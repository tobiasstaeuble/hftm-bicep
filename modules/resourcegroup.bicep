targetScope='subscription'

@description('Specifies the Azure location where the resource should be created.')
param location string

@description('Specifies the name of the resource group.')
param name string

@description('Specifies tags for the resource.')
param tags object = {}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: name
  tags: tags
  location: location
}

output location string = resourceGroup.location
output resourceId string = resourceGroup.id
