
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
