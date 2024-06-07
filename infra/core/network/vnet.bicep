@description('Name of the virtual network')
param virtualNetworkName string

@description('Location of the virtual network')
param location string

@description('Name of the subnet')
param subnetName string = 'privateEndpointSubnet'

@description('Tags for the virtual network')
param tags object = {}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: virtualNetworkName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}
