@description('Name of the Action Group')
param actionGroupName string

@description('Logic App Endpoint URI')
param logicAppEndpointUri string

resource actionGroup 'Microsoft.Insights/actionGroups@2022-06-01' = {
  name: actionGroupName
  location: resourceGroup().location
  properties: {
    enabled: true
    groupShortName: 'AlertGrp'
    webhookReceivers: [
      {
        name: 'LogicAppWebhook'
        serviceUri: logicAppEndpointUri
      }
    ]
  }
}

output actionGroupId string = actionGroup.id
