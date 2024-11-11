@description('Name of the static web app')
param name string
@allowed([
  'prod'
  'nonprod'
])
@description('The service tier')
param sku string = 'nonprod'
@description('Location of the resource')
param location string = resourceGroup().location
@secure()
@description('GitHub repository personal access token')
param repositoryToken string
@description('GitHub repository URL')
param repositoryUrl string
@description('Branch to deploy from')
param branch string
@description('Static web app build properties')
param buildProperties object = {
  appLocation: 'frontend'
  outputLocation: 'build'
}

resource staticSite 'Microsoft.Web/staticSites@2021-03-01' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  properties: {
    repositoryUrl: repositoryUrl
    branch: branch
    repositoryToken: repositoryToken
    buildProperties: buildProperties
  }
}

output defaultHostname string = staticSite.properties.defaultHostname
