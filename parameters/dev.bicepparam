using '../main.bicep'

// param environmentType = 'nonprod'
param location = 'North Europe'

// // posgtresql
// param postgreSQLServerName = 'devopps-dbsrv-dev'
// param postgreSQLDatabaseName = 'devopps-db-dev'

// // app service plan
// param appServicePlanName = 'devopps-asp-dev'
// param appServicePlanSku = 'B1'

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

// LAW
// param logAnalyticsWorkspaceName = 'devopps-law-dev'
// param logAnalyticsSkuName = 'Free' 
// param logAnalyticsRetentionDays = 30

// //Insights
// param appInsightsName = 'appInsights-dev'
// param appInsightsType = 'web'
// param appInsightsRetentionDays = 365

//KeyVault
param keyVaultName = 'devopps-keyvault-dev'
param keyVaultSku = 'standard' 

// //static website
// param staticWebAppName = 'devopps-swa-dev'

// // Container Registry
// param containerRegistryName = 'DevoppsDevACR'
