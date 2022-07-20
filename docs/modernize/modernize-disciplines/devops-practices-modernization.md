---
title: DevOps practices
description: Understand how to evaluate your opportunities for growth and align with the modernize methodology.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

<!--
Dependencies: cross linking​
Review the current TOC under CAF/Adopt/Innovate/Best practices/Empower adoption for other cross linking suggestions.-->

# DevOps practices

When you understand how mature your devops practices are today, you can evaluate things that you could strengthen as a pre-requisite to Modernization.

As devops modernization processes mature, your investment in improving devops practices grows incrementally. 

> [!TIP]
> In the cloud, the traditional developer and operations roles have shifted and therefore developers are often expected to own quite a bit more of the operations of a given workload. For more information, see [Compare common cloud operating models](/azure/cloud-adoption-framework/operating-model/compare.md).

## Ideal state: Modernize through devops

1. Identify the components to modernize.
2. Update configuration in your code base to reference the new components.
3. Update your code base to reflect the best practices for running on any new platform components.
4. [Test the changes](testing-architecture-modernization.md).
5. Change the resource type and cloud API in your deployment pipeline.
6. Deploy the modernized solution to the cloud, including configuration for new components.

:::image type="content" source="../../_images/modernize/ideal-state-modernize-through-devops.png" alt-text="Image showing ideal state for modernizing through devops.":::

### Minimum requirement

- *Do you follow agile principles for software development lifecycle?*
- *What DevOps tools are you currently using?*
- Track your efforts in an iterative backlog management tool.
- Align waves of workloads and modernization work.
- We recommend cross-linking to backlogs for workloads with more mature devops practices.

The baseline of devops maturity is best made by executing following groups of work iteratively:

- **Modernize in waves:** Follow an iterative, workload-based, wave-oriented approach to migration.
- **Use free tools:** Use free first-party migration tools to modernize components of each wave of workloads.
- **Analyze dependencies:** Use dependency mapping and test migration to ensure your modernization cut-overs are predictable and successful.

The following image illustrates that as modernization processes mature, you can improve devops practices in repeat waves of modernization.

:::image type="content" source="../../_images/modernize/improve-devops-practices-incrementally.png" alt-text="Diagram that shows the Cloud Adoption Framework approach to improve devops practices.":::

## Alignment with the Modernize methodology

You can accelerate this type of digital modernization through the following levels of maturity. Technical guidance to accelerate digital modernization is listed in the table of contents next to this page. Those articles are grouped by maturity model level.

- **Shared solution:** Establish a centralized repository for all aspects of the solution.
- **Reliable testing:** Validate solution quality and expected changes to drive ensuring measurements. For more information, see [Automated Testing](/azure/architecture/framework/devops/release-engineering-testing).
- **Solution deployment:** Deploy a solution to allow a team to frequently share changes with customers, making it easier to respond to issues since the team's used to the processes. A benefit of regular structured deployments is that deployment activities get rehearsed frequently, making it easier to respond to issues as the team gets used to the deployment processes.
- **Integrated measurement:** Add learning metrics to the feedback loop for clear analysis by the full team. For example, platform metrics give an indication of whether workloads are under- or over-provisioned and application metrics can be shipped to and evaluated at scale in Azure Monitor.  This helps with diagnosing application issues when implemented alongside a strict correlation ID.

## Toolchain

For modernization teams that are mature professional development teams with many contributors, the Azure toolchain starts with [GitHub](https://github.com/) and [Azure DevOps](https://azure.microsoft.com/services/devops/).

As your need grows, you can expand this foundation to use other tool features. The expanded foundation might involve some of the following tools:

- [Azure Blueprints](https://azure.microsoft.com/services/blueprints/) - Simplify large scale deployments by packaging key environment artifacts, such as [Azure Resource Manager templates](/azure/azure-resource-manager/templates/overview), role-based access controls, and policies, in a single blueprint definition.
- [Azure Policy](https://azure.microsoft.com/services/azure-policy/) - Reduce the time needed to audit your environments by having all your compliance data in a single place.
- [Azure Monitor](https://www.logicmonitor.com/lp/azure-monitoring) - Monitor health and performance on the same platform for a unified view across all of your systems and applications.

The table of contents lists guidance for each tool and aligns with the previously described maturity model.

## Get started

The table of contents outlines many articles. These articles help you get started with each of the tools in this toolchain.

> [!NOTE]
> Some links might leave the Cloud Adoption Framework to help you go beyond the scope of this framework.
