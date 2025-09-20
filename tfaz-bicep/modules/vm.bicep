param vm object
param location string
param tags object = {}
param subnetId string
param nsgId string

resource pipAddressResource 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: '${vm.name}-pip'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
    idleTimeoutInMinutes: 4
  }
}

resource netIntResource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: '${vm.name}-nic'
  tags: tags
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig01'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pipAddressResource.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

resource virtualMachineResource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vm.name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vm.size
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        name: '${vm.name}-osdisk'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      imageReference: vm.imageReference
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: netIntResource.id
        }
      ]
    }
    osProfile: {
      computerName: vm.name
      adminUsername: vm.adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${vm.adminUsername}/.ssh/authorized_keys'
              keyData: vm.sshPublicKey
            }
          ]
        }
      }
    }
  }
}
