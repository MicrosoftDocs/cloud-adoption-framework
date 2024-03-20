---
title: Remediating assets prior to migration
description: Learn how to remediate any assets that you determine to be incompatible with your chosen cloud provider before migration begins.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/19/2024
ms.topic: conceptual
---

# Remediate assets prior to migration

During the migration assessment process, the team identifies any configurations that might make an asset incompatible with the chosen cloud provider. Remediate is a checkpoint in the migration process, which ensures that any incompatibilities are resolved.

This article discusses a few common remediation tasks for reference and helps decide whether remediation is a wise investment.

## Remediation types

There are two main groups of remediation activities, and you need to plan for both throughout your deployment.

- **Based on the results of the assessment activities**
  - Remediation activities that need to be completed to allow replication and deployment.
  - These are going to come from your workload assessment in the [assess phase](../assess/index.md), and will be needed to make sure that the workload can be properly replicated and staged in the cloud.
  - This is focused primarily on the source servers being migrated.
- **Based on the results of the testing activities**
  - This comes from [testing migration activities](../deploy/migration-test.md) and performing [business testing](../release/business-test.md).
  - They're focused on the configuration of the replicated destination servers, and any assisting services like load balancers, virtual networks, and storage accounts.
  - These remediation tasks are likely be more iterative; it's common to need to test and remediate through several cycles until all test cases pass.

## Tracking remediation activities

Throughout the iteration, you identify remediation tasks for your workloads, either from your assessment or testing. You need to track these tasks as project activities to make sure they're completed.

While small migration waves can use spreadsheets to track items, larger waves with many remediation tasks generate many items. Using tools like [Azure DevOps](/azure/devops/boards/backlogs/manage-bugs) or other tools that let you create and prioritize work items and move through specific phases help you scale out. Even if you don't use Azure DevOps for other efforts, using it to triage remediation issues help you organize your tasks for the migration process.

As you create these tasks, you should make sure to connect them back to the workload that they impact. That way, you can report on what workloads might be delayed by remediation tasks. You can then prioritize the work by the workload priority.

Also, some issues might impact multiple workloads. Generally, these are items with the host or a broad configuration, or something with the landing zone as a whole. These issues should be the first ones prioritized for remediation.

## Common remediation tasks

In any corporate environment, technical debt exists, but it's healthy and expected. Architecture decisions that are suited for an on-premises environment might not be suitable in a cloud platform. In either case, common remediation tasks might be required to prepare assets for migration. The following are a few examples:

- **Minor host upgrades**: Occasionally, an outdated host needs to be upgraded prior to replication.
- **Minor guest OS upgrades**: You'll probably need to patch or upgrade your OS before replication.
- **SLA modifications**: Backup and recovery change significantly in a cloud platform. Assets might need to be modified to their backup processes to ensure continued function in the cloud.
- **Application configuration changes**: Migrated applications might require changes to variables, such as network paths to dependent assets, service account changes, or updates to dependent IP addresses.
- **Minor changes to network paths**: Routing patterns need to be modified to properly route user traffic to the new assets.
  - This isn't production routing to the new assets, but rather configuration to allow for proper routing to the assets in general.

## Large-scale remediation tasks

When a datacenter is properly maintained, patched, and updated, there's likely to be little need for remediation. Remediation-rich environments tend to be common among large enterprises. This might also include organizations under large IT downsizing, legacy managed service and acquisition-rich environments. In each of these types of environments, remediation consumes a large portion of the migration effort. The following remediation tasks might frequently appear, or negatively affect migration speed or consistency. If this happens, break out remediation into a parallel effort and team, similar to cloud adoption and cloud governance.

- **Frequent host upgrades**: When you upgrade many hosts to complete a workload's migration, it can delay the migration team. Break out affected applications and address the remediation steps before you include affected applications in any planned releases.
- **Frequent guest OS upgrade**: Large enterprises commonly have servers running on outdated versions of Linux or Windows. Aside from the apparent security risks of operating an outdated OS, there are also incompatibility issues that prevent affected workloads from being migrated. When many VMs require OS remediation, try breaking out these efforts into a parallel iteration.    Some upgrade can be completed by the migration tooling as part of the migration process, such as the [Windows Server Upgrade](/azure/migrate/how-to-upgrade-windows) feature in Azure Migrate.

## Addressing large-scale remediations

Because remediation for smaller workloads can be straightforward, choose smaller workloads for your initial migration waves. As your migration efforts mature and you begin to tackle larger workloads, remediation can be time consuming and costly. For example, remediation efforts for a Windows Server 2003 migration involving a 5,000+ VM pool of assets can delay a migration by months. When such large-scale remediation is required, you might need to change your plans for migrating the affected workloads.  It might be more efficient and produce more value to engage in modernization activities to maximize the value of the remediation efforts.

You can use the following questions can help guide decisions:

- Have all workloads affected by the remediation been identified and notated in the migration backlog?
- For workloads that aren't affected, will a migration produce a similar return on investment (ROI)?
- Can the affected assets be remediated in alignment with the original migration timeline? What impact would timeline changes have on ROI?
- Is it economically feasible to remediate the assets in parallel with migration efforts?

If the previous questions weren't answered, consider these modernization approaches:

- **Containerization**. Some assets can be hosted in a containerized environment without remediation. This could produce less-than-favorable performance and doesn't resolve security or compliance issues.
- **Automation**. Depending on the workload and remediation requirements, it might be more profitable to script the deployment to new assets using a DevOps approach.
- **Rebuild**. When remediation costs are high and business value is equally high, a workload is a good fit for rebuilding or rearchitecting.

## Next steps

After remediation is complete, [replication activities](./replicate.md) are ready.

> [!div class="nextstepaction"]
> [Replicate assets](./replicate.md)
