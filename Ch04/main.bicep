/*
Code snippet for the chapter 4 of the book "Infrastructure Management with Azure Bicep"
by Kasun Rajapakse and Elkhan Yusubov
*/


// Create a Virtual Network and a Storage Account
resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: 'vnetbicepch02'
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
      }
    }
  }

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'stazbicepch02'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
