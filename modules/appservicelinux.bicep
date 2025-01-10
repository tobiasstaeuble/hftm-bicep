targetScope='resourceGroup'

@description('Specifies the name of the App Service.')
param appServiceName string

@description('Specifies the Azure location where the resource should be created.')
param location string = resourceGroup().location

@description('Specifies the linux runtime version.')
param linuxFxVersion string

@description('Specifies the name of the existing App Service Plan the App Service is created on.')
param appServicePlanName string

@description('Specifies tags for the resource.')
param tags object = {}

// reference existing App Service Plan by name
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' existing = {
  name: appServicePlanName
}

resource appService 'Microsoft.Web/sites@2024-04-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
  tags: tags
}

