using '../main.bicep'

param location = 'switzerlandnorth'
param resourceGroupName = 'spoke-pa-rg'
param appServicePlanName = 'spoke-pa-asp'
param appServicePlanSku = 'B1'
param appServiceName = 'spoke-pa-app'
param appServiceLinuxFxVersion = 'DOTNETCORE:8.0'
// ...
