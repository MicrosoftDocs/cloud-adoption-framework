---
title: Data Privacy for Cloud-Scale Analytics in Azure
description: Learn about data privacy for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 1/6/2025
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---
# Data privacy for cloud-scale analytics in Azure

Cloud-scale analytics help you determine the optimal data-access patterns that suit your requirements while safeguarding personal data at multiple levels. Personal data includes any information that can uniquely identify individuals, for example driver's license numbers, social security numbers, bank account details, passport numbers, and email addresses. Many regulations exist today to protect user privacy.

To protect data privacy within a cloud environment such as Azure, you can create a data-confidentiality scheme that specifies data-access policies. These policies can define the underlying architecture that the data application resides on, define how data access is authorized, and specify what rows or columns can be accessed after its granted.

## Create a data-confidentiality classification scheme

[!INCLUDE [data-confidentiality-classification-scheme](includes/data-confidentiality-classification-scheme.md)]

Before you ingest data, you must categorize the data as either **confidential or below** or **sensitive (personal data)**:

- Sort data into **confidential or below** if there are no restrictions on which columns and rows are visible to various users.
- Sort data into **sensitive (personal data)** if there are restrictions on which columns and rows are visible to various users.

> [!IMPORTANT]
> A dataset can change from **confidential or below** to **sensitive (personal data)** when you combine data with other data products that previously had a lower classification. When you need persistent data, move it to a designated folder that aligns with its confidentiality level and the onboarding process.

## Create an Azure policy set

After you map your data classification, you should align the classification with your industry policy requirements and internal company policies. This step helps you create an Azure policy set that governs what infrastructure can be deployed, the location where it can be deployed, and specifies networking and encryption standards.

For regulated industries, Microsoft developed many [regulatory compliance policy initiatives](/industry/sovereignty/policy-portfolio-baseline), which act as a baseline for compliance frameworks.

For data classification, which follows the same rules for encryption and allowed infrastructure SKUs, and policy initiatives, the data can sit inside the same landing zone.

For restricted data, you should host data in a dedicated data landing zone under a management group where you can define a higher set of requirements for infrastructure. For example, you might define customer-managed keys for encryption or inbound or outbound restrictions for the landing zone.

> [!NOTE]
> You can put **sensitive (personal data)** and **confidential or below** data into the same data landing zone but different storage accounts. But this practice might complicate the solution on the networking layer, for example with network security groups.

Any deployed data governance solution should limit who can search for restricted data in the catalog.

You should also consider implementing Microsoft Entra ID conditional access for all data assets and services. To enhance security, apply just-in-time access for restricted data.

## Encryption

In addition to defining policies for location and allowed Azure services, you should consider the encryption requirements for each of the data classifications.

- What are your requirements for key management?
- What are your requirements for storing those keys?
- What are your requirements, per classification, for data-at-rest encryption?
- What are your requirements, per classification, for data-in-transit encryption?
- What are your requirements, per classification, for data-in-use encryption?

For key management, you can use platform-managed or customer-managed encryption keys. For more information, see [Overview of key management in Azure](/azure/security/fundamentals/key-management) and [How to choose the right key management solution](/azure/security/fundamentals/key-management-choose).

For more information about encryption options, see [Azure data encryption at rest](/azure/security/fundamentals/encryption-atrest) and [data encryption models](/azure/security/fundamentals/encryption-models).

