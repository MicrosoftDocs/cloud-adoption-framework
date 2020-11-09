---
title: Recommended naming and tagging conventions
description: Learn detailed resource naming and tagging recommendations aimed specifically at supporting enterprise cloud adoption efforts.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/05/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: readiness, fasttrack-edit
---

<!-- docutune:disable -->
<!-- cSpell:ignore appcs arck cdnp cdne osdisk westeurope usgovia accountlookup messagequery -->

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

## Example names

The following section provides some example names for common Azure resource types in an enterprise cloud deployment.

<!-- TODO: Use tick marks for names. -->

<!-- cSpell:ignore mktgsharepoint acctlookupsvc vmhadoop vmtest vmsharepoint vmnavigator vmsqlnode stvmstcoreeastus stvmpmcoreeastus stvmstplmeastus stvmsthadoopeastus stnavigatordata stemissionsoutput stdiag stdiagsh ssimpnavigatorprod ssimpemissionsdev dlanavigatorprod dlsnavigatorprod dlaemissionsdev dlsemissionsdev weballow rdpallow sqlallow dnsblocked cloudapp azurewebsites servicebus appcn keda acrnavigatorprod -->

<!-- markdownlint-disable MD024 -->

### Example names: General

| Asset type                      | Scope                                 | Format                                                      | Examples                                                                                           |
|---------------------------------|---------------------------------------|-------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| Management group                | Business unit and/or Environment type | mg-\<Business Unit\>\[-\<Environment type\>\]               | <li> mg-mktg <li> mg-hr <li> mg-corp-prod <li> mg-fin-client                                       |
| Subscription                    | Account/ <br> Enterprise Agreement    | \<Business Unit\>-\<Subscription type\>-\<\#\#\#\>          | <li> mktg-prod-001 <li> corp-shared-001 <li> fin-client-001                                        |
| Resource group                  | Subscription                          | rg-\<App or service name\>-\<Subscription type\>-\<\#\#\#\> | <li> rg-mktgsharepoint-prod-001 <li> rg-acctlookupsvc-share-001 <li> rg-ad-dir-services-shared-001 |
| API management service instance | Global                                | apim-\<App or service name\>                                | apim-navigator-prod                                                                                |
| Managed Identity                | Resource group                        | id-\<App or service name\>                                  | id-appcn-keda-prod-eus-001                                                                         |

