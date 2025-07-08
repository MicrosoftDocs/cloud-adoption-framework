---
title: Modernize your processes for the cloud
description: Adopt a DevOps methodology to modernize your development and operations. Process modernization is essential to lowering the total cost of ownership of your workloads.
author: stephen-sumner
ms.author: pnp
ms.date: 09/28/2022
ms.topic: conceptual
ms.custom: internal
---

# Modernize your processes for the cloud

Process modernization creates the mechanisms in your business to gain operational efficiencies that lower the total cost of ownership of your workloads. We recommend adopting a DevOps methodology to modernize your processes.

:::image type="content" source="../../_images/modernize/process-modernization/devops-tools.png" alt-text="Diagram that shows a circle with four segments corresponding to a basic Azure DevOps workflow, showing each service provided: Azure Boards, Azure Test Plans, Azure Repos, Azure Pipelines, and Azure Artifacts." border="false":::

*Diagram 1: High-level DevOps loop with DevOps tools*

The DevOps methodology integrates planning, development, delivery, and operations into a single pipeline. Integration allows teams to name the highest priorities in your organization and resolve them together. The collective focus on the things that matter creates the most value with the least amount of work.

We've broken process modernization into three steps: tools, strategies, and benefits.

## Step 1 - Adopt DevOps tools

Adopting DevOps tools can help you plan better and deliver value to customers faster.

In the following table, we've listed the DevOps tool and description. Azure has a set of DevOps tools called [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops). You can use these Azure tools to implement DevOps, or you can use open-source solutions. For each DevOps tool in the table, we listed a service from the Azure DevOps Services and an alternative open-source solution.

| DevOps tool | Description | Azure DevOps solution |  Open-source solution
| --- | --- | --- | --- |
| Source control | Code repositories for your project. | *[Azure Repos](/azure/devops/repos/get-started/what-is-repos)* | GitHub
| CI/CD pipeline | Continuously build, test, and deploy to any platform and cloud. | *[Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines)* |  Jenkins
| Task board | Plan, track, and discuss work across your teams. | *[Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards)* | TaskBoard |
| Package manager | Share code and publish packages | *[Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts)* | Nexus |
| Test management| Run tests and quality assurance on code | *[Azure Test Plans](/azure/devops/test/overview)* | Selenium |

With your DevOps tools in place, you're ready to modernize your planning strategies.

## Step 2 - Adopt DevOps strategies

Modernize your process by adopting DevOps strategies. DevOps strategies are ways of doing things in an Agile framework. You integrate your development and operations, focus on the highest-priority tasks, and work on tasks for a defined period of time. These strategies allow you to modernize effectively in the cloud.

You're going to consult your modernization roadmap and plan your modernization efforts around it.

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
| 1. Identify major efforts | Major efforts include your modernization motivations and workloads. Major efforts are *epics* in Agile. | Application innovation for the E-commerce website. |
| 2. Break down the major efforts (*epics*) into smaller tasks (user stories) |Analyze the major efforts (*epic*) from the perspective of your customers. Divide the major efforts (*epics*) into smaller, logical tasks that correspond to customer needs. Tasks created from epics are called *user stories* in Agile. The number of user stories you have for each epic depends on the complexity of the workload. There's no right or wrong number. | "As a customer, I want a more responsive website so I have a better shopping experience" <br><br> "As a customer, I want a complete order history so I can reorder items easier"|
| 3. Break down the tasks (*user stories*) further into smaller tasks (tasks)| These smaller tasks should be specific and detailed. Create as many as you need to meet the request in the user story. Subtasks are *tasks* in Agile. | Choose an App Service plan<br><br>Configure resiliency<br><br>Configure caching
| 4. Prioritize your user stories | Prioritize your user stories, so your team can meet the most important goals first. | 1. Better shopping experience <br><br> 2. Order history
| 5. Assign work (sprints) | Set a two-week period for your work efforts. These periods are *sprints* in Agile. Have your team members take on tasks that they can complete within the two-week period. | Assign two-week tasks (App Service plan, configure resiliency, configure caching) to your team.

This table captures the essentials of DevOps. It's enough to work with, but you might need more guidance. For more DevOps guidance, see [DevOps planning guidance](/devops/plan/planning-efficient-workloads-with-devops).

## Step 3 - Adopt DevOps benefits

You've adopted DevOps tools and adopted DevOps strategies. You're ready to adopt the benefits of DevOps. DevOps allows you to learn, improve, and scale faster. The time-bound iterations and team integration will enable your team to modernize better.

## Next steps

You're ready to modernize your applications or databases. You should consult the modernization roadmap you created in [business alignment](../business-alignment/index.md). The road map will let you know what to focus on next.

>[!div class="nextstepaction"]
> [Modernize your applications](../../modernize/modernize-strategies/application-modernization.md)
>[!div class="nextstepaction"]
> [Modernize your databases](../../modernize/modernize-strategies/database-modernization.md)
