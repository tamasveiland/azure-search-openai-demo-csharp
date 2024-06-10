@description('Location of the private endpoint.')
param location string

@description('Name of the private endpoint.')
param privateEndpointName string

@description('Resource ID of the subnet where the private endpoint will be created.')
param subnetId string

@description('ID of the Private Link Service.')
param privateLinkServiceID string

@description('Resource ID of the private DNS zone.')
param privateDnsZoneId string

@description('Tags of the private endpoint.')
param tags object


resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: privateEndpointName
  location: location
  tags: tags
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: privateEndpointName
        properties: {
          privateLinkServiceId: privateLinkServiceID
          groupIds: [
            'sqlServer'
          ]
        }
      }
    ]
  }
}

resource pvtEndpointDnsGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-05-01' = {
  parent: privateEndpoint
  name: 'config1'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZoneId
        }
      }
    ]
  }
}
