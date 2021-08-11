---
title: Azure Purview deployment best practices for data management and analytics enterprise-scale scenario
description: Azure Purview best practices for account setup, networking, name resolution, authentication of data sources, roles, and access control.
author: zeinam
ms.author: zeinam
ms.date: 05/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Purview deployment best practices for data management and analytics enterprise-scale scenario

The [data management landing zone](../architectures/data-management-landing-zone.md) is responsible for the governance of the enterprise-scale for analytics and AI platform. It relies on [Azure Purview](https://azure.microsoft.com/services/purview/) to provide data management capabilities:

- [Data catalog](../architectures/data-management-landing-zone.md#data-catalog)
- [Data classification](../architectures/data-management-landing-zone.md#data-classification)
- [Data lineage](../architectures/data-management-landing-zone.md#data-lineage)

Azure Purview is a unified data governance service. It helps organizations manage and govern data across on-premises, multicloud, and software as a service (SaaS). Azure Purview creates a holistic, up-to-date map of the data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. Azure Purview helps data consumers find valuable and trustworthy data.

> [!TIP]
> We recommend using third-party tools of your choice to integrate the remaining capabilities of the [data management landing zone](../architectures/data-management-landing-zone.md) with Azure that are currently not supported by Azure Purview.
> [!NOTE]
> This guidance in this section explains configurations specific to enterprise-scale for analytics and AI. It's a collection of Azure best practices to enhance your data governance using Azure Purview. The guidance compliments the official [Azure Purview documentation](/azure/purview/).

One Azure Purview account is deployed inside the data management landing zone, which serves as a centralized data catalog. From the data management landing zone, Azure Purview can communicate with each data landing zone via private network connectivity using VNet peering across data management, data landing zones, and [self-hosted integration runtimes](/azure/purview/manage-integration-runtimes). Discovery of datasets in on-premises data stores and other public clouds is achieved by more deployments of self-hosted integration runtimes.

## Account setup

The first step is the deployment of an Azure Purview account. During the deployment of the [data management landing zone](../architectures/data-management-landing-zone.md), a single Azure Purview account is deployed automatically inside the data management subscription. The goal is to centralize the entire data map into a single Azure Purview account across all data landing zones. We recommend you consider a shared single Azure Purview account inside the data management landing zone subscription per environment type.

In addition to the Azure Purview account, a managed resource group is also deployed. A managed *storage account* and a managed *Event Hubs namespace* are deployed inside this resource group and are used to ingest the metadata because of scans. Since these resources are consumed by the Azure Purview catalog, they must not be removed. An Azure role-based access control RBAC *deny assignment* is added automatically for *all principals* at the resource group level at the time of deployment.

### Prerequisites

Before deployment, review the following requirements inside your data management landing zone subscription:

- **Make policy exemptions:** If you have an existing Azure Policy assignment that prevents administrators or applications from creating Azure Storage accounts, Azure Event Hubs namespace, Azure Purview accounts, Azure Private DNS zones, or Azure private endpoints, you must apply [Azure Policy exemptions](/azure/governance/policy/concepts/exemption-structure). The exemptions are required, so the needed resources can be deployed in the data management landing zone, along with Azure Purview deployment.
- **Register resource providers:** Ensure you register the following Azure resource providers in the data management landing zone subscription.
  - Microsoft.EventHub
  - Microsoft.Purview
  - Microsoft.Storage

> [!IMPORTANT]
> To successfully deploy the data management landing zone with Azure Purview, the prerequisites should be met. To learn more about how to register resource providers, see [Resource providers for Azure services](/azure/azure-resource-manager/management/azure-services-resource-providers#registration).

## Networking and name resolution

The Azure Purview account is deployed inside the Azure virtual network (VNet) within the data management landing zone.

### Azure Private Endpoint deployment

:::image type="content" source="../images/purview-private-endpoint-2.png" alt-text="Diagram of Azure Purview Networking." lightbox="../images/purview-private-endpoint-2.png":::

Enterprise-scale for analytics and AI uses [Azure Private Endpoint](/azure/private-link/private-endpoint-overview) to enable secure access to the catalog powered by [Azure Private Link](/azure/private-link/private-link-overview). The private endpoint uses IP addresses from the VNet address space for your Azure Purview account. Network traffic between the clients on the VNet and the Azure Purview account traverses over the VNet and a Private Link on the Microsoft backbone network. The VNet and Private Link eliminate exposure from the public internet. To enable network isolation for end-to-end scan scenarios, more private endpoints are deployed. The private endpoints allow data sources in Azure and on-premises sources to be connected through Azure Private Link.

> [!IMPORTANT]
> To successfully scan data sources in Azure Purview, a self-hosted integration runtime must be deployed inside the private network either in the data management landing zone or the data landing zone.

For more information, see [Enterprise-scale for analytics and AI networking](../eslz-network-topology-and-connectivity.md).

#### Private Endpoint for account and portal

Azure Purview is deployed with two private endpoints:

- **Account:** Private Endpoint is used for securing APIs and it's required as a prerequisite for **portal** Private Endpoint.
- **Portal:** Private Endpoint is aimed to provide private connectivity to Azure Purview studio.

To manage the data estate using Azure Purview and to connect to Azure Purview studio, you must use private connectivity. Public access is restricted to the Azure Purview account that's deployed inside the data management landing zone to add more security.

### Access to Azure Purview studio

To maintain the use of Azure Purview portal through private connectivity, we recommend to [deny public network access](/azure/purview/catalog-private-link#firewalls-to-restrict-public-access) in Azure Purview settings. To connect to Azure Purview studio, a *jump machine or jump box* that's deployed inside your network is needed. You can use a machine from the hybrid network or as a virtual machine inside the data management landing zone. A jump machine is a hardened remote access server, that commonly uses Microsoft's Remote Desktop Services or Secure Shell (SSH) software. Jump machines act as a stepping point for administrators who access critical systems with all administrative actions done from the dedicated host.

Use any of these options to manage your data using Azure Purview through Azure Purview studio:

- **Option 1:** use a jump machine that's connected to CorpNet. To use this connectivity model, you must have connectivity between the VNet where Azure Purview portal Private Endpoint is created and your corporate network.
  
  Review Cloud Adoption Framework networking for more information [network topology and connectivity overview](../../../ready/enterprise-scale/network-topology-and-connectivity.md)

- **Option 2:** if hybrid connectivity isn't available in your organization, [deploy a virtual machine](/azure/virtual-machines/windows/quick-create-portal) inside the data management landing zone. [Deploy Azure Bastion](/azure/bastion/quickstart-host-portal) to connect to Azure Purview using a secure connection.

#### Private endpoints for ingestion

Azure Purview can scan data sources in Azure or on-premises environments using private or public endpoints. The network of a data landing zone is peered automatically with the data management landing zone VNet and the connectivity subscription VNet. So the data sources inside data landing zones can be scanned using private connectivity.

We recommend enabling private endpoints for other [data sources inside your landing zones](/azure/purview/catalog-private-link) and scan data sources using private connectivity.

### Name resolution

DNS resolution for private endpoints should be handled through central Azure Private DNS zones. The following private DNS zones are deployed automatically in the Azure Purview deployment in the data management landing zone:

- `privatelink.purview.azure.com`
- `privatelink.blob.core.windows.net`
- `privatelink.queue.core.windows.net`
- `privatelink.servicebus.windows.net`

:::image type="content" source="../images/purview-name-resolution.png" alt-text="Diagram of high Level name resolution architecture." lightbox="../images/purview-name-resolution.png":::

If you have a hybrid cloud, and cross-premises name resolution is required, it's important to configure on-premises DNS servers correctly to forward the appropriate requests to the custom DNS server in Azure.

- If you have custom DNS already in Azure, you need to set up conditional forwarders on your on-premises DNS server pointing to it.

- If you don't have a custom DNS VM in Azure, you can deploy the Azure virtual machine scale set that includes NGINX already configured to forward DNS requests to Azure-provided DNS IP `168.63.129.16`. Refer to [Deploy virtual machine scale set of a NGINX DNS proxy into an existing virtual network](https://github.com/Microsoft/PL-DNS-Proxy).

> [!TIP]
> To allow name resolution between the data management landing zone and the data landing zones, use the same private DNS zones located inside `{prefix}-global-dns` resource group inside the data management landing zone.

For more information related to enterprise-scale for analytics and AI networking and name resolution, see [Enterprise-scale for analytics and AI networking](../eslz-network-topology-and-connectivity.md)

## Manage authentication for data sources in Azure Purview

Azure Purview requires access to the *control plane* and the *data plane* to register and scan data sources.

### Register data sources

When you deploy the Azure Purview account, a system-assigned managed identity is created automatically. It's created in the Azure Active Directory tenant and assigned to this resource. To read and list Azure resources under a subscription or resource group when registering data sources in Azure Purview, the Azure Purview managed identity requires the Azure RBAC *Reader* role on the scope.

Consider assigning the *Reader* role to the Azure Purview managed identity in each data landing zone subscription before you register any of these data sources into Azure Purview:

- Azure Blob Storage
- Azure Data Lake Storage Gen1
- Azure Data Lake Storage Gen2
- Azure SQL Database
- Azure SQL Managed Instance
- Azure Synapse Analytics

### Scan data sources

#### Deploy and register self-hosted integration runtimes

Deploy and register [self-hosted integration runtime (IR)](/azure/purview/manage-integration-runtimes) VMs for each data landing zone. Self-hosted IRs are required to scan data sources such as Azure SQL Database or any VM-based data sources. These data sources might be on-premises or in each of the data landing zones. A self-hosted IR can run copy activities between a cloud data store and a data store in a private network. It also can dispatch transform activities against compute resources in an on-premises network or an Azure virtual network. The installation of a self-hosted IR needs an on-premises machine or a virtual machine inside a private network.

> [!TIP]
> We recommend that you use a dedicated machine to host the IR. The machine should be separate from the server hosting the data store. Also, it's highly recommended to plan for at least two self-hosted IR VMs in each data landing zone or on-premises environment.

You might want to host an increasing concurrent workload. Or you might want to achieve higher performance in your present workload level. You can enhance the scale of processing by using one of these approaches:

- Scale up when the processor and memory of the node are under-used
- Scale out the self-hosted IR by adding more nodes or virtual machine scale sets

#### Assign access to the data plane to scan data sources

To provide access to Azure Purview at data plane and to data sources, there are multiple options to set up the authentication:

- Option 1: managed identity
- Option 2: account key or passwords stored in Azure Key Vault as a secret
- Option 3: service principal stored in Azure Key Vault as a secret

> [!IMPORTANT]
> To scan data sources through Azure Private Link in Azure Purview, you must deploy a self-hosted integration runtime and use **key vault** or **service principal** from the options for authentication to data sources.
> [!TIP]
> When a data source can't use Azure Private Link, we recommend to use Azure Purview managed identity to scan data sources.

### Store secrets inside Azure Key Vault

Multiple Azure Key Vault resources get deployed inside the data management landing zone and the data landing zone subscriptions. The Azure Key Vault resources store secrets related to metadata data sources in the data management landing zone and data sources. An example of a data source is Azure SQL Database consumed by Azure Data Factory. Or Azure Database for MySQL used by Databricks workspaces in the data landing zone.

### Connect data landing zones Azure key vaults to your Azure Purview account

Azure Purview can use the secrets and credentials stored in Azure key vaults. They can be used only if you create the Azure Key Vault connection inside the Azure Purview account and the secret is registered. After you add a new data landing zone, you must create a new Azure Key Vault connection inside the Azure Purview account. The connection is a one-to-one association of the Azure Key Vault resource with the Azure Purview account. It will allow the creation of credentials inside the Azure Purview account based on the secrets stored in the Azure Key Vault.

For more information, see [Create Azure Key Vault connections in your Azure Purview account](/azure/purview/manage-credentials#create-azure-key-vaults-connections-in-your-azure-purview-account).

> [!TIP]
> Remove any unused Azure key vaults to minimize Key Vault connections.

### Create credentials inside Azure Purview

You might require to set up a *Credential* using a key vault *Secret* for specific scenarios:

- To scan any data sources where Azure Purview managed identity cannot be used as the authentication method.
- To scan any data sources using a self-hosted integration runtime, the supported authentication types such as account keys, SQL authentication (password), or service principal must be stored in a credential.
- To scan data sources using a private endpoint for data ingestion.
- To scan data sources that are inside a virtual machine or inside an on-premises environment.

Before creating any credentials in Azure Purview, your Azure Purview account must have access to Azure Key Vault secrets. Use Azure Key Vault access policy or role-based access control (RBAC) to grant Azure Purview managed service identity (MSI) the required access. For more information about how to grant Azure Purview MSI access to Azure Key Vault and create credentials inside Azure Purview, see [Credentials for source authentication in Azure Purview](/azure/purview/manage-credentials).

## Azure Purview roles and access control

Azure Purview has several built-in RBAC roles such as *Purview Data Reader*, *Purview Data Curator*, and *Purview Data Source Administrator*, to manage the data plane, which can be combined to provide more privileges. For example, the *Purview Data Reader* role is targeted for roles such as data officers, data stewards, and chief security officers who require read-only access to the data estate. The data estate might include classifications, lineage through search options, and reports available in Azure Purview.

:::image type="content" source="../images/purview-roles.png" alt-text="Diagram of Azure Purview roles." lightbox="../images/purview-roles-large.png":::

For more information about Azure Purview catalog roles, see [Role-based access control in Azure Purview's data plane](/azure/purview/catalog-permissions)

Once the data management landing zone deployment is complete, use the least privilege model to provide access to view and manage data in Azure Purview. Assign roles to Azure Purview resource using [Azure role-based access control (RBAC)](/azure/role-based-access-control/).

Review the following list of personas involved in an enterprise-scale for analytics and AI deployment. Assign them the relevant Azure Purview roles so they can contribute in the success of the program:

| Persona | Role |Recommended Azure Purview role  |
|-|-|-|
|Product owners| Product owners use Azure to transform your solutions, bring agility to the business, and optimize business processes.|Purview Data Reader |
| Solution architects | Define solutions to drive across the boundaries of the enterprise business network. Learn how to deal with diagnosis, analysis, design, deployment, and integration of Azure services. |Purview Data Source Administrator + data curator    |
|Developer and DevOps engineers|Design, build, deploy, test, and maintain continuous integration and delivery process with Azure DevOps or GitHub.|Not applicable  |
| Security engineers | Enable your teams to design and implement a secure infrastructure on Azure by using best practices. |Purview Data Reader  |
| Technical and business managers |Build an overall understanding of Azure services. Control your cloud costs and optimize your operations and the agility of your team.|Not applicable |
|Decision makers and business users|Use Azure to access actionable insight, expecting it to be delivered in most relevant form. Use AI embedded in existing solutions to optimize business processes.|Purview Data Reader   |
| Data managers | Responsible for provisioning and managing access to data assets. |Purview Data Reader or Purview Data Curator |
|Data analysts and performance analysts |Use Azure to discover and share new insights from existing data assets or *ad hoc* data. Create one-click AI transformations, consume prebuilt models, and easily generate machine learning models.|Purview Data Source Administrator and data reader   |
|Data engineers | Use Azure to build, integrate, and manage data and analytics products. Create AI enabled applications and solutions when applicable.|Purview Data Source Administrator and data curator|
|Citizen data scientists |Create machine learning models via powerful visual, drag-and-drop, no-code tools where no coding is necessary |Purview Data Source Administrator and data curator |
| Data scientists | Use your preferred tools and machine learning frameworks to build scalable data science solutions. Accelerate end-to-end machine learning lifecycle.|Purview Data Source Administrator and data curator |
| Machine learning engineers | Enable right processes and infrastructure for easy model deployment and model management. |Purview Data Source Administrator and data curator    |

For more information about data personas, see [Personas and teams](../organize-persona-and-teams.md#personas).
