metadata description = 'Creates an Azure App Service plan.'
param name string
param location string = resourceGroup().location
param tags object = {}

param kind string = ''
param reserved bool = true
param sku object

param maxElasticWorkerCount int = 1

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  tags: tags
  sku: sku
  kind: kind
  properties: {
    reserved: reserved
    maximumElasticWorkerCount: maxElasticWorkerCount
  }
}

output id string = appServicePlan.id
output name string = appServicePlan.name
