<#
Code snippet for the chapter 4 of the book "Infrastructure Management with Azure Bicep"
by Kasun Rajapakse and Elkhan Yusubov
#>

# Login to Azure

Login-AzAccount

# Select Azure Subscription

Set-AzContext -SubscriptionId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# Create Resource Group

New-AzResourceGroup -Name "rg-app1" -Location "West Europe"

# Deploy ARM Template

New-AzResourceGroupDeployment -ResourceGroupName "rg-app1" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"

################################
# Install Azure Bicep
################################

# Install Azure Bicep via PowerShell

Install-Module -Name Az.Bicep -Scope CurrentUser -Force

# Convert ARM Template to Bicep



