param vnet object
param location string
param tags object = {}

resource virtualNetworkResource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: vnet.name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet.addressPrefix
      ]
    }
    subnets: [{
      name: vnet.subnetName
      properties: {
        addressPrefix: vnet.subnetAddressPrefix
      }
    }]
  }
}

resource nsgResource 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: '${vnet.name}-nsg-01'
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
    ]
  }
}

output subnetId string = virtualNetworkResource.properties.subnets[0].id
output nsgId string = nsgResource.id
