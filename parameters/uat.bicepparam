using '../main.bicep'

// param environmentType = 'nonprod'
// // posgtresql

// // app service plan
// param appServicePlanName = 'devopps-asp-uat'

// // app service
// param appServiceBackendName = 'devopps-be-uat' // Name of the backend App Service
// param backendDockerImageName = 'devopps-backend' // Docker image name
// param backendDockerImageVersion = 'latest' // Docker image version
// param backendAppSettings = [
//   { name: 'ENV', value: 'uat' }
//   { name: 'DBHOST', value: 'devopps-dbsrv-uat.postgres.database.azure.com' } // PostgreSQL FQDN
//   { name: 'DBNAME', value: 'devopps-db-uat' } // Database name
//   { name: 'DBUSER', value: 'iebankdbadmin' } // Database user
//   { name: 'DEFAULT_ADMIN_USERNAME', value: 'devoppsuser' } // Admin username
// ]
// param appServiceAPIAppName = 'devopps-be-uat'
// param appServiceAPIDBHostFLASK_APP =  'iebank_api\\__init__.py'
// param appServiceAPIDBHostFLASK_DEBUG =  '1'
// param appServiceAPIDBHostDBUSER = 'github-secret-replaced-in-workflow'
// param appServiceAPIEnvVarDBPASS =  'github-secret-replaced-in-workflow'
// param appServiceAPIEnvVarDBHOST =  'devopps-dbsrv-uat.postgres.database.azure.com'
// param appServiceAPIEnvVarDBNAME =  'devopps-db-uat'
// param appServiceAPIEnvVarENV =  'uat'

// //LAW
// param logAnalyticsWorkspaceName = 'devopps-law-uat'
// param logAnalyticsSkuName = 'PerGB2018'
// param logAnalyticsRetentionDays = 30

// //Insights
// param appInsightsName = 'appInsights-uat'
// param appInsightsType = 'web'
// param appInsightsRetentionDays = 365

// //static website
// param staticWebAppName = 'devopps-swa-uat'


param location = 'North Europe'

//KeyVault
param keyVaultName = 'devopps-kv-uat'
param keyVaultSku = 'standard' 
param enableSoftDelete = true

// Container Registry
param containerRegistryName = 'DevoppsUatACR'
param adminPasswordSecretName0 = 'adminPasswordSecretName0'
param adminPasswordSecretName1 = 'adminPasswordSecretName1'
param adminUsernameSecretName = 'adminUsernameSecretName'


// postgresql server
param postgreSQLServerName = 'devopps-dbsrv-uat'
param administratorLogin = 'iebankdbadmin'
param administratorLoginPassword = '' 

// postgresql server
param postgreSQLDatabaseName = 'devopps-db-uat'
