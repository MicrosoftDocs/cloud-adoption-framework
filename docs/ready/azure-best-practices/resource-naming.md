---
title: Define your naming convention
description: Learn about the considerations for naming your Azure resources and assets, and review example names for resources and assets in Azure.
author: stephen-sumner
ms.author: pnp
ms.date: 07/01/2025
ms.topic: conceptual
---

# Define your naming convention

A well-defined naming and tagging strategy forms the foundation of effective Azure cloud governance and security. These conventions enable you to maintain an inventory of Azure resources, track and allocate costs, and respond to incidents by quickly identifying affected resources. Define your naming and tagging strategy early to ensure consistency and clarity across your environment. This article provides recommendations for creating a naming convention. For tagging guidance, see [Define a tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging).

## Why use a naming convention?

An Azure naming convention is a standardized format used to assign names to Azure resources. It ensures clarity, consistency, and adherence to Azure's naming rules, such as length requirements, valid characters, and scope uniqueness. A naming convention must be tailored to your specific needs, as no single naming convention meets the requirements of every environment.

## Understand resource names in Azure

An Azure resource name is the identifier assigned to a specific instance of an Azure resource, such as a web app, database, or storage account. To establish a consistent naming convention, you need to understand how Azure works. Here's what you need to know:

1. **Understand name permanence.** Azure resource names can't be changed after creation. Include only information that remains constant in the name. Use tags to capture other details.

1. **Understand Azure naming rules.** There are [naming rules for every Azure resource](/azure/azure-resource-manager/management/resource-name-rules). Not all Azure resource names can follow the same patterns. Make sure you understand the limitations of the resource types you're working with. Azure names must follow three general principles:

    - Names need to be unique within the scope of the Azure resource (varies by resource).
    - Names need to meet length requirements (varies by resource).
    - Names can only contain valid characters (varies by resource).

1. **Understand Azure name scope.** Azure resource names must be unique within their defined scope. Each resource type has a specific scope level that determines where the name must be unique. Understanding these scope levels ensures proper naming conventions and avoids conflicts.

    | Scope | Description | Example |
    |-------|-------------|---------|
    | **Global** | Unique across all of Azure. This scope applies to PaaS resources with public IP endpoints, as their names serve as the initial default public DNS name. | For example, a web app named `app-navigator-prod-001.azurewebsites.net` must be globally unique. |
    | **Resource group** | Unique within the resource group. Resources in the same group can't share the same name, but identical names can exist in different resource groups. | For example, a virtual network named `vnet-prod-westus-001` can exist in multiple resource groups, but only once within a single resource group. |
    | **Resource** | Unique within the parent resource. Resources nested within another resource must have unique names to avoid conflicts. | For example, subnets within a virtual network must have unique names to prevent segment overlap. |

## Choose naming components

When you construct your naming convention, identify the key pieces of information that you want to capture in a resource name. Different information is relevant for different resource types, and not all established naming components can be used for each resource type. Establish a standard naming convention for your environment that is easy to follow, concise, and useful for recognizing information that's relevant to the deployed resource. The following list provides examples of naming components that are useful when you construct resource names:

| Naming component | Description |
|--|--|
| **Organization** | Top-level name of the organization, normally utilized as the top management group or, in smaller organizations, part of the naming convention. Example: `contoso` |
| **Business unit or department** | Top-level division of your company that owns the subscription or the workload that the resource belongs to. In smaller organizations, this component might represent a single corporate, top-level organizational element. Examples: `fin`, `mktg`, `product`, `it`, `corp` |
| **Resource type** | An abbreviation that represents the type of Azure resource or asset. This component is often a prefix or suffix in the name. For more information, see [Recommended abbreviations for Azure resource types](./resource-abbreviations.md). Examples: `rg`, `vm` |
| **Workload, application, or project** | Name of a workload, application, or project that the resource is a part of. Examples: `navigator`, `emissions`, `sharepoint`, `hadoop` |
| **Environment** | The stage of the development lifecycle for the workload that the resource supports. Examples: `prod`, `dev`, `qa`, `stage`, `test` |
| **Region** | The region or cloud provider where the resource is deployed. Examples:  `westus`, `eastus2`, `westeu`, `usva`, `ustx` |
| **Instance** | The instance count for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, `01`, `001` |

### Develop your naming convention

When you construct your naming convention, identify the key pieces of information that you want to reflect in a resource name. Different information is relevant for different resource types.

1. **Standardize component order.** In addition to defining the naming components, you must also consider the order in which the naming components are listed.

