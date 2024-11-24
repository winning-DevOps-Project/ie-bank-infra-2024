metadata name = 'Application Insights'
metadata description = 'This component deploys an Application Insights instance.'
metadata owner = 'Azure/module-maintainers'

@description('Required. Name of the Application Insights.')
param name string

@description('Optional. Application type.')
param applicationType string = 'web'

@description('Required. Resource ID of the log analytics workspace which the data will be ingested to.')
param workspaceResourceId string

@description('Optional. Retention period in days.')
param retentionInDays int  = 90

@description('Optional. Location for all Resources.')
param location string = resourceGroup().location


//Application Insights Resource
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  kind: 'other'
  properties: {
    Application_Type: applicationType
    Flow_Type: 'Bluefield'
    WorkspaceResourceId: workspaceResourceId
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    RetentionInDays: retentionInDays
  }
}

output appInsightsId string = appInsights.id
output appInsightsConnectionString string = appInsights.properties.ConnectionString
output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
