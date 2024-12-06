@description('App Insights Resource ID')
param appInsightsId string
@description('App Service Resource ID')
param appServiceApp string

@description('Action Group Resource ID')
param actionGroupId string

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

@description('Alert rule for CPU usage exceeding 80%')
resource cpuUsageAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'CPU-Usage-Alert'
  location: 'global'
  properties: {
    description: 'Alert when CPU usage exceeds 80%'
    severity: 3
    enabled: true
    scopes: [
      appServiceApp
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'CpuUsage'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'CPU Time'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
        }
      ]
    }
    autoMitigate: true
    actions: [
      {
        actionGroupId: actionGroupId
        webHookProperties: {
          customMessage: 'CPU usage exceeded the threshold of 80%. Immediate action is required.'
        }
      }
    ]
  }
}
