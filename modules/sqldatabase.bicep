targetScope='resourceGroup'

@description('Specifies the name of the SQL database.')
param sqlDatabaseName string

@description('Specifies the name of the SQL server.')
param sqlServerName string

@description('Specifies the Azure location where the resource should be created.')
param location string = resourceGroup().location

@description('Specifies tags for the resource.')
param tags object = {}

// reference existing server by name
resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' existing = {
  name: sqlServerName
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  tags: tags
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
