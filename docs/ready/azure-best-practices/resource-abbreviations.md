---
title: Recommended abbreviations for Azure resource types
description: Review recommended abbreviations to use for various Azure resource types when naming your resources and assets.
author: BrianBlanchard
ms.author: brblanch
ms.date: 4/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, readiness, fasttrack-edit
---

# Recommended abbreviations for Azure resource types

Azure workloads are typically composed of multiple resources and services. Including a naming component in your resource names that represents the type of the Azure resource makes it easier to visually recognize application or service components.

This list provides recommended abbreviations for various Azure resource types to include in your naming conventions. These abbreviations are often used as prefixes in resource names, so each abbreviation is shown below followed by a hyphen (`-`), except for resource types that disallow hyphens in the resource name. Your naming convention might place the resource type abbreviation in a different location of the name if it's more suitable for your organization's needs.

<!-- cSpell:ignoreRegExp `[a-z]+-?` -->

## General

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| API management service instance | `Microsoft.ApiManagement/service` | `apim-` |
| Managed Identity | `Microsoft.ManagedIdentity/userAssignedIdentities` | `id-` |
| Management group | `Microsoft.Management/managementGroups` | `mg-` |
| Policy definition | `Microsoft.Authorization/policyDefinitions` | `policy-` |
| Resource group | `Microsoft.Resources/resourceGroups` | `rg-` |

## Networking

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Application gateway | `Microsoft.Network/applicationGateways` | `agw-` |
| Application security group (ASG) | `Microsoft.Network/applicationSecurityGroups` | `asg-` |
| Bastion | `Microsoft.Network/bastionHosts` | `bas-` |
| CDN profile | `Microsoft.Cdn/profiles` | `cdnp-` |
| CDN endpoint | `Microsoft.Cdn/profiles/endpoints` | `cdne-` |
| Connections | `Microsoft.Network/connections`| `con-` |
| DNS | `Microsoft.Network/dnsZones` | `dnsz-` |
| DNS zone | `Microsoft.Network/privateDnsZones` | `pdnsz-` |
| Firewall | `Microsoft.Network/azureFirewalls` | `afw-` |
| Firewall policy | `Microsoft.Network/firewallPolicies` | `afwp-` |
| ExpressRoute circuit | `Microsoft.Network/expressRouteCircuits` | `erc-` |
| Front Door instance | `Microsoft.Network/frontDoors` | `fd-` |
| Front Door firewall policy | `Microsoft.Network/frontdoorWebApplicationFirewallPolicies` | `fdfp-`|
| Load balancer (internal) | `Microsoft.Network/loadBalancers` | `lbi-`|
| Load balancer (external) | `Microsoft.Network/loadBalancers` | `lbe-`|
| Load balancer rule | `Microsoft.Network/loadBalancers/inboundNatRules` | `rule-`|
| Local network gateway | `Microsoft.Network/localNetworkGateways` | `lgw-` |
| NAT gateway | Microsoft.Network/natGateways | `ng` |
| Network interface (NIC) | `Microsoft.Network/networkInterfaces` | `nic-`|
| Network security group (NSG) | `Microsoft.Network/networkSecurityGroups` | `nsg-` |
| Network security group (NSG) security rules | `Microsoft.Network/networkSecurityGroups/securityRules` | `nsgsr-` |
| Network Watcher | `Microsoft.Network/networkWatchers` | `nw-` |
| Private Link | `"Microsoft.Network/privateLinkServices` | `pl-` |
| Public IP address | `Microsoft.Network/publicIPAddresses` | `pip-`|
| Public IP address prefix | `Microsoft.Network/publicIPPrefixes` | `ippre-`|
| Route filter | `Microsoft.Network/routeFilters` | `rf-` |
| Route table | `Microsoft.Network/routeTables` | `rt-` |
| Service endpoint | `Microsoft.serviceEndPointPolicies` | `se-` |
| Traffic Manager profile | `Microsoft.Network/trafficManagerProfiles` | `traf-` |
| User defined route (UDR) | `Microsoft.Network/routeTables/routes` | `udr-` |
| Virtual network | `Microsoft.Network/virtualNetworks` | `vnet-`|
| Virtual network peering | `Microsoft.Network/virtualNetworks/virtualNetworkPeerings` | `peer-`|
| Virtual network subnet | `Microsoft.Network/virtualNetworks/subnets` | `snet-`|
| Virtual WAN | `Microsoft.Network/virtualWans` | `vwan-`|
| VPN Gateway| `Microsoft.Network/vpnGateways` | `vpng-`|
| VPN connection | `Microsoft.Network/vpnGateways/vpnConnections` | `vcn-` |
| VPN site | `Microsoft.Network/vpnGateways/vpnSites` | `vst-` |
| Virtual network gateway | `Microsoft.Network/virtualNetworkGateways` | `vgw-` |
| Web Application Firewall (WAF) policy | `Microsoft.Network/firewallPolicies` | `waf` |
| Web Application Firewall (WAF) policy rule group | `Microsoft.Network/firewallPolicies/ruleGroups` | `wafrg` |

