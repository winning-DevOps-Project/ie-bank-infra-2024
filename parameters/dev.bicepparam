using '../main.bicep'

param environmentType = 'nonprod'
param postgreSQLServerName = 'devopps-dbsrv-dev'
param postgreSQLDatabaseName = 'devopps-db-dev'
// param backendContainerAPIName = 'devopps-asp-dev'
param location = 'North Europe'
// param backendContainerAPIEnvVarFLASK_APP =  'iebank_api\\__init__.py'
// param backendContainerAPIEnvVarFLASK_DEBUG =  '1'
// param backendContainerAPIEnvVarDBUSER = 'github-secret-replaced-in-workflow'
// param backendContainerAPIEnvVarDBPASS =  'github-secret-replaced-in-workflow'
// param backendContainerAPIEnvVarDBHOST =  'devopps-dbsrv-dev.postgres.database.azure.com'
// param backendContainerAPIEnvVarDBNAME =  'devopps-db-dev'
// param backendContainerAPIEnvVarENV =  'dev'

// LAW
param logAnalyticsWorkspaceName = 'devopps-law-dev'
param logAnalyticsSkuName = 'Free' 
param logAnalyticsRetentionDays = 30
param appInsightsName = 'appInsights-dev'
param appInsightsType = 'web'
param appInsightsRetentionDays = 365

// Container Registry
param containerRegistryName = 'DevoppsDevACR'

// Static WebApp
param staticWebAppName = 'devopps-swa-dev'
param keyVaultName = 'devopps-keyvault-dev'
param keyVaultSku = 'standard' 

