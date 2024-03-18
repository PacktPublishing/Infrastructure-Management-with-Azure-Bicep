@description('Location for all resources.')
param location string = 'westeurope'

resource innovateStart_appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'innovateStart-appServicePlan'
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
  tags: {
    displayName: 'innovateStart-appServicePlan'
  }
  properties: {
    name: 'innovateStart-appServicePlan'
  }
}

resource frontend_app_432425 'Microsoft.Web/sites@2016-08-01' = {
  name: 'frontend-app-432425'
  location: location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/innovateStart-appServicePlan': 'Resource'
    displayName: 'frontend-app-432425'
  }
  properties: {
    name: 'frontend-app-432425'
    serverFarmId: innovateStart_appServicePlan.id
  }
}

resource app1_vnet 'Microsoft.Network/virtualNetworks@2018-08-01' = {
  name: 'app1-vnet'
  location: location
  tags: {
    displayName: 'app-vnet'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.100.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'app-subnet'
        properties: {
          addressPrefix: '10.100.0.0/24'
        }
      }
      {
        name: 'db-subnet'
        properties: {
          addressPrefix: '10.100.1.0/24'
        }
      }
    ]
  }
}

output frontend_app object = frontend_app_432425.properties
output app_vnet object = app1_vnet.properties
