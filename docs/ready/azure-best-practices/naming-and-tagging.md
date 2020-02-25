---
title: "Recommended naming and tagging conventions"
description: This article provides detailed resource naming and tagging recommendations aimed specifically at supporting enterprise cloud adoption efforts.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/01/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: readiness, fasttrack-edit
---

# Recommended naming and tagging conventions

Organizing cloud-based assets in ways that aid operational management and support accounting requirements is a common challenge in large cloud adoption efforts. By applying well-defined naming and metadata tagging conventions to cloud-hosted resources, IT staff can quickly find and manage resources. Well-defined names and tags also help to align cloud usage costs with business teams by using chargeback and showback accounting mechanisms.

The Azure Architecture Center's guidance for [naming rules and restrictions for Azure resources](https://docs.microsoft.com/azure/architecture/best-practices/resource-naming) provides general recommendations and platform limitations. The following discussion extends that guidance with more detailed recommendations aimed specifically at supporting enterprise cloud adoption efforts.

Resource names can be difficult to change. Prioritize establishing a comprehensive naming convention before you begin any large cloud deployment.

> [!NOTE]
> Every business has different organizational and management requirements. These recommendations provide a starting point for discussions within your cloud adoption teams.
>
> As these discussions proceed, use the following template to capture the naming and tagging decisions you make when you align these recommendations to your specific business needs.
>
> Download the [naming and tagging convention tracking template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/CAF%20Readiness%20Naming%20and%20Tagging%20tracking%20template.xlsx).

## Naming and tagging resources

A naming and tagging strategy includes business and operational details as components of resource names and metadata tags:

- The business side of this strategy ensures that resource names and tags include the organizational information that's needed to identify the teams. Use a resource along with the business owners who are responsible for resource costs.
- The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other information useful for managing resources.

### Resource naming

An effective naming convention assembles resource names by using important resource information as parts of a resource's name. For example, using these [recommended naming conventions](#sample-naming-convention), a public IP resource for a production SharePoint workload is named like this: `pip-sharepoint-prod-westus-001`.

From the name, you can quickly identify the resource's type, its associated workload, its deployment environment, and the Azure region hosting it.

#### Naming scope

All Azure resource types have a scope that defines the level that resource names must be unique. A resource must have a unique name within its scope.

For example, a virtual network has a resource group scope, which means that there can be only one network named `vnet-prod-westus-001` in a given resource group. Other resource groups can have their own virtual network named `vnet-prod-westus-001`. Subnets, to give another example, are scoped to virtual networks, which means that each subnet within a virtual network must be uniquely named.

Some resource names, such as PaaS services with public endpoints or virtual machine DNS labels, have global scopes, which means that they must be unique across the entire Azure platform.

