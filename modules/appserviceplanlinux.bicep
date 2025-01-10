targetScope = 'resourceGroup'

@description('Specifies the name of the app service plan.')
param appServicePlanName string

@description('Specifies the Azure location where the resource should be created.')
param location string = resourceGroup().location

@description('Specifies the SKU for the App Service Plan.')
param sku string

@description('Specifies tags for the resource.')
param tags object = {}

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
  tags: tags
}
