---
title: Data integration security for SAP on Azure
description: Learn about data integrations security for SAP on Azure, including an example architecture and considerations for each component.
author: pankajmeshramCSA
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 07/18/2023
ms.topic: conceptual
ms.subservice: caf-scenario-sap
ms.custom: think-tank, e2e-sap, UpdateFrequency2
---

# Data integration security for SAP on Azure

This article is part of the "SAP extend and innovate data: Best practices" article series.

- [Identify SAP data sources](./sap-lza-identify-sap-data-sources.md)
- [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md)
- [Performance and troubleshooting for SAP data extraction](./sap-lza-data-extraction-performance-troubleshooting.md)
- [Data integration security for SAP on Azure](./sap-lza-data-integration-security.md)
- [SAP data integration generic architecture](./sap-lza-data-example-architecture.md)

This article describes the security layers for SAP extend scenarios, provides a breakdown of each component, and offers considerations and recommendations. Azure Data Factory management resources are built on the Azure security infrastructure, and they use Azure security measures.

The data ingestion layer consists of:

- SAP S/4HANA, SAP BW/4HANA, or SAP HANA enterprise edition
- Azure Data Lake Storage Gen2
- Data Factory
- A self-hosted integration runtime (SHIR) virtual machine (VM)

The following diagram is an example architecture of SAP data integration security on Azure. Use the example architecture as a starting point.

