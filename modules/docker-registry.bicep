@description('Name of the Azure Container Registry')
param registryName string
@description('Location of the Azure Container Registry')
param location string = resourceGroup().location
@description('SKU for the Azure Container Registry')
param sku string 
param keyVaultResourceId string
#disable-next-line secure-secrets-in-params
param keyVaultSecreNameAdminUsername string
#disable-next-line secure-secrets-in-params
param keyVaultSecreNameAdminPassword0 string
#disable-next-line secure-secrets-in-params
param keyVaultSecreNameAdminPassword1 string
@description('Log Analytics Workspace Resource ID for diagnostic settings')
param workspaceResourceId string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: registryName
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: true
  }
}

// #disable-next-line outputs-should-not-contain-secrets
// output registryLoginServer string = containerRegistry.properties.loginServer

// // Retrieve the admin credentials using the resource reference syntax
// #disable-next-line outputs-should-not-contain-secrets
// var credentials = containerRegistry.listCredentials()

// // Suppress the outputs warning for secrets
// #disable-next-line outputs-should-not-contain-secrets
// output adminUsername string = credentials.username
// #disable-next-line outputs-should-not-contain-secrets
// output adminPassword string = credentials.passwords[0].value



resource adminCredentialsKeyVault 'Microsoft.KeyVault/vaults@2021-10-01' existing = if (!empty(keyVaultResourceId)) {
  name: last(split((!empty(keyVaultResourceId) ? keyVaultResourceId : 'dummyVault'), '/'))!
}

// create a secret to store the container registry admin username
resource secretAdminUserName 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = if (!empty(keyVaultSecreNameAdminUsername)) {
  name: !empty(keyVaultSecreNameAdminUsername) ? keyVaultSecreNameAdminUsername : 'dummySecret'
  parent: adminCredentialsKeyVault
  properties: {
    value: containerRegistry.listCredentials().username
}
}
// create a secret to store the container registry admin password 0
resource secretAdminUserPassword0 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = if (!empty(keyVaultSecreNameAdminPassword0)) {
  name: !empty(keyVaultSecreNameAdminPassword0) ? keyVaultSecreNameAdminPassword0 : 'dummySecret'
  parent: adminCredentialsKeyVault
  properties: {
    value: containerRegistry.listCredentials().passwords[0].value
}
}
// create a secret to store the container registry admin password 1
resource secretAdminUserPassword1 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = if (!empty(keyVaultSecreNameAdminPassword1)) {
  name: !empty(keyVaultSecreNameAdminPassword1) ? keyVaultSecreNameAdminPassword1 : 'dummySecret'
  parent: adminCredentialsKeyVault
  properties: {
    value: containerRegistry.listCredentials().passwords[1].value
}
}


resource acrDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'ContainerRegistryDiagnostic'
  scope: containerRegistry
  properties: {
    workspaceId: workspaceResourceId
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        category: 'ContainerRegistryLoginEvents'  
        enabled: true
      }
      {
        category: 'ContainerRegistryRepositoryEvents'  
        enabled: true
      }
    ]
  }
}

output registryLoginServer string = containerRegistry.properties.loginServer
