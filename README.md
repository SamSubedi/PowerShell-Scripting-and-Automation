# PowerShell-Scripting-and-Automation
# Bulk User Creation Script for Active Directory and Exchange Server
# Overview: This PowerShell script allows you to create multiple Active Directory users from a CSV file and automatically:

- Create users in the correct OU

- Create the department OU if it does not already exist

- Create the department security group if it does not exist

- Add the user to the appropriate security group

- Enable Exchange mailboxes for all users in the Employee OU

- Force users to change their password at first logon

- The script also includes optional logic to create 50 Exchange mailbox databases (DB1 to DB50) with specified EDB and log paths.


# Prerequisites:

# Before running the script:

- Active Directory and Exchange Server must be fully functional.

- The CSV file must include all required columns: FirstName, LastName, FullName, Gender, Role, OU

# You must run the script with sufficient permissions to:

- Create OUs and groups

- Create user accounts

- Add users to security groups

- Enable mailboxes and create Exchange databases

- The CSV must be formatted correctly with no empty columns and all required information filled in.


# How the Script Works?

- Imports the CSV file and converts the default password into a secure string.

- Loops through each user record and performs:

- Checks if the department OU exists; creates it if missing

- Checks if the department security group exists; creates it if missing

- Checks if a user with the same SamAccountName exists; skips creation if so

- Creates the new user with the provided information, forces password change at first logon, and enables the account

- Adds the user to the department security group


# Exchange Mailbox Setup:

- Creates 50 mailbox databases (DB1 to DB50) with specified paths

- Enables mailboxes for all users in the Employee OU

# CSV File Example:

FirstName,LastName,FullName,Gender,Role,OU
John,Doe,John Doe,Male,Engineer,IT
Jane,Smith,Jane Smith,Female,Manager,HR

# Important Notes

- The script will not create duplicate users; it checks for existing SamAccountName first.

- Passwords are set to a default (Pineapple123$) and users are forced to change them at first logon.

- The script assumes all users belong under OU=Employee,DC=Subedi,DC=com. Adjust the OU path if your AD structure is different.

- If running the Exchange database creation section, ensure the specified file paths exist and have sufficient storage.

- Test the script in a lab environment before running in production.


# How to Run

- Open PowerShell as Administrator.

- Ensure the ActiveDirectory module is installed and loaded.

- Place the CSV file at the path specified in $csvPath.

# Run the script using:

- .\BulkUserCreation.ps1

- Confirm that users are created, assigned to groups, mailboxes enabled, and databases created (if enabled).

