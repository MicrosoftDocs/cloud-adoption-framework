---
title: Abbreviation examples for Azure resources
description: Abbreviation examples for Azure resources
author: stephen-sumner
ms.author: ssumner
ms.date: 4/12/2023
ms.reviewer: ssumner
ms.topic: conceptual
ms.custom: internal, readiness, fasttrack-edit
---

# Abbreviation examples for Azure resources

This page gives you abbreviation examples for many of the resources in Azure. The following table has *abbreviations* mapped to *resource* and *resource provider namespace*.

**Azure Naming Tool:** You can use the Azure Naming Tool to standardize and automate your naming process. For more information, see [Azure Naming Tool Overview](https://github.com/mspnp/AzureNamingTool).

<!-- cSpell:ignoreRegExp `[a-z]+-?` -->
<!-- cspell:ignoreRegExp [_\*][a-z]+[\\-] -->

## AI + machine learning

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Azure Cognitive Search | `Microsoft.Search/searchServices` | `srch` |
| Azure Cognitive Services | `Microsoft.CognitiveServices/accounts` | `cog` |
| Azure Machine Learning workspace | `Microsoft.MachineLearningServices/workspaces` | `mlw` |

## Analytics and IoT

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Azure Analysis Services server | `Microsoft.AnalysisServices/servers` | `as` |
| Azure Databricks workspace | `Microsoft.Databricks/workspaces` | `dbw` |
| Azure Data Explorer cluster | `Microsoft.Kusto/clusters` | `dec` |
| Azure Data Explorer cluster database | `Microsoft.Kusto/clusters/databases` | `dedb` |
| Azure Data Factory | `Microsoft.DataFactory/factories` | `adf` |
| Azure Digital Twin instance | `Microsoft.DigitalTwins/digitalTwinsInstances` | `dt` |
| Azure Stream Analytics | `Microsoft.StreamAnalytics/cluster` | `asa` |
| Azure Synapse Analytics Workspaces | `Microsoft.Synapse/workspaces` | `synw` |
| Azure Synapse Analytics SQL Dedicated Pool | `Microsoft.Synapse/workspaces/sqlPools` | `syndp` |
| Azure Synapse Analytics Spark Pool | `Microsoft.Synapse/workspaces/bigDataPools` | `synsp` |
| Data Lake Store account | `Microsoft.DataLakeStore/accounts` | `dls` |
| Data Lake Analytics account | `Microsoft.DataLakeAnalytics/accounts` | `dla` |
| Event Hubs namespace | `Microsoft.EventHub/namespaces` | `evhns` |
| Event hub | `Microsoft.EventHub/namespaces/eventHubs` | `evh` |
| Event Grid domain | `Microsoft.EventGrid/domains` | `evgd` |
| Event Grid subscriptions | `Microsoft.EventGrid/eventSubscriptions` | `evgs` |
| Event Grid topic | `Microsoft.EventGrid/domains/topics` | `evgt` |
| Event Grid system topic | `Microsoft.EventGrid/systemTopics` | `egst` |
| HDInsight - Hadoop cluster | `Microsoft.HDInsight/clusters` | `hadoop` |
| HDInsight - HBase cluster | `Microsoft.HDInsight/clusters` | `hbase` |
| HDInsight - Kafka cluster | `Microsoft.HDInsight/clusters` | `kafka` |
| HDInsight - Spark cluster | `Microsoft.HDInsight/clusters` | `spark` |
| HDInsight - Storm cluster | `Microsoft.HDInsight/clusters` | `storm` |
| HDInsight - ML Services cluster | `Microsoft.HDInsight/clusters` | `mls` |
| IoT hub | `Microsoft.Devices/IotHubs` | `iot` |
| Provisioning services | `Microsoft.Devices/provisioningServices` | `provs` |
| Provisioning services certificate | `Microsoft.Devices/provisioningServices/certificates` | `pcert` |
| Power BI Embedded | `Microsoft.PowerBIDedicated/capacities` | `pbi` |
| Time Series Insights environment | `Microsoft.TimeSeriesInsights/environments` | `tsi` |

## Compute and Web

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| App Service environment | `Microsoft.Web/hostingEnvironments` | `ase` |
| App Service plan | `Microsoft.Web/serverFarms` | `asp` |
| Azure Load Testing instance | `Microsoft.LoadTestService/loadTests` | `lt` |
| Availability set | `Microsoft.Compute/availabilitySets` | `avail` |
| Azure Arc enabled server | `Microsoft.HybridCompute/machines` | `arcs` |
| Azure Arc enabled Kubernetes cluster | `Microsoft.Kubernetes/connectedClusters` | `arck` |
| Batch accounts | `Microsoft.Batch/batchAccounts` | `ba` |
| Cloud service | `Microsoft.Compute/cloudServices` | `cld` |
| Communication Services | `Microsoft.Communication/communicationServices` | `acs` |
| Disk encryption set | `Microsoft.Compute/diskEncryptionSets` | `des` |
| Function app | `Microsoft.Web/sites` | `func` |
| Gallery | `Microsoft.Compute/galleries` | `gal` |
| Hosting environment | `Microsoft.Web/hostingEnvironments` | `host` |
| Image template | `Microsoft.VirtualMachineImages/imageTemplates` | `it` |
| Managed disk (OS) | `Microsoft.Compute/disks` | `osdisk` |
| Managed disk (data) | `Microsoft.Compute/disks` | `disk` |
| Notification Hubs | `Microsoft.NotificationHubs/namespaces/notificationHubs` | `ntf` |
| Notification Hubs namespace | `Microsoft.NotificationHubs/namespaces` | `ntfns` |
| Proximity placement group | `Microsoft.Compute/proximityPlacementGroups` | `ppg` |
| Snapshot | `Microsoft.Compute/snapshots` | `snap` |
| Static web app | `Microsoft.Web/staticSites` | `stapp` |
| Virtual machine | `Microsoft.Compute/virtualMachines` | `vm` |
| Virtual machine scale set | `Microsoft.Compute/virtualMachineScaleSets` | `vmss` |
| Virtual machine maintenance configuration | `Microsoft.Maintenance/maintenanceConfigurations` | `mc`
| VM storage account | `Microsoft.Storage/storageAccounts` | `stvm` |
| Web app | `Microsoft.Web/sites` | `app` |

## Containers

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| AKS cluster | `Microsoft.ContainerService/managedClusters` | `aks` |
| Container apps | `Microsoft.App/containerApps` | `ca` |
| Container apps environment | `Microsoft.App/managedEnvironments` | `cae` |
| Container registry | `Microsoft.ContainerRegistry/registries` | `cr` |
| Container instance | `Microsoft.ContainerInstance/containerGroups` | `ci` |
| Service Fabric cluster | `Microsoft.ServiceFabric/clusters` | `sf` |
| Service Fabric managed cluster | `Microsoft.ServiceFabric/managedClusters` | `sfmc` |

## Databases

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Azure Cosmos DB database | `Microsoft.DocumentDB/databaseAccounts/sqlDatabases` | `cosmos` |
| Azure Cosmos DB for Apache Cassandra account | `Microsoft.DocumentDB/databaseAccounts` | `coscas`|
| Azure Cosmos DB for MongoDB account | `Microsoft.DocumentDB/databaseAccounts` | `cosmon`|
| Azure Cosmos DB for NoSQL account | `Microsoft.DocumentDb/databaseAccounts` | `cosno`|
| Azure Cosmos DB for Table account | `Microsoft.DocumentDb/databaseAccounts` |`costab`|
| Azure Cosmos DB for Apache Gremlin account | `Microsoft.DocumentDb/databaseAccounts` | `cosgrm`|
| Azure Cosmos DB PostgreSQL cluster | `Microsoft.DBforPostgreSQL/serverGroupsv2` | `cospos`|
| Azure Cache for Redis instance | `Microsoft.Cache/Redis` | `redis` |
| Azure SQL Database server | `Microsoft.Sql/servers` | `sql` |
| Azure SQL database | `Microsoft.Sql/servers/databases` | `sqldb` |
| Azure SQL Elastic Job agent | `Microsoft.Sql/servers/jobAgents` | `sqlja` |
| Azure SQL Elastic Pool | `Microsoft.Sql/servers/elasticpool` | `sqlep` |
| MariaDB server | `Microsoft.DBforMariaDB/servers` | `maria` |
| MariaDB database | `Microsoft.DBforMariaDB/servers/databases` | `mariadb` |
| MySQL database | `Microsoft.DBforMySQL/servers` | `mysql` |
| PostgreSQL database | `Microsoft.DBforPostgreSQL/servers` | `psql` |
| SQL Server Stretch Database | `Microsoft.Sql/servers/databases` | `sqlstrdb` |
| SQL Managed Instance | `Microsoft.Sql/managedInstances` | `sqlmi` |

## Developer tools

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| App Configuration store | `Microsoft.AppConfiguration/configurationStores` | `appcs` |
| Maps account | `Microsoft.Maps/accounts` | `map` |
| SignalR | `Microsoft.SignalRService/SignalR` | `sigr` |
| WebPubSub | `Microsoft.SignalRService/webPubSub` | `wps` |

## DevOps

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Azure Managed Grafana | `Microsoft.Dashboard/grafana` | `amg` |

## Integration

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| API management service instance | `Microsoft.ApiManagement/service` | `apim` |
| Integration account | `Microsoft.Logic/integrationAccounts` | `ia` |
| Logic apps | `Microsoft.Logic/workflows` | `logic` |
| Service Bus namespace | `Microsoft.ServiceBus/namespaces` | `sbns` |
| Service Bus queue | `Microsoft.ServiceBus/namespaces/queues` | `sbq` |
| Service Bus topic | `Microsoft.ServiceBus/namespaces/topics` | `sbt` |
| Service Bus topic subscription | `Microsoft.ServiceBus/namespaces/topics/subscriptions` | `sbts` |

## Management and governance

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Automation account | `Microsoft.Automation/automationAccounts` | `aa` |
| Azure Policy definition | `Microsoft.Authorization/policyDefinitions` | <*descriptive*> |
| Application Insights | `Microsoft.Insights/components` | `appi` |
| Azure Monitor action group | `Microsoft.Insights/actionGroups` | `ag` |
| Azure Monitor data collection rules | `Microsoft.Insights/dataCollectionRules` | `dcr` |
| Blueprint | `Microsoft.Blueprint/blueprints` | `bp` |
| Blueprint assignment | `Microsoft.Blueprint/blueprints/artifacts` | `bpa` |
| Log Analytics workspace | `Microsoft.OperationalInsights/workspaces` | `log` |
| Log Analytics query packs | `Microsoft.OperationalInsights/querypacks` | `pack` |
| Management group | `Microsoft.Management/managementGroups` | `mg` |
| Microsoft Purview instance | `Microsoft.Purview/accounts` | `pview` |
| Resource group | `Microsoft.Resources/resourceGroups` | `rg` |
| Template specs name | `Microsoft.Resources/templateSpecs` | `ts` |

## Migration

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Azure Migrate project | `Microsoft.Migrate/assessmentProjects` | `migr` |
| Database Migration Service instance | `Microsoft.DataMigration/services` | `dms` |
| Recovery Services vault | `Microsoft.RecoveryServices/vaults` | `rsv` |

## Networking

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Application gateway | `Microsoft.Network/applicationGateways` | `agw` |
| Application security group (ASG) | `Microsoft.Network/applicationSecurityGroups` | `asg` |
| CDN profile | `Microsoft.Cdn/profiles` | `cdnp` |
| CDN endpoint | `Microsoft.Cdn/profiles/endpoints` | `cdne` |
| Connections | `Microsoft.Network/connections`| `con` |
| DNS | `Microsoft.Network/dnsZones` | \<*DNS domain name*> |
| DNS private resolver | `Microsoft.Network/dnsResolvers` | `dnspr` |
| DNS private resolver inbound endpoint | `Microsoft.Network/dnsResolvers/inboundEndpoints` | `in` |
| DNS private resolver outbound endpoint | `Microsoft.Network/dnsResolvers/outboundEndpoints` | `out` |
| DNS zone | `Microsoft.Network/privateDnsZones` | \<*DNS domain name*> |
| Firewall | `Microsoft.Network/azureFirewalls` | `afw` |
| Firewall policy | `Microsoft.Network/firewallPolicies` | `afwp` |
| ExpressRoute circuit | `Microsoft.Network/expressRouteCircuits` | `erc` |
| Front Door (Standard/Premium) profile | `Microsoft.Cdn/profiles` | `afd` |
| Front Door (Standard/Premium) endpoint | `Microsoft.Cdn/profiles/afdEndpoints` | `fde` |
| Front Door firewall policy | `Microsoft.Network/frontdoorWebApplicationFirewallPolicies` | `fdfp`|
| Front Door (classic) | `Microsoft.Network/frontDoors` | `afd` |
| Load balancer (internal) | `Microsoft.Network/loadBalancers` | `lbi`|
| Load balancer (external) | `Microsoft.Network/loadBalancers` | `lbe`|
| Load balancer rule | `Microsoft.Network/loadBalancers/inboundNatRules` | `rule`|
| Local network gateway | `Microsoft.Network/localNetworkGateways` | `lgw` |
| NAT gateway | `Microsoft.Network/natGateways` | `ng` |
| Network interface (NIC) | `Microsoft.Network/networkInterfaces` | `nic`|
| Network security group (NSG) | `Microsoft.Network/networkSecurityGroups` | `nsg` |
| Network security group (NSG) security rules | `Microsoft.Network/networkSecurityGroups/securityRules` | `nsgsr` |
| Network Watcher | `Microsoft.Network/networkWatchers` | `nw` |
| Private Link | `Microsoft.Network/privateLinkServices` | `pl` |
| Private endpoint | `Microsoft.Network/privateEndpoints` | `pep` |
| Public IP address | `Microsoft.Network/publicIPAddresses` | `pip`|
| Public IP address prefix | `Microsoft.Network/publicIPPrefixes` | `ippre`|
| Route filter | `Microsoft.Network/routeFilters` | `rf` |
| Route server | `Microsoft.Network/virtualHubs` | `rtserv` |
| Route table | `Microsoft.Network/routeTables` | `rt` |
| Service endpoint policy | `Microsoft.serviceEndPointPolicies` | `se` |
| Traffic Manager profile | `Microsoft.Network/trafficManagerProfiles` | `traf` |
| User defined route (UDR) | `Microsoft.Network/routeTables/routes` | `udr` |
| Virtual network | `Microsoft.Network/virtualNetworks` | `vnet`|
| Virtual network gateway | `Microsoft.Network/virtualNetworkGateways` | `vgw` |
| Virtual network manager | `Microsoft.Network/networkManagers` | `vnm`|
| Virtual network peering | `Microsoft.Network/virtualNetworks/virtualNetworkPeerings` | `peer`|
| Virtual network subnet | `Microsoft.Network/virtualNetworks/subnets` | `snet`|
| Virtual WAN | `Microsoft.Network/virtualWans` | `vwan`|
| Virtual WAN Hub | `Microsoft.Network/virtualHubs` | `vhub`|


## Security

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Azure Bastion | `Microsoft.Network/bastionHosts` | `bas` |
| Key vault | `Microsoft.KeyVault/vaults` | `kv` |
| Key Vault Managed HSM | `Microsoft.KeyVault/managedHSMs` | `kvmhsm` |
| Managed identity | `Microsoft.ManagedIdentity/userAssignedIdentities` | `id` |
| VPN Gateway| `Microsoft.Network/vpnGateways` | `vpng`|
| VPN connection | `Microsoft.Network/vpnGateways/vpnConnections` | `vcn` |
| VPN site | `Microsoft.Network/vpnGateways/vpnSites` | `vst` |
| Web Application Firewall (WAF) policy | `Microsoft.Network/firewallPolicies` | `waf` |
| Web Application Firewall (WAF) policy rule group | `Microsoft.Network/firewallPolicies/ruleGroups` | `wafrg` |

## Storage

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Azure StorSimple | `Microsoft.StorSimple/managers` | `ssimp` |
| Backup Vault name | `Microsoft.DataProtection/backupVaults` | `bvault` |
| Backup Vault policy | `Microsoft.DataProtection/backupVaults/backupPolicies` | `bkpol` |
| File share | `Microsoft.Storage/storageAccounts/fileServices/shares` | `share` |
| Storage account | `Microsoft.Storage/storageAccounts` | `st` |
| Storage Sync Service name | `Microsoft.StorageSync/storageSyncServices` | `sss` |

## Virtual desktop infrastructure

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Virtual desktop host pool | `Microsoft.DesktopVirtualization/hostPools` | `vdpool` |
| Virtual desktop application group | `Microsoft.DesktopVirtualization/applicationGroups` | `vdag` |
| Virtual desktop workspace | `Microsoft.DesktopVirtualization/workspaces` | `vdws` |
| Virtual desktop scaling plan | `Microsoft.DesktopVirtualization/scalingPlans` | `vdscaling`|

## Deprecated product names

| Resource | Resource provider namespace | Abbreviation |
|--|--|--|
| Azure SQL Data Warehouse | `Microsoft.Sql/servers` | `sqldw` |

## Next steps

Review recommendations for tagging your Azure resources and assets.

> [!div class="nextstepaction"]
> [Define your tagging strategy](./resource-tagging.md)
