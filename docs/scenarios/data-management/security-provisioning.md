---
title: Provision security for data management and analytics in Azure
description: Learn how to provision security for the data management and analytics scenario in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data Access Management

Organizations can use [authentication](./secure-authentication.md) and [authorization](./secure-analytics-role-based-access-control.md) to control access to the scenario's services. Each product's best practice section features guidance about how to set up security for a particular service. For example, the Azure Data Lake best practices section describes how to grant access to data products.

> [!NOTE]
> Every business needs to define its data governance process in detail for each data product. For example, data with a **public** classification or **internal use only** might be secured by resources, but anything **confidential** or above is secured using options outlined in [Data privacy for data management and analytics in Azure](secure-data-privacy.md). For more classification types, see [Requirements for governing Azure data in a modern enterprise](./govern-requirements.md#data-governance-classification).

In other sections, we've focused on how to how to onboard data applications (which create data products). The focus has been predominantly on using automation as much as possible.

There are two ways, within the Azure platform, to approach giving access to data products from within Azure Purview (data policies) or a custom data marketplace which uses Azure Active Directory Entitlement Management to grant access to data products. As Azure Purview (data policies) is covered in [Dataset provisioning by data owner for Azure Storage (preview)](/azure/purview/how-to-access-policies-storage), we will concentrate on the scenario of using Azure Active Directory Entitlement Management with a custom data marketplace.

## What is Azure AD entitlement management?

It is an [identity governance](/azure/active-directory/governance/identity-governance-overview) feature that enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration.

This article presumes that you are familiar with Azure AD [entitlement management](/azure/active-directory/governance/entitlement-management-overview) or have at least studied the Microsoft documentation and understand the terminology below:

|Term  |Description  |
|---------|---------|
| Access package | A bundle of resources that a team or project needs and is governed with policies. An access package is always contained in a catalog. You would create a new access package for a scenario in which users need to request access.|
| Access request | A request to access the resources in an access package. A request typically goes through an approval workflow. If approved, the requesting user receives an access package assignment.|
| Assignment | An assignment of an access package to a user ensures the user has all the resource roles of that access package. Access package assignments typically have a time limit before they expire. |
| Catalogue | A container of related resources and access packages. Catalogs are used for delegation, so that non-administrators can create their own access packages. Catalog owners can add resources they own to a catalog.|
|Catalog creator|A collection of users who are authorized to create new catalogs. When a non-administrator user who is authorized to be a catalog creator creates a new catalog, they automatically become the owner of that catalog.|
|Connected organization|An external Azure AD directory or domain that you have a relationship with. The users from a connected organization can be specified in a policy as being allowed to request access.|
|Policy|A set of rules that defines the access lifecycle, such as how users get access, who can approve, and how long users have access through an assignment. A policy is linked to an access package. For example, an access package could have two policies - one for employees to request access and a second for external users to request access.|

## Data access management workflows

The data management and analytics scenario roles map to the configurations and maintenance of an Azure AD entitlement management solution.

An organization can use a custom application with Azure AD entitlement management to delegate access governance to the domain data stewards and chief data officers, which frees data application teams to support themselves without deferring to platform teams. It is possible to set multiple levels of approval and to automate the end-to-end onboarding and data access management via [Microsoft Graph REST API](/graph/api/overview) and [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview)

The decision to use Azure AD entitlement management is based upon seeing scenarios where users receive access to a resource, they might hold on to access longer than is required for business purposes. Moving to entitlement packages allows delegation to non-administrators, such as data application teams, to create access packages. These access packages contain resources, such as access to data products, that users can request, and the delegated access package managers, such as data stewards, can define policies with rules for which users can request, who must approve their access, and when access expires.

## Domain catalogue creation

For each domain, it is recommended that you create a catalogue in entitlement management. Depending on the size of your implementation, and automation, you can:

1. Approach this as part of your domain creation process and call the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) to create a catalogue for the domain.
1. Create an additional catalogue for the domain via the Entitlement Management portal.

## Data Product Creation

Data product onboarding has been covered in [Data onboarding](architectures/data-onboarding.md). As part of that onboarding, with a custom application, there is an expectation that the end-to-end security will be provisioned.

The process requires key meta data such as:

- Polyglot storage location (compute or data lake)
- Approvers i.e. Data Stewards and Chief Data Officer for domain
- Lifecycle requirements
- Review requirements
- Domain
- Data product name
- Classification

:::image type="content" source="images/data-access-management-create-product-security-groups.png" alt-text="Create data product security groups" lightbox="images/data-access-management-create-product-security-groups.png":::

Figure 1: Data access management data product creation

In figure 1, we illustrate how a data application team automates the security provisioning for a data product which will reside in a data lake. Post the data product onboarding a request is sent to the Microsoft Graph REST APIs to:

1. Create two security groups, one which will allow you to read/write and another which will allow read only, via the Azure Active Directory Graph API.
    1. The following Azure AD group naming conventions are suggested for Azure AD Pass-through Authentication in the data lakes:

        - Domain name
        - Data product name
        - Data lake layer:
          - `RAW` for raw
          - `ENR` for enriched
          - `CUR` for curated
        - Data product name
          - `RW` for read-write
          - `R` for read-only

    1. The following Azure AD group naming conventions are suggested for table access control:

    - Domain name
    - Data product name
    - Schema or table tame
      - `RW` for read-write
      - `R` for read-only

1. Assign the security groups to the data product. For a data lake this would involve applying the two security groups at the data product folder level and at the correct layer of the lake (raw, enriched or curated).

1. An access package is created which bundles the the security groups are bundled together along with the required approvers and life-cycle (access reviews and expiry)

