---
title: "Enterprise Scale Analytics and AI Data Privacy"
description: Enterprise Scale Analytics and AI Data Privacy
author: xigyenge
ms.author: xigyenge
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Privacy

The Enterprise Scale Analytics and AI solution pattern addresses PII (Personally Identifiable information) at multiple layers, whilst leaving it to the business to decide upon the best pattern to suit its requirements. Personally Identifiable Information (PII), is any data that can be used used to identify individuals, such as names, driver's license numbers, SSNs, bank account numbers, passport numbers, or email addresses. Many regulations from GDPR to HIPPA require strict protection of user privacy.

Before Domains ingest data into the solution pattern, they must be able to classify the data as non-sensitive or sensitive.

* Data may be considered non-sensitive if we give a user access to the data asset in the Enriched or Curated, we are happy for them to see all the rows and columns.
* Data might be deemed sensitive if we wish to restrict the columns and rows that different users can see.

## Non-Sensitive

For every domain which is on-boarded we create two data lake folders for each data lake layer (Non-Sensitive and Sensitive) and enable Azure AD Pass-through with ACLs. If a domain onboards a data asset which is non-sensitive then Users Principal Names(UPNs) and Service Principal objects can be added to two Azure AD Groups (one for read/write and the other for read-only). There two Azure AD groups are created as part of the onboarding process and assigned to the data asset folder the domains non-sensitive containers for RAW, Enriched and Curated.

This pattern enables any compute product which supports Azure AD Passthrough to connect to the data lake, authenticate with the user logged in, and, if the user is part of the data asset's Azure AD Group, access the data via Azure AD Passthrough. This would allow those inside the group to read all of the data asset without any policy filtering. Access can then be audited in detail in the appropriate logs as well as the Microsoft Graph.

>[!NOTE]
>Examples of compute products are Azure Databricks, Synapse Analytics Spark, and Synapse SQL On-Demand pools enabled with Azure AD passthrough.

## Sensitive Data

For sensitive data the enterprise needs to restrict what users could see via policy and/or compute. In this case we have to consider moving or injecting the access control into the compute layer.

Within the Enterprise Scale Analytics and AI solution pattern, there are three options to approach the securing of data.

### Example Scenario

Using the following example, we are able to explore options for securing sensitive data.

A domain ingests a Human Resources Personnel data asset for North America and Europe. The use case calls for European users to see only European personnel records and North American users to see only North American personnel records. This is further restricted such that only HR Managers can see columns containing salary data.

#### Option One - Azure SQL Database, Managed Instance or Azure Synapse Analytics SQL Pools

Using either Azure SQL Database, SQL Managed Instance, or Azure Synapse Analytics SQL Pools, the domains load the data asset into a database which supports Row-Level Security, Column-Level Security, and Dynamic Data Masking. The domains create different Azure AD Groups and assign permissions which align to the sensitivity of data.

In the scenario use case, the domain would need to create four Azure AD Groups for read-only access:

| Group | Permission|
|--|--|
| DA-AMERICA-HRMANAGER-R | View North America HR Personnel data asset WITH Salary information |
| DA-AMERICA-HRGENERAL-R | View North America HR Personnel data asset WITHOUT Salary information |
| DA-EUROPE-HRMANAGER-R | View Europe HR Personnel data asset WITH Salary information |
| DA-EUROPE-HRGENERAL-R | View Europe HR Personnel data asset WITHOUT Salary information |

The first level of restrictions would support dynamic data masking. [Dynamic data masking](/azure/azure-sql/database/dynamic-data-masking-overview) limits sensitive data exposure by masking it to non-privileged users. One of the advantages of using Dynamic Data Masking is this could be implemented into the onboarding process of a dataset using the [Data Masking Policies - Create Or Update](/azure/azure-sql/database/dynamic-data-masking-overview) REST API.

