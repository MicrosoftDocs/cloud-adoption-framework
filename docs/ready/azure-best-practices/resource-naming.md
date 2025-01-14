---
title: Define your naming convention
description: Learn about the considerations for naming your Azure resources and assets, and review example names for resources and assets in Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/14/2025
ms.topic: conceptual
---

# Define your naming convention

A good name for a resource helps you to quickly identify its type, its associated workload, its environment, and the Azure region where it runs. To do so, names should follow a consistent format—a *naming convention*—that is composed of important information about each resource. The information in the names ideally includes whatever you need to identify specific instances of resources. For example, a public IP address (PIP) for a production SharePoint workload in the West US region might be `pip-sharepoint-prod-westus-001`.

![Diagram that shows the components of an Azure resource name.](./media/naming-convention-example.svg)

*Diagram 1: Example of components in an Azure resource name.*

> [!NOTE]
> Consider that not all Azure resources can follow the same patterns. Make sure you understand the limitations of the resource types you are working with.
>
> To learn more, see [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules).

## Recommended naming components

When you construct your naming convention, identify the key pieces of information that you want to capture in a resource name. Different information is relevant for different resource types, and not all established naming components can be used for each resource type. Establish a standard naming convention for your environment that is easy to follow, concise, and useful for recognizing information that's relevant to the deployed resource.

The following list provides examples of naming components that are useful when you construct resource names:

| Naming component | Description |
|--|--|
| **Organization** | Top-level name of the organization, normally utilized as the top management group or, in smaller organizations, part of the naming convention. Example: `contoso` |
| **Business unit or department** | Top-level division of your company that owns the subscription or the workload that the resource belongs to. In smaller organizations, this component might represent a single corporate, top-level organizational element. Examples: `fin`, `mktg`, `product`, `it`, `corp` |
| **Resource type** | An abbreviation that represents the type of Azure resource or asset. This component is often a prefix or suffix in the name. For more information, see [Recommended abbreviations for Azure resource types](./resource-abbreviations.md). Examples: `rg`, `vm` |
| **Workload, application, or project** | Name of a workload, application, or project that the resource is a part of. Examples: `navigator`, `emissions`, `sharepoint`, `hadoop` |
| **Environment** | The stage of the development lifecycle for the workload that the resource supports. Examples: `prod`, `dev`, `qa`, `stage`, `test` |
| **Region** | The region or cloud provider where the resource is deployed. Examples:  `westus`, `eastus2`, `westeu`, `usva`, `ustx` |
| **Instance** | The instance count for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, `01`, `001` |

## Naming considerations

In addition to defining the naming components, you must also consider the order in which the naming components are listed and what type of delimiters (if any) should appear between components. Also take into account the different naming rules that are associated with resources types.

### Scope

All Azure resource types have a scope that defines the level of that resource. Also, a resource must have a unique name within its scope.

Scope levels for Azure resource names:

- **Global**: Unique across all of Azure.

  *Example: Name of PaaS resources with public IP endpoints across all of Azure, because that name is the initial default public DNS name.*

- **Resource group**: Unique within the resource group.

  *Example: All virtual networks in a resource group must have a unique name for routing within that resource group.*

- **Resource**: Unique within the parent resource.

  *Example: All subnets within a virtual network must have unique names to avoid segment overlap.*

![Diagram that shows the scope levels for Azure resource names.](../../_images/ready/resource-naming-scope.png)

*Diagram 2: Scope levels for Azure resource names.*

For example, a virtual network has the scope of a resource group, which means that there can be only one network named `vnet-prod-westus-001` in a specific resource group. Other resource groups can also have virtual networks named `vnet-prod-westus-001`, but each resource group can have only one with that name. Subnets are scoped to virtual networks, so each subnet within a virtual network must have a distinct name.

Some resource names have a global scope, such as a name for a Platform as a Service (PaaS) that has a public endpoint or a virtual machine DNS label. A resource in a global scope must have a name that's unique across the entire Azure platform.

### Azure naming rules

Azure naming rules vary depending on the resource type. It's important to understand naming rules for each resource type to avoid confusion and delays.

For example, resource names for different resource types might have different length limits. We recommend that you keep the length of naming components short or abbreviating names to prevent exceeding resource name length limits.

When you construct your naming convention, identify the key pieces of information that you want to reflect in a resource name. Different information is relevant for different resource types.


**Recommendations:**

