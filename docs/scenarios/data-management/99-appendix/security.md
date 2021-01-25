---
# This basic template provides core metadata fields for Markdown articles on docs.microsoft.com.

# Mandatory fields.
title: Enterprise Scale Analytics and AI
description: Enterprise Scale Analytics and AI Architecture represents the strategic design path and target technical state for an Azure Analytics environment. Addressing the challenges of a centralized monolithic data lake this architecture is using a harmonized data mesh.
author:
ms.author: # Microsoft employees only
ms.date: 12/8/2020
ms.topic: conceptual
ms.service: architecture-center
ms.subservice: enterprise-scale-analytics
# Use ms.service for services or ms.prod for on-prem products. Remove the # before the relevant field.
# ms.service: service-name-from-white-list
# ms.prod: product-name-from-white-list

# Optional fields. Don't forget to remove # if you need a field.
# ms.custom: can-be-multiple-comma-separated
# ms.reviewer: MSFT-alias-of-reviewer
# manager: MSFT-alias-of-manager-or-PM-counterpart
---


## Sample data security model using ACLs and Groups

![Data Security Model](../images/data_security_model.png)

The figure above shows how ACLs and Groups can be applied to an Enterprise Scale Analytics and AI deployment.

1. Each data asset in Azure Data Lake Store owns a matching Azure Active Directory Data Asset group.
2. Data asset Azure Active Directory registration automated via script and restricted to Domain-ops.
3. Teams can request access via a security group (SG) join request, approved by Domain-ops.
4. Once approved teams can access data from storage client (SSO authenticated), Azure Synapse Analytics, Databricks, etc.

### Considerations for securing sensitive data

1. Access to data-asset group is only granted to analytic services through Managed Identities or Service Principals as opposed to individual teams.
2. Teams with access to secure data must ensure members are vetted. This can be implemented via dynamic groups.
3. Azure Synapse Analytics, like Azure Data Lake Store, exposes table-asset groups to control access.
4. Project external table via PolyBase and control filtering.
5. Data copied into table enabling row-column filtering and masking.
6. Teams given access to Azure Databricks via Azure Active Directory Enterprise Application SCIM.
7. Azure Databricks table defined to external table, optionally.
8. Azure Databricks ACLs mapped to groups.


Teams with access to secure data must ensure members are vetted and comply with the policies aligned with secure and sensitive data. This could be implemented via dynamic groups.

In **Azure Synapse Analytics**, it is recommended that vetted users are given access to the Synapse workspace where data is exposed via an external table and is secured using Azure Active Directory groups.

In **Azure Databricks**, teams would be added to the Azure Databricks Sensitive workspace. Databricks will map to Azure Data Lake Storage via service principals but the data would be secured with Databricks Table Access Control (See [Azure Databricks Security Considerations](#data-ingestion)).

## Granting Access Overview



>[Previous](02-sensitive.md)
>[Next](../06-dataops/01-overview.md)
