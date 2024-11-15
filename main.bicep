@sys.description('The environment type (nonprod or prod)')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string = 'nonprod'
@sys.description('The user alias to add to the deployment name')
param userAlias string = 'devopps-team'
@sys.description('The PostgreSQL Server name')
@minLength(3)
@maxLength(24)
param postgreSQLServerName string = 'ie-bank-db-server-dev'
@sys.description('The PostgreSQL Database name')
@minLength(3)
@maxLength(24)
param postgreSQLDatabaseName string = 'ie-bank-db'
@sys.description('The App Service Plan name')
@minLength(3)
@maxLength(24)
param appServicePlanName string = 'ie-bank-app-sp-dev'
@sys.description('The Web App name (frontend)')
@minLength(3)
@maxLength(24)
param appServiceAppName string = 'ie-bank-dev'
@sys.description('The API App name (backend)')
@minLength(3)
@maxLength(24)
param appServiceAPIAppName string = 'ie-bank-api-dev'
@sys.description('The Azure location where the resources will be deployed')
param location string = resourceGroup().location

// Environment variables for the backend API
@sys.description('The value for the environment variable ENV')
param appServiceAPIEnvVarENV string
@sys.description('The value for the environment variable DBHOST')
param appServiceAPIEnvVarDBHOST string
@sys.description('The value for the environment variable DBNAME')
param appServiceAPIEnvVarDBNAME string
@sys.description('The value for the environment variable DBPASS')
@secure()
param appServiceAPIEnvVarDBPASS string
@sys.description('The value for the environment variable DBUSER')
param appServiceAPIDBHostDBUSER string
@sys.description('The value for the environment variable FLASK_APP')
param appServiceAPIDBHostFLASK_APP string
@sys.description('The value for the environment variable FLASK_DEBUG')
param appServiceAPIDBHostFLASK_DEBUG string

// Frontend repository details for Static Web App
@sys.description('Frontend repository URL')
param frontendRepositoryUrl string
@sys.description('Frontend repository branch')
param frontendRepositoryBranch string = 'main'
@sys.description('Frontend repository personal access token')
@secure()
param frontendRepositoryToken string = ''

// Azure Container Registry SKU
@sys.allowed([
  'Basic'
  'Standard'
  'Premium'
])
@sys.description('The Azure Container Registry SKU')
param acrSku string = 'Standard'

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
@description('List of object IDs to grant Contributor access to the Key Vault.')
param keyVaultPrincipalIds array = []
@description('Enable RBAC authorization for Key Vault (default: true).')
param keyVaultEnableRbacAuthorization bool = true

// Define App Service Plan using the app-service.bicep module
module appServicePlan 'modules/app-service.bicep' = {
  name: appServicePlanName
  params: {
    appServicePlanName: appServicePlanName
    location: location
    environmentType: environmentType
  }
}

module containerRegistry 'modules/docker-registry.bicep' = {
  name: 'acrdevopps' // The registry name is hardcoded, because the alias contains a - which is not allowed in the registry name
  params: {
    registryName: 'acrdevopps'
    location: location
    sku: acrSku
  }
}

// Use outputs from the containerRegistry module
module appServiceAPI 'modules/app-service-api.bicep' = {
  name: 'appServiceAPI-${userAlias}'
  params: {
    appServiceAPIAppName: appServiceAPIAppName
    appServicePlanId: appServicePlan.outputs.id
    containerRegistryLoginServer: containerRegistry.outputs.registryLoginServer
    containerRegistryUsername: containerRegistry.outputs.adminUsername
    containerRegistryPassword: containerRegistry.outputs.adminPassword
    containerImageName: 'ie-bank-api'
    containerImageTag: 'latest'

    // Environment variables
    appServiceAPIEnvVarENV: appServiceAPIEnvVarENV
    appServiceAPIEnvVarDBHOST: appServiceAPIEnvVarDBHOST
    appServiceAPIEnvVarDBNAME: appServiceAPIEnvVarDBNAME
    appServiceAPIEnvVarDBPASS: appServiceAPIEnvVarDBPASS
    appServiceAPIDBHostDBUSER: appServiceAPIDBHostDBUSER
    appServiceAPIDBHostFLASK_APP: appServiceAPIDBHostFLASK_APP
    appServiceAPIDBHostFLASK_DEBUG: appServiceAPIDBHostFLASK_DEBUG
  }
}

// Outputs for convenience
output registryLoginServer string = containerRegistry.outputs.registryLoginServer
output adminUsername string = containerRegistry.outputs.adminUsername
output adminPassword string = containerRegistry.outputs.adminPassword
output appServiceAppHostName string = appServiceAPI.outputs.appServiceAppHostName

module postgresDb 'modules/postgresql-db.bicep' = {
  name: 'postgresDb-${userAlias}'
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
  name: 'logAnalyticsWorkspaceDeployment-${userAlias}'
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
  name: 'appInsightsDeployment-${userAlias}'
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
  name: 'StaticWebApp-${userAlias}'
  params: {
    name: appServiceAppName
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
    principalIds: keyVaultPrincipalIds
    enableRbacAuthorization: keyVaultEnableRbacAuthorization 
    tags: {
      Environment: environmentType
      Project: 'IE Bank'
    }
  }
}
