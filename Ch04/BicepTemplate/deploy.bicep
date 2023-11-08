
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'frontend-appserviceplan'
  location: 'westeurope'
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource appService 'Microsoft.Web/sites@2020-12-01' = {
  name: 'frontend-appservice-34543'
  location: 'westeurope'
  properties: {
    serverFarmId: appServicePlan.id
    virtualNetworkSubnetId: virtualNetwork.properties.subnets[0].id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '14.17.0'
        }
      ]
    }
  }
}

resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: 'frontend-appinsights-34543'
  location: 'westeurope'
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'app1-vnet'
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/20'
      ]
    }
    subnets: [
      {
        name: 'app1-subnet'
        properties: {
          addressPrefix: '10.10.1.0/24'
          delegations: [
            {
              name: 'app1-delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverfarms'
                actions: [
                  'Microsoft.Network/virtualNetworks/subnets/action'
                ]
              }
            }
          ]
        }
      }
      {
        name: 'db1-subnet'
        properties: {
          addressPrefix: '10.10.2.0/24'
        }
      }
    ]
  }
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'app1storageaccount4353'
  location: 'westeurope'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

output webAppUrl string = appService.properties.defaultHostName
