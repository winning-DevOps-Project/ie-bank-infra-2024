metadata name = 'Application Insights'
metadata description = 'This component deploys an Application Insights instance.'
metadata owner = 'Azure/module-maintainers'

@description('Required. Name of the Application Insights.')
param name string

@description('Optional. Application type.')
@allowed([
  'web'
  'other'
])
param applicationType string = 'web'

@description('Required. Resource ID of the log analytics workspace which the data will be ingested to.')
param workspaceResourceId string

@description('Optional. Disable IP masking. Default value is set to true.')
param disableIpMasking bool = true

@description('Optional. The network access type for accessing Application Insights ingestion. - Enabled or Disabled.')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccessForIngestion string = 'Enabled'

@description('Optional. The network access type for accessing Application Insights query. - Enabled or Disabled.')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccessForQuery string = 'Enabled'

@description('Optional. Retention period in days.')
@allowed([
  30
  60
  90
  120
  180
  270
  365
  550
  730
])
param retentionInDays int = 365

@description('Optional. Location for all Resources.')
param location string = resourceGroup().location

@description('Optional. Tags of the resource.')
param tags object?

//Application Insights Resource
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  tags: tags
  kind: applicationType
  properties: {
    Application_Type: applicationType
    WorkspaceResourceId: workspaceResourceId
    DisableIpMasking: disableIpMasking
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    RetentionInDays: retentionInDays
  }
}

@description('The Instrumentation Key for the Application Insights resource.')
output instrumentationKey string = appInsights.properties.InstrumentationKey
