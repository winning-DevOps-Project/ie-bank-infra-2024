// @sys.description('The environment type (nonprod or prod)')
// param environmentType string = 'nonprod'
// @sys.description('The PostgreSQL Server name')
// param postgreSQLServerName string = 'ie-bank-db-server-dev'
// @sys.description('The PostgreSQL Database name')
// param postgreSQLDatabaseName string = 'ie-bank-db'


@sys.description('The Azure location where the resources will be deployed')
param location string = resourceGroup().location
// Key Vault
@description('The Key Vault name')
param keyVaultName string
@description('The Key Vault SKU')
param keyVaultSku string
param enableSoftDelete bool 
@sys.description('The role assignments for the Key Vault')
param keyVaultRoleAssignments array 
// Azure Container Registry SKU
@sys.description('The Azure Container Registry SKU')
param acrSku string = 'Standard'
@sys.description('The Azure Container Registry name')
param containerRegistryName string

// PostgreSQL
@description('The PostgreSQL Server name')
param postgreSQLServerName string 
@description('The PostgreSQL Database name')
param postgreSQLDatabaseName string  

// App Service
param appServiceWebsiteBEName string 
@sys.description('The App Service Plan name')
param appServicePlanName string 
@sys.description('The App Service Plan SKU')
param appServicePlanSku string
param dockerRegistryImageName string
param dockerRegistryImageVersion string 
var adminPasswordSecretName0 = 'adminPasswordSecretName0'
var adminPasswordSecretName1 = 'adminPasswordSecretName1'
var adminUsernameSecretName = 'adminUsernameSecretName'
param appServiceBeAppSettings array 
// param postgreSQLAdminServicePrincipalObjectId string
// // App Settings (environment variables)
// param backendAppSettings array = []


// Frontend repository details for Static Web App
@sys.description('The name of the Static Web App')
param staticWebAppName string


// Log Analytics and App Insights configurations
@sys.description('Name of the Log Analytics workspace')
param logAnalyticsWorkspaceName string
@sys.description('SKU for the Log Analytics workspace')
param logAnalyticsSkuName string 
@sys.description('Retention period for data in Log Analytics workspace')
param logAnalyticsRetentionDays int 

@description('The Application Insights name')
param appInsightsName string
@description('The Application Insights application type')
param appInsightsType string 
@description('The retention period for Application Insights in days')
param appInsightsRetentionDays int


 // Log Analytics Workspace and Application Insights
module logAnalytics 'modules/log-analytics.bicep' = {
  name: logAnalyticsWorkspaceName
  params: {
    name: logAnalyticsWorkspaceName
    location: location
    skuName: logAnalyticsSkuName
    dataRetention: logAnalyticsRetentionDays
  }
}

module appInsights 'modules/app-insights.bicep' = {
  name: appInsightsName
  params: {
    name: appInsightsName
    applicationType: appInsightsType
    workspaceResourceId: logAnalytics.outputs.logAnalyticsWorkspaceId 
    retentionInDays: appInsightsRetentionDays
    location: location
  }
  dependsOn: [
    logAnalytics
  ]
}

module workbook 'modules/workbook.bicep' = {
  name: 'DevoppsWorkbook'
  params: {
    sourceId: logAnalytics.outputs.logAnalyticsWorkspaceId
    location: location
  }
  dependsOn: [
    logAnalytics
    appInsights
  ]
}

module keyVault 'modules/key-vault.bicep' = {
  name: keyVaultName
  params: {
    name: keyVaultName
    location: location
    sku: keyVaultSku
    roleAssignments: keyVaultRoleAssignments
    enableVaultForDeployment: true
    enableSoftDelete: enableSoftDelete
    workspaceResourceId: logAnalytics.outputs.logAnalyticsWorkspaceId
  }
}

