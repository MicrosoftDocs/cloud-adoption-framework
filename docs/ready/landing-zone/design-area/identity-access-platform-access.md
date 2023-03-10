---
title: Azure identity services and platform access
description: Understand how to provide access to Azure Resources.
author: anlucen
ms.author: anlucena
ms.date: 06/27/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, UpdateFrequency.5
---

# Identity for Azure platform resources

Azure identity services, including Azure Active Directory (Azure AD), manage access to resources in the Azure platform. This article describes design considerations for platform access and workflow access. We offer design recommendations for platform access.

## Design consideration for platform access

You need to decide which resources are manged centrally and which are federated.

Shared resources or any aspect of the environment that implements or enforces a security boundary, such as the network, must be managed centrally. This requirement is part of many regulatory frameworks. It's a standard practice for any organization that grants or denies access to confidential or critical business resources.

Managing application resources that don't violate security boundaries can be delegated to application teams. Consider delegating other aspects that are required to maintain security and compliance as well. Letting users provision resources within a securely managed environment lets organizations take advantage of the agile nature of the cloud and prevent violation of any critical security or governance boundary.

Depending on the definition of the centralized or federated resource ownership, custom roles might differ. The custom roles for the centralized resource ownership are limited. Those roles might need extra rights depending on the responsibility model. For example, in some organizations a NetOps role might only need to manage and configure global connectivity. In organizations that need a more centralized approach, you can enrich the NetOps role with more allowed actions. That role might allow creating peering between the hub and the spokes.

As part of the guidelines for best practices enabling multifactor authentication, you can use a tool called [Azure Active Directory (Azure AD) Identity Protection](/azure/active-directory/identity-protection/). This tool can require users to enroll in multifactor authentication from day one with Conditional Access policy. Additionally, the multifactor authentication is used as part of the self-remediation methods for any flagged risky event. For more information, see [License requirements](/azure/active-directory/identity-protection/overview-identity-protection).

## Design recommendations for platform access

A *centralized identity* uses a single location in the cloud and the integration of the Active Directory Service, control access, authentication, and applications. This approach provides better management from the IT team. For centralized Directory services, the best practice is to have only one Azure AD tenant.

When you grant access to resources, use Azure AD-only groups for Azure control-plane resources and Azure AD Privileged Identity Management. Add on-premises groups to the Azure AD-only group if a group management system is already in place. Note that *Azure AD-only* is also known as *cloud only*.


By using Azure AD-only groups, you can add both users and groups that are synchronized from on-premises by using Azure AD Connect. You can also add Azure AD-only users and groups to a single Azure AD-only group, including guest users.

Groups that are synchronized from on-premises can only be managed and updated from the identity source of truth, which is the on-premises Active Directory. These groups can only contain members from the same identity source, which doesn't provide flexibility the way that Azure AD-only groups do.

Integrate Azure AD logs with the platform-central [Log Analytics workspace](/azure/azure-monitor/logs/data-platform-logs). This approach allows for a single source of truth around log and monitoring data in Azure. This source gives organizations cloud-native options to meet requirements for log collection and retention.

Custom user policies can enforce any data sovereignty requirements for the organization.

If identity protection is used as part your identity solution, make sure you exclude the *break-glass* admin account. For more information, see [Manage emergency access accounts in Azure AD](/azure/active-directory/roles/security-emergency-access).

## Design considerations for workload access

For workflow access design, answer the following questions:

- Based on your cloud operating model, which teams require access to workloads within the landing zone?
- What roles or functions do the teams with access carry out?
- What is the minimum level of privilege the teams need to carry out their responsibilities?

## Next steps

> [!div class="nextstepaction"]
> [Landing Zones](identity-access-landing-zones.md)
