metadata name = 'Key Vaults'
metadata description = 'This module deploys a Key Vault.'
metadata owner = 'Azure/module-maintainers'

// Parameters
@description('Required. Name of the Key Vault. Must be globally unique.')
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
param enableSoftDelete bool = false

@description('Specifies the SKU for the vault.')
param sku string = 'standard'

// @description('Optional. List of object IDs to grant Contributor access to the Key Vault.')
// param principalIds array = []

param roleAssignments array = []
var builtInRoleNames = {
  Reader: subscriptionResourceId( 'Microsoft.Authorization/roleDefinitions','f58310d9-a9f6-439a-9e8d-f62e7b41a168')
}

// Key Vault Resource
resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
  properties: {
    enabledForDeployment: enableVaultForDeployment
    enabledForTemplateDeployment: enableVaultForTemplateDeployment
    enableSoftDelete: enableSoftDelete
    enableRbacAuthorization: enableRbacAuthorization 
    sku: {
      name: sku
      family: 'A'
    }
    accessPolicies: []
    tenantId: subscription().tenantId
  }
}


resource keyVault_roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
for (roleAssignment, index) in (roleAssignments ?? []): {
  name: guid(keyVault.id, roleAssignment.principalId,roleAssignment.roleDefinitionIdOrName)
  properties: {
    roleDefinitionId:builtInRoleNames[?roleAssignment.roleDefinitionIdOrName] ?? roleAssignment.roleDefinitionIdOrName
    principalId: roleAssignment.principalId
    description: roleAssignment.?description
    principalType: roleAssignment.?principalType
    condition: roleAssignment.?condition
    conditionVersion: !empty(roleAssignment.?condition) ? (roleAssignment.?conditionVersion ?? '2.0') : null // Must only be set if condtion is set
    delegatedManagedIdentityResourceId: roleAssignment.?delegatedManagedIdentityResourceId
  }
  scope: keyVault
}
]

// // Add Contributor role assignments for specified object IDs
// resource keyVaultRoleAssignments 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = [
//   for (principalId, i) in principalIds: {
//     name: guid(keyVault.id, 'b24988ac-6180-42a0-ab88-20f7382dd24c', principalId)
//     properties: {
//       roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c') // Contributor Role
//       principalId: principalId
//     }
//     scope: keyVault
//   }
// ]

// Outputs
@description('The resource ID of the key vault.')
output resourceId string = keyVault.id

@description('The URI of the key vault.')
output uri string = keyVault.properties.vaultUri
