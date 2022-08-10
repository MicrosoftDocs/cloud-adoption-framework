---
title: Learn how to modernize your processes for the cloud
description: Learn how to modernize your processes in the cloud
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

# Modernize your processes for the cloud

Learn how to modernize your process for the cloud. Modernizing your processes increases operational efficiency. Operational efficiency reduces the total cost of ownership of your workloads.

:::image type="content" source="../../_images/modernize/process-modernization/devops-and-tools-512.png" alt-text="image showing a circle with 4 segments":::

Modernize your process with a DevOps approach. DevOps uses an Agile framework to deliver continuous value to customers. The DevOps approach has a specific focus, approach, and benefits

- *Focus* - Focus on continuously deliver value to customers.
- *Approach* - Integrate planning, development, delivery, and operations with DevOps methods and tools.
- *Benefits* - Quickly limit the total cost of ownership of your workloads in the cloud.

## Modernize your workflow

Modernize your workflow by adopting an Agile cadence and following these steps.

### Step 1 - Grab your modernization path

Grab the modernization path you created in the [commit phase](../business-alignment/envision-cloud-modernization.md#step-1---identify-your-modernization-motivations) to begin modernizing your workflow. You need to structure your modernization efforts around the modernization path.

The sample modernization path we created is below for easy reference.

|Business Function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |Modernization Strategy
| --- | --- | --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment System|Application innovation |<ul><li>Process modernization</li><li>Application modernization</li></ul>|

### Step 2 - Organize modernization efforts around your modernization path

Organize modernization efforts around the modernization path you created. The modernization path has all the information you need to modernize your workflow.

Follow the steps in the table below to organize your modernization efforts.

| Step | Work Tasks | Example |
| --- | --- | --- |
| 1. Create large buckets of work (epics) | Combine your modernization motivation and workload to create large buckets of work. Large buckets of work are epics in Agile. | Application innovation for the E-commerce website |
| 2. Break down the large buckets of work into multiple tasks (user stories) | Create these tasks from the perspective of your user or customer. Tasked created from epics are user stories in Agile. | As a shopper, I want a more responsive website so I have a better shopping experience |
| 3. Break down the tasks into subtasks (tasks)| Subtasks are specific and detailed. Subtasks are tasks in Agile. | <ul> <li>Choose Azure App Service plan</li> <li>Configure security</li>  <li>Configure caching</li> </ul>
| 4. Prioritize user stories. Assign the work. Limit the time to complete the work (sprints) | Set a two-week time frame and let your team members take on tasks that they can complete in the two-week period | <ul> <li>Person-A takes on the Azure App Service plan task</li> <li>Person-B configures security</li>  <li>Person-C configures caching</li> </ul>|

## Modernize your tools

Modernize your tools with DevOps. DevOps has a toolset with five components. You can use open-source tools or use [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) to make modernizing easier (*see table*).

The table below shows you what DevOps tools you need and what it does. The "Solution" column gives you guidance on how to adopt each tool. "Alternative" gives an open-source option.

| DevOps Tool | Tool Description | Solution | Alternative
| --- | --- | --- | --- |
| *Repository* | A cloud-based location to store all code, track changes, and merge work | [Azure Repos](/azure/devops/repos/get-started/what-is-repos) | GitHub
| *Pipeline* | An automated process to validate and push code to a desired environment | [Azure Pipeline](/azure/devops/pipelines/get-started/pipelines-get-started) | Jenkins
| *Boards* | A central dashboard that tracks the progress of work items | [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) | TaskBoard |
| *Artifacts* | A tool to share code and publish packages | [Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts) | Nexus
| *Testing* | A tool to run tests and quality assurance on code | [Azure Test Plans](/azure/devops/test/overview) | Selenium |

With your DevOps tools in place, you can begin modernizing your applications and modernizing your databases.

## Next Steps

>[!div class="nextstepaction"]
> [Modernize your applications](../../modernize/modernize-strategies/application-modernization.md)
>[!div class="nextstepaction"]
> [Modernize your databases](../../modernize/modernize-strategies/database-modernization.md)