The second level is to add [Column-Level Security](/azure/synapse-analytics/sql-data-warehouse/column-level-security) to restrict non-HR managers from being able to see salaries and [Row-Level Security](https://docs.microsoft.com/sql/relational-databases/security/row-level-security) to restrict which rows European and North American team members could see.

An additional security layer, on top of Transparent Data Encryption, would be to [Encrypt the Column of Data](https://docs.microsoft.com/sql/relational-databases/security/encryption/encrypt-a-column-of-data) and decrypt upon read.

The tables could be made available to Azure Databricks via the [Apache Spark connector: SQL Server & Azure SQL](https://docs.microsoft.com//sql/connect/spark/connector).

#### Option Two - Azure Databricks

Option two is to use Azure Databricks to explore sensitive data. By using a combination of Fernet encryption libraries, user-defined functions (UDFs), Databricks secrets, Table Access Control, and Dynamic View Functions, we are able to encrypt and decrypt columns.

As the the blog post by Databricks on [Enforcing Column-level Encryption and Avoiding Data Duplication With PII](https://databricks.com/blog/2020/11/20/enforcing-column-level-encryption-and-avoiding-data-duplication-with-pii.html) describes:

*The first step in this process is to protect the data by encrypting it during ingestion and one possible solution is the Fernet Python library. Fernet uses symmetric encryption, which is built with several standard cryptographic primitives. This library is used within an encryption UDF that will enable us to encrypt any given column in a dataframe. To store the encryption key, we use Databricks Secrets with access controls in place to only allow our data ingestion process to access it. Once the data is written to our Delta Lake tables, PII columns holding values such as social security number, phone number, credit card number, and other identifiers will be impossible for an unauthorized user to read.*

*Once we have the sensitive data written and protected, we need a way for privileged users to read the sensitive data. The first thing that needs to be done is to create a permanent UDF to add to the Hive instance running on Databricks. In order for a UDF to be permanent, it must be written in Scala. Fortunately, Fernet also has a Scala implementation that we can leverage for our decrypted reads. This UDF also accesses the same secret we used in the encrypted write to perform the decryption, and, in this case, it is added to the Spark configuration of the cluster. This requires us to add cluster access controls for privileged and non-privileged users to control their access to the key. Once the UDF is created, we can use it within our view definitions for privileged users to see the decrypted data.*

Using [Dynamic view functions](/azure/databricks/security/access-control/table-acls/object-privileges#dynamic-view-functions), we are able to create only one view and easily return either the encrypted or decrypted values based on the Databricks group of which they are a member.

In our example above, we would create two Dynamic view functions, one for North America and another for Europe, and implementing the encryption techniques in this [notebook](https://databricks.com/notebooks/enforcing-column-level-encryption.html).

##### North America View

```SQL
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

##### European View

```SQL
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

For this to work you would enable Azure Databricks [Table Access Control](https://docs.microsoft.com//azure/databricks/security/access-control/table-acls/object-privileges) in the Azure Databricks Workspace and apply the following permissions:

* Grant DA-AMERICA-HRMANAGER-R and DA-AMERICA-HRGENERAL-R Azure AD Groups access to the `vhr_us` view.
* Grant DA-EUROPE-HRMANAGER-R and DA-EUROPE-HRGENERAL-R Azure AD Groups access to the `vhr_eu` view.

As the columns are encrypted and cannot be decrypted in the non-sensitive workspace, the non-sensitive workspaces could still make use of Azure AD Passthrough and allow users to explore the lake based upon their permissions.

Where table access is used, teams requiring access would be added to the Azure Databricks Workspace. Azure Databricks would map to Azure Data Lake Storage via service principals, but the data would be secured with Databricks Table Access Control.

As new datasets are deployed, part of the DevOps process would need to run scripts to set up the table permissions in the an Azure Databricks workspace and add the correct Azure AD Groups to those permissions.

>[!NOTE]
>Azure Databricks Table Access Control cannot be mixed with Azure AD Passthrough. Therefore, you could decide to only have one Azure Databricks workspace and use just table access control instead.

#### Option 3 - Policy Engine

Whilst option 1 and 2 provide a way to handle sensitive data, they place a lot of control into the Domain and Data Products team to identify and restrict access.

For a small-scale analytics platform, this might just be enough. However a large enterprise with hundreds of datasets, a policy engine should be placed in the Data Management Landing Zone.

A policy engine will allows a central way of managing, securing, and controlling:

* Data access
* Data lifecycle management
* Enforcing both internal and external policies and regulations (e.g., GDPR)
* Data sharing policies
* Identification of sensitive data
* Protection and compliance insights
* GDPR reporting policy

Typically, a policy engine would integrate with a Data Catalog such as Azure Purview. There are a number of solutions from third-party vendors in the Azure marketplace.

Some of vendors work with both Azure Synapse and Azure Databricks to encrypt and decrypt information while also providing Row- and Column-Level Security.

The Policy Engine should use Azure AD Groups to apply the policies to the datasets.

The expectation of any policy solution providing Data Privacy is to tokenize sensitive data and to always check through attribute access control that the user has the ability to de-tokenize the columns they wish to access.

As mentioned, for a policy engine to succeed it is important that there is an integration into the Data Catalog and a REST API which can be used by the DevOps process when onboarding a new dataset.

As Domains and Data Products create read data sources, they would be registered in the Data Catalog, which would help identify sensitive data. The policy engine should import this definition and deny any access to this data until the domain has set up its access policies. All of this should be done via a REST API workflow from the IT Service Management solution.

## Highly Confidential Data

In addition to the above options being implemented for Highly Confidential Data, also known as restricted, we recommend that Highly Confidential Data is hosted in a dedicated Data Landing Zone. This allows specific requirements such as just in time access, customer managed keys for encryption and putting inbound/outbound restrictions to the landing zone. The Data Management Landing Zone should be able to connect to catalogue the data, in the Data Landing Zone, but should restrict who can search for this data in the catalogue.