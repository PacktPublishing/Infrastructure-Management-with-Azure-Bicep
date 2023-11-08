# Login to Azure

Login-AzAccount

# Select Azure Subscription

Set-AzContext -Subscription ''

# Create resource group

New-AzResourceGroup -Name "rg-app1" -Location "West Europe"

# Deploy Bicep Template

New-AzResourceGroupDeployment -ResourceGroupName "rg-app1" -TemplateFile "deploy.bicep"