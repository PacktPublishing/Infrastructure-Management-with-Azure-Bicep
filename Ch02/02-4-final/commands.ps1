# Login Azure via PowerShell

Login-AzAccount

# Select Azure Subscription

Select-AzSubscription -Subscription "<SubName>"

# Create Resource Group 

New-AzResourceGroup -Name arm-template-rg -Location 'West Europe' 

# Provision ARM templates

New-AzResourceGroupDeployment -Name arm-deploy -ResourceGroupName arm-template-rg -Mode Incremental -TemplateParameterFile .\02-4-final\azuredeploy.parameters.json -TemplateFile .\02-4-final\azuredeploy.json -Verbose