---
title: Define your naming convention
description: Learn about the considerations for naming your Azure resources and assets, and review example names for resources and assets in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, readiness, fasttrack-edit
---

# Define your naming convention

A well-defined naming convention helps to quickly identify information about resources, accelerate deployments, and support effective communication throughout your organization. 

There isn't a one-size-fits-all approach to defining a naming convention. Each organization will have different needs and preferences. However, there are some best practices, considerations, and examples available to help enable orgnaizations develop a standardized naming convention for their Azure deployments.

> [!NOTE]
> Use the Cloud Adoption Framework naming tools to assist you in defing your naming convention:
> 
> - [Azure Naming Tool](https://github.com/microsoft/CloudAdoptionFramework/tree/master/ready/AzNamingTool)
> - [Naming and tagging tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx)
>

## Naming components

An effective naming convention composes resource names from *naming components*. Naming components contain important information about each resource. A good name helps you quickly identify the resource's type, associated workload, deployment environment, and the Azure region hosting it. For example, a public IP resource for a production SharePoint workload in the West US region might be `pip-sharepoint-prod-westus-001`.

![Diagram that shows the components of an Azure resource name.](../../_images/ready/resource-naming.png)

*Diagram 1: Components of an Azure resource name.*

### Recommended naming components

When you construct your naming convention, identify the key pieces of information you want to reflect in a resource name. Different information is relevant for different resource types, and not all established naming components can be used for each resource type. The intention is to have a standard naming convention for your environment that is easy to follow, concise, and useful for recognizing information that's relevant to the deployed resource. 

The following list provides examples of naming components that are useful when you construct resource names:

| Naming component | Description |
|--|--|
| **Organization** | Top-level name of organization, normally utilized as top management group or, in smaller organizations, part of the naming convention. Example: `contoso`
| **Business unit or department** | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this component might represent a single corporate top-level organizational element. Examples: `fin`, `mktg`, `product`, `it`, `corp` |
| **Resource type** | An abbreviation that represents the type of Azure resource or asset. This component often is used as a prefix or suffix in the name. For more information, see [Recommended abbreviations for Azure resource types](./resource-abbreviations.md). Examples: `rg`, `vm` |
| **Project, application, or service name** | Name of a project, application, or service that the resource is a part of. Examples: `navigator`, `emissions`, `sharepoint`, `hadoop` |
| **Environment** | The stage of the development lifecycle for the workload that the resource supports. Examples: `prod`, `dev`, `qa`, `stage`, `test` |
| **Location** | The region or cloud provider where the resource is deployed. Examples:  `westus`, `eastus2`, `westeu`, `usva`, `ustx` |
| **VM role** | Identifier for the purpose of the VM. Examples: `db` (database), `ws` (web server), `ps` (print server) |
| **Instance** | The instance count for a specific resource to identify more than one resource that has the same naming convention. Examples, `01`, `001` |

> [!NOTE]
> Although virtual machine (VM) names in Azure can be longer than the allowed NetBIOS name of the VM, we recommend that you keep them consistent. For more information and for other restrictions, see [Computer names](/troubleshoot/windows-server/identity/naming-conventions-for-computer-domain-site-ou#computer-names).
> 

## Naming considerations 

In addition to defining the naming components, you must also consider the order in which the naming components should be listed, if and what type of delimiters you should use between components, and take into account the different naming rules associated with resources types. 

### Scope

All Azure resource types have a scope that defines the level that resource names must be unique. A resource must have a unique name within its scope.

For example, a virtual network has a resource group scope, which means that there can be only one network named `vnet-prod-westus-001` in a given resource group. Other resource groups could have their own virtual network named `vnet-prod-westus-001`. Subnets are scoped to virtual networks, so each subnet within a virtual network must have a distinct name.

Some resource names, such as PaaS services with public endpoints or virtual machine DNS labels, have global scopes, so they must be unique across the entire Azure platform.

![Diagram that shows the scope levels for Azure resource names.](../../_images/ready/resource-naming-scope.png)

*Diagram 2: Scope levels for Azure resource names.*

### Azure naming rules

Azure naming rules vary depending on the resource type. When you define a naming convention, it's important to understand Azure naming rules for the resource type to avoid confusion and delay deployments. 

For example, resource names have length limits. We recommend that you keep the length of naming components short to prevent exceeding resource name length limits.

> [!NOTE]
> Balancing the context of a name with its scope and name length limit is important when you develop your naming conventions. For more information, see [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules).

### Naming abbreviations

You can abbreviate resource names and naming components as a strategy to reduce the length and complexity of resource names. Shortening names can be useful for any of the naming components, but it's especially important to help you keep resource names within name length limits. For example, a VM name in Azure can be longer than the OS naming restrictions. Keeping Azure VM names shorter than the naming restrictions of the OS helps create consistency, improve communication when discussing resources, and reduce confusion when you are working in the Azure portal while being signed in to the VM itself.

| Naming component | Description |
|--|--|
| **Resource type** | An abbreviation that represents the type of Azure resource or asset. This component is often used as a prefix or suffix in the name. For more information, see [Recommended abbreviations for Azure resource types](./resource-abbreviations.md). <br/> Examples: `rg`, `vm` |
| **Business unit** | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this component might represent a single corporate top-level organizational element. <br/> Examples: `fin`, `mktg`, `product`, `it`, `corp` |
| **Application or service name** | Name of the application, workload, or service that the resource is a part of. <br/> Examples: `navigator`, `emissions`, `sharepoint`, `hadoop` |
| **Subscription type** | Summary description of the purpose of the subscription that contains the resource. Often broken down by deployment environment type or specific workloads. <br/> Examples: `prod`, `shared`, `client` |
| **Deployment&nbsp;environment** | The stage of the development lifecycle for the workload that the resource supports. <br/> Examples: `prod`, `dev`, `qa`, `stage`, `test` |
| **Region** | The Azure region where the resource is deployed. <br/> Examples: `westus`, `eastus2`, `westeu`, `usva`, `ustx` |

> [!NOTE]
> When you're ready to name your resources and assets, review [Recommended abbreviations for Azure resource types](./resource-abbreviations.md).

### Padding schemes

Padding improves readability and helps you sort assets when those assets are managed in a configuration management database (CMDB) or IT asset management tool, or when using traditional accounting tools. When the deployed asset is managed centrally as part of a larger inventory or portfolio of IT assets, the padding approach aligns with interfaces those systems use to manage inventory naming.

Unfortunately, the traditional asset padding approach can prove problematic in infrastructure-as-code approaches, which might iterate through assets based on a non-padded number. This approach is common during deployment or automated configuration management tasks. Those scripts would have to routinely strip the padding and convert the padded number to a real number, which slows script development and runtime.

> [!NOTE]
> Choose an approach that's suitable for your organization. Some of the example names described later in this article use a three-digit padding scheme (`###`), such as `mktg-prod-001`. The padding shown here illustrates the importance of using a consistent approach to inventory numbering, rather than which approach is superior. Before choosing a numbering scheme (with or without padding), evaluate what will affect long-term operations more: CMDB/asset management solutions or code-based inventory management. Then consistently follow the padding option that best fits your operational needs.

## Example names for common Azure resource types

The following section provides some example names for common Azure resource types in an enterprise cloud deployment. For additional examples, see the 
[Azure Naming Tool](https://github.com/microsoft/CloudAdoptionFramework/tree/master/ready/AzNamingTool) and the [Naming and tagging tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx).

> [!NOTE]
> The following examples are intended to provide visualization of a naming convention, but actual conventions will vary by organization.  

### Example names: General

| Asset type | Scope | Format and examples |
|--|--|--|
| **Management group** |  Organization / Unit / Department | *mg-\<organization>-\<unit>-\<department>* <br><br> <li> `mg-contoso` <li> `mg-contoso-hr` <li> `mg-hr` |
| **Subscription** | Account / enterprise agreement | *\<department>-\<environment>-\<###>* <br><br> <li> `mktg-prod` <li> `corp-shared-001` |
| **Resource group** | Subscription | *rg-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `rg-projectcontoso-prod` <li> `rg-sharepoint-dev` <li> `rg-coreservices-shared` |

### Example names: Networking

| Asset type | Scope | Format and examples |
|--|--|--|
| **Virtual network** | Resource group | *vnet-\<subscription&nbsp;type>-\<region>-\<###>* <br><br> <li> `vnet-shared-eastus2-001` <li> `vnet-prod-westus-001` <li> `vnet-client-eastus2-001` |
| **Virtual network gateway** | Virtual network | *vgw-\<environment>-\<region>-\<###>* <br><br> <li> `vgw-shared-eastus2-001` <li> `vgw-prod-westus-001` <li> `vgw-client-eastus2-001` |
| **Subnet** | Virtual network | *snet-\<subscription>-\<region>-\<###>* <br><br> <li> `snet-shared-eastus2-001` <li> `snet-prod-westus-001` <li> `snet-client-eastus2-001` |
| **Network interface (NIC)** | Resource group | *nic-<##>-\<vm&nbsp;name>-\<subscription>-\<###>* <br><br> <li> `nic-01-dc1-shared-001` <li> `nic-02-vmhadoop1-prod-001` <li> `nic-02-vmtest1-client-001` |
| **Public IP address** | Resource group | *pip-\<vm&nbsp;name&nbsp;or&nbsp;app&nbsp;name>-\<environment>-\<region>-\<###>* <br><br> <li> `pip-dc1-shared-eastus2-001` <li> `pip-hadoop-prod-westus-001` |
| **Load balancer** | Resource group | *lb-\<app&nbsp;name&nbsp;or&nbsp;role>-\<environment>-\<###>* <br><br> <li> `lb-navigator-prod-001` <li> `lb-sharepoint-dev-001` |
| **Network security group (NSG)** | Subnet or NIC | *nsg-\<policy&nbsp;name&nbsp;or&nbsp;app&nbsp;name>-\<###>* <br><br> <li> `nsg-weballow-001` <li> `nsg-rdpallow-001` <li> `nsg-sqlallow-001` <li> `nsg-dnsblocked-001` |
| **Local network gateway** | Virtual gateway | *lgw-\<subscription&nbsp;type>-\<region>-\<###>* <br><br> <li> `lgw-shared-eastus2-001` <li> `lgw-prod-westus-001` <li> `lgw-client-eastus2-001` |
| **Site-to-Site connection** | Resource group | *cn-\<local&nbsp;gateway&nbsp;name>-to-\<virtual&nbsp;gateway&nbsp;name>* <br><br> <li> `cn-lgw-shared-eastus2-001-to-vgw-shared-eastus2-001` <li> `cn-lgw-shared-eastus2-001-to-vgw-shared-westus-001` |

### Example names: Compute and Web

| Asset type | Scope | Format and examples |
|--|--|--|
| **Virtual machine** | Resource group | *vm\<vm&nbsp;role>\<environment><###>* <br><br> <li> `vmsqltest001` <li> `vmhadoopprod001` |
| **Web app** | Global | *app-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>-\<###>.azurewebsites.net* <br><br> <li> `app-navigator-prod-001.azurewebsites.net` <li> `app-accountlookup-dev-001.azurewebsites.net` |
| **Function app** | Global | *func-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>-\<###>.azurewebsites.net* <br><br> <li> `func-navigator-prod-001.azurewebsites.net` <li> `func-accountlookup-dev-001.azurewebsites.net` |

### Example names: Databases

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure SQL database** | Azure SQL Database | *sqldb-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `sqldb-users-prod` <li> `sqldb-users-dev` |
| **Azure Cosmos DB database** | Global | *cosmos-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `cosmos-navigator-prod` <li> `cosmos-emissions-dev` |
| **Azure Cache for Redis instance** | Global | *redis-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `redis-navigator-prod` <li> `redis-emissions-dev` |
  
### Example names: Storage

| Asset type | Scope | Format and examples |
|--|--|--|
| **Storage account (general use)** | Global | *st\<project,&nbsp;app&nbsp;or&nbsp;service>\<###>* <br><br> <li> `stnavigatordata001` <li> `stemissionsoutput001` |
| **Azure StorSimple** | Global | *ssimp\<project,&nbsp;app&nbsp;or&nbsp;service>\<environment>* <br><br> <li> `ssimpnavigatorprod` <li> `ssimpemissionsdev` |
| **Azure Container Registry** | Global | *cr\<project,&nbsp;app&nbsp;or&nbsp;service>\<environment>\<###>* <br><br> <li> `crnavigatorprod001` |

### Example names: AI and machine learning

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure Cognitive Search** | Global | *srch-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `srch-navigator-prod` <li> `srch-emissions-dev` |
| **Azure Cognitive Services** | Resource group | *cog-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `cog-navigator-prod` <li> `cog-emissions-dev` |
| **Azure Machine Learning workspace** | Resource group | *mlw-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `mlw-navigator-prod` <li> `mlw-emissions-dev` |

### Example names: Analytics and IoT

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure Data Factory** | Global | *adf-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `adf-navigator-prod` <li> `adf-emissions-dev` |
| **Azure Stream Analytics** | Resource group | *asa-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `asa-navigator-prod` <li> `asa-emissions-dev` |
| **Data Lake Storage account** | Global | *dls\<project,&nbsp;app&nbsp;or&nbsp;service>\<environment>* <br><br> <li> `dlsnavigatorprod` <li> `dlsemissionsdev` |
| **IoT hub** | Global | *iot-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `iot-navigator-prod` <li> `iot-emissions-dev` |

### Example names: Integration

| Asset type | Scope | Format and Examples|
|--|--|--|
| **Service Bus** | Global | *sb-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>.servicebus.windows.net* <br><br> <li> `sb-navigator-prod.servicebus.windows.net` <li> `sb-emissions-dev.servicebus.windows.net` |
| **Service Bus queue** | Service Bus | *sbq-\<query descriptor>* <br><br> <li> `sbq-messagequery` |
| **Service Bus topic** | Service Bus | *sbt-\<query descriptor>* <br><br> <li> `sbt-messagequery` |
