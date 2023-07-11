---
title: Provision security for cloud-scale analytics in Azure
description: Learn how to provision security for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 03/18/2022
ms.topic: conceptual
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Provision security for cloud-scale analytics in Azure

This article explains how your organization can implement security provisioning through data access and entitlement management in Azure.

## Manage data access

Organizations can use [authentication](./secure-authentication.md) and [authorization](./secure-analytics-role-based-access-control.md) to control access to their scenario's services. Our best practices section provides guidance for setting up each particular service's security. As an example, the Azure Data Lake best practices section describes [access control and data lake configurations in Azure Data Lake Storage](best-practices/data-lake-access.md).

In previous articles, we've described how to onboard data applications that create your data products. Our focus has been predominantly on using automation as much as possible.

Within the Azure platform, there are two ways to give access to data products:

- Using Azure Purview (data policies)
- Using a custom data marketplace, which grants access through Azure Active Directory Entitlement Management

The Azure Purview method is explained in [dataset provisioning by data owners for Azure Storage](/azure/purview/how-to-policies-data-owner-storage). Note that data owners can also define polices for [resource groups and subscriptions](/azure/purview/how-to-policies-data-owner-resource-group).

This article explains how you can use Azure Active Directory Entitlement Management with a custom data marketplace to give access to data products.

> [!NOTE]
> Every business must define its data governance process in detail for each data product. For example, data with a **public** classification or **internal use only** might be secured by resources, but anything **confidential** or above gets secured using options outlined in [data privacy for cloud-scale analytics in Azure](secure-data-privacy.md). To learn more about classification types, see [requirements for governing Azure data in a modern enterprise](./govern-requirements.md#data-classification).

## Manage Azure AD entitlement

Entitlement management is an [identity governance](/azure/active-directory/governance/identity-governance-overview) feature that enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration. For a recap of entitlement management and its value, see the [What is Azure Active Directory entitlement management?](https://www.youtube.com/watch?v=_Lss6bFrnQ8) video.

This article presumes that you're familiar with Azure AD [entitlement management](/azure/active-directory/governance/entitlement-management-overview) or that you have at least studied the Microsoft documentation and understand the following terminology.

| Term | Description |
|---------|---------|
| Access package | A bundle of resources that a team or project needs, governed by policy. An access package always must be contained in a catalog. Create a new access package for a scenario where users need to request access. |
| Access request | A request to access the resources in an access package. Access requests typically go through an approval workflow. If approved, the requester receives an access package assignment. |
| Assignment | An assignment of an access package to a user. The user is provided with all the resource roles of an access package. Access package assignments typically are set to expire after a certain time. |
| Catalog | A container of related resources and access packages. Catalogs are used for delegation, allowing non-administrators can create their own access packages. Catalog owners can add resources they own to a catalog. |
| Catalog creator | A user who is authorized to create new catalogs. When a non-administrator user who is authorized to be a catalog creator creates a new catalog, they automatically become the owner of that catalog.|
| Connected organization | An external Azure AD directory or domain that you have a relationship with. You can specify users from connected organizations as being allowed to request access. |
| Policy | A set of rules that defines the data access lifecycle. Rules can include how users get access, who can approve users, and how long users have access through an assignment. Policies are linked to access packages. An access package can have more than one policy. An example would be a package having one policy for employees requesting access and a second policy for external users requesting access. |

> [!IMPORTANT]
> Azure AD tenants can currently provision 500 catalogs with 500 access packages. If your organization needs to increase these capacities, contact [Azure Support](https://azure.microsoft.com/support/options/).

## Data access management workflows

Your organization can delegate access governance to your domain data stewards and chief data officers using a custom application with Azure AD entitlement management. This delegation frees data application teams to support themselves without needing to defer to your platform teams. You can set multiple levels of approval and automate your end-to-end onboarding and data access management via [Microsoft Graph REST API](/graph/api/overview) and [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview).

Azure AD entitlement management packages allow you to delegate access to non-administrators (like your data application teams) so they can create access packages. Access packages contain resources that users can request, like access to data products. Your data stewards and other delegated access package managers can define policies containing rules for which users can request access, who can approve their access, and when their approved access expires.

## Create catalogs

If you're implementing a data lakehouse, create a catalog in entitlement management for each data landing zone. Depending on automation and your implementation's size, you can either:

- Call the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) to create a catalog for the domain.
- Create another catalog for each data landing zone via the Entitlement Management portal.

If you're implementing a data mesh, create a catalog in entitlement management for each domain. Depending on automation and your implementation's size, you can either:

- Call the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) to create a catalog for the domain.
- Create another catalog for each domain via the Entitlement Management portal.

> [!TIP]
> Each catalog can have its own group permissions for package creation and permissions management.

### Data product creation

Data products are discussed in [Cloud-scale analytics data products in Azure](architectures/data-landing-zone-data-products.md). For custom applications, data onboarding involves an expectation that end-to-end security will be provisioned.

The data onboarding process requires key metadata, including:

- Polyglot storage locations (compute or data lake)
- Approvers (like data stewards or the chief data officer of a domain)
- Lifecycle requirements
- Review requirements
- Domains
- Data product names
- Classifications

:::image type="content" source="images/data-access-management-create-product-security-groups.png" alt-text="Create data product security groups" lightbox="images/data-access-management-create-product-security-groups.png":::
*Figure 1: Data access management data product creation*

Figure 1 illustrates how your data application team can automate the security provisioning for a data product residing in a data lake. A request gets sent to the Microsoft Graph REST APIs after data product onboarding to:

1. Create two security groups via the Azure Active Directory Graph API, one allowing read/write access and another allowing only read access.
    - The following Azure AD group naming conventions are suggested for Azure AD Pass-through Authentication in data lakes:
        - Domain name or data landing zone name
        - Data product name
        - Data lake layer:
          - `RAW` for raw
          - `ENR` for enriched
          - `CUR` for curated
        - Data product name
          - `RW` for read-write
          - `R` for read-only
    - The following Azure AD group naming conventions are suggested for table access control:
        - Domain name or data landing zone name
        - Data product name
        - Schema or table tame
          - `RW` for read-write
          - `R` for read-only

2. Assign your security groups to the data product. For data lakes, this involves applying your two security groups at the data product folder level and at the correct lake layer (raw, enriched or curated).

3. Create an access package that bundles your security groups together along with the required approvers and lifecycle (access reviews and expiry).

> [!TIP]
> In complex scenarios, you can create a permission collection security group to capture multiple security groups, but this would be a manual task AFTER you've already created your data product security groups.

### Request data product access

You can automate the granting of data product access using a custom application and the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview).