## Compute and Web

| Asset type | Resource provider namespace/entity | Abbreviation |
|--|--|--|
| App Service environment | `Microsoft.Web/sites` | `ase-` |
| App Service plan | `Microsoft.Web/serverFarms` | `plan-` |
| Availability set | `Microsoft.Compute/availabilitySets` | `avail-` |
| Azure Arc enabled server | `Microsoft.HybridCompute/machines` | `arcs-` |
| Azure Arc enabled Kubernetes cluster | `Microsoft.Kubernetes/connectedClusters` | `arck` |
| Cloud service | `Microsoft.Compute/cloudServices` | `cld-` |
| Disk encryption set | `Microsoft.Compute/diskEncryptionSets` | `des` |
| Function app | `Microsoft.Web/sites` | `func-` |
| Gallery | `Microsoft.Compute/galleries` | `gal` |
| Managed disk (OS) | `Microsoft.Compute/disks` | `osdisk` |
| Managed disk (data) | `Microsoft.Compute/disks` | `disk` |
| Notification Hubs | `Microsoft.NotificationHubs/namespaces/notificationHubs` | `ntf-` |
| Notification Hubs namespace | `Microsoft.NotificationHubs/namespaces` | `ntfns-` |
| Snapshot | `Microsoft.Compute/snapshots` | `snap-` |
| Static web app | `Microsoft.Web/staticSites` | `stapp-` |
| Virtual machine | `Microsoft.Compute/virtualMachines` | `vm` |
| Virtual machine scale set | `Microsoft.Compute/virtualMachineScaleSets` | `vmss-` |
| VM storage account | `Microsoft.Storage/storageAccounts` | `stvm` |
| Web app | `Microsoft.Web/sites` | `app-` |

## Containers

| Asset type | Resource provider namespace/entity | Abbreviation |
|--|--|--|
| AKS cluster | `Microsoft.ContainerService/managedClusters` | `aks-` |
| Container registry | `Microsoft.ContainerRegistry/registries` | `cr` |
| Container instance | `Microsoft.ContainerInstance/containerGroups` | `ci` |
| Service Fabric cluster | `Microsoft.ServiceFabric/clusters` | `sf-` |

## Databases

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Azure Cosmos DB database | `Microsoft.DocumentDB/databaseAccounts/sqlDatabases` | `cosmos-` |
| Azure Cache for Redis instance | `Microsoft.Cache/Redis` | `redis-` |
| Azure SQL Database server | `Microsoft.Sql/servers` | `sql-` |
| Azure SQL database | `Microsoft.Sql/servers/databases` | `sqldb-` |
| Azure Synapse Analytics | `Microsoft.Synapse/workspaces` | `syn` |
| Azure Synapse Analytics Workspaces | `Microsoft.Synapse/workspaces` | `synw` |
| Azure Synapse Analytics SQL Dedicated Pool | `Microsoft.Synapse/workspaces/sqlPools` | `syndp` |
| Azure Synapse Analytics Spark Pool | `Microsoft.Synapse/workspaces/sqlPools` | `synsp` |
| MySQL database | `Microsoft.DBforMySQL/servers` | `mysql-` |
| PostgreSQL database | `Microsoft.DBforPostgreSQL/servers` | `psql-` |
| SQL Server Stretch Database | `Microsoft.Sql/servers/databases` | `sqlstrdb-` |
| SQL Managed Instance | `Microsoft.Sql/managedInstances` | `sqlmi-` |

## Storage

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Storage account | `Microsoft.Storage/storageAccounts` | `st` |
| Azure StorSimple | `Microsoft.StorSimple/managers` | `ssimp` |

## AI and Machine Learning

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Azure Cognitive Search | `Microsoft.Search/searchServices` | `srch-` |
| Azure Cognitive Services | `Microsoft.CognitiveServices/accounts` | `cog-` |
| Azure Machine Learning workspace | `Microsoft.MachineLearningServices/workspaces` | `mlw-` |

