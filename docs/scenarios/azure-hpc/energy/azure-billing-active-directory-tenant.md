---
title: Azure billing and Azure Active Directory tenants for energy HPC
description: Learn about Azure billing and Azure Active Directory tenants for energy HPC.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 11/08/2022
---

# Azure billing and Azure Active Directory tenants for energy HPC

Azure landing zones for HPC don't have any specific considerations or recommendations that affect billing offer decisions, enterprise enrollment, or Active Directory tenant decisions.

It could, however, be important to understand any decisions made previously by the cloud platform team so you know about existing [enterprise enrollment or Azure Active Directory tenant decisions](/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-ad-tenant).

You might also want to review the [identity and access management considerations](/azure/cloud-adoption-framework/scenarios/sap/eslz-identity-and-access-management) so you understand how the Azure Active Directory tenant is applied in the design of authentication and authorization solutions. And you might want to evaluate the [resource organization considerations](/azure/cloud-adoption-framework/scenarios/sap/eslz-resource-organization) so you understand how the enrollment might be organized into management groups, subscriptions, and resource groups.

## Next steps

The following articles provide guidance that you might find helpful at various points throughout the cloud adoption process. They can help you succeed in your cloud adoption for energy HPC environments.

- [Compute](./compute.md)
- [Identity and access management](./identity-access-management.md)
- [Management for energy HPC](./management.md)
- [Network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
