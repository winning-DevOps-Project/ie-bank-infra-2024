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
