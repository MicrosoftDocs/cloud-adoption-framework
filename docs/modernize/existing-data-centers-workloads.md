---
title: 'Modernization commitment'
description: Learn how to balance your modernization effort and modernization impact, to gain commitment to your cloud adoption-related modernization plan.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/14/2022
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

# Commit to a modernization plan

Commitment to a modernization plan can occur once you've found a balance between your modernization effort and modernization impact. When you outline the efforts required and they're respective impact on your business, it delivers your case for modernization and helps you gain commitment from stakeholders.

The following questions will help you move toward commitment:

- How long will it take to modernize you workloads?
- Do you have the skills to modernize? Do you need a vendor? If so, what does it cost?
- What work needs to be done before modernization?
- Are we committed to move forward?
- How do we prioritize those commitments?
- What comes first, second, and third?

If you haven't evaluated your assets to determine the best way to modernize each asset, do so now: [Cloud rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization).

## Modernization effort

This section of the Cloud Adoption Framework teaches readers how to maximize the return from each phase required to modernize. The actions required to migrate workloads generally fall into three phases for each workload:

- **Assess workloads:** Assess each batch of workloads(epics) to evaluate cost, architecture, and deployment tooling.
- **Deploy workloads:** Replicate functionality in the cloud using IaaS, PaaS, cloud-native, or other modernization solutions.
- **Release workloads:** Test, optimize, document, and review. Release by handing off for governance, management, and security.

:::image type="content" source="../_images/modernize/methodology.png" alt-text="Diagram that shows the Cloud Adoption Framework modernization effort.":::



Evaluate the efforts required for establishing epics, creating user stories and tasks, determining iterations, and aligning your priorities.

|Effort  |Description | Example |
|---------|---------|
|Epics    |Capture business value and overall transformation and record the overall wave of things to modernize, grouped around a common set of modernization behaviors. What do you need to do per workload as you go through modernization to a common foundation set of technology?   | Enabling hybrid work, Faster time to market, Cost-optimizing applications, Application innovation, and Centralizing data.
|User stories     | Capture each workload to track progress toward completion.     |4 workloads could roll up to one epic for application innovation. Additional user stories for iteration 0, testing modernized workloads, and identifying workloads for post modernization WAF review. |
|Tasks     | Associated with user stories, capture the environmental configurations associated with your architecture or other dependencies, workload-specific tasks, and repeatable processes.   |Required to use modernization tools and for any changes made by modernization tools affecting applications, infrastructure, and data.  |


Experience and complexity both have significant impact on timelines and migration velocity.

In a standard two-week iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads, such as SAP, might take several two-week iterations to complete all three phases of migration effort for a single workload.

Here's an example of what a plan might look like:

Epic

Critical to the epic - setting up the Landing Zone Accelerator, using the Azure Migrate tool, Cost optimizing app, Well Architected Review.

Test modernized

### Assess workloads

Workloads will undergo a primary transformation.
For each primary transformation, there's iteration zero.

Iteration zero - environment
Workloads

Workloads that have undergone any significant architectural change will go back through the [Well Architected Framework review](/azure/architecture/framework/).

Consider how you'd prioritize your workloads, first, second, third, and so on.

:::image type="content" source="../_images/modernize/existing-datacenters.png" alt-text="...":::

:::image type="content" source="../_images/modernize/workload-clusters.png" alt-text="...":::

Align workload motivations with workloads.

:::image type="content" source="../_images/modernize/align-workload-motivations.png" alt-text="...":::

Align your motivations with the Modernization disciplines.

:::image type="content" source="../_images/modernize/align-motivations-desciplines.png" alt-text="...":::

### Assess workload deployments

### Assess workload releases

### Personnel

There are generally the following three groups from which it's important to get a commitment:

- Business lead
- Technical lead
- Technical team - usually your business leads or an individual person, technical teams, or a group of people, which could include a partner

Make sure they're named, identified, and have agreed to the backlog of commitments. If not committed, you'll want a [Well Architected Framework](/azure/architecture/framework/) review and then evaluate afterward to see if you can proceed with modernization.



If you're starting your cloud adoption journey with the Migrate horizon, you might need to run a migration analysis. For more information, see [Assess on-premises workloads for Azure migration](/azure/cloud-adoption-framework/plan/contoso-migration-assessment).

## Modernization commitment

:::image type="content" source="../_images/modernize/commitment-to-modernization-plan.png" alt-text="Graphic showing modernization plan commitment flow.":::



WORK IN PROGRESS

You can now use this toolset to execute and use your pl
Stakeholders are committed to move forward with prioritized modernization plan.