<div align="center">

<img src="https://img.shields.io/badge/PowerShell-5.1%2B-blue?style=for-the-badge&logo=powershell&logoColor=white" />
<img src="https://img.shields.io/badge/Active%20Directory-Enterprise-0078D4?style=for-the-badge&logo=microsoft&logoColor=white" />
<img src="https://img.shields.io/badge/Microsoft%20365-Cloud%20Ready-D83B01?style=for-the-badge&logo=microsoftoffice&logoColor=white" />
<img src="https://img.shields.io/badge/Azure%20AD-Entra%20ID-0089D6?style=for-the-badge&logo=microsoftazure&logoColor=white" />
<img src="https://img.shields.io/badge/Scripts-34-brightgreen?style=for-the-badge" />
<img src="https://img.shields.io/badge/Updated-March%202026-orange?style=for-the-badge" />

<br /><br />

```
██████╗ ███████╗    ██╗      █████╗ ██████╗ ███████╗
██╔══██╗██╔════╝    ██║     ██╔══██╗██╔══██╗██╔════╝
██████╔╝███████╗    ██║     ███████║██████╔╝███████╗
██╔═══╝ ╚════██║    ██║     ██╔══██║██╔══██╗╚════██║
██║     ███████║    ███████╗██║  ██║██████╔╝███████║
╚═╝     ╚══════╝    ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝
```

# 🚀 PowerShell Automation Toolkit
### Active Directory · Microsoft 365 · Azure AD / Entra ID · Exchange Online · Windows Server

**34 production-grade PowerShell scripts** for modern enterprise IT administration —  
fully modernized for **2026**, replacing every deprecated API with current Microsoft-supported equivalents.

