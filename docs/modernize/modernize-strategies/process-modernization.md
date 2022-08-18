---
title: Modernize your development and operations processes for the cloud
description: Learn how to modernize your processes in the cloud
author: stephen-sumner
ms.author: ssumner
ms.date: 08/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# Modernize your development and operations processes for the cloud

Process modernization creates the mechanism in your business to gain operational efficiencies and lower the total cost of ownership of your workloads.

We recommend using Azure DevOps to allow your teams to plan work, collaborate on code development, and build and deploy applications, so you can continuously deliver value to customers at a faster pace (*see figure*). For demonstration purposes, we're using Azure DevOps Services, which supports integration with GitHub.com and GitHub Enterprise Server repositories. For more information, see the [Azure DevOps and GitHub integration overview](/azure/devops/cross-service/github-integration) and [What is Azure DevOps?](/azure/devops/user-guide/what-is-azure-devops).
<!---
Need to add Azure DevOps to image, not just DevOps.
-->
:::image type="content" source="../../_images/modernize/process-modernization/devops-and-tools-512.png" alt-text="An image showing a circle with four segments corresponding to a basic Azure DevOps workflow, showing each service provided: Azure Boards, Azure Test Plans, Azure Repos, Azure Pipelines, and Azure Artifacts.":::

## Step 1 - Modernize your tools

Modernize your tools so you can plan and deliver value to customers. Azure DevOps lets you easily integrate planning, development, delivery, and operations. In the following table, we've listed the standalone services offered and examples of alternative open-source solutions.

| Azure DevOps standalone service | Description |  Open-source solution
| --- | --- | --- | --- |
| *[Azure Repos](/azure/devops/repos/get-started/what-is-repos)* | Get unlimited, cloud-hosted private Git repositories for your project. | GitHub
| *[Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines)* | Continuously build, test, and deploy to any platform and cloud. | Jenkins
| *[Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards)* | Plan, track, and discuss work across your teams. | TaskBoard |
| *[Azure Artifacts](/azure/devops/artifacts/artifacts-overview)* | Share code and publish packages | Nexus
| *[Azure Test Plans](/azure/devops/test/overview)* | Run tests and quality assurance on code | Selenium |

With modernized tools, you're ready to modernize your planning strategies.

## Step 2 - Modernize your planning strategies

Modernize your planning strategies with an Agile framework that integrates planning, development, delivery, and operations into a continuous feedback loop (*see previous figure*).

You can quickly deliver value by prioritizing your tasks and working on high-priority tasks for a short period of time.

### Consult your modernization roadmap

Consult the modernization roadmap you created in the [commit phase](../business-alignment/envision-cloud-modernization.md#step-1---identify-your-modernization-motivations) to begin modernizing your planning strategies. It has all the details you need.

Here's the sample modernization roadmap we created.

|Business function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |Modernization strategy|Timeline|
| --- | --- | --- | --- | --- |
|E-commerce<br>Website| Web app<br>Business logic<br>Database<br>Servers<br>Payment system|Application innovation |<ul><li>Process modernization</li><li>Application modernization</li></ul>| X-weeks|

### Plan your modernization efforts

Plan your modernization efforts using your modernization roadmap. Do the steps in the following table to divide the work into manageable pieces and assign it to members of your team. For illustrating this purpose, we're using the Agile process in Azure Boards. For more information, see [Plan and track work in Azure Boards](/azure/devops/boards/get-started/plan-track-work).

| Step | Work tasks | Example |
| --- | --- | --- |
| 1. Identify major efforts | Major efforts include a combination of your modernization motivations and workloads. Major efforts are often called *epics* in Agile. | Application innovation for the E-commerce website. |
| 2. Break down the major efforts (*epics*) into smaller tasks (user stories) |Analyze the major efforts (*epic*) from the perspective of your customers. Divide the major efforts (*epics*) into smaller, logical tasks that correspond to customer needs. Tasks created from epics are called *user stories* in Agile. The number of user stories you have for each epic depends on the complexity of the workload. There's no right or wrong number. | "As a customer, I want a more responsive website so I have a better shopping experience" <br><br> "As a customer, I want a complete order history so I can reorder items easier"|
| 3. Break down the tasks (*user stories*) further into smaller tasks (tasks)| These smaller tasks should be specific and detailed. Create as many as you need to meet the request in the user story. Subtasks are called *tasks* in Agile. | Choose an App Service plan<br><br>Configure resiliency<br><br>Configure caching
| 4. Prioritize your user stories | Prioritize your user stories, so your team can meet the most important goals first. | 1. Better shopping experience <br><br> 2. Order history
| 5. Assign work (sprints) | Set a two-week time frame for your work efforts. These time frames are called sprints in Agile. Have your team members take on tasks that they can complete within the two-week period. | Assign two-week tasks (App Service plan, configure resiliency, configure caching) to your team.

For more details on modernizing your planning efforts, you can look at more robust [DevOps planning guidance](/azure/devops/plan/planning-efficient-workloads-with-devops).

## Step 3 - Begin modernizing

You're ready to modernize, since you've adopted DevOps tools and planned your work. Begin working on your first sprint.

## Next steps

Your [modernization roadmap](/business-alignment/commit-to-modernization-plan.md/#next-steps) will guide you to modernize your applications or databases next.

>[!div class="nextstepaction"]
> [Modernize your applications](../../modernize/modernize-strategies/application-modernization.md)
>[!div class="nextstepaction"]
> [Modernize your databases](../../modernize/modernize-strategies/database-modernization.md)
