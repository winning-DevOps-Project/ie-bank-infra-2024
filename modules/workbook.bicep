@sys.description('The linked resource of the workbook')
param sourceId string
@sys.description('The location of the resource')
param location string
param appInsightsId string
var workbookSerializedData = '''
{
  "version": "1.0",
  "items": [
    {
      "type": "textblock",
      "content": {
        "json": {
          "value": "Hello, welcome to Devopps Workbook!"
        }
      }
    },
    {
      "type": "textblock",
      "content": {
        "json": {
          "value": "Application Insights Resource ID: APPINSIGHTSPLACEHOLDER"
        }
      }
    }
  ]
}
'''

resource DevopsWorkbook 'Microsoft.Insights/workbooks@2022-04-01' = {
  name: guid('sampleWorkbook', resourceGroup().id)
  location: location
  kind:'shared'
  properties: {
    category: 'workbook'
    displayName: 'Devopps Workbook'
    serializedData: replace(workbookSerializedData, 'APPINSIGHTSPLACEHOLDER', appInsightsId )
    sourceId: sourceId
  }
}