module containerRegistry 'modules/docker-registry.bicep' = {
  name: containerRegistryName 
  params: {
    keyVaultResourceId: keyVault.outputs.resourceId
    keyVaultSecreNameAdminUsername: adminUsernameSecretName
    keyVaultSecreNameAdminPassword0: adminPasswordSecretName0
    keyVaultSecreNameAdminPassword1: adminPasswordSecretName1
    registryName: containerRegistryName
    location: location
    sku: acrSku
    workspaceResourceId: logAnalytics.outputs.logAnalyticsWorkspaceId
  }
  dependsOn: [
    keyVault 
  ]  
}

module appServicePlan 'modules/app-service-plan.bicep' = {
  name: appServicePlanName
  params: {
    location: location
    appServicePlanName: appServicePlanName
    sku: appServicePlanSku
  }
}

resource keyVaultReference 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
  }
  
  module appServiceBE 'modules/app-service.bicep' = {
    name: appServiceWebsiteBEName
    params: {
      name: appServiceWebsiteBEName
      location: location
      appServicePlanId: appServicePlan.outputs.id
      appCommandLine: ''
      appSettings: appServiceBeAppSettings
      dockerRegistryName: containerRegistryName
      dockerRegistryServerUserName: keyVaultReference.getSecret(adminUsernameSecretName)
      dockerRegistryServerPassword: keyVaultReference.getSecret(adminPasswordSecretName0)
      dockerRegistryImageName: dockerRegistryImageName
      dockerRegistryImageVersion: dockerRegistryImageVersion
      appInsightsConnectionString: appInsights.outputs.appInsightsConnectionString
      appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
      workspaceResourceId: logAnalytics.outputs.logAnalyticsWorkspaceId
    }
    dependsOn: [
    appServicePlan
    containerRegistry
    keyVault
    appInsights
    ]
    }

module postgresSQLServer 'modules/postgresql-server.bicep' = {
  name: postgreSQLServerName
  params: {
    location: location
    postgreSQLAdminServicePrincipalObjectId: appServiceBE.outputs.systemAssignedIdentityPrincipalId
    postgreSQLAdminServicePrincipalName: appServiceWebsiteBEName
    postgreSQLServerName: postgreSQLServerName
    workspaceResourceId: logAnalytics.outputs.logAnalyticsWorkspaceId
  }
  dependsOn: [
    appServiceBE
  ]
}

module postgresSQLDatabase 'modules/postgresql-db.bicep' = {
  name: postgreSQLDatabaseName 
  params: {
    postgreSQLDatabaseName: postgreSQLDatabaseName
    serverName: postgresSQLServer.outputs.postgreSQLServerName 
  }
  dependsOn: [
    postgresSQLServer
  ]
}

module staticWebApp 'modules/static-web-app.bicep' = {
  name: staticWebAppName
  params: {
    name: staticWebAppName
    sku: 'Free'
    keyVaultResourceId: keyVault.outputs.resourceId
    keyVaultSecretName: 'SWATokenSecret'
  }
  dependsOn: [
    keyVault
  ]
}


@description('Logic app name')
param logicAppName string 
@description('URL for alerts to Slack')
@secure()
param slackWebhookUrl string

module logicAppModule 'modules/logic-app.bicep' = {
  name: 'logicAppDeployment'
  params: {
    logicAppName: logicAppName
    location: location
    slackWebhookUrl: slackWebhookUrl
  }
}

module actionGroupModule 'modules/action-group.bicep' = {
  name: 'AlertActionGroup'
  params: {
    actionGroupName: 'CpuUsageAlertGroup'
    logicAppEndpointUri: logicAppModule.outputs.logicAppEndpointUri
  }
}

module metricsAlertModule 'modules/metrics-alerts.bicep' = {
  name: 'Alerts'
  params: {
    //appServiceApp: resourceId('Microsoft.Web/sites', appServiceWebsiteBEName)
    appInsightsId: appInsights.outputs.appInsightsId
    actionGroupId: actionGroupModule.outputs.actionGroupId
    keyVaultId: keyVault.outputs.resourceId
  }
  dependsOn: [
    appInsights
    actionGroupModule
    keyVault
  ]
}



