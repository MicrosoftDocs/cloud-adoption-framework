---
title: Recommended abbreviations for Azure resource types
description: Review recommended abbreviations to use for various Azure resource types when naming your resources and assets.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, readiness, fasttrack-edit
---

# Recommended abbreviations for Azure resource types

Azure workloads are typically composed of multiple resources and services. Including a naming component in your resource names that represents the type of the Azure resource makes it easier to visually recognize application or service components.

This list provides recommended abbreviations for various Azure resource types to include in your naming conventions. These abbreviations are often used as prefixes in resource names, so each abbreviation is shown below followed by a hyphen (`-`), except for resource types that disallow hyphens in the resource name. Your naming convention might place the resource type abbreviation in a different location of the name if it's more suitable for your organization's needs.

<!-- cSpell:ignore osdisk stvm arck ssimp -->
<!-- cSpell:ignoreRegExp [a-z]+- -->

## General

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Management group | `Microsoft.Management/managementGroups` | `mg-` |
| Resource group | `Microsoft.Resources/resourceGroups` | `rg-` |
| Policy definition | `Microsoft.Authorization/policyDefinitions` | `policy-` |
| API management service instance | `Microsoft.ApiManagement/service` | `apim-` |
| Managed Identity | `Microsoft.ManagedIdentity/userAssignedIdentities` | `id-` |

## Networking

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Virtual network | `Microsoft.Network/virtualNetworks` | `vnet-` |
| Subnet | `Microsoft.Network/virtualNetworks/subnets` | `snet-` |
| Virtual network peering | `Microsoft.Network/virtualNetworks/virtualNetworkPeerings` | `peer-` |
| Network interface (NIC) | `Microsoft.Network/networkInterfaces` | `nic-` |
| Public IP address | `Microsoft.Network/publicIPAddresses` | `pip-` |
| Load balancer (internal) | `Microsoft.Network/loadBalancers` | `lbi-` |
| Load balancer (external) | `Microsoft.Network/loadBalancers` | `lbe-` |
| Network security group (NSG) | `Microsoft.Network/networkSecurityGroups` | `nsg-` |
| Application security group (ASG) | `Microsoft.Network/applicationSecurityGroups` | `asg-` |
| Local network gateway | `Microsoft.Network/localNetworkGateways` | `lgw-` |
| Virtual network gateway | `Microsoft.Network/virtualNetworkGateways` | `vgw-` |
| VPN connection | `Microsoft.Network/vpnGateways/vpnConnections` | `cn-` |
| ExpressRoute circuit | `Microsoft.Network/expressRouteCircuits` | `erc-` |
| Application gateway | `Microsoft.Network/applicationGateways` | `agw-` |
| Route table | `Microsoft.Network/routeTables` | `route-` |
| User defined route (UDR) | `Microsoft.Network/routeTables/routes` | `udr-` |
| Traffic Manager profile | `Microsoft.Network/trafficManagerProfiles` | `traf-` |
| Front door | `Microsoft.Network/frontDoors` | `fd-` |
| CDN profile | `Microsoft.Cdn/profiles` | `cdnp-` |
| CDN endpoint | `Microsoft.Cdn/profiles/endpoints` | `cdne-` |
| Web Application Firewall (WAF) policy | `Microsoft.Network/firewallPolicies` | `waf` |

## Compute and Web

| Asset type | Resource provider namespace/entity | Abbreviation |
|--|--|--|
| Virtual machine | `Microsoft.Compute/virtualMachines` | `vm` |
| Virtual machine scale set | `Microsoft.Compute/virtualMachineScaleSets` | `vmss-` |
| Availability set | `Microsoft.Compute/availabilitySets` | `avail-` |
| Managed disk (OS) | `Microsoft.Compute/disks` | `osdisk` |
| Managed disk (data) | `Microsoft.Compute/disks` | `disk` |
| VM storage account | `Microsoft.Storage/storageAccounts` | `stvm` |
| Azure Arc enabled server | `Microsoft.HybridCompute/machines` | `arcs-` |
| Azure Arc enabled Kubernetes cluster | `Microsoft.Kubernetes/connectedClusters` | `arck` |
| Container registry | `Microsoft.ContainerRegistry/registries` | `cr` |
| Container instance | `Microsoft.ContainerInstance/containerGroups` | `ci-` |
| AKS cluster | `Microsoft.ContainerService/managedClusters` | `aks-` |
| Service Fabric cluster | `Microsoft.ServiceFabric/clusters` | `sf-` |
| App Service environment | `Microsoft.Web/sites` | `ase-` |
| App Service plan | `Microsoft.Web/serverFarms` | `plan-` |
| Web app | `Microsoft.Web/sites` | `app-` |
| Static web app | `Microsoft.Web/sites` | `stapp` |
| Function app | `Microsoft.Web/sites` | `func-` |
| Cloud service | `Microsoft.Compute/cloudServices` | `cld-` |
| Notification Hubs | `Microsoft.NotificationHubs/namespaces/notificationHubs` | `ntf-` |
| Notification Hubs namespace | `Microsoft.NotificationHubs/namespaces` | `ntfns-` |

