---
title: Microsoft Purview deployment best practices for cloud-scale analytics
description: Microsoft Purview best practices for account setup, networking, name resolution, authentication of data sources, roles, and access control.
author: zeinam
ms.author: zeinam
ms.date: 04/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Microsoft Purview deployment best practices for cloud-scale analytics

The [Data management landing zone](../architectures/data-management-landing-zone.md) is responsible for the governance of the cloud-scale analytics platform. It relies on [Microsoft Purview](https://azure.microsoft.com/services/purview/) to provide most data management capabilities.

> [!NOTE]
> This guidance in this section explains configurations specific to cloud-scale analytics. It's a collection of Azure best practices to enhance your data governance using Microsoft Purview. The guidance compliments the official [Microsoft Purview documentation](/azure/purview/).

## Overview

Microsoft Purview is a unified data governance service that helps you manage and govern your on-premises, multi-cloud, and software-as-a-service (SaaS) data. Create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. Enable data curators to manage and secure your data estate. Empower data consumers to find valuable, trustworthy data.

> [!TIP]
> We recommend using third-party tools of your choice to integrate the remaining capabilities of the [data management landing zone](../architectures/data-management-landing-zone.md) with Azure that are currently not supported by Microsoft Purview.

One Microsoft Purview account is deployed inside the data management landing zone, which serves as a centralized data catalog. From the data management landing zone, Microsoft Purview can communicate with each data landing zone via private network connectivity using VNet peering across data management, data landing zones, and [self-hosted integration runtimes](/azure/purview/manage-integration-runtimes). Discovery of data products in on-premises data stores and other public clouds is achieved by more deployments of self-hosted integration runtimes.

## Account setup

The first step is the deployment of an Microsoft Purview account. During the deployment of the [data management landing zone](../architectures/data-management-landing-zone.md), a single Microsoft Purview account is deployed automatically inside the data management subscription. The goal is to centralize the entire data map into a single Microsoft Purview account across all data landing zones. We recommend you consider a shared single Microsoft Purview account inside the data management landing zone subscription per environment type.

In addition to the Microsoft Purview account, a managed resource group is also deployed. A managed *storage account* and a managed *Event Hubs namespace* are deployed inside this resource group and are used to ingest data asset metadata through scans. Since these resources are consumed by the Microsoft Purview catalog, they must not be removed. An Azure role-based access control RBAC *deny assignment* is added automatically for *all principals* at the resource group level at the time of deployment.

### Prerequisites

Before deployment, review the following requirements inside your data management landing zone subscription:

- **Make policy exemptions:** If you have an existing Azure Policy assignment that prevents administrators or applications from creating Azure Storage accounts, Azure Event Hubs namespace, Microsoft Purview accounts, Azure Private DNS zones, or Azure private endpoints, you must apply [Azure Policy exemptions](/azure/governance/policy/concepts/exemption-structure). The exemptions are required, so the needed resources can be deployed in the data management landing zone, along with Microsoft Purview deployment.
- **Register resource providers:** Ensure you register the following Azure resource providers in the data management landing zone subscription:
  - `Microsoft.EventHub`
  - `Microsoft.Purview`
  - `Microsoft.Storage`

> [!IMPORTANT]
> To successfully deploy the data management landing zone with Microsoft Purview, the prerequisites should be met. To learn more about how to register resource providers, see [Resource providers for Azure services](/azure/azure-resource-manager/management/azure-services-resource-providers#registration).

## Networking and name resolution

Cloud-scale analytics uses an [Azure private endpoint](/azure/private-link/private-endpoint-overview) to enable secure access to the catalog, powered by [Azure Private Link](/azure/private-link/private-link-overview). The private endpoint uses IP addresses from the VNet address space for your Microsoft Purview account. Network traffic between the clients on the VNet and the Microsoft Purview account traverses over the VNet and a Private Link on the Microsoft backbone network. The VNet and Private Link eliminate exposure from the public internet. To enable network isolation for end-to-end scan scenarios, more private endpoints are deployed. The private endpoints allow data sources in Azure and on-premises sources to be connected through Azure Private Link.

### Azure private endpoint deployment

The Microsoft Purview account is deployed inside the Azure virtual network (VNet) within the data management landing zone with several private endpoints:

- **Account:** A private endpoint is used to allow only client calls to Microsoft Purview that originate from within the private network. It's required as a prerequisite for a *portal* private endpoint.

- **Portal:** A private endpoint is intended to provide private connectivity to Microsoft Purview governance portal. The Microsoft Purview governance portal is the management user interface that allows you to access and manage Microsoft Purview from a web browser.

- **Ingestion** private endpoints to scan Azure IaaS and PaaS data sources inside Azure Virtual Network and on-premises data sources through a private connection. This method ensures network isolation for your metadata flowing from the data sources to Microsoft Purview Data Map.

:::image type="content" source="../images/purview-private-endpoint-2.png" alt-text="Diagram of Microsoft Purview Networking." lightbox="../images/purview-private-endpoint-2.png":::

> [!IMPORTANT]
> To successfully scan data sources in Microsoft Purview, a self-hosted integration runtime must be deployed inside the same virtual network where Microsoft Purview ingestion private endpoints are deployed, which can be inside the data management landing zone or any data landing zones.

For more information about data management landing zone networking, see [Cloud-scale analytics networking](../eslz-network-topology-and-connectivity.md).

For more information about Microsoft Purview private endpoints, see [Use private endpoints for your Microsoft Purview account](/azure/purview/catalog-private-link).

#### Private endpoint for account and portal

To manage the data estate using Microsoft Purview and to connect to Microsoft Purview governance portal, you must use private connectivity. Public access is restricted to the Microsoft Purview account that is deployed inside the data management landing zone to add more security.
*Account* and *portal* private endpoints are deployed to provide private connectivity to your Microsoft Purview account and access to Microsoft Purview governance portal.

#### Access to Microsoft Purview governance portal

To maintain the use of Microsoft Purview portal through private connectivity, we recommend to [deny public network access](/azure/purview/catalog-private-link#firewalls-to-restrict-public-access) in Microsoft Purview settings. To connect to Microsoft Purview governance portal, a *jump machine* or *jump box* that's deployed inside your network is needed. You can use a machine from the hybrid network or as a virtual machine inside the data management landing zone. A jump machine is a hardened remote access server, that commonly uses Microsoft's Remote Desktop Services or Secure Shell (SSH) software. Jump machines act as a stepping point for administrators who access critical systems with all administrative actions done from the dedicated host.

Use any of these options to manage your data using Microsoft Purview through Microsoft Purview governance portal:

- **Option 1:** Use a jump machine that's connected to the corporate network. To use this connectivity model, you must have connectivity between the VNet where the Microsoft Purview portal private endpoint is created and your corporate network.

  Review Cloud Adoption Framework networking for more information [network topology and connectivity overview](../../../ready/landing-zone/design-area/network-topology-and-connectivity.md).

- **Option 2:** If hybrid connectivity isn't available in your organization, [deploy a virtual machine](/azure/virtual-machines/windows/quick-create-portal) inside the data management landing zone. [Deploy Azure Bastion](/azure/bastion/quickstart-host-portal) to connect to Microsoft Purview using a secure connection.

#### Private endpoints for ingestion

Microsoft Purview can scan data sources in Azure or on-premises environments using private or public endpoints. The network of a data landing zone is peered automatically with the data management landing zone VNet and the connectivity subscription VNet. So the data sources inside data landing zones can be scanned using private connectivity.

We recommend enabling private endpoints for other [data sources inside your landing zones](/azure/purview/catalog-private-link) and scan data sources using private connectivity.

### Name resolution

DNS resolution for private endpoints should be handled through central Azure Private DNS zones. The following private DNS zones are deployed automatically in the Microsoft Purview deployment in the data management landing zone:

- `privatelink.purview.azure.com`
- `privatelink.purviewstudio.azure.com`
- `privatelink.blob.core.windows.net`
- `privatelink.queue.core.windows.net`
- `privatelink.servicebus.windows.net`

:::image type="content" source="../images/purview-name-resolution.png" alt-text="Diagram of high Level name resolution architecture." lightbox="../images/purview-name-resolution.png":::

If you have a hybrid cloud, and cross-premises name resolution is required, it's important to configure on-premises DNS servers correctly to forward the appropriate requests to the custom DNS server in Azure.

- If you have custom DNS already in Azure, you need to set up conditional forwarders on your on-premises DNS server pointing to it.

- If you don't have a custom DNS VM in Azure, you can deploy the Azure virtual machine scale set that includes NGINX already configured to forward DNS requests to Azure-provided DNS IP `168.63.129.16`. For more information, see [Deploy virtual machine scale set of an NGINX DNS proxy into an existing virtual network](https://github.com/Microsoft/PL-DNS-Proxy).

> [!TIP]
> To allow name resolution between the data management landing zone and the data landing zones, use the same private DNS zones located inside `{prefix}-global-dns` resource group inside the data management landing zone.

For more information related to cloud-scale analytics networking and name resolution, see [Cloud-scale analytics networking](../eslz-network-topology-and-connectivity.md)

## Manage authentication for data sources in Microsoft Purview

Microsoft Purview requires access to the *control plane* and the *data plane* to register and scan data sources.

### Register data sources

When you deploy the Microsoft Purview account, a system-assigned managed identity is created automatically. It's created in the Azure Active Directory tenant and assigned to this resource. To read and list Azure resources under a subscription or resource group when registering data sources in Microsoft Purview, the Microsoft Purview managed identity requires the Azure RBAC *Reader* role on the scope.

Consider assigning the *Reader* role to the Microsoft Purview managed identity in each data landing zone subscription before you register any of these data sources into Microsoft Purview:

- Azure Blob Storage
- Azure Data Lake Storage Gen1
- Azure Data Lake Storage Gen2
- Azure SQL Database
- Azure SQL Managed Instance
- Azure Synapse Analytics

### Scan data sources

Before running any new scans, make sure you have completed the following requirements:

#### Deploy and register self-hosted integration runtimes

Deploy and register [self-hosted integration runtime (IR)](/azure/purview/manage-integration-runtimes) VMs for each data landing zone. Self-hosted IRs are required to scan data sources such as Azure SQL Database or any VM-based data sources. These data sources might be on-premises or in each of the data landing zones. A self-hosted IR can run copy activities between a cloud data store and a data store in a private network. It also can dispatch transform activities against compute resources in an on-premises network or an Azure virtual network. The installation of a self-hosted IR needs an on-premises machine or a virtual machine inside a private network.

> [!TIP]
> We recommend that you use a dedicated machine to host the IR. The machine should be separate from the server hosting the data store. Also, it's highly recommended to plan for at least two self-hosted IR VMs in each data landing zone or on-premises environment.
>
> To scan on-premises data sources, the self-hosted IRs can be deployed inside your on-premises network, however, to scan data sources located in Azure, the self-hosted IRs must be deployed in the same VNet as Microsoft Purview ingestion private endpoints. It's recommended to deploy new ingestion private endpoints and new self-hosted IRs per region where data sources are located.

You might want to host an increasing concurrent workload. Or you might want to achieve higher performance in your present workload level. You can enhance the scale of processing by using one of these approaches:

- Scale up when the processor and memory of the node are under-used
- Scale out the self-hosted IR by adding more nodes or virtual machine scale sets

#### Assign access to the data plane to scan data sources

To provide access to Microsoft Purview at data plane and to data sources, there are multiple options to set up the authentication:

- **Option 1:** Managed identity
- **Option 2:** Account key or passwords stored in Azure Key Vault as a secret
- **Option 3:** Service principal stored in Azure Key Vault as a secret

> [!IMPORTANT]
> To scan data sources through Azure Private Link in Microsoft Purview, you must deploy a self-hosted integration runtime and use **Account key/ SQL Authentication** or **service principal** from the options for authentication to data sources.

> [!TIP]
> When a data source can't use Azure Private Link, we recommend to use Microsoft Purview managed identity to scan data sources. In this case, you have to allow public access on your Microsoft Purview account firewall settings.

### Store secrets inside Azure Key Vault

Multiple Azure Key Vault resources get deployed inside the data management landing zone and the data landing zone subscriptions. The Azure Key Vault resources store secrets related to metadata data sources in the data management landing zone and data sources. An example of a data source is Azure SQL Database consumed by Azure Data Factory. Or Azure Database for MySQL used by Databricks workspaces in the data landing zone.

### Connect data landing zones Azure key vaults to your Microsoft Purview account

Microsoft Purview can use the secrets and credentials stored in Azure key vaults. They can be used only if you create the Azure Key Vault connection inside the Microsoft Purview account and the secret is registered. After you add a new data landing zone, you must create a new Azure Key Vault connection inside the Microsoft Purview account. The connection is a one-to-one association of the Azure Key Vault resource with the Microsoft Purview account. It will allow the creation of credentials inside the Microsoft Purview account based on the secrets stored in the Azure Key Vault.

For more information, see [Create Azure Key Vault connections in your Microsoft Purview account](/azure/purview/manage-credentials#create-azure-key-vaults-connections-in-your-azure-purview-account).

> [!TIP]
> Remove any unused Azure key vaults to minimize Key Vault connections.

### Create credentials inside Microsoft Purview

You might require to set up a *Credential* using a key vault *Secret* for specific scenarios:

- To scan any data sources where Microsoft Purview managed identity cannot be used as the authentication method.
- To scan any data sources using a self-hosted integration runtime, the supported authentication types such as account keys, SQL authentication (password), or service principal must be stored in a credential.
- To scan data sources using a private endpoint for data ingestion.
- To scan data sources that are inside a virtual machine or inside an on-premises environment.

Before creating any credentials in Microsoft Purview, your Microsoft Purview account must have access to Azure Key Vault secrets. Use Azure Key Vault access policy or role-based access control (RBAC) to grant Microsoft Purview managed service identity (MSI) the required access. For more information about how to grant Microsoft Purview MSI access to Azure Key Vault and create credentials inside Microsoft Purview, see [Credentials for source authentication in Microsoft Purview](/azure/purview/manage-credentials).

## Microsoft Purview roles and access control

Microsoft Purview has several built-in roles, such as Data reader, Data curator, Collection administrator, Data source administrator and Policy author to manage the data plane, which can be combined to provide more privileges. For example, the Data reader role is targeted for roles such as data officers, data stewards, and chief security officers who require read-only access to the data estate. The data estate might include classifications, lineage through search options, and reports available in Microsoft Purview.

Once the [Data management landing zone](../architectures/data-management-landing-zone.md) deployment is complete, use the least privilege model to provide access to view or manage metadata in Microsoft Purview.

> [!IMPORTANT]
> Microsoft Purview data plane roles must be managed inside Microsoft Purview governance portal or using the API directly.

For more information about Microsoft Purview roles, see [Access control in Microsoft Purview's data plane](/azure/purview/catalog-permissions)

### Recommended Microsoft Purview roles

Review the following list of [personas](../../cloud-scale-analytics/organize-roles-teams.md) involved in an cloud-scale analytics deployment. Assign them the relevant Microsoft Purview roles so they can contribute in the success of the deployment:

| Persona | Role | Recommended Microsoft Purview role |
|---|---|---|
|Product owners| Product owners use Azure to transform your solutions, bring agility to the business, and optimize business processes.| Data Reader |
| Solution architects | Define solutions to drive across the boundaries of the enterprise business network. Learn how to deal with diagnosis, analysis, design, deployment, and integration of Azure services. | <li> Data Source Admin <li> Data Curator |
| Developer and DevOps engineers | Design, build, deploy, test, and maintain continuous integration and delivery process with Azure DevOps or GitHub. | Not applicable |
| Security engineers | Enable your teams to design and implement a secure infrastructure on Azure by using best practices. | <li> Collection Admin <li> Data Reader |
| Technical and business managers | Build an overall understanding of Azure services. Control your cloud costs and optimize your operations and the agility of your team. | Not applicable |
| Decision makers and business users | Use Azure to access actionable insight, expecting it to be delivered in most relevant form. Use AI embedded in existing solutions to optimize business processes.| Data Reader |
| Data managers | Responsible for provisioning and managing access to data assets. | Data Reader or Data Curator |
| Data analysts and performance analysts | Use Azure to discover and share new insights from existing data assets or *ad hoc* data. Create one-click AI transformations, consume prebuilt models, and easily generate machine learning models. | <li> Data Source Admin <li> Data Reader |
| Data engineers | Use Azure to build, integrate, and manage data and analytics products. Create AI enabled applications and solutions when applicable.| <li> Data Source Admin <li> Data Curator |
| Citizen data scientists |Create machine learning models via powerful visual, drag-and-drop, no-code tools where no coding is necessary | <li> Data Source Admin <li> Data Curator |
| Data scientists | Use your preferred tools and machine learning frameworks to build scalable data science solutions. Accelerate end-to-end machine learning lifecycle. | <li> Data Source Admin <li> Data Curator |
| Machine learning engineers | Enable right processes and infrastructure for easy model deployment and model management. | <li> Data Source Admin <li> Data Curator |

For more information about data roles, see [Roles and teams](../../cloud-scale-analytics/organize-roles-teams.md).

## Next steps

[Azure Machine Learning as a data product for cloud-scale analytics](./azure-machine-learning.md)