> [!NOTE]
> The example names above and elsewhere in this document reference a three digit padding (\<\#\#\#\>). I.E.  mktg-prod-*001*
>
> Padding aids in human readability and sorting of assets when those assets are managed in a configuration management database (CMDB), IT Asset Management tool, or traditional accounting tools. When the deployed asset is managed centrally as part of a larger inventory or portfolio of IT assets, the padding approach aligns with interfaces those systems use to manage inventory naming.
>
> Unfortunately, the traditional asset padding approach can prove problematic in infrastructure-as-code approaches which may iterate through assets based on a non-padded number. This approach is common during deployment or automated configuration management tasks. Those scripts would have to routinely strip the padding and convert the padded number to a real number, which slows script development and run time.
>
> Which approach you choose to implement is a personal decision. The padding in this article is meant to illustrate the importance of using a consistent approach to inventory numbering, not which approach is superior. Before deciding on a number schema (with or without padding) evaluate which will have a bigger impact on long term operations: CMDB/asset management solutions or code-based inventory management. Then consistently follow the padding option that best fits your operational needs.

### Example names: Networking

| Asset type                   | Scope           | Format                                                               | Examples                                                                                                                      |
|------------------------------|-----------------|----------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| Virtual network              | Resource group  | vnet-\<Subscription type\>-\<Region\>-\<\#\#\#\>                     | <li> vnet-shared-eastus2-001 <li> vnet-prod-westus-001 <li> vnet-client-eastus2-001 |
| Subnet                       | Virtual network | snet-\<subscription\>-\<subregion\>-\<\#\#\#\>                       | <li> snet-shared-eastus2-001 <li> snet-prod-westus-001 <li> snet-client-eastus2-001 |
| Network interface (NIC)      | Resource group  | nic-\<\#\#\>-\<vm name\>-\<subscription\>-\<\#\#\#\>                   | <li> nic-01-dc1-shared-001 <li> nic-02-vmhadoop1-prod-001 <li> nic-02-vmtest1-client-001 |
| Public IP address            | Resource group  | pip-\<vm name or app name\>-\<Environment\>-\<subregion\>-\<\#\#\#\> | <li> pip-dc1-shared-eastus2-001 <li> pip-hadoop-prod-westus-001 |
| Load balancer                | Resource group  | lb-\<app name or role\>\<Environment\>\<\#\#\#\>                     | <li> lb-navigator-prod-001 <li> lb-sharepoint-dev-001 |
| Network security group (NSG) | Subnet or NIC   | nsg-\<policy name or app name\>-\<\#\#\#\>                           | <li> nsg-weballow-001 <li> nsg-rdpallow-001 <li> nsg-sqlallow-001 <li> nsg-dnsblocked-001 |
| Local network gateway        | Virtual gateway | lgw-\<Subscription type\>-\<Region\>-\<\#\#\#\>                      | <li> lgw-shared-eastus2-001 <li> lgw-prod-westus-001 <li> lgw-client-eastus2-001 |
| Virtual network gateway      | Virtual network | vgw-\<Subscription type\>-\<Region\>-\<\#\#\#\>                      | <li> vgw-shared-eastus2-001 <li> vgw-prod-westus-001 <li> vgw-client-eastus2-001 |
| Site-to-site connection      | Resource group  | cn-\<local gateway name\>-to-\<virtual gateway name\>                | <li> cn-lgw-shared-eastus2-001-to-vgw-shared-eastus2-001 <li> cn-lgw-shared-eastus2-001-to-shared-westus-001 |
| VPN connection               | Resource group  | cn-\<subscription1\>\<region1\>-to-\<subscription2\>\<region2\>-     | <li> cn-shared-eastus2-to-shared-westus <li> cn-prod-eastus2-to-prod-westus |
| Route table                  | Resource group  | route-\<route table name\>                                           | <li> route-navigator <li> route-sharepoint |
| DNS label                    | Global          | \<A record of vm\>.<region\>.cloudapp.azure.com                   | <li> dc1.westus.cloudapp.azure.com <li> web1.eastus2.cloudapp.azure.com |

### Example names: Compute and Web

| Asset type                  | Scope          | Format                                                              | Examples                                                                                                                          |
|-----------------------------|----------------|---------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| Virtual machine             | Resource group | vm\<policy name or app name\>\<\#\#\#\>                              | <li> vmnavigator001 <li> vmsharepoint001 <li> vmsqlnode001 <li> vmhadoop001 |
| VM storage account          | Global         | stvm\<performance type\>\<app name or prod name\>\<region\>\<\#\#\#\> | <li> stvmstcoreeastus2001 <li> stvmpmcoreeastus2001 <li> stvmstplmeastus2001 <li> stvmsthadoopeastus2001 |
| Web app                     | Global         | app-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{azurewebsites.net}]   | <li> app-navigator-prod-001.azurewebsites.net <li> app-accountlookup-dev-001.azurewebsites.net |
| Function app                | Global         | func-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{azurewebsites.net}]  | <li> func-navigator-prod-001.azurewebsites.net <li> func-accountlookup-dev-001.azurewebsites.net |
| Cloud service               | Global         | cld-\<App Name\>-\<Environment\>-\<\#\#\#\>.[{cloudapp.net}]        | <li> cld-navigator-prod-001.azurewebsites.net <li> cld-accountlookup-dev-001.azurewebsites.net |
| Notification hub            | Resource group | ntf-\<App Name\>-\<Environment\>                                    | <li> ntf-navigator-prod <li> ntf-emissions-dev |
| Notification Hubs namespace | Global         | ntfns-\<App Name\>-\<Environment\>                                  | <li> ntfns-navigator-prod <li> ntfns-emissions-dev |

### Example names: Databases

| Asset type                     | Scope              | Format                                 | Examples                                                                  |
|--------------------------------|--------------------|----------------------------------------|---------------------------------------------------------------------------|
| Azure SQL Database server      | Global             | sql-\<App Name\>-\<Environment\>       | <li> sql-navigator-prod <li> sql-emissions-dev |
| Azure SQL database             | Azure SQL Database | sqldb-\<Database Name>-\<Environment\> | <li> sqldb-users-prod <li> sqldb-users-dev |
| Azure Cosmos DB database       | Global             | cosmos-\<App Name\>-\<Environment\>    | <li> cosmos-navigator-prod <li> cosmos-emissions-dev |
| Azure Cache for Redis instance | Global             | redis-\<App Name\>-\<Environment\>     | <li> redis-navigator-prod <li> redis-emissions-dev |
| MySQL database                 | Global             | mysql-\<App Name\>-\<Environment\>     | <li> mysql-navigator-prod <li> mysql-emissions-dev |
| PostgreSQL database            | Global             | psql-\<App Name\>-\<Environment\>      | <li> psql-navigator-prod <li> psql-emissions-dev |
| Azure SQL Data Warehouse       | Global             | sqldw-\<App Name\>-\<Environment\>     | <li> sqldw-navigator-prod <li> sqldw-emissions-dev |
| SQL Server Stretch Database    | Azure SQL Database | sqlstrdb-\<App Name\>-\<Environment\>  | <li> sqlstrdb-navigator-prod <li> sqlstrdb-emissions-dev |

