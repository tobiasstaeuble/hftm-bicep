@description('Specifies the name of the key vault.')
param keyVaultName string

@description('Specifies the name of the secret that you want to create.')
param secretName string

@description('Specifies the value of the secret that you want to create.')
@secure()
param secretValue string

@description('Specifies tags for the resource.')
param tags object = {}

// reference existing keyvault by name
resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: kv
  name: secretName
  tags: tags
  properties: {
    value: secretValue
  }
}
