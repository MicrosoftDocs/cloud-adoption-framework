---
title: Recommended naming and tagging conventions
description: Learn detailed resource naming and tagging recommendations aimed specifically at supporting enterprise cloud adoption efforts.
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/12/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: readiness, fasttrack-edit
---

# Recommended naming and tagging conventions

Organize your cloud assets to support operational management and accounting requirements. Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and showback accounting mechanisms.

Accurate representation and naming of resources are critical for security purposes. In the event of a security incident, quickly identifying affected systems, their potential business impact, and what they are being used for is critical to making good risk decisions. Security services such as [Azure Security Center](https://docs.microsoft.com/azure/security-center/security-center-introduction) and [Azure Sentinel](https://docs.microsoft.com/azure/sentinel) reference resources and their associated logging/alert information by resource name.

Azure defines [naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules). This guidance provides detailed recommendations to support enterprise cloud adoption efforts.

Changing resource names can be difficult. Establish a comprehensive naming convention before you begin any large cloud deployment.

> [!NOTE]
> Every business has different organizational and management requirements. These recommendations provide a starting point for discussions within your cloud adoption teams.
>
> As these discussions proceed, use the following template to capture the naming and tagging decisions you make when you align these recommendations to your specific business needs.
>
> Download the [naming and tagging conventions tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx).

## Naming and tagging resources

A naming and tagging strategy includes business and operational details as components of resource names and metadata tags:

The business side of this strategy ensures that resource names and tags include the organizational information needed to identify the teams. Use a resource along with the business owners who are responsible for resource costs.

The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other information useful for managing resources.

## Resource naming

An effective naming convention assembles resource names by using important resource information as parts of a resource's name. For example, using these [recommended naming conventions](#example-names), a public IP resource for a production SharePoint workload is named like this: `pip-sharepoint-prod-westus-001`.

From the name, you can quickly identify the resource's type, its associated workload, its deployment environment, and the Azure region hosting it.

### Naming scope

All Azure resource types have a scope that defines the level that resource names must be unique. A resource must have a unique name within its scope.

For example, a virtual network has a resource group scope, which means that there can be only one network named `vnet-prod-westus-001` in a given resource group. Other resource groups could have their own virtual network named `vnet-prod-westus-001`. Subnets are scoped to virtual networks, so each subnet within a virtual network must be uniquely named.

Some resource names, such as PaaS services with public endpoints or virtual machine DNS labels, have global scopes, which means that they must be unique across the entire Azure platform.

Resource names have length limits. Balancing the context embedded in a name with its scope and length is important when you develop your naming conventions. For more information, see [naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules).

### Recommended naming components

When you construct your naming convention, identify the key pieces of information that you want to reflect in a resource name. Different information is relevant for different resource types. The following list provides examples of information that are useful when you construct resource names.

Keep the length of naming components short to prevent exceeding resource name length limits.

| Naming component            | Description                                                                                                                                                                                                      | Examples                                         |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| Business unit               | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this component might represent a single corporate top-level organizational element. | `fin`, `mktg`, `product`, `it`, `corp`           |
| Subscription type           | Summary description of the purpose of the subscription that contains the resource. Often broken down by deployment environment type or specific workloads.                                                       | `prod`, `shared`, `client`                       |
| Application or service name | Name of the application, workload, or service that the resource is a part of.                                                                                                                                    | `navigator`, `emissions`, `sharepoint`, `hadoop` |
| Deployment environment      | The stage of the development lifecycle for the workload that the resource supports.                                                                                                                              | `prod`, `dev`, `qa`, `stage`, `test`             |
| Region                      | The Azure region where the resource is deployed.                                                                                                                                                                 | `westus`, `eastus2`, `westeurope`, `usgovia`     |

### Recommended resource-type prefixes

Each workload can consist of many individual resources and services. Incorporating resource type prefixes into your resource names makes it easier to visually identify application or service components.

This list recommends Azure resource type prefixes to use when you define your naming conventions.

<!-- cSpell:ignore apim snet traf vmss stvm arcm ntfns sqldb psql sqldw sqlstrdb ssimp srch hbase appi migr -->

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

<!-- cSpell:enable -->

## Metadata tags

When you apply metadata tags to your cloud resources, you can include information about those assets that couldn't be included in the resource name. You can use that information to perform more sophisticated filtering and reporting on resources. You want these tags to include context about the resource's associated workload or application, operational requirements, and ownership information. This information can be used by IT or business teams to find resources or generate reports about resource usage and billing.

What tags you apply to resources and what tags are required or optional differs among organizations. The following list provides examples of common tags that capture important context and information about a resource. Use this list as a starting point to establish your own tagging conventions.

| Tag Name                  | Description                                                                                                                                                                                                          | Key               | Example value                                              |
|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|------------------------------------------------------------|
| Application name          | Name of the application, service, or workload the resource is associated with.                                                                                                                                       | _ApplicationName_ | _{application name}_                                               |
| Approver name             | Person responsible for approving costs related to this resource.                                                                                                                                                     | _Approver_        | _{email}_                                                  |
| Budget required/approved  | Money allocated for this application, service, or workload.                                                                                                                                                          | _BudgetAmount_    | _{\$}_                                                     |
| Business unit             | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this tag might represent a single corporate or shared top-level organizational element. | _BusinessUnit_    | _FINANCE_, _MARKETING_, _{Product Name}_, _CORP_, _SHARED_ |
| Cost center               | Accounting cost center associated with this resource.                                                                                                                                                                | _CostCenter_      | _{number}_                                                 |
| Disaster recovery         | Business criticality of the application, workload, or service.                                                                                                                                                       | _DR_              | _Mission-critical_, _Critical_, _Essential_                |
| End date of the project   | Date when the application, workload, or service is scheduled for retirement.                                                                                                                                         | _EndDate_         | _{date}_                                                   |
| Environment               | Deployment environment of the application, workload, or service.                                                                                                                                                     | _Env_             | _Prod_, _Dev_, _QA_, _Stage_, _Test_                       |
| Owner name                | Owner of the application, workload, or service.                                                                                                                                                                      | _Owner_           | _{email}_                                                  |
| Requester name            | User who requested the creation of this application.                                                                                                                                                                 | _Requester_       | _{email}_                                                  |
| Service class             | Service level agreement level of the application, workload, or service.                                                                                                                                              | _ServiceClass_    | _Dev_, _Bronze_, _Silver_, _Gold_                          |
| Start date of the project | Date when the application, workload, or service was first deployed.                                                                                                                                                  | _StartDate_       | _{date}_                                                   |
