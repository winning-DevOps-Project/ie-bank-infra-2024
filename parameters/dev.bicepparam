using '../main.bicep'


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
param acrSku  = 'Basic'

// postgresql server
param postgreSQLServerName = 'devopps-dbsrv-dev'
param SerskuName  = 'Standard_B1ms'
param SerskuTier = 'Burstable'

// postgresql db
param postgreSQLDatabaseName = 'devopps-db-dev'


// App service plan
param appServicePlanName = 'devopps-asp-dev'
param appServicePlanSku = 'F1'
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
param swaSku = 'Free'

// LAW
param logAnalyticsWorkspaceName = 'devopps-law-dev'
param logAnalyticsRetentionDays = 30
param logAnalyticsSkuName = 'PerGB2018'

// Insights
param appInsightsName = 'devopps-insights-dev'
param appInsightsType = 'web'
param appInsightsRetentionDays = 90

// alerts
param logicAppName = 'MyLogicApp'
param slackWebhookUrl = 'https://example.com/placeholder' // Placeholder value