Resource names have length limits. Balancing the context embedded in a name with its scope and length is important when you develop your naming conventions. For more information about naming rules for allowed characters, scopes, and name lengths for resource types, see [Naming conventions for Azure resources](https://docs.microsoft.com/azure/architecture/best-practices/resource-naming).

#### Recommended naming components

When you construct your naming convention, identify the key pieces of information that you want to reflect in a resource name. Different information is relevant for different resource types. The following list provides examples of information that are useful when you construct resource names.

Keep the length of naming components short to prevent exceeding resource name length limits.

| Naming component | Description | Examples |
| --- | --- | --- |
| Business unit | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this component might represent a single corporate top-level organizational element. | _fin_, _mktg_, _product_, _it_, _corp_ |
| Subscription type | Summary description of the purpose of the subscription that contains the resource. Often broken down by deployment environment type or specific workloads. | _prod_, _shared_, _client_ |
| Application or service name | Name of the application, workload, or service that the resource is a part of. | _navigator_, _emissions_, _sharepoint_, _hadoop_ |
| Deployment environment | The stage of the development lifecycle for the workload that the resource supports. | _prod_, _dev_, _qa_, _stage_, _test_ |
| Region | The Azure region where the resource is deployed. | _westus_, _eastus2_, _westeurope_, _usgovia_ |

#### Recommended resource-type prefixes

Each workload can consist of many individual resources and services. Incorporating resource type prefixes into your resource names makes it easier to visually identify application or service components.

The following list provides recommended Azure resource type prefixes to use when you define your naming conventions.

| Resource type                       | Resource name prefix |
| ----------------------------------- | -------------------- |
| Resource group                      | rg-                  |
| Availability set                    | avail-               |
| API management service              | api-                 |
| Virtual network                     | vnet-                |
| Virtual network gateway             | vnetgw-              |
| Gateway connection                  | cn-                  |
| Subnet                              | snet-                |
| Network security group              | nsg-                 |
| Route table                         | route-               |
| Virtual machine                     | vm                   |
| VM storage account                  | stvm                 |
| Public IP                           | pip-                 |
| Load balancer                       | lb-                  |
| NIC                                 | nic-                 |
| Key vault                           | kv-                  |
| AKS cluster                         | aks-                 |
| AKS container                       | con-                 |
| Service Bus                         | sb-                  |
| Service Bus queue                   | sbq-                 |
| Service Bus topic                   | sbt-                 |
| App Service plan                    | plan-                |
| Web app                             | app-                 |
| Function app                        | func-                |
| Logic app                           | la-                  |
| Cloud service                       | cld-                 |
| Azure SQL Database server           | sql-                 |
| Azure SQL database                  | sqldb-               |
| Cosmos DB database                  | cosmos-              |
| Azure Cache for Redis cache         | redis-               |
| MySQL database                      | mysql-               |
| PostgreSQL database                 | psql-                |
| Azure SQL Data Warehouse            | sqldw-               |
| SQL Server Stretch Database         | sqlstrdb-            |
| Storage account                     | st                   |
| Azure StorSimple                    | ssimp                |
| Azure Search                        | srch-                |
| Azure Cognitive Services            | cog-                 |
| Azure Machine Learning workspace    | mlw-                 |
| Azure Data Lake Storage             | dls                  |
| Azure Data Lake Analytics           | dla                  |
| Azure HDInsight - Spark             | hdis-                |
| Azure HDInsight - Hadoop            | hdihd-               |
| Azure HDInsight - R Server          | hdir-                |
| Azure HDInsight - HBase             | hdihb-               |
| Power BI Embedded                   | pbi-                 |
| Azure Stream Analytics              | asa-                 |
| Azure Data Factory                  | adf-                 |
| Event hub                           | evh-                 |
| IoT hub                             | iot-                 |
| Notification hubs                   | ntf-                 |
| Notification Hubs namespace         | ntfns-               |

### Metadata tags

When you apply metadata tags to your cloud resources, you can include information about those assets that couldn't be included in the resource name. You can use that information to perform more sophisticated filtering and reporting on resources. You want these tags to include context about the resource's associated workload or application, operational requirements, and ownership information. This information can be used by IT or business teams to find resources or generate reports about resource usage and billing.

What tags you apply to resources and what tags are required or optional differs among organizations. The following list provides examples of common tags that capture important context and information about a resource. Use this list as a starting point to establish your own tagging conventions.

| Tag Name                  | Description                                                                                                                                                                                                    | Key               | Example value                                   |
|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------------|
| Application name          | Name of the application, service, or workload the resource is associated with.                                                                                                                                 | _ApplicationName_ | _{app name}_                                    |
| Approver name             | Person responsible for approving costs related to this resource.                                                                                                                                               | _Approver_        | _{email}_                                       |
| Budget required/approved  | Money allocated for this application, service, or workload.                                                                                                                                                    | _BudgetAmount_    | _{\$}_                                          |
| Business unit             | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this tag might represent a single corporate or shared top-level organizational element. | _BusinessUnit_    | _FINANCE_, _MARKETING_, _{Product Name}_, _CORP_, _SHARED_ |
| Cost center               | Accounting cost center associated with this resource.                                                                                                                                                          | _CostCenter_      | _{number}_                                      |
| Disaster recovery         | Business criticality of the application, workload, or service.                                                                                                                                                | _DR_              | _Mission-critical_, _Critical_, _Essential_         |
| End date of the project   | Date when the application, workload, or service is scheduled for retirement.                                                                                                                                  | _EndDate_         | _{date}_                                        |
| Environment               | Deployment environment of the application, workload, or service.                                                                                                                                              | _Env_             | _Prod_, _Dev_, _QA_, _Stage_, _Test_                    |
| Owner name                | Owner of the application, workload, or service.                                                                                                                                                                | _Owner_           | _{email}_                                       |
| Requester name            | User who requested the creation of this application.                                                                                                                                                          | _Requestor_       | _{email}_                                       |
| Service class             | Service level agreement level of the application, workload, or service.                                                                                                                                       | _ServiceClass_    | _Dev_, _Bronze_, _Silver_, git _Gold_                     |
| Start date of the project | Date when the application, workload, or service was first deployed.                                                                                                                                           | _StartDate_       | _{date}_                                        |

## Sample naming convention

The following section provides examples of naming schemes for common Azure resource types that are deployed during an enterprise cloud deployment.

<!-- markdownlint-disable MD033 -->

### Subscriptions

| Asset type   | Scope                        | Format                                             | Examples                                     |
|--------------|------------------------------|----------------------------------------------------|----------------------------------------------|
| Subscription | Account/Enterprise Agreement | \<Business Unit\>-\<Subscription type\>-\<\#\#\#\> | <ul><li>mktg-prod-001 </li><li>corp-shared-001 </li><li>fin-client-001</li></ul> |

### Resource groups

| Asset type     | Scope        | Format                                                     | Examples                                                                            |
|----------------|--------------|------------------------------------------------------------|-------------------------------------------------------------------------------------|
| Resource group | Subscription | rg-\<App or Service name\>-\<Subscription type\>-\<\#\#\#\> | <ul><li>rg-mktgsharepoint-prod-001 </li><li>rg-acctlookupsvc-share-001 </li><li>rg-ad-dir-services-shared-001</li></ul> |

### Virtual networking

| Asset type               | Scope           | Format                                                                | Examples                                                                                              |
|--------------------------|-----------------|-----------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| Azure Virtual Network          | Resource group  | vnet-\<Subscription type\>-\<Region\>-\<\#\#\#\>                      | <ul><li>vnet-shared-eastus2-001 </li><li>vnet-prod-westus-001 </li><li>vnet-client-eastus2-001</li></ul>                                  |
| Virtual network virtual gateway     | Virtual network | vnetgw-v-\<Subscription type\>-\<Region\>-\<\#\#\#\>                 | <ul><li>vnetgw-v-shared-eastus2-001 </li><li>vnetgw-v-prod-westus-001 </li><li>vnetgw-v-client-eastus2-001</li></ul>                   |
| Virtual network local gateway       | Virtual gateway | vnetgw-l-\<Subscription type\>-\<Region\>-\<\#\#\#\>                 | <ul><li>vnetgw-l-shared-eastus2-001 </li><li>vnetgw-l-prod-westus-001 </li><li>vnetgw-l-client-eastus2-001</li></ul>                   |
| Site-to-site connections | Resource group  | cn-\<local gateway name\>-to-\<virtual gateway name\>                 | <ul><li>cn-l-gw-shared-eastus2-001-to-v-gw-shared-eastus2-001 </li><li>cn-l-gw-shared-eastus2-001-to-shared-westus-001</li></ul> |
| Virtual network connections         | Resource group  | cn-\<subscription1\>\<region1\>-to-\<subscription2\>\<region2\>-      | <ul><li>cn-shared-eastus2-to-shared-westus </li><li>cn-prod-eastus2-to-prod-westus</li></ul>                                     |
| Subnet                   | Virtual network | snet-\<subscription\>-\<subregion\>-\<\#\#\#\>                       | <ul><li>snet-shared-eastus2-001 </li><li>snet-prod-westus-001 </li><li>snet-client-eastus2-001</li></ul>                                  |
| Network security group   | Subnet or NIC   | nsg-\<policy name or appname\>-\<\#\#\#\>                             | <ul><li>nsg-weballow-001 </li><li>nsg-rdpallow-001 </li><li>nsg-sqlallow-001 </li><li>nsg-dnsbloked-001</li></ul>                                  |
| Public IP                | Resource group  | pip-\<vm name or app name\>-\<Environment\>-\<subregion\>-\<\#\#\#\> | <ul><li>pip-dc1-shared-eastus2-001 </li><li>pip-hadoop-prod-westus-001</li></ul>                                                 |

### Azure Virtual Machines

| Asset type         | Scope          | Format                                                              | Examples                                                                             |
|--------------------|----------------|---------------------------------------------------------------------|--------------------------------------------------------------------------------------|
| Azure Virtual Machines    | Resource group | vm\<policy name or appname\>\<\#\#\#\>                              | <ul><li>vmnavigator001 </li><li>vmsharepoint001 </li><li>vmsqlnode001 </li><li>vmhadoop001</li></ul>                              |
| VM storage account | Global         | stvm\<performance type\>\<appname or prodname\>\<region\>\<\#\#\#\> | <ul><li>stvmstcoreeastus2001 </li><li>stvmpmcoreeastus2001 </li><li>stvmstplmeastus2001 </li><li>stvmsthadoopeastus2001</li></ul> |
| DNS label          | Global         | \<A record of vm\>.[\<region\>.cloudapp.azure.com]                  | <ul><li>dc1.westus.cloudapp.azure.com </li><li>web1.eastus2.cloudapp.azure.com</li></ul>                        |
| Azure Load Balancer      | Resource group | lb-\<app name or role\>\<Environment\>\<\#\#\#\>                    | <ul><li>lb-navigator-prod-001 </li><li>lb-sharepoint-dev-001</li></ul>                                          |
| NIC                | Resource group | nic-\<\#\#\>-\<vmname\>-\<subscription\>\<\#\#\#\>                  | <ul><li>nic-01-dc1-shared-001 </li><li>nic-02-vmhadoop1-prod-001 </li><li>nic-02-vmtest1-client-001</li></ul>            |

### PaaS services

| Asset type           | Scope  | Format                                                              | Examples                                                                                 |
|----------------------|--------|---------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| Azure Web Apps       | Global | app-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{azurewebsites.net}] | <ul><li>app-navigator-prod-001.azurewebsites.net </li><li>app-accountlookup-dev-001.azurewebsites.net</li></ul> |
| Azure Functions      | Global | func-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{azurewebsites.net}] | <ul><li>func-navigator-prod-001.azurewebsites.net </li><li>func-accountlookup-dev-001.azurewebsites.net</li></ul> |
| Azure Cloud Services | Global | cld-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{cloudapp.net}]       | <ul><li>cld-navigator-prod-001.azurewebsites.net </li><li>cld-accountlookup-dev-001.azurewebsites.net</li></ul>   |

