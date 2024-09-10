@description('The Azure region/location for deployment.')
param location string = resourceGroup().location

@description('The allowed environment types are: Dev, Test, and Prod.')
@allowed([
  'Dev'
  'Test'
  'Prod'
])
param environmentType string

@description('A unique suffix for resource names that requires a global uniqueness.')
@minLength(3)
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

var appServicePlanName = 'demo-website-${resourceNameSuffix}'

@description('Configurations based on SKUs and the environment type.')
var environmentConfigurationMap = {
  Dev: {
    appServicePlan: {
      sku: {
        name: 'F1'
      }
    }
  }
  Prod: {
    appServicePlan: {
      sku: {
        name: 'S1'
        capacity: 1
      }
    }
  }
  Test: {
    appServicePlan: {
      sku: {
        name: 'F1'
      }
    }
  }
}

@description('Application Service Plan for the web app.')
resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: appServicePlanName
  location: location
  sku: environmentConfigurationMap[environmentType].appServicePlan.sku
}