### Example names: Storage

| Asset type                        | Scope  | Format                                                                        | Examples                                                              |
|-----------------------------------|--------|-------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| Storage account (general use)     | Global | st\<storage name\>\<\#\#\#\>                                                  | <li> stnavigatordata001 <li> stemissionsoutput001 |
| Storage account (diagnostic logs) | Global | stdiag\<first 2 letters of subscription name and number\>\<region\>\<\#\#\#\> | <li> stdiagsh001eastus2001 <li> stdiagsh001westus001 |
| Azure StorSimple                  | Global | ssimp\<App Name\>\<Environment\>                                              | <li> ssimpnavigatorprod <li> ssimpemissionsdev |
| Azure Container Registry          | Global | acr\<App Name\>\<Environment\>\<\#\#\#\>                                      | <li> acrnavigatorprod001 |

### Example names: AI and machine learning

| Asset type                       | Scope          | Format                            | Examples                                                          |
|----------------------------------|----------------|-----------------------------------|-------------------------------------------------------------------|
| Azure Cognitive Search           | Global         | srch-\<App Name\>-\<Environment\> | <li> srch-navigator-prod <li> srch-emissions-dev |
| Azure Cognitive Services         | Resource group | cog-\<App Name\>-\<Environment\>  | <li> cog-navigator-prod <li> cog-emissions-dev |
| Azure Machine Learning workspace | Resource group | mlw-\<App Name\>-\<Environment\>  | <li> mlw-navigator-prod <li> mlw-emissions-dev |

### Example names: Analytics and IoT

| Asset type                  | Scope          | Format                              | Examples                                                              |
|-----------------------------|----------------|-------------------------------------|-----------------------------------------------------------------------|
| Azure Data Factory          | Global         | adf-\<App Name\>\<Environment\>     | <li> adf-navigator-prod <li> adf-emissions-dev |
| Azure Stream Analytics      | Resource group | asa-\<App Name\>-\<Environment\>    | <li> asa-navigator-prod <li> asa-emissions-dev |
| Data Lake Analytics account | Global         | dla\<App Name\>\<Environment\>      | <li> dlanavigatorprod <li> dlaemissionsdev |
| Data Lake Storage account   | Global         | dls\<App Name\>\<Environment\>      | <li> dlsnavigatorprod <li> dlsemissionsdev |
| Event hub                   | Global         | evh-\<App Name\>-\<Environment\>    | <li> evh-navigator-prod <li> evh-emissions-dev |
| HDInsight - HBase cluster   | Global         | hbase-\<App Name\>-\<Environment\>  | <li> hbase-navigator-prod <li> hbase-emissions-dev |
| HDInsight - Hadoop cluster  | Global         | hadoop-\<App Name\>-\<Environment\> | <li> hadoop-navigator-prod <li> hadoop-emissions-dev |
| HDInsight - Spark cluster   | Global         | spark-\<App Name\>-\<Environment\>  | <li> spark-navigator-prod <li> spark-emissions-dev  |
| IoT hub                     | Global         | iot-\<App Name\>-\<Environment\>    | <li> iot-navigator-prod <li> iot-emissions-dev |
| Power BI Embedded           | Global         | pbi-\<App Name\>\<Environment\>     | <li> pbi-navigator-prod <li> pbi-emissions-dev |

### Example names: Integration

| Asset type        | Scope       | Format                                                     | Examples                                                      |
|-------------------|-------------|------------------------------------------------------------|---------------------------------------------------------------|
| Service Bus       | Global      | sb-\<App Name\>-\<Environment\>.[{servicebus.windows.net}] | <li> sb-navigator-prod <li> sb-emissions-dev |
| Service Bus queue | Service Bus | sbq-\<query descriptor\>                                   | <li> sbq-messagequery |
| Service Bus topic | Service Bus | sbt-\<query descriptor\>                                   | <li> sbt-messagequery |
