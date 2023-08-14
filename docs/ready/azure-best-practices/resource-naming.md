---
title: Define your naming convention
description: Learn about the considerations for naming your Azure resources and assets, and review example names for resources and assets in Azure.
author: martinekuan
ms.author: ssumner
ms.date: 09/28/2022
ms.topic: conceptual
s.custom: internal, readiness, fasttrack-edit
---

# Define your naming convention

A good name for a resource helps you to quickly identify its type, its associated workload, its environment, and the Azure region where it runs. To do so, names should follow a consistent format—a *naming convention*—that is composed of important information about each resource. The information in the names ideally includes whatever you need to identify specific instances of resources. For example, a public IP address (PIP) for a production SharePoint workload in the West US region might be `pip-sharepoint-prod-westus-001`. 

![Diagram that shows the components of an Azure resource name.](../../_images/ready/resource-naming.png)

*Diagram 1: Components of an Azure resource name.*


### Recommended naming components

When you construct your naming convention, identify the key pieces of information that you want to capture in a resource name. Different information is relevant for different resource types, and not all established naming components can be used for each resource type. Establish a standard naming convention for your environment that is easy to follow, concise, and useful for recognizing information that's relevant to the deployed resource. 

The following list provides examples of naming components that are useful when you construct resource names:

| Naming component | Description |
|--|--|
| **Organization** | Top-level name of the organization, normally utilized as the top management group or, in smaller organizations, part of the naming convention. Example: `contoso`
| **Business unit or department** | Top-level division of your company that owns the subscription or the workload that the resource belongs to. In smaller organizations, this component might represent a single corporate, top-level organizational element. Examples: `fin`, `mktg`, `product`, `it`, `corp` |
| **Resource type** | An abbreviation that represents the type of Azure resource or asset. This component is often a prefix or suffix in the name. For more information, see [Recommended abbreviations for Azure resource types](./resource-abbreviations.md). Examples: `rg`, `vm` |
| **Project, application, or service name** | Name of a project, application, or service that the resource is a part of. Examples: `navigator`, `emissions`, `sharepoint`, `hadoop` |
| **Environment** | The stage of the development lifecycle for the workload that the resource supports. Examples: `prod`, `dev`, `qa`, `stage`, `test` |
| **Location** | The region or cloud provider where the resource is deployed. Examples:  `westus`, `eastus2`, `westeu`, `usva`, `ustx` |
| **VM role** | Identifier of the purpose of the VM. Examples: `db` (database), `ws` (web server), `ps` (print server) |
| **Instance** | The instance count for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, `01`, `001` |

