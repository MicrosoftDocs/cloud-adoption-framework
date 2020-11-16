---
title: Recommended naming elements for Azure resources and assets
description: Review recommended naming elements to use for different types of Azure resources and assets.
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/12/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: readiness, fasttrack-edit
---

### Recommended naming elements for Azure resources and assets

Azure workloads are typically composed of multiple resources and services. Including a naming element that 

<!-- TODO -->

 Incorporating resource type prefixes into your resource names makes it easier to visually identify application or service components.

This list recommends Azure resource type prefixes to use when you define your naming conventions.

<!-- cSpell:disable -->
<!-- docutune:disable -->

### General

| Asset type                      | Name prefix |
|---------------------------------|-------------|
| Management group                | mg-         |
| Resource group                  | rg-         |
| Policy definition               | policy-     |
| API management service instance | apim-       |
| Managed Identity                | id-         |

### Networking

| Asset type                            | Name prefix |
|---------------------------------------|-------------|
| Virtual network                       | vnet-       |
| Subnet                                | snet-       |
| Virtual network peering               | peer-       |
| Network interface (NIC)               | nic-        |
| Public IP address                     | pip-        |
| Load balancer (internal)              | lbi-        |
| Load balancer (external)              | lbe-        |
| Network security group (NSG)          | nsg-        |
| Application security group (ASG)      | asg-        |
| Local network gateway                 | lgw-        |
| Virtual network gateway               | vgw-        |
| VPN connection                        | cn-         |
| ExpressRoute circuit                  | erc-        |
| Application gateway                   | agw-        |
| Route table                           | route-      |
| User defined route (UDR)              | udr-        |
| Traffic Manager profile               | traf-       |
| Front door                            | fd-         |
| CDN profile                           | cdnp-       |
| CDN endpoint                          | cdne-       |
| Web Application Firewall (WAF) policy | waf         |

### Compute and Web

| Asset type | Name prefix |
|--|--|
| Virtual machine | vm |
| Virtual machine scale set | vmss- |
| Availability set | avail- |
| Managed disk (OS) | osdisk |
| Managed disk (data) | disk |
| VM storage account | stvm |
| Azure Arc enabled server | arcs- |
| Azure Arc enabled Kubernetes cluster | arck |
| Container registry | cr |
| Container instance | ci- |
| AKS cluster | aks- |
| Service Fabric cluster | sf- |
| App Service environment | ase- |
| App Service plan | plan- |
| Web app | app- |
| Function app | func- |
| Cloud service | cld- |
| Notification Hubs | ntf- |
| Notification Hubs namespace | ntfns- |

### Databases

| Asset type                     | Name prefix |
|--------------------------------|-------------|
| Azure SQL Database server      | sql-        |
| Azure SQL database             | sqldb-      |
| Azure Cosmos DB database       | cosmos-     |
| Azure Cache for Redis instance | redis-      |
| MySQL database                 | mysql-      |
| PostgreSQL database            | psql-       |
| Azure SQL Data Warehouse       | sqldw-      |
| Azure Synapse Analytics        | syn-        |
| SQL Server Stretch Database    | sqlstrdb-   |
| SQL Managed Instance           | sqlmi-      |

### Storage

| Asset type               | Name prefix |
|--------------------------|-------------|
| Storage account          | st          |
| Azure StorSimple         | ssimp       |
| Azure Container Registry | acr         |

### AI and Machine Learning

| Asset type                       | Name prefix |
|----------------------------------|-------------|
| Azure Cognitive Search           | srch-       |
| Azure Cognitive Services         | cog-        |
| Azure Machine Learning workspace | mlw-        |

### Analytics and IoT

| Asset type                       | Name prefix |
|---------------------------------_|-------------|
| Azure Analysis Services server   | as          |
| Azure Databricks workspace       | dbw-        |
| Azure Stream Analytics           | asa-        |
| Azure Data Explorer cluster      | dec         |
| Azure Data Factory               | adf-        |
| Data Lake Store account          | dls         |
| Data Lake Analytics account      | dla         |
| Event hub                        | evh-        |
| HDInsight - Hadoop cluster       | hadoop-     |
| HDInsight - HBase cluster        | hbase-      |
| HDInsight - Kafka cluster        | kafka-      |
| HDInsight - Spark cluster        | spark-      |
| HDInsight - Storm cluster        | storm-      |
| HDInsight - ML Services cluster  | mls-        |
| IoT hub                          | iot-        |
| Power BI Embedded                | pbi-        |
| Time Series Insights environment | tsi-        |

### Developer tools

| Asset type | Name prefix |
|---|---|
| App Configuration store | appcs- |

### Integration

| Asset type          | Name prefix |
|---------------------|-------------|
| Integration account | ia-         |
| Logic apps          | logic-      |
| Service Bus         | sb-         |
| Service Bus queue   | sbq-        |
| Service Bus topic   | sbt-        |

### Management and governance

| Asset type | Name prefix |
|--|--|
| Automation account | aa- |
| Azure Monitor action group | ag- |
| Blueprint | bp- |
| Blueprint assignment | bpa- |
| Key vault | kv- |
| Log Analytics workspace | log- |
| Application Insights | appi- |
| Recovery Services vault | rsv- |

### Migration

| Asset type                          | Name prefix |
|-------------------------------------|-------------|
| Azure Migrate project               | migr-       |
| Database Migration Service instance | dms-        |
| Recovery Services vault             | rsv-        |
