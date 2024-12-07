# Service Level Agreement (SLA) 

## **Purpose**
This SLA defines the performance, availability, and reliability commitments of the DevOpps system. It outlines the agreed-upon metrics and responsibilities to ensure the system's effective operation.

---

## **Scope**
This SLA applies to the following services and components in the production environment:
- Azure Key Vault
- Azure Container Registry
- Azure PostgreSQL Server and Database
- Azure App Service (Backend)
- Azure Static Web App
- Azure Log Analytics Workspace
- Azure Application Insights
- Azure Logic App (for Slack notifications)

---

## **Service Level Objectives (SLOs)**

### **1. Key Vault**
- **Availability**: 99.9%
- **Access Time**: 99.9% of secret retrieval operations should complete within 100 milliseconds.

---

### **2. Container Registry**
- **Availability**: 99.9%
- **Image Pull Time**: Ensure image pull requests complete within 500 milliseconds for 95% of operations.

---

### **3. PostgreSQL Server**
- **Availability**: 99.95%
- **Response Time**: Ensure 95% of database queries complete within 300 milliseconds.

---

### **4. App Service (Backend)**
- **Availability**: 99.95%
- **API Latency**: Maintain API response times under 200 milliseconds for 95% of requests.

---

### **5. Static Web App**
- **Availability**: 99.99%
- **Page Load Time**: Ensure 95% of pages load within 1 second globally.

---

### **6. Log Analytics Workspace**
- **Data Availability**: 99.9% of logs and telemetry data should be available within 5 minutes of generation.
- **Retention**: Logs retained for 30 days.

---

### **7. Application Insights**
- **Data Availability**: 99.9% of monitoring data should be available within Application Insights for real-time diagnostics.
- **Retention**: Insights retained for 90 days.

---

### **8. Logic App and Slack Notifications**
- **Notification Delivery**: 99.9% of alerts should be sent to Slack within 1 minute of threshold breaches.

---

## **Monitoring and Reporting**
### **Tools Used for Monitoring**
- **Azure Monitor**: Tracks performance and availability metrics.
- **Log Analytics Workspace**: Aggregates logs for analysis.
- **Application Insights**: Monitors application performance and user behavior.

---

## **Incident Response and Escalation**
1. **Initial Response Time**: Within 15 minutes for critical incidents.
2. **Escalation Timeframe**:
   - Escalate unresolved issues to the next support level within 1 hour.
3. **Incident Resolution Time**:
   - Critical: Resolved within 4 hours.
   - Moderate: Resolved within 8 hours.
   - Low: Resolved within 24 hours.

---

## **Performance Measurement**
Metrics will be measured monthly using Azure’s built-in monitoring and reporting tools. If any SLA is not met, an RCA (Root Cause Analysis) will be conducted to address the issue.

---

## **Review and Revision**
This SLA will be reviewed quarterly to ensure it remains relevant and accurate. Any updates will be communicated to stakeholders.

---

## **Exclusions**
This SLA does not cover:
1. Issues caused by user misconfiguration.
2. Outages due to planned maintenance (with at least 48 hours of prior notice).
3. Third-party service failures outside Azure's ecosystem.
