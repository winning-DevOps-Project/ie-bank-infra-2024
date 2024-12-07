# IE Bank infrastructure

- [IE Bank infrastructure](#ie-bank-infrastructure)
  - [Overview](#overview)
  - [Requirements](#requirements)
  - [Recommended tutorials](#recommended-tutorials)
  - [Configure your local environment](#configure-your-local-environment)
    - [Install Prerequisites](#install-prerequisites)
  - [Repository organization](#repository-organization)
    - [`Main.bicep`](#mainbicep)
    - [Module `app-service.bicep`](#module-app-servicebicep)
  - [Configuration variables](#configuration-variables)
  - [Continuos Delivery](#continuos-delivery)
    - [GitHub secrets](#github-secrets)
    - [GitHub variables](#github-variables)

## Overview

This is the repository for the infrastructure code of the IE Bank web app

![IE Bank app logical view](images/ie-bank-app.png)

## Requirements

This source code works under the following technologies:
- [Azure CLI 2.51.0](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

## Recommended tutorials

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/get-started-with-azure-cli)
- [Azure Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-cli)
- [Learn modules for Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/learn-bicep)
- [Quickstart: Create Bicep files with Visual Studio Code](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI)
- [Deploy Azure resources by using Bicep and GitHub Actions](https://learn.microsoft.com/en-us/training/paths/bicep-github-actions/)
- [Quickstart: Use a Bicep file to create an Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/quickstart-create-server-bicep?toc=%2Fazure%2Fazure-resource-manager%2Fbicep%2Ftoc.json&tabs=CLI)

## Configure your local environment

### Install Prerequisites

- **Install Azure CLI**. Install Azure CLI from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli). Make sure to select the option to add Azure CLI to your PATH while installing.
- **Install Visual Studio Code and Bicep extension**. Install Visual Studio Code from [here](https://code.visualstudio.com/download). Install the Bicep extension from [here](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). You can also follow the steps from the article [Install Bicep tools](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#visual-studio-code-and-bicep-extension)

## Repository organization

### `Main.bicep`

The script that will deploy the infrastructure for IE Bank app is [`main.bicep`](main.bicep).

The script deploys:

Resource | Azure Documentation | Bicep resource definition | Description
--- | --- | --- | ---
**PostgreSQL server** | [Azure Database for PostgreSQL - Flexible Server](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/overview) | [Microsoft.DBforPostgreSQL flexibleServers 2022-12-01](https://learn.microsoft.com/en-us/azure/templates/microsoft.dbforpostgresql/2022-12-01/flexibleservers?pivots=deployment-language-bicep) | PostgreSQL server for the IE Bank app
**PostgreSQL database** | [Azure Database for PostgreSQL - Flexible Server](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/overview) | [Microsoft.DBforPostgreSQL flexibleServers/databases 2022-12-01](https://learn.microsoft.com/en-us/azure/templates/microsoft.dbforpostgresql/2022-12-01/flexibleservers/databases?pivots=deployment-language-bicep) | PostgreSQL database for the IE Bank app
**module `modules/app-service`** | See [Module `app-service.bicep`](#module-app-servicebicep) | - | Bicep module that deploys the web app services for the IE Bank app

### Module `app-service.bicep`

The `main.bicep` script uses the module [`modules/app-service.bicep`](.\modules\app-service.bicep) to deploy the web app services for the IE Bank app.

The module deploys:

Resource | Azure Documentation | Bicep resource definition | Description
--- | --- | --- | ---
**App Service Plan** | [Azure App Service plan overview](https://docs.microsoft.com/en-us/azure/app-service/overview-hosting-plans) | [Microsoft.Web/serverfarms 2021-02-01](https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2021-03-01/serverfarms) | App Service Plan for the IE Bank app
**Linux App Service** | [Azure App Service overview](https://docs.microsoft.com/en-us/azure/app-service/overview) | [Microsoft.Web/sites 2021-02-01](https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2021-03-01/sites) | Linux App Service to host the IE Bank app backend
**Linux App Service** | [Azure App Service overview](https://docs.microsoft.com/en-us/azure/app-service/overview) | [Microsoft.Web/sites 2021-02-01](https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2021-03-01/sites) | Linux App Service to host the IE Bank app frontend

## Configuration variables

To determine different configuration options for each environment, we will make use of the files under the [`parameters`](./parameters/) folder.
- File [`parameters/dev.parameters.json`](./parameters/dev.parameters.json) contains the configuration for the development environment.

## Continuos Delivery

> Learn more: 
>- [Deploy Azure resources by using Bicep and GitHub Actions](https://learn.microsoft.com/en-us/training/paths/bicep-github-actions/)

The file [`.github/workflows/ie-banc-infra.yml`](.github\workflows\ie-bank-infra.yml) contains the configuration for the CI/CD pipeline.

### GitHub secrets

The workflow uses the following GitHub secrets:

Secret name | Description | Learn more
--- | --- | ---
`AZURE_CREDENTIALS` | Azure credentials to authenticate to Azure via Service Principal | [Use the Azure login action with a service principal secret](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#use-the-azure-login-action-with-a-service-principal-secret)
`DBPASS` | Password for the PostgreSQL server, configured as App Setting in the backend web server | [Environment variables and app settings in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet)
`DBUSER` | Username for the PostgreSQL server, configured as App Setting in the backend web server | [Environment variables and app settings in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet)

### GitHub variables

The workflow uses the following GitHub variables:

Variable name | Description | Learn more
--- | --- | ---
`DBHOST` | Hostname for the PostgreSQL server, configured as App Setting in the backend web server | [Environment variables and app settings in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet)
`DBNAME` | Name for the PostgreSQL database, configured as App Setting in the backend web server | [Environment variables and app settings in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet)
`ENV` | Environment name, configured as App Setting in the backend web server  | [Environment variables and app settings in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet)
`FLASK_APP` | Name of the flask app to run, configured as App Setting in the backend web server  | [Environment variables and app settings in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet)
`FLASK_DEBUG` | Debug option for the flask app, configured as App Setting in the backend web server  | [Environment variables and app settings in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet)


# Cyber Security

## GitHub Hardening Strategy for Banking Application

### Code Scanning with CodeQL

Security in software begins with proactive identification of vulnerabilities during development, and CodeQL plays a crucial role in achieving this. By analyzing both the frontend (Vue.js) and backend (Python) code, CodeQL enables the detection of common yet critical vulnerabilities, such as SQL injection, XSS, and command injection, before deployment. Its integration with GitHub Actions allows it to operate seamlessly within our development workflows, flagging issues as soon as code is pushed. This approach embodies "shift-left security," embedding security considerations into the earliest stages of development. With its powerful querying language and support for multiple languages, CodeQL ensures that security remains a fundamental part of the software lifecycle.

#### Key Vulnerabilities Detected
- SQL Injection
- Cross-Site Scripting (XSS)
- Command Injection

| Tool   | Purpose                    | Key Benefits                 |
|--------|----------------------------|------------------------------|
| CodeQL | Detect code vulnerabilities | Proactive, detailed analysis |

*Screenshot:* Below is an example screenshot of CodeQL scanning results:

![CodeQL Scanning Results](images/code_scanning.png)

### Code Scanning with OSSF Scorecard

While CodeQL focuses on analyzing the code itself, maintaining the overall security posture of the repository requires adherence to best practices. The OSSF Scorecard complements CodeQL by evaluating key aspects of repository security, such as branch protection, two-factor authentication, and timely dependency updates. By running automated checks on a regular schedule, Scorecard ensures that our repository's security remains consistent and up to date. The detailed metrics it provides not only help identify areas for improvement but also establish a foundation for continuous compliance with open-source security standards. This is particularly critical for a financial application, where maintaining a high-security threshold is non-negotiable.

#### Key Aspects Evaluated
- Branch Protection
- Two-Factor Authentication
- Dependency Updates

| Tool          | Purpose                           | Key Benefits                 |
|---------------|-----------------------------------|------------------------------|
| OSSF Scorecard | Assess repo security posture       | Consistent compliance checks |

Below is an example screenshot of OSSF Scorecard metrics:

![OSSF Scorecard Metrics](images/openssf_2_2.png)

### GitHub Secret Scanning

In banking applications, safeguarding sensitive information such as API keys and tokens is vital. GitHub Secret Scanning acts as a defense mechanism against the accidental leakage of these credentials. Integrated directly into GitHub, it continuously monitors for any exposed secrets, ensuring immediate detection and resolution. This proactive approach mitigates the risk of unauthorized access, protecting both the application and its sensitive financial data. By pairing Secret Scanning with CodeQL and Scorecard, we create a multi-layered security strategy that addresses not only vulnerabilities but also operational risks.

#### Key Benefits
- Continuous Monitoring
- Immediate Detection and Resolution

| Tool              | Purpose                        | Key Benefits                 |
|-------------------|--------------------------------|------------------------------|
| GitHub Secret Scanning | Detect accidental secret exposure | Protects sensitive info   |

Below is an example screenshot of GitHub Secret Scanning alerts:

![GitHub Secret Scanning Alerts](images/openssf_4.png)

### Push Protection

The integrity of the main codebase is critical in preventing accidental or malicious changes. Push Protection ensures this by blocking risky changes before they are merged. Configurations like requiring pull requests, restricting force pushes, and disallowing branch deletions provide an additional layer of control. These measures complement the outputs of CodeQL, Scorecard, and Secret Scanning by safeguarding the repository against unauthorized modifications. For a banking application, where the smallest oversight could have significant repercussions, such strict protections are indispensable.

#### Configurations
- Require Pull Requests Before Merging
- Restrict Force Pushes
- Disallow Branch Deletions

| Tool           | Purpose                        | Key Benefits                 |
|----------------|--------------------------------|------------------------------|
| Push Protection | Prevent risky changes          | Safeguard code integrity     |

Below is an example screenshot of Push Protection configuration:

![Push Protection Configuration](images/pus_protection.png)

### CODEOWNERS Configuration

A robust security strategy also requires accountability, and the CODEOWNERS configuration ensures that critical changes are reviewed by the right people. By assigning each developer to their corresponding repo, we ensure that every modification undergoes special supervision. This aligns with the outputs from CodeQL, Scorecard, and Push Protection, creating a cohesive workflow where expertise and automated tools work together to secure the codebase. In a high-stakes domain like banking, this combination of automation and human oversight is key to maintaining both quality and security.

#### Benefits of CODEOWNERS
- Accountability for Code Changes
- Expertise-Based Review Process

| Tool           | Purpose                      | Key Benefits                 |
|----------------|------------------------------|------------------------------|
| CODEOWNERS     | Ensure accountability        | Human oversight              |

Below is an example screenshot of the CODEOWNERS file:

![CODEOWNERS File Configuration](images/codeowners.png)

### Conclusion

The chosen GitHub hardening measures—CodeQL, OSSF Scorecard, Secret Scanning, Push Protection, and CODEOWNERS—create a well-rounded approach to safeguarding the code and infrastructure of our banking application. These tools and practices not only detect vulnerabilities but also ensure best practices for access control, accountability, and compliance with security standards. Implementing these controls significantly reduces the risk of vulnerabilities being introduced into the system, thereby enhancing the overall security of the application and protecting sensitive financial data from potential attacks.

### Summary Table

| Tool                 | Purpose                           | Key Benefits                 |
|----------------------|-----------------------------------|------------------------------|
| CodeQL               | Detect code vulnerabilities       | Proactive, detailed analysis |
| OSSF Scorecard       | Assess repo security posture      | Consistent compliance checks |
| GitHub Secret Scanning | Detect accidental secret exposure | Protects sensitive info      |
| Push Protection      | Prevent risky changes             | Safeguard code integrity     |
| CODEOWNERS           | Ensure accountability             | Human oversight              |

### Checklist
- [x] Enable CodeQL scanning for both frontend and backend.
  - ![CodeQL Scanning Results](images/code_scanning.png)
- [x] Configure OSSF Scorecard for regular checks.
  - ![OSSF Scorecard Metrics](images/openssf_2_2.png)
- [x] Set up GitHub Secret Scanning.
  - ![GitHub Secret Scanning Alerts](images/openssf_4.png)
- [x] Configure Push Protection for all repositories.
  - ![Push Protection Configuration](images/pus_protection.png)
- [x] Define CODEOWNERS for specific repositories.
  - ![CODEOWNERS File Configuration](images/codeowners.png)


## Secrets Management Strategy

### Overview of Secrets Management Strategy

Managing sensitive credentials such as API keys, passwords, and other secrets is critical in securing a financial application. To achieve this, our strategy leverages **Azure Key Vault** for centralized credential management and **Azure Managed Identities** for secure, seamless access to Azure resources. The integration of **Azure Bicep** ensures automated and consistent deployments. This cohesive approach secures credentials for critical resources, such as the Container Registry and PostgreSQL server, while minimizing risks and simplifying workflows.

![Overview Diagram](images/overview_diagram_cred.png)

---

### Azure Key Vault for Credential Management

At the heart of our strategy is **Azure Key Vault**, a centralized service for securely storing and managing secrets. By keeping credentials out of source control and application settings, it significantly reduces the risk of accidental exposure. Azure Key Vault’s robust encryption, compliance capabilities, and integration with other Azure services ensure that secrets are securely stored and easily retrievable by authorized applications.

### Key Benefits:
- Centralized management of secrets.
- Strong encryption and compliance with industry standards.
- Easy integration with Azure services like Managed Identity.

By centralizing secret storage, Key Vault provides an efficient, auditable, and secure system for managing sensitive credentials.

**Screenshot:** Below is an example screenshot of Azure Key Vault’s secrets configuration:

![Azure Key Vault Configuration](images/safecode_3_2.png)

---

### Azure Managed Identity for Secure Access

To eliminate static credentials, we use **Azure Managed Identity**, which enables applications to authenticate directly with Azure resources like Key Vault. This approach ensures secure connectivity without the need for hard-coded secrets, reducing the risks associated with credential leaks.

#### Key Benefits:
- Eliminates the need for static credentials.
- Automatically rotates credentials for seamless access.
- Enhances security posture by removing hard-coded secrets.

Managed Identity also automates credential rotation, providing a seamless and secure way to access resources such as the PostgreSQL server and Container Registry.

**Screenshot:** Below is an example screenshot of Azure Managed Identity’s secrets configuration:

![Azure Key Vault Configuration](images/safecode_3_1.png)

---

### Container Registry and PostgreSQL Credentials Protection

### **Container Registry**
For protecting Container Registry credentials, we rely on **Azure Key Vault** and **Azure Bicep templates** to securely store and manage admin usernames and passwords. These credentials are retrieved programmatically with strict access controls, ensuring consistent and secure practices across environments. This approach not only reduces human error but also facilitates automated credential rotation, further enhancing security.

#### **PostgreSQL Server**
Similarly, the PostgreSQL server’s administrative credentials are stored in **Azure Key Vault** and accessed via **Managed Identity**. This ensures that sensitive secrets are never exposed in the codebase or shared manually among developers. With Bicep templates managing deployment, the workflow is automated and consistent, simplifying secret management while maintaining compliance and security.

---

### Key Rotation and Automation

Automated key rotation is a critical aspect of our strategy, mitigating the risks associated with credential compromise over time. By leveraging **Azure Key Vault’s rotation capabilities**, credentials for the Container Registry and PostgreSQL server are updated automatically, adhering to security best practices.

#### Key Benefits:
- Regularly refreshed secrets reduce the risk of compromise.
- Reduces operational overhead through automation.
- Ensures compliance with regulatory requirements.

---

### Collaboration with the Cloud and Infrastructure Teams

The implementation of this strategy was a collaborative effort involving the **Cloud Architect**, **Full Stack Developer**, and **Infrastructure Developer**. By working together, we ensured that security was embedded at every stage of development and deployment, using best practices and Azure’s robust security features.

#### Key Contributions:
- **Cloud Architect:** Designed and audited the secure infrastructure.
- **Full Stack Developer:** Integrated secrets management into application workflows.
- **Infrastructure Developer:** Automated deployment with Azure Bicep.

---

### Conclusion

By combining Azure Key Vault, Managed Identity, and Bicep, we have created a robust secrets management strategy that ensures the security and compliance of our financial application. This approach simplifies credential management, reduces risks, and aligns with the high-security standards required in the financial sector. The collaboration between teams further enhances the reliability and effectiveness of the implementation, ensuring security at every step.



## 10 Implemented Guides in Our Design Document

To holistically secure our banking application, we adopted a dual framework approach, leveraging guidelines from the **Open Source Security Foundation (OpenSSF)** and practices from the **SAFECode framework**. This comprehensive strategy allowed us to address security at every level, including code, cloud infrastructure, database, and deployment. Collaborating with the Cloud Architect and development teams, we integrated 10 key security principles to minimize vulnerabilities and ensure adherence to industry best practices.

### OpenSSF Guidelines

#### 1. Use a Combination of Tools in CI Pipeline to Detect Vulnerabilities

Integrating CodeQL and OSSF Scorecard into our CI/CD pipeline allowed us to continuously analyze code for vulnerabilities. CodeQL provides semantic analysis, while Scorecard evaluates adherence to open-source best practices, offering a thorough and multi-dimensional assessment of our codebase. This dual approach ensures comprehensive vulnerability detection, reducing risks early in the development lifecycle.

**Links:**
- [Frontend Code Scanning](https://github.com/winning-DevOps-Project/ie-bank-fe-2024/security/code-scanning)
- [Infrastructure Code Scanning](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/security/code-scanning)
- [Backend Code Scanning](https://github.com/winning-DevOps-Project/ie-bank-be-2024/security/code-scanning)

**Screenshot:** Below is an example screenshot of the Combination of Tools in CI Pipeline to Detect Vulnerabilities:

![Azure Key Vault Configuration](images/openssf_1.png)

#### 2. Implement Automated Tests, Including Negative Tests

Automated security tests, including negative scenarios, were configured for both frontend and backend using CodeQL. These tests ensure that unintended behaviors are caught and prevented before deployment. This strategy enforces a “ship only if it passes the tests” rule, enhancing the robustness of our banking application by simulating adverse conditions.

**Links:**
- [Frontend Tests](https://github.com/winning-DevOps-Project/ie-bank-fe-2024/actions)
- [Infrastructure Tests](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/actions)
- [Backend Tests](https://github.com/winning-DevOps-Project/ie-bank-be-2024/actions)

**Screenshot:** Below is an example screenshot of the Implemented Automated Tests, Including Negative Tests:

![Azure Key Vault Configuration](images/openssf_2_1.png)

![Azure Key Vault Configuration](images/openssf_2_2.png)

#### 3. Monitor Known Vulnerabilities in Dependencies

**Dependabot** was implemented to monitor and alert us about vulnerabilities in dependencies. By identifying risks in both direct and transitive dependencies, we ensured timely updates to address potential threats. Keeping dependencies up to date reduces exposure to vulnerabilities that could arise from outdated libraries.

**Links:**
- [Frontend Dependabot](https://github.com/winning-DevOps-Project/ie-bank-fe-2024/security/dependabot)
- [Infrastructure Dependabot](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/security/dependabot)
- [Backend Dependabot](https://github.com/winning-DevOps-Project/ie-bank-be-2024/security/dependabot)

**Screenshot:** Below is an example screenshot of the Monitoring of Known Vulnerabilities in Dependencies:

![Azure Key Vault Configuration](images/openssf_3.png)

#### 4. Do Not Push Secrets to a Repository

**GitHub Secret Scanning** was enabled to detect and block accidental inclusion of secrets in the codebase, supported by push protection to prevent sensitive information from being committed. These safeguards ensure that secrets remain out of public repositories, protecting against unauthorized access.

**Links:**
- [Frontend Secret Scanning](https://github.com/winning-DevOps-Project/ie-bank-fe-2024/security/secret-scanning)
- [Infrastructure Secret Scanning](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/security/secret-scanning)
- [Backend Secret Scanning](https://github.com/winning-DevOps-Project/ie-bank-be-2024/security/secret-scanning)

**Screenshot:** Below is an example screenshot of monitoring preventing Pushing Secrets to a Repository:

![Azure Key Vault Configuration](images/openssf_4.png)

#### 5. Improve OpenSSF Scorecards Score

The **OpenSSF Scorecard workflow** was configured to evaluate our repository’s adherence to best practices such as branch protection and dependency management. By improving our Scorecard score, we continually enhance our security posture, aligning with industry standards and reinforcing our commitment to secure development.

**Links:**
- [Frontend Scorecard Workflow](https://github.com/winning-DevOps-Project/ie-bank-fe-2024/actions/workflows/scorecard.yml)
- [Infrastructure Scorecard Workflow](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/actions/workflows/scorecard.yml)
- [Backend Scorecard Workflow](https://github.com/winning-DevOps-Project/ie-bank-be-2024/actions/workflows/scorecard.yml)

### SAFECode Framework Practices

#### 1. Application Security Control Definition

In collaboration with the Cloud Architect, we identified and implemented **Application Security Controls (ASCs)** focused on authentication, data protection, and secure configurations. This ensured critical security requirements were systematically addressed, reducing risks during development.

#### 2. Secure Design Principles & Threat Modeling

Threat modeling sessions with the Cloud Architect identified potential attack vectors and informed the design of security features. Incorporating secure design principles helped us create a resilient architecture that anticipates threats, minimizing the need for reactive fixes post-implementation.

#### 3. Develop an Encryption Strategy

We used **Azure Key Vault** for secure storage of secrets and credentials, alongside a robust encryption strategy for data at rest and in transit. **Managed Identity** facilitated secure communication between services, ensuring sensitive data was consistently protected while meeting stringent financial industry standards.

**Links:**
- [PostgreSQL Server Bicep Module](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/blob/main/modules/postgresql-server.bicep)
- [Docker Registry Bicep Module](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/blob/main/modules/docker-registry.bicep)

**Screenshot:** Below are screenshots of the files implementing the Encryption Strategies:

![Azure Key Vault Configuration](images/safecode_3_1.png)

![Azure Key Vault Configuration](images/safecode_3_2.png)

#### 4. Manage Security Risk Inherent in Third-Party Components

Dependabot’s alerts highlighted risks in third-party components, while our CI/CD pipeline performed automated security and compatibility testing. This proactive approach to dependency management mitigates supply chain risks and ensures the reliability of external libraries integrated into the application.

**Links:**
- [Frontend Dependabot](https://github.com/winning-DevOps-Project/ie-bank-fe-2024/security/dependabot)
- [Infrastructure Dependabot](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/security/dependabot)
- [Backend Dependabot](https://github.com/winning-DevOps-Project/ie-bank-be-2024/security/dependabot)

#### 5. Secure Coding Practices & Code Analysis

Secure coding standards were enforced with tools like CodeQL for static analysis, ensuring developers adhered to safe functions and robust error handling practices. These measures embedded security into the development process, minimizing the likelihood of vulnerabilities being introduced during coding.

**Links:**
- [Frontend Code Scanning](https://github.com/winning-DevOps-Project/ie-bank-fe-2024/security/code-scanning)
- [Infrastructure Code Scanning](https://github.com/winning-DevOps-Project/ie-bank-infra-2024/security/code-scanning)
- [Backend Code Scanning](https://github.com/winning-DevOps-Project/ie-bank-be-2024/security/code-scanning)

---

### Conclusion

By combining OpenSSF guidelines and SAFECode practices, we ensured a comprehensive security framework that addresses vulnerabilities at all levels. This dual-framework approach aligns with industry standards, providing a secure foundation for the development, deployment, and operation of our banking application.
