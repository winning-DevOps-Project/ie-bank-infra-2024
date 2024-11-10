metadata name = 'Key Vaults'
metadata description = 'This module deploys a Key Vault.'
metadata owner = 'Azure/module-maintainers'

// Parameters
@description('Required. Name of the Key Vault. Must be globally unique.')
@maxLength(24)
param name string

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Specifies if the vault is enabled for deployment by script or compute.')
param enableVaultForDeployment bool = true

@description('Specifies if the vault is enabled for a template deployment.')
param enableVaultForTemplateDeployment bool = true

@description('Enable Key Vault\'s soft delete feature.')
param enableSoftDelete bool = true

@description('Specifies the SKU for the vault.')
@allowed([
  'premium'
  'standard'
])
param sku string = 'standard'

@description('Optional. Resource tags.')
param tags object?

// Key Vault Resource
resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    enabledForDeployment: enableVaultForDeployment
    enabledForTemplateDeployment: enableVaultForTemplateDeployment
    enableSoftDelete: enableSoftDelete
    tenantId: subscription().tenantId
    sku: {
      name: sku
      family: 'A'
    }
  }
}

// Outputs
@description('The resource ID of the key vault.')
output resourceId string = keyVault.id

@description('The URI of the key vault.')
output uri string = keyVault.properties.vaultUri
