using '../main.bicep'

// param environmentType = 'nonprod'


// // app service
// // param appServiceAppName = 'devopps-be-dev' // Name of the backend app
// // param appServiceWebsiteBeAppSettings = [
// //   { name: 'ENV', value: 'dev' }
// //   { name: 'DBHOST', value: 'aguadamillas-dbsrv-dev.postgres.database.azure.com' }
// //   { name: 'DBNAME', value: 'aguadamillas-db-dev' }
// //   { name: 'DBPASS', value: 'IE.Bank.DB.Admin.Pa$$' }
// //   { name: 'DBUSER', value: 'iebankdbadmin' }
// //   { name: 'FLASK_DEBUG', value: '1' }
// //   { name: 'SCM_DO_BUILD_DURING_DEPLOYMENT', value: 'true' }

// //7- app service - containerized be 
// // App Service Backend Parameters for Dev
// param appServiceBackendName = 'devopps-be-dev' // Name of the backend App Service
// param backendDockerImageName = 'devopps-backend' // Docker image name
// param backendDockerImageVersion = 'latest' // Docker image version
// param backendAppSettings = [
//   { name: 'ENV', value: 'dev' }
//   { name: 'DBHOST', value: 'devopps-dbsrv-dev.postgres.database.azure.com' } // PostgreSQL FQDN
//   { name: 'DBNAME', value: 'devopps-db-dev' } // Database name
//   { name: 'DBUSER', value: 'iebankdbadmin' } // Database user
//   { name: 'DEFAULT_ADMIN_USERNAME', value: 'devoppsuser' } // Admin username
// ]

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


param location = 'North Europe'

//KeyVault
param keyVaultName = 'devopps-kv-dev'
param keyVaultSku = 'standard' 
param enableSoftDelete  = false
param keyVaultRoleAssignments = [
  {
    principalId: '25d8d697-c4a2-479f-96e0-15593a830ae5' // BCSAI2024-DEVOPS-STUDENTS-A-SP
    roleDefinitionIdOrName: 'Key Vault Secrets User'
    principalType: 'ServicePrincipal'
    }
    {
      principalId: 'a03130df-486f-46ea-9d5c-70522fe056de' // BCSAI2024-DEVOPS-STUDENTS-A
      roleDefinitionIdOrName: 'Key Vault Administrator'
      principalType: 'Group'
      }
]

// Container Registry
param containerRegistryName = 'DevoppsDevACR'

// postgresql server
param postgreSQLServerName = 'devopps-dbsrv-dev'

// postgresql db
param postgreSQLDatabaseName = 'devopps-db-dev'


// App service plan
param appServicePlanName = 'devopps-asp-dev'
param appServicePlanSku = 'B1'
param appServiceWebsiteBEName = 'devopps-be-dev'
param dockerRegistryImageName = 'devopps-backend'
param dockerRegistryImageVersion = 'latest'
param appServiceBeAppSettings = [
  { name: 'ENV', value: 'dev' }
  { name: 'DBHOST', value: 'devopps-dbsrv-dev.postgres.database.azure.com' }
  { name: 'DBNAME', value: 'devopps-db-dev' }
  { name: 'DBUSER', value: 'devopps-be-dev' }
  { name: 'FLASK_DEBUG', value: '1' }
  { name: 'SCM_DO_BUILD_DURING_DEPLOYMENT', value: 'true' }
  ]

// Static Web App
param staticWebAppName = 'devopps-swa-dev'

// LAW
param logAnalyticsWorkspaceName = 'devopps-law-dev'
param logAnalyticsRetentionDays = 30
param logAnalyticsSkuName = 'PerGB2018'

// Insights
param appInsightsName = 'devopps-insights-dev'
param appInsightsType = 'web'
param appInsightsRetentionDays = 90


param logicAppName = 'MyLogicApp'
param slackWebhookUrl = 'https://example.com/placeholder' // Placeholder value



