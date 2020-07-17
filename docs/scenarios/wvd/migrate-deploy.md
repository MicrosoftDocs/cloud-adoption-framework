---
title: "Deploy Windows Virtual Desktop to Azure"
description: Use the Cloud Adoption Framework for Azure to learn Windows Virtual Desktop migration best practices to reduce complexity and standardize the migration process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

<!-- cSpell:ignore NTFS Logix -->

# Windows Virtual Desktop deployment or migration

The guidance in this article assumes that you've [established a plan for Windows Virtual Desktop](./plan.md), [assessed the desktop deployment requirements](./migrate-assess.md), [completed a proof of concept](./proof-of-concept.md), and are now ready to migrate or deploy your Windows Virtual Desktop instances.

## Initial scope

Deployment of WVD follows a similar process to the steps completed in the proof of concept. We will use this initial scope as a baseline to explain the various scope changes required by the output of the assessment.

- [Create a host pool](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace) for pooled desktops using a Windows 10 gallery image from the Azure Marketplace and the sizing from step 1.
- [Create RemoteApp application groups](https://docs.microsoft.com/azure/virtual-desktop/manage-app-groups#create-a-remoteapp-group) for workloads that have already been migrated.
- [Create an FSLogix profile container](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-user-profile) to store user profiles.

Deployment or migration consist of persona migration, application migration, and user profile migration. Depending on the results of the workload assessment, there will likely be changes to each of those migration tasks. This article will help identify ways the scope would change based on the assessment feedback.

## Iterative methodology

Each persona is likely going to require an iteration of the initial scope outlined above, resulting in multiple host pools. Based on the Windows Virtual Desktop assessment, the adoption team should define iterations based on the number of personas and/or users per persona. Breaking the process down into persona-driven iterations will help reduce the change velocity impact on the business and allow the team to focus on proper testing/onboard for each of the persona pools.

## Scope considerations

Each of the following sets of considerations should be included in the design documentation for each persona group to be migrated or deployed. Once the scope considerations are factored into the  [initial scope](#initial-scope) above, the deployment or migration can begin.

### Azure landing zone considerations

Prior to deployment, a landing zone should be created in the Azure region required to support each persona to be deployed. Each assigned landing zone should be evaluated against the [landing zone review requirements](./ready.md).

If the assigned Azure landing zone doesn't meet your requirements, scope should be added for any modifications to be made to the environment.

### Application and desktop considerations

Some personas may have a dependency on legacy solutions, which are not compatible with Windows 10 multi-session. In these cases, some personas may require dedicated desktops. This dependency may not be discovered until deployment and testing. If discovered late in the process, future iterations should be allocated to modernization or migration of the legacy application, to reduce the long-term cost of the desktop experience. Those future iterations should be prioritized and completed based on the overall pricing impact of modernization versus the extra cost associated with dedicated desktops. This should not affect current iterations to avoid pipeline disruptions and realization of business outcomes.

Some applications may require remediation, modernization, or migration to Azure to support the desired end-user experience. Those changes are likely to come after release. Alternatively, when desktop latency can impact business functions, the application changes may create a blocking dependencies for the migration of some personas.

### User profile considerations

The [initial scope](#initial-scope) assumes you're using a [VM-based FSLogix user profile container](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-user-profile).

You can use [Azure NetApp Files to host user profiles](https://docs.microsoft.com/azure/virtual-desktop/create-fslogix-profile-container). It will require a few extra steps in the scope, including:

- **Per NetApp instance:** Configuration of NetApp files, volumes, and Active Directory connections.
- **Per host/persona:** Configure FSLogix on session host virtual machines.
- **Per user:** Assign users to the host session.

You can also use [Azure Files to host user profiles](https://docs.microsoft.com/azure/virtual-desktop/create-file-share), which requires a few extra steps in the scope, including:

- **Per Azure Files instance:** Configure the storage account, disk type, and Active Directory connection ([Azure AD DS is also supported](https://docs.microsoft.com/azure/virtual-desktop/create-profile-container-adds), assign RBAC access for an Active Directory user group and apply NTFS permissions, and get the storage account access key.
- **Per host/persona:** Configure FSLogix on session host virtual machines.
- **Per user:** Assign users to the host session.

The user profiles for some personas or users may also require a data migration effort, which can delay the migration of specific personas until user profiles can be remediated within your local Active Directory or individual user desktops. This could significantly impact the scope outside of the WVD scenario. Once remediated, the initial scope or the above approaches can be resumed.

## Deploy or migrate Windows Virtual Desktop

After all considerations are factored into your production scope for the Windows Virtual Desktop migration or deployment, the process can begin. On an iterative cadence, the adoption team will now deploy host pools, applications, and user profiles. Once completed, the post deployment effort of [testing and onboarding users](./migrate-release.md) can begin.

## Next steps

The next step is to deploy or migrate Windows Virtual Desktop instances. The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey.

- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
