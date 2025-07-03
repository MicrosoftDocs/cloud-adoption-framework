---
title: Define and prioritize workloads for cloud adoption
description: Use the Cloud Adoption Framework for Azure to learn how to define and prioritize workloads for a cloud adoption plan.
author: Zimmergren
ms.author: pnp
ms.date: 04/24/2023
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Define and prioritize workloads for a cloud adoption plan

Establishing clear, actionable priorities is one of the secrets to successful cloud adoption. The natural temptation is to invest time defining all workloads that could be affected during cloud adoption. But that's counterproductive, especially early in the adoption process.

Instead, we recommend that your team thoroughly prioritizes and documents the first 10 workloads. After implementing the adoption plan, the team can maintain a list of the following 10 highest-priority workloads. This approach provides enough information to plan for the subsequent few iterations.

Limiting the plan to 10 workloads encourages agility and alignment of priorities as business criteria change. This approach also allows the cloud adoption team to learn and refine estimates. Most importantly, it removes extensive planning as a barrier to effective business change.

## What is a workload?

In cloud adoption, a workload is a collection of IT assets (servers, VMs, applications, data, or appliances) that collectively support a defined process. Workloads can support more than one process. Workloads can also depend on other shared assets or larger platforms. However, a workload should have defined boundaries regarding the dependent assets and the processes that depend upon the workload. Often, workloads can be visualized by monitoring network traffic among IT assets.

## Prerequisites

The strategic inputs from the prerequisites list make accomplishing the following tasks much more manageable. For help with gathering the data discussed in this article, review the [prerequisites](./prerequisites.md).

## Initial workload prioritization

During the process of [incremental rationalization](../digital-estate/rationalize.md), your team should agree on a [Power of 10 approach](../digital-estate/rationalize.md#release-planning) consisting of 10 priority workloads. These workloads serve as an initial boundary for adoption planning.

Suppose you decide that a digital estate rationalization isn't needed. In that case, we recommend that the cloud adoption teams and the cloud strategy team agree on a list of 10 applications to serve as the initial focus of the migration. We recommend that these 10 workloads contain a mixture of simple workloads (fewer than 10 assets in a self-contained deployment) and more complex workloads. Those 10 workloads start the workload prioritization process.

> [!NOTE]
> The Power of 10 approach serves as an initial planning boundary, focusing the energy and investment in early-stage analysis. However, analyzing and defining workloads is likely to cause changes in the list of priority workloads.

## Add workloads to your cloud adoption plan

In the previous article, [Cloud adoption plan and Azure DevOps](./template.md), you created a cloud adoption plan in Azure DevOps.

You can now represent the workloads in the Power of 10 list in your cloud adoption plan. The easiest way to do this is via bulk editing in Microsoft Excel. To prepare your workstation for bulk editing, see [Bulk add or modify work items with Microsoft Excel](/azure/devops/boards/backlogs/office/bulk-add-modify-work-items-excel).

Step 5 in that article tells you to select **Input list**. Instead, select **Query list**. Then, from the **Select a Query** drop-down list, select the **Workload Template** query. That query loads all the efforts related to migrating a single workload into your spreadsheet.

After the work items for the workload template are loaded, follow these steps to begin adding new workloads:

1. Copy all items with the **Workload Template** tag in the far right column.
2. Paste the copied rows below the last line item in the table.
3. Change the title cell for the new feature from **Workload Template** to the name of your new workload.
4. Paste the new workload name cell into the tag column for all rows below the new feature. Be careful not to change the tags or name of the rows related to the actual **Workload Template** feature. When you add the next workload to the cloud adoption plan, you'll need those work items.
5. Skip to step 8 in the bulk-editing instructions to publish the worksheet. This step creates all the work items required to migrate your workload.

Repeat steps 1 through 5 for each workload in the Power of 10 list.

## Define workloads

After defining initial priorities and adding workloads to the plan, define each workload via deeper qualitative analysis. Before including any workload in the cloud adoption plan, try to provide the following data points for each workload.

### Business inputs

| Data point | Description | Input |
|---|---|---|
| Workload name | What is this workload called? |         |
| Workload description | In one sentence, what does this workload do? |         |
| Adoption motivations | Which cloud adoption motivations are affected by this workload? |         |
| Primary sponsor | Of those stakeholders affected, who is the primary sponsor requesting the preceding motivations? |         |
| Business impact | What is the business impact of this workload?|         |
| Application impact | What impact does this application have on business processes?|         |
| Data impact | What impact does the data have on the business?|         |
| Business unit | Which business unit is responsible for the cost of this workload? |         |
| Business processes | Which business processes will be affected by changes to the workload? |         |
| Business teams | Which business teams will be affected by changes? |         |
| Business stakeholders | Are there any executives whose business will be affected by changes? |         |
| Business outcomes | How will the business measure the success of this effort? |         |
| Metrics | What metrics will be used to track success? |         |
| Compliance | Are there any third-party compliance requirements for this workload? |         |
| Application owners | Who is accountable for the business impact of any applications associated with this workload? |         |
| Business freeze periods | Are there any times when the business won't permit change? |         |
| Geographies | Are any geographies affected by this workload? |         |
| Sustainability | What [sustainability and cloud efficiency considerations](./plan-sustainability.md#identify-current-emissions) have been taken into account for this workload?|         |

### Technical inputs

| Data point | Description | Input |
|---|---|---|
| Adoption approach | Is this adoption a candidate for migration or innovation? |         |
| Application ops lead | List the parties responsible for the performance and availability of this workload. |         |
| SLAs | List any service-level agreements (RTO/RPO requirements). |         |
| Criticality | List the current application criticality. |         |
| Data classification | List the classification of data sensitivity. |         |
| Operating geographies | List any geographies in which the workload is or should be hosted. |         |
| Applications | Specify an initial list or count of any applications included in this workload. |         |
| VMs | Specify an initial list or count of any VMs or servers included in the workload. |         |
| Data sources | Specify an initial list or count of any data sources included in the workload. |         |
| Dependencies | List any asset dependencies not included in the workload. |         |
| User traffic geographies | List geographies with a significant collection of user traffic. |         |

## Confirm priorities

Based on the assembled data, the cloud strategy and adoption teams should meet to reevaluate priorities. Clarification of business data points might prompt changes in priorities. Technical complexity or dependencies might result in changes related to staffing allocations, timelines, or sequencing of technical efforts.

After a review, both teams should be comfortable with confirming the resulting priorities. This set of documented, validated, and confirmed priorities is the prioritized cloud adoption backlog.

## Next steps

For any workload in the prioritized cloud adoption backlog, the team is now ready to [align assets](./assets.md).

> [!div class="nextstepaction"]
> [Align assets for prioritized workloads](./assets.md)
