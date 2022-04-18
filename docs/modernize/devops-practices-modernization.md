---
title: 'DevOps practices'
description: TODO.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

<!--
Dependencies: cross linking​
Review the current TOC under CAF/Adopt/Innovate/Best practices/Empower adoption for other cross linking suggestions.-->

# DevOps practices for modernization

When you understand how mature your devops practices are today, you can evaluate things you might want to strengthen as a pre-requisite to Modernization.

As devops modernization processes mature, your investment in improving devops practices grows incrementally. This article provides key modernization links to help you get started with each stage of the [DevOps maturity model](/azure/cloud-adoption-framework/innovate/considerations/ci-cd).

## Ideal state: Modernize through devops

1. Identify the components to modernize.
2. Update configuration in your code base to reference the new component.
3. Test the changes.
4. Change the resource type and cloud API in your deployment pipeline.
5. Deploy the modernized solution to the cloud, including configuration for new components.

:::image type="content" source="../_images/modernize/ideal-state-modernize-through-devops.png" alt-text="Image showing ideal state for modernizing through devops.":::

### Minimum requirement

- Track your efforts in an iterative backlog management tool.
- Align waves of workloads and modernization work.
- We recommend cross-linking to backlogs for workloads with more mature devops practices.

The baseline of devops maturity is best made by executing following groups of work iteratively:

- **Modernize in waves:** Follow an iterative, workload-based, wave-oriented approach to migration.
- **Use free tools:** Use free first-party migration tools to modernize components of each wave of workloads.
- **Analyze dependencies:** Use dependency mapping and test migration to ensure your modernization cut-overs are predictable and successful.

The following image illustrates that as modernization processes mature, you can improve devops practices in repeat waves of modernization.

:::image type="content" source="../_images/modernize/improve-devops-practices-incrementally.png" alt-text="Diagram that shows the Cloud Adoption Framework approach to improve devops practices.":::

## Alignment with the Modernize methodology

You can accelerate this type of digital modernization through the following levels of maturity. Technical guidance to accelerate digital modernization is listed in the table of contents on the left side of this page. Those articles are grouped by maturity model level.

- **Shared solution:** Establish a centralized repository for all aspects of the solution.
- **Reliable testing:** Validate solution quality and expected changes to drive ensuring measurements.
- **Solution deployment:** Deploy a solution to allow a team to quickly share changes with customers.
- **Integrated measurement:** Add learning metrics to the feedback loop for clear analysis by the full team.

## Toolchain

For modernization teams that are mature professional development teams with many contributors, the Azure toolchain starts with GitHub and Azure DevOps.

As your need grows, you can expand this foundation to use other tool features. The expanded foundation might involve tools like:

- Azure Blueprints
- Azure Policy
- Azure Resource Manager templates
- Azure Monitor

The table of contents on the left side of this page lists guidance for each tool and aligns with the previously described maturity model.

## Get started

The table of contents on the left side of this page outlines many articles. These articles help you get started with each of the tools in this toolchain.

> [!NOTE]
> Some links might leave the Cloud Adoption Framework to help you go beyond the scope of this framework.
