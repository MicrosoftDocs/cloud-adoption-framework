---
title: Data Privacy for Cloud-Scale Analytics in Azure
description: Learn about how to use cloud-scale analytics to determine the optimal data-access patterns that suit your requirements while safeguarding personal data at multiple levels.
author: stephen-sumner
ms.author: pnp
ms.date: 1/6/2025
ms.topic: concept-article
ms.custom: e2e-data-management, think-tank
---
# Data privacy for cloud-scale analytics in Azure

Cloud-scale analytics help you determine the optimal data-access patterns that suit your requirements while safeguarding personal data at multiple levels. Personal data includes any information that can uniquely identify individuals, for example driver's license numbers, social security numbers, bank account details, passport numbers, and email addresses. Many regulations exist to protect user privacy.

To protect data privacy within a cloud environment such as Azure, you can create a data-confidentiality scheme that specifies data-access policies. These policies can define the underlying architecture that the data application resides on, define how to authorize data access, and specify what rows or columns users can access.

## Create a data-confidentiality classification scheme

[!INCLUDE [data-confidentiality-classification-scheme](includes/data-confidentiality-classification-scheme.md)]

Before you ingest data, you must categorize the data as either *confidential or below* or *sensitive personal data*:

- Sort data into confidential or below if you don't need to restrict which columns and rows users can view.
- Sort data into sensitive personal data if you need to restrict which columns and rows users can view.

> [!IMPORTANT]
> A dataset can change from confidential-or-below to sensitive personal data when you combine data with other data products that previously had a lower classification. If you need persistent data, move it to a designated folder that aligns with its confidentiality level and the onboarding process.

## Create an Azure policy set

After you classify your data, you should align the classification with your industry policy requirements and internal company policies. You want to create an Azure policy set that governs what infrastructure can be deployed, the location where it can be deployed, and networking and encryption standards.

For regulated industries, you can use Microsoft [regulatory compliance policy initiatives](/industry/sovereignty/policy-portfolio-baseline) as a baseline for compliance frameworks.

Data classification follows the same rules for encryption, allowed infrastructure SKUs, and policy initiatives. So you can store all data within the same landing zone.

For restricted data, you should host data in a dedicated data landing zone under a management group where you can define a higher set of requirements for infrastructure. For example, you might define customer-managed keys for encryption or inbound or outbound restrictions for the landing zone.

> [!NOTE]
> You can put sensitive personal data and confidential-or-below data in the same data landing zone but different storage accounts. But this practice might complicate the solution on the networking layer, for example with network security groups.

A deployed data governance solution should limit who can search for restricted data in the catalog. Consider implementing Microsoft Entra ID Conditional Access for all data assets and services. To enhance security, apply just-in-time access for restricted data.

## Consider encryption requirements

In addition to defining policies for locations and allowed Azure services, consider the encryption requirements for each data classification. Consider the requirements for the following areas:

- Key management
- Key storage
- Data-at-rest encryption
- Data-in-transit encryption
- Data-in-use encryption

For key management, you can use platform-managed or customer-managed encryption keys. For more information, see [Overview of key management in Azure](/azure/security/fundamentals/key-management) and [How to choose the right key management solution](/azure/security/fundamentals/key-management-choose).

For more information about encryption options, see [Azure data encryption at rest](/azure/security/fundamentals/encryption-atrest) and [Data encryption models](/azure/security/fundamentals/encryption-models).