You can use the [Transport Layer Security (TLS)](https://en.wikipedia.org/wiki/Transport_Layer_Security) protocol to protect data when it travels between cloud services and customers. For more information, see [Encryption of data in transit](/azure/security/fundamentals/encryption-overview#encryption-of-data-in-transit).

If your scenario requires data to remain encrypted during use, the Azure Confidential Computing threat model helps minimize trust. It minimizes the possibility that cloud provider operators or other actors in the tenant's domain access code and data during implementation.

For more information, see [Azure confidential computing products](/azure/confidential-computing/overview-azure-products).

## Data governance

After you define the policies for the deployment of allowed Azure services, you must decide how you grant access to the data product.

If you have a data governance solution such as [Microsoft Purview](/purview/purview) or [Azure Databricks Unity Catalog](/azure/databricks/data-governance/unity-catalog/), you can create data assets or products for enriched and curated data lake layers. Ensure that you set the permissions within the data catalog to help secure those data objects.

Use Microsoft Purview to centrally manage, secure, and control the following areas:

- Access to data
- The data lifecycle
- Internal and external policies and regulations
- Data-sharing policies
- Identifying sensitive data
- Insights about protection and compliance
- Policies for data protection reporting

For more information about managing read or modify access with Microsoft Purview, see [Microsoft Purview data owner policies concepts](/purview/concept-policies-data-owner).

Whether you decide to implement Microsoft Purview or another data governance solution, use Microsoft Entra ID groups to apply policies to data products.

Use the data governance solutions' REST API to onboard a new dataset. Data application teams create data products and register them in the data governance solution to help identify sensitive data. The data governance solution imports the definition and denies all access to data until the teams set up its access policies.

## Use patterns to protect sensitive data

There are several patterns that can be adopted depending on the data, services, and policies you need to implement for the protection of sensitive data.

### Multiple copies

For every data product which is classified as **sensitive (personal data)**, two copies are created by its pipeline. The first copy is classified as **confidential or below**. This copy has all of the **sensitive (personal data)** columns removed and is created under the **confidential or below** folder for the data product. The other copy is created in the **sensitive (personal data)** folder and has all of the sensitive data included. Each folder is assigned a Microsoft Entra ID reader and a Microsoft Entra ID writer security group.

If Microsoft Purview is in use, you can register both versions of the data product and use policies to secure the data.

This process separates out **sensitive (personal data)** and **confidential or below** data, but a user who's granted access to **sensitive (personal data)** will be able to query all rows. Your organization might need to look at other solutions which provide row-level security to filter rows.

### Row-level and column-level security

If you need to filter rows seen by users, you can move your data into a compute solution that uses row-level security.

Selecting the appropriate Azure service or Microsoft Fabric solution for your particular use case is essential to prevent re-engineering. An OLTP database is unsuitable for extensive analytics, just as a solution tailored for big data analytics can't achieve millisecond response times required by an e-commerce application.

To work with solutions that support row-level security, the data application teams create different Microsoft Entra ID groups and assign permissions based on the data's sensitivity.

Let's elaborate on the scenario by specifying that along with row-level security, there's a need to restrict access to certain columns. The data application teams created the four Microsoft Entra ID groups with read-only access as shown in the following table:

| **Group** | **Permission** |
|---|---|
| `DA-AMERICA-HRMANAGER-R` | View North America HR personnel data asset **with** salary information. |
| `DA-AMERICA-HRGENERAL-R` | View North America HR personnel data asset **without** salary information. |
| `DA-EUROPE-HRMANAGER-R` | View Europe HR personnel data asset **with** salary information. |
| `DA-EUROPE-HRGENERAL-R` | View Europe HR personnel data asset **without** salary information. |

The first level of restrictions would support dynamic data masking, which hides sensitive data from users without privileges. One advantage of this approach is that it can be integrated into a data set's onboarding with a REST API.

The second level of restrictions is to add column-level security to restrict non-HR managers from seeing salaries and row-level security to restrict which rows European and North American team members can see.

### Column encryption

While dynamic data masking masks the data at the point of presentation, some use cases require that the solution never has access to the plaintext data.

SQL Always Encrypted is a powerful feature introduced by Microsoft that enhances the security of sensitive data stored in SQL Server databases. SQL Always Encrypted ensures that sensitive data stored in SQL Server databases remains secure and protected from unauthorized access. This feature helps in maintaining maximum data confidentiality and regulatory compliance by encrypting the data both at rest and in transit.

By performing encryption and decryption operations on the client side, Always Encrypted ensures that sensitive data remains protected from unauthorized access. Its ease of integration and compliance benefits make it an essential tool for organizations looking to safeguard their most valuable data assets.

## Next steps

> [!div class="nextstepaction"]
> [Organize data operations team members](organize.md)