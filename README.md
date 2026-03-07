<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PowerShell Scripting and Automation</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #5391FE;
            --accent: #FF6B35;
            --success: #00D084;
            --warning: #FF9800;
            --dark: #0D1117;
            --light: #F6F8FA;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0D1117 0%, #1a1a2e 50%, #16213e 100%);
            color: #24292E;
            line-height: 1.6;
        }

        header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 50%, #FFB84D 100%);
            padding: 5rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 15px 50px rgba(83, 145, 254, 0.4);
        }

        header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, transparent 70%);
            border-radius: 50%;
        }

        h1 {
            font-size: 3.5rem;
            font-weight: 900;
            color: white;
            margin-bottom: 1rem;
            text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
            animation: slideDown 0.8s ease-out;
        }

        .tagline {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.95);
            font-weight: 300;
            position: relative;
            z-index: 1;
            animation: fadeIn 1s ease-out 0.3s both;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        nav {
            background: white;
            padding: 1.5rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 1rem;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        nav a {
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
            padding: 0.7rem 1.4rem;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            color: white;
            transform: translateY(-3px);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        section {
            background: white;
            margin: 2.5rem 0;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
            animation: fadeIn 0.7s ease-out;
        }

        h2 {
            font-size: 2.3rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1.5rem;
            border-bottom: 3px solid var(--accent);
            padding-bottom: 1rem;
        }

        h3 {
            color: var(--primary);
            font-size: 1.7rem;
            margin-top: 1.8rem;
            margin-bottom: 1rem;
            border-left: 5px solid var(--accent);
            padding-left: 1rem;
        }

        h4 {
            color: var(--accent);
            font-size: 1.2rem;
            margin: 1rem 0 0.5rem 0;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }

        .feature-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(83, 145, 254, 0.12);
            transition: all 0.3s ease;
            border-left: 5px solid var(--primary);
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, rgba(255, 107, 53, 0.1) 0%, transparent 70%);
            border-radius: 50%;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(83, 145, 254, 0.25);
            border-left-color: var(--accent);
        }

        .feature-card h4 {
            color: var(--primary);
            margin-top: 0;
            position: relative;
            z-index: 1;
        }

        .badges {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin: 2rem 0;
        }

        .badge {
            display: inline-block;
            padding: 0.6rem 1.3rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            color: white;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 600;
            box-shadow: 0 6px 20px rgba(83, 145, 254, 0.25);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            border-radius: 8px;
            overflow: hidden;
        }

        thead {
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            color: white;
        }

        th {
            padding: 1.2rem;
            text-align: left;
            font-weight: 700;
        }

        td {
            padding: 1rem 1.2rem;
            border-bottom: 1px solid #e0e0e0;
        }

        tbody tr:nth-child(odd) {
            background: #f9f9f9;
        }

        tbody tr:hover {
            background: linear-gradient(90deg, rgba(83, 145, 254, 0.08) 0%, rgba(255, 107, 53, 0.08) 100%);
        }

        ul, ol {
            margin: 1rem 0 1rem 2rem;
        }

        li {
            margin: 0.6rem 0;
        }

        .highlight {
            background: linear-gradient(135deg, #fff9e6 0%, #fff0b3 100%);
            border-left: 5px solid var(--accent);
            padding: 1.5rem;
            margin: 1.5rem 0;
            border-radius: 6px;
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.15);
        }

        .script-card {
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 8px 25px rgba(83, 145, 254, 0.25);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin: 1rem 0;
        }

        .script-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(83, 145, 254, 0.4);
        }

        .script-card h4 {
            color: white;
            margin-top: 0;
        }

        footer {
            background: linear-gradient(135deg, var(--dark) 0%, var(--accent) 100%);
            color: white;
            text-align: center;
            padding: 2.5rem;
            margin-top: 3rem;
            box-shadow: 0 -6px 20px rgba(0, 0, 0, 0.2);
        }

        @media (max-width: 768px) {
            h1 { font-size: 2rem; }
            .tagline { font-size: 1rem; }
            nav { gap: 0.5rem; }
            .container { padding: 1.5rem 1rem; }
            section { padding: 1.5rem; }
            h2 { font-size: 1.6rem; }
            .feature-grid { grid-template-columns: 1fr; }
        }

        .code-block {
            background: #1e1e1e;
            color: #d4d4d4;
            padding: 1.8rem;
            border-radius: 8px;
            overflow-x: auto;
            margin: 1.5rem 0;
            font-family: 'Courier New', monospace;
            border-left: 5px solid var(--success);
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <header>
        <h1>🚀 PowerShell Scripting and Automation</h1>
        <p class="tagline">Enterprise Automation Scripts for Active Directory, Exchange, and Hyper-V</p>
    </header>

    <nav>
        <a href="#challenge">Challenge</a>
        <a href="#scripts">Scripts</a>
        <a href="#features">Features</a>
        <a href="#structure">Structure</a>
        <a href="#usage">Usage</a>
        <a href="#benefits">Benefits</a>
        <a href="#conclusion">Conclusion</a>
    </nav>

    <div class="container">
        <section>
            <div class="badges">
                <span class="badge">💻 PowerShell 5.1+</span>
                <span class="badge">🔑 Active Directory</span>
                <span class="badge">📧 Exchange 2019</span>
                <span class="badge">🖥️ Hyper-V</span>
                <span class="badge">⚡ Enterprise Grade</span>
                <span class="badge">🔒 Production Ready</span>
            </div>
        </section>

        <section id="challenge">
            <h2>🚨 The Challenge</h2>
            <p>Enterprise IT administration involves repetitive, time-consuming manual tasks that are error-prone and difficult to scale.</p>
            
            <div class="highlight">
                <strong>Manual Work: 50+ hours for infrastructure deployment and bulk user creation</strong><br>
                <strong>Automated: Minutes with zero errors and complete audit trail</strong>
            </div>

            <h3>Pain Points:</h3>
            <ul>
                <li>Creating hundreds of users one-by-one is extremely time-consuming (30+ hours)</li>
                <li>Active Directory structure is inconsistent across deployments</li>
                <li>Mailbox provisioning requires multiple manual steps</li>
                <li>Network configuration is often error-prone</li>
                <li>No audit trail for compliance requirements</li>
                <li>Staff spending time on repetitive tasks instead of strategic work</li>
            </ul>

            <h3>The Solution: Comprehensive PowerShell Automation</h3>
            <p>This repository provides 7 production-ready scripts that automate the entire enterprise infrastructure lifecycle, saving 40-50 hours of manual work.</p>
        </section>

        <section id="scripts">
            <h2>💻 Script Collection</h2>
            
            <div class="script-card">
                <h4>1. ADDS Installation: Fully Automated</h4>
                <p>Completely automate Active Directory Domain Services installation on Windows Server. Time Saved: 2-3 hours. Perfect for new forest and domain creation.</p>
            </div>

            <div class="script-card">
                <h4>2. ADDS Installation (Streamlined)</h4>
                <p>Streamlined ADDS installation for experienced administrators. Time Saved: 1-2 hours. Ideal for quick testing and prototyping.</p>
            </div>

            <div class="script-card">
                <h4>3. Bulk User Creation with Mailboxes</h4>
                <p>Create hundreds of users from CSV with complete AD configuration and Exchange integration. Time Saved: 20-30 hours. Perfect for bulk provisioning and migrations.</p>
            </div>

            <div class="script-card">
                <h4>4. Exchange Server 2019 Deployment</h4>
                <p>Fully automated Exchange Server 2019 installation with bundled prerequisites. Time Saved: 4-8 hours. Best for air-gapped environments and greenfield deployments.</p>
            </div>

            <div class="script-card">
                <h4>5. OU Deletion and Removal</h4>
                <p>Forcefully delete organizational units and all contents. Time Saved: 30 minutes per OU. Perfect for cleanup and restructuring.</p>
            </div>

            <div class="script-card">
                <h4>6. Hyper-V NAT Setup</h4>
                <p>Automate Hyper-V internal switch creation with NAT configuration and connectivity testing. Time Saved: 20 minutes. Ideal for lab environment setup.</p>
            </div>

            <div class="script-card">
                <h4>7. Documentation and Best Practices</h4>
                <p>Complete guide with examples, best practices, and troubleshooting tips for all scripts.</p>
            </div>
        </section>

        <section id="features">
            <h2>✅ Key Features</h2>
            
            <h3>Active Directory Automation</h3>
            <div class="feature-grid">
                <div class="feature-card">
                    <h4>🏢 ADDS Installation</h4>
                    <p>Complete forest and domain creation with automatic configuration</p>
                </div>
                <div class="feature-card">
                    <h4>👥 Bulk User Creation</h4>
                    <p>Create 100s of users from CSV with complete configuration</p>
                </div>
                <div class="feature-card">
                    <h4>📁 OU Management</h4>
                    <p>Automatic OU creation and hierarchy management</p>
                </div>
            </div>

            <h3>Security and Access</h3>
            <div class="feature-grid">
                <div class="feature-card">
                    <h4>🔐 Password Management</h4>
                    <p>Force password change at first logon with secure handling</p>
                </div>
                <div class="feature-card">
                    <h4>👮 Security Groups</h4>
                    <p>Department-based group creation and membership management</p>
                </div>
                <div class="feature-card">
                    <h4>🛡️ Hardening</h4>
                    <p>Automatic security hardening and audit logging</p>
                </div>
            </div>

            <h3>User Experience</h3>
            <div class="feature-grid">
                <div class="feature-card">
                    <h4>🏠 Home Drives</h4>
                    <p>Automatic home drive assignment and mapping to H:</p>
                </div>
                <div class="feature-card">
                    <h4>👤 Roaming Profiles</h4>
                    <p>Configure roaming profiles for multi-workstation access</p>
                </div>
                <div class="feature-card">
                    <h4>📧 Exchange Mailboxes</h4>
                    <p>Optional mailbox creation and enablement for all users</p>
                </div>
            </div>
        </section>

        <section id="structure">
            <h2>🏗️ Organizational Structure</h2>
            
            <h3>Professional AD Hierarchy</h3>
            <p>Scripts create a scalable, professional Active Directory structure:</p>

            <div class="highlight">
                Employee OU contains:<br>
                • Sales OU (Users + Groups)<br>
                • IT OU (Users + Groups)<br>
                • Finance OU (Users + Groups)<br>
                • Marketing OU (Users + Groups)<br>
                • Accounting OU (Users + Groups)<br>
            </div>

            <h3>Benefits of This Structure:</h3>
            <ul>
                <li>Clear organizational hierarchy</li>
                <li>Scalable for new departments</li>
                <li>Granular Group Policy application</li>
                <li>Efficient permission management</li>
                <li>Easy delegation of administrative tasks</li>
                <li>Audit trail and compliance support</li>
            </ul>
        </section>

        <section id="usage">
            <h2>🚀 Getting Started</h2>
            
            <h3>Quick Start: Bulk User Creation</h3>

            <h4>Step 1: Prepare CSV File</h4>
            <div class="code-block">
FirstName,LastName,FullName,Gender,Role,OU
John,Doe,John Doe,Male,Engineer,IT
Jane,Smith,Jane Smith,Female,Manager,Finance
Bob,Johnson,Bob Johnson,Male,Analyst,Finance
            </div>

            <h4>Step 2: Run Script as Administrator</h4>
            <div class="code-block">
.\BulkUserCreation.ps1
            </div>

            <h4>Step 3: Verify Results</h4>
            <div class="code-block">
Get-ADUser -Filter {Department -eq "IT"}
Get-ADGroupMember -Identity "IT Group"
Get-Mailbox -ResultSize Unlimited
            </div>

            <h3>Requirements:</h3>
            <ul>
                <li>Windows Server with Active Directory installed</li>
                <li>PowerShell 5.1 or higher</li>
                <li>Administrator privileges</li>
                <li>Active Directory module imported</li>
                <li>Exchange Server (for mailbox creation)</li>
            </ul>
        </section>

        <section id="benefits">
            <h2>🎯 Key Benefits</h2>
            
            <h3>Time Savings</h3>
            <ul>
                <li>ADDS Installation: 2-3 hours saved</li>
                <li>Bulk User Creation: 20-30 hours saved for 100+ users</li>
                <li>Exchange Deployment: 4-8 hours saved</li>
                <li>Total: 40-50 hours saved per infrastructure deployment</li>
            </ul>

            <h3>Quality and Consistency</h3>
            <ul>
                <li>Zero manual configuration errors</li>
                <li>Identical configurations across all servers</li>
                <li>Professional AD structure every time</li>
                <li>Security hardening applied automatically</li>
            </ul>

            <h3>Compliance and Auditing</h3>
            <ul>
                <li>Complete audit trail of all changes</li>
                <li>Timestamped logging for compliance</li>
                <li>Automated security hardening</li>
                <li>Password policy enforcement</li>
            </ul>
        </section>

        <section id="conclusion">
            <h2>🎯 Conclusion</h2>
            
            <p>This PowerShell Scripting and Automation repository provides comprehensive, production-ready automation for:</p>

            <ul>
                <li>Active Directory management (ADDS installation, bulk users, OUs)</li>
                <li>Exchange Server integration (deployment, mailbox creation)</li>
                <li>Hyper-V networking (virtual switch, NAT configuration)</li>
                <li>Security hardening and compliance</li>
                <li>Complete audit logging and verification</li>
            </ul>

            <div class="highlight">
                Save 40-50 hours of manual work, improve security, ensure consistency, and enable rapid scaling with professional-grade automation.
            </div>

            <h3>Suitable For:</h3>
            <ul>
                <li>Small organizations (10-50 users)</li>
                <li>Medium organizations (50-500 users)</li>
                <li>Large enterprises (500+ users)</li>
                <li>Lab and test environments</li>
                <li>Disaster recovery scenarios</li>
            </ul>

            <p style="margin-top: 2rem; font-size: 0.95rem; text-align: center; color: #666;">
                MIT License: Free to use, modify, and deploy<br>
                A comprehensive portfolio project demonstrating advanced PowerShell scripting and enterprise automation expertise
            </p>
        </section>
    </div>

    <footer>
        <p><strong>PowerShell Scripting and Automation</strong></p>
        <p>Enterprise automation for Active Directory, Exchange Server, and Hyper-V</p>
        <p>MIT License: Free to use, modify, and deploy</p>
        <p>Created for hands-on learning and practical infrastructure automation expertise</p>
    </footer>
</body>
</html>
