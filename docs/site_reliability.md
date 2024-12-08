---
layout: default
title: "Site-Reliability"
---

## Site-Reliability

[Service Level Agreement](SLA.md)

# Service Level Objectives (SLOs)

### 1. Static Web App Availability
- **Definition**: Ensure the Static Web App is available 99.99% of the time.
- **Status Levels**:
  - ✅ Meeting SLO (>=99.99%): Excellent availability.
  - ⚠️ Warning (>=99.9% and <99.99%): Needs attention.
  - ❌ Critical (<99.9%): Immediate action required.

### 2. HTTP Request Duration
- **Definition**: Ensure that 95% of HTTP requests are completed within 200 milliseconds.
- **Status Levels**:
  - ✅ Meeting SLO (<=200ms): Good performance.
  - ❌ Not Meeting SLO (>200ms): Performance needs immediate attention.

### 3. Key Vault Availability
- **Definition**: Ensure Azure Key Vault maintains 99.9% availability.
- **Status Levels**:
  - ✅ Meeting SLO (>=99.9%): Good availability.
  - ❌ Not Meeting SLO (<99.9%): Immediate action required.

### 4. Application Insights Data Availability
- **Definition**: Ensure 99.9% of monitoring data is available and accessible through Application Insights.
- **Status Levels**:
  - ✅ Meeting SLO (>=99.9%): Data is available and accessible.
  - ❌ Not Meeting SLO (<99.9%): Data availability issues detected.

### 5. Security Monitoring
- **Definition**: Ensure no more than 5 failed requests are detected simultaneously for security monitoring.
- **Status Levels**:
  - ✅ No Failed Requests: System is secure.
  - ❌ Too Many Failed Requests (>5): Immediate action required.

---


# Service Level Indicators (SLIs)

### 1. Static Web App Availability SLI
- **Metric**: The percentage of uptime over a given time period, measured through Azure’s availability metrics for the Static Web App.
- **Target**: >=99.99%.

### 2. HTTP Request Duration SLI
- **Metric**: The duration of HTTP requests processed by the app, specifically measuring the 95th percentile latency.
- **Target**: <=200 milliseconds for 95% of requests.

### 3. Key Vault Availability SLI
- **Metric**: The percentage of successful connections to Azure Key Vault over a given time period.
- **Target**: >=99.9%.

### 4. Application Insights Data Availability SLI
- **Metric**: The percentage of telemetry data successfully ingested and available in Application Insights within a specified time window.
- **Target**: >=99.9%.

### 5. Security Monitoring SLI
- **Metric**: The count of failed requests to the monitored application, measured over a rolling 5-minute interval.
- **Target**: No more than 5 failed requests simultaneously.

---

# Monitoring Strategy

### 1. Observability Tools
- **Azure Monitor/Application Insights**:
  - Page load time tracking.
  - Application performance monitoring.
  - Data availability monitoring (99.9% target).
- **Log Analytics Workspace**:
  - Centralized logging.
  - 30-day retention for logs.
  - Custom workbook for visualization.
- **Custom Workbook Dashboard**:
  - Consolidated view of all metrics.
  - Visual representation of SLOs.
  - Real-time status monitoring.

### 2. Alerting Strategy
- **Action Groups**:
  - Centralized alert management.
  - Integration with Logic Apps.
- **Logic Apps Integration**:
  - Automated alert processing.
  - Slack channel notifications.
  - Real-time incident communication.
- **Security Monitoring**:
  - Failed requests monitoring.
  - Threshold: Maximum 5 failed requests.
  - Critical alerts for security incidents.

### 3. Infrastructure Monitoring
- **Key Vault**:
  - Availability monitoring.
  - Access and audit logging.
  - Security metrics tracking.
- **PostgreSQL Database**:
  - Memory utilization.
  - Performance metrics.
  - Resource optimization alerts.
- **Static Web App**:
  - Availability metrics.
  - Response time tracking.
  - CDN performance monitoring.

---

# Incident Response Approach

When an incident occurs (such as Key Vault availability dropping below 99%, PostgreSQL memory usage exceeding 90%, or page load times exceeding thresholds), our system automatically triggers alerts through a chain of Azure services. 

- The incident is detected by **Azure Monitor metrics**, which triggers metric alerts routed through an **Action Group** to a **Logic App**.
- The Logic App sends detailed notifications to the **Slack channel** (`azure-alerts-devopps`), ensuring rapid team awareness.
- Alerts include:
  - **Incident nature**: e.g., "PostgreSQL server free memory has dropped below 5GB."
  - **Suggested actions**: e.g., "Please check database usage and optimize queries if needed."
  
This setup, combined with Azure Workbooks, ensures quick detection, assessment, and resolution of incidents, minimizing disruptions.

---

# Capacity Design

### App Service Plan (BE)
- **DEV/UAT Environment**:
  - **SKU**: B1 (Basic).
  - **Specs**: 1 Core, 1.75 GB RAM.
  - **Purpose**: Development and testing with moderate traffic.

### PostgreSQL Flexible Server
- **DEV/UAT Environment**:
  - **SKU**: Standard_B1ms (Burstable).
  - **Specs**: 1 vCore, 32GB Storage.
  - **Purpose**: Development workloads.

### Static Web App (FE)
- **DEV/UAT Environment**:
  - **SKU**: Free.
  - **Purpose**: Development and testing.

### Azure Container Registry
- **DEV/UAT Environment**:
  - **SKU**: Standard.
  - **Features**: 100 GB storage, webhooks, geo-replication.

### Log Analytics Workspace
- **DEV/UAT Environments**:
  - **SKU**: PerGB2018.
  - **Retention**: 30 days.

### Application Insights
- **DEV/UAT Environments**:
  - **Type**: Web.
  - **Retention**: 90 days.

