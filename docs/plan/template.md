---
title: Cloud adoption plan deployment to Azure DevOps
description: Learn how to quickly deploy a backlog to Azure DevOps by using a template that aligns cloud adoption efforts to a standardized process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
ms.custom: internal
---

# Cloud adoption plan and Azure DevOps

Azure DevOps is the set of cloud-based tools for Azure customers who manage iterative projects. It also includes tools for managing deployment pipelines and other important aspects of DevOps.

In this article, you'll learn how to quickly deploy a backlog to Azure DevOps using a template. This template aligns cloud adoption efforts to a standardized process based on the guidance in the Cloud Adoption Framework.

## Create your cloud adoption plan

To deploy the cloud adoption plan, open the [Azure DevOps demo generator](https://aka.ms/adopt/plan/generator). This tool will deploy the template to your Azure DevOps tenant. Using the tool requires the following steps:

1. Verify that the **Selected Template** field is set to **Cloud Adoption Plan**. If it isn't, select **Choose template** to choose the right template.
2. Select your Azure DevOps organization from the **Select Organization** drop-down list box.
3. Enter a name for your new project. The cloud adoption plan will have this name when it's deployed to your Azure DevOps tenant.
4. Select **Create Project** to create a new project in your tenant, based on the strategy and plan template. A progress bar show your progress toward deploying the project.
5. When deployment is finished, select **Navigate to project** to see your new project.

After your project has been created, continue through this article series to learn how to modify the template to align to your cloud adoption plan.

For additional support and guidance on this tool, see [Azure DevOps Services demo generator](/azure/devops/demo-gen/).

## Bulk edit the cloud adoption plan

When the plan project has been deployed, you can use Microsoft Excel to modify it. It's much easier to create new workloads or assets in the plan by using Microsoft Excel than by using the Azure DevOps browser experience.

To prepare your workstation for bulk editing, see [Bulk add or modify work items with Microsoft Excel](/azure/devops/boards/backlogs/office/bulk-add-modify-work-items-excel).

Some users may want to use Microsoft Project to track their tasks, create backlog and assign resource. Here are the steps to [connect Microsoft Project to Azure DevOps](/azure/devops/boards/backlogs/create-your-backlog).

## Use the cloud adoption plan

The cloud adoption plan organizes activities by activity type:

- **Epics:** An *epic* represents an overall phase of the cloud adoption lifecycle.
- **Features:** Features are used to organize specific objectives within each phase. For instance, migration of a specific workload would be one feature.
- **User stories:** User stories group work into logical collections of activities based on a specific goal.
- **Tasks:** Tasks are the actual work to be done.

At each layer, activities are then sequenced based on dependencies. Activities are linked to articles in the Cloud Adoption Framework to clarify the objective or task at hand.

The clearest view of the cloud adoption plan comes from the **Epics** backlog view. For help with changing to the **Epics** backlog view, see the article on [viewing a backlog](/azure/devops/boards/backlogs/define-features-epics#view-a-backlog-or-portfolio-backlog). From this view, it's easy to plan and manage the work required to complete the current phase of the adoption lifecycle.

> [!NOTE]
> The current state of the cloud adoption plan focuses heavily on migration efforts. Tasks related to governance, innovation, or operations must be populated manually.

## Align the cloud adoption plan

The overview pages for the Strategy methodology and the Plan methodology each refer to the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx). That template organizes the decisions and data points that will align the template for the cloud adoption plan with your specific plans for adoption. Considering completing the exercises in the [Strategy methodology](../strategy/index.md) and the [Plan methodology](./index.md) before aligning your new project.

The following articles support alignment of the cloud adoption plan:

- [Workloads](./workloads.md): Align features within the cloud migration epic to capture each workload to be migrated or modernized. Add and modify those features to capture the effort to migrate your top 10 workloads.
- [Assets](./assets.md): Each asset (virtual machine, application, or data) is represented by the user stories under each workload. Add and modify those user stories to align with your digital estate.
- [Rationalization](./review-rationalization.md): As each workload is defined, the initial assumptions about that workload can be challenged. This might result in changes to the tasks under each asset.
- [Create release plans](./iteration-paths.md): Iteration paths establish release plans by aligning efforts with various releases and iterations.
- [Establish timelines](./timelines.md): Defining start and end dates for each iteration creates a timeline to manage the overall project.

These five articles help with each of the alignment tasks required to start managing your adoption efforts. The next step gets you started on the alignment exercise.

## Next steps

Start aligning your plan project by [defining and prioritizing workloads](./workloads.md).

> [!div class="nextstepaction"]
> [Define and prioritize workloads](./workloads.md)
