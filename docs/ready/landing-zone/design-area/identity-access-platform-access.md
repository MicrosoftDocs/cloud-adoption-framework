---
title: Azure Identity and Platform Access
description: Understand how to provide access to Azure Resources.
author: anlucen
ms.author: anais.lucena
ms.date: 04/29/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Identity for Azure platform resources

## Platform access - design considerations

- Centralized versus federated resource ownership:

    -- Shared resources or any aspect of the environment that implements or enforces a security boundary, such as the network, must be managed centrally. This requirement is part of many regulatory frameworks. It is a standard practice for any organization that grants or denies access to confidential or critical business resources.

    -- Managing application resources that don't violate security boundaries can be delegated to application teams. Consider delegating other aspects that are required to maintain security and compliance as well. Letting users provision resources within a securely managed environment lets organizations:

    --- Take advantage of the agile nature of the cloud

    --- Prevent the violation of any critical security or governance boundary

    -- Depending on the definition of the centralized or federated resource ownership, custom roles might differ. The custom roles for the centralized resource ownership are limited and might need extra rights depending on the responsibility model. For example, in some organizations a NetOps role might only need to manage and configure global connectivity. But, in other organizations that need a more centralized approach, enrich the NetOps role with more allowed actions, like creating peering between the hub and the spokes.

- As part of the guidelines for best practices enabling MFA, you can used a tool called Azure AD Identity Protection to force users to enroll in MFA from day one with CA policy. Additionally, the MFA is used as part of the self-remediation methods for any flagged risky event. Verify the full benefits base on the licenses in this link: [overview-identity-protection#license-requirements](https://docs.microsoft.com/azure/active-directory/identity-protection/overview-identity-protection).

## Platform access - design recommendations

- Centralizing Identity means having only one location in the cloud and the integration of the Directories services, control access, authentication, and applications. It provides better management from the IT team.

    o For centralized Directories the best practice is to have only one Azure AD tenant.

- Use Azure AD-only groups for Azure control-plane resources and Azure AD Privileged Identity Management when you grant access to resources.

    o Add on-premises groups to the Azure AD-only group if a group management system is already in place.

- By using Azure AD-only groups, you can add both users and groups that are synchronized from on-premises, via Azure AD Connect. You can also add Azure AD-only (also known as cloud only) users and groups to a single Azure AD-only group, including guest users.

- Groups that are synchronized from on-premises can only be managed and updated from the identity source of truth (on-premises Active Directory). These groups can only contain members from the same identity source, which doesn't provide flexibility like Azure AD-only groups do.

- Integrate Azure AD logs with the platform-central [Log Analytics workspace](https://docs.microsoft.com/azure/azure-monitor/logs/data-platform-logs). It allows for a single source of truth around log and monitoring data in Azure, which gives organizations cloud-native options to meet requirements around log collection and retention.

- If any data sovereignty requirements exist, custom user policies can be deployed to enforce them.

- If Identity protection is used as part your Identity solution, please make sure you exclude Break-glass admin account.

### Workload access - design considerations

- Based on your cloud operating model, which teams will require access to workloads within the landing zone?
- What roles or functions will those teams with access carry out? 
- What is the minimum level of privilege they would require to carry out their responsibilities?

> [!div class="nextstepaction"]
> [IaaS](identity-access-landing-zones.md)
