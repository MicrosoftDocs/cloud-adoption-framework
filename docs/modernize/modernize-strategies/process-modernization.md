---
title: Modernize your processes for the cloud
description: Adopt a DevOps methodology to modernize your development and operations. Process modernization is essential to lowering the total cost of ownership of your workloads.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# Modernize your processes for the cloud

Process modernization creates the mechanism in your business to gain operational efficiencies and lower the total cost of ownership of your workloads. Adopting a DevOps methodology drives efficiencies across your development and operations processes. DevOps empowers your teams to deliver value to customers faster.

**Modernization overview:**

The DevOps methodology integrates work planning, code development, application deployment, and operations. You gain efficiency across your business with this integration.

You'll first want to adopt some DevOps tools. Azure has a set of DevOps tools called [Azure DevOps Services](/azure/devops/user-guide/what-is-azure-devops). You can use these Azure tools to implement DevOps, or you can use open-source solutions to get started.

After adopting DevOps tools, you can start modernizing your development and operations processes. Follow the steps below to get started.

:::image type="content" source="../../_images/modernize/process-modernization/devops-tools.png" alt-text="An image showing a circle with four segments corresponding to a basic Azure DevOps workflow, showing each service provided: Azure Boards, Azure Test Plans, Azure Repos, Azure Pipelines, and Azure Artifacts." border="false":::

## Step 1 - Adopt DevOps tools

Adopting DevOps tools can help you plan better and deliver value to customers faster. Azure DevOps lets you easily integrate planning, development, delivery, and operations.

In the following table, we've listed the DevOps tool and description. For each tool, we listed a service from the Azure DevOps Services and an alternative open-source solution.

| DevOps tool | Description | Azure DevOps Services tool |  Open-source solution
| --- | --- | --- | --- |
| Source control | Get unlimited, cloud-hosted private Git repositories for your project. | *[Azure Repos](/azure/devops/repos/get-started/what-is-repos)* | GitHub
| CI/CD pipeline | Continuously build, test, and deploy to any platform and cloud. | *[Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines)* |  Jenkins
| Task board | Plan, track, and discuss work across your teams. | *[Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards)* | TaskBoard |
| Package manager | Share code and publish packages | *[Azure Artifacts](/azure/devops/artifacts/artifacts-overview)* | Nexus |
| Test management| Run tests and quality assurance on code | *[Azure Test Plans](/azure/devops/test/overview)* | Selenium |

With modernized tools, you're ready to modernize your planning strategies.

## Step 2 - Adopt DevOps strategies

Modernize your planning strategies with DevOps. DevOps is an Agile framework that integrates planning, development, delivery, and operations into a continuous feedback loop (*see previous figure*).

DevOps focuses you on quickly delivering value to customers. You prioritize your high-value tasks and work on these tasks for a defined period of time. The combination of task prioritization and time constrained activities promotes rapid innovation.

### Consult your modernization roadmap

Consult the modernization roadmap you created in the [commit phase](../business-alignment/envision-cloud-modernization.md#step-1---identify-modernization-motivations) to begin modernizing your planning strategies. It has all the details you need.

Here's the sample modernization roadmap we created.

|Business function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |Modernization strategy|Timeline|
| --- | --- | --- | --- | --- |
|E-commerce<br>Website| Web app<br>Business logic<br>Database<br>Servers<br>Payment system|Application innovation |<ul><li>Process modernization</li><li>Application modernization</li></ul>| X-weeks|

### Plan your modernization efforts

Plan your modernization efforts using your modernization roadmap. Complete the steps in the following table to divide the work into manageable pieces and assign it to members of your team.

| Step | Work tasks | Example |
| --- | --- | --- |
| 1. Identify major efforts | Major efforts include a combination of your modernization motivations and workloads. Major efforts are often called *epics* in Agile. | Application innovation for the E-commerce website. |
| 2. Break down the major efforts (*epics*) into smaller tasks (user stories) |Analyze the major efforts (*epic*) from the perspective of your customers. Divide the major efforts (*epics*) into smaller, logical tasks that correspond to customer needs. Tasks created from epics are called *user stories* in Agile. The number of user stories you have for each epic depends on the complexity of the workload. There's no right or wrong number. | "As a customer, I want a more responsive website so I have a better shopping experience" <br><br> "As a customer, I want a complete order history so I can reorder items easier"|
| 3. Break down the tasks (*user stories*) further into smaller tasks (tasks)| These smaller tasks should be specific and detailed. Create as many as you need to meet the request in the user story. Subtasks are called *tasks* in Agile. | Choose an App Service plan<br><br>Configure resiliency<br><br>Configure caching
| 4. Prioritize your user stories | Prioritize your user stories, so your team can meet the most important goals first. | 1. Better shopping experience <br><br> 2. Order history
| 5. Assign work (sprints) | Set a two-week time frame for your work efforts. These time frames are called sprints in Agile. Have your team members take on tasks that they can complete within the two-week period. | Assign two-week tasks (App Service plan, configure resiliency, configure caching) to your team.

[Azure Boards](/azure/devops/boards/get-started/plan-track-work) makes it easy to plan and track work. For more details on modernizing your planning efforts, you can look at more robust [DevOps planning guidance](/azure/devops/plan/planning-efficient-workloads-with-devops).

## Step 3 - Begin modernizing

Begin modernizing. You've adopted DevOps tools and planned your work. Start planning your first sprint.

## Next steps

Your modernization roadmap will guide you to modernize your applications or databases next.

>[!div class="nextstepaction"]
> [Modernize your applications](../../modernize/modernize-strategies/application-modernization.md)
>[!div class="nextstepaction"]
> [Modernize your databases](../../modernize/modernize-strategies/database-modernization.md)
