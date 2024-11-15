@sys.description('The environment type (nonprod or prod)')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string = 'nonprod'
@sys.description('The PostgreSQL Server name')
@minLength(3)
@maxLength(24)
param postgreSQLServerName string = 'ie-bank-db-server-dev'
@sys.description('The PostgreSQL Database name')
@minLength(3)
@maxLength(24)
param postgreSQLDatabaseName string = 'ie-bank-db'

param location string = resourceGroup().location

// Environment variables for the backend API
// @minLength(3)
// @maxLength(24)
// param backendContainerAPIName string
// @sys.description('The Azure location where the resources will be deployed')
// @sys.description('The value for the environment variable ENV')
// param backendContainerAPIEnvVarENV string
// @sys.description('The value for the environment variable DBHOST')
// param backendContainerAPIEnvVarDBHOST string
// @sys.description('The value for the environment variable DBNAME')
// param backendContainerAPIEnvVarDBNAME string
// @sys.description('The value for the environment variable DBPASS')
// @secure()
// param backendContainerAPIEnvVarDBPASS string
// @sys.description('The value for the environment variable DBUSER')
// param backendContainerAPIEnvVarDBUSER string
// @sys.description('The value for the environment variable FLASK_APP')
// param backendContainerAPIEnvVarFLASK_APP string
// @sys.description('The value for the environment variable FLASK_DEBUG')
// param backendContainerAPIEnvVarFLASK_DEBUG string

// Frontend repository details for Static Web App
@sys.description('Frontend repository URL')
param frontendRepositoryUrl string
@sys.description('Frontend repository branch')
param frontendRepositoryBranch string = 'main'
@sys.description('Frontend repository personal access token')
@secure()
param frontendRepositoryToken string = ''
@sys.description('The name of the Static Web App')
param staticWebAppName string

// Azure Container Registry SKU
@sys.allowed([
  'Basic'
  'Standard'
  'Premium'
])
@sys.description('The Azure Container Registry SKU')
param acrSku string = 'Standard'
@sys.description('The Azure Container Registry name')
param containerRegistryName string

// Log Analytics and App Insights configurations
@sys.description('Name of the Log Analytics workspace')
param logAnalyticsWorkspaceName string
@sys.description('SKU for the Log Analytics workspace')
param logAnalyticsSkuName string 
@sys.description('Retention period for data in Log Analytics workspace')
@minValue(0)
@maxValue(730)
param logAnalyticsRetentionDays int 
@description('The Application Insights name')
param appInsightsName string
@description('The Application Insights application type')
param appInsightsType string 
@description('The retention period for Application Insights in days')
param appInsightsRetentionDays int
@description('The Key Vault name')
param keyVaultName string
@description('The Key Vault SKU')
param keyVaultSku string
@sys.description('The role assignments for the Key Vault')
param keyVaultRoleAssignments array = []



module containerRegistry 'modules/docker-registry.bicep' = {
  name: containerRegistryName 
  params: {
    registryName: containerRegistryName
    location: location
    sku: acrSku
    keyVaultResourceId: keyVault.outputs.resourceId
  }
  dependsOn: [
    keyVault
  ]
}

// Define Azure Container Instance for backend API
// module containerInstance 'modules/container-instance.bicep' = {
//   name: backendContainerAPIName
//   params: {
//     containerGroupName: backendContainerAPIName
//     containerImageName: 'ie-bank-api'
//     containerImageTag: 'latest'
//     location: location
//     containerRegistryLoginServer: containerRegistry.outputs.registryLoginServer
//     containerRegistryUsername: containerRegistry.outputs.adminUsername
//     containerRegistryPassword: containerRegistry.outputs.adminPassword
//     appServiceAPIEnvVarENV: backendContainerAPIEnvVarENV
//     appServiceAPIEnvVarDBHOST: backendContainerAPIEnvVarDBHOST
//     appServiceAPIEnvVarDBNAME: backendContainerAPIEnvVarDBNAME
//     appServiceAPIEnvVarDBPASS: backendContainerAPIEnvVarDBPASS
//     appServiceAPIEnvVarDBUSER: backendContainerAPIEnvVarDBUSER
//     appServiceAPIEnvVarFLASK_APP: backendContainerAPIEnvVarFLASK_APP
//     appServiceAPIEnvVarFLASK_DEBUG: backendContainerAPIEnvVarFLASK_DEBUG
//   }
// }


module postgresDb 'modules/postgresql-db.bicep' = {
  name: postgreSQLServerName
  params: {
    postgreSQLServerName: postgreSQLServerName
    location: location
    postgreSQLDatabaseName: postgreSQLDatabaseName
    administratorLoginPassword: 'IE.Bank.DB.Admin.Pa$$' // Replace with a secure value
  }
}

// Outputs for PostgreSQL
output postgreSQLServerName string = postgresDb.outputs.postgreSQLServerName
output postgreSQLDatabaseName string = postgresDb.outputs.postgreSQLDatabaseName
output postgreSQLServerAdmin string = postgresDb.outputs.postgreSQLServerAdmin

// Log Analytics Workspace and Application Insights
module logAnalytics 'modules/log-analytics.bicep' = {
  name: logAnalyticsWorkspaceName
  params: {
    name: logAnalyticsWorkspaceName
    location: location
    skuName: logAnalyticsSkuName
    dataRetention: logAnalyticsRetentionDays
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    tags: {
      Environment: environmentType
      Project: 'IE Bank'
    }
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
    tags: {
      Environment: environmentType
      Project: 'IE Bank'
    }
  }
}

module staticWebApp 'modules/static-web-app.bicep' = {
  name: staticWebAppName
  params: {
    name: staticWebAppName
    sku: 'Free'
    location: 'westeurope'
    repositoryToken: frontendRepositoryToken
    repositoryUrl: frontendRepositoryUrl
    branch: frontendRepositoryBranch
  }
}

module keyVault 'modules/key-vault.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    name: keyVaultName
    location: location
    sku: keyVaultSku
    roleAssignments: keyVaultRoleAssignments
    enableVaultForDeployment: true
  }
}

output keyVaultUri string = keyVault.outputs.keyVaultUri
