---
title: How to cutover a cloud workload.
description: How to cutover a cloud workload and application.
author: SomilGanguly
ms.author: ssumner
ms.date: 2/3/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# Cutover a cloud workload

Cutover is the workload in the new target region. After this step, the workload can be decommissioned in the source region. It’s a good practice to confirm with stakeholders before cutover. Here’s the high-level process to cut over a cloud workload.

:::image type="content" source="../_images/relocate/caf-relocate-cutover.png" alt-text="Image showing the relocation process and highlights the Cutover step in the Move phase.. In the relocation process, there are two phases and five steps. The first phase is the initiate phase, and it has one step called initiate. The second phase is the Move phase. It has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate-cutover.png" border="false":::
*Figure 1. The Cutover step of relocation.*

**(1) Test and validate migrated services and data.** Test and validate the workload and dependencies to ensure the relocation was successful. Investigate and remediate bugs or issues related to scripts built by the relocation delivery team. We recommend running user acceptance tests. It’s a best practice to assign different users to various parts of the application for UAT. You want to receive confirmation from users that the workload functions before switching the endpoints.

**(2) Switch endpoints.** You should execute the cutover plan from the Select step of the relocation process. Have a failover strategy in place for urgent fixes.

**(3) Validate traffic.** Validate the traffic is routed to the target region, for example, running smoke tests. We recommend you communicate the progress of relocation to users. You should check the workload metrics and logs to confirmation the workload is working properly.

**(4) Fix if necessary.** If something went wrong, you should implement the failover plan (roll-back) or apply an urgent fix to stabilize the deployment.

**(5) Handover workload.** When the process is complete, hand the workload over to the IT operations team.

## Next Step

**Repeat the Move phase for each workload.** If you have more workloads to relocate, return to the [Evaluate step](evaluate.md) and repeat the four steps of the Move phase until you complete the relocation project. Otherwise, you need to formally close the relocation project.

**Make the environment operational.** Make sure you turn on or configure your new environments. We recommend following all Azure Advisor recommendations and configuring items such as backups, security controls, logging, and cost reporting.

**Close project.** After the final cutover, you should close the relocation project. Stakeholders should review and approve. Project closure signals that the relocation team is moving on to other priorities and the operations team should assume full responsibility. Closure should take place two weeks after relocating the final workload. You need time to assess the success of the relocation and create a report for stakeholders to review. Business and technical stakeholders should review the report and approve.

**Improve workloads.** Depending on the state of your workload, you might want to continue with our adopt guidance for modernizing workloads with Azure platform-as-a-service solutions (PaaS) or conduct a well-architected review to determine areas of improvement.

> [!div class="nextstepaction"]
> [Modernize workloads](/azure/cloud-adoption-framework/modernize/)

> [!div class="nextstepaction"]
> [Azure Well-Architected Framework](/azure/architecture/framework/)

> [!div class="nextstepaction"]
> [Azure Well-Architected Review](/assessments/)
