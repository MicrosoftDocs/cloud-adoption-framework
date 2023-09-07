---
title: Data privacy for cloud-scale analytics in Azure
description: Learn about data privacy for cloud-scale analytics in Azure.
author: abdale
ms.author: hamoodaleem
ms.date: 02/14/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data privacy for cloud-scale analytics in Azure

Cloud-scale analytics frees organizations to determine the best patterns to suit their requirements while guarding personal data at multiple levels. Personal data is any data that can be used to identify individuals, for example, driver's license numbers, social security numbers, bank account numbers, passport numbers, email addresses, and more. Many regulations exist today to protect user privacy.

## Data confidentiality classification scheme

[!INCLUDE [data-confidentiality-classification-scheme](includes/data-confidentiality-classification-scheme.md)]

Before ingesting data, you must categorize the data as **confidential or below** or **sensitive (personal data)**:

- Data might be sorted into **confidential or below** if a user gains access to the data asset in **enriched** or **curated**. Users can view all columns and rows.

- Data might be sorted into **sensitive (personal data)** if there are restrictions for which columns and rows are visible to different users.

> [!IMPORTANT]
> A dataset *can* change from **confidential or below** to **sensitive (personal data)** when data is combined. In situations where data should be persistent, it should be copied to a separate folder that aligns with the data confidentiality classification and process for onboarding it.

## Confidential or below

For every onboarded data product, we create two data lake folders in the enriched and curated layers, **confidential or below** and **sensitive (personal data)**, and use access control lists to enable Microsoft Azure directory (Azure AD) Pass-through Authentication.

If a data application team onboards a **confidential or below** data asset, then user principal names and service principal objects can be added to two Azure AD groups (one for read/write access and the other for read-only access). These two Azure AD groups should be created during the onboarding process and sorted in the appropriate data product folder with **confidential or below** containers for raw and enriched data.

This pattern enables any compute product that supports Azure AD Pass-through Authentication to connect to the data lake and authenticate logged-in users. If a user is part of the data asset's Azure AD group, they can access the data via Azure AD Pass-through Authentication. It allows those users inside the group to read the entire data asset without policy filters. Access can then be audited in detail with appropriate logs and Microsoft Graph.

For recommendations on the layout of your data lake please review [Provision three Azure Data Lake Storage Gen2 accounts for each data landing zone](../cloud-scale-analytics/best-practices/data-lake-zones.md).

> [!NOTE]
> Examples of compute products are Azure Databricks, Azure Synapse Analytics, Apache Spark, and Azure Synapse SQL on-demand pools enabled with Azure AD Pass-through Authentication.

## Sensitive data (personal data)

For **sensitive (personal data)**, the enterprise needs to restrict what users can see via policy, data copies or compute. In this case, the organization needs to consider moving or injecting the access control into the compute layer. There are four options to approach securing data within cloud-scale analytics.

### Example scenario

The following example describes options for securing **sensitive (personal data)**:

A data application ingests a human resources (HR) personnel data product for North America and Europe. The use case calls for European users to see only European personnel records and North American users to see only North American personnel records. It's further restricted so that only HR managers see columns containing salary data.

#### Option 1: Policy engine (recommended)

The first two options provide a way to handle **sensitive (personal data)**, and they also grant control to integrations ops and data product teams to identify and restrict access. It might be enough for a small-scale analytics platform, but a policy engine should be placed in the data management landing zone for a large enterprise with hundreds of data products. Policy engines support a central way of managing, securing, and controlling:

- Access to data
- Managing the data lifecycle
- Internal and external policies and regulations
- Data-sharing policies
- Identifying **sensitive (personal data)**
- Insights about protection and compliance
- Policies for data protection reporting

Typically, a policy engine would integrate with a data catalog like Azure Purview. The Azure Marketplace features third-party vendor solutions, and some vendors work with Azure Synapse and Azure Databricks to encrypt and decrypt information while also providing row-level and column-level security. As at Jan 2022, Azure Purview has launched a public preview for access policies to control access to data stored in Blob and Azure Data Lake Storage (ADLS) Gen2. See [Dataset provisioning by data owner for Azure Storage (preview)](/azure/purview/tutorial-data-owner-policies-storage).

