---
layout: default
title: "Full Stack Development"
description: "Gloria Paraschivoiu & Pietro Rodrigano"
---  

## [Home](index.md)

- [Continuous Integration](#frontend---ci-strategy)
- [Test Driven Development](#test-driven-development)
- [Continuous Deployment](#continuous-deployment-strategy) 

### FRONTEND - CI STRATEGY
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


## Test-Driven Development

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
## Continuous Deployment Strategy

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

