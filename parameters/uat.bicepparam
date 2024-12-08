using '../main.bicep'

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
param acrSku = 'Basic'

// postgresql server
param postgreSQLServerName = 'devopps-dbsrv-uat'
param SerskuName = 'Standard_B1ms'
param SerskuTier = 'Burstable'

// postgresql server
param postgreSQLDatabaseName = 'devopps-db-uat'

// App service plan
param appServicePlanName = 'devopps-asp-uat'
param appServicePlanSku = 'F1'

// be 
param appServiceWebsiteBEName = 'devopps-be-uat' 
param dockerRegistryImageName = 'devopps-backend'
param dockerRegistryImageVersion = 'latest'
param appServiceBeAppSettings = [
  { name: 'ENV', value: 'uat' }
  { name: 'DBHOST', value: 'devopps-dbsrv-uat.postgres.database.azure.com' }
  { name: 'DBNAME', value: 'devopps-db-uat' }
  { name: 'DBUSER', value: 'devopps-be-uat' }
  { name: 'FLASK_DEBUG', value: '1' }
  { name: 'SCM_DO_BUILD_DURING_DEPLOYMENT', value: 'true' }
  ]

// Static Web App
param staticWebAppName = 'devopps-swa-uat'
param swaSku = 'Standard'
 
// LAW
param logAnalyticsWorkspaceName = 'devopps-law-uat'
param logAnalyticsRetentionDays = 30
param logAnalyticsSkuName = 'PerGB2018'

// Insights
param appInsightsName = 'devopps-insights-uat'
param appInsightsType = 'web'
param appInsightsRetentionDays = 90


// alerts
param logicAppName = 'MyLogicApp'
param slackWebhookUrl = 'https://example.com/placeholder' // Placeholder value
