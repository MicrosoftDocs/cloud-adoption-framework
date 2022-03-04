---
title: Provision security for cloud-scale analytics in Azure
description: Learn how to provision security for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data Access Management

Organizations can use [authentication](./secure-authentication.md) and [authorization](./secure-analytics-role-based-access-control.md) to control access to the scenario's services.

The best practice section features guidance about how to set up security for a particular service. For example, the Azure Data Lake best practices section describes for [Access control and data lake configurations in Azure Data Lake Storage](best-practices/data-lake-access.md).

In other sections, we've focused on how to onboard data applications (which create data products). The focus has been predominantly on using automation as much as possible.

There are two ways, within the Azure platform, to approach giving access to data products:

- Using Azure Purview (data policies)

- A custom data marketplace that uses Azure Active Directory Entitlement Management to grant access to data products.

As Azure Purview (data policies) is covered in [Dataset provisioning by data owner for Azure Storage (preview)](/azure/purview/how-to-access-policies-storage). Data owner polices can also be defined on [resource groups and subscriptions](/azure/purview/tutorial-data-owner-policies-resource-group). In this document we'll concentrate on the scenario of using Azure Active Directory Entitlement Management with a custom data marketplace.

> [!NOTE]
> Every business needs to define its data governance process in detail for each data product. For example, data with a **public** classification or **internal use only** might be secured by resources, but anything **confidential** or above is secured using options outlined in [Data privacy for cloud-scale analytics in Azure](secure-data-privacy.md). For  classification types, see [Requirements for governing Azure data in a modern enterprise](./govern-requirements.md#data-governance-classification).

## What is Azure AD entitlement management?

It's an [identity governance](/azure/active-directory/governance/identity-governance-overview) feature that enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration. For a recap of entitlement management and its value, see the  [What is Azure Active Directory entitlement management?](https://www.youtube.com/watch?v=_Lss6bFrnQ8) video.

This article presumes that you're familiar with Azure AD [entitlement management](/azure/active-directory/governance/entitlement-management-overview) or have at least studied the Microsoft documentation and understand the terminology below:

|Term  |Description  |
|---------|---------|
| Access package | A bundle of resources that a team or project needs and is governed with policies. An access package is always contained in a catalog. You would create a new access package for a scenario in which users need to request access.|
| Access request | A request to access the resources in an access package. A request typically goes through an approval workflow. If approved, the requesting user receives an access package assignment.|
| Assignment | An assignment of an access package to a user ensures the user has all the resource roles of that access package. Access package assignments typically have a time limit before they expire. |
| Catalog | A container of related resources and access packages. Catalogs are used for delegation, so that non-administrators can create their own access packages. Catalog owners can add resources they own to a catalog.|
|Catalog creator|A collection of users who are authorized to create new catalogs. When a non-administrator user who is authorized to be a catalog creator creates a new catalog, they automatically become the owner of that catalog.|
|Connected organization|An external Azure AD directory or domain that you have a relationship with. The users from a connected organization can be specified in a policy as being allowed to request access.|
|Policy|A set of rules that defines the access lifecycle, such as how users get access, who can approve, and how long users have access through an assignment. A policy is linked to an access package. For example, an access package could have two policies - one for employees to request access and a second for external users to request access.|

> [!IMPORTANT]
> Tenants can currently provision 500 catalogs with 500 access packages; to increase this number, contact [Azure Support](https://azure.microsoft.com/support/options/).

## Data access management workflows

An organization can use a custom application with Azure AD entitlement management to delegate access governance to the domain data stewards and chief data officers, which frees data application teams to support themselves without deferring to platform teams. It's possible to set multiple levels of approval and to automate the end-to-end onboarding and data access management via [Microsoft Graph REST API](/graph/api/overview) and [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview)

Using Azure AD entitlement management packages allows delegation to non-administrators, such as data application teams, to create access packages. These access packages contain resources, such as access to data products, that users can request, and the delegated access package managers, such as data stewards, can define policies with rules for which users can request, who must approve their access, and when access expires.

## Catalog creation

If you are implementing data lakehouse, then:

- For each data landing zone, it's recommended that you create a catalog in entitlement management. Depending on the size of your implementation, and automation, you can:

  - Approach this as part of your data landing zone creation process and call the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) to create a catalog for the domain.

  - Create an another catalog for the data landing zone via the Entitlement Management portal.

If you are implementing a data mesh, then:

- For each domain, it's recommended that you create a catalog in entitlement management. Depending on the size of your implementation, and automation, you can:

  - Approach this as part of your domain creation process and call the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) to create a catalog for the domain.

  - Create an another catalog for the domain via the Entitlement Management portal.

