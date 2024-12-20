param location string = resourceGroup().location
param appServicePlanName string
@allowed([
'B1'
'F1'
])
param sku string

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output id string = appServicePlan.id
output name string = appServicePlanName
// This module is for creating an App Service Plan that hosts web apps.
 