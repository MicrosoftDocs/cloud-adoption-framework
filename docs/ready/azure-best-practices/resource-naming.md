---
title: Define your naming convention
description: Learn about the considerations for naming your Azure resources and assets, and review example names for resources and assets in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, readiness, fasttrack-edit
---

# Define your naming convention

A well-defined naming convention helps to quickly identify information about resources, accelerate deployments, and support effective communication throughout your organization. 

There is not a one size fits all approach to defining a naming convention as each organization will have different needs and preferences. However, there are some best practices, considerations and examples available to help enable orgnaizations develop a standardized naming convention for their Azure deployments.

> [!NOTE]
> Use the Cloud Adoption Framework naming tools to assist you in defing your naming convention
> 
> >[Azure Naming Tool](https://github.com/microsoft/CloudAdoptionFramework/tree/master/ready/AzNamingTool)
> >
> >[Naming and tagging tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx)
 

## Naming components

Naming conventions are comprised of individual "naming components" defined by organizations to quickly identify key information about resources. 

Naming components may include information about the resource types, associated workloads, deployment environments, and the regions where the resources is hosted. For example, a public IP resource for a production SharePoint workload residing in the West US region may be defined as `pip-sharepoint-prod-westus-001`.


![Components of an Azure resource name](../../_images/ready/resource-naming.png)

*Diagram 1: Components of an Azure resource name.*

### Recommended naming components

When you construct your naming convention, identify the key pieces of information you want to reflect in a resource name. Different information is relevant for different resource types, and not all established naming components may be used for each resource type. The intension is to have a standard naming convention for your envrionment that is easy to follow, concise and useful to recognizing information releveant to the resource deployed. 

The following list provides examples of naming components that are useful when you construct resource names.

| Naming component | Description |
|--|--|
| **Organization** | Top level name of organization, normally utilized as top management group or in smaller organizations part of the naming convention. Examples, `contoso`
| **Business unit or department** | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this component might represent a single corporate top-level organizational element. Examples: `fin`, `mktg`, `product`, `it`, `corp` |
| **Resource type** | An abbreviation that represents the type of Azure resource or asset. This component is often used as a prefix or suffix in the name. For more information, see [Recommended abbreviations for Azure resource types](./resource-abbreviations.md). Examples: `rg`, `vm` |
| **Project, application or service name** | Name of a project, application, or service that the resource is a part of. Examples: `navigator`, `emissions`, `sharepoint`, `hadoop` |
| **Environment** | The stage of the development lifecycle for the workload that the resource supports. Examples: `prod`, `dev`, `qa`, `stage`, `test` |
| **Location** | The region or cloud provider where the resource is deployed. Examples:  `westus`, `eastus2`, `westeu`, `usva`, `ustx` |
| **VM Role** | Identifier for the purpose of the VM. Examples: `db` database, `ws` web server, `ps` print server|
| **Instance** | The instance count for a specific resource to identify more than one with the same naming convention. Examples, `01`, `001` |

> [!NOTE]
> While Virtual Machine names in Azure can be longer than the allowed NetBIOS name of the VM, it is recommended to keep them consistant. Please refer to [Computer Names](https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/naming-conventions-for-computer-domain-site-ou#computer-names) for more infomration and additional restrictions.
> 
## Naming considerations 

In addition to defining the naming components, you must also consider the order in which the naming components should be listed, if and what type of delimiters should be utilized between components, and take into account the different naming rules associated with resources types. 

### Scope

All Azure resource types have a scope that defines the level that resource names must be unique. A resource must have a unique name within its scope.

For example, a virtual network has a resource group scope, which means that there can be only one network named `vnet-prod-westus-001` in a given resource group. Other resource groups could have their own virtual network named `vnet-prod-westus-001`. Subnets are scoped to virtual networks, so each subnet within a virtual network must have a distinct name.

Some resource names, such as PaaS services with public endpoints or virtual machine DNS labels, have global scopes, so they must be unique across the entire Azure platform.

![Scope levels for Azure resource names](../../_images/ready/resource-naming-scope.png)

*Diagram 2: Scope levels for Azure resource names.*

### Azure naming rules

Azure naming rules depending on the resource type that must be considered when defining a naming standard. It is important to understand these rules when defining a naming convention to avoid confusion and delay deployments. 

For example, resource names have length limits. It is recommended to keep the length of naming components short to prevent exceeding resource name length limits.

> [!NOTE]
> Balancing the context embedded in a name with its scope and length limit is important when you develop your naming conventions. For more information, see [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules).

### Naming abbreviations

Abbreviating names is a strategy that allows you to shorten the names to reduce the length and complexity of resource naming. Shortening names can be useful for any of the naming components, but especially important to assist in keeping the resource names within the naming length rules. For example, a VM name in azure can be longer than the OS naming restrictions. Keeping Azure VM names shortened to the naming restrictions by the OS helps to keep consistantcy, increase communications about when discussing resources, and reduce confusion when working between Azure portal while being directly logged into the VM itself.

> [!NOTE]
> Review [recommended abbreviations for Azure resource types](./resource-abbreviations.md) when naming your resources and assets.

### Padding schemes

Padding improves readability and sorting of assets when those assets are managed in a configuration management database (CMDB), IT Asset Management tool, or traditional accounting tools. When the deployed asset is managed centrally as part of a larger inventory or portfolio of IT assets, the padding approach aligns with interfaces those systems use to manage inventory naming.

Unfortunately, the traditional asset padding approach can prove problematic in infrastructure-as-code approaches which may iterate through assets based on a non-padded number. This approach is common during deployment or automated configuration management tasks. Those scripts would have to routinely strip the padding and convert the padded number to a real number, which slows script development and run time.

> [!NOTE]
> Choose an approach that's suitable for your organization. The padding shown here illustrates the importance of using a consistent approach to inventory numbering, rather than which approach is superior. Before choosing a numbering scheme (with or without padding), evaluate what will affect long-term operations more: CMDB/asset management solutions or code-based inventory management. Then consistently follow the padding option that best fits your operational needs.

## Example names for common Azure resource types

The following section provides some example names for common Azure resource types in an enterprise cloud deployment. For additional examples, please refer to the 
[Azure Naming Tool](https://github.com/microsoft/CloudAdoptionFramework/tree/master/ready/AzNamingTool) or [Naming and tagging tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx)
 

> [!NOTE]
>  Examples listed below are intended to provide visualization of a naming convention, but actual conventions will vary by orgnaization.  

### Example names: General

| Asset type | Scope | Format and examples |
|--|--|--|
| **Management group** |  Organization / Unit / Department | *mg-\<organization>-\<unit>-\<department>* <br><br> <li> `mg-contoso` <li> `mg-contoso-hr` <li> `mg-hr` |
| **Subscription** | Account / enterprise agreement | *\<department>-\<environment>-\<###>* <br><br> <li> `mktg-prod` <li> `corp-shared-001` |
| **Resource Group** | Subscription | *rg-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `rg-projectcontoso-prod` <li> `rg-sharepoint-dev` <li> `rg-coreservices-shared` |

### Example names: Networking

| Asset type | Scope | Format and examples |
|--|--|--|
| **Virtual network** | Resource group | *vnet-\<environment>-\<region>-\<###>* <br><br> <li> `vnet-shared-eastus2-001` <li> `vnet-prod-westus-001` <li> `vnet-client-eastus2-001` |
| **Virtual network gateway** | Virtual network | *vgw-\<environment>-\<region>-\<###>* <br><br> <li> `vgw-shared-eastus2-001` <li> `vgw-prod-westus-001` <li> `vgw-client-eastus2-001` |
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