## Databases

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Azure SQL Database server | `Microsoft.Sql/servers` | `sql-` |
| Azure SQL database | `Microsoft.Sql/servers/databases` | `sqldb-` |
| Azure Cosmos DB database | `Microsoft.DocumentDB/databaseAccounts/sqlDatabases` | `cosmos-` |
| Azure Cache for Redis instance | `Microsoft.Cache/Redis` | `redis-` |
| MySQL database | `Microsoft.DBforMySQL/servers` | `mysql-` |
| PostgreSQL database | `Microsoft.DBforPostgreSQL/servers` | `psql-` |
| Azure Synapse Analytics | `Microsoft.Synapse/workspaces` | `syn-` |
| Azure Synapse Analytics Workspaces | `Microsoft.Synapse/workspaces` | `syn-` |
| Azure Synapse Analytics SQL Dedicated Pool | `Microsoft.Synapse/workspaces/sqlPools` | `syndw-` |
| Azure Synapse Analytics Spark Pool | `Microsoft.Synapse/workspaces/sqlPools` | `synspark-` |
| SQL Server Stretch Database | `Microsoft.Sql/servers/databases` | `sqlstrdb-` |
| SQL Managed Instance | `Microsoft.Sql/managedInstances` | `sqlmi-` |

## Storage

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| Storage account | `Microsoft.Storage/storageAccounts` | `st` |
| Azure StorSimple | `Microsoft.StorSimple/managers` | `ssimp` |
| Azure Container Registry | `Microsoft.ContainerRegistry/registries` | `acr` |

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
| Azure Data Factory | `Microsoft.DataFactory/factories` | `adf-` |
| Data Lake Store account | `Microsoft.DataLakeStore/accounts` | `dls` |
| Data Lake Analytics account | `Microsoft.DataLakeAnalytics/accounts` | `dla` |
| Event Hubs namespace | `Microsoft.EventHub/namespaces` | `evhns-` |
| Event hub | Microsoft.EventHub namespaces/eventHubs | `evh-` |
| Event Grid domain | `Microsoft.EventGrid/domains` | `evgd-` |
| Event Grid topic | `Microsoft.EventGrid/domains/topics` | `evgt-` |
| HDInsight - Hadoop cluster | `Microsoft.HDInsight/clusters` | `hadoop-` |
| HDInsight - HBase cluster | `Microsoft.HDInsight/clusters` | `hbase-` |
| HDInsight - Kafka cluster | `Microsoft.HDInsight/clusters` | `kafka-` |
| HDInsight - Spark cluster | `Microsoft.HDInsight/clusters` | `spark-` |
| HDInsight - Storm cluster | `Microsoft.HDInsight/clusters` | `storm-` |
| HDInsight - ML Services cluster | `Microsoft.HDInsight/clusters` | `mls-` |
| IoT hub | `Microsoft.Devices/IotHubs` | `iot-` |
| Power BI Embedded | `Microsoft.PowerBIDedicated/capacities` | `pbi-` |
| Time Series Insights environment | `Microsoft.TimeSeriesInsights/environments` | `tsi-` |

## Developer tools

| Asset type | Resource provider namespace/Entity | Abbreviation |
|--|--|--|
| App Configuration store | `Microsoft.AppConfiguration/configurationStores` | `appcs-` |
| Azure Static Web Apps | `Microsoft.Web/sites` | `stap-` |

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
| Azure Monitor action group | `Microsoft.Insights/actionGroups` | `ag-` |
| Azure Purview instance | `Microsoft.Purview/accounts` | `pview-` |
| Blueprint | `Microsoft.Blueprint/blueprints` | `bp-` |
| Blueprint assignment | `Microsoft.Blueprint/blueprints/artifacts` | `bpa-` |
| Key vault | `Microsoft.KeyVault/vaults` | `kv-` |
| Log Analytics workspace | `Microsoft.OperationalInsights/workspaces` | `log-` |
| Application Insights | `Microsoft.Insights/components` | `appi-` |

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