> [!NOTE]
> Although virtual machine (VM) names in Azure can be longer than the allowed NetBIOS name of the VM, we recommend that you keep them consistent. For more information and for other restrictions, see [Computer names](/troubleshoot/windows-server/identity/naming-conventions-for-computer-domain-site-ou#computer-names).
> 

## Naming considerations 

In addition to defining the naming components, you must also consider the order in which the naming components are listed and what type of delimiters (if any) should appear between components. Also take into account the different naming rules that are associated with resources types.

### Scope

All Azure resource types have a scope that defines the level of that resource. Also, A resource must have a unique name within its scope.

For example, a virtual network has the scope of a resource group, which means that there can be only one network named `vnet-prod-westus-001` in a specific resource group. Other resource groups can also have virtual networks named `vnet-prod-westus-001`, but each resource group can have only one with that name. Subnets are scoped to virtual networks, so each subnet within a virtual network must have a distinct name.

Some resource names have a global scope, such as a name for a Platform as a Service (PaaS) that has a public endpoint or a virtual machine DNS label. A resource in a global scope must have a name that's unique across the entire Azure platform.

![Diagram that shows the scope levels for Azure resource names.](../../_images/ready/resource-naming-scope.png)

*Diagram 2: Scope levels for Azure resource names.*

### Azure naming rules

Azure naming rules vary depending on the resource type. When you define a naming convention, it's important to understand Azure naming rules for the resource type to avoid confusion and delay deployments. 

For example, resource names have length limits. We recommend that you keep the length of naming components short to prevent exceeding resource name length limits.

> [!NOTE]
> Balancing the context of a name with its scope and length limit is important when you develop your naming conventions. For more information, see [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules).

When you construct your naming convention, identify the key pieces of information that you want to reflect in a resource name. Different information is relevant for different resource types. The following list provides examples of information that are useful when you construct resource names.

You can abbreviate resource names and naming components as a strategy to reduce the length and complexity of resource names. Shortening names can be useful for any of the naming components, but it's especially important to help you keep resource names within name length limits. For example, a VM name in Azure can be longer than the OS naming restrictions. Keeping Azure VM names shorter than the naming restrictions of the OS helps create consistency, improve communication when discussing resources, and reduce confusion when you're working in the Azure portal while being signed in to the VM itself.

| Naming component | Description |
|--|--|
| **Resource type** | An abbreviation that represents the type of Azure resource or asset. This component is often used as a prefix or suffix in the name. For more information, see [Recommended abbreviations for Azure resource types](./resource-abbreviations.md). <br/> Examples: `rg`, `vm` |
| **Business unit** | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this component might represent a single corporate top-level organizational element. <br/> Examples: `fin`, `mktg`, `product`, `it`, `corp` |
| **Application or service name** | Name of the application, workload, or service that the resource is a part of. <br/> Examples: `navigator`, `emissions`, `sharepoint`, `hadoop` |
| **Subscription purpose** | Summary description of the purpose of the subscription that contains the resource. Often broken down by environment or specific workloads. <br/> Examples: `prod`, `shared`, `client` |
| **Environment** | The stage of the development lifecycle for the workload that the resource supports. <br/> Examples: `prod`, `dev`, `qa`, `stage`, `test` |
| **Region** | The Azure region where the resource is deployed. <br/> Examples: `westus`, `eastus2`, `westeu`, `usva`, `ustx` |

> [!NOTE]
> When you're ready to name your resources and assets, review [Recommended abbreviations for Azure resource types](./resource-abbreviations.md).

The following section provides example names for common Azure resource types in an enterprise cloud deployment.

> [!NOTE]
> Some of these example names use a three-digit padding scheme (`###`), such as `mktg-prod-001`.
>
> Padding improves readability and sorting of assets when those assets are managed in a configuration management database (CMDB), IT Asset Management tool, or traditional accounting tools. When the deployed asset is managed centrally as part of a larger inventory or portfolio of IT assets, the padding approach aligns with interfaces those systems use to manage inventory naming.
>
> Unfortunately, the traditional asset padding approach can prove problematic in infrastructure-as-code approaches that might iterate through assets based on a non-padded number. This approach is common during deployment or automated configuration management tasks. Those scripts would have to routinely strip the padding and convert the padded number to a real number, which slows script development and run time.
>
> Choose an approach that's suitable for your organization. The padding shown here illustrates the importance of using a consistent approach to inventory numbering, rather than showing which approach is superior. Before choosing a numbering scheme, with or without padding, evaluate what will affect long-term operations more: CMDB and asset management solutions or code-based inventory management. Then, consistently follow the padding option that best fits your operational needs.

The following section provides some example names for common Azure resource types in an enterprise cloud deployment. For more examples, see the 
[Azure Naming Tool](https://github.com/mspnp/AzureNamingTool) and the [Naming and tagging tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx).

> [!NOTE]
> The following examples are intended to provide visualization of a naming convention, but actual conventions vary by organization.  

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
| **Load balancer** | Resource group | *lb-\<app&nbsp;name&nbsp;or&nbsp;role>-\<environment>-\<###>* <br><br> <li> `lb-navigator-prod-001` <li> `lb-sharepoint-dev-001` |
| **Network security group (NSG)** | Subnet or NIC | *nsg-\<policy&nbsp;name&nbsp;or&nbsp;app&nbsp;name>-\<###>* <br><br> <li> `nsg-weballow-001` <li> `nsg-rdpallow-001` <li> `nsg-sqlallow-001` <li> `nsg-dnsblocked-001` |
| **Local network gateway** | Virtual gateway | *lgw-\<subscription&nbsp;purpose>-\<region>-\<###>* <br><br> <li> `lgw-shared-eastus2-001` <li> `lgw-prod-westus-001` <li> `lgw-client-eastus2-001` |
| **Virtual network gateway** | Virtual network | *vgw-\<subscription&nbsp;purpose>-\<region>-\<###>* <br><br> <li> `vgw-shared-eastus2-001` <li> `vgw-prod-westus-001` <li> `vgw-client-eastus2-001` |
| **Site-to-Site connection** | Resource group | *cn-\<local&nbsp;gateway&nbsp;name>-to-\<virtual&nbsp;gateway&nbsp;name>* <br><br> <li> `cn-lgw-shared-eastus2-001-to-vgw-shared-eastus2-001` <li> `cn-lgw-shared-eastus2-001-to-vgw-shared-westus-001` |
| **VPN connection** | Resource group | *cn-\<subscription1&nbsp;purpose>>-\<region1>-to-\<subscription2&nbsp;purpose>>-\<region2>-* <br><br> <li> `cn-shared-eastus2-to-shared-westus` <li> `cn-prod-eastus2-to-prod-westus` |
| **Route table** | Resource group | *route-\<route&nbsp;table&nbsp;name>* <br><br> <li> `route-navigator` <li> `route-sharepoint` |
| **DNS label** | Global | *\<DNS&nbsp;A&nbsp;record&nbsp;for&nbsp;VM>.\<region>.cloudapp.azure.com* <br><br> <li> `dc1.westus.cloudapp.azure.com` <li> `web1.eastus2.cloudapp.azure.com` |

### Example names: Compute and Web

| Asset type | Scope | Format and examples |
|--|--|--|
| **Virtual machine** | Resource group | *vm-\<vm&nbsp;role>-\<environment>-<###>* <br><br> <li> `vm-sql-test-001` <li> `vm-hadoop-prod-001` |
| **Web app** | Global | *app-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>-\<###>.azurewebsites.net* <br><br> <li> `app-navigator-prod-001.azurewebsites.net` <li> `app-accountlookup-dev-001.azurewebsites.net` |
| **Function app** | Global | *func-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>-\<###>.azurewebsites.net* <br><br> <li> `func-navigator-prod-001.azurewebsites.net` <li> `func-accountlookup-dev-001.azurewebsites.net` |

### Example names: Databases

| Asset type | Scope | Format and examples |
|--|--|--|
| **Azure SQL database** | Azure SQL Server | *sqldb-\<project,&nbsp;app&nbsp;or&nbsp;service>-\<environment>* <br><br> <li> `sqldb-users-prod` <li> `sqldb-users-dev` |
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
| **Azure Analysis Services** | Global | *as\<app name>\<environment>* <br><br> <li> `asnavigatorprod` <li> `asemissionsdev` |
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
