---
title: Example names for common Azure resource types
description: Review example names for resources and assets in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/12/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: readiness, fasttrack-edit
---

# Example names for common Azure resource types

The following section provides some example names for common Azure resource types in an enterprise cloud deployment.

> [!NOTE]
> Some of these example names use a three-digit padding scheme (\<###>). such as `mktg-prod-*001*`.
>
> Padding improves readability and sorting of assets when those assets are managed in a configuration management database (CMDB), IT Asset Management tool, or traditional accounting tools. When the deployed asset is managed centrally as part of a larger inventory or portfolio of IT assets, the padding approach aligns with interfaces those systems use to manage inventory naming.
>
> Unfortunately, the traditional asset padding approach can prove problematic in infrastructure-as-code approaches which may iterate through assets based on a non-padded number. This approach is common during deployment or automated configuration management tasks. Those scripts would have to routinely strip the padding and convert the padded number to a real number, which slows script development and run time.
>
> Which approach you choose to implement is a personal decision. The padding in this article is meant to illustrate the importance of using a consistent approach to inventory numbering, not which approach is superior. Before deciding on a number schema (with or without padding) evaluate which will have a bigger impact on long term operations: CMDB/asset management solutions or code-based inventory management. Then consistently follow the padding option that best fits your operational needs.

<!-- cSpell:disable -->

## Example names: General

| Asset type | Scope | Format and examples |
|--|--|--|
| Management group | Business unit and/or environment type | _mg-\<business&nbsp;unit>[-\<environment&nbsp;type>\]_ <br><br> <li> `mg-mktg` <li> `mg-hr` <li> `mg-corp-prod` <li> `mg-fin-client` |
| Subscription | Account / enterprise agreement | _\<business&nbsp;unit>-\<subscription&nbsp;type>-\<###>_ <br><br> <li> `mktg-prod-001` <li> `corp-shared-001` <li> `fin-client-001` |
| Resource group | Subscription | _rg-\<app&nbsp;or&nbsp;service&nbsp;name>-<subscription&nbsp;type>-\<###>_ <br><br> <li> `rg-mktgsharepoint-prod-001` <li> `rg-acctlookupsvc-share-001` <li> `rg-ad-dir-services-shared-001` |
| API management service instance | Global | _apim-\<app&nbsp;or&nbsp;service&nbsp;name>_ | `apim-navigator-prod` |
| Managed Identity | Resource group | _id-\<app&nbsp;or&nbsp;service&nbsp;name>_ <br><br> <li> `id-appcn-keda-prod-eus-001` |

## Example names: Networking

| Asset type | Scope | Format | Examples |
|--|--|--|--|
| Virtual network | Resource group | _vnet-\<subscription&nbsp;type>-\<region>\<###>_ | <br><br> <li> `vnet-shared-eastus2-001` <li> `vnet-prod-westus-001` <li> `vnet-client-eastus2-001` |
| Subnet | Virtual network | _snet-\<subscription>-\<subregion>-\<###>_ <br><br> <li> `snet-shared-eastus2-001` <li> `snet-prod-westus-001` <li> `snet-client-eastus2-001` |
| Network interface (NIC) | Resource group | nic-<##>-\<vm&nbsp;name>-\<subscription>-<###> | <li> `nic-01-dc1-shared-001` <li> `nic-02-vmhadoop1-prod-001` <li> `nic-02-vmtest1-client-001` |
| Public IP address | Resource group | pip-\<vm&nbsp;name&nbsp;or&nbsp;app&nbsp;name>-\<environment>-\<subregion>-<###> | <li> `pip-dc1-shared-eastus2-001` <li> `pip-hadoop-prod-westus-001` |
| Load balancer | Resource group | lb-\<app&nbsp;name&nbsp;or&nbsp;role><Environment><###> | <li> `lb-navigator-prod-001` <li> `lb-sharepoint-dev-001` |
| Network security group (NSG) | Subnet or NIC | nsg-\<policy&nbsp;name&nbsp;or&nbsp;app&nbsp;name>-<###> | <li> `nsg-weballow-001` <li> `nsg-rdpallow-001` <li> `nsg-sqlallow-001` <li> `nsg-dnsblocked-001` |
| Local network gateway | Virtual gateway | lgw-\<subscription&nbsp;type>-\<region>-<###> | <li> `lgw-shared-eastus2-001` <li> `lgw-prod-westus-001` <li> `lgw-client-eastus2-001` |
| Virtual network gateway | Virtual network | vgw-\<subscription&nbsp;type>-\<Region>-<###> | <li> `vgw-shared-eastus2-001` <li> `vgw-prod-westus-001` <li> `vgw-client-eastus2-001` |
| Virtual network gateway | Virtual network | vgw-\<subscription&nbsp;type>-\<Region>-<###> | <li> `vgw-shared-eastus2-001` <li> `vgw-prod-westus-001` <li> `vgw-client-eastus2-001` |
| Site-to-site connection | Resource group | cn-\<local&nbsp;gateway&nbsp;name>-to-\<virtual&nbsp;gateway&nbsp;name> | <li> `cn-lgw-shared-eastus2-001-to-vgw-shared-eastus2-001` <li> `cn-lgw-shared-eastus2-001-to-shared-westus-001` |
| VPN connection | Resource group | cn-\<subscription1>\<region1>-to-\<subscription2>\<region2>- | <li> `cn-shared-eastus2-to-shared-westus` <li> `cn-prod-eastus2-to-prod-westus` |
| Route table | Resource group | route-\<route&nbsp;table&nbsp;name> | <li> `route-navigator` <li> `route-sharepoint` |
| DNS label | Global | \<DNS&nbsp;A&nbsp;record&nbsp;for&nbsp;VM>.\<region>.cloudapp.azure.com | <li> `dc1.westus.cloudapp.azure.com` <li> `web1.eastus2.cloudapp.azure.com` |

## Example names: Compute and Web

| Asset type | Scope | Format | Examples |
|--|--|--|--|
| Virtual machine | Resource group | vm\<policy name or app name\>\<\#\#\#\> | <li> `vmnavigator001` <li> `vmsharepoint001` <li> `vmsqlnode001` <li> `vmhadoop001` |
| VM storage account | Global | stvm\<performance type\>\<app name or prod name\>\<region\>\<\#\#\#\> | <li> `stvmstcoreeastus2001` <li> `stvmpmcoreeastus2001` <li> `stvmstplmeastus2001` <li> `stvmsthadoopeastus2001` |
| Web app | Global | app-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{azurewebsites.net}] | <li> `app-navigator-prod-001.azurewebsites.net` <li> `app-accountlookup-dev-001.azurewebsites.net` |
| Function app | Global | func-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{azurewebsites.net}] | <li> `func-navigator-prod-001.azurewebsites.net` <li> `func-accountlookup-dev-001.azurewebsites.net` |
| Cloud service | Global | cld-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{cloudapp.net}] | <li> `cld-navigator-prod-001.azurewebsites.net` <li> `cld-accountlookup-dev-001.azurewebsites.net` |
| Notification hub | Resource group | ntf-\<App Name\>-\<Environment\> | <li> `ntf-navigator-prod` <li> `ntf-emissions-dev` |
| Notification Hubs namespace | Global | ntfns-\<App Name\>-\<Environment\> | <li> `ntfns-navigator-prod` <li> `ntfns-emissions-dev` |

