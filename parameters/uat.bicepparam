using '../main.bicep'

param environmentType = 'nonprod'
param postgreSQLServerName = 'devopps-dbsrv-uat'
param postgreSQLDatabaseName = 'devopps-db-uat'
// param backendContainerAPIName = 'devopps-be-uat'
param location = 'North Europe'
// param backendContainerAPIEnvVarFLASK_APP =  'iebank_api\\__init__.py'
// param backendContainerAPIEnvVarFLASK_DEBUG =  '1'
// param backendContainerAPIEnvVarDBUSER = 'github-secret-replaced-in-workflow'
// param backendContainerAPIEnvVarDBPASS =  'github-secret-replaced-in-workflow'
// param backendContainerAPIEnvVarDBHOST =  'devopps-dbsrv-uat.postgres.database.azure.com'
// param backendContainerAPIEnvVarDBNAME =  'devopps-db-uat'
// param backendContainerAPIEnvVarENV =  'uat'

//LAW
param logAnalyticsWorkspaceName = 'devopps-law-uat'
param logAnalyticsSkuName = 'PerGB2018'
param logAnalyticsRetentionDays = 30
param appInsightsName = 'appInsights-uat'
param appInsightsType = 'web'
param appInsightsRetentionDays = 365

//Container Registry

param containerRegistryName = 'DevoppsUatACR'

//Static WebApp

param staticWebAppName = 'devopps-swa-uat'

param keyVaultName = 'uat-keyvault'
param keyVaultSku = 'standard' 
