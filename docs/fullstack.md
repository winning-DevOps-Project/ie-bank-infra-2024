

## Full-Stack Development
-mainly diagrams here and description of the important concepts related to the development and implementation of the front and backend that we are handling, also other relevant concepts such as the development strategy (trunk-based)-


## Functional Requirements: 

## Admin Portal - Bank Users Management System 
The IE Bank system will include a bank user's management system that can be accessed and controlled by a bank administrator. A bank users management portal will allow an admin user to view, create, update, and delete bank users.

| Requirements | Description |  
|-|-|
| FR 1. | The application must provide a default administrator account (user, password). The admin account must be able to access the users management portal once logged in successfully. |
| FR 2. | Once logged into the bank users management portal, a bank administrator can list, create, update, and delete bank users and passwords. |


### Administrator Login  
---
The system shall allow the administrator at the bank to log into the admin portal with the default administrator account that will be created once

- **`Admin Account Name`:** A unique identifier for the administrator account
- **`Admin Account Password`:** A unique password for the administrator account

### Administrator List Accounts
---
The system shall allow the administrator to list the account objects which allows the administrator to see their information with their following attributes.

- **`User Account ID`:**   A unique identifier for the account object.

The objects displayed to the administrator will be the following: 
1. ***User History***
2. ***User Balance***
3. ***User Account ID***
4. ***User Account Name***
5. ***User Account Number***
6. ***User Country***
7. ***User Balance***
8. ***User Currency***
9. ***User Status***
10. ***User Created At***

### Administrator Update Accounts
---
The system shall allow the administrator to update the all user account objects after listing the accounts with the following attributes.
 
- **`User Account Name`:** A unique name of the account holder
- **`User Account Password`:** A unique password for the user account
- **`User Country`:** The country where the user account is registered
- **`User Balance`:** The current balance of the user account
- **`User Currency`:** The currency used for the account
- **`User Status`:** The date and time when the user account was created

The objects can be updated to other values, but cannot be deleted or null within the database.

### Administrator Create Accounts
---
The system shall allow the administrator to create/register new user accounts by adding in new attributes through a frontend register page.

- **`User Account Name`:** The name of the account holder
- **`User Account Password`:** A unique password for the account holder 

A unique ***User Account ID*** will be added to the database upon successfully inputting the attributes outlined.   

### Administrator Delete Accounts
---
The system shall allow the administrator to delete user accounts on a separate page with the following attributes:

- **`User Account ID`:** A unique identifier for the account object
- **`User Account Name`:** The name of the account holder
- **`User Account Password`:** A unique password for the account holder

## User Portal - Bank Account Management System
The IE Bank system will allow multiple bank users to access the account management portal that is currently implemented. Bank users can have one or more bank accounts associated with their user profile. Bank users can use the account management portal to perform various banking operations.

| Requirements | Description |  
|-|-|
| FR 3. | New bank users can register on IE bank in the bank with a register for accessible form (username, password, password confirmation). When a new user is registered, a new account will be provided by default, with a random account number. |
| FR 4. | Bank users can log in to the web application using their username and password. Once logged in, they can view only their owned bank accounts and transactions. |
| FR 5. | Bank users can transfer money to other existing accounts in the bank from the account management portal, by entering the recipient’s account number and the amount to be transferred. Amount to transfer cannot be more than the available amount in the account. |

## Non Functional Requirements
For the expected MVP, the following non-functional requirements have been defined:

| Requirements | Description |  
|-|-|
| NFR 1. | The web application should implement a basic user/admin authentication system that requires the users to enter their username and password to log in. The web application should not use any advanced or complex authentication methods, such as biometrics, token, or OAuth. The web application should also encrypt and store the user credentials securely (hashed) in the database. |
| NFR 2. | The web application should have a simple frontend user interface. The web application should not necessarily focus on the aesthetic aspects of the frontend, such as colors, fonts, or animations, or ensure that the frontend is compatible and responsive with different browsers and devices. |

### FRONTEND -- CI STRATEGY
### GitHub Branch Protection Rules

### Main Branch
- Must use **Pull Requests** before merging.
- Requires at least **one code review approval**.
- All **status checks** from CI pipelines must pass prior to merging
---