### Azure Service Bus

| Asset type         | Scope       | Format                                                     | Examples                           |
|--------------------|-------------|------------------------------------------------------------|------------------------------------|
| Azure Service Bus        | Global      | sb-\<App Name\>-\<Environment\>.[{servicebus.windows.net}] | <ul><li>sb-navigator-prod </li><li>sb-emissions-dev</li></ul> |
| Azure Service Bus queues | Service Bus | sbq-\<query descriptor\>                                   | <ul><li>sbq-messagequery</li></ul>                   |
| Azure Service Bus topics | Service Bus | sbt-\<query descriptor\>                                   | <ul><li>sbt-messagequery</li></ul>                   |

### Databases

| Asset type                          | Scope              | Format                                | Examples                                       |
|-------------------------------------|--------------------|---------------------------------------|------------------------------------------------|
| Azure SQL Database Server           | Global             | sql-\<App Name\>-\<Environment\>      | <ul><li>sql-navigator-prod </li><li>sql-emissions-dev</li></ul>           |
| Azure SQL Database                  | Azure SQL Database | sqldb-\<Database Name>-\<Environment\>| <ul><li>sqldb-users-prod </li><li>sqldb-users-dev</li></ul>               |
| Azure Cosmos DB                     | Global             | cosmos-\<App Name\>-\<Environment\>   | <ul><li>cosmos-navigator-prod </li><li>cosmos-emissions-dev</li></ul>       |
| Azure Cache for Redis               | Global             | redis-\<App Name\>-\<Environment\>    | <ul><li>redis-navigator-prod </li><li>redis-emissions-dev</li></ul>       |
| Azure Database for MySQL            | Global             | mysql-\<App Name\>-\<Environment\>    | <ul><li>mysql-navigator-prod </li><li>mysql-emissions-dev</li></ul>       |
| Azure Database for PostgreSQL       | Global             | psql-\<App Name\>-\<Environment\>     | <ul><li>psql-navigator-prod </li><li>psql-emissions-dev</li></ul>         |
| Azure SQL Data Warehouse            | Global             | sqldw-\<App Name\>-\<Environment\>    | <ul><li>sqldw-navigator-prod </li><li>sqldw-emissions-dev</li></ul>       |
| SQL Server Stretch Database         | Azure SQL Database | sqlstrdb-\<App Name\>-\<Environment\> | <ul><li>sqlstrdb-navigator-prod </li><li>sqlstrdb-emissions-dev</li></ul> |

