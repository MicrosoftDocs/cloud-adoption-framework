---
title: Enterprise Scale Analytics and AI Data Handling
description: Enterprise Scale Analytics and AI Architecture Data Handling.
author: mboswell
ms.author: mboswell # Microsoft employees only
ms.date: 12/8/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Privacy

The Enterprise Scale Analytic and AI solution pattern addresses PII (Personally Identifiable information), at multiple layers, whilst leaving it to the business to decide upon the best pattern which suits its requirements. Personally Identifiable information (PII), is any data that can be used used to identify a individuals such as names, driver's license number, SSNs, bank account numbers, passport numbers, email addresses and more. Many regulations from GDPR to HIPPA require strict protection of user privacy.

Starting before Domains ingest data into the solution pattern they must be able to classify if the data is non-sensitive or sensitive.

* We can think of non-sensitive under the context of if we give access to a user, to the data asset in the Enriched or Curated, we are happy for them to see all the rows and columns.
* We can think of sensitive under the context that we wish restrict columns and rows which can be seen by different users in the data asset.

## Non-Sensitive Data

For every domain which is on-boarded we create two data lake containers for each data lake account (Non-Sensitive and Sensitive) and enable Azure AD Pass-through with ACLs. If a domain onboards a data asset which is non-sensitive then Users Principal Names(UPNs) and Service Principal objects can be added to two Azure AD Groups (one for read/write and the other for read-only). There two Azure AD groups are created as part of the onboarding process and assigned to the data asset folder the domains non-sensitive containers for RAW, Enriched and Curated.

In this pattern, it would enable any compute product which supported Azure AD Passthrough, to connect to the data lake, authenticate with the user logged in and if the user was part of the data asset Azure AD Group access the data via Azure AD Passthrough. This would allow those inside the group to read all of the data asset without any policy filtering.

>[!NOTE]
>Compute products can be classified as Azure Databricks and/or Synapse Analytics Spark and SQL On-Demand enabled with Azure AD Pass-through.

## Sensitive Data

For sensitive data the enterprise would want to restrict, via policy and/or compute, what users could see. In this case we have to consider moving or injecting the access control into the compute layer.

Within the Enterprise Scale Analytics and AI solution pattern there are three options to approach the securing of data.

### Example Scenario

Using the following example we are able to explore options for securing sensitive data.

A domain ingests a Human Resources Personnel data asset for North America and Europe. The use case calls for European users to only see Europe personnel records and North America to see only North America. This is then sub divided that only HR Managers can see columns for salary.

#### Option One - Azure SQL Database, Managed Instance or Azure Synapse Analytics SQL Pools

Using either Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics SQL Pools the domains load the data asset is loaded into a database which supports Row Level, Column Level and Dynamic Data masking. The domains create different Azure AD Groups and assign permissions which align to the sensitivity of data.

In the scenario use case the domain would need to create four Azure AD Groups for read-only.

| Group | Permission|
|--|--|
| DA-AMERICA-HRMANAGER-R | View North America HR Personnel data asset WITH Salary information |
| DA-AMERICA-HRGENERAL-R | View North America HR Personnel data asset WITHOUT Salary information |
| DA-EUROPE-HRMANAGER-R | View Europe HR Personnel data asset WITH Salary information |
| DA-EUROPE-HRGENERAL-R | View Europe HR Personnel data asset WITHOUT Salary information |

