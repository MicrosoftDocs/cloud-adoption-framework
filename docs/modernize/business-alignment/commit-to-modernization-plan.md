---
title: Modernization commitment
description: Learn how to balance your modernization effort and modernization impact, to gain commitment to your cloud adoption-related modernization plan.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal, seo-caf-modernize
keywords: effort, impact, balance, modern, cloud modernization, cloud adoption framework
---
<!--This article might have dependencies or require links to future articles related to the modernization disciplines. But no other known links or dependencies are identified at this point.
Primary Deliverable: CAF/Modernize/Commit-to-modernization-plan.md
Effort, Impact, Commitment
Minimum: 1 article		Maximum: 4 articles-->

# Modernization commitment

Commitment to a modernization plan can only occur once you've found a balance between your modernization effort and modernization impact. When you outline the efforts required and their respective impact on your business, it delivers your case for modernization and helps you gain commitment from stakeholders.

Explore the following questions to help you move toward commitment:

- How long will it take to modernize your workloads?
- Do you have the skills to modernize? Do you need a vendor? If so, what does it cost?
- What work needs to be done before modernization?
- Are we committed to move forward?
- How do we prioritize those commitments?
- What comes first, second, and third?

If you haven't analyzed your assets to determine the best way to modernize each asset, do so now with  [Cloud rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization) and then you can [evaluate your modernization options](evaluate-modernization-options.md).

## Modernization effort

This section of the Cloud Adoption Framework teaches readers how to maximize the return from each phase required to modernize. The actions required to migrate workloads generally fall into three phases for each workload:

- **Assess workloads:** Assess each batch of workloads(epics) to evaluate cost, architecture, and deployment tooling.
- **Deploy workloads:** Replicate functionality in the cloud using IaaS, PaaS, cloud-native, or other modernization solutions.
- **Release workloads:** Test, optimize, document, and review. Release by handing off for governance, management, and security.

:::image type="content" source="../../_images/modernize/methodology.png" alt-text="Diagram showing the Cloud Adoption Framework modernization efforts required.":::

Evaluate the efforts that are required for establishing epics, creating user stories and tasks, determining iterations, and aligning your priorities.

|Effort  |Description | Example |
|---------|---------|
|Epics    |Capture business value and overall transformation and record the overall wave of things to modernize, grouped around a common set of modernization behaviors. What do you need to do per workload as you go through modernization to a common foundation set of technology?   | Enabling hybrid work, Faster time to market, Cost-optimizing applications, Application innovation, and Centralizing data. Critical to the epic are setting up the Landing Zone Accelerator and using the Azure Migrate tool, Cost optimizing app, and Well Architected Review.
|User stories     | Capture each workload to track progress toward completion.     |Four workloads could roll up to one epic for application innovation. More user stories for iteration 0, testing modernized workloads, and identifying workloads for post modernization WAF review. |
|Tasks     | Associated with user stories, capture the environmental configurations that are associated with your architecture or other dependencies, workload-specific tasks, and repeatable processes.   |Required to use modernization tools and for any changes that get made by modernization tools affecting applications, infrastructure, and data.  |

## Timeline

Experience and complexity both have significant impact on timelines and migration velocity.

In a standard two-week iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads, such as SAP, might take several two-week iterations to complete all three phases of migration effort for a single workload.

## Assess workloads

Workloads undergo a primary transformation. For each primary transformation, there's iteration zero.

Workloads that have undergone any significant architectural change go back through the [Well Architected Framework review](/azure/architecture/framework/).

Consider how you'd prioritize your workloads, first, second, third, and so on.

:::image type="content" source="../../_images/modernize/existing-datacenters.png" alt-text="Graphic showing an example of existing datacenters.":::

:::image type="content" source="../../_images/modernize/workload-clusters.png" alt-text="Graphic showing an example of workload clusters.":::

Align your motivations with workloads.

:::image type="content" source="../../_images/modernize/align-workload-motivations.png" alt-text="Graphic showing an example of aligning your motivations with workloads.":::

## Modernization disciplines

Align your motivations with the Modernization disciplines.

:::image type="content" source="../../_images/modernize/align-motivations-disciplines.png" alt-text="...":::

### Personnel

There are generally the following three groups from which it's important to get a commitment:

- Business lead
- Technical lead
- Technical team - usually your business leads or an individual person, technical teams, or a group of people, which could include a partner

Make sure they're named, identified, and have agreed to the backlog of commitments. If they're not committed, you'll want a [Well Architected Framework](/azure/architecture/framework/) review and then evaluate afterward to see if you can proceed with modernization.

If you're starting your cloud adoption journey with the Migrate horizon, you might need to run a migration analysis. For more information, see [Assess on-premises workloads for Azure migration](/azure/cloud-adoption-framework/plan/contoso-migration-assessment).

## Commitment

:::image type="content" source="../../_images/modernize/commitment-to-modernization-plan.png" alt-text="Graphic showing modernization plan commitment flow.":::

Stakeholders are committed to move forward with prioritized modernization plan.
