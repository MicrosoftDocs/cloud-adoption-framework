---
title: 'Modernization commitment'
description: TODO
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal
---
<!--This article might have dependencies or require links to future articles related to the modernization disciplines. But no other known links or dependencies are identified at this point.
Primary Deliverable: CAF/Modernize/Commit-to-modernization-plan.md
Potential additional deliverables: 
- CAF/Modernize/modernization-effort.md (slide 46)
- CAF/Modernize/modernization-impact.md (slide 47)
- CAF/Modernize/modernization-commitment.md (slide 48)
Minimum: 1 article		Maximum: 4 articles-->

# Commit to a modernization plan

WORK IN PROGRESS

Committing to a modernization plan is about finding a balance between your modernization effort and modernization impact. When you outline the efforts required and they're respective impact on your business, it delivers your case for modernization and helps you gain commitment from stakeholders.

Ask the following questions to help you move toward commitment:

- How long will it take to modernize you workloads?
- Do you have the skills to modernize? Do you need a vendor? If so, what does it cost?
- What work needs to be done before modernization?
- Are we committed to move forward?
- How do we prioritize those commitments?
- What comes first, second, and third?

If you haven't evaluated your assets to determine the best way to modernize each asset, do so now: [Cloud rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization).

## Modernization effort
<!--slide 46-->

This section of the Cloud Adoption Framework teaches readers how to maximize the return from each phase required to modernize. The actions required to migrate workloads generally fall into three phases for each workload:

- **Assess workloads:** Assess each batch of workloads to evaluate cost, architecture, and deployment tooling.
- **Deploy workloads:** Replicate functionality in the cloud using IaaS, PaaS, cloud-native, or other modernization solutions.
- **Release workloads:** Test, optimize, document, and review. Release by handing off for governance, management, and security.

:::image type="content" source="../_images/modernize/methodology.png" alt-text="Diagram that shows the Cloud Adoption Framework modernization effort.":::

In a standard two-week iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads, such as SAP, might take several two-week iterations to complete all three phases of migration effort for a single workload. 

Evaluate the efforts required for establishing epics, creating user stories and tasks, determining iterations, and aligning your priorities.

|Effort  |Description | Example |
|---------|---------|
|Epics    |Capture business value and overall transformation and record the overall wave of things to modernize, grouped around a common set of modernization behaviors. What do you need to do per workload as you go through modernization to a common foundation set of technology?   | Enabling hybrid work, Faster time to market, Cost-optimizing applications, Application innovation, and Centralizing data.
|User stories     | Capture each workload to track your work.     | |
|Tasks     | Capture the environmental configurations associated with your architecture or other dependencies, workload-specific tasks, and repeatable processes.   |Changes made by modernization tools.  |

Experience and complexity both have a significant impact on timelines and migration velocity.

### Assess workloads

Workloads will undergo a primary transformation at iteration 0.

Workloads that have undergone any significant architectural change will go back through the [Well Architected Framework review](/azure/architecture/framework/).

Consider how you'd prioritize your workloads, first, second, third, and so on.

### Assess workload deployments

### Assess workload releases

### Personnel

There are generally the following three groups from which it's important to get a commitment:

- Business lead
- Technical lead
- Technical team - usually your business leads or an individual person, technical teams, or a group of people, which could include a partner

Make sure they're named, identified, and have agreed to the backlog of commitments. If not committed, you'll want a [Well Architected Framework](/azure/architecture/framework/) review and then evaluate afterward to see if you can proceed with modernization.

## Modernization impact
<!--slide 47-->

If you're starting your cloud adoption journey with the Migrate horizon, you might need to run a migration analysis. For more information, see [Assess on-premises workloads for Azure migration](/azure/cloud-adoption-framework/plan/contoso-migration-assessment).


WORK IN PROGRESS

## Modernization commitment
<!--slide 48-->

WORK IN PROGRESS