### Key Vault
- **DEV/UAT Environments**:
  - **SKU**: Standard.
  - **Soft Delete**: Disabled in DEV, enabled in UAT.
 
## Azure Production Environment Configuration

## App Service Plan (BE) 
- **SKU**: B1 (Basic)  
- **Specs**: 1 Core, 1.75 GB RAM  
- **Purpose**: Production workloads  

## PostgreSQL Flexible Server 
- **SKU**: Standard_B1ms (Burstable)  
- **Specs**: 1 vCore, Burstable tier  
- **Purpose**: Production database workloads  

## Static Web App (FE)  
- **SKU**: Standard  
- **Purpose**: Production frontend hosting with CDN capabilities  

## Azure Container Registry 
- **SKU**: Standard  
- **Features**: 100 GB storage, webhooks  

## Log Analytics Workspace
- **SKU**: PerGB2018  
- **Retention**: 30 days  

## Application Insights 
- **Type**: Web  
- **Retention**: 90 days  

## Key Vault 
- **SKU**: Standard  
- **Soft Delete**: Enabled  
- **Purpose**: Secure secrets management for production  

---


# Cost Optimization and FinOps 

Our Azure infrastructure implements a comprehensive three-tier environment strategy (Development, UAT, and Production) with environment-specific optimizations. The infrastructure utilizes Azure App Services with B1 plans, PostgreSQL Flexible Server with Standard_B1ms/Burstable configurations, and Static Web Apps with built-in CDN capabilities. Security is managed through Azure Key Vault (Standard tier) with environment-appropriate soft delete policies. Container management is handled by Azure Container Registry (Standard tier, $20/month), providing essential features with 100GB storage. Monitoring and observability are implemented through Application Insights and Log Analytics, with retention periods of 30-90 days depending on the environment. The solution includes automated alerting through Logic Apps integrated with Slack for real-time monitoring. Cost optimization is achieved through strategic resource sizing, burstable compute options, and environment-specific retention policies. Production environment maintains higher reliability standards while development and UAT environments optimize for cost-efficiency. The infrastructure leverages Azure's pay-as-you-go pricing model where applicable, implementing right-sized resources specific to each environment's needs. This setup ensures a predictable monthly cost structure while maintaining the capability to scale when required, with total monthly costs varying from approximately $50-100 for development/UAT to $150-200 for production environments.


# Performance Efficiency

The performance efficiency design is built around carefully selected Azure resource tiers and monitoring thresholds. The infrastructure uses B1 App Service Plans for compute resources, Standard_B1ms PostgreSQL servers optimized with 32GB storage, and implements CDN capabilities through Static Web Apps. Performance monitoring is handled through Application Insights with custom HTTP duration thresholds set at 200ms, while database performance is monitored with memory utilization alerts triggering at 90% usage. Real-time performance metrics are collected at 1-minute intervals with 5-minute evaluation windows, enabling quick detection of performance degradation. The system leverages Azure Workbooks for performance visualization and tracks key metrics including CDN latency, database response times, and application response times. This design ensures optimal performance through automated monitoring and alerting, with different performance thresholds configured for development , UAT and Production environments to match their specific requirements.

---


# Operational Excellence and Release Engineering

Our operational excellence and release engineering framework is built on Infrastructure as Code principles using Azure Bicep for resource definitions and GitHub Actions for automated deployments. The deployment pipeline (`ie-bank-infra.yml`) implements a structured release process across development , UAT and Production environments, with automated Bicep linting, resource validation, and environment-specific configurations managed through parameter files (`dev.bicepparam` , `uat.bicepparam` and `prod.bicepparam`). The release strategy incorporates automated testing including Key Vault deployment verification, RBAC permission validation, and access policy checks, while operational monitoring is handled through a comprehensive Azure Workbook dashboard that visualizes SLOs and metrics. Incident management is streamlined through Logic Apps integration with Slack, providing real-time alerts for service availability, performance issues, and resource utilization concerns. The deployment process follows a structured pattern where development deployments are triggered by both push events and workflow dispatch, while UAT deployments occur either on pull requests to main or direct pushes to the main branch. Production deployments are strictly controlled, triggering only when a pull request is merged into the main branch. Each environment (Development, UAT, and Production) is configured with its own environment protection rules, ensuring appropriate governance through GitHub environments. The infrastructure is deployed using Bicep templates with environment-specific parameters, and all deployments are preceded by a Bicep linting check in the build stage to ensure template validity. This infrastructure automation, combined with modular Bicep templates and centralized logging with 90-day retention, enables consistent deployments, rapid incident response, and maintains high operational standards across all environments.

---

# Reliability Design

Our comprehensive reliability design implements a robust strategy across all Azure resources, focusing on key reliability pillars. For Availability, we maintain strict SLOs with 99.99% target for Static Web App (Standard tier) and 99.9% for Key Vault (Standard tier), utilizing Azure's built-in high-availability features and CDN capabilities to ensure consistent accessibility. Resiliency is achieved through our PostgreSQL Flexible Server configuration with Standard_B1ms tier in Burstable configuration, complemented by our backup retention policies and automated failover capabilities. Our Monitoring and Alerting system combines Application Insights with 90-day retention and Log Analytics workspace with 30-day retention periods, while Logic Apps integration enables instant Slack notifications for incidents through our configured webhook. The infrastructure leverages B1 App Service Plan for compute resources, and Standard tier Azure Container Registry for container management. Fault Tolerance is implemented through our modular Bicep-based infrastructure deployment, with soft delete enabled for Key Vault data protection. The system's health is continuously monitored through automated checks and metric alerts, ensuring rapid detection and response to any component failures while maintaining system stability and performance. This approach provides a balanced combination of reliability features while maintaining cost-effectiveness in the production environment.
