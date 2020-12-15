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

| Asset type | Abbreviation |
|--|--|
| Management group | `mg-` |
| Resource group | `rg-` |
| Policy definition | `policy-` |
| API management service instance | `apim-` |
| Managed Identity | `id-` |

## Networking

| Asset type | Abbreviation |
|--|--|
| Virtual network | `vnet-` |
| Subnet | `snet-` |
| Virtual network peering | `peer-` |
| Network interface (NIC) | `nic-` |
| Public IP address | `pip-` |
| Load balancer (internal) | `lbi-` |
| Load balancer (external) | `lbe-` |
| Network security group (NSG) | `nsg-` |
| Application security group (ASG) | `asg-` |
| Local network gateway | `lgw-` |
| Virtual network gateway | `vgw-` |
| VPN connection | `cn-` |
| ExpressRoute circuit | `erc-` |
| Application gateway | `agw-` |
| Route table | `route-` |
| User defined route (UDR) | `udr-` |
| Traffic Manager profile | `traf-` |
| Front door | `fd-` |
| CDN profile | `cdnp-` |
| CDN endpoint | `cdne-` |
| Web Application Firewall (WAF) policy | `waf` |

## Compute and Web

| Asset type | Abbreviation |
|--|--|
| Virtual machine | `vm` |
| Virtual machine scale set | `vmss-` |
| Availability set | `avail-` |
| Managed disk (OS) | `osdisk` |
| Managed disk (data) | `disk` |
| VM storage account | `stvm` |
| Azure Arc enabled server | `arcs-` |
| Azure Arc enabled Kubernetes cluster | `arck` |
| Container registry | `cr` |
| Container instance | `ci-` |
| AKS cluster | `aks-` |
| Service Fabric cluster | `sf-` |
| App Service environment | `ase-` |
| App Service plan | `plan-` |
| Web app | `app-` |
| Function app | `func-` |
| Cloud service | `cld-` |
| Notification Hubs | `ntf-` |
| Notification Hubs namespace | `ntfns-` |

## Databases

| Asset type | Abbreviation |
|--|--|
| Azure SQL Database server | `sql-` |
| Azure SQL database | `sqldb-` |
| Azure Cosmos DB database | `cosmos-` |
| Azure Cache for Redis instance | `redis-` |
| MySQL database | `mysql-` |
| PostgreSQL database | `psql-` |
| Azure SQL Data Warehouse | `sqldw-` |
| Azure Synapse Analytics | `syn-` |
| SQL Server Stretch Database | `sqlstrdb-` |
| SQL Managed Instance | `sqlmi-` |

## Storage

| Asset type | Abbreviation |
|--|--|
| Storage account | `st` |
| Azure StorSimple | `ssimp` |
| Azure Container Registry | `acr` |

## AI and Machine Learning

| Asset type | Abbreviation |
|--|--|
| Azure Cognitive Search | `srch-` |
| Azure Cognitive Services | `cog-` |
| Azure Machine Learning workspace | `mlw-` |

## Analytics and IoT

| Asset type | Abbreviation |
|--|--|
| Azure Analysis Services server | `as` |
| Azure Databricks workspace | `dbw-` |
| Azure Stream Analytics | `asa-` |
| Azure Data Explorer cluster | `dec` |
| Azure Data Factory | `adf-` |
| Data Lake Store account | `dls` |
| Data Lake Analytics account | `dla` |
| Event hub | `evh-` |
| HDInsight - Hadoop cluster | `hadoop-` |
| HDInsight - HBase cluster | `hbase-` |
| HDInsight - Kafka cluster | `kafka-` |
| HDInsight - Spark cluster | `spark-` |
| HDInsight - Storm cluster | `storm-` |
| HDInsight - ML Services cluster | `mls-` |
| IoT hub | `iot-` |
| Power BI Embedded | `pbi-` |
| Time Series Insights environment | `tsi-` |

## Developer tools

| Asset type | Abbreviation |
|---|---|
| App Configuration store | `appcs-` |

## Integration

| Asset type | Abbreviation |
|--|--|
| Integration account | `ia-` |
| Logic apps | `logic-` |
| Service Bus | `sb-` |
| Service Bus queue | `sbq-` |
| Service Bus topic | `sbt-` |

## Management and governance

| Asset type | Abbreviation |
|--|--|
| Automation account | `aa-` |
| Azure Monitor action group | `ag-` |
| Azure Purview instance | `pview-` |
| Blueprint | `bp-` |
| Blueprint assignment | `bpa-` |
| Key vault | `kv-` |
| Log Analytics workspace | `log-` |
| Application Insights | `appi-` |

## Migration

| Asset type | Abbreviation |
|--|--|
| Azure Migrate project | `migr-` |
| Database Migration Service instance | `dms-` |
| Recovery Services vault | `rsv-` |

## Next steps

Review recommendations for tagging your Azure resources and assets.

> [!div class="nextstepaction"]
> [Define your tagging strategy](./resource-tagging.md)
