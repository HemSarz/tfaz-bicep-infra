targetScope = 'subscription'

param resourceGroupNEParam object
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

module virtualMachine 'modules/vm.bicep' = {
  name: '${deploymentNameParam}-virtual-machine'
  scope: resourceGroup(resourceGroupNEParam.name)
  params: {
    location: resourceGroupNEParam.location
    vm: vmParam
    subnetId: virtualNetwork.outputs.subnetId
    nsgId: virtualNetwork.outputs.nsgId
    tags: tagsParam
  }
}
