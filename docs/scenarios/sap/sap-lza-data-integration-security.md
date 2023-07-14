---
title: Data integration security for SAP on Azure
description: Learn about data integrations security for SAP on Azure
author: pankajmeshramCSA
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 07/17/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap, UpdateFrequency2
---

# Data integration security for SAP on Azure

This article is part of the "SAP extend and innovate data: Best practices" article series.

- [Identify SAP data sources](./sap-lza-identify-sap-data-sources.md)
- [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md)
- [Performance and troubleshooting for SAP data extraction](./sap-lza-data-extraction-performance-troubleshooting.md)
- [Data integration security for SAP on Azure](./sap-lza-data-integration-security.md)
- [SAP data integration generic architecture](./sap-lza-data-example-architecture.md)

The sections below describes different security layers in SAP Extend Scenarios, breaks down each component and provides considerations and recommendations on them. Additionally, Azure Data Factory management resources are built on Azure security infrastructure and use security measures offered by Azure.

Data ingestion layer:

- SAP S/4 HANA/SAP BW4HANA/SAP Enterprise HANA
- Azure Data Lake Storage Gen2
- Data Factory
- Self-hosted integration runtime (SHIR) virtual machine (VM)

The following diagram is an example architecture of SAP data integration security on Azure. Use the example architecture as a starting point.

