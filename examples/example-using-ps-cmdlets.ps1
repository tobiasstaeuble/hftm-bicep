# Install-Module -Scope CurrentUser -Name Az -AllowClobber
Import-Module Az

$tenantId = ""
$subscriptionId = ""
$userPrincipalName = ""

# interactive login
Connect-AzAccount -Tenant $tenantId -Subscription $subscriptionId

# determine user
$AzADUser = Get-AzADUser -UserPrincipalName $userPrincipalName

# create resource group
New-AzResourceGroup -Name example-rg -Location switzerlandnorth

# deploy bicep template to create key vault
New-AzResourceGroupDeployment -ResourceGroupName example-rg -TemplateFile ./keyvault.bicep -keyVaultName "test-vault1" -objectId $AzADUser.Id

