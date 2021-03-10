---
title: "Enterprise-Scale identity and access management for data management"
description: Describe how this enterprise-scale scenario can improve identity and access management of data management
author: xigyenge
ms.author: xigyenge
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for data management Enterprise-Scale Analytics and AI scenario

## Access to the central datasets

Granting access to datasets should be done only on an ACL level of the data lakes. Most of our native services such as Azure Machine Learning, Synapse and Databricks are already supporting this and more services will follow. This also gives a single pane of glass and allows reviewing access rights in a holistic way inside the Azure Graph.

<!--Not adding this as it is not GA yet.
 In addition to managing access using AAD identities using RBACs and ACLs, ADLS Gen2 also supports using SAS tokens and storage keys for managing access to data in your Gen2 account. In order to make sure that every request to Storage Account is authorized through AAD, there is a new feature (currently in preview) of disabling Key based access that permits to disallow requests to the specific storage account in case the requests were authorized with Shared Key. CAE Team is recommending enabling this feature once GA to enforce AAD level access. -->

## Applied ACLs and Groups

The figure above shows how ACLs and Groups can be applied to an Enterprise Scale Analytics and AI deployment:

![Data Access Model](./images/data_security_model.png)

*Figure 1: Data Access Model*

Standard data:

1. Each data asset in Azure Data Lake Store owns a matching AAD Data Asset group.
1. Data asset AAD registration automated via script and restricted to domain-ops.
1. Teams can request access via security group (SG) join request, approved by domain-ops.
1. Once approved teams can access data from storage client (SSO authenticated), Synapse, Databricks etc.

Secure/Sensitive Data:

1. Access to data-asset group is only granted to analytic services (via Managed Identities or Service Principals), as opposed to individual teams.
1. Teams with access to secure data must ensure members are vetted. This can be implemented via dynamic groups.
1. Synapse, like Azure Store, exposes table-asset groups to control access.
    1. Project external tables via PolyBase and control filtering
    1. Data copied into table enabling row and column filtering and masking.
1. Teams given access to Azure Databricks (ADB) via Azure Active Directory Enterprise Application SCIM
    1. ADB table defined to external table, optionally.
    1. ADB ACLs mapped to groups.
