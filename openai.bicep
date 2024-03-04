param location string = 'norwayeast'
param resourceGroupName string = 'OpenAI test'
param openAiServiceName string = 'myOpenAiService'
param subnetId string = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}'
param privateEndpointId string = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}'

resource openAiService 'Microsoft.CognitiveServices/accounts@2021-03-01-preview' = {
  name: openAiServiceName
  location: location
  kind: 'TextAnalytics'
  sku: {
    name: 'S0'
  }
  properties: {
    publicNetworkAccess: 'Disabled'
    networkAcls: {
      defaultAction: 'Deny'
      virtualNetworkRules: [
        {
          id: subnetId
          ignoreMissingVNetServiceEndpoint: false
        }
      ]
    }
    privateEndpointConnections: [
      {
        name: 'privateEndpointConnection1'
        properties: {
          privateEndpoint: {
            id: privateEndpointId
          }
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Private endpoint connection approved'
          }
        }
      }
    ]
  }
}

output openAiServiceEndpoint string = openAiService.properties.endpoint