- **Understand naming rules and restrictions**: Balancing the context of a name with its scope and length limit is important when developing your naming conventions. For more information, see [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules).
- **Use recommended resource abbreviations**: Abbreviations can help you keep resource names within length limits and make them easier to read. For more information, see [Recommended abbreviations for Azure resource types](./resource-abbreviations.md).
- **Consider naming consistency for VMs**: If you're working with VMs in Azure, we recommend keeping names consistent even though VM names in Azure can be longer than the allowed NetBIOS name of the VM. For more information and for other restrictions, see [Naming conventions in Active Directory for computers, domains, sites, and OUs - Computer names](/troubleshoot/windows-server/identity/naming-conventions-for-computer-domain-site-ou#computer-names).
- **Use the Azure Naming Tool**: The Azure Naming Tool is a tool that helps you generate names for Azure resources based on a naming convention. For more information, see [Azure Naming Tool](https://github.com/mspnp/AzureNamingTool).

<!-- docutune:ignored "(?-i)[a-z]+(?=[\\-])" -->

## Example names

Consider these examples when you define your naming convention. The examples are based on the naming components and considerations that are described in this article.

The following examples are intended to provide visualization of a naming convention, but actual conventions vary by organization. For more examples, see the [Azure Naming Tool](https://github.com/mspnp/AzureNamingTool).

### Example names: General

| Asset type | Scope | Format and examples |
|--|--|--|
| **Management group** | Business unit and/or <br> environment | *mg-\<business unit>[-\<environment>]* <br><br> <li> `mg-mktg` <li> `mg-hr` <li> `mg-corp-prod` <li> `mg-fin-client` |
| **Subscription** | Account / enterprise agreement | *\<business&nbsp;unit>-\<subscription&nbsp;purpose>-\<###>* <br><br> <li> `mktg-prod-001` <li> `corp-shared-001` <li> `fin-client-001` |
| **Resource group** | Subscription | *rg-\<app&nbsp;or&nbsp;service&nbsp;name>-<subscription&nbsp;purpose>-\<###>* <br><br> <li> `rg-mktgsharepoint-prod-001` <li> `rg-acctlookupsvc-shared-001` <li> `rg-ad-dir-services-shared-001` |
| **API management service instance** | Global | *apim-\<app&nbsp;or&nbsp;service&nbsp;name>* <br><br> `apim-navigator-prod` |
| **Managed identity** | Resource group | *id-\<app&nbsp;or&nbsp;service&nbsp;name>-\<environment>-\<region name>-\<###>* <br><br> <li> `id-appcn-keda-prod-eastus2-001` |

### Example names: Networking

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

### Example names: Compute and web

| Asset type | Scope | Format and examples |
|--|--|--|
| **Virtual machine** | Resource group | *vm-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>-<###>* <br><br> <li> `vm-sql-test-001` <li> `vm-hadoop-prod-001` <li> `vm-sharepoint-dev-001` |
| **Web app** | Global | *app-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>-\<###>.azurewebsites.net* <br><br> <li> `app-navigator-prod-001.azurewebsites.net` <li> `app-accountlookup-dev-001.azurewebsites.net` |
| **Function app** | Global | *func-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>-\<###>.azurewebsites.net* <br><br> <li> `func-navigator-prod-001.azurewebsites.net` <li> `func-accountlookup-dev-001.azurewebsites.net` |

### Example names: Databases

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure SQL database** | Azure SQL Server | *sqldb-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `sqldb-users-prod` <li> `sqldb-users-dev` |
| **Azure Cosmos DB database** | Global | *cosmos-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `cosmos-navigator-prod` <li> `cosmos-emissions-dev` |
| **Azure Cache for Redis instance** | Global | *redis-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `redis-navigator-prod` <li> `redis-emissions-dev` |
  
### Example names: Storage

| Asset type | Scope | Format and examples |
|--|--|--|
| **Storage account (general use)** | Global | *st\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<###>* <br><br> <li> `stnavigatordata001` <li> `stemissionsoutput001` |
| **Azure StorSimple** | Global | *ssimp\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<environment>* <br><br> <li> `ssimpnavigatorprod` <li> `ssimpemissionsdev` |
| **Azure Container Registry** | Global | *cr\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<environment>\<###>* <br><br> <li> `crnavigatorprod001` |

### Example names: AI and machine learning

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure AI Search** | Global | *srch-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `srch-navigator-prod` <li> `srch-emissions-dev` |
| **Azure OpenAI Service** | Resource group | *oai-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `oai-navigator-prod` <li> `oai-emissions-dev` |
| **Azure Machine Learning workspace** | Resource group | *mlw-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `mlw-navigator-prod` <li> `mlw-emissions-dev` |

### Example names: Analytics and IoT

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure Analysis Services** | Global | *as\<app name>\<environment>* <br><br> <li> `asnavigatorprod` <li> `asemissionsdev` |
| **Azure Data Factory** | Global | *adf-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `adf-navigator-prod` <li> `adf-emissions-dev` |
| **Azure Synapse Analytics workspaces** | Resource group | *synw-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `synw-navigator-prod` <li> `synw-emissions-dev` |
| **Data Lake Storage account** | Global | *dls\<workload,&nbsp;application,&nbsp;or&nbsp;project>\<environment>* <br><br> <li> `dlsnavigatorprod` <li> `dlsemissionsdev` |
| **IoT hub** | Global | *iot-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>* <br><br> <li> `iot-navigator-prod` <li> `iot-emissions-dev` |

### Example names: Integration

| Asset type | Scope | Format and Examples|
|--|--|--|
| **Service Bus namespace** | Global | *sbns-\<workload,&nbsp;application,&nbsp;or&nbsp;project>-\<environment>.servicebus.windows.net* <br><br> <li> `sbns-navigator-prod.servicebus.windows.net` <li> `sbns-emissions-dev.servicebus.windows.net` |
| **Service Bus queue** | Service Bus | *sbq-\<workload,&nbsp;application,&nbsp;or&nbsp;project>* <br><br> <li> `sbq-navigator` |
| **Service Bus topic** | Service Bus | *sbt-\<workload,&nbsp;application,&nbsp;or&nbsp;project>* <br><br> <li> `sbt-navigator` |

## Next step

A good next step is to look at recommended abbreviations for Azure resources. Abbreviations can help you keep resource names within length limits and make them easier to read.

> [!div class="nextstepaction"]
> [Abbreviations for resource types](./resource-abbreviations.md)
