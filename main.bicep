// @sys.description('The environment type (nonprod or prod)')
// param environmentType string = 'nonprod'
// @sys.description('The PostgreSQL Server name')
// param postgreSQLServerName string = 'ie-bank-db-server-dev'
// @sys.description('The PostgreSQL Database name')
// param postgreSQLDatabaseName string = 'ie-bank-db'
// @sys.description('The App Service Plan name')
// param appServicePlanName string = 'ie-bank-app-sp-dev'
// @sys.description('The App Service Plan SKU')
// param appServicePlanSku string


@sys.description('The Azure location where the resources will be deployed')
param location string = resourceGroup().location
// Key Vault
@description('The Key Vault name')
param keyVaultName string
@description('The Key Vault SKU')
param keyVaultSku string
@sys.description('The role assignments for the Key Vault')
param keyVaultRoleAssignments array = [
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
// Azure Container Registry SKU
@sys.description('The Azure Container Registry SKU')
param acrSku string = 'Standard'
@sys.description('The Azure Container Registry name')
param containerRegistryName string
@description('The resource ID of the key vault.')

param adminUsernameSecretName string 
param adminPasswordSecretName0 string
param adminPasswordSecretName1 string

@description('The PostgreSQL Server name')
param postgreSQLServerName string = 'devopps-dbsrv-dev'
param administratorLogin string = 'iebankdbadmin'
@secure()
param administratorLoginPassword string
@description('The PostgreSQL Database name')
param postgreSQLDatabaseName string  = 'devopps-db-dev'

// param appServiceBackendName string = 'backend-service' // Name of the backend app
// param backendDockerImageName string = 'backend-image'
// param backendDockerImageVersion string = 'latest'

// // App Settings (environment variables)
// param backendAppSettings array = []


// // Frontend repository details for Static Web App
// @sys.description('Frontend repository URL')
// param frontendRepositoryUrl string
// @sys.description('Frontend repository branch')
// param frontendRepositoryBranch string = 'main'
// @sys.description('Frontend repository personal access token')
// @secure()
// param frontendRepositoryToken string = ''
// @sys.description('The name of the Static Web App')
// param staticWebAppName string


// // Log Analytics and App Insights configurations
// @sys.description('Name of the Log Analytics workspace')
// param logAnalyticsWorkspaceName string
// @sys.description('SKU for the Log Analytics workspace')
// param logAnalyticsSkuName string 
// @sys.description('Retention period for data in Log Analytics workspace')
// param logAnalyticsRetentionDays int 
// @description('The Application Insights name')
// param appInsightsName string
// @description('The Application Insights application type')
// param appInsightsType string 
// @description('The retention period for Application Insights in days')
// param appInsightsRetentionDays int




module keyVault 'modules/key-vault.bicep' = {
  name: keyVaultName
  params: {
    name: keyVaultName
    location: location
    sku: keyVaultSku
    roleAssignments: keyVaultRoleAssignments
    enableVaultForDeployment: true
  }
}


module containerRegistry 'modules/docker-registry.bicep' = {
  name: containerRegistryName 
  params: {
    keyVaultResourceId: keyVault.outputs.resourceId
    keyVaultSecreNameAdminUsername: adminUsernameSecretName
    keyVaultSecreNameAdminPassword0: adminPasswordSecretName0
    keyVaultSecreNameAdminPassword1: adminPasswordSecretName1
    registryName: containerRegistryName
    location: location
    sku: acrSku
  }
  dependsOn: [
    keyVault 
  ]  
}

module postgresSQLServer 'modules/postgresql-server.bicep' = {
  name: postgreSQLServerName
  params: {
    location: location
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    postgreSQLServerName: postgreSQLServerName
  }
}

module postgresDb 'modules/postgresql-db.bicep' = {
  name: postgreSQLDatabaseName 
  params: {
    postgreSQLDatabaseName: postgreSQLDatabaseName
    serverName: postgresSQLServer.outputs.postgreSQLServerName 
  }
  dependsOn: [
    postgresSQLServer
  ]
}

// // Log Analytics Workspace and Application Insights
// module logAnalytics 'modules/log-analytics.bicep' = {
//   name: logAnalyticsWorkspaceName
//   params: {
//     name: logAnalyticsWorkspaceName
//     location: location
//     skuName: logAnalyticsSkuName
//     dataRetention: logAnalyticsRetentionDays
//     publicNetworkAccessForIngestion: 'Enabled'
//     publicNetworkAccessForQuery: 'Enabled'
//     tags: {
//       Environment: environmentType
//       Project: 'IE Bank'
//     }
//   }
// }

// module appInsights 'modules/app-insights.bicep' = {
//   name: appInsightsName
//   params: {
//     name: appInsightsName
//     applicationType: appInsightsType
//     workspaceResourceId: logAnalytics.outputs.logAnalyticsWorkspaceId 
//     retentionInDays: appInsightsRetentionDays
//     location: location
//     tags: {
//       Environment: environmentType
//       Project: 'IE Bank'
//     }
//   }
// }

// module appServicePlan 'modules/app-service-plan.bicep' = {
//   name: appServicePlanName
//   params: {
//     location: location
//     appServicePlanName: appServicePlanName
//     sku: appServicePlanSku
//   }
// }


// module appServiceBackend 'modules/app-service.bicep' = {
//   name: 'appServiceBackend-deployment'
//   params: {
//     location: location
//     name: appServiceBackendName
//     appServicePlanId: appServicePlan.outputs.id
//     dockerRegistryName: containerRegistryName
//     dockerRegistryServerUserName: containerRegistry.outputs.adminUsername
//     dockerRegistryServerPassword: containerRegistry.outputs.adminPassword
//     dockerRegistryImageName: backendDockerImageName
//     dockerRegistryImageVersion: backendDockerImageVersion
//     appSettings: backendAppSettings
//     appCommandLine: ''
//     // keyVaultUri: keyVault.outputs.keyVaultUri // Optional
//     // databasePasswordKey: 'databasePassword' // Optional
//   }
//   dependsOn: [
//     appServicePlan
//     containerRegistry
//     keyVault // Optional
//   ]
// }


// module staticWebApp 'modules/static-web-app.bicep' = {
//   name: staticWebAppName
//   params: {
//     name: staticWebAppName
//     sku: 'Free'
//     location: 'westeurope'
//     repositoryToken: frontendRepositoryToken
//     repositoryUrl: frontendRepositoryUrl
//     branch: frontendRepositoryBranch
//   }
// }


// output keyVaultUri string = keyVault.outputs.keyVaultUri
// // Outputs for PostgreSQL
// output postgreSQLServerName string = postgresDb.outputs.postgreSQLServerName
// output postgreSQLDatabaseName string = postgresDb.outputs.postgreSQLDatabaseName
// output postgreSQLServerAdmin string = postgresDb.outputs.postgreSQLServerAdmin
