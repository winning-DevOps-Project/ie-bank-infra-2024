using '../main.bicep'

param environmentType = 'nonprod'
param location = 'North Europe'

// posgtresql
param postgreSQLServerName = 'devopps-dbsrv-dev'
param postgreSQLDatabaseName = 'devopps-db-dev'

// app service plan
param appServicePlanName = 'devopps-asp-dev'
param appServicePlanSku = 'B1'

// app service
param appServiceAppName = 'devopps-be-dev' // Name of the backend app
// param dockerRegistryName = 'devoppsregistry'
// param dockerRegistryImageName = 'iebank-backend'
// param dockerRegistryImageVersion = 'latest'
// param dockerRegistryServerUserName = 'github-secret-replaced-in-workflow'
// param dockerRegistryServerPassword = 'github-secret-replaced-in-workflow'

// param appServiceAppName = 'devopps-be-dev'
// param appServiceAPIAppName = 'devopps-be-dev'
// param appServiceAPIDBHostFLASK_APP =  'iebank_api\\__init__.py'
// param appServiceAPIDBHostFLASK_DEBUG =  '1'
// param appServiceAPIDBHostDBUSER = 'github-secret-replaced-in-workflow'
// param appServiceAPIEnvVarDBPASS =  'github-secret-replaced-in-workflow'
// param appServiceAPIEnvVarDBHOST =  'devopps-dbsrv-dev.postgres.database.azure.com'
// param appServiceAPIEnvVarDBNAME =  'devopps-db-dev'
// param appServiceAPIEnvVarENV =  'dev'

// LAW
param logAnalyticsWorkspaceName = 'devopps-law-dev'
param logAnalyticsSkuName = 'Free' 
param logAnalyticsRetentionDays = 30

//Insights
param appInsightsName = 'appInsights-dev'
param appInsightsType = 'web'
param appInsightsRetentionDays = 365

//KeyVault
param keyVaultName = 'devopps-keyvault-dev'
param keyVaultSku = 'standard' 

//static website
param staticWebAppName = 'devopps-swa-dev'

// Container Registry
param containerRegistryName = 'DevoppsDevACR'
