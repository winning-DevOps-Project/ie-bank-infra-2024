using '../main.bicep'

param environmentType = 'nonprod'
param postgreSQLServerName = 'devopps-dbsrv-uat'
param postgreSQLDatabaseName = 'devopps-db-uat'
param appServicePlanName = 'devopps-asp-uat'
param appServiceAPIAppName = 'devopps-be-uat'
param appServiceAppName = 'devopps-fe-uat'
param location = 'North Europe'
param appServiceAPIDBHostFLASK_APP =  'iebank_api\\__init__.py'
param appServiceAPIDBHostFLASK_DEBUG =  '1'
param appServiceAPIDBHostDBUSER = 'github-secret-replaced-in-workflow'
param appServiceAPIEnvVarDBPASS =  'github-secret-replaced-in-workflow'
param appServiceAPIEnvVarDBHOST =  'devopps-dbsrv-uat.postgres.database.azure.com'
param appServiceAPIEnvVarDBNAME =  'devopps-db-uat'
param appServiceAPIEnvVarENV =  'uat'

//LAW
param logAnalyticsWorkspaceName = 'devopps-law-uat'
param logAnalyticsSkuName = 'Free'
param logAnalyticsRetentionDays = 30
param appInsightsName = 'appInsights-uat'
param appInsightsType = 'web'
param appInsightsRetentionDays = 365
