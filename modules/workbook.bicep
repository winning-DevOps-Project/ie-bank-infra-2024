@sys.description('The linked resource of the workbook')
param sourceId string
@sys.description('The location of the resource')
param location string
//param appInsightsId string

var workbookSerializedData = '''
{
  "version": "Notebook/1.0",
  "items": [
    {
      "type": 1,
      "content": {
        "json": "## Hello, welcome to Devopps Workbook!"
      },
      "name": "text - 1"
    },
    {
      "type": 1,
      "content": {
        "json": "Application Insights Resource ID: ${appInsightsId}"
      },
      "name": "text - 2"
    }
  ],
  "styleSettings": {},
  "fromTemplateId": "sentinel-UserWorkbook",
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
