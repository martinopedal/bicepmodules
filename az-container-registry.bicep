param location string = 'swedencentral'
param registryName string 'myregistry'
param sku string = 'Premium'

@description('Deploy container registry with encryption enabled and keyvault integration')
resource acr 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: registryName
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: false
    anonymousPullEnabled: bool(false)  
    dataEndpointEnabled: bool(false)
    publicNetworkAccess: bool(false)
    encryption: {
      services: {
        blob: {
          enabled: bool(true)
          identity: {
            type: 'SystemAssigned'
          }
          keyVaultProperties: {
            keyVaultUri: 'https://mykeyvault.vault.azure.net'
          }
          networkruleBypassOptions:'string'
          networkruleset: {
            defaultAction: 'Deny'
            ipRules: [
              {
                action: 'Allow'
                value: 'string'
          
        }
        policies: [
          {
            azureadadauthenticationpolicy: {
              allowedaudienceuris: [
                'string'
              ]
              clientapplicationids: [
                'string'
              ]
              enabled: bool(true)
              tenantid: 'string'
            }
            quarantinepolicy: {
              enabled: bool(true)
              status: 'Enabled'
            }
            retentionpolicy: {
              days: int(0)
              enabled: bool(true)
              status: 'Enabled'
            }
            softdeletepolicy: {
              days: int(0)
              enabled: bool(true)
              status: 'Enabled'
            }
            trustpolicy: {
              type: 'Notary'
              status: 'Enabled'
            }
            zoneRedundancy: 'Enabled'
            publicnetworkaccess: bool(false)
          }
        ]
      }
    }
  }
}
