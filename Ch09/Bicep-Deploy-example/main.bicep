targetScope = 'resourceGroup'

@description('Resource Location for the deployment')
param resourceLocation string = 'westeurope'

@description('Resource environment for the deployment')
param environment string

@description('Resource prefix')
param resourcePrefix string

@description('App Service Plan tier')
param appServicePlanTier string 

@description('App Service Plan size')
param appServicePlanSize string

@description('App service plan Family')
param appServicePlanFamily string

@description('SQL Server Admin Username')
@secure()
param sqlAdminUserName string

@description('SQL Server Admin Password')
@secure()
param sqlAdminPassword string

module serverfarm 'br/public:avm/res/web/serverfarm:0.1.1' = {
  name: '${uniqueString(deployment().name, resourceLocation)}-test-wsfmin'
  params: {
    // Required parameters
    name: 'appfarm-${resourcePrefix}-${environment}'
    sku: {
      capacity: 3
      family: appServicePlanFamily
      name: appServicePlanSize
      size: appServicePlanSize
      tier: appServicePlanTier
    }
    // Non-required parameters
    location: resourceLocation
  }
}

module site 'br/public:avm/res/web/site:0.3.1' = {
  name: '${uniqueString(deployment().name, resourceLocation)}-test-wsfamin'
  params: {
    // Required parameters
    kind: 'app'
    name: 'app-${resourcePrefix}-${environment}'
    serverFarmResourceId: serverfarm.outputs.resourceId
    // Non-required parameters
    location: resourceLocation
    siteConfig: {
      alwaysOn: true
    }
  }
}


module server 'br/public:avm/res/sql/server:0.2.0' = {
  name: '${uniqueString(deployment().name, resourceLocation)}-test-ssmin'
  params: {
    // Required parameters
    name: 'sqlsvr-${resourcePrefix}-${environment}'
    // Non-required parameters
    administratorLogin: sqlAdminUserName
    administratorLoginPassword: sqlAdminPassword
    location: resourceLocation
    databases: [
      {
        createMode: 'Default'
        maxSizeBytes: 2147483648
        name: 'app1'
        skuName: 'Basic'
        skuTier: 'Basic'
      }
    ]
  }
}


