@description('Name of the Azure Container Registry')
param registryName string
@description('Location of the Azure Container Registry')
param location string = resourceGroup().location
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
@description('SKU for the Azure Container Registry')
param sku string = 'Standard'

@description('Resource ID of the Key Vault to store secrets.')
param keyVaultResourceId string

@description('Name of the Key Vault secret for the admin username.')
param keyVaultSecretNameAdminUsername string = 'containerRegistryAdminUsername'

@description('Name of the Key Vault secret for the admin password.')
param keyVaultSecretNameAdminPassword string = 'containerRegistryAdminPassword'

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

resource adminCredentialsKeyVault 'Microsoft.KeyVault/vaults@2021-10-01' existing = {
  name: last(split(keyVaultResourceId, '/'))
}


resource secretAdminUsername 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: keyVaultSecretNameAdminUsername
  parent: adminCredentialsKeyVault
  properties: {
    value: containerRegistry.listCredentials().username
  }
}

resource secretAdminPassword 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: keyVaultSecretNameAdminPassword
  parent: adminCredentialsKeyVault
  properties: {
    value: containerRegistry.listCredentials().passwords[0].value
  }
}


// output adminUsernameSecretUri string = secretAdminUsername.properties.secretUri
// output adminPasswordSecretUri string = secretAdminPassword.properties.secretUri

#disable-next-line outputs-should-not-contain-secrets
output registryLoginServer string = containerRegistry.properties.loginServer

// Retrieve the admin credentials using the resource reference syntax
#disable-next-line outputs-should-not-contain-secrets
var credentials = containerRegistry.listCredentials()

// Suppress the outputs warning for secrets
#disable-next-line outputs-should-not-contain-secrets
output adminUsername string = credentials.username
#disable-next-line outputs-should-not-contain-secrets
output adminPassword string = credentials.passwords[0].value
