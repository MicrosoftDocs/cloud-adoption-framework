---
title: Deploy Azure Virtual Desktop
description: Use the Cloud Adoption Framework for Azure to deploy Azure Virtual Desktop using best practices that reduce complexity and standardize the migration process.
author: DominicAllen
ms.author: doalle
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

<!-- cSpell:ignore NTFS Logix -->

# Azure Virtual Desktop deployment or migration

The guidance in this article assumes that you've [established a plan for Azure Virtual Desktop](./plan.md), [assessed the desktop deployment requirements](./migrate-assess.md), [completed a proof of concept](./proof-of-concept.md), and are now ready to migrate or deploy your Azure Virtual Desktop instances.

## Initial scope

The deployment of Azure Virtual Desktop instances follows a process that's similar to the [proof of concept](./proof-of-concept.md) process. Use this initial scope as a baseline to explain the various scope changes that are required by the output of the assessment.

- [Create a host pool](/azure/virtual-desktop/create-host-pools-azure-marketplace) for pooled desktops by using a Windows&nbsp;10 gallery image from Azure Marketplace and the sizing from the first step of that procedure.
- Create desktop or [RemoteApp application groups](/azure/virtual-desktop/manage-app-groups#create-a-remoteapp-group) for workloads that have already been migrated.
- [Create an FSLogix profile container](/azure/virtual-desktop/create-host-pools-user-profile) to store user profiles.

Deployment and migration consist of persona migration, application migration, and user profile migration. Depending on the results of the workload assessment, there will likely be changes to those migration tasks. This article helps identify ways that the scope would change based on the assessment feedback.

## Iterative methodology

Each persona will likely require an iteration of the previously outlined initial scope, resulting in multiple host pools. Depending on the Azure Virtual Desktop assessment, the adoption team should define iterations that are based on the number of personas or users per persona. Breaking the process into persona-driven iterations helps to reduce the change velocity impact on the business and allows the team to focus on proper testing or onboarding of each of the persona pools.

## Scope considerations

Each of the following sets of considerations should be included in the design documentation for each persona group to be migrated or deployed. After the scope considerations are factored in to the previously discussed [initial scope](#initial-scope), the deployment or migration can begin.

### Azure landing zone considerations

Before you deploy the persona groups, a landing zone should be created in the Azure regions required to support each persona to be deployed. Each assigned landing zone should be evaluated against the [landing zone review requirements](./ready.md).

If the assigned Azure landing zone doesn't meet your requirements, scope should be added for any modifications to be made to the environment.

### Application and desktop considerations

Some personas might have a dependency on legacy solutions, which are not compatible with Windows&nbsp;10 Enterprise multi-session. In these cases, some personas might require dedicated desktops. This dependency might not be discovered until deployment and testing.

If they're discovered late in the process, future iterations should be allocated to modernization or migration of the legacy application. This will reduce the long-term cost of the desktop experience. Those future iterations should be prioritized and completed based on the overall pricing impact of modernization versus the extra cost associated with dedicated desktops. To avoid pipeline disruptions and the realization of business outcomes, this prioritization should not affect current iterations.

Some applications might require remediation, modernization, or migration to Azure to support the desired end-user experience. Those changes are likely to come after release. Alternately, when desktop latency can affect business functions, the application changes might create blocking dependencies for the migration of some personas.

### User profile considerations

The [initial scope](#initial-scope) assumes that you're using a [VM-based FSLogix user profile container](/azure/virtual-desktop/create-host-pools-user-profile).

You can use [Azure NetApp Files to host user profiles](/azure/virtual-desktop/create-fslogix-profile-container). Doing so will require a few extra steps in the scope, including:

- **Per NetApp instance:** Configure NetApp files, volumes, and Active Directory connections.
- **Per host/persona:** Configure FSLogix on session host virtual machines.
- **Per user:** Assign users to the host session.

You can also use [Azure Files to host user profiles](/azure/virtual-desktop/create-file-share). Doing so will require a few extra steps in the scope, including:

- **Per Azure Files instance:** Configure the storage account, disk type, and Azure Active Directory connection ([Azure Active Directory Domain Services (AD DS) is also supported](/azure/virtual-desktop/create-profile-container-adds), assign Azure role-based access control access for an Active Directory user group, apply [NTFS permissions on Azure Files](/azure/storage/files/storage-files-identity-ad-ds-configure-permissions), and get the storage account access key.
- **Per host/persona:** Configure FSLogix on session host virtual machines.
- **Per user:** Assign users to the host session.

The user profiles for some personas or users might also require a data migration effort, which can delay the migration of specific personas until user profiles can be remediated within your local Active Directory or individual user desktops. This delay could significantly affect the scope outside of the Azure Virtual Desktop scenario. After they've been remediated, the initial scope and the preceding approaches can be resumed.

## Deploy or migrate Azure Virtual Desktop

After all considerations are factored into your production scope for the Azure Virtual Desktop migration or deployment, the process can begin. On an iterative cadence, the adoption team will now deploy host pools, applications, and user profiles. After this phase is completed, the post deployment effort of [testing and onboarding users](./migrate-release.md) can begin.

## Next steps

[Release your Azure Virtual Desktop deployment to production](./migrate-release.md)
