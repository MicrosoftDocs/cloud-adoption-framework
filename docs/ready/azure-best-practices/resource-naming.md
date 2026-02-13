---
title: Define your naming convention
description: Learn how to create a standardized naming convention for Azure resources that ensures clarity, consistency, and compliance with Azure naming requirements across your cloud environment.
author: stephen-sumner
ms.author: pnp
ms.date: 09/12/2025
ms.topic: concept-article
---

# Define your naming convention

Naming conventions provide standardized formats for assigning names to Azure resources. Every organization needs a tailored naming convention that meets both Azure requirements and specific cloud adoption needs. This guidance provides a foundation that you can adapt to align with your organizational requirements.

**See examples:** [Example Azure resource names](#example-azure-resource-names)

## Understand resource names in Azure

An Azure resource name is the identifier assigned to a specific instance of an Azure resource, such as a web app, database, or storage account. To establish a consistent Azure naming convention, you need to understand how Azure works. Here's what you need to know:

1. **Understand name permanence.** Most Azure resource names can't be changed after creation. Include only information that remains constant in the name. Use tags to capture other details.

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

The following list provides examples of naming components (what to include in the name) that are useful for constructing Azure resource names:

| Naming component | Description | Example component | Example Azure resource |
|--|--|--|--|
| **Resource type** | An [abbreviation](./resource-abbreviations.md) that represents the type of Azure resource or asset. | `rg`, `vm`, `st`, `app` | `rg-navigator-prod-001`, `vm-web-prod-001` |
| **Workload, application, or project** | Name of a workload, application, or project that the resource is a part of. | `navigator`, `emissions`, `sharepoint`, `hadoop` | `app-navigator-prod`, `vm-sharepoint-dev-001` |
| **Environment** | Production, development, quality assurance, stage, test. | `prod`, `dev`, `qa`, `stage`, `test` | `app-navigator-prod`, `sqldb-dev` |
| **Region** | The [Azure region](/azure/reliability/availability-zones-service-support) or cloud provider location where the resource is deployed. | `westus`, `eastus2`, `westeu`, `usva`, `ustx` | `vnet-shared-eastus2-001`, `pip-hadoop-prod-westus-001` |
| **Instance number** | The instance count for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. | `01`, `001` | `vm-sql-test-001`, `vm-sql-test-002` |

### Develop your naming convention

To construct your Azure naming convention, identify the key pieces of information that you want to reflect in a resource name. Different information is relevant for different resource types.

1. **Standardize component order.** In addition to defining the naming components, you must also consider the order in which the naming components are listed.

1. **Choose to use a delimiter or not.** To improve readability, use a hyphen `-` to separate naming components. However, not every resource in Azure allows you to use a delimiter. If you need absolute consistency across all your Azure resource names, don't use a hyphen. For many customers, the benefits of using a delimiter outweigh some inconsistency in the naming convention.

1. **Use abbreviations.** Use [Azure resource abbreviations](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) to keep resource names within length limits.

1. **Use the Azure Naming Tool.** The Azure Naming Tool is a tool that helps you generate names for Azure resources. You configure the tool to use your preferred naming convention, and it generates names for your Azure resources. For more information, see [Azure Naming Tool](https://github.com/mspnp/AzureNamingTool).

## Example Azure resource names

Consider these examples when you define your Azure naming convention. The examples are based on the naming components and considerations that are described in this article.

### AI and machine learning

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure AI Search** | Global | *srch-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `srch-navigator-prod` <li> `srch-emissions-dev` |
| **Azure OpenAI Service** | Resource group | *oai-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `oai-navigator-prod` <li> `oai-emissions-dev` |
| **Azure Machine Learning workspace** | Resource group | *mlw-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `mlw-navigator-prod` <li> `mlw-emissions-dev` |

### Analytics and IoT

| Asset type | Scope | Format and examples |
|--|--|--|
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
| **Azure Managed Redis instance** | Global | *redis-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `redis-navigator-prod` <li> `redis-emissions-dev` |

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
| **Management group** | Tenant | Provide a globally unique identifier (GUID) for the management group ID. Display names are editable and should represent the platform function or workload types within them. |
| **Subscription** | Azure account or Enterprise agreement | Descriptive name that aligns with IT standards. You can change the display name. Example: *(Business Unit (optional)) (Function or Workload) (Environment)* <br><br> <li> `Marketing Web App Production` <li> `Connectivity` <li> `Security` |
| **Resource group** | Subscription | *rg-workload name/type-workload component (optional)-environment (optional)* <br><br> <li> `rg-webapp-prod` <li> `rg-webapp-database-dev` |

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
| **Azure Container Registry** | Global | *cr\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<environment>\<###>* <br><br> <li> `crnavigatorprod001` |

## Next step

A good next step is to define your tagging strategy.

> [!div class="nextstepaction"]
> [Define your tagging strategy](./resource-tagging.md)