[📋 Scripts Overview](#-scripts-overview) · [⚡ Quick Start](#-quick-start) · [🏗️ Architecture](#%EF%B8%8F-architecture--design-decisions) · [📖 Full Reference](#-full-script-reference) · [🛡️ Security](#%EF%B8%8F-security-philosophy) · [🤝 Contributing](#-contributing)

</div>

---

## 🎯 Why This Project Exists

Enterprise IT administration is full of scripts written 5–10 years ago that silently break in 2025–2026 because Microsoft has **retired entire API layers**:

| ❌ Deprecated (Broken in 2026) | ✅ This Toolkit Uses |
|---|---|
| `MSOnline` module (retired March 2024) | `Microsoft.Graph` SDK (`Get-Mg*`) |
| `Get-WmiObject` / `Invoke-WmiMethod` | `Get-CimInstance` / `New-CimSession` |
| Exchange Online Basic Auth | `ExchangeOnlineManagement` v3+ (REST) |
| `WMIC.exe` | PowerShell CIM + `Invoke-Command` |
| Plaintext passwords in scripts | `SecureString` + DPAPI + AES key files |
| `netdom.exe` trust repair | `Reset-ComputerMachinePassword` |

This toolkit was **built from scratch for 2026** — not patched, not bodged. Every script is idiomatic, safe, and production-ready the moment you clone it.

---

## 📊 Project at a Glance

```
📁 PS-ActiveDirectory-AzureAD-O365/
├── 🏢 Active Directory Management     (Scripts 03–06, 09–10, 14, 17–20, 25–26, 29–32, 34)
├── ☁️  Microsoft 365 / Graph API       (Scripts 01, 33)
├── 📧 Exchange Online                  (Scripts 02, 33)
├── 🔐 Security & Encryption           (Scripts 13, 22, 23)
├── 🖥️  Windows / Local Management     (Scripts 11, 12, 15, 21, 24, 27)
├── 🌐 DNS & Networking                 (Scripts 07, 28)
└── 📁 File System & Permissions       (Scripts 08, 16)
```

| Category | Scripts | Key Technologies |
|---|---|---|
| 🏢 Active Directory | 18 scripts | `ActiveDirectory` module, LDAP, RSAT |
| ☁️ Microsoft 365 | 2 scripts | `Microsoft.Graph` SDK v2+ |
| 📧 Exchange Online | 2 scripts | `ExchangeOnlineManagement` v3+ |
| 🔐 Security | 3 scripts | DPAPI, AES-256, `SecureString` |
| 🖥️ Windows Server | 5 scripts | CIM, PSRemoting, WinRM, Robocopy |
| 🌐 DNS & Network | 2 scripts | `DnsServer` module, AD cross-reference |
| 📁 File & Permissions | 2 scripts | NTFS ACL, SMB shares, `NTFSSecurity` |

---

## ⚡ Quick Start

### Prerequisites

```powershell
# 1. Install RSAT (Active Directory tools) — Windows 10/11 / Server 2016+
Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0

# 2. Microsoft Graph SDK (for M365 scripts 01, 33)
Install-Module Microsoft.Graph -Scope CurrentUser -Force

# 3. Exchange Online Management v3+ (for scripts 02, 33)
Install-Module ExchangeOnlineManagement -Scope CurrentUser -Force

# 4. Optional — enhanced NTFS permissions (script 16)
Install-Module NTFSSecurity -Scope CurrentUser

# 5. Optional — Excel export (script 20)
Install-Module ImportExcel -Scope CurrentUser
```

### Run Your First Script

```powershell
# Clone the repo
git clone https://github.com/yourusername/PS-ActiveDirectory-AzureAD-O365.git
cd PS-ActiveDirectory-AzureAD-O365

# Example: Find all users inactive for 90+ days (safe read-only mode)
.\05-Find-Inactive-AD-Users-and-Computers.ps1 -DaysInactive 90

# Example: Preview what would be disabled — WhatIf mode on every destructive script
.\05-Find-Inactive-AD-Users-and-Computers.ps1 -DaysInactive 90 -DisableInactive -WhatIf

# Example: Assign M365 licenses from CSV
.\01-Assign-M365-Licenses-from-CSV.ps1 -CsvPath .\users.csv
```

> 💡 **Every destructive operation** in this toolkit supports `-WhatIf`. Always preview before you act.

---

## 🏗️ Architecture & Design Decisions

### 🔑 Core Engineering Principles

Every script in this toolkit was written following the same set of non-negotiable rules:

```
┌─────────────────────────────────────────────────────────┐
│  SAFETY FIRST    →  -WhatIf on ALL destructive ops      │
│  NO PLAINTEXT    →  SecureString / DPAPI / AES always   │
│  FAIL GRACEFULLY →  try/catch with per-record counts    │
│  EXPORT ALWAYS   →  CSV with UTF-8 encoding every time  │
│  MODERN APIs     →  CIM, Graph SDK, EXO v3 throughout   │
│  SELF-DOCUMENTING→  .SYNOPSIS, .DESCRIPTION, examples   │
└─────────────────────────────────────────────────────────┘
```

### 🔄 The API Migration Story

When Microsoft retired the `MSOnline` module in **March 2024**, thousands of enterprise IT teams were left with broken pipelines. This project maps every old pattern to the correct 2026 replacement:

```powershell
# ❌ OLD — Broken since March 2024
Connect-MsolService
Get-MsolUser -All | Where-Object { $_.IsLicensed -eq $true }
Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $sku

# ✅ NEW — Microsoft Graph SDK (this toolkit)
Connect-MgGraph -Scopes 'User.ReadWrite.All','Organization.Read.All'
Get-MgUser -All -Property assignedLicenses | Where-Object { $_.AssignedLicenses.Count -gt 0 }
Set-MgUserLicense -UserId $upn -BodyParameter @{
    AddLicenses    = @(@{ SkuId = $skuId })
    RemoveLicenses = @()
}
```

```powershell
# ❌ OLD — WMI / WMIC (deprecated, removed from Windows Server 2025)
Get-WmiObject Win32_Service -ComputerName $srv
wmic /node:$srv service get Name,State

# ✅ NEW — CIM (this toolkit)
$session = New-CimSession -ComputerName $srv
Get-CimInstance -CimSession $session -ClassName Win32_Service
Remove-CimSession $session
```

### 📐 Password Security Architecture

```
Script Passwords — Decision Tree
─────────────────────────────────
Are you running on ONE specific machine as ONE specific user?
  └─ YES → Use DPAPI (Script 13: -Action Encrypt)
           ConvertFrom-SecureString (no key) = user+machine bound
           ✓ Most secure  ✗ not portable

Are you deploying across MULTIPLE machines / service accounts?
  └─ YES → Use AES-256 Key File (Script 13: -Action GenerateKey + EncryptAES)
           ConvertFrom-SecureString -Key $aesKeyBytes
           ✓ Portable  ✗ protect the key file carefully

NEVER → -AsPlainText -Force in production scripts
NEVER → Passwords in script files or version control
```

---

## 📖 Full Script Reference

### 🏢 Active Directory — User Management

---

#### `01` · Assign-M365-Licenses-from-CSV
> **Bulk-assign Microsoft 365 licenses to users via the Microsoft Graph API**

Replaces the retired `Set-MsolUserLicense`. Reads a CSV of users and SKU names, validates each SKU exists in your tenant, checks for existing assignments to avoid double-billing, and assigns licenses atomically via `Set-MgUserLicense`.

```powershell
# CSV format:  UserPrincipalName, LicenseSku
.\01-Assign-M365-Licenses-from-CSV.ps1 -CsvPath .\users.csv
.\01-Assign-M365-Licenses-from-CSV.ps1 -CsvPath .\users.csv -TenantId "your-tenant-guid"
```

| Feature | Detail |
|---|---|
| Module | `Microsoft.Graph.Users`, `Microsoft.Graph.Identity.DirectoryManagement` |
| Permissions | `User.ReadWrite.All`, `Organization.Read.All` |
| Duplicate check | ✅ Skips already-licensed users |
| Error handling | Per-user try/catch with full error output |

---

#### `02` · Manage-ExchangeOnline-Mailbox-Permissions
> **Add or remove FullAccess, SendAs, and SendOnBehalf permissions on shared mailboxes**

Handles all three Exchange permission types from a single CSV. Uses `ExchangeOnlineManagement` v3+ with modern auth — no Basic Auth, no legacy PSSession.

```powershell
# CSV format:  UserPrincipalName, SharedMailbox, Permission
.\02-Manage-ExchangeOnline-Mailbox-Permissions.ps1 -CsvPath .\perms.csv
.\02-Manage-ExchangeOnline-Mailbox-Permissions.ps1 -CsvPath .\perms.csv -Remove
```

| Permission Type | Cmdlet Used |
|---|---|
| `FullAccess` | `Add-MailboxPermission` / `Remove-MailboxPermission` |
| `SendAs` | `Add-RecipientPermission` / `Remove-RecipientPermission` |
| `SendOnBehalf` | `Set-Mailbox -GrantSendOnBehalfTo` |

---

#### `03` · Create-AD-Users-from-CSV
> **Bulk-create Active Directory user accounts from a structured CSV file**

Comprehensive user provisioning with 15+ attributes, automatic UPN generation, SecureString password handling, manager resolution by SamAccountName, and full `-WhatIf` preview support.

```powershell
# CSV: FirstName, LastName, Username, Password, OU, Department, Title, Email, Phone, Manager...
.\03-Create-AD-Users-from-CSV.ps1 -CsvPath .\newusers.csv
.\03-Create-AD-Users-from-CSV.ps1 -CsvPath .\newusers.csv -WhatIf
.\03-Create-AD-Users-from-CSV.ps1 -CsvPath .\newusers.csv -DefaultOU "OU=Staff,DC=contoso,DC=com"
```

**Attributes populated:** DisplayName, GivenName, Surname, UPN, EmailAddress, Title, Department, Company, OfficePhone, Description, Manager, OU path

---

#### `04` · Create-AD-Groups-from-CSV
> **Bulk-create AD security and distribution groups with members in one pass**

Creates groups with configurable scope (DomainLocal/Global/Universal) and category (Security/Distribution), then populates membership from semicolon-delimited member lists in the same CSV row.

```powershell
# CSV: GroupName, GroupScope, GroupCategory, OU, Description, Members (semicolon-separated)
.\04-Create-AD-Groups-from-CSV.ps1 -CsvPath .\groups.csv -WhatIf
```

---

#### `05` · Find-Inactive-AD-Users-and-Computers
> **Identify stale user and computer accounts exceeding an inactivity threshold**

Uses the replicated `LastLogonDate` attribute with `whenCreated` as a secondary guard to avoid false positives on brand-new accounts. Supports optional bulk disable with `-WhatIf` safety.

```powershell
.\05-Find-Inactive-AD-Users-and-Computers.ps1 -DaysInactive 90
.\05-Find-Inactive-AD-Users-and-Computers.ps1 -DaysInactive 90 -IncludeUsers -DisableInactive -WhatIf
.\05-Find-Inactive-AD-Users-and-Computers.ps1 -DaysInactive 60 -SearchBase "OU=London,DC=contoso,DC=com"
```

---

#### `06` · List-and-Move-AD-Computers
> **List all domain computers and optionally move them to a target OU — single or bulk**

Three operational modes: read-only listing with CSV export, single computer move, or bulk move from CSV. Built-in validation ensures the target computer exists before attempting a move.

```powershell
.\06-List-and-Move-AD-Computers.ps1 -GetOnly                          # List + export CSV
.\06-List-and-Move-AD-Computers.ps1 -CsvPath .\computers.csv -WhatIf  # Bulk move preview
.\06-List-and-Move-AD-Computers.ps1 -ComputerName PC01 -TargetOU "OU=Retired,DC=contoso,DC=com"
```

---

#### `07` · Find-Duplicate-IPs-in-DNS
> **Detect duplicate A records in DNS and cross-reference with Active Directory**

Queries a DNS zone for all A records, groups by IP address, identifies duplicates, and cross-references against AD computer accounts to show which machine owns each IP. Essential for troubleshooting IP conflicts in large environments.

```powershell
.\07-Find-Duplicate-IPs-in-DNS.ps1 -DnsServer DC01 -ZoneName contoso.com
.\07-Find-Duplicate-IPs-in-DNS.ps1 -DnsServer DC01 -ZoneName contoso.com -ShowAll
```

---

#### `08` · Create-Folders-from-CSV
> **Bulk-create folder structures with NTFS permissions from a CSV file**

Creates folders recursively using `New-Item -Force`, then optionally applies NTFS ACL rules using `System.Security.AccessControl.FileSystemAccessRule` with `ContainerInherit,ObjectInherit` inheritance. Works for local paths and UNC shares.

```powershell
# CSV: Path, Group, Permission (Read|Modify|FullControl)
.\08-Create-Folders-from-CSV.ps1 -CsvPath .\folders.csv
.\08-Create-Folders-from-CSV.ps1 -CsvPath .\folders.csv -SetPermissions -WhatIf
```

---

#### `09` · Get-AD-User-LastLogon-All-DCs
> **Query EVERY Domain Controller to get the true last logon time per user**

`LastLogon` is not replicated — each DC only knows about logins that happened against it. This script queries all DCs and returns the maximum value per user — the only technically accurate way to determine true last activity.

```powershell
.\09-Get-AD-User-LastLogon-All-DCs.ps1
.\09-Get-AD-User-LastLogon-All-DCs.ps1 -DaysInactive 60 -EnabledOnly
```

```
Why this matters:
  DC1 says: lastLogon = 45 days ago
  DC2 says: lastLogon = 2 days ago   ← user logged in via DC2
  DC3 says: lastLogon = 45 days ago

  LastLogonDate (replicated): 45 days ago  ← WRONG
  This script result:          2 days ago  ← CORRECT
```

---

#### `10` · Bulk-Update-AD-User-Attributes
> **Update 15+ AD user attributes from a single CSV — without touching unlisted fields**

Smart differential update: only sets attributes that have non-empty values in the CSV, leaving other attributes untouched. Supports Manager resolution, Enable/Disable via Enabled column, and full WhatIf mode.

```powershell
# CSV must include SamAccountName + any columns you want to update
.\10-Bulk-Update-AD-User-Attributes.ps1 -CsvPath .\updates.csv -WhatIf
```

**Supported columns:** DisplayName, FirstName, LastName, Title, Department, Company, Office, Phone, Mobile, Email, Manager, Description, StreetAddress, City, State, PostalCode, Country, Enabled

---

#### `11` · Manage-Local-Windows-Users
> **Full lifecycle management of local Windows user accounts via PowerShell**

Uses the built-in `Microsoft.PowerShell.LocalAccounts` module — no `net.exe`, no ADSI, no WMI. Supports Create, Enable, Disable, Delete, SetPassword, List, and CheckPrivileges actions.

```powershell
.\11-Manage-Local-Windows-Users.ps1 -Action List
.\11-Manage-Local-Windows-Users.ps1 -Action Create -Username ITAdmin -GroupName Administrators
.\11-Manage-Local-Windows-Users.ps1 -Action Disable -Username jdoe -WhatIf
```

---

#### `12` · Migrate-User-Profile-with-Robocopy
> **Migrate a user's profile between computers using Robocopy with full logging**

Wraps Robocopy with intelligent defaults: `/E /COPYALL /R:3 /W:5 /MT:8` for reliable, multi-threaded copies. Migrates essential folders by default (Desktop, Documents, Downloads, Pictures, Videos, Music, Favorites, Outlook signatures, Firefox profiles), or everything with `-IncludeAll`.

```powershell
.\12-Migrate-User-Profile-with-Robocopy.ps1 `
    -SourceUser "\\OldPC\c$\Users\jdoe" `
    -DestUser   "\\NewPC\c$\Users\jdoe"
.\12-Migrate-User-Profile-with-Robocopy.ps1 -SourceUser C:\Users\jdoe -DestUser D:\Users\jdoe -IncludeAll -WhatIf
```

---

#### `13` · Encrypt-Decrypt-Script-Passwords
> **Eliminate plaintext passwords from automation scripts — two encryption strategies**

Implements both DPAPI (user+machine bound, most secure) and AES-256 key file encryption (cross-machine portable, suitable for service accounts and CI/CD pipelines).

```powershell
# Strategy 1: DPAPI (single machine)
.\13-Encrypt-Decrypt-Script-Passwords.ps1 -Action Encrypt   -OutputFile admin.txt
.\13-Encrypt-Decrypt-Script-Passwords.ps1 -Action Decrypt   -InputFile  admin.txt

# Strategy 2: AES-256 (cross-machine)
.\13-Encrypt-Decrypt-Script-Passwords.ps1 -Action GenerateKey -KeyFile prod.key
.\13-Encrypt-Decrypt-Script-Passwords.ps1 -Action EncryptAES  -OutputFile pwd.txt -KeyFile prod.key
.\13-Encrypt-Decrypt-Script-Passwords.ps1 -Action DecryptAES  -InputFile  pwd.txt -KeyFile prod.key
```

---

#### `14` · Show-Nested-AD-Group-Memberships
> **Recursively resolve all inherited group memberships for any user or group**

Two resolution modes: recursive `Get-ADGroupMember` walk (depth-controlled), or the high-performance LDAP matching rule `1.2.840.113556.1.4.1941` (`LDAP_MATCHING_RULE_IN_CHAIN`) that resolves the entire nested tree in a single LDAP query.

```powershell
.\14-Show-Nested-AD-Group-Memberships.ps1 -Identity jdoe
.\14-Show-Nested-AD-Group-Memberships.ps1 -Identity HelpDesk -ObjectType Group
.\14-Show-Nested-AD-Group-Memberships.ps1 -Identity jdoe -UseChainQuery -OutputPath result.csv
```

---

#### `15` · Get-Services-on-Remote-Computers
> **Inventory all services and their logon accounts across multiple remote servers**

Supports two transport methods: PSRemoting (`Invoke-Command`) for modern environments, and CIM sessions (`New-CimSession`) for legacy networks. Auto-pings before connecting to skip unreachable hosts.

```powershell
.\15-Get-Services-on-Remote-Computers.ps1 -ComputerNames SRV01,SRV02,SRV03
.\15-Get-Services-on-Remote-Computers.ps1 -CsvPath servers.csv -FilterState Running -UseCIM
.\15-Get-Services-on-Remote-Computers.ps1 -CsvPath servers.csv -FilterName "*SQL*"
```

---

#### `16` · Assign-NTFS-Permissions-on-Shared-Resources
> **Set or remove granular NTFS permissions on folders — with optional SMB share creation**

Uses the `NTFSSecurity` module (preferred — more reliable inheritance control) with automatic fallback to built-in `Set-Acl`. Can create SMB shares in the same pass with `New-SmbShare`.

```powershell
# CSV: Path, ADObject, Permission (Read|Modify|FullControl), Action (Add|Remove), ShareName
.\16-Assign-NTFS-Permissions-on-Shared-Resources.ps1 -CsvPath permissions.csv
.\16-Assign-NTFS-Permissions-on-Shared-Resources.ps1 -CsvPath permissions.csv -CreateShares -WhatIf
```

---

#### `17` · Join-Computer-to-AD-Domain
> **Rename a machine and join it to an AD domain — with full OU targeting**

Handles the complete workstation provisioning workflow: validate name length (NetBIOS 15-char limit), rename, join to domain with credential prompt, target a specific OU, and optionally restart.

```powershell
.\17-Join-Computer-to-AD-Domain.ps1 -DomainName contoso.com -DomainCredential (Get-Credential)
.\17-Join-Computer-to-AD-Domain.ps1 -DomainName contoso.com -NewComputerName WS-JOHN01 `
    -OUPath "OU=Workstations,DC=contoso,DC=com" -DomainCredential (Get-Credential) -Restart
```

---

#### `18` · Copy-AD-Group-Members-Source-to-Dest
> **Copy all members from one AD group to another — with deduplication**

Compares source and destination member DNs before adding — no duplicate memberships. Supports `-Recursive` to flatten nested source groups. Ideal for group restructuring and role migrations.

```powershell
.\18-Copy-AD-Group-Members-Source-to-Dest.ps1 -SourceGroup OldTeam -DestinationGroup NewTeam -WhatIf
.\18-Copy-AD-Group-Members-Source-to-Dest.ps1 -SourceGroup "IT-All" -DestinationGroup "IT-2026" -Recursive
```

---

#### `19` · Resolve-SID-to-AD-Object
> **Translate any SID string into its AD object — users, groups, computers, or built-ins**

Three-tier resolution: built-in SID dictionary (Everyone, SYSTEM, Administrators etc.), AD `objectSID` attribute lookup, then .NET `SecurityIdentifier.Translate()` fallback. Handles orphaned SIDs gracefully. Bulk CSV support.

```powershell
.\19-Resolve-SID-to-AD-Object.ps1 -SID "S-1-5-21-123456789-987654321-111222333-1001"
.\19-Resolve-SID-to-AD-Object.ps1 -CsvPath sids.csv -OutputPath resolved.csv
```

---

#### `20` · Export-All-AD-Objects-MultiDomain
> **Export every user, group, and computer from every domain in the forest — at once**

Auto-discovers all domains in the AD forest via `Get-ADForest`, queries each in turn, and exports three CSVs (Users / Groups / Computers). Optional XLSX output with formatted worksheets via `ImportExcel`.

```powershell
.\20-Export-All-AD-Objects-MultiDomain.ps1 -OutputFolder .\ADExport
.\20-Export-All-AD-Objects-MultiDomain.ps1 -ExportXLSX -IncludeDisabled
.\20-Export-All-AD-Objects-MultiDomain.ps1 -Domains "corp.local","eu.corp.local"
```

---

#### `21` · Move-Files-by-Extension-Recursively
> **Recursively find files by extension and consolidate them into a target folder**

Handles naming conflicts with three strategies: Rename (auto-suffix), Skip, or Overwrite. Optional empty-folder cleanup after the move. Supports `-WhatIf` to preview without moving anything.

```powershell
.\21-Move-Files-by-Extension-Recursively.ps1 -SourcePath C:\Scans -DestinationPath C:\AllPDFs -Extensions .pdf
.\21-Move-Files-by-Extension-Recursively.ps1 -SourcePath D:\Work  -DestinationPath D:\Archive `
    -Extensions .pdf,.docx -ConflictAction Rename -WhatIf
```

---

#### `22` · Check-and-Control-Windows-Defender
> **Audit Defender status, update signatures, manage exclusions from the command line**

Full read/write access to Windows Defender settings via the `Defender` module. Status reporting includes tamper protection state, signature age, and active threats. Disable requires explicit `-Force` to prevent accidents.

```powershell
.\22-Check-and-Control-Windows-Defender.ps1 -Action Status
.\22-Check-and-Control-Windows-Defender.ps1 -Action UpdateDefinitions
.\22-Check-and-Control-Windows-Defender.ps1 -Action AddExclusion -ExclusionPath C:\TestTools
.\22-Check-and-Control-Windows-Defender.ps1 -Action Disable -Force   # ⚠️ Test labs only
```

---

#### `23` · Setup-Custom-Local-Admin-Account
> **Security hardening: disable/rename built-in Administrator, create named local admin**

Finds the built-in Administrator by its well-known SID suffix (`-500`, not by name — immune to renames), disables or renames it, then creates a new named local admin account. Industry best practice for CIS compliance.

```powershell
.\23-Setup-Custom-Local-Admin-Account.ps1 -NewAdminUsername ITAdmin -DisableBuiltinAdmin
.\23-Setup-Custom-Local-Admin-Account.ps1 -NewAdminUsername ITAdmin `
    -DisableBuiltinAdmin -RenameBuiltinAdmin -WhatIf
```

---

#### `24` · Run-Commands-Remotely-on-Domain-Computers
> **Execute any PowerShell command on remote machines — three transport methods**

PSRemoting (fastest, recommended), CIM `Win32_Process::Create` (DCOM, no WinRM required), and Scheduled Task (runs fully in background, no interactive session needed). Zero legacy WMIC.

```powershell
.\24-Run-Commands-Remotely-on-Domain-Computers.ps1 `
    -ComputerNames SRV01,SRV02 -ScriptBlock 'Get-Service | Where-Object Status -eq Running'
.\24-Run-Commands-Remotely-on-Domain-Computers.ps1 `
    -ComputerNames SRV01 -ScriptBlock 'gpupdate /force' -Method ScheduledTask
```

---

#### `25` · Look-Up-AD-User-Details-by-Email
> **Get a full AD user profile by email address — including Exchange alias support**

Searches both the `mail` attribute and `ProxyAddresses` (for Exchange aliases and secondary SMTP addresses). Returns 20+ attributes including manager name resolution and group membership count.

```powershell
.\25-Look-Up-AD-User-Details-by-Email.ps1 -Email john.doe@contoso.com
.\25-Look-Up-AD-User-Details-by-Email.ps1 -CsvPath emails.csv -OutputPath results.csv
```

---

#### `26` · List-AD-Users-Created-in-Last-N-Days
> **Audit recently created accounts — sorted newest first, with department breakdown**

Filters on `whenCreated`, includes manager resolution, supports OU scope narrowing, name filtering, and enabled-only toggle. Outputs a summary breakdown by department at the end.

```powershell
.\26-List-AD-Users-Created-in-Last-N-Days.ps1 -Days 30
.\26-List-AD-Users-Created-in-Last-N-Days.ps1 -Days 7 -EnabledOnly
.\26-List-AD-Users-Created-in-Last-N-Days.ps1 -Days 90 -SearchBase "OU=Sales,DC=contoso,DC=com"
```

---

#### `27` · Get-All-Microsoft-Updates-Installed
> **List every Microsoft product update — not just Windows patches**

`Get-HotFix` only returns Windows patches. This script uses the `Microsoft.Update.Session` COM interface to query the full Windows Update history — including **Office, SQL Server, .NET Framework, Visual C++ runtimes**, and more. Supports remote computers via PSRemoting.

```powershell
.\27-Get-All-Microsoft-Updates-Installed.ps1
.\27-Get-All-Microsoft-Updates-Installed.ps1 -ComputerNames SRV01,SRV02
.\27-Get-All-Microsoft-Updates-Installed.ps1 -FilterProduct "Office" -Since (Get-Date).AddDays(-90)
```

---

#### `28` · Get-IP-Address-and-Hostname-from-AD-DNS
> **Build an IP ↔ hostname map from AD and DNS — with cross-reference mismatch detection**

Queries AD computer objects, DNS A records, or both simultaneously. The `-CrossReference` flag compares AD IPv4Address attributes against DNS A records and flags any IP mismatches — critical for detecting stale DNS entries and rogue machines.

```powershell
.\28-Get-IP-Address-and-Hostname-from-AD-DNS.ps1 -Source AD
.\28-Get-IP-Address-and-Hostname-from-AD-DNS.ps1 -Source Both -DnsServer DC01 -CrossReference
```

---

#### `29` · Grant-Temporary-AD-Group-Membership
> **Add a user to a group for a fixed duration — auto-removed by Scheduled Task**

Creates a Windows Scheduled Task that runs `Remove-ADGroupMember` at the expiry time. The task deletes itself after running. Prints cancel commands so the operator can undo manually if needed.

```powershell
.\29-Grant-Temporary-AD-Group-Membership.ps1 -UserName jdoe -GroupName ServerAdmins `
    -DurationMinutes 60 -Reason "Emergency production patch"
.\29-Grant-Temporary-AD-Group-Membership.ps1 -UserName jdoe -GroupName VPN_Access `
    -DurationMinutes 480 -WhatIf
```

> 🔐 For **cloud/hybrid environments**, use **Microsoft Entra Privileged Identity Management (PIM)** — this script is for on-prem AD only.

---

#### `30` · List-DCs-and-FSMO-Roles
> **Audit all Domain Controllers and identify every FSMO role holder**

Reports all 5 FSMO roles (Schema Master, Domain Naming Master, PDC Emulator, RID Master, Infrastructure Master), live ping status for each DC, Global Catalog and RODC flags, and optional replication health check.

```powershell
.\30-List-DCs-and-FSMO-Roles.ps1
.\30-List-DCs-and-FSMO-Roles.ps1 -CheckReplication -OutputPath dcs.csv
```

---

#### `31` · Fix-Domain-Trust-Relationship
> **Diagnose and repair "The trust relationship between this workstation and the primary domain failed"**

Runs a structured diagnostic (secure channel test → AD account verify → Netlogon service → DC ping), then attempts repair via `Reset-ComputerMachinePassword`, falling back to `Test-ComputerSecureChannel -Repair`. Replaces the legacy `netdom.exe` workflow entirely.

```powershell
.\31-Fix-Domain-Trust-Relationship.ps1 -DomainCredential (Get-Credential DOMAIN\Admin) -DiagnoseOnly
.\31-Fix-Domain-Trust-Relationship.ps1 -DomainCredential (Get-Credential DOMAIN\Admin) -ForceRepair
```

---

#### `32` · Migrate-AD-Users-to-New-Domain
> **Recreate AD users in a target domain preserving all attributes and group memberships**

Reads users from a source domain and creates equivalent accounts in the target domain with all standard attributes. Supports group membership migration by name-matching. For SID history migration, pair this with Microsoft ADMT.

```powershell
# CSV: SamAccountName, TargetOU, NewPassword
.\32-Migrate-AD-Users-to-New-Domain.ps1 `
    -SourceDomain old.local -TargetDomain new.local `
    -CsvPath users.csv `
    -SourceCredential (Get-Credential) -TargetCredential (Get-Credential) `
    -MigrateGroupMemberships -WhatIf
```

---

#### `33` · M365-Tenant-Information-Report
> **Complete Microsoft 365 tenant health report — 7 sections, all via Microsoft Graph**

The definitive tenant audit script. Fully migrated from `MSOnline` (retired March 2024) to **Microsoft Graph SDK**. Covers organization info, license consumption, all users, all groups, verified domains, admin role assignments, and optional Exchange Online mailbox inventory.

```powershell
.\33-M365-Tenant-Information-Report.ps1 -OutputFolder .\M365Report
.\33-M365-Tenant-Information-Report.ps1 -OutputFolder .\M365Report -ConnectExchange -AdminUPN admin@contoso.com
```

**Report sections generated:**

| File | Contents |
|---|---|
| `OrgInfo.csv` | Tenant name, ID, tech contact, country |
| `Licenses.csv` | SKU names, assigned vs available vs total |
| `Users.csv` | All users, enabled status, license count, department |
| `Groups.csv` | All groups with type classification (M365 / Security / Distribution / Dynamic) |
| `Domains.csv` | All verified domains, default flag, auth type |
| `AdminRoles.csv` | Every admin role → member UPN mapping |
| `Mailboxes.csv` | All mailboxes, type, archive status, litigation hold |

---

#### `34` · Find-Inactive-AD-Computers
> **Dual-indicator inactive computer detection — both LastLogonDate AND PasswordLastSet**

Using only `LastLogonDate` produces false positives (computers offline during DC replication). This script requires **both** `LastLogonDate` **and** `PasswordLastSet` to exceed the threshold — significantly more accurate. Supports bulk disable, OU move, and OS/OU summary breakdown.

```powershell
.\34-Find-Inactive-AD-Computers.ps1 -DaysInactive 90
.\34-Find-Inactive-AD-Computers.ps1 -DaysInactive 90 -DisableInactive -WhatIf
.\34-Find-Inactive-AD-Computers.ps1 -DaysInactive 90 -MoveInactive -MoveToOU "OU=Stale,DC=contoso,DC=com"
```

---

## 🛡️ Security Philosophy

This toolkit treats security as a first-class engineering concern, not an afterthought.

### WhatIf Support Matrix

| Script | WhatIf | Scope |
|---|---|---|
| 03, 04 | ✅ | New-ADUser / New-ADGroup |
| 05, 34 | ✅ | Disable-ADAccount |
| 06, 32 | ✅ | Move-ADObject / New-ADUser in target |
| 08, 16 | ✅ | New-Item, Set-Acl |
| 10 | ✅ | Set-ADUser |
| 11 | ✅ | New / Remove / Enable / Disable-LocalUser |
| 12 | ✅ | Robocopy `/L` list-only mode |
| 17 | ✅ | Rename-Computer, Add-Computer |
| 18 | ✅ | Add-ADGroupMember |
| 21 | ✅ | Move-Item (file operations) |
| 22 | ✅ | Set-MpPreference |
| 23 | ✅ | Disable / Rename / New LocalUser |
| 29 | ✅ | Add-ADGroupMember + ScheduledTask |
| 31 | ✅ | Diagnose-only mode |

### Principle of Least Privilege
Each script documents the minimum required permissions in its `.NOTES` section. No script requests `Global Administrator` when a scoped Graph API permission suffices.

---

## 📋 CSV Templates

<details>
<summary><strong>📂 Click to expand all CSV templates</strong></summary>

**Script 01 — License Assignment**
```csv
UserPrincipalName,LicenseSku
john.doe@contoso.com,ENTERPRISEPREMIUM
jane.smith@contoso.com,STANDARDPACK
```

**Script 02 — Mailbox Permissions**
```csv
UserPrincipalName,SharedMailbox,Permission
jdoe@contoso.com,finance@contoso.com,FullAccess
jdoe@contoso.com,sales@contoso.com,SendAs
jsmith@contoso.com,support@contoso.com,SendOnBehalf
```

**Script 03 — Create AD Users**
```csv
FirstName,LastName,Username,Password,OU,Department,Title,Email,Phone,Manager,Company,Description
John,Doe,jdoe,Welcome@2026!,"OU=Staff,DC=contoso,DC=com",IT,Sysadmin,jdoe@contoso.com,555-1234,manager1,Contoso,New hire
```

**Script 04 — Create AD Groups**
```csv
GroupName,GroupScope,GroupCategory,OU,Description,Members
IT-Admins,Global,Security,"OU=Groups,DC=contoso,DC=com",IT Admin group,jdoe;jsmith;bwilson
```

**Script 06 — Move Computers**
```csv
ComputerName,TargetOU
PC-JOHN01,"OU=Workstations,OU=London,DC=contoso,DC=com"
SRV-FILE02,"OU=Servers,DC=contoso,DC=com"
```

**Script 10 — Bulk Update Users**
```csv
SamAccountName,Title,Department,Phone,Manager,Enabled
jdoe,Senior Sysadmin,IT,555-9999,csmith,True
```

**Script 16 — NTFS Permissions**
```csv
Path,ADObject,Permission,Action,ShareName
C:\Shares\Finance,CONTOSO\Finance-Team,FullControl,Add,Finance
C:\Shares\HR,CONTOSO\HR-Group,Modify,Add,HR
```

**Script 32 — Migrate Users**
```csv
SamAccountName,TargetOU,NewPassword
jdoe,"OU=Staff,DC=new,DC=local",NewPass@2026!
```

</details>

---

## 🔧 Compatibility

| Requirement | Minimum | Recommended |
|---|---|---|
| PowerShell | 5.1 | 5.1 (fully tested) / 7.4+ |
| OS | Windows 10 / Server 2016 | Windows 11 / Server 2022+ |
| AD Module | RSAT or AD DS role | RSAT (`Add-WindowsCapability`) |
| .NET Framework | 4.7.2 | 4.8+ |
| Microsoft.Graph | 1.x | 2.x (v2 SDK, used here) |
| ExchangeOnlineManagement | 3.0+ | 3.4+ |

> ✅ All scripts are tested against **Windows PowerShell 5.1** — the version shipped with Windows Server 2016–2022. No PowerShell 7-only syntax (`?.`, `??`, `&&`, `||`) is used anywhere in this toolkit.

---

## 📂 Repository Structure

```
PS-ActiveDirectory-AzureAD-O365/
│
├── 01-Assign-M365-Licenses-from-CSV.ps1
├── 02-Manage-ExchangeOnline-Mailbox-Permissions.ps1
├── 03-Create-AD-Users-from-CSV.ps1
├── 04-Create-AD-Groups-from-CSV.ps1
├── 05-Find-Inactive-AD-Users-and-Computers.ps1
├── 06-List-and-Move-AD-Computers.ps1
├── 07-Find-Duplicate-IPs-in-DNS.ps1
├── 08-Create-Folders-from-CSV.ps1
├── 09-Get-AD-User-LastLogon-All-DCs.ps1
├── 10-Bulk-Update-AD-User-Attributes.ps1
├── 11-Manage-Local-Windows-Users.ps1
├── 12-Migrate-User-Profile-with-Robocopy.ps1
├── 13-Encrypt-Decrypt-Script-Passwords.ps1
├── 14-Show-Nested-AD-Group-Memberships.ps1
├── 15-Get-Services-on-Remote-Computers.ps1
├── 16-Assign-NTFS-Permissions-on-Shared-Resources.ps1
├── 17-Join-Computer-to-AD-Domain.ps1
├── 18-Copy-AD-Group-Members-Source-to-Dest.ps1
├── 19-Resolve-SID-to-AD-Object.ps1
├── 20-Export-All-AD-Objects-MultiDomain.ps1
├── 21-Move-Files-by-Extension-Recursively.ps1
├── 22-Check-and-Control-Windows-Defender.ps1
├── 23-Setup-Custom-Local-Admin-Account.ps1
├── 24-Run-Commands-Remotely-on-Domain-Computers.ps1
├── 25-Look-Up-AD-User-Details-by-Email.ps1
├── 26-List-AD-Users-Created-in-Last-N-Days.ps1
├── 27-Get-All-Microsoft-Updates-Installed.ps1
├── 28-Get-IP-Address-and-Hostname-from-AD-DNS.ps1
├── 29-Grant-Temporary-AD-Group-Membership.ps1
├── 30-List-DCs-and-FSMO-Roles.ps1
├── 31-Fix-Domain-Trust-Relationship.ps1
├── 32-Migrate-AD-Users-to-New-Domain.ps1
├── 33-M365-Tenant-Information-Report.ps1
├── 34-Find-Inactive-AD-Computers.ps1
└── README.md
```

---

## 🚀 What Makes This Toolkit Different

```
Most PowerShell repos on GitHub:                 This toolkit:
────────────────────────────────────────         ──────────────────────────────────────────
❌  Written 2015–2020, never updated             ✅  Built and audited for March 2026
❌  Uses MSOnline (broken since March 2024)      ✅  Full Microsoft Graph SDK migration
❌  Uses Get-WmiObject (deprecated)              ✅  CIM everywhere (Get-CimInstance)
❌  Uses WMIC.exe (removed in Server 2025)       ✅  PSRemoting + CIM sessions only
❌  Plaintext passwords in script files          ✅  SecureString + DPAPI + AES-256
❌  No -WhatIf support                           ✅  WhatIf on every destructive operation
❌  No error handling                            ✅  try/catch + per-record counters
❌  Hard-coded domain names                      ✅  Full parametrization + sensible defaults
❌  No CSV export                                ✅  UTF-8 CSV output on every script
❌  Single-domain only                           ✅  Multi-domain forest support (Script 20)
❌  No documentation                             ✅  .SYNOPSIS + .NOTES + usage on every file
```

---

## 🤝 Contributing

Contributions are welcome. Please follow the existing code conventions:

- `#Requires -Version 5.1` at the top of every script
- `param()` block with typed, documented parameters
- `[switch]$WhatIf` on any script that modifies data
- `try/catch` with meaningful `$created / $skipped / $failed` counters
- `Export-Csv -NoTypeInformation -Encoding UTF8` for all file output
- `.SYNOPSIS`, `.DESCRIPTION`, and `.NOTES` with usage examples in every file

```powershell
# Standard script header pattern used throughout this project
#Requires -Version 5.1
#Requires -Modules ActiveDirectory
<#
.SYNOPSIS  One-line description.
.NOTES
    Usage : .\XX-ScriptName.ps1 -Param Value
            .\XX-ScriptName.ps1 -Param Value -WhatIf
#>
param(
    [Parameter(Mandatory)][string]$RequiredParam,
    [switch]$WhatIf
)
$created = 0; $skipped = 0; $failed = 0
# ... script body with try/catch and counter increments
Write-Host "Done. Created: $created | Skipped: $skipped | Failed: $failed" -ForegroundColor Cyan
```

---

## 📄 License

MIT License — free to use, modify, and distribute in personal and commercial projects. See [LICENSE](LICENSE) for details.

---

<div align="center">

**Built with ❤️ for enterprise IT professionals**
*Tested · Modernized · Production-ready · March 2026*

<br/>

⭐ **If this toolkit saved you time, please star the repository** ⭐

<br/>

<img src="https://img.shields.io/badge/PowerShell-5.1%2B-blue?style=flat-square&logo=powershell" />
<img src="https://img.shields.io/badge/Microsoft%20Graph-v2%20SDK-0078D4?style=flat-square&logo=microsoft" />
<img src="https://img.shields.io/badge/Exchange%20Online-v3%2B-D83B01?style=flat-square&logo=microsoftoutlook" />
<img src="https://img.shields.io/badge/Scripts-34-brightgreen?style=flat-square" />
<img src="https://img.shields.io/badge/WhatIf-Supported-success?style=flat-square" />
<img src="https://img.shields.io/badge/MSOnline-Migrated%20Away%20%E2%9C%93-red?style=flat-square" />
<img src="https://img.shields.io/badge/WMIC-Gone%20%E2%9C%93-red?style=flat-square" />

</div>
