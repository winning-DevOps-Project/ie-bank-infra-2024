@sys.description('The linked resource of the workbook')
param sourceId string
@sys.description('The location of the resource')
param location string

var workbookSerializedData = '''
{
  "version": "Notebook/1.0",
  "items": [
    {
      "type": 1,
      "content": {
        "json": "## Hello, welcome to Devopps Workbook!"
      },
      "name": "welcome-header"
    },
    {
      "type": 1,
      "content": {
        "json": "## SLO Monitoring Dashboard"
      },
      "name": "slo-header"
    },
    {
      "type": 1,
      "content": {
        "json": "### Static Web App Availability (Target: 99.99%)"
      },
      "name": "swa-header"
    },
    {
      "type": 10,
      "content": {
        "chartId": "workbook1234",
        "version": "MetricsItem/2.0",
        "size": 0,
        "chartType": 2,
        "resourceType": "microsoft.web/staticsites",
        "metricScope": 0,
        "resourceIds": [
          "/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourceGroups/BCSAI2024-DEVOPS-STUDENTS-A-DEV/providers/Microsoft.Web/staticSites/devopps-swa-dev"
        ],
        "timeContext": {
          "durationMs": 2592000000
        },
        "metrics": [
          {
            "namespace": "microsoft.web/staticsites",
            "metric": "microsoft.web/staticsites--SiteHits",
            "aggregation": 7,
            "splitBy": null
          }
        ],
        "title": "Static Web App Availability (30 Days)",
        "gridFormatType": 1,
        "tileSettings": {
          "titleContent": {
            "formatOptions": {
              "thresholdsOptions": "icons",
              "thresholdsGrid": [
                {
                  "operator": ">=",
                  "thresholdValue": 99.99,
                  "representation": "success"
                },
                {
                  "operator": ">=",
                  "thresholdValue": 99.9,
                  "representation": "warning"
                },
                {
                  "operator": "Default",
                  "representation": "critical"
                }
              ]
            }
          }
        },
        "gridSettings": {
          "rowLimit": 10000
        }
      },
      "name": "availability-metric"
    },
    {
      "type": 1,
      "content": {
        "json": "### Key Vault Availability (Last 7 Days)"
      },
      "name": "kv-header"
    },
    {
      "type": 10,
      "content": {
        "chartId": "workbook5678",
        "version": "MetricsItem/2.0",
        "size": 0,
        "chartType": 2,
        "metricScope": 0,
        "resourceIds": [
          "${sourceId}"
        ],
        "timeContext": {
          "durationMs": 604800000,
          "endTime": null,
          "createdTime": "2024-03-20T10:00:00.000Z",
          "isInitialTime": true,
          "grain": 1,
          "useDashboardTimeRange": false
        },
        "metrics": [
          {
            "resourceMetadata": {
              "id": "${sourceId}"
            },
            "name": "Availability",
            "aggregationType": 4,
            "namespace": "microsoft.keyvault/vaults",
            "metricVisualization": {
              "displayName": "Overall Vault Availability",
              "color": "#47BF4F"
            }
          },
          {
            "resourceMetadata": {
              "id": "${sourceId}"
            },
            "name": "ServiceApiLatency",
            "aggregationType": 4,
            "namespace": "microsoft.keyvault/vaults",
            "metricVisualization": {
              "displayName": "Overall Vault Latency",
              "color": "#FF9900"
            }
          }
        ],
        "title": "Key Vault Performance (7 Days)",
        "visualization": "linechart",
        "gridFormatType": 1,
        "tileSettings": {
          "titleContent": {
            "formatOptions": {
              "thresholdsOptions": "icons",
              "thresholdsGrid": [
                {
                  "operator": ">=",
                  "thresholdValue": 99.9,
                  "representation": "success"
                },
                {
                  "operator": "Default",
                  "representation": "critical"
                }
              ]
            }
          }
        }
      },
      "name": "keyvault-metrics"
    },
    {
      "type": 1,
      "content": {
        "json": "### Application Insights Data Availability (Target: 99.9%)"
      },
      "name": "ai-header"
    },
    {
      "type": 10,
      "content": {
        "chartId": "workbook91011",
        "version": "MetricsItem/2.0",
        "size": 0,
        "chartType": 2,
        "resourceType": "microsoft.insights/components",
        "metricScope": 0,
        "resourceIds": [
          "/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourceGroups/BCSAI2024-DEVOPS-STUDENTS-A-DEV/providers/Microsoft.Insights/components/devopps-insights-dev"
        ],
        "timeContext": {
          "durationMs": 2592000000
        },
        "metrics": [
          {
            "namespace": "microsoft.insights/components/kusto",
            "metric": "microsoft.insights/components/kusto-Availability-availabilityResults/availabilityPercentage",
            "aggregation": 4,
            "splitBy": null
          }
        ],
        "title": "Application Insights Data Availability (30 Days)",
        "gridFormatType": 1,
        "tileSettings": {
          "titleContent": {
            "formatOptions": {
              "thresholdsOptions": "icons",
              "thresholdsGrid": [
                {
                  "operator": ">=",
                  "thresholdValue": 99.9,
                  "representation": "success"
                },
                {
                  "operator": "Default",
                  "representation": "critical"
                }
              ]
            }
          }
        },
        "gridSettings": {
          "rowLimit": 10000
        }
      },
      "name": "ai-metrics"
    },
    {
      "type": 1,
      "content": {
        "json": "### Failed requests count in the last 30 days"
      },
      "name": "failed-requests"
    },
    {
      "type": 10,
      "content": {
        "chartId": "workbook121314",
        "version": "MetricsItem/2.0",
        "size": 0,
        "chartType": 2,
        "resourceType": "microsoft.insights/components",
        "metricScope": 0,
        "resourceIds": [
          "/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourceGroups/BCSAI2024-DEVOPS-STUDENTS-A-DEV/providers/Microsoft.Insights/components/devopps-insights-dev"
        ],
        "timeContext": {
          "durationMs": 2592000000
        },
        "metrics": [
          {
            "namespace": "microsoft.insights/components/kusto",
            "metric": "microsoft.insights/components/kusto-Failures-requests/failed",
            "aggregation": 1,
            "splitBy": null
          }
        ],
        "title": "Security Monitoring (30 Days)",
        "gridFormatType": 1,
        "tileSettings": {
          "titleContent": {
            "formatOptions": {
              "thresholdsOptions": "icons",
              "thresholdsGrid": [
                {
                  "operator": "<=",
                  "thresholdValue": 5,
                  "representation": "success"
                },
                {
                  "operator": "Default",
                  "representation": "critical"
                }
              ]
            }
          }
        },
        "gridSettings": {
          "rowLimit": 10000
        }
      },
      "name": "requests-metrics"
    },
    {
      "type": 1,
      "content": {
        "json": "### SLO Status Explanation\n\n**Static Web App Availability:**\n✅ **Meeting SLO (>=99.99%)**: Excellent availability\n⚠️ **Warning (>=99.9% and <99.99%)**: Needs attention\n❌ **Critical (<99.9%)**: Immediate action required\n\n**Key Vault Availability:**\n✅ **Meeting SLO (>=99.9%)**: Good availability\n❌ **Not Meeting SLO (<99.9%)**: Immediate attention required\n\n**Application Insights Data Availability:**\n✅ **Meeting SLO (>=99.9%)**: Data is available and accessible\n❌ **Not Meeting SLO (<99.9%)**: Data availability issues\n\n**Security Monitoring:**\n✅ **No failed requests**: Secure\n❌ **Too many failed requests at the same time(more than 5)**: Immediate action required"
      },
      "name": "status-explanation"
    }
  ],
  "styleSettings": {},
  "$schema": "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
}
'''

resource DevopsWorkbook 'Microsoft.Insights/workbooks@2022-04-01' = {
  name: guid('DevoppsWorkbook', resourceGroup().id)
  location: location
  kind: 'shared'
  properties: {
    category: 'workbook'
    displayName: 'Devopps Workbook'
    serializedData: workbookSerializedData
    sourceId: sourceId
    version: '1.0'
  }
}



