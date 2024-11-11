@description('The name of the container group')
param containerGroupName string

@description('Location of the Azure Container Registry')
param location string = resourceGroup().location

@description('The container registry login server')
param containerRegistryLoginServer string

@description('The container registry username')
param containerRegistryUsername string

@description('The container registry password')
@secure()
param containerRegistryPassword string

@description('The name of the Docker image to pull')
param containerImageName string

@description('The tag of the Docker image to pull')
param containerImageTag string = 'latest'

@description('The value for the environment variable ENV')
param appServiceAPIEnvVarENV string

@description('The value for the environment variable DBHOST')
param appServiceAPIEnvVarDBHOST string

@description('The value for the environment variable DBNAME')
param appServiceAPIEnvVarDBNAME string

@description('The value for the environment variable DBPASS')
@secure()
param appServiceAPIEnvVarDBPASS string

@description('The value for the environment variable DBUSER')
param appServiceAPIEnvVarDBUSER string

@description('The value for the environment variable FLASK_APP')
param appServiceAPIEnvVarFLASK_APP string

@description('The value for the environment variable FLASK_DEBUG')
param appServiceAPIEnvVarFLASK_DEBUG string

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2021-03-01' = {
  name: containerGroupName
  location: location
  properties: {
    osType: 'Linux'
    containers: [
      {
        name: containerGroupName
        properties: {
          image: '${containerRegistryLoginServer}/${containerImageName}:${containerImageTag}'
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 1
            }
          }
          environmentVariables: [
            {
              name: 'ENV'
              value: appServiceAPIEnvVarENV
            }
            {
              name: 'DBHOST'
              value: appServiceAPIEnvVarDBHOST
            }
            {
              name: 'DBNAME'
              value: appServiceAPIEnvVarDBNAME
            }
            {
              name: 'DBPASS'
              value: appServiceAPIEnvVarDBPASS
            }
            {
              name: 'DBUSER'
              value: appServiceAPIEnvVarDBUSER
            }
            {
              name: 'FLASK_APP'
              value: appServiceAPIEnvVarFLASK_APP
            }
            {
              name: 'FLASK_DEBUG'
              value: appServiceAPIEnvVarFLASK_DEBUG
            }
          ]
        }
      }
    ]
    imageRegistryCredentials: [
      {
        server: containerRegistryLoginServer
        username: containerRegistryUsername
        password: containerRegistryPassword
      }
    ]
    restartPolicy: 'Always'
  }
}

// Output to expose the IP address of the container instance
output containerGroupIPAddress string = containerGroup.properties.ipAddress.ip