## Team Collaboration

### Feature Branches
- Use **feature branches** with nomenclature: `feature/<feature-name>`.
- **Short-lived feature branches** are used for bug fixes and feature development/updates.
- Regular **communication among team members** to prevent merge conflicts and maintain a smooth process.

### Trunk-Based Development
- All feature branches are merged back into the `main` branch promptly to avoid divergence.
- Frequent integration is encouraged to catch issues early.

---

## Build Jobs Overview

### Frontend CI Workflow

#### Key Steps:
1. **Code Checkout**: Utilize `actions/checkout@v4`.
2. **Node.js Setup**: Use `actions/setup-node@v4`.
3. **Dependency Installation and Build**:
   - Install dependencies via `npm install`.
   - Build the application for environments:
     - `build-dev`: Development.
     - `build-uat`: User Acceptance Testing.
     - `build-prod`: Production.
4. **Artifact Upload**:
   - Use `actions/upload-artifact@v4` to store build artifacts for deployment.

#### Trigger Events:
- **Pushes** to feature branches deploy to the **development environment**.
- **Pull Requests** to `main` trigger **UAT deployment**.
- **Pushes** to `main` deploy to **production**.

---

# Backend CI Workflow

#### Key Steps:
1. **Checkout Code**: Use `actions/checkout@v4`.
2. **Setup Python**: Leverage `actions/setup-python@v5`.
3. **Dependency Management**:
   - Install required packages using `pip`.
4. **Testing**:
   - Execute **functional** and **unit tests**.
5. **Save Docker Context**:
   - Store Docker context as an artifact using `actions/upload-artifact@v4`.

#### Trigger Events:
- On **manual dispatch** via workflow triggers.
- On **pull requests** to the `main` branch.
- On **pushes** to any other branch.

---

### Deployment Environments

1. **Development (DEV)**:
   - Triggered by **feature branch pushes**.
   - Hosted in Azure DEV resource group.
2. **User Acceptance Testing (UAT)**:
   - Triggered by **pull requests** to `main`.
   - Validates features in the staging environment.
3. **Production (PROD)**:
   - Triggered by **successful merges** to `main`.
   - Stable release for end-users.

---

## Automation Highlights

### Frontend
- YAML workflow ensures a **seamless build and deployment pipeline**.
- Environment-specific build steps ensure compatibility and readiness for production.

### Backend
- Automated **testing and containerization** for consistent application deployment.
- Workflow integrates Docker for seamless production deployments.

---
### Additional Notes
- **Code Reviews**: Promote teamwork and ensure subgroups are aware of peers' contributions and issues faced.
- **Testing Philosophy**: Aligns with TDD principles, integrating **unit** and **functional tests**.
- **Communication Channels**: Mainly updates via **Slack integration**.
---

### Test Driven Development (TDD)

## Test-Driven Development (TDD)

### TDD Workflow
TDD is a repeated process where we write failing tests, write code that ensures the test passes, and refactor.


### Testing & Implementation Details
- **Unit Tests**:
  - Developed using **Pytest**, which verifies components of the implementation.
- **Functional Tests**:
  - This was done using **Postman**, with **Postbot**, to verifiy the end-to-end scenarios in the **User Acceptance Testing (UAT)** environment. This includes the overall management of a bank accpunt, the respective transactions, as well as the user's authorised login.

---

### Workflow Integration
- Functional tests are integrated into the **build and deployment workflows**.
- **GitHub Status Checks** ensure:
  - Only **pull requests** that pass all the tests can continue, and be successfully merged into `main`

---

### Benefits
This integration ensures **high-quality code** throughout the development lifecycle, from development to deployment.

---
## Continuous Deployment (CD) Strategy

### Frontend CD Workflow

#### Key Steps:
1. **Artifact Retrieval**:
   - Retrieve build artifacts from the CI pipeline using `actions/download-artifact@v4`.
2. **Static Web Deployment**:
   - Deploy the application to **Azure Static Web Apps** for efficient and scalable hosting.
