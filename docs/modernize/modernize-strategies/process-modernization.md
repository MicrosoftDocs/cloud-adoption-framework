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

Learn how to modernize your development and operations processes for the cloud. Process modernization creates the mechanism in your business to gain operational efficiencies and lower the total cost of ownership of your workloads.

The DevOps methodology provides these essential mechanisms. DevOps uses special planning strategies and tools that let you continuously deliver value to customers (*see figure*).

:::image type="content" source="../../_images/modernize/process-modernization/devops-and-tools-512.png" alt-text="An image showing a circle with four segments corresponding to a basic DevOps workflow. The segments say plan, develop, deliver, and operate. In the middle of the circle, it says DevOps. There's a circular arrow showing that DevOps is a continuous process. There are images of five Azure DevOps tools inside the circular arrow. The Azure DevOps tools are Azure Boards, Azure Test Plans, Azure Repos, Azure Pipelines, and Azure Artifacts.":::

## Step 1 - Modernize your tools

Modernize your tools so you can plan and deliver value to customers. DevOps tools let you easily integrate planning, development, delivery, and operations. The DevOps toolset has five components.

The table has each DevOps tool and what it does. The "solution" column has a link that shows you how to adopt each tool with an alternative open-source solution.

| DevOps Tool | Tool Description | Solution | Open-Source Solution
| --- | --- | --- | --- |
| *Repository* | A cloud-based location to store all code, track changes, and merge work | [Azure Repos](/azure/devops/repos/get-started/what-is-repos) | GitHub
| *Pipeline* | An automated process to validate and push code to a desired environment | [Azure Pipeline](/azure/devops/pipelines/get-started/pipelines-get-started) | Jenkins
| *Boards* | A central dashboard that tracks the progress of work items | [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) | TaskBoard |
| *Artifacts* | A tool to share code and publish packages | [Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts) | Nexus
| *Testing* | A tool to run tests and quality assurance on code | [Azure Test Plans](/azure/devops/test/overview) | Selenium |

With these tools in place, you're ready to modernize your planning strategies.

## Step 2 - Modernize your planning strategies

Modernize your planning strategies with a DevOps mindset. DevOps is an Agile framework that integrates planning, development, delivery, and operations into a continuous feedback loop (*see figure above*).

The goal of DevOps is to deliver value quickly. You deliver value quickly by prioritizing your tasks and working on high-priority tasks for a short period of time.

### Consult your modernization roadmap

Consult the modernization roadmap you created in the [commit phase](../business-alignment/envision-cloud-modernization.md#step-1---identify-your-modernization-motivations) to begin modernizing your planning strategies. It has all the details you need.

Here's the sample modernization roadmap we created.

|Business Function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |Modernization Strategy|Timeline|
| --- | --- | --- | --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment System|Application innovation |<ul><li>Process modernization</li><li>Application modernization</li></ul>| N-weeks|

### Plan your modernization efforts

Plan your modernization efforts using the modernization roadmap you created. Follow the steps in the table to divide the work into manageable pieces and assign them to members of your team.

| Step | Work Tasks | Example |
| --- | --- | --- |
| 1. Identify major efforts (epics) | Major efforts are simply a combination of your modernization motivation and workload. Major efforts are called *epics* in Agile. | Application innovation for the E-commerce website |
| 2. Break down the major efforts (*epics*) into smaller tasks (user stories) |Analyze the major efforts (*epic*) from the perspective of your customers. Divide the major efforts (*epics*) into smaller, logical tasks that correspond to customer needs. Tasks created from epics are called *user stories* in Agile. The number of user stories you have for each epic depends on the complexity of the workload. There's no right or wrong number. | "As a customer, I want a more responsive website so I have a better shopping experience" <br><br> "As a customer, I want a complete order history so I can reorder items easier"|
| 3. Break down the tasks (*user stories*) further into smaller tasks (tasks)| These smaller tasks should be specific and detailed. Create as many as you need to meet the request in the user story. Subtasks are called *tasks* in Agile. | Choose an App Service plan<br><br>Configure resiliency<br><br>Configure caching
| 4. Prioritize your user stories | Put your user stories in order of priority. Ordering by priority will allow your team to meet the most important goals first | 1. Better shopping experience <br><br> 2. Order history
| 5. Assign work (sprints) | Set a two-week time frame for your work efforts. These time frames are called sprints in Agile. Have your team members take on tasks that they can complete in the two-week period | Assign two-week tasks (App Service plan, configure resiliency, configure caching) to team.

For more details on modernizing your planning efforts, you can look at more robust [DevOps planning guidance](/devops/plan/planning-efficient-workloads-with-devops).

## Step 3 - Begin modernizing

You're ready to begin modernizing. You've adopted DevOps tools. You've planned your work. Begin working on your first sprint.

## Next Steps

Your [modernization roadmap](/business-alignment/commit-to-modernization-plan.md/#next-steps) will guide you to modernize your application or database next.

>[!div class="nextstepaction"]
> [Modernize your applications](../../modernize/modernize-strategies/application-modernization.md)
>[!div class="nextstepaction"]
> [Modernize your databases](../../modernize/modernize-strategies/database-modernization.md)
