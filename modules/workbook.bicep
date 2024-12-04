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
        "json": "## Static Web App Availability Monitoring"
      },
      "name": "slo-header"
    },
    {
      "type": 10,
      "content": {
        "chartId": "workbook1234",
        "version": "MetricsItem/2.0",
        "size": 0,
        "chartType": 2,
        "metricScope": 0,
        "resourceIds": [
          "${sourceId}"
        ],
        "timeContext": {
          "durationMs": 2592000000,
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
            "namespace": "microsoft.web/staticsites",
            "metricVisualization": {
              "displayName": "Availability",
              "color": "#47BF4F"
            }
          }
        ],
        "title": "Static Web App Availability (30 Days)",
        "gridSettings": {
          "rowLimit": 10000
        },
        "visualization": "linechart",
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
          },
          "leftContent": {
            "columnMatch": "Value",
            "formatter": 2,
            "formatOptions": {
              "min": 99,
              "max": 100,
              "palette": "redGreen"
            }
          }
        }
      },
      "name": "availability-metric"
    },
    {
      "type": 1,
      "content": {
        "json": "### Availability Status Explanation\n\n✅ **Meeting SLO (>=99.99%)**: Excellent availability, meeting our target\n\n⚠️ **Warning (>=99.9% and <99.99%)**: Availability is good but below target\n\n❌ **Critical (<99.9%)**: Immediate attention required"
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