:::image type="content" source="./media/sap-extend-security-architecture.png" lightbox="./media/sap-extend-security-architecture.png" border="false" alt-text="Diagram that shows the SAP data integration security architecture on Azure.":::
_Download a [Visio file](https://arch-center.azureedge.net/sap-extend-security-architecture.vsdx) of this architecture._

## Considerations and recommendations

The following sections describe data integration security considerations and recommendations for SAP on Azure.

### SAP security

The SAP security guide has detailed guidance for SAP products.

- [SAP BW/4HANA security](https://help.sap.com/docs/SAP_BW4HANA/d3b558c9e49d4eb495c99c63a0ae549a/4f0b56878a585f86e10000000a42189b.html?q=SAP%20Bw4HANA%20security)
- [SAP S/4HANA security](https://help.sap.com/doc/d7c2c95f2ed2402c9efa2f58f7c233ec/2020/en-US/SEC_OP2020.pdf)
- [SAP HANA security](https://help.sap.com/doc/eec734dbb0fd1014a61590fcb5411390/2.0.05/en-US/SAP_HANA_Security_Guide_en.pdf)

### Data Lake Storage Gen2 security

See the following considerations for Data Lake Storage Gen2 security.

#### Authorize access to data in Azure Storage

When you access data in your Storage account, your client application makes a request over HTTP/HTTPS to Storage. By default, every resource in Storage is secure, and every request to a secure resource must be authorized. Storage offers many options for authorizing access to data. We recommend using Microsoft Entra credentials to authorize requests to data for optimal security and simplicity. For more information, see [Protect your access keys](/azure/storage/common/authorize-data-access#protect-your-access-keys).

#### Azure role-based access control (RBAC)

Use RBAC to manage a security principal's permissions to blob, queue, and table resources in a Storage account. You can also use Azure attribute-based access control (ABAC) to add conditions to Azure role assignments for blob resources. For more information, see [Authorize access to Azure Blob Storage by using Azure role assignment conditions](/azure/storage/blobs/storage-auth-abac).

#### Blob storage security

Consider security recommendations for blob storage, like data protection, identity and access management, networking, logging, and monitoring. For more information, see [Security recommendations for blob storage](/azure/storage/blobs/security-recommendations).

#### Data Lake Storage Gen2 access control

Data Lake Storage Gen2 supports the following authorization strategies:

- RBAC
- Access control lists (ACLs)
- Security groups
- Shared-key and shared-access signature (SAS) authorization

There are two kinds of ACLs in Data Lake Storage Gen2:

- _Access ACLs_ control access to an object. Files and directories have access ACLs.
- _Default ACLs_ are templates of ACLs that are associated with a directory. They determine the access ACLs for any child items that are created under that directory. Files don't have default ACLs.

In an ACL entry, don't directly assign individual users or service principals. Always use Microsoft Entra security groups as the assigned principal. This practice lets you add and remove users or service principals without reapplying ACLs to an entire directory structure. Instead, you can add or remove users and service principals from the appropriate Microsoft Entra security group. For more information, see [Access control lists](/azure/storage/blobs/data-lake-storage-access-control).

### Data Factory security

See the following considerations for Data Factory security.

#### Data movement

There are two data movement scenarios: a cloud scenario and a hybrid scenario. For information about data movement security, see [Security considerations for data movement in Data Factory](/azure/data-factory/data-movement-security-considerations).

- In a _cloud scenario_, your source and your destination are publicly accessible through the internet. Your source or destination might be managed cloud storage services, such as Azure Storage, Azure Synapse Analytics, Azure SQL Database, Data Lake Storage Gen2, Amazon S3, Amazon Redshift, software-as-a-service (SaaS) services, such as Salesforce, or web protocols, such as file transfer protocol (FTP) and open data protocol (OData). Find a complete list of supported data sources in supported data stores and formats.

- In a _hybrid scenario_, either your source or your destination is behind a firewall or inside an on-premises corporate network. Or the data store is in a private network or virtual network and isn't publicly accessible. In that case, the data store is usually the source. The hybrid scenario also includes database servers that are hosted on virtual machines.

#### Data access strategies

Your organization wants to protect their data stores, such as on-premises or cloud/SaaS data stores, from unauthorized access via the internet. You can control access in your cloud data store by using:

- A private link from a virtual network to a private endpoint-enabled data source.
- Firewall rules that limit connectivity by using an IP address.
- Authentication strategies that require users to prove their identity.
- Authorization strategies that restrict users to specific actions and data.

For more information, see [Data access strategies](/azure/data-factory/data-access-strategies).

#### Store credentials in Azure Key Vault

You can store credentials for data stores and computes in Key Vault. Data Factory retrieves the credentials when an activity runs that uses the data store or compute. For more information, see [Store credentials in Key Vault](/azure/data-factory/store-credentials-in-key-vault) and [Use Key Vault secrets in pipeline activities](/azure/data-factory/how-to-use-azure-key-vault-secrets-pipeline-activities).

#### Encrypt credentials

In Data Factory, consider encrypting credentials for on-premises data stores. On a machine with a SHIR, you can encrypt and store credentials for any of your on-premises data stores, such as linked services with sensitive information. For more information, see [Encrypt credentials for on-premises data stores in Data Factory](/azure/data-factory/encrypt-credentials-self-hosted-integration-runtime).

#### Use a managed identity

When you use a managed identity, you don't have to manage credentials. A managed identity provides an identity for the service instance when it connects to resources that support Microsoft Entra authentication.
There are two types of supported managed identities: System-assigned managed identities and user-assigned managed identities. For more information, see [Managed identity for Data Factory](/azure/data-factory/data-factory-service-identity).

#### Encrypt with customer-managed keys

Depending on your security policies, consider encrypting Data Factory with customer-managed keys. For more information, see [Encrypt Data Factory with customer-managed keys](/azure/data-factory/enable-customer-managed-key).

#### Use a managed virtual network

When you create an Azure integration runtime within a Data Factory-managed virtual network, the integration runtime is provisioned with the managed virtual network. It uses private endpoints to securely connect to the supported data stores. A private endpoint is a private IP address within a specific virtual network and subnet. The managed virtual network is only supported in the same region as the Data Factory region. For more information, see [Data Factory managed virtual network](/azure/data-factory/managed-virtual-network-private-endpoint).

#### Use Azure Private Link

When you use Private Link, you can connect to platform-as-a-service (PaaS) deployments in Azure via a private endpoint. For a list of PaaS deployments that support Private Link, see [Private Link for Data Factory](/azure/data-factory/data-factory-private-link).

### SHIR VM connections and security

See the following considerations for SHIR VM connections and security.

#### On-premises data store credentials

You can store on-premises data store credentials in Data Factory, or reference the credentials by using Data Factory during the runtime from Key Vault. If you store credentials in Data Factory, always encrypt them on a SHIR. For more information, see [On-premises data store credentials](/azure/data-factory/data-movement-security-considerations#on-premises-data-store-credentials).

#### Set up a SHIR based on your network configuration

For a hybrid data movement, the following table summarizes the network and SHIR configuration recommendations based on different combinations of source and destination locations.

| **Source**  | **Destination**   | **Network configuration**   | **Integration runtime setup**  |
| ----------- | ----------------- |  -------------------------- | -----------------------------  |
|On-premises| Virtual machines and cloud services deployed in virtual networks | IPSec VPN (point-to-site or site-to-site)|Install a SHIR on an Azure virtual machine in the virtual network |
|On-premises  | Virtual machines and cloud services deployed in virtual networks | Azure ExpressRoute (private peering) | Install a SHIR on an Azure virtual machine in the virtual network |
| On-premises | Azure-based services that have a public endpoint | ExpressRoute (Microsoft peering) | Install a SHIR on-premises or on an Azure virtual machine|

#### ExpressRoute or IPSec VPN

The following images show how to use a SHIR to move data between an on-premises database and an Azure service by using Azure Virtual Network and ExpressRoute or IPSec VPN.

For firewall configurations and allowlist setup for IP addresses, see [Security considerations for data movement in Data Factory](/azure/data-factory/data-movement-security-considerations).

This diagram shows how to move data by using ExpressRoute private peering:

:::image type="content" source="./media/sap-security-expressroute.png" border="false" alt-text="Diagram that shows ExpressRoute on Azure." lightbox="./media/sap-security-expressroute.png":::

This diagram shows how to move data by using IPSec VPN:

:::image type="content" source="./media/sap-extend-security-ipsec.svg" border="false" alt-text="Diagram that shows IPSec VPN on Azure." lightbox="./media/sap-extend-security-ipsec.svg":::

In the firewall, ensure that the IP address of the SHIR machine is allowed and configured appropriately. The following cloud data stores require that you allow the IP address of the SHIR machine. By default, some of these data stores might not require allowlist.

- SQL Database
- Azure Synapse Analytics
- Data Lake Storage Gen2
- Azure Cosmos DB
- Amazon Redshift
  
For more information, see [Security considerations for data movement in Data Factory](/azure/data-factory/data-movement-security-considerations) and [Create and configure a SHIR](/azure/data-factory/create-self-hosted-integration-runtime?tabs=data-factory).

### Azure Databricks security

See the following considerations for Azure Databricks security.

#### Azure security baseline for Azure Databricks

Consider the [Azure security baseline for Azure Databricks](/security/benchmark/azure/baselines/azure-databricks-security-baseline). This security baseline applies guidance from the Microsoft cloud security benchmark version 1.0 to Azure Databricks. The Microsoft cloud security benchmark provides recommendations about how to secure your cloud solutions on Azure.

### Azure Synapse Analytics security

Azure Synapse Analytics implements a multi-layered security architecture for end-to-end protection of your data. There are five layers:

- **Data protection** identifies and classifies sensitive data and encrypts data at rest and in motion. For data discovery and classification, governance, and encryption recommendations, see [Data protection](/azure/synapse-analytics/guidance/security-white-paper-data-protection).

- **Access control** determines a user's right to interact with data. Azure Synapse Analytics supports a wide range of capabilities to control who can access what data. For more information, see [Access control](/azure/synapse-analytics/guidance/security-white-paper-access-control).

- **Authentication** proves the identity of users and applications. Azure SQL Auditing can log authentication activities, and an IT administrator can configure reports and alerts whenever there's an attempted sign in from a suspicious location. For more information, see [Authentication](/azure/synapse-analytics/guidance/security-white-paper-authentication).

- **Network security** isolates network traffic with private endpoints and virtual private networks. There are many network security options to secure Azure Synapse Analytics. For more information, see [Network security](/azure/synapse-analytics/guidance/security-white-paper-network-security).

- **Threat detection** identifies potential security threats, such as unusual access locations, SQL injection attacks, and authentication attacks. For more information, see [Threat detection](/azure/synapse-analytics/guidance/security-white-paper-threat-protection).

### Data presentation layer

Consider how you can use security capabilities to defend the presentation layer, including Power BI. For more information, see [Power BI security](/power-bi/guidance/whitepaper-powerbi-security) and [Power BI implementation planning: Security](/power-bi/guidance/powerbi-implementation-planning-security-overview).

## Next steps

- [Identify SAP data sources](./sap-lza-identify-sap-data-sources.md)
- [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md)
- [Performance and troubleshooting for SAP data extraction](./sap-lza-data-extraction-performance-troubleshooting.md)
- [SAP data integration generic architecture](./sap-lza-data-example-architecture.md)
