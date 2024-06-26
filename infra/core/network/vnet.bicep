@description('Name of the virtual network')
param virtualNetworkName string

@description('Location of the virtual network')
param location string

@description('Name of the subnet')
param subnet0Name string = 'privateEndpointSubnet'

@description('Name of the subnet')
param subnet1Name string = 'acaSubnet'

@description('Name of the subnet')
param subnet2Name string = 'functionSubnet'

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
        name: subnet0Name
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
      {
        name: subnet1Name
        properties: {
          addressPrefix: '10.0.3.0/24'
          delegations: [
            {
              name: 'aca_environments'
              properties: {
                serviceName: 'Microsoft.App/environments'
              }
            }
          ]
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: '10.0.4.0/24'
          delegations: [
            {
              name: 'function_delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
    ]
  }

  // resource functionSubnet 'subnets' existing = {
  //   name: subnet2Name
  // }

}

output virtualNetworkId string = virtualNetwork.id
output subnet0Id string = virtualNetwork.properties.subnets[0].id
output subnet1Id string = virtualNetwork.properties.subnets[1].id
output subnet2Id string = virtualNetwork.properties.subnets[2].id