> [!TIP]
> Each catalogue can have their own group permissions to create packages and manage permissions.

### Data product creation

Data product onboarding has been covered in [Data onboarding](architectures/data-onboarding.md). As part of that onboarding, with a custom application, there's an expectation that the end-to-end security will be provisioned.

The process requires key meta data such as:

- Polyglot storage location (compute or data lake)
- Approvers that is, Data Stewards and Chief Data Officer for domain
- Lifecycle requirements
- Review requirements
- Domain
- Data product name
- Classification

:::image type="content" source="images/data-access-management-create-product-security-groups.png" alt-text="Create data product security groups" lightbox="images/data-access-management-create-product-security-groups.png":::

Figure 1: Data access management data product creation

In figure 1, we illustrate how a data application team automates the security provisioning for a data product that will reside in a data lake. Post the data product onboarding a request is sent to the Microsoft Graph REST APIs to:

1. Create two security groups, one that will allow you to read/write and another which will allow read only, via the Azure Active Directory Graph API.
    1. The following Azure AD group naming conventions are suggested for Azure AD Pass-through Authentication in the data lakes:

        - Domain name or data landing zone name
        - Data product name
        - Data lake layer:
          - `RAW` for raw
          - `ENR` for enriched
          - `CUR` for curated
        - Data product name
          - `RW` for read-write
          - `R` for read-only

    1. The following Azure AD group naming conventions are suggested for table access control:

    - Domain name or data landing zone name
    - Data product name
    - Schema or table tame
      - `RW` for read-write
      - `R` for read-only

1. Assign the security groups to the data product. For a data lake, this would involve applying the two security groups at the data product folder level and at the correct layer of the lake (raw, enriched or curated).

1. An access package is created which bundles the security groups are bundled together along with the required approvers and life-cycle (access reviews and expiry)

> [!TIP]
> In complex scenarios a permission collection security group can be created to capture multiple security groups but this would be a manual task AFTER the data product security groups have been created.

### Request access to data product

Using a custom application and the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) it's possible to automate the granting of access to a data product.

:::image type="content" source="images/data-access-management-request-access.png" alt-text="Request access to a data product" lightbox="images/data-access-management-request-access.png":::

Figure 2: Request access to a data product.

Figure 2 gives an overview of a data product access request workflow.

#### User access request

1. A data user browses the data marketplace to discover the products they want access to.
1. The data marketplace interfaces with the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) and requests to add the user to the data product access package.
1. Subject to policy and account, approvers are notified and reviews the request in an access management portal.

    - If approved, the user is notified and given access to the dataset.

1. If the business wants to grant user permissions based on metadata (for example, a user's division, title, or location), then [dynamic groups in Azure AD](/azure/active-directory/enterprise-users/groups-create-rule) could be added as an approved group to the access package.

#### User request status

The other services included in the data marketplace could check on the current status of the users requests to a data produce and this could interface with the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) to list all the outstanding requests for a user or service principle name.

## Summary of data access management with Azure AD entitlement management

Data access management is divided into the following tiers:

- The physical layer (for example, the polyglot storing the dataset)
- Azure Active Directory security groups
- Access packages, a bundle of resources that a team or project needs and is governed by policies
- Users and teams who try to access the dataset by requesting access or joining a dynamic group based on their user metadata.

:::image type="content" source="./images/granting-access.png" alt-text="Example of using Azure Active Directory Entitlement Management." lightbox="./images/granting-access.png":::

The diagram above shows an example of a data mesh implementation where a catalog has been created per domain.

- Data product teams onboard the new dataset or product to a data domain.
- An Azure AD group is created and assigned to the dataset. Access can be granted with Azure AD Pass-through Authentication or table access control in Azure Databricks, Azure Synapse Analytics or other analytics polyglot store.

Azure AD entitlement management creates access packages in the domains access packages catalog. The access packages can contain multiple Azure AD groups. The `Finance Analysis` package gives access to finance and LOB A, while the `Finance Writers` package gives access to schema F and LOB A. Only grant write access to those who are creating the dataset. Otherwise, read-only access should be the default.

> [!IMPORTANT]
> The diagram illustrates adding Azure AD user groups. The same process can help with adding Azure service principals, which are used by integration or data product teams for ingestion pipelines and more. It's recommended that you set up two lifecycle settings, one for users to request short-term access (30 days) and another for requesting longer access periods (90 days).

## Next steps

- [Organize data operations team members for cloud-scale analytics in Azure](./organize.md)
- [How to deploy Azure Active Directory entitlement management](https://www.youtube.com/watch?feature=youtu.be&v=zaaKvaaYwI4) (video)
- Explore [common scenarios in Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-scenarios) for more information about how to manage entitlement.
