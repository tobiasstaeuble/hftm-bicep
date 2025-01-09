targetScope = 'resourceGroup'

@description('Specifies the name of the SQL server.')
param sqlServerName string

@description('Specifies the Azure location where the resource should be created.')
param location string = resourceGroup().location

@description('Specifies the administrator login name for the SQL server.')
param sqlServerLogin string

@description('Specifies the administrator login password for the SQL server.')
@secure()
param sqlServerPassword string

@description('Specifies tags for the resource.')
param tags object = {}

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  tags: tags
  properties: {
    administratorLogin: sqlServerLogin
    administratorLoginPassword: sqlServerPassword
  }
}
