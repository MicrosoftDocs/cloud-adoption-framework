---
title: "Azure Enterprise Scale Analytics Analytics and AI Security Provisioning"
description: Enterprise-Scale Analytics and AI Security Provisioning
author: mboswell
ms.author: mboswell
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---


# Security Provisioning

In previous sections we have focused on ingesting different types of data and how we onboard domains and data products. The focus has been predominantly on using automation as much as possible.

The story for self-service access to data relies upon automation, which starts when a new dataset is registered. Even if your organization doesn't yet have an automated ingestion framework, we still recommend that you create a Custom App, IT Service Management Process, or PowerApp to allow Domain teams and Data Product teams to register datasets.

At a minimum, the high level registration process should provide REST APIs to support the following actions:

1. Create the folders inside the Domain's Data Lake Containers
2. Create the required Azure AD Groups for access. Each data asset in Azure Data Lake Store owns two matching Azure Active Directory Groups.
3. Create an Access Package within [Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview)

The final step of creating an access package allows users to request access to the package and is based on features available within Azure AD Identity Governance.

## Granting Access

Onboarding new Data Domain uses cases or Data Products is handled via Azure Active Directory (Azure Active Directory) entitlement management.

:::image type="content" source="./images/granting-access.png" alt-text="Granting Access" lightbox="./images/granting-access.png":::

*Figure 1: Granting Access to Datasets*

As Figure 1 above illustrates:

1. Domain Ops onboard the new dataset to a Data Landing Zone.
2. A Data Asset Security Group (DASG) will be created and assigned to the dataset. A DASG is in fact an Azure Active Directory Group which could have been granted access to the data via AD Passthrough or via Table Access Control in Azure Databricks or Azure Synapse Analytics. The name of the AD Group should follow the recommended convention:

   - Data Landing Zone Name
   - Domain
   - RAW for RAW, ENR for Enriched, CUR for Curated
   - Schema or Table Name
   - RW for Read Write and R for read only

3. Using Azure Active Directory entitlement management, we create Access Packages in the Data Landing Zone Access Packages Catalog. These Access Packages can contain multiple DASGs. In the figure above, the Finance Analysis Package gives access to Finance and LOB A, for example. The Finance Writers Package gives access to Schema F and LOB A.
4. Users request access to use these packages via Self-Service by browsing an access-package catalog or uses a direct link (from docs or the data catalog) to request access.
5. Subject to policy and account, an approver is notified and reviews request via access management portal.
6. If approved, the user will be notified and given access to the dataset.
7. If the enterprise wants to grant permissions to user based on their metadata (*e.g.* division, title, or location), then [Creating or update a dynamic group in Azure Active Directory](/azure/active-directory/enterprise-users/groups-create-rule) could be used and this Dynamic Group could be added as an approved group to the access package.

>[!TIP]
>Although Figure 1 illustrates adding Azure AD User Groups, the same process could be achieved for adding Azure Service Principals which would be used by Data Product teams for ingestion pipelines etc.
>[!IMPORTANT]
>It is recommended that you set up two lifecycle settings. One for users to ask for access for a short time period (30 days) and another for requesting a longer period of access (90 days).

## Configuring Azure AD entitlement management

Enterprise Scale Analytics and AI roles map to the configuration and maintenance of an Azure AD entitlement management solution.

We are able to delegate access governance to access package managers in Azure AD entitlement management so that Data Landing Zone can look after themselves without having to go back to the Platform teams.

:::image type="content" source="./images/user-access-management.png" alt-text="User Access Management" lightbox="./images/user-access-management.png":::


*Figure 2: Configuring Azure AD entitlement management*

Figure 2 brings all of this together on how different personas would work together to control access to data assets.

1. Data Platform Ops would create a catalog for each individual Data Landing Zone, and each can have their own group to create packages and manage permissions.

   >[!IMPORTANT]
   >Currently tenants can provision 500 catalogs with 500 access packages each (this can be increased by contacting Azure support).

2. Domain Ops owns the creation and management of Data Asset Security Groups (DASG). This is mostly handled via automated scripts that manage the creating and updating of security groups.
3. A Data Manager, part of Domain Ops, can curate access packages and define which access and applications are included. The Access Packages are published to their respective catalogs. Access Packages are typically aligned to user profiles (*e.g.* base package for finance users). Access Packages can include expiration policies and access review policies. Special policies also exist for external guest users.
4. Users browse packages in myaccess portal and can request access to these packages themselves. However a manager could also request that the AP-admin (requires assignment-manager role) grant their team access.
5. Upon a request for access, the user must provide justification and submit.
6. The delegated approver or Data Manager in Domain Ops can approve or reject the request.

## Next Steps

- Video: [How to deploy Azure Active Directory entitlement management](https://www.youtube.com/watch?v=zaaKvaaYwI4&feature=youtu.be).
- [Common scenarios in Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-scenarios).
