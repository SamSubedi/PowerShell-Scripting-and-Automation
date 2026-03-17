# PowerShell Scripting and Automation

A practical collection of PowerShell scripts built for real-world IT environments. This repository covers identity management across Active Directory, Microsoft Entra ID, and Microsoft 365, as well as general-purpose automation scripts for day-to-day IT operations and infrastructure management.

All scripts are written in PowerShell and designed with production environments in mind, with error handling, logging, and clear parameter usage throughout.

![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Active Directory](https://img.shields.io/badge/Active_Directory-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Microsoft Entra ID](https://img.shields.io/badge/Microsoft_Entra_ID-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)
![Microsoft 365](https://img.shields.io/badge/Microsoft_365-D83B01?style=for-the-badge&logo=microsoft-office&logoColor=white)
![License](https://img.shields.io/badge/License-Apache_2.0-blue?style=for-the-badge)

---

## Table of Contents

- [About This Repository](#about-this-repository)
- [Repository Structure](#repository-structure)
- [Projects](#projects)
  - [01. PowerShell AD, Entra ID and M365 Scripts](#01-powershell-ad-entra-id-and-m365-scripts)
  - [02. PowerShell Scripting and Automation](#02-powershell-scripting-and-automation)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Usage Notes](#usage-notes)
- [License](#license)
- [Author](#author)

---

## About This Repository

Managing users, groups, licenses, and infrastructure manually across Active Directory, Entra ID, and Microsoft 365 takes up a significant amount of time in any IT environment. This repository brings together scripts that handle those recurring tasks in a reliable and repeatable way.

The scripts range from targeted one-liners wrapped with proper error handling to more involved automation workflows that string together multiple service connections and operations. Whether you are provisioning a batch of new users, cleaning up stale accounts, or auditing M365 license assignments, the goal is the same: less clicking around in portals, more getting things done.

---

## Repository Structure

```
Powershell-Scripting-and-Automation/
│
├── 01. PowerShell-AD-EntraID-M365-Scripts/
│   ├── README.md
│   ├── User-Management/
│   ├── Group-Management/
│   ├── License-Management/
│   ├── Reporting/
│   └── ...
│
├── 02. PowerShell-Scripting-and-Automation/
│   ├── README.md
│   ├── System-Administration/
│   ├── File-and-Storage/
│   ├── Scheduled-Tasks/
│   ├── Logging-and-Monitoring/
│   └── ...
│
├── .gitattributes
├── LICENSE
└── README.md                  (you are here)
```

---

## Projects

---

### 01. PowerShell AD, Entra ID and M365 Scripts

📂 [View Project](./01.%20PowerShell-AD-EntraID-M365-Scripts/)

This folder contains scripts focused on identity and access management across both on-premises Active Directory and the Microsoft cloud stack. The scripts are built to support IT admins and engineers who work across hybrid environments where on-prem AD and Entra ID (formerly Azure AD) run side by side, as well as those working in fully cloud-based M365 tenants.

#### What Is Covered

**Active Directory**
- Bulk user creation and modification from CSV input
- OU (Organisational Unit) creation and management
- Group membership reporting and bulk updates
- Stale account detection and automated disabling or removal
- Password policy reporting and expiry notifications
- GPO (Group Policy Object) documentation and export

**Microsoft Entra ID (Azure AD)**
- User and group provisioning via Microsoft Graph API
- App registration and service principal management
- Conditional Access policy reporting
- Guest user (B2B) lifecycle management
- Sign-in log retrieval and analysis
- Role assignment auditing

**Microsoft 365**
- License assignment, removal, and reporting across users and groups
- Mailbox management via Exchange Online PowerShell
- SharePoint Online site collection reporting
- Teams provisioning and membership management
- MFA status reporting across the tenant
- Inactive mailbox detection and archiving workflows

#### Key Modules Used

| Module | Purpose |
|--------|---------|
| `ActiveDirectory` | On-premises AD operations |
| `Microsoft.Graph` | Entra ID and M365 via Graph API |
| `ExchangeOnlineManagement` | Exchange Online mailbox and transport management |
| `MicrosoftTeams` | Teams provisioning and policy management |
| `MSOnline` | Legacy Azure AD operations where applicable |

#### Example Use Cases

```powershell
# Bulk create AD users from a CSV file
.\New-BulkADUsers.ps1 -CsvPath ".\users.csv" -OUPath "OU=Staff,DC=contoso,DC=com"

# Generate an M365 license report for the entire tenant
.\Get-M365LicenseReport.ps1 -OutputPath ".\Reports\LicenseReport.csv"

# Disable all AD accounts inactive for more than 90 days
.\Disable-InactiveADAccounts.ps1 -InactiveDays 90 -WhatIf
```

> The `-WhatIf` switch is included on any script that makes changes, so you can always preview what will happen before running it for real.

---

### 02. PowerShell Scripting and Automation

📂 [View Project](./02.%20PowerShell-Scripting-and-Automation/)

This folder is a broader collection of PowerShell scripts covering general IT administration and infrastructure automation tasks. Where the first folder focuses specifically on identity and M365, this one covers the wider range of things sysadmins and engineers deal with regularly, from server configuration and disk management to scheduled task deployment and system health monitoring.

The scripts here are built to be reusable across environments, with configurable parameters at the top of each file and comments throughout to make modification straightforward.

#### What Is Covered

**System Administration**
- Windows Server health checks and uptime reporting
- Installed software auditing across multiple machines
- Remote service management (start, stop, restart)
- Windows Update status reporting and patch compliance checks
- Event log collection and filtering for specific error codes
- Local admin account auditing across endpoints

**File and Storage Management**
- Disk space monitoring with email alerting thresholds
- Bulk file operations (rename, move, archive by date)
- Folder permission auditing and reporting
- Large file and duplicate file detection
- Log file cleanup and automated archiving

**Networking and Connectivity**
- Ping sweep and port scanning utilities
- DNS record lookup and validation scripts
- Network share auditing and access reporting
- Certificate expiry monitoring across servers

**Scheduled Tasks and Job Automation**
- Template scripts designed for use as scheduled tasks
- Centralised logging to file and event log
- Email notification wrappers with SMTP configuration
- Script run history and output archiving

**Reporting and Documentation**
- HTML and CSV report generation
- System inventory collection (hardware, OS, roles)
- Environment documentation export scripts

#### Example Use Cases

```powershell
# Check disk space across a list of servers and alert if below threshold
.\Get-DiskSpaceReport.ps1 -ComputerList ".\servers.txt" -ThresholdGB 20 -SendEmail

# Audit local administrator group members on all domain computers
.\Get-LocalAdminAudit.ps1 -OutputPath ".\Reports\LocalAdmins.csv"

# Archive log files older than 30 days from a target directory
.\Invoke-LogArchive.ps1 -SourcePath "D:\Logs" -ArchivePath "D:\Archive" -RetentionDays 30
```

---

## Requirements

Before running any scripts in this repository, make sure the following are in place:

- **PowerShell 5.1** or later (PowerShell 7+ recommended for cross-platform compatibility)
- **Windows Server 2016 / 2019 / 2022** or **Windows 10 / 11** as the execution host
- **Appropriate permissions** for the tasks being performed:
  - Domain Admin or delegated OU permissions for AD scripts
  - Global Admin or specific M365 role assignments for Entra ID and M365 scripts
  - Local Admin on target machines for system administration scripts
- **Required modules** installed before running scripts in Folder 01:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
Install-Module ExchangeOnlineManagement -Scope CurrentUser
Install-Module MicrosoftTeams -Scope CurrentUser
Install-Module MSOnline -Scope CurrentUser
```

- **Script execution policy** set to allow local scripts:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## Getting Started

1. Clone the repository to your local machine:

```bash
git clone https://github.com/SamSubedi/Powershell-Scripting-and-Automation.git
cd Powershell-Scripting-and-Automation
```

2. Navigate to the relevant project folder and read its README for specific setup steps.

3. Open the script you want to run and review the configurable variables at the top of the file.

4. Run PowerShell as Administrator where required:

```powershell
# Use -WhatIf first on any script that modifies data
.\ScriptName.ps1 -WhatIf

# Once satisfied, run without -WhatIf to apply changes
.\ScriptName.ps1
```

---

## Usage Notes

A few things worth keeping in mind before running anything:

- **Test in a lab first.** Any script that creates, modifies, or removes objects should be validated in a non-production environment before being pointed at live systems.
- **Use `-WhatIf` freely.** Scripts that make changes support the `-WhatIf` parameter. Use it to preview output without committing anything.
- **Check the parameters.** Each script has configurable variables or parameters at the top. Read through them and update paths, names, and thresholds to match your environment before running.
- **Logging is built in.** Most scripts write a log file alongside the output. Check the log if something does not behave as expected.
- **Credentials.** No credentials are hardcoded in any script. You will be prompted to authenticate, or you can pass a credential object using `-Credential` where supported.

---

## License

This project is licensed under the **Apache License 2.0**. See the [LICENSE](./LICENSE) file for full details.

You are free to use, modify, and distribute the scripts in this repository, including for commercial use, provided attribution is maintained and the license terms are followed.

---

## Author

**Sam Subedi**

[![GitHub](https://img.shields.io/badge/GitHub-SamSubedi-181717?style=flat&logo=github)](https://github.com/SamSubedi)

---

> Each project folder has its own README with detailed descriptions of every script, usage examples, required permissions, and any specific setup steps. Use the links above to navigate directly to each section.