>[TIP] In complex scenarios a permission collection security group can be created to capture multiple security groups but this would be a manual task AFTER the data product security groups have been created.






:::image type="content" source="./images/user-access-management.png" alt-text="User access management." lightbox="./images/user-access-management.png":::

*Figure 1: Create Azure AD entitlement management.*

:::image type="content" source="./images/identity-governance-catalogs.png" alt-text="Screen capture of Identity Governance Catalogs." lightbox="./images/identity-governance-catalogs.png":::

Figure 2 summarizes how different personas work together to control access to data assets:

1. Data platform ops creates a catalog for each individual data landing zone, and each can have their own group to create packages and manage permissions.

1. Integration ops and data product create and manage data asset security groups. They use automated scripts that manage how the security groups are created and updated.

1. A data manager part of integration ops or data product can curate access packages and define which access and applications are included. The access packages are published to their corresponding catalogs. Access packages typically correspond to user profiles (for example, a base package for finance users) and can include expiration and access review policies. Special policies also exist for external guest users.

1. Users browse packages in a `MyAccess` portal and can request access to these packages themselves. However, a manager could also request that for an AP-admin (requires assignment-manager role) to grant their team access.

1. Upon a request for access, the user must provide justification and submit.

1. The delegated approver or data manager in integration ops can approve or reject the request.

> [!IMPORTANT]
> Tenants can currently provision 500 catalogs with 500 access packages; to increase this number, contact [Azure Support](https://azure.microsoft.com/support/options/).

## Create Security Groups and Access Packages

The story for self-service access to data relies upon automation, which starts when a new data product is registered. Even if your organization doesn't yet have an automated ingestion framework, we still recommend that you create a custom application, IT service management process, or an application built with Microsoft Power Apps to allow data application teams to register data products.

The high-level registration process should provide REST APIs to at least support:

- Creating folders inside the data integration's or data product's Azure Data Lake containers.
- Creating the required Azure AD groups for access. Each data asset in Azure Data Lake Storage owns two matching Azure AD groups. [Working with groups in Microsoft Graph](/graph/api/resources/groups-overview)
- Creating an access package within [Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview).

The final step of creating an access package allows users to request access to the package and is based on features available within Azure AD identity governance.

### Grant access

The data management and analytics scenario is centered around onboarding new data integration uses cases or data products via Azure Active Directory entitlement management.

Azure Active Directory (Azure AD) entitlement management is an identity governance feature that automates workflows for access requests, access assignments, reviews, and expiration, supporting organizations to manage identity and the access lifecycle at scale. For guidance about configuring access, see an [overview of Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview).

The decision is based upon seeing scenarios where users receive access to a resource, they might hold on to access longer than is required for business purposes. Moving the entitlement packages allows delegate to non-administrators the ability to create access packages. These access packages contain resources, such as access to data products, that users can request, and the delegated access package managers can define policies with rules for which users can request, who must approve their access, and when access expires.

For a recap of entitlement management and its value, see the [What is Azure Active Directory entitlement management?](https://www.youtube.com/watch?v=_Lss6bFrnQ8) video.

Data access management is divided into the following tiers:

- The physical layer (for example, the polyglot storing the dataset)
- Azure AD groups (see the previous note about granularity)
- Access packages, a bundle of resources that a team or project needs and is governed by policies
- Users and teams who try to access the dataset by requesting access or joining a dynamic group based on their user metadata.

:::image type="content" source="./images/granting-access.png" alt-text="Diagram of granting access to data products." lightbox="./images/granting-access.png":::

The diagram shows how:

- Integration ops or data product teams onboard the new dataset or product to a data landing zone.
- An Azure AD group is created and assigned to the dataset. Access can be granted with Azure AD Pass-through Authentication or table access control in Azure Databricks or Azure Synapse Analytics.

The following Azure AD group naming conventions are suggested for Azure AD Pass-through Authentication:

- Data landing zone name
- Data integration
  - `RAW` for raw
  - `ENR` for enriched
  - `CUR` for curated
- Schema or table name
  - `RW` for read-write
  - `R` for read-only

The following Azure AD group naming conventions are suggested for table access control:

- Data landing zone name
- Data product
  - `CUR` for curated
- Schema or table tame
  - `RW` for read-write
  - `R` for read-only

## The Azure AD entitlement process

1. Azure AD entitlement management creates access packages in the data landing zone access packages catalog. The access packages can contain multiple Azure AD groups. The `Finance Analysis` package gives access to finance and LOB A, while the `Finance Writers` package gives access to schema F and LOB A. Only grant write access to those who are creating the dataset. Otherwise, read-only access should be the default.

1. Users browse an access package catalog or request access to the packages from a direct link (a docs link or a data catalog).

1. Subject to policy and account, an approver is notified and reviews the request in an access management portal.

1. If approved, the user is notified and given access to the dataset.

1. If the enterprise wants to grant user permissions based on metadata (for example, a user's division, title, or location), then [dynamic groups in Azure AD](/azure/active-directory/enterprise-users/groups-create-rule) could be added as an approved group to the access package.

> [!IMPORTANT]
> The diagram illustrates adding Azure AD user groups. The same process can help with adding Azure service principals, which are used by integration or data product teams for ingestion pipelines and more. It's recommended that you set up two lifecycle settings, one for users to request short-term access (30 days) and another for requesting longer access periods (90 days).

## Next steps

- [Organize data operations team members for data management and analytics in Azure](./organize.md)
- [How to deploy Azure Active Directory entitlement management](https://www.youtube.com/watch?feature=youtu.be&v=zaaKvaaYwI4) (video)
- Explore [common scenarios in Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-scenarios) for more information about how to manage entitlement.
