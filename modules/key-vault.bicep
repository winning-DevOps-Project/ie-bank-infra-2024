metadata name = 'Key Vaults'
metadata description = 'This module deploys a Key Vault.'
metadata owner = 'Azure/module-maintainers'

// Parameters
@description('Required. Name of the Key Vault. Must be globally unique.')
@maxLength(24)
param name string

@description('Enable RBAC authorization for Key Vault (default: true).')
param enableRbacAuthorization bool = true

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


@description('Optional. List of object IDs to grant Contributor access to the Key Vault.')
param principalIds array = []

// Key Vault Resource
resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    enabledForDeployment: enableVaultForDeployment
    enabledForTemplateDeployment: enableVaultForTemplateDeployment
    enableSoftDelete: enableSoftDelete
    enableRbacAuthorization: enableRbacAuthorization 
    tenantId: subscription().tenantId
    sku: {
      name: sku
      family: 'A'
    }
  }
}

// Add Contributor role assignments for specified object IDs
resource keyVaultRoleAssignments 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = [
  for (principalId, i) in principalIds: {
    name: guid(keyVault.id, 'b24988ac-6180-42a0-ab88-20f7382dd24c', principalId)
    properties: {
      roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c') // Contributor Role
      principalId: principalId
    }
    scope: keyVault
  }
]

// Outputs
@description('The resource ID of the key vault.')
output resourceId string = keyVault.id

@description('The URI of the key vault.')
output uri string = keyVault.properties.vaultUri
