---
title: Modernize your process 
description: Understand how to evaluate your opportunities for growth and align with the modernize methodology.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

<!--
Dependencies: cross linking​
Review the current TOC under CAF/Adopt/Innovate/Best practices/Empower adoption for other cross linking suggestions.-->

# Modernize your process

Learn how to modernize your process. Modernizing your processes increases operational efficiency. Operational efficiency reduces the total cost of ownership of your workloads.

:::image type="content" source="../../_images/modernize/devops/devops-and-tools-512.png" alt-text="image showing a circle with 4 segments":::

Modernize your process with a DevOps approach. DevOps uses an Agile framework to deliver continuous value to customers. The DevOps approach has a specific focus, approach, and benefits

- *Focus* - Focus on continuously deliver value to customers.
- *Approach* - Integrate planning, development, delivery, and operations with DevOps methods and tools.
- *Benefits* - Quickly limit the total cost of ownership of your workloads in the cloud.

## Modernize your workflow

Modernize your workflow by adopting an Agile cadence by following these steps:

### Step 1 - Reference your commitment path

Reference the commitment path you created in step 1 of the [the commit phase](../business-alignment/envision-cloud-modernization.md#step-1---identify-your-modernization-motivations).

For reference, the table we created in the commitment step has been copied below.

|Business Function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |Modernization Strategy
| --- | --- | --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment System|Application innovation |<ul><li>Process modernization</li><li>Application modernization</li></ul>|
|

### Organize work tasks around the commitment path

Next, organize work tasks around the commitment path you created. The commitment path has all the information you need to modernize your workflow. Follow the table to organize your work tasks.

| Step | Work Tasks | Example |
| --- | --- | --- |
| 1. Create large buckets of work (epics) | Combine your modernization motivation and workload. High-level goals are epics in Agile. | Application innovation for the E-commerce website |
| 2. Identify major tasks (user stories) | Create major tasks from a user or customer perspective. Major tasks are user stories in Agile. | As a shopper, I want a more responsive website so I have a better shopping experience |
| 3. Identify smaller tasks within the major tasks (subtasks)| Break down the major tasks into smaller tasks. Smaller tasks are simply tasks or subtasks in Agile. | <ul> <li>Choose Azure App Service plan</li> <li>Configure security</li>  <li>Configure caching</li> </ul>
| 4. Divide up the work into management pieces (sprints) | Set a two-week time frame and let your team members take on tasks that they can complete over that two week period | <ul> <li>Person-A takes "choose Azure App Service plan"</li> <li>Person-B takes "configure security"</li>  <li>Person-C takes "configure caching"</li> </ul>|
|

## Modernize your tools

Modernize your tools by adopting a DevOps toolset. A DevOps toolset has five components. You can patch together tools or use [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) to make modernizing your tools easier (*see table*).

The table tells you what you need and the "Solution" column contains guidance on how to adopt that tool.

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
> [Learn how to modernize your applications](../../modernize/modernize-strategies/application-modernization.md)