The policy engine should use Azure AD groups to apply policies to data products. The expectation for any policy solution providing data privacy is to tokenize **sensitive (personal data)** and to always check through attribute access control so that the user has can detokenize the columns they need to access.

As mentioned, for a policy engine to succeed, it's important for it to integrate into the data catalog and for DevOps to use a REST API to onboard a new dataset. As data application teams create read data sources, they would be registered in the data catalog and help identify **sensitive (personal data)**. The policy engine should import the definition and deny all access to data until the teams have set up its access policies. All of this should be done via a REST API workflow from the IT service management solution.

#### Option 2: Confidential or below and sensitive (personal data) versions

For every data product which is classified as **sensitive (personal data)** two copies are created by it's pipeline. One which is classified as **confidential or below** which has all the **sensitive (personal data)** columns removed and is created under the **confidential or below** folder for the data product. The other copy is created in the **sensitive (personal data)** folder, for the data product, which has all the sensitive data included. Each folder would be assigned an Azure Active Directory reader security group and an Azure Active Directory writer security group. Using [Data Access Management](security-provisioning.md) a user could request access to the data product.

Whilst this fulfills separating out **sensitive (personal data)** and **confidential or below**, a user granted access via Active Directory passthrough authentication to the **sensitive (personal data)** would be able to query all the rows. If you required row-level security then you would need to use [Option 1: Policy engine (recommended)](#option-1-policy-engine-recommended) or [Option 3: Azure SQL Database, SQL Managed Instance, or Azure Synapse Analytics SQL pools](#option-3-azure-sql-database-sql-managed-instance-or-azure-synapse-analytics-sql-pools).

#### Option 3: Azure SQL Database, SQL Managed Instance, or Azure Synapse Analytics SQL pools

A data application uses SQL Database, SQL Managed Instance, or Azure Synapse Analytics SQL pools to load the data products into a database that supports row-level security, column-level security, and dynamic data masking. The data application teams create different Azure AD groups and assign permissions that support the data's sensitivity.

For this scenario's use case, data application teams would need to create the following four Azure AD groups with read-only access:

| Group | Permission|
|--|--|
| `DA-AMERICA-HRMANAGER-R` | View North America HR personnel data asset **with** salary information. |
| `DA-AMERICA-HRGENERAL-R` | View North America HR personnel data asset **without** salary information. |
| `DA-EUROPE-HRMANAGER-R` | View Europe HR personnel data asset **with** salary information. |
| `DA-EUROPE-HRGENERAL-R` | View Europe HR personnel data asset **without** salary information. |

The first level of restrictions would support [dynamic data masking](/azure/azure-sql/database/dynamic-data-masking-overview), which hides sensitive data from users without privileges. One advantage of this approach is that it can be integrated into a data set's onboarding with a REST API.

The second level is to add [column-level security](/azure/synapse-analytics/sql-data-warehouse/column-level-security) to restrict non-HR managers from seeing salaries and [row-level security](/sql/relational-databases/security/row-level-security) to restrict which rows European and North American team members can see.

In addition to transparent data encryption, security layer would be to [encrypt the column of data](/sql/relational-databases/security/encryption/encrypt-a-column-of-data) and decrypt upon read.

The tables can be made available to Azure Databricks with [Apache Spark connector: SQL Server and Azure SQL Database](/sql/connect/spark/connector).

#### Option 4: Azure Databricks

Option four is to use Azure Databricks to explore **sensitive (personal data)**. Using a combination of Fernet encryption libraries, user-defined functions (UDFs), Databricks secrets, table access control, and dynamic view functions helps to encrypt and decrypt columns.

As blog post, [enforcing Column-level encryption and avoiding data duplication](https://databricks.com/blog/2020/11/20/enforcing-column-level-encryption-and-avoiding-data-duplication-with-pii.html), describes:

> The first step in this process is to protect the data by encrypting it during ingestion and one possible solution is the Fernet Python library. Fernet uses symmetric encryption, which is built with several standard cryptographic primitives. This library is used within an encryption UDF that will enable us to encrypt any given column in a data frame. To store the encryption key, we use Databricks secrets with access controls in place to only allow our data ingestion process to access it. Once the data is written to our Delta Lake tables, personal data columns holding values such as social security number, phone number, credit card number, and other identifiers will be impossible for an unauthorized user to read.
>
> Once you have the sensitive data written and protected, you need a way for privileged users to read the sensitive data. The first thing that needs to be done is to create a permanent UDF to add to the Hive instance running on Databricks. In order for a UDF to be permanent, it must be written in Scala. Fortunately, Fernet also has a Scala implementation that you can use for your decrypted reads. This UDF also accesses the same secret used in the encrypted write to do the decryption, and, in this case, it's added to the Spark configuration of the cluster. This requires us to add cluster access controls for privileged and non-privileged users to control their access to the key. Once the UDF is created, we can use it within our view definitions for privileged users to see the decrypted data.

With [dynamic view functions](/azure/databricks/security/access-control/table-acls/object-privileges#dynamic-view-functions), you can create only one view and return the encrypted or decrypted values based on the Databricks group to which they belong.

In the previous example, you would create two dynamic view functions, one for North America and another for Europe, and implement the encryption techniques in this [notebook](https://databricks.com/notebooks/enforcing-column-level-encryption.html).

**North American view**:

```sql
-- Alias the field 'email' to itself (as 'email') to prevent the
-- permission logic from showing up directly in the column name results.
CREATE VIEW vhr_us AS
SELECT
  emp_id,
  CASE WHEN
    is_member('DA-AMERICA-HRMANAGER-R') THEN udfPIIDecrypt(salary, "${spark.fernet}")
    ELSE 0
  END AS salary,
FROM hr_enriched
where region='US'
```

**European view**:

```sql
-- Alias the field 'email' to itself (as 'email') to prevent the
-- permission logic from showing up directly in the column name results.
CREATE VIEW vhr_eu AS
SELECT
  emp_id,
  CASE WHEN
    is_member('DA-EUROPE-HRMANAGER-R') THEN udfPIIDecrypt(salary, "${spark.fernet}")
    ELSE 0
  END AS salary,
FROM hr_enriched
where region='EU'
```

For it to work, you'd enable Azure Databricks [table access control](/azure/databricks/security/access-control/table-acls/object-privileges) in the workspace and apply the following permissions:

- Grant `DA-AMERICA-HRMANAGER-R` and `DA-AMERICA-HRGENERAL-R` Azure AD groups access to the `vhr_us` view.
- Grant `DA-EUROPE-HRMANAGER-R` and `DA-EUROPE-HRGENERAL-R` Azure AD groups access to the `vhr_eu` view.

Since columns are encrypted and can't be decrypted in the **confidential or below** workspace, the **confidential or below** workspaces can still use Azure AD Pass-through Authentication and allow users to explore the lake, based upon their permissions.

Where table access is used, teams that require access are added to the Azure Databricks workspace. Azure Databricks would use service principals to map to Azure Data Lake Storage, but the data would be secured with Azure Databricks table access control.

As new data products are deployed, part of the DevOps process would need to run scripts to set up the table permissions in the Azure Databricks workspace and add the correct Azure AD groups to those permissions.

> [!NOTE]
> Azure Databricks table access control can't be combined Azure AD Pass-through Authentication. Therefore, you could use only one Azure Databricks workspace and use table access control instead.

## Restricted data

Along with implementing options for confidential or restricted data, we also recommend you host highly confidential data in a **dedicated** data landing zone and data management landing zone.

It allows specific requirements like just-in-time access, customer-managed keys for encryption, and inbound or outbound restrictions applied to the landing zone. The guidance has evaluated putting data of this type into the same data landing zone but different storage accounts. However, it can make the solution complicated on the networking layer, for example, with network security groups and others.

The dedicated 'restricted' data management landing zone should connect to catalog the data in the 'restricted' data landing zone. It should restrict who can search for this data in the catalog.

## Next steps

- [Data Access Management](security-provisioning.md)