## Example names: Databases

| Asset type | Scope | Format | Examples |
|--|--|--|--|
| Azure SQL Database server | Global | sql-\<App Name\>-\<Environment\> | <li> `sql-navigator-prod` <li> `sql-emissions-dev` |
| Azure SQL database | Azure SQL Database | sqldb-\<Database Name>-\<Environment\> | <li> `sqldb-users-prod` <li> `sqldb-users-dev` |
| Azure Cosmos DB database | Global | cosmos-\<App Name\>-\<Environment\> | <li> `cosmos-navigator-prod` <li> `cosmos-emissions-dev` |
| Azure Cache for Redis instance | Global | redis-\<App Name\>-\<Environment\> | <li> `redis-navigator-prod` <li> `redis-emissions-dev` |
| MySQL database | Global | mysql-\<App Name\>-\<Environment\> | <li> `mysql-navigator-prod` <li> `mysql-emissions-dev` |
| PostgreSQL database | Global | psql-\<App Name\>-\<Environment\> | <li> `psql-navigator-prod` <li> `psql-emissions-dev` |
| Azure SQL Data Warehouse | Global | sqldw-\<App Name\>-\<Environment\> | <li> `sqldw-navigator-prod` <li> `sqldw-emissions-dev` |
| SQL Server Stretch Database | Azure SQL Database | sqlstrdb-\<App Name\>-\<Environment\> | <li> `sqlstrdb-navigator-prod` <li> `sqlstrdb-emissions-dev` |

