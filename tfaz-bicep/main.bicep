targetScope = 'subscription'

param resourceGroupNEParam string
param tagsParam object
param vnetParam object
param vmParam object

param deploymentNameParam string = 'agentpool'

module resourceGroupNE 'modules/rg.bicep' = {
  name: '${deploymentNameParam}-resourceGroup'
  params: {
    resourceGroup: resourceGroupNEParam
    tags: tagsParam
  }
}

module virtualNetwork 'modules/vnet.bicep' = {
  name: '${deploymentNameParam}-virtual-network'
  scope: resourceGroup(resourceGroupNEParam.name)
  params: {
    location: resourceGroupNEParam.location
    vnet: vnetParam
    tags: tagsParam
  }
  dependsOn: [
    resourceGroupNE
  ]
}

