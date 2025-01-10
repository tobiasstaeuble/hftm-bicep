targetScope = 'subscription'

/* to reference an existing resource group:
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'example-rg'
}
*/

// use a parameters file to provide values for these parameters
param location string = ''
param globalTags object = {}
param resourceGroupName string = ''
param keyVaultName string = ''
param sqlServerName string = ''
param sqlDbName string = ''
param userObjectId string = '00000000-0000-0000-0000-000000000000'
param sqlServerLogin string = ''
param appServicePlanName string = ''
param appServicePlanSku string = ''
param appServiceName string = ''
param appServiceLinuxFxVersion string = ''
param appServiceWindowsFxVersion string = ''

@secure()
param sqlServerPassword string = ''

module rg './modules/resourcegroup.bicep' = {
  name: resourceGroupName
  scope: subscription()
  params: {
    location: location
    name: resourceGroupName
    tags: globalTags
  }
}

module appserviceplanwindows './modules/appserviceplanwindows.bicep' = {
  name: appServicePlanName
  scope: resourceGroup(rg.name)
  params: {
    appServicePlanName: appServicePlanName
    location: 'northeurope'
    sku: appServicePlanSku
    tags: globalTags
  }
}

module appservicewindows './modules/appservicewindows.bicep' = {
  name: appServiceName
  scope: resourceGroup(rg.name)
  params: {
    appServiceName: appServiceName
    location: 'northeurope'
    windowsFxVersion: appServiceWindowsFxVersion
    appServicePlanName: appserviceplanwindows.name
    tags: globalTags
  }
}

module keyvault './modules/keyvault.bicep' = {
  name: keyVaultName
  scope: resourceGroup(rg.name)
  params: {
    keyVaultName: keyVaultName
    location: location
    tenantId: subscription().tenantId
    objectId: userObjectId
    secretsPermissions: [
      //'list', 'get'
      'all'
    ]
    tags: globalTags
  }
}

module sqlserver './modules/sqlserver.bicep' = {
  name: sqlServerName
  scope: resourceGroup(rg.name)
  params: {
    sqlServerName: sqlServerName
    location: location
    sqlServerLogin: sqlServerLogin
    sqlServerPassword: sqlServerPassword
    tags: globalTags
  }
}

module sqldatabase './modules/sqldatabase.bicep' = {
  name: sqlDbName
  scope: resourceGroup(rg.name)
  params: {
    sqlDatabaseName: sqlDbName
    sqlServerName: sqlserver.name
    location: location
    tags: globalTags
  }
}
