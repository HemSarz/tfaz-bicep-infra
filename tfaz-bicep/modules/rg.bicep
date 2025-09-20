targetScope = 'subscription'

param resourceGroup object
param tags object = {}

resource resourceGroupresource 'Microsoft.Resources/resourceGroups@2025-04-01' = {
name: resourceGroup.name
location: resourceGroup.location
tags: tags
}
