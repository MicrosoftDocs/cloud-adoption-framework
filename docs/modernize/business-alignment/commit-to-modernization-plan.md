---
title: Commit to the cloud modernization
description: Learn how to balance your modernization effort and modernization impact, to gain commitment to your cloud adoption-related modernization plan.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/21/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice:
ms.custom: internal, seo-caf-modernize
keywords: effort, impact, balance, modern, cloud modernization, cloud adoption framework
---
<!--This article might have dependencies or require links to future articles related to the modernization disciplines. But no other known links or dependencies are identified at this point.
Primary Deliverable: CAF/Modernize/Commit-to-modernization-plan.md
Effort, Impact, Commitment
Minimum: 1 article		Maximum: 4 articles-->

# Commit to the cloud modernization

You can commit to a modernization plan once you've found a balance between effort and impact. When you outline the efforts required and their respective impact on your business, it delivers your case for modernization, and helps you gain commitment from stakeholders.

:::image type="content" source="../../_images/modernize/commit/commit.png" alt-text="Image showing where you are in the business alignment process.":::

Explore the following questions to help you move toward commitment:

- How long will it take to modernize your workloads?
- Do you have the skills to modernize? Do you need a vendor? If so, what does it cost?
- What work needs to be done before modernization?
- Are we committed to move forward?
- How do we prioritize those commitments?
- What comes first, second, and third?

If you haven't analyzed your assets to determine the best way to modernize each asset, do so now with  [Cloud rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization).
If you haven't already, we recommend you see [Envision your modernization](envision-cloud-modernization.md) and [Evaluate your options](evaluate-modernization-options.md) before you continue.

## 1. Determine effort

Maximize your return from each of the following three phases required for migrating each workload:

- **Assess workload:** Assess each workload to evaluate cost, architecture, and deployment tooling.
- **Deploy workload:** Replicate functionality in the cloud using IaaS, PaaS, cloud-native, or other modernization solutions.
- **Release workload:** Test, optimize, document, and review. Release by handing off for governance, management, and security.

:::image type="content" source="../../_images/modernize/modernize-methodology-graphic.png" alt-text="Diagram showing the Cloud Adoption Framework modernization efforts required.":::

Remember more of your behind-the-scenes efforts:

- Establish work items and tasks
- Determine iterations
- Align your priorities

## 2. Set a timeline

Experience and complexity both have significant impact on timelines and migration velocity. In a standard two-week iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads, such as [SAP](https://azure.microsoft.com/solutions/sap/azure-solutions/), might take several two-week iterations to complete all three phases of migration effort for a single workload.

## 3. Assess workloads

Assess your workloads in the following steps.

Workloads that have undergone any significant architectural change go back through the [Well Architected Framework review](/azure/architecture/framework/).

1. Begin with an inventory of all your applications, data, and infrastructure.

   :::image type="content" source="../../_images/modernize/existing-datacenters.png" alt-text="Graphic showing an example of existing datacenters.":::

2. Group your apps, data, and infrastructure to form workloads, and then prioritize those workloads.

   :::image type="content" source="../../_images/modernize/workload-clusters.png" alt-text="Graphic showing an example of workload clusters.":::

3. Align your motivations with each workload, so you can create your work items.

   :::image type="content" source="../../_images/modernize/align-workload-motivations.png" alt-text="Graphic showing an example of aligning your motivations with workloads.":::

4. Create your work items.

   The following illustration shows an outline of the efforts required for a modernization plan. The efforts are broken down into epics, user stories, and tasks, using Azure DevOps as an example.

   :::image type="content" source="../../_images/modernize/commitment-to-modernization-plan.png" alt-text="Graphic showing modernization plan commitment flow.":::

## 5. Get commitment

There are generally the following three groups from which it's important to get a commitment:

- Business lead
- Technical lead
- Technical team - usually your business leads or an individual person, technical teams, or a group of people, which could include a partner

Make sure they're named, identified, and have agreed to the backlog of commitments. If they're not committed, you'll want a [Well Architected Framework](/azure/architecture/framework/) review, and then evaluate afterward to see if you can proceed with modernization.

If you're starting your cloud adoption journey with the Migrate horizon, you might need to run a migration analysis. For more information, see [Assess on-premises workloads for Azure migration](/azure/cloud-adoption-framework/plan/contoso-migration-assessment).

## Next steps

> [!div class="nextstepaction"]
> [Learn about application platform modernization](../modernize-disciplines/application-platform-modernization.md)
