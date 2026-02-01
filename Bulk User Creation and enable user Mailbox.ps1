Set-ExecutionPolicy Unrestricted
Import-Module ActiveDirectory 

# Declare some variables needed
$csvPath = "C:\bulkuser.csv"
$userList = Import-Csv -Path $csvPath
$password = ConvertTo-SecureString "Pineapple123$" -AsPlainText -Force

# Loop through the Userdata csv file
foreach($user in $userList) {
    $GivenName = $user.FirstName
    $LastName = $user.LastName
    $FullName = $user.FullName
    $Gender = $user.Gender
    $JobTitle = $user.Role
    $Name = "$GivenName $LastName"
    $sam = "$GivenName.$LastName"
    $upn = "$sam@Subedi.com"
    $department = $user.OU
    $OU = "OU=$department,OU=Employee,DC=Subedi,DC=com"

    # Check if the department for user exists in AD
    $ouExists = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$OU'" -ErrorAction SilentlyContinue

    # Create new department OU if it does not exist
    if ($null -eq $ouExists) {
        New-ADOrganizationalUnit -Name $department -Path "OU=Employee,DC=Subedi,DC=com"
    }

    # Check if the security group for user exists in AD
    $groupExists = Get-ADGroup -Filter "Name -eq '$department'" -SearchBase "OU=Groups,DC=Subedi,DC=com" -ErrorAction SilentlyContinue 

    # Create new security group if it does not exist
    if($null -eq $groupExists) {
        New-ADGroup -Name $department -GroupScope Global -GroupCategory Security -Path "OU=Groups,DC=Subedi,DC=com" 
    }

    # Check if the user with given sam exists
    if(Get-ADUser -F {SamAccountName -eq $sam}) {
        Write-Warning "A user with username $sam already exists"
    } else {
        # Create a new user with forced password change at next logon
        New-ADUser -Name $Name `
                   -GivenName $GivenName `
                   -Surname $LastName `
                   -UserPrincipalName $upn `
                   -SamAccountName $sam `
                   -AccountPassword $password  `
                   -Path $OU `
                   -Description $Gender `
                   -Title $JobTitle  `
                   -Enabled $true `
                   -ChangePasswordAtLogon $true

        Write-Host "The user account for $Name is successfully created." -ForegroundColor Green  

        # Add newly created user to the security group for their department
        try {  
            Add-ADGroupMember -Identity $department -Members $sam
            Write-Output "Added $Name to $department Group"     
        } catch {
            Write-Output "Failed to add $Name to $department Group"
        }
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
$users = Get-ADUser -Filter * -SearchBase "OU=Employee,DC=Subedi,DC=com"
foreach ($user in $users) {
    Enable-Mailbox -Identity $user.SamAccountName
}
