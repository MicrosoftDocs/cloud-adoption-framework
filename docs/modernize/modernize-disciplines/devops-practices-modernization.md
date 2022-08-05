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

# Modernize your cloud operations

Learn how to modernize your operations. Increasing operational efficiency will limit the total cost of ownership of your workloads.
:::image type="content" source="../../_images/modernize/devops/devops-and-tools-512.png" alt-text="image showing a circle with 4 segments":::

## Modernize your mindset

Modernize you mindset by adopting a DevOps approach. Shift your focus to continuously delivering value to your customers.

- *Primary Focus* - Continuously deliver value to customers.
- *Method* - Integrate planning, development, delivery, and operations with DevOps tools.
- *Benefit* - Quickly limits the total cost of ownership for your workloads in the cloud.

## Modernize your tools

Modernize your tools by adopting a DevOps toolset. Five DevOps tools make this possible. Using [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) makes this adoption easy (*see table*).

| Tool | Description | Azure Solution | Alternative
| --- | --- | --- | --- |
| *Repository* | A centralized location to store code and code changes | [Azure Repos](/azure/devops/repos/get-started/what-is-repos) | GitHub
| *Pipeline* | An automated process to validate and push code to a desired environment | [Azure Pipeline](/azure/devops/pipelines/get-started/pipelines-get-started) | Jenkins
| *Boards* | A central dashboard that tracks the progress of work items | [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) | TaskBoard |
| *Artifacts* | A tool to share code and publish packages | [Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts) | Nexus
| *Testing* | A tool to run tests and quality assurance on code | [Azure Test Plans](/azure/devops/test/overview) | Selenium
|

## Streamline DevOps process

 Enhance your DevOps process with additional governance and monitoring tools. Add these tools to your DevOps toolset to streamline your operations.

| Tool | Description | Azure Solution
| --- | --- | --- |
| *Resource deployment template* | A declarative way to orchestrate the deployment of various resource templates and other artifacts. | [Azure Blueprints](https://azure.microsoft.com/services/blueprints/)
|*Automated auditing* | A tool to enforce organizational standards and to assess compliance at-scale.  | [Azure Policy](https://azure.microsoft.com/services/azure-policy/) |
| *Health and performance monitoring* | A tool to monitor the health and performance of your systems and applications | [Azure Monitor](https://www.logicmonitor.com/lp/azure-monitoring) |
|

## Next Steps

>[!div class="nextstepaction"]
> [Learn how to modernize your applications](../../modernize/modernize-disciplines/application-platform-modernization.md)
