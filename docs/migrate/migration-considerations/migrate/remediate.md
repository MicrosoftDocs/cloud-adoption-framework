---
title: Remediating assets prior to migration
description: Learn how to remediate any assets that you determine to be incompatible with your chosen cloud provider before migration begins.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Remediate assets prior to migration

During the migration assessment process, the team identifies any configurations that might make an asset incompatible with the chosen cloud provider. *Remediate* is a checkpoint in the migration process, which ensures that any incompatibilities are resolved. This article discusses a few common remediation tasks for reference, and helps decide whether remediation is a wise investment.

## Common remediation tasks

In any corporate environment, technical debt exists, but it's healthy and expected. Architecture decisions that are suited for an on-premises environment might not be suitable in a cloud platform. In either case, common remediation tasks might be required to prepare assets for migration. The following are a few examples:

- **Minor host upgrades:** Occasionally, an outdated host needs to be upgraded prior to replication.
- **Minor guest OS upgrades:** You'll probably need to patch or upgrade your OS before replication.
- **SLA modifications:** Backup and recovery change significantly in a cloud platform. Assets might need to be modified to their backup processes to ensure continued function in the cloud.
- **PaaS migration:** In some cases, a PaaS deployment of a data structure or application might be required to accelerate deployment. Minor modifications are required to prepare the solution for PaaS deployment.
- **PaaS code changes:** It's not uncommon for custom applications to require minor code modifications to be PaaS ready. Examples could include methods that write to local disk or use of in-memory session state, among others.
- **Application configuration changes:** Migrated applications might require changes to variables, such as network paths to dependent assets, service account changes, or updates to dependent IP addresses.
- **Minor changes to network paths:** Routing patterns need to be modified to properly route user traffic to the new assets.
    > [!NOTE]
    > This isn't production routing to the new assets, but rather configuration to allow for proper routing to the assets in general.

## Large-scale remediation tasks

When a datacenter is properly maintained, patched, and updated, there is likely to be little need for remediation. Remediation-rich environments tend to be common among large enterprises. This might also include organizations under large IT downsizing, legacy managed service and acquisition-rich environments. In each of these types of environments, remediation consumes a large portion of the migration effort. The following remediation tasks might frequently appear, or negatively affect migration speed or consistency. If this happens, break out remediation into a parallel effort and team (similar to cloud adoption and cloud governance).

- **Frequent host upgrades:** When you have to upgrade large numbers of hosts to complete the migration of a workload, it can delay the migration team. Break out affected applications and address the remediation steps before you include affected applications in any planned releases.
- **Frequent guest OS upgrade:** Large enterprises commonly have servers running on outdated versions of Linux or Windows. Aside from the apparent security risks of operating an outdated OS, there are also incompatibility issues that prevent affected workloads from being migrated. When a large number of VMs require OS remediation, try breaking out these efforts into a parallel iteration.
- **Major code changes:** Older custom applications might require significantly more modifications to prepare them for PaaS deployment. When this is the case, try removing them from the migration backlog entirely, managing them in a separate program.

## Decision framework

Because remediation for smaller workloads can be straightforward, choose a smaller workload for your initial migration. As your migration efforts mature and you begin to tackle larger workloads, remediation can be time consuming and costly. For example, remediation efforts for a Windows Server 2003 migration involving a 5,000+ VM pool of assets can delay a migration by months. When such large-scale remediation is required, the following questions can help guide decisions:

- Have all workloads affected by the remediation been identified and notated in the migration backlog?
- For workloads that are not affected, will a migration produce a similar return on investment (ROI)?
- Can the affected assets be remediated in alignment with the original migration timeline? What impact would timeline changes have on ROI?
- Is it economically feasible to remediate the assets in parallel with migration efforts?
- Is there sufficient bandwidth on staff to remediate and migrate? Should a partner be engaged to execute one or both tasks?

If the previous questions were not answered, consider these approaches:

- **Containerization.** Some assets can be hosted in a containerized environment without remediation. This could produce less-than-favorable performance and doesn't resolve security or compliance issues.
- **Automation.** Depending on the workload and remediation requirements, it might be more profitable to script the deployment to new assets using a DevOps approach.
- **Rebuild.** When remediation costs are very high and business value is equally high, a workload is a good fit for rebuilding or rearchitecting.

## Next steps

After remediation is complete, [replication activities](./replicate.md) are ready.

> [!div class="nextstepaction"]
> [Replicate assets](./replicate.md)
