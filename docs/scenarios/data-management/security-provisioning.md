---
title: Understand security provisioning for the data management and analytics scenario in Azure
description: Learn about security provisioning for the data management and analytics scenario in Azure.
author: mboswell
ms.author: mboswell
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand security provisioning for the data management and analytics scenario in Azure

Organizations can use [authentication](./secure-authentication.md) and [authorization](./secure-analytics-role-based-access-control.md) to control access to the scenario's services. Each product's best practice section features guidance about how to set up security for a particular service. For example, the Azure Data Lake best practices section describes how to grant access to datasets.

> [!NOTE]
> Every business needs to define its data governance process in detail for each data integration and data product. For example, data with a **public** classification or **internal use only** might be secured by resources, but anything **confidential** or above is secured at a dataset (table name) level. For more classification types, see [Data governance classification](./govern-requirements.md#data-governance-classification).

## Automate security

In previous sections, we've focused on how to ingest different data types and how to onboard data integrations and data products. The focus has been predominantly on using automation as much as possible.

The story for self-service access to data relies upon automation, which starts when a new dataset is registered. Even if your organization doesn't yet have an automated ingestion framework, we still recommend that you create a custom application, IT Service Management process, or PowerApp to allow integration operations (integration ops) and data product teams to register datasets.

The high-level registration process should provide REST APIs to at least support:

- Creating folders inside the data integration's Azure Data Lake containers.
- Creating the required Azure AD groups for access. Each data asset in Azure Data Lake Storage owns two matching Azure AD groups.
- Creating an access package within [Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview).

The final step of creating an access package allows users to request access to the package and is based on features available within Azure AD identity governance.

### Grant access

The data management and analytics scenario is centered around onboarding new data integration uses cases or data products via Azure Active Directory entitlement management.

Azure Active Directory (Azure AD) entitlement management is an identity governance feature that automates workflows for access requests, access assignments, reviews, and expiration, supporting organizations to manage identity and the access lifecycle at scale. For guidance about configuring access, see an [overview of Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview).

The decision is based upon seeing scenarios where users receive access to a resource, they may hold on to access longer than is required for business purposes. Moving the entitlement packages allows delegate to non-administrators the ability to create access packages. These access packages contain resources, such as access to datasets, that users can request, and the delegated access package managers can define policies with rules for which users can request, who must approve their access, and when access expires.

This video, [What is Azure Active Directory entitlement management?](https://www.youtube.com/watch?v=_Lss6bFrnQ8), recaps entitlement management and its value.

Data access management is divided into the following tiers:

- The physical layer (for example, the polyglot storing the dataset)
- Azure AD groups (see the previous note about granularity)
- Access packages, a bundle of resources that a team or project needs and is governed by policies
- Users and teams who try to access the dataset by requesting access or joining a dynamic group based on their user metadata.

:::image type="content" source="./images/granting-access.png" alt-text="Diagram of granting access to datasets." lightbox="./images/granting-access.png":::

The diagram shows how:

- Integration ops or data product onboard the new dataset or product to a data landing zone.
- An Azure AD group is created and assigned to the dataset. Access can be granted with Azure AD Pass-through Authentication or table access control in Azure Databricks or Azure Synapse Analytics.

The following Azure AD group naming conventions are suggested for Azure AD Pass-through Authentication:

- Data landing zone name
- Data integration
- RAW for RAW, ENR for Enriched, CUR for Curated
- Schema or table name
- RW for read-write and R for read-only
  
The following Azure AD group naming conventions are suggested for table access control:

- Data landing zone name
- Data product
- CUR for Curated
- Schema or table tame
- RW for read-write and R for read-only

## The Azure AD entitlement process

1. Azure AD entitlement management creates access packages in the data landing zone access packages catalog. The access packages can contain multiple Azure AD groups. The Finance Analysis package gives access to finance and LOB Awhile the Finance Writers package gives access to schema F and LOB A. It's recommended to only grant write access to those who are creating the dataset. Read-only should be the default otherwise.

1. Users browse an access package catalog or request access to the packages from a direct link (a docs link or a data catalog).

1. Subject to policy and account, an approver is notified and reviews the request in an access management portal.

1. If approved, the user is notified and given access to the dataset.

1. If the enterprise wants to grant user permissions based on metadata (for example, a user's division, title, or location), then [dynamic groups in Azure AD](/azure/active-directory/enterprise-users/groups-create-rule) could be added as an approved group to the access package.

> [!IMPORTANT]
> The diagram illustrates adding Azure AD user groups. The same process can help with adding Azure service principals, which are used by data product teams for ingestion pipelines and more. It's recommended that you set up two lifecycle settings, one for users to request short-term access (30 days) and another for requesting longer access periods (90 days).

## Configure Azure AD entitlement management

The data management and analytics scenario roles map to the configurations and maintenance of an Azure AD entitlement management solution.

An organization can use Azure AD entitlement management to delegate access governance to access package managers, which frees data landing zone staff to support themselves without deferring to platform teams.

:::image type="content" source="./images/user-access-management.png" alt-text="User access management." lightbox="./images/user-access-management.png":::

*Figure 2: Configuring Azure AD entitlement management.*

:::image type="content" source="./images/identity-governance-catalogs.png" alt-text="Identity Governance Catalogs" lightbox="./images/identity-governance-catalogs.png":::

Figure 2 summarizes how different personas work together to control access to data assets:

1. Data platform ops creates a catalog for each individual data landing zone, and each can have their own group to create packages and manage permissions.

1. Integration ops and data product create and manage data asset security groups. They use automated scripts that manage how the security groups are created and updated.

1. A data manager part of integration ops or data product can curate access packages and define which access and applications are included. The access packages are published to their corresponding catalogs. Access packages typically correspond to user profiles (for example, a base package for finance users) and can include expiration and access review policies. Special policies also exist for external guest users.

1. Users browse packages in a MyAccess portal and can request access to these packages themselves. However, a manager could also request that for an AP-admin (requires assignment-manager role) to grant their team access.

1. Upon a request for access, the user must provide justification and submit.

1. The delegated approver or data manager in integration ops can approve or reject the request.

> [!IMPORTANT]
> Tenants can currently provision 500 catalogs with 500 access packages; to increase this number, contact [Azure Support](https://azure.microsoft.com/support/options/).

## Next steps

- Video: [How to deploy Azure Active Directory entitlement management](https://www.youtube.com/watch?v=zaaKvaaYwI4&feature=youtu.be).
- Explore [common scenarios in Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-scenarios) for more information about how to manage entitlement.
