@description('The name of the PostgreSQL server')
param postgreSQLServerName string
@description('The location for the PostgreSQL server')
param location string
// // Optional: Define admin credentials for server
// param administratorLogin string = 'iebankdbadmin'
// @secure()
// param administratorLoginPassword string
param postgreSQLAdminServicePrincipalObjectId string
param postgreSQLAdminServicePrincipalName string

resource postgresSQLServer 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
  name: postgreSQLServerName
  location: location
  sku: {
    name: 'Standard_B1ms'
    tier: 'Burstable'
  }
  properties: {
    // administratorLogin: administratorLogin
    // administratorLoginPassword: administratorLoginPassword
    createMode: 'Default'
    highAvailability: {
      mode: 'Disabled'
      standbyAvailabilityZone: ''
    }
    storage: {
      storageSizeGB: 32
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    version: '15'
    authConfig: { activeDirectoryAuth: 'Enabled', passwordAuth: 'Enabled', tenantId: subscription().tenantId }
}
  }


// Firewall rule to allow Azure services
resource firewallRule 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2022-12-01' = {
  name: 'AllowAllAzureServicesAndResourcesWithinAzureIps'
  parent: postgresSQLServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource postgreSQLAdministrators 'administrators@2022-12-01' = {
  name: postgreSQLAdminServicePrincipalObjectId
  properties: {
  principalName: postgreSQLAdminServicePrincipalName
  principalType: 'ServicePrincipal'
  tenantId: subscription().tenantId
  }
  dependsOn: [
    firewallRule
  ]
  }
  

// Outputs
output id string = postgresSQLServer.id
output postgreSQLServerName string = postgresSQLServer.name
// output postgreSQLServerAdmin string = administratorLogin
 