You can use the [Transport Layer Security (TLS)](https://en.wikipedia.org/wiki/Transport_Layer_Security) protocol to protect data that travels between cloud services and customers. For more information, see [Encryption of data in transit](/azure/security/fundamentals/encryption-overview#encryption-of-data-in-transit).

If your scenario requires that data remains encrypted during use, the Azure Confidential Computing threat model helps minimize trust. It minimizes the possibility that cloud provider operators or other actors in the tenant's domain can access code and data during implementation.

For more information, see [Azure confidential computing products](/azure/confidential-computing/overview-azure-products).

## Implement data governance

After you define the policies for the deployment of allowed Azure services, determine how to grant access to the data product.

If you have a data governance solution such as [Microsoft Purview](/purview/purview) or [Azure Databricks Unity Catalog](/azure/databricks/data-governance/unity-catalog/), you can create data assets or products for enriched and curated data lake layers. Ensure that you set the permissions within the data catalog to help secure those data objects.

Use Microsoft Purview to centrally manage, secure, and control the following areas:

- Access to data
- The data lifecycle
- Internal and external policies and regulations
- Data-sharing policies
- Identifying sensitive data
- Insights about protection and compliance
- Policies for data protection reporting

For more information about how to use Microsoft Purview to manage read or modify access, see [Concepts for Microsoft Purview data owner policies](/purview/concept-policies-data-owner).

Whether you decide to implement Microsoft Purview or another data governance solution, use Microsoft Entra ID groups to apply policies to data products.

Use the data governance solution's REST API to onboard a new dataset. Your data application teams create data products and register them in the data governance solution to help identify sensitive data. The data governance solution imports the definition and denies all access to the data until your teams set up its access policies.

## Use data-protection patterns

To protect sensitive data, choose a data-protection pattern based on the data, services, and policies that you implement.

### Multiple copies

The pipeline for every data product that has a sensitive personal-data classification creates two copies. The pipeline classifies the first as confidential or below. This copy doesn't include the sensitive personal-data columns. It's created under the confidential-or-below folder for the data product. The other copy is created in the sensitive personal-data folder. This copy includes the sensitive data. Each folder is assigned a Microsoft Entra ID reader and a Microsoft Entra ID writer security group.

If you use Microsoft Purview, you can register both versions of the data product and use policies to help secure the data.

The multiple copies pattern separates sensitive personal data and confidential-or-below data. But if you grant a user access to sensitive personal data, they can query all rows. Your organization might need to consider other solutions that provide row-level security to filter rows.

### Row-level and column-level security

If you need to filter rows that users can view, you can move your data into a compute solution that uses row-level security.

To prevent re-engineering, select the appropriate Azure service or Microsoft Fabric solution for your particular use case. Different types of databases are designed for different purposes. For example, you shouldn't use an online transaction processing (OLTP) database for extensive analytics. And if you use an e-commerce application, you shouldn't use a solution that's tailored for big data analytics because it can't achieve the required millisecond response times.

If you implement solutions that support row-level security, your data application teams must create different Microsoft Entra ID groups and assign permissions based on the data's sensitivity.

In addition to row-level security, you can restrict access to certain columns. The following table shows an example of four Microsoft Entra ID groups that have read-only access:

| Group | Permission |
|---|---|
| `DA-AMERICA-HRMANAGER-R` | View North America HR personnel data asset **with** salary information. |
| `DA-AMERICA-HRGENERAL-R` | View North America HR personnel data asset **without** salary information. |
| `DA-EUROPE-HRMANAGER-R` | View Europe HR personnel data asset **with** salary information. |
| `DA-EUROPE-HRGENERAL-R` | View Europe HR personnel data asset **without** salary information. |

The first level of restrictions support dynamic data masking, which hides sensitive data from users that don't have privileges. You can use a REST API to integrate this approach into a dataset's onboarding.

The second level of restrictions adds column-level security to restrict non-HR managers from viewing salaries. It also adds row-level security to restrict which rows European and North American team members can view.

### Column encryption

Dynamic data masking masks the data at the point of presentation, but some use cases require that the solution never has access to the plaintext data.

The *SQL Always Encrypted* feature enhances the security of sensitive data in SQL Server databases. SQL Always Encrypted helps ensure that sensitive data in SQL Server databases remains secure and protected from unauthorized access. This feature encrypts the data at rest and in transit, which helps maintain maximum data confidentiality and regulatory compliance. SQL Always Encrypted performs encryption and decryption operations on the client side. Integrate this feature to help safeguard your most valuable data assets.

## Next step

> [!div class="nextstepaction"]
> [Organize data operations team members](organize.md)