:::image type="content" source="./media/sap-extend-security-architecture.svg" lightbox="./media/sap-extend-security-architecture.svg" border="false" alt-text="Diagram that shows the SAP Data Integration Security architecture on Azure.":::
_Download a [Visio file](https://arch-center.azureedge.net/sap-extend-security-architecture.vsdx) of this architecture._

The sections below discusses considerations and recommendations for data integration security for SAP on Azure.

## SAP security

The source systems referenced in the diagram - section 1

![Screenshot that shows SAP source systems.](./media/sap-extend-security-architecture-sap-sources1.png)

The SAP security guide has detailed security guidance on various SAP products. Consider analyzing the following security recommendations in the SAP guidance:

- [SAP BW security guide](https://help.sap.com/docs/SAP_BW4HANA/d3b558c9e49d4eb495c99c63a0ae549a/4f0b56878a585f86e10000000a42189b.html?q=SAP%20Bw4HANA%20security)
- [SAP S4HANA security](https://help.sap.com/doc/d7c2c95f2ed2402c9efa2f58f7c233ec/2020/en-US/SEC_OP2020.pdf)
- [SAP HANA security](https://help.sap.com/doc/eec734dbb0fd1014a61590fcb5411390/2.0.05/en-US/SAP_HANA_Security_Guide_en.pdf)

## Security for Data Lake Storage Gen2

![Screenshot that shows ADLS2.](./media/sap-extend-security-architecture-adls2.png)

### Authorize access to data in Azure Storage

Each time you access data in your storage account, your client application makes a request over HTTP/HTTPS to Storage. By default, every resource in Storage is secured, and every request to a secure resource must be authorized. Understand different options that Storage offers for authorizing access to data. Microsoft recommends using Azure Active Directory (Azure AD) credentials to authorize requests to data when possible for optimal security and ease of use. See further details [here](/azure/storage/common/authorize-data-access?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json#protect-your-access-keys)

### Azure role-based access control (RBAC)

Consider the use of RBAC to manage a security principal's permissions to blob, queue, and table resources in a storage account. You can also use Azure attribute-based access control (ABAC) to add conditions to Azure role assignments for blob resources. See further details here - Authorize access to Azure Blob Storage using Azure role assignment conditions - [Azure Storage](/azure/storage/blobs/storage-auth-abac)

### Blob storage security recommendations

Consider the security recommendations for Blob storage from data protection, identity, and access management, networking, logging/monitoring perspective mentioned. See [Security recommendations for Blob storage](/azure/storage/blobs/security-recommendations)

### Data Lake Storage Gen2 access control

Data Lake Storage Gen2 supports the following authorization mechanisms:

- RBAC
- Access control lists (ACLs)
- Security groups
- Shared key and shared access signature (SAS) authorization

There are two kinds of ACLs in Data Lake Storage Gen2. Always use Azure AD security groups as the assigned principal in an ACL entry. Resist the opportunity to directly assign individual users or service principals. Using this structure will allow you to add and remove users or service principals without the need to reapply ACLs to an entire directory structure. Instead, you can just add or remove users and service principals from the appropriate Azure AD security group.

- **Access ACLs** - Access ACLs control access to an object. Files and directories both have access ACLs.
- **Default ACLs** - Default ACLs are templates of ACLs associated with a directory that determine the access ACLs for any child items that are created   under that directory. Files do not have default ACLs.

For more information, see [Access control lists](/azure/storage/blobs/data-lake-storage-access-control).

## Data Factory security

![Screenshot that shows ADF.](./media/sap-extend-security-architecture-adf1.png)

### Data movement security considerations

Consider the Security considerations for data movement in Data Factory for the following scenarios mentioned [here](/azure/data-factory/data-movement-security-considerations).

### Cloud scenario

In this scenario, both your source and your destination are publicly accessible through the internet. These include managed cloud storage services, such as Azure Storage, Azure Synapse Analytics, Azure SQL Database, Azure Data Lake Store, Amazon S3, Amazon Redshift, SaaS services such as Salesforce, and web protocols such as FTP and OData. Find a complete list of supported data sources in supported data stores and formats.

### Hybrid scenario

In this scenario, either your source or your destination is behind a firewall or inside an on-premises corporate network. Or the data store is in a private network or virtual network (most often the source) and is not publicly accessible. Database servers hosted on virtual machines also fall under this scenario.

### Data access strategies

A vital security goal of an organization is to protect their data stores from random access over the internet, might it be an on-premises or a Cloud/ SaaS data store. Typically, a cloud data store controls access using the below mechanisms:

- A private link from a virtual network to a private endpoint-enabled data source.
- Firewall rules that limit connectivity by IP address
- Authentication mechanisms that require users to prove their identity
- Authorization mechanisms that restrict users to specific actions and data

To learn more, see [Data access strategies](/azure/data-factory/data-access-strategies).

### Store credentials in Azure Key Vault

You can store credentials for data stores and computes in Key Vault. Data Factory retrieves the credentials when executing an activity that uses the data store/compute.

To learn more, see these resources:

- [Store credentials in Key Vault](/azure/data-factory/store-credentials-in-key-vault)
- [Use Key Vault secrets in pipeline activities](/azure/data-factory/how-to-use-azure-key-vault-secrets-pipeline-activities)

### Encrypt credentials

Consider encrypting credentials for on-premises data stores in Data Factory.

You can encrypt and store credentials for any of your on-premises data stores (linked services with sensitive information) on a machine with SHIR.

For more information, see [Encrypt credentials in Data Factory](/azure/data-factory/encrypt-credentials-self-hosted-integration-runtime)

### Use managed identity

Managed identities eliminate the need to manage credentials. Managed identities provide an identity for the service instance when connecting to resources that support Azure AD authentication.
There are two types of supported managed identities: System-assigned and user-assigned.

For more information, see [Managed identity for Data Factory](/azure/data-factory/data-factory-service-identity) for more details.

### Encrypt with customer-managed keys

Depending on your security policies, consider the encryption of Data Factory with customer-managed keys. For more information, see [here](/azure/data-factory/enable-customer-managed-key)

### Use a managed virtual network

When you create an Azure integration runtime within a Data Factory-managed virtual network, the integration runtime is provisioned with the managed virtual network. It uses private endpoints to securely connect to supported data stores. The managed virtual network is only supported in the same region as the Data Factory region.

For more information, see [Managed virtual network and managed private endpoints](/azure/data-factory/managed-virtual-network-private-endpoint).

### Use Azure Private Link

By using Private Link, you can connect to platform as a service (PaaS) deployments in Azure via a private endpoint. A private endpoint is a private IP address within a specific virtual network and subnet. For a list of PaaS deployments that support Private Link functionality, see [Private Link for Data Factory](/azure/data-factory/data-factory-private-link).

## SHIR VM connections and security

![Screenshot that shows SHIR.](./media/sap-extend-security-architecture-shir1.png)

### On-premises data store credentials

The credentials can be stored within Data Factory or be referenced by Data Factory during the runtime from Key Vault. If storing credentials within Data Factory, it is always stored encrypted on the SHIR.

For more information, see [On-premises data store credentials](/azure/data-factory/data-movement-security-considerations#on-premises-data-store-credentials).

### Set up SHIR based on your network configuration

The following table summarizes the network and SHIR configuration recommendations based on different combinations of source and destination locations for hybrid data movement.

| **Source**  | **Destination**   | **Network Configuration**   | **Integration Runtime Setup**  |
| ----------- | ----------------- |  -------------------------- | -----------------------------  |
|On-Premises| Virtual machines and cloud services deployed in virtual networks | IPSec VPN (point-to-site or site-to-site)|The SHIR should be installed on an Azure virtual machine in the virtual network |
|On-Premises  | Virtual machines and cloud services deployed in virtual networks | Azure ExpressRoute (private peering) | The SHIR should be installed on an Azure virtual machine in the virtual network |
| On-Premises | Azure-based services that have a public endpoint | ExpressRoute (Microsoft peering) | The SHIR can be installed on-premises or on an Azure virtual machine|

### ExpressRoute or IPSec VPN

The following images show the use of SHIR for moving data between an on-premises database and Azure services by using ExpressRoute and IPSec VPN with Azure Virtual Network

See [Security considerations for data movement in Data Factory](/azure/data-factory/data-movement-security-considerations) for firewall configurations and allow list setting up for IP addresses mentioned.

**ExpressRoute private peering**:

:::image type="content" source="./media/sap-security-expressroute.svg" border="false" alt-text="Diagram that shows ExpressRoute on Azure.":::

**IPSec VPN**:

:::image type="content" source="./media/sap-extend-security-ipsec.svg" border="false" alt-text="Diagram that shows IPSec VPN on Azure.":::

- Ensure that the IP address of the SHIR machine is allowed or configured in the firewall appropriately. The following cloud data stores require that you allow the IP address of the SHIR machine. Some of these data stores, by default, might not require allow list.
  - Azure SQL Database
  - Azure Synapse Analytics
  - Azure Data Lake Store
  - Azure Cosmos DB
  - Amazon Redshift
  
   For more information, see [Security considerations for data movement in Data Factory](/azure/data-factory/data-movement-security-considerations) and [Create and configure a SHIR](/azure/data-factory/create-self-hosted-integration-runtime?tabs=data-factory).

## Azure Databricks security

![Screenshot that shows Azure DataBricks.](./media/sap-extend-security-architecture-azure-databricks.png)

### Azure security baseline for Azure Databricks

Consider the [Azure security baseline for Azure Databricks](/security/benchmark/azure/baselines/azure-databricks-security-baseline) mentioned here.

This security baseline applies guidance from the Microsoft cloud security benchmark version 1.0 to Azure Databricks. The Microsoft cloud security benchmark provides recommendations on how you can secure your cloud solutions on Azure.

## Azure Synapse security

![Screenshot that shows Synapse.](./media/sap-extend-security-architecture-synapse1.png)

Azure Synapse implements a multi-layered security architecture for end-to-end protection of your data. There are five layers:

- **Data protection** to identify and classify sensitive data, and encrypt data at rest and in motion – Consider the [Data protection - Azure Synapse Analytics](/azure/synapse-analytics/guidance/security-white-paper-data-protection) whitepaper to understand options available for data discovery & classification, governance and encryption recommendations.

- **Access control** to determine a user's right to interact with data - Azure Synapse supports a wide range of capabilities to control who can access what data. Consider the recommendations mentioned in the [Security whitepaper](/azure/synapse-analytics/guidance/security-white-paper-access-control)

- **Authentication** to prove the identity of users and applications – Authentication is the process of proving the user is who they claim to be. Authentication activities can be logged with Azure SQL Auditing, and an IT administrator can configure reports and alerts whenever a login from a suspicious location is attempted. Consider the recommendations mentioned in the [Authentication Security whitepaper](/azure/synapse-analytics/guidance/security-white-paper-authentication)

- **Network security** to isolate network traffic with private endpoints and virtual private networks - To secure Azure Synapse, there are a range of network security options to consider. Consider the details mentioned in the [Network Security whitepaper](/azure/synapse-analytics/guidance/security-white-paper-network-security)

- **Threat protection** to identify potential security threats, such as unusual access locations, SQL injection attacks, authentication attacks, and more. Consider the details mentioned in the [Threat Protection Whitepaper](/azure/synapse-analytics/guidance/security-white-paper-threat-protection)

## Data presentation layer

Consider how you can use security capabilities to secure the presentation layer, including Power BI.

See the below resources for additional information:

- [Power BI security white paper](/power-bi/guidance/whitepaper-powerbi-security)
- [Power BI implementation planning: Security](/power-bi/guidance/powerbi-implementation-planning-security-overview)

## Next steps

- [Example architecture](./sap-lza-data-example-architecture.md)
