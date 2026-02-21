# PowerShell-Scripting-and-Automation
# Bulk User Creation Script for Active Directory and Exchange Server

# Overview:
Managing users in Active Directory manually can be time-consuming, prone to errors, and difficult to scale in medium or large organizations. This PowerShell script automates the creation of multiple Active Directory users from a CSV file while maintaining a clean, organized, and secure environment. The script ensures that users are created in the correct organizational unit (OU), department OUs and security groups are automatically generated if they do not exist, users are added to their respective groups, roaming profiles are configured, home drives are assigned, and users are forced to change their password at first logon. For organizations using Exchange Server, the script can optionally create mailbox databases and enable mailboxes for all users. This approach ensures consistent configuration, enforces security policies, and reduces manual errors, making onboarding faster and more reliable.

# Key Features:
1. User Creation and Organization:
- Creates users in the correct Users OU based on department
- Automatically creates department OUs if they do not exist
- Generates sub-OUs for Users and Groups inside each department

2. Security and Access Management:
- Creates department security groups if they do not exist
- Adds users to their respective department security groups
- Forces password change at first logon
  
3. User Experience Enhancements:
- Configures roaming profiles so users can log in to any workstation and retain settings
- Assigns a home drive (H:) for personal files

4. Exchange Mailbox Integration:
- Optionally creates and enables Exchange mailboxes for all users
- Can create multiple Exchange mailbox databases (DB1 to DB50) with specified EDB and log paths

# Active Directory Structure:

- The script organizes Active Directory in a clear, scalable structure:

- Employee OU as the top-level container:

- Sales OU contains a Users OU with all Sales users and a Groups OU with the Sales Group containing all Sales users

- IT OU contains a Users OU with all IT users and a Groups OU with the IT Group containing all IT users

- Finance OU contains a Users OU with all Finance users and a Groups OU with the Finance Group containing all Finance users

- Marketing OU contains a Users OU with all Marketing users and a Groups OU with the Marketing Group containing all Marketing users

- Accounting OU contains a Users OU with all Accounting users and a Groups OU with the Accounting Group containing all Accounting users

- This structure ensures that users and groups are organized per department, access is properly controlled, and policies can be enforced consistently.

# How the Script Works?

The script starts by importing the CSV file containing user details and converting the default password into a secure string. For each user record, it performs the following actions:

- Checks if the main Employee OU exists and creates it if missing

- Checks if the department OU exists and creates it if missing

- Creates sub-OUs for Users and Groups inside each department

- Checks if the department security group exists and creates it if missing

- Verifies if a user with the same SamAccountName already exists and skips creation if so

- Creates the new user in the Users OU

- Configures a roaming profile for consistent access across workstations

- Assigns a home drive mapped to H:

- Forces a password change at first logon

- Adds the user to their department security group

- Optionally enables an Exchange mailbox

By combining these steps, the script ensures that every user is properly configured, has secure access, and is ready to work without manual setup.

# CSV File Example:
The CSV file must include the following columns:
FirstName,LastName,FullName,Gender,Role,OU
John,Doe,John Doe,Male,Engineer,IT
Jane,Smith,Jane Smith,Female,Manager,Finance

# Important Notes:
- The script checks for duplicate SamAccountNames to avoid creating users twice
- Default passwords are set to Pineapple123$ and users are required to change them at first logon
- Roaming profiles ensure users retain their settings across all workstations
- Home drives provide personal storage mapped to H:
- The script assumes all users belong under OU=Employee,DC=abc,DC=com. Adjust if your AD structure is different
- Test the script in a lab environment before deploying to production:

# How to Run?
- Open PowerShell as Administrator
-Ensure the ActiveDirectory module is installed and loaded
- Place the CSV file at the path specified in $csvPath
- Run the script using: .\BulkUserCreation.ps1

# Verify that:

- All users are created in the correct department OU

- Roaming profiles and home drives are configured

- Users are members of their respective department groups

- Exchange mailboxes are created and enabled if applicable

This script provides a professional, scalable, and secure approach to Active Directory management. By automating repetitive tasks, enforcing security policies, and maintaining a clear AD structure with department OUs, groups, roaming profiles, and home drives, organizations can improve efficiency, reduce errors, and enhance user satisfaction.
