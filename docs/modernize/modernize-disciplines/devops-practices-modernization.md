---
title: Modernize your process 
description: Understand how to evaluate your opportunities for growth and align with the modernize methodology.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

<!--
Dependencies: cross linking​
Review the current TOC under CAF/Adopt/Innovate/Best practices/Empower adoption for other cross linking suggestions.-->

# Modernize your process

Learn how to modernize your process. Increasing operational efficiency will limit the total cost of ownership of your workloads.
:::image type="content" source="../../_images/modernize/devops/devops-and-tools-512.png" alt-text="image showing a circle with 4 segments":::

Modernize your process with an DevOps approach. DevOps uses an Agile framework to deliver continuous value to customers.

- *Focus* - Focus on continuously deliver value to customers.
- *How* - Integrate planning, development, delivery, and operations with Agile processes and DevOps tools.
- *Benefit* - Quickly limit the total cost of ownership of your workloads in the cloud.

## Modernize your workflow

Modernize your work cadence by adopting an Agile workflow. Take your mapping of modernization motivations and workloads that you created in [step 3 of the Envision phase](../business-alignment/envision-cloud-modernization.md). You need to create structure around the work that needs to get done so you can modernize your workloads.

| Step | Activity | Example |
| --- | --- | --- |
| 1. Create large buckets of work (epics) | Combine your modernization motivation and workload. These are called epics in Agile. | Application innovation for the E-commerce website |
| 2. Identify major tasks (user stories) | Create major tasks from a user or customer perspective. These are called user stories in Agile. | As a shopper, I want a more responsive website so I have better shopping experience |
| 3. Identify smaller tasks within the major tasks (subtasks)| Break down the major tasks into smaller activities. These are called tasks or subtasks in Agile. | <ul> <li>Choose Azure App Service plan</li> <li>Configure security</li>  <li>Configure caching</li> </ul>
| 4. Divide up the work into management pieces (sprints) | Set a two-week time frame and let your team members take on tasks that they can complete over that two week period | <ul> <li>Joy takes "choose Azure App Service plan"</li> <li>Jaye takes "configure security"</li>  <li>Jon takes "configure caching"</li> </ul>|
|

## Modernize your tools

Modernize your tools by adopting a DevOps toolset. Five DevOps tools make this possible. Using [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) makes this adoption easy (*see table*).

| DevOps Tool | Tool Description | Solution | Alternative
| --- | --- | --- | --- |
| *Repository* | A centralized location to store code and code changes | [Azure Repos](/azure/devops/repos/get-started/what-is-repos) | GitHub
| *Pipeline* | An automated process to validate and push code to a desired environment | [Azure Pipeline](/azure/devops/pipelines/get-started/pipelines-get-started) | Jenkins
| *Boards* | A central dashboard that tracks the progress of work items | [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) | TaskBoard |
| *Artifacts* | A tool to share code and publish packages | [Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts) | Nexus
| *Testing* | A tool to run tests and quality assurance on code | [Azure Test Plans](/azure/devops/test/overview) | Selenium
|

## Next Steps

>[!div class="nextstepaction"]
> [Learn how to modernize your applications](../../modernize/modernize-disciplines/application-platform-modernization.md)