## Example names: Storage

| Asset type | Scope | Format | Examples |
|--|--|--|--|
| Storage account (general use) | Global | st\<storage name\>\<\#\#\#\> | <li> `stnavigatordata001` <li> `stemissionsoutput001` |
| Storage account (diagnostic logs) | Global | stdiag\<first 2 letters of subscription name and number\>\<region\>\<\#\#\#\> | <li> `stdiagsh001eastus2001` <li> `stdiagsh001westus001` |
| Azure StorSimple | Global | ssimp\<App Name\>\<Environment\> | <li> `ssimpnavigatorprod` <li> `ssimpemissionsdev` |
| Azure Container Registry | Global | acr\<App Name\>\<Environment\>\<\#\#\#\> | <li> `acrnavigatorprod001` |

## Example names: AI and machine learning

| Asset type | Scope | Format | Examples |
|--|--|--|--|
| Azure Cognitive Search | Global | srch-\<App Name\>-\<Environment\> | <li> `srch-navigator-prod` <li> `srch-emissions-dev` |
| Azure Cognitive Services | Resource group | cog-\<App Name\>-\<Environment\> | <li> `cog-navigator-prod` <li> `cog-emissions-dev` |
| Azure Machine Learning workspace | Resource group | mlw-\<App Name\>-\<Environment\> | <li> `mlw-navigator-prod` <li> `mlw-emissions-dev` |

## Example names: Analytics and IoT

| Asset type | Scope | Format | Examples |
|--|--|--|--|
| Azure Data Factory | Global | adf-\<App Name\>\<Environment\> | <li> `adf-navigator-prod` <li> `adf-emissions-dev` |
| Azure Stream Analytics | Resource group | asa-\<App Name\>-\<Environment\> | <li> `asa-navigator-prod` <li> `asa-emissions-dev` |
| Data Lake Analytics account | Global | dla\<App Name\>\<Environment\> | <li> `dlanavigatorprod` <li> `dlaemissionsdev` |
| Data Lake Storage account | Global | dls\<App Name\>\<Environment\> | <li> `dlsnavigatorprod` <li> `dlsemissionsdev` |
| Event hub | Global | evh-\<App Name\>-\<Environment\> | <li> `evh-navigator-prod` <li> `evh-emissions-dev` |
| HDInsight - HBase cluster | Global | hbase-\<App Name\>-\<Environment\> | <li> `hbase-navigator-prod` <li> `hbase-emissions-dev` |
| HDInsight - Hadoop cluster | Global | hadoop-\<App Name\>-\<Environment\> | <li> `hadoop-navigator-prod` <li> `hadoop-emissions-dev` |
| HDInsight - Spark cluster | Global | spark-\<App Name\>-\<Environment\> | <li> `spark-navigator-prod` <li> `spark-emissions-dev` |
| IoT hub | Global | iot-\<App Name\>-\<Environment\> | <li> `iot-navigator-prod` <li> `iot-emissions-dev` |
| Power BI Embedded | Global | pbi-\<App Name\>\<Environment\> | <li> `pbi-navigator-prod` <li> `pbi-emissions-dev` |

## Example names: Integration

| Asset type | Scope | Format | Examples |
|--|--|--|--|
| Service Bus | Global | sb-\<App Name\>-\<Environment\>.[{servicebus.windows.net}] | <li> `sb-navigator-prod` <li> `sb-emissions-dev` |
| Service Bus queue | Service Bus | sbq-\<query descriptor\> | <li> `sbq-messagequery` |
| Service Bus topic | Service Bus | sbt-\<query descriptor\> | <li> `sbt-messagequery` |
