@description('App Insights Resource ID')
param appInsightsId string


@description('Action Group Resource ID')
param actionGroupId string

@description('Key Vault Resource ID')
param keyVaultId string

@description('PostgreSQL Server Resource ID')
param postgreSQLServerId string

@description('Alert rule for page load time exceeding 7 seconds')
resource pageLoadTimeAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'Page-Load-Time-Alert'
  location: 'global'
  properties: {
    description: 'Alert when page load time exceeds 7 seconds'
    severity: 4
    enabled: true
    scopes: [
      appInsightsId
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'PageLoadTime'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'browserTimings/totalDuration'
          operator: 'GreaterThan'
          threshold: 7000
          timeAggregation: 'Average'
        }
      ]
    }
    autoMitigate: true
    actions: [
      {
        actionGroupId: actionGroupId
        webHookProperties: {
          customMessage: 'Page load time exceeded the threshold of 7 seconds. Please take action immediately.'
        }
      }
    ]
  }
}



@description('Alert rule for Key Vault availability below 99%')
resource keyVaultAvailabilityAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'KeyVault-Availability-Alert'
  location: 'global'
  properties: {
    description: 'Alert when Key Vault availability drops below 99%'
    severity: 1
    enabled: true
    scopes: [
      keyVaultId
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'KeyVaultAvailability'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'Availability'
          operator: 'LessThan'
          threshold: 99
          timeAggregation: 'Average'
        }
      ]
    }
    autoMitigate: true
    actions: [
      {
        actionGroupId: actionGroupId
        webHookProperties: {
          customMessage: 'Key Vault availability has dropped below 99%. Immediate attention required.'
        }
      }
    ]
  }
}

@description('Alert rule for PostgreSQL free memory below 5GB')
resource postgresqlMemoryAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'PostgreSQL-Memory-Alert'
  location: 'global'
  properties: {
    description: 'Alert when PostgreSQL free memory drops below 5GB'
    severity: 2
    enabled: true
    scopes: [
      postgreSQLServerId
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'PostgreSQLMemory'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'memory_percent'
          operator: 'GreaterThan'
          threshold: 90  // Alert when memory usage is above 90% (meaning less than 5% free)
          timeAggregation: 'Average'
        }
      ]
    }
    autoMitigate: true
    actions: [
      {
        actionGroupId: actionGroupId
        webHookProperties: {
          customMessage: 'PostgreSQL server free memory has dropped below 5GB. Please check database usage and optimize queries if needed.'
        }
      }
    ]
  }
}