3. **Environment-Specific Deployments**:
   - **Development (DEV)**: Automatically deploy builds from feature branches.
   - **User Acceptance Testing (UAT)**: Deploy builds from pull requests to `main`.
   - **Production (PROD)**: Deploy finalized builds after successful merges to `main`.

#### Deployment Automation:
- **YAML Configuration**: Automates deployment steps for different environments.
- **Validation**:
  - Ensure UAT deployment succeeds before allowing production releases.

---

### Backend CD Workflow

#### Key Steps:
1. **Artifact Retrieval**:
   - Fetch Docker images stored as artifacts from CI pipelines.
2. **Dockerization**:
   - Deploy the backend as a containerized application to **Azure App Service**.
3. **Secrets Management**:
   - Use **Azure Key Vault** to securely manage database credentials and other sensitive data.
4. **Environment-Specific Deployments**:
   - **Development (DEV)**: Triggered by feature branch pushes.
   - **User Acceptance Testing (UAT)**: Triggered by pull requests to `main`.
   - **Production (PROD)**: Triggered by successful merges to `main`.

#### Deployment Automation:
- **Docker Workflow**:
  - Build and push Docker images to **Azure Container Registry**.
  - Deploy containers to **App Service** instances for each environment.
- **Validation**:
  - Functional tests to make sure deployments are stable and meet acceptance criteria 
---

### Continuous Deployment Highlights
- **End-to-End Validation**:
  - Functional tests in UAT environments ensure production readiness.
- **Monitoring**:
  - Post-deployment, application health is monitored using **Azure Application Insights**.

---

### Release Strategy

### Overview
The release strategy is designed to ensure **high-quality deployments** across all environments—**Development (DEV)**, **User Acceptance Testing (UAT)**, and **Production (PROD)**. This can inclue workflows, various types of robust testing, and validation steps to streamline the release process.

---

### Environment-Specific Strategy

#### 1. **Development (DEV)**
- **Purpose**: Experimental environment for active development and testing.
- **Triggers**:
  - Pushes to **feature branches**.
- **Deployment Steps**:
  - Build artifacts generated in CI are deployed automatically.
  - Functional tests run to validate components
- **Outcome**:
  - Quick feedback for developers to iterate on features and fixes.

#### 2. **User Acceptance Testing (UAT)**
- **Purpose**: Staging environment for stakeholder validation and functional testing.
- **Triggers**:
  - Pull requests to the `main` branch.
- **Deployment Steps**:
  - Deployment to UAT occurs automatically after CI pipelines pass.
  - Functional and integration tests validate end-to-end scenarios.
- **Outcome**:
  - Confirms that features meet requirements and are production-ready.

#### 3. **Production (PROD)**
- **Purpose**: Stable environment for end-user access.
- **Triggers**:
  - Successful merges to the `main` branch.
- **Deployment Steps**:
  - Artifacts validated in UAT are deployed to production.
  - Monitoring tools, such as **Azure Application Insights**, ensure stability.
- **Outcome**:
  - Features are procided to the end-users.
---

### Key Components

#### Validation Gates
- **GitHub Status Checks**:
  - CI and CD pipelines must pass all automated tests before deployment to UAT or PROD.
- **Manual Approvals**:
  - Optional approvals can be required for critical production releases.

#### Rollback Mechanism
- Each deployment is tagged, enabling easy rollback in case of failures.
- **Dockerized backend** and **static frontend** make reverting to previous builds straightforward.

#### Monitoring and Feedback
- Use **Azure Monitor** and **Application Insights** for real-time tracking.
- Alerts configured to notify teams of any critical issues post-release.

#### Communication
- **Release Notes**:
  - Document changes, new features, and fixes for each release.
- **Slack Notifications**:
  - Notify stakeholders and developers about deployments and their outcomes.

---

### Benefits
- **Consistency**: Automating builds and deployments reduces human error.
- **Scalability**: Environment-specific configurations support growing user bases and features.
- **Transparency**: Stakeholders can validate features in UAT before they go live.
- **Resilience**: Robust rollback and monitoring mechanisms ensure stability in production.

This release strategy aligns with the **CI/CD pipeline**, enabling seamless, automated, and reliable delivery of software updates across all stages of development and deployment.

