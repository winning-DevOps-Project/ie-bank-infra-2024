using '../main.bicep'

param environmentType = 'nonprod'
param postgreSQLServerName = 'devopps-dbsrv-dev'
param postgreSQLDatabaseName = 'devopps-db-dev'
param appServicePlanName = 'devopps-asp-dev'
param appServiceAPIAppName = 'devopps-be-dev'
param appServiceAppName = 'devopps-fe-dev'
param location = 'North Europe'
param appServiceAPIDBHostFLASK_APP =  'iebank_api\\__init__.py'
param appServiceAPIDBHostFLASK_DEBUG =  '1'
param appServiceAPIDBHostDBUSER = 'github-secret-replaced-in-workflow'
param appServiceAPIEnvVarDBPASS =  'github-secret-replaced-in-workflow'
param appServiceAPIEnvVarDBHOST =  'devopps-dbsrv-dev.postgres.database.azure.com'
param appServiceAPIEnvVarDBNAME =  'devopps-db-dev'
param appServiceAPIEnvVarENV =  'dev'

// LAW
param logAnalyticsWorkspaceName = 'devopps-law-dev'
param logAnalyticsSkuName = 'Free'
param logAnalyticsRetentionDays = 30