### Storage

| Asset type                              | Scope  | Format                                                                        | Examples                                   |
|-----------------------------------------|--------|-------------------------------------------------------------------------------|--------------------------------------------|
| Azure Storage account - general use     | Global | st\<storage name\>\<\#\#\#\>                                                  | <ul><li>stnavigatordata001 </li><li>stemissionsoutput001</li></ul>    |
| Azure Storage account - diagnostic logs | Global | stdiag\<first 2 letters of subscription name and number\>\<region\>\<\#\#\#\> | <ul><li>stdiagsh001eastus2001 </li><li>stdiagsh001westus001</li></ul> |
| Azure StorSimple                        | Global | ssimp\<App Name\>\<Environment\>                                              | <ul><li>ssimpnavigatorprod </li><li>ssimpemissionsdev</li></ul>       |

### AI + Machine Learning

| Asset type                       | Scope          | Format                            | Examples                               |
|----------------------------------|----------------|-----------------------------------|----------------------------------------|
| Azure Search                     | Global         | srch-\<App Name\>-\<Environment\> | <ul><li>srch-navigator-prod </li><li>srch-emissions-dev</li></ul> |
| Azure Cognitive Services         | Resource group | cog-\<App Name\>-\<Environment\>   | <ul><li>cog-navigator-prod </li><li>cog-emissions-dev</li></ul>     |
| Azure Machine Learning workspace | Resource group | mlw-\<App Name\>-\<Environment\>   | <ul><li>mlw-navigator-prod </li><li>mlw-emissions-dev</li></ul>     |

