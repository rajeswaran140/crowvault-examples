// orders-service — Azure Container App
// Region: eastus · Image: ghcr.io/acme/orders-service:1.0.0
param location string = 'eastus'

resource laws 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'orders-service-laws'
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
  }
}

resource env 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: 'orders-service-env'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: laws.properties.customerId
        sharedKey: laws.listKeys().primarySharedKey
      }
    }
  }
}

resource app 'Microsoft.App/containerApps@2024-03-01' = {
  name: 'orders-service'
  location: location
  identity: { type: 'SystemAssigned' }
  properties: {
    managedEnvironmentId: env.id
    configuration: {
      ingress: {
        external: true
        targetPort: 3000
        transport: 'auto'
        traffic: [{ latestRevision: true, weight: 100 }]
        corsPolicy: {
          allowedOrigins: ['*']
          allowedMethods: ['GET','POST','PUT','DELETE','OPTIONS']
        }
      }
    }
    template: {
      containers: [
        {
          name: 'orders-service'
          image: 'ghcr.io/acme/orders-service:1.0.0'
          resources: { cpu: json('0.5'), memory: '1Gi' }
          probes: [
            { type: 'Liveness',  httpGet: { path: '/health', port: 3000 } }
            { type: 'Readiness', httpGet: { path: '/health', port: 3000 } }
          ]
        }
      ]
      scale: {
        minReplicas: 0
        maxReplicas: 5
        rules: [
          {
            name: 'http-scale'
            http: { metadata: { concurrentRequests: '50' } }
          }
        ]
      }
    }
  }
}

output appFqdn string = app.properties.configuration.ingress.fqdn
output principalId string = app.identity.principalId
