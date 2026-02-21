Set-ExecutionPolicy Unrestricted
Import-Module ActiveDirectory

# CSV file path
$csvPath = "C:\bulkuser.csv"
$userList = Import-Csv -Path $csvPath

# Default password for new users
$password = ConvertTo-SecureString "Pineapple123$" -AsPlainText -Force

# Ensure main Employee OU exists
$employeeOU = "OU=Employee,DC=abc,DC=com"
if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$employeeOU'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Employee" -Path "DC=abc,DC=com"
    Write-Host "Created main Employee OU" -ForegroundColor Cyan
}

# List of Departments
$departments = @("Sales","IT","Finance","Marketing","Accounting")

# Create Department OUs with sub-OUs for Users and Groups and department group
foreach ($dept in $departments) {
    $deptOU = "OU=$dept,$employeeOU"
    
    # Create department OU if not exist
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$deptOU'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $dept -Path $employeeOU
        Write-Host "Created OU for $dept" -ForegroundColor Cyan
    }

    # Create sub-OU for Users
    $usersOU = "OU=Users,$deptOU"
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$usersOU'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name "Users" -Path $deptOU
        Write-Host "Created Users OU in $dept" -ForegroundColor Cyan
    }

    # Create sub-OU for Groups
    $groupsOU = "OU=Groups,$deptOU"
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$groupsOU'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name "Groups" -Path $deptOU
        Write-Host "Created Groups OU in $dept" -ForegroundColor Cyan
    }

    # Create department group inside Groups OU
    $deptGroupName = "$dept Group"
    if (-not (Get-ADGroup -Filter "Name -eq '$deptGroupName'" -SearchBase $groupsOU -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $deptGroupName -GroupScope Global -GroupCategory Security -Path $groupsOU
        Write-Host "Created group $deptGroupName in $dept Groups OU" -ForegroundColor Cyan
    }
}

# Loop through CSV users
foreach($user in $userList) {
    $GivenName = $user.FirstName
    $LastName = $user.LastName
    $FullName = "$GivenName $LastName"
    $JobTitle = $user.Role
    $department = $user.OU

    # Remove spaces in SamAccountName
    $sam = "$GivenName.$($LastName -replace ' ','')"
    $upn = "$sam@abc.com"

    # Path to Users OU for this department
    $usersOU = "OU=Users,OU=$department,$employeeOU"

    # Create user if not exists
    if (-not (Get-ADUser -Filter {SamAccountName -eq $sam})) {
        New-ADUser -Name $FullName `
                   -GivenName $GivenName `
                   -Surname $LastName `
                   -UserPrincipalName $upn `
                   -SamAccountName $sam `
                   -AccountPassword $password `
                   -Path $usersOU `
                   -Title $JobTitle `
                   -Enabled $true `
                   -ChangePasswordAtLogon $true

        Write-Host "Created user $FullName in $department Users OU" -ForegroundColor Green
    } else {
        Write-Warning "User $sam already exists"
    }

    # Path to Groups OU for this department
    $groupsOU = "OU=Groups,OU=$department,$employeeOU"
    $deptGroupName = "$department Group"

    # Add user to department group
    $group = Get-ADGroup -Filter {Name -eq $deptGroupName} -SearchBase $groupsOU
    if ($group) {
        try {
            Add-ADGroupMember -Identity $group.DistinguishedName -Members $sam
            Write-Host "Added $FullName to $deptGroupName" -ForegroundColor Green
        } catch {
            Write-Warning ("Failed to add {0} to {1}: {2}" -f $FullName, $deptGroupName, $_)
        }
    } else {
        Write-Warning "Group $deptGroupName not found in $department"
    }
}



# ----------------------------
# DB creation (Exchange)
# ----------------------------
for ($i=1; $i -le 50; $i++) {
    $dbName = "DB$i"
    $edbFilePath = "F:\Program Files\Microsoft\Exchange Server\V15\Mailbox\$dbName\$dbName.edb"
    $logFolderPath = "F:\Program Files\Microsoft\Exchange Server\V15\Mailbox\$dbName\Logs"
    New-MailboxDatabase -Name $dbName -Server Mail -EdbFilePath $edbFilePath -LogFolderPath $logFolderPath
}

# ----------------------------
# Enable mailbox for all users under Employee OU
# ----------------------------
$users = Get-ADUser -Filter * -SearchBase "OU=Employee,DC=abc,DC=com"
foreach ($user in $users) {
    Enable-Mailbox -Identity $user.SamAccountName
}

