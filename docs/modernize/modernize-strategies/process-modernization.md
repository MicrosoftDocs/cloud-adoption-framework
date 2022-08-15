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

# Modernize your development and operations processes for the cloud

Learn how to modernize your development and operations processes for the cloud. Modernizing your development and operations processes increases your team's efficiency and ultimately reduces the total cost of ownership of your workloads.

:::image type="content" source="../../_images/modernize/process-modernization/devops-and-tools-512.png" alt-text="An image showing a circle with four segments corresponding to a basic DevOps workflow. The segments say plan, develop, deliver, and operate. In the middle of the circle, it says DevOps. There's a circular arrow showing that DevOps is a continuous process. There are images of five Azure DevOps tools inside the circular arrow. The Azure DevOps tools are Azure Boards, Azure Test Plans, Azure Repos, Azure Pipelines, and Azure Artifacts.":::

We recommend you modernize your processes inline with DevOps. DevOps uses proven planning strategies and tools to continuously deliver value to customers. We outline how to start with DevOps in the sections below.

## Modernize your planning strategies

Modernize your planning strategies by adopting a DevOps process. DevOps is an Agile framework that lets you plan effectively and modernize efficiently. Here are three steps to start planning your workload modernization efforts.

### Step 1 - Use your modernization roadmap

Use the modernization roadmap you created in the [commit phase](../business-alignment/envision-cloud-modernization.md#step-1---identify-your-modernization-motivations) to begin modernizing your planning strategies. It has all the details you need.

The sample modernization path we created in the previous steps is copied below for easy reference.

|Business Function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |Modernization Strategy
| --- | --- | --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment System|Application innovation |<ul><li>Process modernization</li><li>Application modernization</li></ul>|

### Step 2 - Plan your modernization efforts

Organize modernization efforts around the modernization path you created. The modernization path has all the information you need to modernize your workflow.

Follow the steps in the table below to organize your modernization efforts.

| Step | Work Tasks | Example |
| --- | --- | --- |
| 1. Create large buckets of work (epics) | Combine your modernization motivation and workload to create large buckets of work. Large buckets of work are called *epics* in Agile. | Application innovation for the E-commerce website |
| 2. Break down the large buckets of work into multiple tasks (user stories) |Create these tasks from the perspective of your user or customer. Tasked created from epics are called *user stories* in Agile. The number of user stories you have depends on the complexity of the workload. There's no right or wrong number. | You could have one or many user stories. Here's one example:<br><br> "As a shopper, I want a more responsive website so I have a better shopping experience" |
| 3. Break down the tasks identified in step 2 into smaller tasks (tasks)| These smaller tasks should be specific and detailed. Together, they meet the need identified in the user story. Subtasks are called *tasks* in Agile. | Sticking with our sample user story in step 2, here are some sample tasks: <br><ul> <li>Choose an Azure App Service plan</li> <li>Configure security for the app</li>  <li>Configure caching for the app</li> </ul>
| 4. Prioritize your user stories and tasks | Put your user stories in order of priority. Ordering by priority will allow your team to meet the most important goals first | 1. As a shopper, I want a more responsive website ...<br>2. As a developer, I want better comments in our code ... <br><br>In this example, customer needs are more important than the need for better code comments.
| 5. Assign work (sprints) | Set a two-week time frame for your work efforts. These time frames are called sprints in Agile. Have your team members take on tasks that they can complete in the two-week period | We will use the user story from step 2:<br><ul> <li>Person-A takes on the Azure App Service plan task</li> <li>Person-B configures security</li>  <li>Person-C configures caching</li> </ul>|

The goal is the break the modernization work into manageable pieces and make the changes that have the most effect on customer and user needs.

### Step 3 - Begin working

You're ready to begin working. You've identified your epics, user stories, and tasks. You have a prioritized list of tasks and have assigned each task to people on your team. You're now ready to begin working on your first sprint.

For more details on modernizing your planning efforts, you can look at more robust [DevOps planning guidance](/devops/plan/planning-efficient-workloads-with-devops).

## Modernize your tools

Modernize your tools to facilitate your DevOps planning strategies. You need to adopt DevOps tools to gain the efficiencies of DevOps. DevOps has a toolset with five components. You can use open-source tools or use [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) to make modernizing easier (*see table*).

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