:::image type="content" source="images/data-access-management-request-access.png" alt-text="Request access to a data product" lightbox="images/data-access-management-request-access.png":::
*Figure 2: Request access to a data product.*

Figure 2 provides an overview of a data product access request workflow.

#### User access request

1. A data user browses the data marketplace to discover the products they want access to.
2. The data marketplace interfaces with the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) and requests access to the data product for the user.
3. Subject to policy and account, approvers are notified and review the access request in their access management portal. If the request is approved, the user is notified and given access to the dataset.
4. If your organization wants to grant user permissions based on metadata (such as a user's division, title, or location), you can add [dynamic groups in Azure AD](/azure/active-directory/enterprise-users/groups-create-rule) as an approved group.

#### User request status

Other services included in the data marketplace can check on the current status of data product access requests. These services can interface with the [Entitlement Management REST APIs](/graph/api/resources/entitlementmanagement-overview) to list all outstanding requests for a user or service principle name.

## Summary of data access management

Data access management in Azure is divided into the following tiers:

- The physical layer (such as the polyglot storing your dataset)
- Azure Active Directory security groups
- Access packages
- Users and teams who access datasets

:::image type="content" source="./images/granting-access.png" alt-text="Example of using Azure Active Directory Entitlement Management." lightbox="./images/granting-access.png":::

The diagram above provides an example data mesh implementation where one catalog has been created for each domain. Data product teams onboard the new dataset or product to a data domain. An Azure AD group is created and assigned to the dataset. You can grant access with Azure AD Pass-through Authentication or with table access control using Azure Databricks, Azure Synapse Analytics or other analytics polyglot stores.

Azure AD entitlement management creates access packages in the domains access packages catalog. Access packages can contain multiple Azure AD groups. The `Finance Analysis` package gives access to finance and LOB A, while the `Finance Writers` package gives access to schema F and LOB A. Only grant write access to dataset creators. Otherwise, read-only access should be your default.

> [!IMPORTANT]
> The previous diagram illustrates how you add Azure AD user groups. You can use the same process to add Azure service principals, which are used by integration or data product teams for ingestion pipelines and more. You should set up two lifecycle settings: one for users to request short-term access (30 days), and another for requesting longer access (90 days).

## Next steps

- [Organize data operations team members for cloud-scale analytics in Azure](./organize.md)
- [Deploy Azure Active Directory entitlement management](https://www.youtube.com/watch?feature=youtu.be&v=zaaKvaaYwI4) (video)
- Explore [common scenarios in Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-scenarios) for more information about how to manage entitlement.
