param location string = resourceGroup().location
param name string
param appServicePlanId string
param dockerRegistryName string
@secure()
param dockerRegistryServerUserName string
@secure()
param dockerRegistryServerPassword string
param dockerRegistryImageName string
param dockerRegistryImageVersion string = 'latest'
param appSettings array = []
param appCommandLine string = ''
param appInsightsInstrumentationKey string
param appInsightsConnectionString string
param workspaceResourceId string

var appInsigthsSettings = [
{ name: 'APPINSIGHTS_INSTRUMENTATIONKEY', value: appInsightsInstrumentationKey }
{ name: 'APPLICATIONINSIGHTS_CONNECTION_STRING', value: appInsightsConnectionString }
{ name: 'ApplicationInsightsAgent_EXTENSION_VERSION', value: '~3' }
{ name: 'XDT_MicrosoftApplicationInsights_NodeJS', value:'1' }
]

var dockerAppSettings = [
  { name: 'DOCKER_REGISTRY_SERVER_URL', value: 'https://${dockerRegistryName}.azurecr.io' }
  { name: 'DOCKER_REGISTRY_SERVER_USERNAME', value: dockerRegistryServerUserName }
  { name: 'DOCKER_REGISTRY_SERVER_PASSWORD', value: dockerRegistryServerPassword }
]

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: name
  location: location
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOCKER|${dockerRegistryName}.azurecr.io/${dockerRegistryImageName}:${dockerRegistryImageVersion}'
      alwaysOn: false
      ftpsState: 'FtpsOnly'
      appCommandLine: appCommandLine
      appSettings: union(appSettings, dockerAppSettings, appInsigthsSettings)
    }
  }
}

resource appServiceDiagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'AppServiceDiagnostics'
  scope: appServiceApp
  properties: {
    workspaceId: workspaceResourceId // Log Analytics Workspace ID
    logs: [
      {
        category: 'AppServiceHTTPLogs' // Captures HTTP logs
        enabled: true
      }
      {
        category: 'AppServiceConsoleLogs' // Captures console logs
        enabled: true
      }
      {
        category: 'AppServiceAppLogs' // Captures application logs
        enabled: true
      }
      {
        category: 'AppServiceAuditLogs' // Captures audit logs
        enabled: true
      }
      {
        category: 'AppServiceIPSecAuditLogs' // Captures IPSec audit logs
        enabled: true
      }
      {
        category: 'AppServicePlatformLogs' // Captures platform logs
        enabled: true
      }
      {
        category: 'AppServiceAuthenticationLogs' // Captures authentication logs
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics' // Tracks all metrics for the app service
        enabled: false
      }
    ]
  }
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
output systemAssignedIdentityPrincipalId string = appServiceApp.identity.principalId

