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

As outlined in both [Authentication](authentication.md) and [Authorization](analytics-role-based-access-control.md) are used to control access to services with the construction set. Specific guidance on setting up security, for a particular service, is contained in the best practice section for each product. For example the best practices section for Azure Data Lakes, gives insight how to think of granting access to datasets.

>[!Note]
>Every business needs to define it's data governance process for the granularity of data access per data integration and data product.\
>\
>For example, data with a classification of *public* or *internal use only* might be secured by sources. Where as anything which is *confidential* or above is secured at dataset (table name) level. See [Data Governance Classification](requirements-for-governing-data-in-a-modern-enterprise.md#data-governance-classification) for classification types.

## Automating Security

In previous sections we have focused on ingesting different types of data and how we onboard data integrations and data products. The focus has been predominantly on using automation as much as possible.

The story for self-service access to data relies upon automation, which starts when a new dataset is registered. Even if your organization doesn't yet have an automated ingestion framework, we still recommend that you create a Custom App, IT Service Management Process, or PowerApp to allow Integration Ops teams and Data Product teams to register datasets.

At a minimum, the high level registration process should provide REST APIs to support the following actions:

1. Create the folders inside the data integrations Data Lake Containers
2. Create the required Azure AD Groups for access. Each data asset in Azure Data Lake Store owns two matching Azure Active Directory Groups.
3. Create an Access Package within [Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview)

The final step of creating an access package allows users to request access to the package and is based on features available within Azure AD Identity Governance.

### Granting Access

Enterprise Scale Analytics and AI construction set has centered around onboarding new Data Integration uses cases or Data Products via Azure Active Directory entitlement management.

Azure Active Directory (Azure AD) entitlement management is an identity governance feature that enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration. For further insights and guidance on configuring this please see [What is Azure AD entitlement management?](/azure/active-directory/governance/entitlement-management-overview).

The decision is based upon seeing scenarios where users receive access to a resource, they may hold on to access longer than is required for business purposes. Moving the entitlement packages allows delegate to non-administrators the ability to create access packages. These access packages contain resources, such as access to datasets, that users can request, and the delegated access package managers can define policies with rules for which users can request, who must approve their access, and when access expires.

This video provides an overview of entitlement management and its value:

>[!VIDEO <https://www.youtube.com/embed/_Lss6bFrnQ8>]

We have to break our data access management into multiple tiers:

- Physical layer such as the polygot which is storing the dataset
- Azure Active Directory Groups (see above note on granularity)
- Access Packages are a bundle of resources that a team or project needs and is governed with policies.
- Users and Teams who wish to gain access to the dataset. Either by explicitly requesting or dynamic group membership based on there user metadata.

:::image type="content" source="./images/granting-access.png" alt-text="Granting Access" lightbox="./images/granting-access.png":::

*Figure 1: Granting Access to Datasets*

As Figure 1 above illustrates:

1. Integration Ops or Data Products onboard the new dataset and/or product to a Data Landing Zone.
2. An Azure Active Directory Group will be created and assigned to the dataset. This could been granted access to the data via AD Passthrough or via Table Access Control in Azure Databricks or Azure Synapse Analytics.

    A suggested naming convention, for the AD Group, in the case of AD passthrough is:

   - Data Landing Zone Name
   - Data Integration
   - RAW for RAW, ENR for Enriched, CUR for Curated
   - Schema or Table Name
   - RW for Read Write and R for read only
  
    A suggested naming convention, for the AD Group, in the case of table access control is:

   - Data Landing Zone Name
   - Data Product
   - CUR for Curated
   - Schema or Table Name
   - RW for Read Write and R for read only

3. Using Azure Active Directory entitlement management, we create Access Packages in the Data Landing Zone Access Packages Catalog. These Access Packages can contain multiple Azure Active Directory Groups. In the figure above, the Finance Analysis Package gives access to Finance and LOB A. Whilst, the Finance Writers Package gives access to Schema F and LOB A. Typically write should only be given to those who are creating the dataset. At all  other times read should be the default.
4. Users request access to use these packages via Self-Service by browsing an access-package catalog or uses a direct link (from docs or the data catalog) to request access.
5. Subject to policy and account, an approver is notified and reviews request via access management portal.
6. If approved, the user will be notified and given access to the dataset.
7. If the enterprise wants to grant permissions to user based on their metadata (*e.g.* division, title, or location), then [Creating or update a dynamic group in Azure Active Directory](/azure/active-directory/enterprise-users/groups-create-rule) could be used and this Dynamic Group could be added as an approved group to the access package.

> [!IMPORTANT]
> Although Figure 1 illustrates adding Azure AD User Groups, the same process could be achieved for adding Azure Service Principals which would be used by Data Product teams for ingestion pipelines etc.\
>\
>It is recommended that you set up two lifecycle settings. One for users to ask for access for a short time period (30 days) and another for requesting a longer period of access (90 days).

## Configuring Azure AD entitlement management

Enterprise Scale Analytics and AI roles map to the configuration and maintenance of an Azure AD entitlement management solution.

We are able to delegate access governance to access package managers in Azure AD entitlement management so that Data Landing Zone can look after themselves without having to go back to the Platform teams.

:::image type="content" source="./images/user-access-management.png" alt-text="User Access Management" lightbox="./images/user-access-management.png":::

*Figure 2: Configuring Azure AD entitlement management*

Figure 2 brings all of this together on how different personas would work together to control access to data assets.

:::image type="content" source="./images/identity-governance-catalogs.png" alt-text="Identity Governance Catalogs" lightbox="./images/identity-governance-catalogs.png":::

1. Data Platform Ops would create a catalog for each individual Data Landing Zone, and each can have their own group to create packages and manage permissions.
1. Integration Ops and Data Product owns the creation and management of Data Asset Security Groups (DASG). This is mostly handled via automated scripts that manage the creating and updating of security groups.
1. A Data Manager, part of Integration Ops or Data Product, can curate access packages and define which access and applications are included. The Access Packages are published to their respective catalogs. Access Packages are typically aligned to user profiles (*e.g.* base package for finance users). Access Packages can include expiration policies and access review policies. Special policies also exist for external guest users.
1. Users browse packages in myaccess portal and can request access to these packages themselves. However a manager could also request that the AP-admin (requires assignment-manager role) grant their team access.
1. Upon a request for access, the user must provide justification and submit.
1. The delegated approver or Data Manager in Integration Ops can approve or reject the request.

>[!IMPORTANT]
>Currently tenants can provision 500 catalogs with 500 access packages each (this can be increased by contacting Azure support).

## Next Steps

- Video: [How to deploy Azure Active Directory entitlement management](https://www.youtube.com/watch?v=zaaKvaaYwI4&feature=youtu.be).
- [Common scenarios in Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-scenarios).
