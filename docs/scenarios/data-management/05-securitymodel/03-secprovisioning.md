---
title: Enterprise Scale Analytics and AI Security Provisioning
description: Enterprise Scale Analytics and AI Architecture Security Provisioning.
author: mboswell
ms.author: mboswell # Microsoft employees only
ms.date: 02/10/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---
# Security Provisioning

In previous sections we have focussed ingesting different types of data and how we onboard domains/data products. The focussed has been predominantly on using automation as much as possible.

The story for self-service access to data relies upon automation which starts when the a new dataset is registered. Even if your organization doesn't yet have an automated ingested framework we still recommend that you create a Custom App, IT Service Management Process or PowerApp to allow Domain/Data Product teams to register datasets.

The high level registration process, at a minimum, via REST APIs should:

1. Create the folders inside the Domains Data Lake Containers
1. Create the required Azure AD Groups for access. Each data asset in Azure Data Lake Store owns two matching Azure Active Directory Groups.
1. Create an Access Package within [Azure AD entitlement management](https://docs.microsoft.com/azure/active-directory/governance/entitlement-management-overview)

The final step of creating an access package allows users to request access to the package and is based on features available within Azure AD Identity Governance.

## Granting Access

Onboarding new Data Domain uses cases or Data Products is handled via Azure Active Directory (Azure Active Directory) entitlement management.

![Granting Access](../images/granting_access.png)

Figure 1: Granting Access to Datasets

As the figure 1 above illustrates:

1. Domain Ops onboards to a new dataset to a Data Landing Zone. 
1. A Data Asset Security Group (DASG) will be created and assigned to the dataset. A DASG is in fact an Azure Active Directory Group which could have been granted access to the data via AD Passthrough or via Table Access Control in Azure Databricks or Azure Synapse Analytics. The name of the AD Group is recommended to follow:

   - Data Landing Zone Name
   - Domain
   - RAW for RAW, ENR for Enriched, CUR for Curated
   - Schema or Table Name
   - RW for Read Write and R for read only

1. Using Azure Active Directory entitlement management, we create Access Packages in the Data Landing Zone Access Packages Catalogue. These Access Packages can contain multiple DASGs. In the above figure, the Finance Analysis Package gives access to Finance and LOB A, for example. The Finance Writers Package gives access to Schema F and LOB A.
1. Users request access to use these packages via Self-Service by browsing access-package catalogue or uses direct link (from docs or the data catalogue) to request access.
1. Subject to policy and account an approver is notified and reviews request via access management portal.
1. If approved the user will be notified and given access to the dataset.
1. If the enterprise wants to grant permissions to user based on there metadata (i.e. division, title, location)then [Creating or update a dynamic group in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/enterprise-users/groups-create-rule) could be used and this DYnamic Group could be added as an approved group to the access package.

>[!TIP]
>Although Figure 1 illustrates adding Azure AD User Groups, the same process could be achieved for adding Azure Service Principals which would be used by Data Product teams for ingestion pipelines etc.

>[!IMPORTANT]
>It is recommended that you setup two lifecycle settings. One for users to ask for access for a short time period (30 days) and a longer period (90 days)

## Configuring Azure AD entitlement management

Enterprise Scale Analytics and AI roles map to the configuration and maintenance of an Azure AD entitlement management solution.

We are able delegate access governance to access package managers in Azure AD entitlement management so that Data Landing Zone can look after themselves without having to go back to the Platform teams.

![User Access Management](../images/user_access_management.png)

Figure 2: Configuring Azure AD entitlement management

Figure 2 brings all this together on how different personas would work together to control access to data assets.

1. Data Platform Ops would create a catalogue for each individual Data Landing Zone, each can have their own group to create packages and manage permissions.

   >[!IMPORTANT]
   >Currently tenants can provision 500 catalogues with 500 access packages each (this can be increased by contacting Azure support).

1. Domain Ops owns the creation and management of Data Asset Security Groups (DASG). This is mostly handled via automated scripts that manage the creating and updating of security groups.
1. A Data Manager, part of Domain Ops, can curate access packages and define which access and applications are included. The Access Packages are published to their respective catalogue. Access Packages are typically aligned to user profiles, i.e., base package for finance users, etc. Access Packages can include expiration policies and access review policies. Special policies also exist for external guest users.
1. Users browse packages in myaccess portal and can request access to these packages themselves, however a manager could also request that the AP-admin (requires assignment-manager role) grant their team access.
1. Upon a request for access the user must provide justification and submit.
1. The delegated approver or Data Manager in Domain Ops can approve or reject the request.

## Next Steps

- Video: [How to deploy Azure Active Directory entitlement management](https://www.youtube.com/watch?v=zaaKvaaYwI4&feature=youtu.be).
- [Common scenarios in Azure AD entitlement management](https://docs.microsoft.com/azure/active-directory/governance/entitlement-management-scenarios).

## Log Feedback to Enterprise Scale Analytics v-team

[Log Feedback for this page](https://github.com/Azure/enterprise-scale-analytics/issues/new?title=&body=%0A%0A%5BEnter%20feedback%20here%5D%0A%0A%0A---%0A%23%23%23%23%20Document%20Details%0A%0A%E2%9A%A0%20*Do%20not%20edit%20this%20section.%20It%20is%20required%20for%20Solution%20Engineering%20%E2%9E%9F%20GitHub%20issue%20linking.*%0A%0A*%20Content%3A%2005-securitymodel%20%E2%9E%9F%2003-secprovisioning.md)

>[Previous](02-sensitive.md)
>[Next](../06-dataops/01-overview.md)