### Analytics

| Asset type                | Scope  | Format                             | Examples                                 |
|---------------------------|--------|------------------------------------|------------------------------------------|
| Azure Data Factory        | Global | adf-\<App Name\>\<Environment\>    | <ul><li>adf-navigator-prod </li><li>adf-emissions-dev</li></ul>     |
| Azure Data Lake Storage   | Global | dls\<App Name\>\<Environment\>     | <ul><li>dlsnavigatorprod </li><li>dlsemissionsdev</li></ul>         |
| Azure Data Lake Analytics | Global | dla\<App Name\>\<Environment\>     | <ul><li>dlanavigatorprod </li><li>dlaemissionsdev</li></ul>         |
| Azure HDInsight - Spark   | Global | hdis-\<App Name\>-\<Environment\>  | <ul><li>hdis-navigator-prod </li><li>hdis-emissions-dev </li></ul>  |
| Azure HDInsight - Hadoop  | Global | hdihd-\<App Name\>-\<Environment\> | <ul><li>hdihd-hadoop-prod </li><li>hdihd-emissions-dev</li></ul>    |
| Azure HDInsight - R Server| Global | hdir-\<App Name\>-\<Environment\>  | <ul><li>hdir-navigator-prod </li><li>hdir-emissions-dev</li></ul>   |
| Azure HDInsight - HBase   | Global | hdihb-\<App Name\>-\<Environment\> | <ul><li>hdihb-navigator-prod </li><li>hdihb-emissions-dev</li></ul> |
| Power BI Embedded         | Global | pbi-\<App Name\>\<Environment\>    | <ul><li>pbi-navigator-prod </li><li>pbi-emissions-dev</li></ul> |

### Data Streams / Internet of Things (IoT)

| Asset type                         | Scope          | Format                             | Examples                                 |
|------------------------------------|----------------|------------------------------------|------------------------------------------|
| Azure Stream Analytics             | Resource group | asa-\<App Name\>-\<Environment\>   | <ul><li>asa-navigator-prod </li><li>asa-emissions-dev</li></ul>     |
| Azure IoT Hub                      | Global         | iot-\<App Name\>-\<Environment\>   | <ul><li>iot-navigator-prod </li><li>iot-emissions-dev</li></ul>     |
| Azure Event Hubs                   | Global         | evh-\<App Name\>-\<Environment\>   | <ul><li>evh-navigator-prod </li><li>evh-emissions-dev</li></ul>     |
| Azure Notification Hubs            | Resource group | ntf-\<App Name\>-\<Environment\>   | <ul><li>ntf-navigator-prod </li><li>ntf-emissions-dev</li></ul>     |
| Azure Notification Hubs namespace  | Global         | ntfns-\<App Name\>-\<Environment\> | <ul><li>ntfns-navigator-prod </li><li>ntfns-emissions-dev</li></ul> |