The first level of restrictions would be to implement support dynamic data masking. [Dynamic data masking](https://docs.microsoft.com/azure/azure-sql/database/dynamic-data-masking-overview) limits sensitive data exposure by masking it to non-privileged users. One of the advantages of using Dynamic Data Masking is this could be implemented into the onboarding process of a dataset using the [Data Masking Policies - Create Or Update](https://docs.microsoft.com/azure/azure-sql/database/dynamic-data-masking-overview) REST API.

The second level is to [Column-Level Security](https://docs.microsoft.com/azure/synapse-analytics/sql-data-warehouse/column-level-security) to restrict non-HR managers from being able to see salaries and [Row-Level Security](https://docs.microsoft.com/sql/relational-databases/security/row-level-security) to restrict which rows European and North American team members could see.

An additional security layer, on top of Transparent Data Encryption would be to [Encrypt the Column of Data](https://docs.microsoft.com/sql/relational-databases/security/encryption/encrypt-a-column-of-data) and decrypt upon read.

The tables could be made available to Azure Databricks via the [Apache Spark connector: SQL Server & Azure SQL](https://docs.microsoft.com//sql/connect/spark/connector).

#### Option Two - Azure Databricks

Option two us to use Azure Databricks to explore sensitive data using a combination of Fernet encryption libraries, user-defined functions (UDFs), Databricks secrets, Table Access Control and Dynamic View Functions we are able to encrypt and decrypt columns.

As the the blog post, by Databricks, on [Enforcing Column-level Encryption and Avoiding Data Duplication With PII](https://databricks.com/blog/2020/11/20/enforcing-column-level-encryption-and-avoiding-data-duplication-with-pii.html) describes:

*The first step in this process is to protect the data by encrypting it during ingestion and one possible solution is the Fernet Python library. Fernet uses symmetric encryption, which is built with several standard cryptographic primitives. This library is used within an encryption UDF that will enable us to encrypt any given column in a dataframe. To store the encryption key, we use Databricks Secrets with access controls in place to only allow our data ingestion process to access it. Once the data is written to our Delta Lake tables, PII columns holding values such as social security number, phone number, credit card number, and other identifiers will be impossible for an unauthorized user to read.*

*Once we have the sensitive data written and protected, we need a way for privileged users to read the sensitive data. The first thing that needs to be done is to create a permanent UDF to add to the Hive instance running on Databricks. In order for a UDF to be permanent, it must be written in Scala. Fortunately, Fernet also has a Scala implementation that we can leverage for our decrypted reads. This UDF also accesses the same secret we used in the encrypted write to perform the decryption, and, in this case, it is added to the Spark configuration of the cluster. This requires us to add cluster access controls for privileged and non-privileged users to control their access to the key. Once the UDF is created, we can use it within our view definitions for privileged users to see the decrypted data.*

Using [Dynamic view functions](https://docs.microsoft.com/azure/databricks/security/access-control/table-acls/object-privileges#dynamic-view-functions) we are able to create only one view and easily return either the encrypted or decrypted values based on the Databricks group they are a member of.

In our example above we would create a two Dynamic view functions, one for North America and another for Europe, and implementing the encryption techniques in this [notebook](https://databricks.com/notebooks/enforcing-column-level-encryption.html).

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

##### European America View

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

You would enable Azure Databricks [Table Access Control](https://docs.microsoft.com//azure/databricks/security/access-control/table-acls/object-privileges) in the **Azure Databricks Sensitive Workspace** and apply the following permissions:

* Grant DA-AMERICA-HRMANAGER-R and DA-AMERICA-HRGENERAL-R Azure AD Groups access to the vhr_us view.
* Grant DA-EUROPE-HRMANAGER-R and DA-EUROPE-HRGENERAL-R Azure AD Groups access to the vhr_eu view.

As the columns are encrypted and cannot be decrypted in the non-sensitive workspace, the non-sensitive workspaces could still make use of Azure AD Passthrough and allow users to explore the lake based upon there permissions.

Where table access is used teams, requiring access, would be added to the Azure Databricks Sensitive workspace. Azure Databricks would map to Azure Data Lake Storage via service principals but the data would be secured with Databricks Table Access Control.

As new datasets are deployed, part of the DevOps process the Domain would need to run scripts to setup the table permissions, in the **Azure Databricks Sensitive Workspace**, and add the correct Azure AD Groups to those permissions.

>[!NOTE]
>Azure Databricks table access control cannot be mixed with Azure AD Passthrough. Therefore, you could decide to only have one Azure Databricks workspace, and use table access control, as you want to have access to all your data and not only your sensitive data from the **Azure Databricks Sensitive Workspace**.

#### Option 3 - Policy Engine

Whilst option 1 and 2 provide a way to handle sensitive data they place a lot of control into the Domain and Data Products team to identify and restrict access.

For a small scale analytics platform this might just be enough but for a large enterprise where we are looking at hundred of datasets then it recommend that a policy engine be placed in the Data Management Subscription.

A policy engine will allows a central way of managing, securing, and controlling:

* Data access
* Data lifecycle management
* Enforcing both internal and external policies and regulations (e.g., GDPR)
* Data sharing policies
* Identification of sensitive data
* Protection and compliance insights
* GDPR reporting policy

Typically, a policy engine would integrate with a Data Catalogue such as Azure Purview. Microsoft has a number of vendors with solutions in our marketplace.

Some of vendors work with both Azure Synapse and Azure Databricks to encrypt/decrypt information alongside providing Row and Column Level Security. Vendors to consider are [Immuta](https://www.immuta.com/integrations/azure-synapse/), [Privacera](https://privacera.com/) and [Okera](https://www.okera.com/partners/microsoft-gold-partner/).

The Policy Engine should use Azure AD Groups to assign apply the policies to the datasets.

The expectation of any policy solution providing Data Privacy is to tokenize sensitive data and to always check through attribute access control that the user has the ability to de-tokenize the columns they wish to access.

As mentioned, for a policy engine to succeed it is important that there is an integration into the Data Catalogue and an Rest API which can be used by the DevOps process when onboarding a new dataset.

As Domains and Data Products create read data sources, they would be registered in the Data Catalogue which would help identify sensitive data. The policy engine should import this definition and deny any access to this data until the domain has setup it's access policies. All of this should be done via a REST API workflow from the IT Service Management solution.

>[!div class="step-by-step"]s
>[Previous](01-securitymodel.md)
>[Next](03-secprovisioning.md)
