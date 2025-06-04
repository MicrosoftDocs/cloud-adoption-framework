---
title: Remediate assets prior to migration
description: Learn how to remediate assets that you determine to be incompatible with your chosen cloud provider prior to migration.
author: Zimmergren
ms.author: pnp
ms.date: 04/05/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Remediate assets prior to migration

During the migration assessment process, the team identifies any configurations that might make an asset incompatible with the chosen cloud provider. Remediation is a checkpoint in the migration process that you can use to resolve any incompatibilities.

This article describes a few common remediation tasks and helps you decide if remediation is a wise investment.

## Remediation types

There are two main types of remediation activities that you need to plan for throughout your deployment.

- **Based on the results of the assessment activities**
  - Remediation activities that need to be completed to allow replication and deployment.
  - You determined these remediation activities in your workload assessment during the assess phase. You must perform these tasks to ensure that you can properly replicate and stage your workload in the cloud.
  - This is focused primarily on the source servers being migrated.
- **Based on the results of the testing activities**
  - This comes from [testing migration activities](../deploy/migration-test.md) and performing [business testing](../release/business-test.md).
  - These remediation activities are focused on the configuration of the replicated destination servers and any assisting services like load balancers, virtual networks, and storage accounts.
  - These tasks are likely more iterative. Testing and remediating through several cycles until all test cases pass is expected.

## Track remediation activities

Throughout the iteration, you can identify remediation tasks for your workloads through assessment or testing. You need to track these tasks as project activities to make sure that they're completed.

While small migration waves can use spreadsheets to track items, larger waves with many remediation tasks generate multiple items. You can use tools like [Azure DevOps](/azure/devops/boards/backlogs/manage-bugs) to create and prioritize work items and move through specific phases to help you scale out. Even if you don't use Azure DevOps for other efforts, you can use it to triage remediation problems and organize tasks for the migration process.

As you create these tasks, you should make sure to connect them back to the workload that they affect. This allows you to assess which workloads might be delayed by remediation tasks. You can then prioritize the work by workload priority.

Some problems might affect multiple workloads. These are generally items with the host, a broad configuration, or problems with the landing zone as a whole. These problems should be the first ones prioritized for remediation.

## Common remediation tasks

Technical debt is a healthy and expected part of the corporate environment. Architecture decisions that are suited for an on-premises environment might not be suitable in a cloud platform. In either case, common remediation tasks might be required to prepare assets for migration. The following are a few examples:

- **Minor host upgrades**: Occasionally an outdated host needs to be upgraded prior to replication.
- **Minor guest operating system upgrades**: You probably need to patch or upgrade your operating system before replication.
- **Service-level agreement (SLA) modifications**: Backup and recovery processes change significantly in a cloud platform. The backup processes for migrated assets might need to be modified to ensure that they continue to achieve their necessary SLAs in the cloud.
- **Application configuration changes**: Migrated applications might require adjustments to variables such as network paths to dependent assets, service account changes, or updates to dependent IP addresses.
- **Minor changes to network paths**: Routing patterns need to be modified to properly route user traffic to the new assets. This isn't production routing to the new assets, but configuration to allow for proper routing to the assets in general.

## Large-scale remediation tasks

There's little need for remediation when a datacenter is properly maintained, patched, and updated. Remediation-rich environments tend to be common within large enterprises. This can include organizations under large IT downsizing, legacy-managed service, and acquisition-rich environments. In each of these environments, remediation comprises a large portion of the migration effort. The following remediation tasks might frequently occur or negatively affect migration speed or consistency. If this happens, separate remediation into a parallel effort and team similar to cloud adoption and cloud governance.

- **Frequent host upgrades**: Upgrading multiple hosts to complete a workload's migration can delay the migration team. Isolate affected applications and address the remediation steps before you include affected applications in any planned releases.
- **Frequent guest operating system upgrade**: Large enterprises commonly have servers running on outdated versions of Linux or Windows. Aside from the security risks of operating an outdated operating system, there are also incompatibility problems that prevent the migration of affected workloads. When multiple virtual machines (VMs) require operating system remediation, try separating these efforts into a parallel iteration. Some upgrades can be completed by the migration tooling as part of the migration process, such as the [Windows Server upgrade](/azure/migrate/how-to-upgrade-windows) feature in Azure Migrate and Modernize.

## Address large-scale remediations

Because remediation for smaller workloads can be straightforward, choose smaller workloads for your initial migration waves. As your migration efforts mature and you begin to tackle larger workloads, remediation can be time consuming and costly. For example, remediation efforts for a Windows Server 2003 migration involving a pool of assets with more than 5,000 VMs can delay a migration by months. When such large-scale remediation is required, you might need to change your plans for migrating the affected workloads. In such instances, modernization activities to maximize the value of remediation efforts might be more efficient and productive.

You can use the following questions to help guide decisions:

- Have all workloads affected by the remediation been identified and notated in the migration backlog?
- For workloads that aren't affected, does a migration produce a similar return on investment (ROI)?
- Can the affected assets be remediated in alignment with the original migration timeline? What effect do timeline changes have on the ROI?
- Is it economically feasible to remediate the assets in parallel with migration efforts?

If the previous questions aren't answered, consider these modernization approaches:

- **Containerization**: Some assets can be hosted in a containerized environment without remediation. This might produce less-than-favorable performance and doesn't resolve security or compliance issues.
- **Automation**: Depending on the workload and remediation requirements, scripting the deployment to new assets using a DevOps approach might be more profitable.
- **Rebuilding**: When remediation costs and business value are equally high, a workload is a good fit for rebuilding or rearchitecting.

## Next step

> [!div class="nextstepaction"]
> [Replicate assets](./replicate.md)