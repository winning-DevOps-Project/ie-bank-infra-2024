using '../main.bicep'

// param environmentType = 'nonprod'
// // posgtresql


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




param location = 'North Europe'

//KeyVault
param keyVaultName = 'devopps-kv-uat'
param keyVaultSku = 'standard' 
param enableSoftDelete = true
param keyVaultRoleAssignments  = [
{
    principalId: '25d8d697-c4a2-479f-96e0-15593a830ae5' // BCSAI2024-DEVOPS-STUDENTS-A-SP
    roleDefinitionIdOrName: 'Key Vault Secrets User'
    principalType: 'ServicePrincipal'
    }
]
// Container Registry
param containerRegistryName = 'DevoppsUatACR'

// postgresql server
param postgreSQLServerName = 'devopps-dbsrv-uat'


// postgresql server
param postgreSQLDatabaseName = 'devopps-db-uat'

// App service plan
param appServicePlanName = 'devopps-asp-uat'
param appServicePlanSku = 'B1'

// be 
param appServiceWebsiteBEName = 'devopps-be-uat' 
param dockerRegistryImageName = 'devopps-backend'
param dockerRegistryImageVersion = 'latest'
param appServiceBeAppSettings = [
  { name: 'ENV', value: 'uat' }
  { name: 'DBHOST', value: 'devopps-dbsrv-dev.postgres.database.azure.com' }
  { name: 'DBNAME', value: 'devopps-db-uat' }
  { name: 'DBUSER', value: 'devopps-be-uat' }
  { name: 'FLASK_DEBUG', value: '1' }
  { name: 'SCM_DO_BUILD_DURING_DEPLOYMENT', value: 'true' }
  ]

// Static Web App
param staticWebAppName = 'devopps-swa-uat'


// LAW
param logAnalyticsWorkspaceName = 'devopps-law-uat'
param logAnalyticsRetentionDays = 30
param logAnalyticsSkuName = 'PerGB2018'

// Insights
param appInsightsName = 'devopps-insights-uat'
param appInsightsType = 'web'
param appInsightsRetentionDays = 90