## Analytics and IoT

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Azure Analysis Services server | `Microsoft.AnalysisServices/servers` | `as` |
| Azure Databricks workspace | `Microsoft.Databricks/workspaces` | `dbw-` |
| Azure Stream Analytics | `Microsoft.StreamAnalytics/cluster` | `asa-` |
| Azure Data Explorer cluster | `Microsoft.Kusto/clusters` | `dec` |
| Azure Data Explorer cluster database | `Microsoft.Kusto/clusters/databases` | `dedb` |
| Azure Data Factory | `Microsoft.DataFactory/factories` | `adf-` |
| Data Lake Store account | `Microsoft.DataLakeStore/accounts` | `dls` |
| Data Lake Analytics account | `Microsoft.DataLakeAnalytics/accounts` | `dla` |
| Event Hubs namespace | `Microsoft.EventHub/namespaces` | `evhns-` |
| Event hub | `Microsoft.EventHub/namespaces/eventHubs` | `evh-` |
| Event Grid domain | `Microsoft.EventGrid/domains` | `evgd-` |
| Event Grid subscriptions | `Microsoft.EventGrid/eventSubscriptions` | `evgs-` |
| Event Grid topic | `Microsoft.EventGrid/domains/topics` | `evgt-` |
| HDInsight - Hadoop cluster | `Microsoft.HDInsight/clusters` | `hadoop-` |
| HDInsight - HBase cluster | `Microsoft.HDInsight/clusters` | `hbase-` |
| HDInsight - Kafka cluster | `Microsoft.HDInsight/clusters` | `kafka-` |
| HDInsight - Spark cluster | `Microsoft.HDInsight/clusters` | `spark-` |
| HDInsight - Storm cluster | `Microsoft.HDInsight/clusters` | `storm-` |
| HDInsight - ML Services cluster | `Microsoft.HDInsight/clusters` | `mls-` |
| IoT hub | `Microsoft.Devices/IotHubs` | `iot-` |
| Provisioning services | `Microsoft.Devices/provisioningServices` | `provs-` |
| Provisioning services certificate | `Microsoft.Devices/provisioningServices/certificates` | `pcert-` |
| Power BI Embedded | `Microsoft.PowerBIDedicated/capacities` | `pbi-` |
| Time Series Insights environment | `Microsoft.TimeSeriesInsights/environments` | `tsi-` |

## Azure Virtual Desktop

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Virtual desktop host pool | | vdpool- |
| Virtual desktop application group | | vdag- |
| Virtual desktop workspace | | vdws- |

## Developer tools

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| App Configuration store | `Microsoft.AppConfiguration/configurationStores` | `appcs-` |
| SignalR | `Microsoft.SignalRService/SignalR` | `sigr` |

## Integration

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Integration account | `Microsoft.Logic/integrationAccounts` | `ia-` |
| Logic apps | `Microsoft.Logic/workflows` | `logic-` |
| Service Bus | `Microsoft.ServiceBus/namespaces` | `sb-` |
| Service Bus queue | `Microsoft.ServiceBus/namespaces/queues` | `sbq-` |
| Service Bus topic | `Microsoft.ServiceBus/namespaces/topics` | `sbt-` |

## Management and governance

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Automation account | `Microsoft.Automation/automationAccounts` | `aa-` |
| Application Insights | `Microsoft.Insights/components` | `appi-` |
| Azure Monitor action group | `Microsoft.Insights/actionGroups` | `ag-` |
| Azure Purview instance | `Microsoft.Purview/accounts` | `pview-` |
| Blueprint | `Microsoft.Blueprint/blueprints` | `bp-` |
| Blueprint assignment | `Microsoft.Blueprint/blueprints/artifacts` | `bpa-` |
| Key vault | `Microsoft.KeyVault/vaults` | `kv-` |
| Log Analytics workspace | `Microsoft.OperationalInsights/workspaces` | `log-` |

## Migration

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Azure Migrate project | `Microsoft.Migrate/assessmentProjects` | `migr-` |
| Database Migration Service instance | `Microsoft.DataMigration/services` | `dms-` |
| Recovery Services vault | `Microsoft.RecoveryServices/vaults` | `rsv-` |

## Deprecated product names

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Azure SQL Data Warehouse | `Microsoft.Sql/servers` | `sqldw-` |

## Next steps

Review recommendations for tagging your Azure resources and assets.

> [!div class="nextstepaction"]
> [Define your tagging strategy](./resource-tagging.md)
