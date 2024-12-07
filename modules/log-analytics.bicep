metadata name = 'Log Analytics Workspaces'
metadata description = 'This module deploys a Log Analytics Workspace.'
metadata owner = 'Azure/module-maintainers'

@description('Required. Name of the Log Analytics workspace.')
param name string

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. The name of the SKU.')
param skuName string 

@description('Optional. Number of days data will be retained for.')
param dataRetention int = 30

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: name
  location: location
  properties: {
    retentionInDays: dataRetention
    sku: {
      name: skuName
    }
  }
}

output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id

