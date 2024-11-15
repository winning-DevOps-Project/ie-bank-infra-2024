@description('The API App name')
param appServiceAPIAppName string

@description('The App Service Plan ID')
param appServicePlanId string

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
param appServiceAPIDBHostDBUSER string

@description('The value for the environment variable FLASK_APP')
param appServiceAPIDBHostFLASK_APP string

@description('The value for the environment variable FLASK_DEBUG')
param appServiceAPIDBHostFLASK_DEBUG string

resource appServiceAPIApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAPIAppName
  location: resourceGroup().location
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: '' // Empty when using container
      alwaysOn: true
      ftpsState: 'FtpsOnly'
      appSettings: [
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
          value: appServiceAPIDBHostDBUSER
        }
        {
          name: 'FLASK_APP'
          value: appServiceAPIDBHostFLASK_APP
        }
        {
          name: 'FLASK_DEBUG'
          value: appServiceAPIDBHostFLASK_DEBUG
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: containerRegistryLoginServer
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: containerRegistryUsername
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: containerRegistryPassword
        }
      ]
      containerSettings: {
        imageName: '${containerRegistryLoginServer}/${containerImageName}:${containerImageTag}'
        registryCredentials: {
          password: containerRegistryPassword
          username: containerRegistryUsername
        }
      }
    }
  }
}

// Output to expose the hostname for the API app
output appServiceAppHostName string = appServiceAPIApp.properties.defaultHostName