1. **Choose to use a delimiter or not.** To improve readability, use a hyphen `-` to separate naming components. However, not every resource in Azure allows you to use a delimiter. If you need absolute consistency across all your Azure resource names, don't use a hyphen. For many customers, the benefits of using a delimiter outweigh some inconsistency in the naming convention.

1. **Use abbreviations.** Use [Azure resource abbreviations](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) to keep resource names within length limits.

1. **Use the Azure Naming Tool**: The Azure Naming Tool is a tool that helps you generate names for Azure resources. You configure the tool to use your preferred naming convention, and it generates names for your Azure resources. For more information, see [Azure Naming Tool](https://github.com/mspnp/AzureNamingTool).

1. **Consider naming consistency for VMs.** If you're working with VMs in Azure, we recommend keeping names consistent even though VM names in Azure can be longer than the allowed NetBIOS name of the VM. For more information and for other restrictions, see [Naming conventions in Active Directory for computers, domains, sites, and OUs - Computer names](/troubleshoot/windows-server/identity/naming-conventions-for-computer-domain-site-ou#computer-names).

## Example Azure resource names

Consider these examples when you define your naming convention. The examples are based on the naming components and considerations that are described in this article.

### AI and machine learning

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure AI Search** | Global | *srch-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `srch-navigator-prod` <li> `srch-emissions-dev` |
| **Azure OpenAI Service** | Resource group | *oai-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `oai-navigator-prod` <li> `oai-emissions-dev` |
| **Azure Machine Learning workspace** | Resource group | *mlw-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `mlw-navigator-prod` <li> `mlw-emissions-dev` |

### Analytics and IoT

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure Analysis Services** | Global | *as\<app name>\<environment>* <br><br> <li> `asnavigatorprod` <li> `asemissionsdev` |
| **Azure Data Factory** | Global | *adf-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `adf-navigator-prod` <li> `adf-emissions-dev` |
| **Data Lake Storage account** | Global | *dls\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<environment>* <br><br> <li> `dlsnavigatorprod` <li> `dlsemissionsdev` |
| **IoT hub** | Global | *iot-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `iot-navigator-prod` <li> `iot-emissions-dev` |

### Compute and web

| Asset type | Scope | Format and examples |
|--|--|--|
| **Virtual machine** | Resource group | *vm-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>-<###>* <br><br> <li> `vm-sql-test-001` <li> `vm-hadoop-prod-001` <li> `vm-sharepoint-dev-001` |
| **Web app** | Global | *app-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>-\<###>.azurewebsites.net* <br><br> <li> `app-navigator-prod-001.azurewebsites.net` <li> `app-accountlookup-dev-001.azurewebsites.net` |
| **Function app** | Global | *func-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>-\<###>.azurewebsites.net* <br><br> <li> `func-navigator-prod-001.azurewebsites.net` <li> `func-accountlookup-dev-001.azurewebsites.net` |

### Databases

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure SQL database** | Azure SQL Server | *sqldb-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `sqldb-users-prod` <li> `sqldb-users-dev` |
| **Azure Cosmos DB database** | Global | *cosmos-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `cosmos-navigator-prod` <li> `cosmos-emissions-dev` |
| **Azure Cache for Redis instance** | Global | *redis-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `redis-navigator-prod` <li> `redis-emissions-dev` |

### Integration

| Asset type | Scope | Format and Examples|
|--|--|--|
| **API management service instance** | Global | *apim-\<app&nbsp;or&nbsp;service&nbsp;name>* <br><br> `apim-navigator-prod` |
| **Service Bus namespace** | Global | *sbns-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>.servicebus.windows.net* <br><br> <li> `sbns-navigator-prod.servicebus.windows.net` <li> `sbns-emissions-dev.servicebus.windows.net` |
| **Service Bus queue** | Service Bus | *sbq-\<workload,&nbsp;application,&nbsp;or&nbsp;project>* <br><br> <li> `sbq-navigator` |
| **Service Bus topic** | Service Bus | *sbt-\<workload,&nbsp;application,&nbsp;or&nbsp;project>* <br><br> <li> `sbt-navigator` |

### Management and governance

| Asset type | Scope | Format and examples |
|--|--|--|
| **Management group** | Business unit and/or <br> environment | *mg-\<business unit>[-\<environment>]* <br><br> <li> `mg-mktg` <li> `mg-hr` <li> `mg-corp-prod` <li> `mg-fin-client` |
| **Subscription** | Account / enterprise agreement | *\<business&nbsp;unit>-\<subscription&nbsp;purpose>-\<###>* <br><br> <li> `mktg-prod-001` <li> `corp-shared-001` <li> `fin-client-001` |
| **Resource group** | Subscription | *rg-\<app&nbsp;or&nbsp;service&nbsp;name>-<subscription&nbsp;purpose>-\<###>* <br><br> <li> `rg-mktgsharepoint-prod-001` <li> `rg-acctlookupsvc-shared-001` <li> `rg-ad-dir-services-shared-001` |

### Networking

| Asset type | Scope | Format and examples |
|--|--|--|
| **Virtual network** | Resource group | *vnet-\<subscription&nbsp;purpose>-\<region>-\<###>* <br><br> <li> `vnet-shared-eastus2-001` <li> `vnet-prod-westus-001` <li> `vnet-client-eastus2-001` |
| **Subnet** | Virtual network | *snet-\<subscription&nbsp;purpose>-\<region>-\<###>* <br><br> <li> `snet-shared-eastus2-001` <li> `snet-prod-westus-001` <li> `snet-client-eastus2-001` |
| **Network interface (NIC)** | Resource group | *nic-<##>-\<vm&nbsp;name>-\<subscription&nbsp;purpose>-\<###>* <br><br> <li> `nic-01-dc1-shared-001` <li> `nic-02-vmhadoop1-prod-001` <li> `nic-02-vmtest1-client-001` |
| **Public IP address** | Resource group | *pip-\<vm&nbsp;name&nbsp;or&nbsp;app&nbsp;name>-\<environment>-\<region>-\<###>* <br><br> <li> `pip-dc1-shared-eastus2-001` <li> `pip-hadoop-prod-westus-001` |
| **Load balancer (external)** | Resource group | *lbe-\<app&nbsp;name&nbsp;or&nbsp;role>-\<environment>-\<###>* <br><br> <li> `lbe-navigator-prod-001` <li> `lbe-sharepoint-dev-001` |
| **Network security group (NSG)** | Subnet or NIC | *nsg-\<policy&nbsp;name&nbsp;or&nbsp;app&nbsp;name>-\<###>* <br><br> <li> `nsg-weballow-001` <li> `nsg-rdpallow-001` <li> `nsg-sqlallow-001` <li> `nsg-dnsblocked-001` |
| **Local network gateway** | Virtual gateway | *lgw-\<subscription&nbsp;purpose>-\<region>-\<###>* <br><br> <li> `lgw-shared-eastus2-001` <li> `lgw-prod-westus-001` <li> `lgw-client-eastus2-001` |
| **Virtual network gateway** | Virtual network | *vgw-\<subscription&nbsp;purpose>-\<region>-\<###>* <br><br> <li> `vgw-shared-eastus2-001` <li> `vgw-prod-westus-001` <li> `vgw-client-eastus2-001` |
| **VPN connection** | Resource group | *vcn-\<subscription1&nbsp;purpose>>-\<region1>-to-\<subscription2&nbsp;purpose>>-\<region2>-* <br><br> <li> `vcn-shared-eastus2-to-shared-westus` <li> `vcn-prod-eastus2-to-prod-westus` |
| **Route table** | Resource group | *rt-\<route&nbsp;table&nbsp;name>* <br><br> <li> `rt-navigator` <li> `rt-sharepoint` |
| **DNS label** | Global | *\<DNS&nbsp;A&nbsp;record&nbsp;for&nbsp;VM>.\<region>.cloudapp.azure.com* <br><br> <li> `dc1.westus.cloudapp.azure.com` <li> `web1.eastus2.cloudapp.azure.com` |

### Security

| Asset type | Scope | Format and examples |
|--|--|--|
| **Managed identity** | Resource group | *id-\<app&nbsp;or&nbsp;service&nbsp;name>-\<environment>-\<region name>-\<###>* <br><br> <li> `id-appcn-keda-prod-eastus2-001` |
  
### Storage

| Asset type | Scope | Format and examples |
|--|--|--|
| **Storage account (general use)** | Global | *st\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<###>* <br><br> <li> `stnavigatordata001` <li> `stemissionsoutput001` |
| **Azure StorSimple** | Global | *ssimp\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<environment>* <br><br> <li> `ssimpnavigatorprod` <li> `ssimpemissionsdev` |
| **Azure Container Registry** | Global | *cr\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<environment>\<###>* <br><br> <li> `crnavigatorprod001` |

## Next step

A good next step is to define your tagging strategy.

> [!div class="nextstepaction"]
> [Define your tagging strategy](./resource-tagging.md)
