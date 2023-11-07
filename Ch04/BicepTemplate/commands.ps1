
# Create resource group

New-AzResourceGroup -Name "rg-app1" -Location "West Europe"

# Deploy Bicep Template

New-AzResourceGroupDeployment -ResourceGroupName "rg-app1" -TemplateFile "deploy.bicep"