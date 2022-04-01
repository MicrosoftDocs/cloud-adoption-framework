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
Dependencies: This article has a few potential dependencies for cross linking​
Review the current TOC under CAF/Adopt/Innovate/Best practices/Empower adoption for other cross linking suggestions.
Primary Deliverable: CAF/modernize/.....devops-practices.md​
Potential additional deliverables:​
CAF/modernize/best-practices/devops-practices (Copy/Move from current location)​
Copy/move links to additional best practices
This deliver should be able to fit into one net new article. However, there might be minor modifications to the existing CI-CD guidance in innovate when moving it over.​
Minimum: 1 article Maximum: 1 new article – up to 2 modified articles – TOC changes
-->

# DevOps practices

In this article, we help you understand how mature your devops practices are today and evaluate things you might want to strengthen as a pre-requisite to Modernization.

## Minimum requirement

- Track your efforts in an iterative backlog management tool.
- Align waves of workloads and modernization work.
- We recommend cross-linking to backlogs for workloads with more mature devops practices.

:::image type="content" source="../../_images/modernize/ideal-state-modernize-through-devops.png" alt-text="Image showing ideal state for modernizing through devops.":::

## Minimum maturity: Execute iteratively

The baseline of devops maturity is best made within the following groups of work:

- **Modernize in waves:** Follow an iterative, workload-based, wave-oriented approach to migration.
- **Use free tools:** Use free first-party migration tools to modernize components of each wave of workloads.
- **Analyze dependencies:** Use dependency mapping and test migration to ensure your modernization cut-overs are predictable and successful.

The following image illustrates that as modernization processes mature, you can improve devops practices in repeat waves of modernization.

:::image type="content" source="../../_images/modernize/improve-devops-practices-incrementally.png" alt-text="Chart showing how to improve devops practices incrementally.":::

## Alignment with the Modernize methodology

You can accelerate this type of digital invention through the following levels of maturity. Technical guidance to accelerate digital modernization is listed in the table of contents on the left side of this page. Those articles are grouped by maturity model level.

- **Shared solution:** Establish a centralized repository for all aspects of the solution.
- **Feedback loops:** Ensure feedback loops can be managed consistently throughout iterations.
- **Continuous integration:** Regularly build and consolidate a continuous integration and continuous deployment (CI/CD) solution.
- **Reliable testing:** Validate solution quality and expected changes to drive ensuring measurements.
- **Solution deployment:** Deploy a solution to allow a team to quickly share changes with customers.
- **Integrated measurement:** Add learning metrics to the feedback loop for clear analysis by the full team.

## Toolchain

For adoption teams that are mature professional development teams with many contributors, the Azure toolchain starts with GitHub and Azure DevOps.

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
