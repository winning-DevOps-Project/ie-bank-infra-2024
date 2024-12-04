using '../main.bicep'

param location = 'North Europe'

//KeyVault
param keyVaultName = 'devopps-kv-prod'
param keyVaultSku = 'standard' 
param enableSoftDelete  = true
param keyVaultRoleAssignments = [
  {
    principalId: '25d8d697-c4a2-479f-96e0-15593a830ae5' // BCSAI2024-DEVOPS-STUDENTS-A-SP
    roleDefinitionIdOrName: 'Key Vault Secrets User'
    principalType: 'ServicePrincipal'
    }
]

// Container Registry
param containerRegistryName = 'DevoppsProdACR'
param acrSku = 'Standard'

// postgresql server
param postgreSQLServerName = 'devopps-dbsrv-prod'
param SerskuName  = 'Standard_B1ms'
param SerskuTier = 'Burstable'

// postgresql db
param postgreSQLDatabaseName = 'devopps-db-prod'


// App service plan
param appServicePlanName = 'devopps-asp-prod'
param appServicePlanSku = 'B1'
param appServiceWebsiteBEName = 'devopps-be-prod'
param dockerRegistryImageName = 'devopps-backend'
param dockerRegistryImageVersion = 'latest'
param appServiceBeAppSettings = [
  { name: 'ENV', value: 'prod' }
  { name: 'DBHOST', value: 'devopps-dbsrv-dev.postgres.database.azure.com' }
  { name: 'DBNAME', value: 'devopps-db-prod' }
  { name: 'DBUSER', value: 'devopps-be-prod' }
  { name: 'FLASK_DEBUG', value: '1' }
  { name: 'SCM_DO_BUILD_DURING_DEPLOYMENT', value: 'true' }
  ]

// Static Web App
param staticWebAppName = 'devopps-swa-prod'
param swaSku = 'Standard'
// LAW
param logAnalyticsWorkspaceName = 'devopps-law-prod'
param logAnalyticsRetentionDays = 30
param logAnalyticsSkuName = 'Standard'

// Insights
param appInsightsName = 'devopps-insights-prod'
param appInsightsType = 'web'
param appInsightsRetentionDays = 90
 