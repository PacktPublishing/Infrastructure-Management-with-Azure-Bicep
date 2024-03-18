using './main.bicep'

param resourceLocation = 'westus'
param environment = 'dev'
param resourcePrefix = 'app1'
param appServicePlanTier = 'Basic'
param appServicePlanSize = 'B1'
param appServicePlanFamily = 'B'
param sqlAdminPassword = 'P@ssw0rd1234'
param sqlAdminUserName = 'sqladmin'

