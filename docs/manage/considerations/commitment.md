---
title: Business commitment in cloud management
description: Calculate future returns from the classification and impact of interruptions to various workloads to make better business decisions and commitments.
author: martinekuan
ms.author: martinek
ms.date: 09/12/2024
ms.topic: conceptual
ms.custom: internal
---

# Business commitment in cloud management

A *business commitment* helps you define your level of operational management at an acceptable operating cost. To define a business commitment, you must balance priorities. This article describes how to evaluate data points and calculations to find that balance.

You can have commitments that are related to business stability that justify business decisions. Stability commitments can include service-level agreements (SLAs) or a certain level of technical resiliency. For most workloads, you need only a baseline level of cloud management. For other workloads, you might spend two to four times more on cloud management compared to a baseline level. You can justify this cost because of the potential impact of business interruptions.

The previous articles in this series can help you understand the classification and impact of interruptions to various workloads. This article helps you calculate the returns.

The following diagram shows that each level of cloud management has inflection points in which cost can rise faster than resiliency. Those inflection points prompt detailed business decisions and business commitments.

:::image type="content" source="../../_images/manage/business-commitment-scale.png" alt-text="Diagram that shows the balance of cost and resiliency." border="false":::

## Determine a proper commitment

For each workload in a portfolio, the cloud operations team and cloud strategy team should align on the level of management that the cloud operations team directly provides.

When your business establishes a commitment, determine how to align the following aspects.

- IT operations prerequisites
- Management responsibility
- Cloud tenancy
- Soft-cost factors
- Return on investment (ROI) loss avoidance
- Validation of the management level

To help you make decisions, the following sections describe these aspects in greater detail.

## Determine IT operations prerequisites

The [Azure Management Guide](../azure-management-guide/index.md) outlines Azure management tools. Before your business makes a commitment, IT should determine an acceptable standard-level management baseline to apply to all managed workloads. IT can then calculate a standard management cost for each of the managed workloads in the IT portfolio, based on CPU cores, disk space, and other asset-related variables. IT can also estimate a composite SLO for each workload, based on the architecture.

IT operations teams often use a default minimum of 99.9% uptime for the initial composite SLO. They might normalize management costs based on the average workload, especially for solutions that have minimal logging and storage needs. To provide a starting point for initial conversations, the IT operations team can average the costs of a few medium-criticality workloads.

> [!TIP]
> If you use the [operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) to plan for cloud management, you should update the operations management fields to reflect the IT operations prerequisites. The operations management fields include *Commitment level*, *Composite SLO*, and *Monthly cost*. The monthly cost should represent the cost of the operational management tools that you add on a monthly basis.

The operations management baseline serves as an initial starting point, and you should also validate the baseline with the following aspects.

## Choose a responsibility model

In a traditional on-premises environment, you might assume that the cost of managing the environment is a sunk cost for IT operations. A *sunk cost* is an expense that you can't recover. In the cloud, management is a purposeful decision that has a direct budgetary impact. You can directly attribute the costs of each management function to each workload that you deploy to the cloud. You have greater control with this approach. But the cloud operations teams and cloud strategy teams must first commit to an agreement about responsibilities.

Your business might also outsource some of your ongoing management functions to a [service provider](https://azure.microsoft.com/partners). Service providers can use [Azure Lighthouse](/azure/lighthouse/overview) to provide your business with precise control. For example, you can grant access to your resources and have greater visibility into the actions that service providers perform.

To manage your cloud environment, you can implement various models.

- **Delegated responsibility model:** IT operations can use an approach known as *delegated responsibility*. This approach doesn't require centralized management and prevents operational management overhead. In a cloud center of excellence (CCoE) model, platform operations and platform automation provide self-service management tools that business-led operations teams can use, independent of a centralized IT operations team. 

  This approach gives business stakeholders complete control over management-related budgets. The CCoE team can also ensure that a minimum set of guardrails is properly implemented. IT acts as a broker and a guide to help your business make wise decisions. Business operations oversee day-to-day operations of dependent workloads.

- **Centralized responsibility model:** Your business might require a *central IT team model* if you have compliance requirements, technical complexity, or some shared service models. In a central IT model, IT performs its operations management responsibilities.
 
  You might centrally manage and control environmental design, management controls, and governance tooling, which prevents business stakeholders from making management commitments. But the visibility into the cost and the architecture of the cloud approaches makes it easier for centralized IT to communicate the cost and level of management for each workload.

- **Mixed model:** Classification is the foundation of a *mixed model* of management responsibilities. If your business is in the process of transforming from on-premises to the cloud, you might require an on-premises-first operating model for some time. If your business has strict compliance requirements or depends on long-term contracts with IT outsourcing vendors, you might need a centralized operating model.

  A mixed-model approach provides balance. In this approach, a central IT team provides a centralized operating model for all workloads that are mission critical or contain sensitive information. The team places all other workload classifications in a cloud environment that supports delegated responsibilities. The centralized responsibility approach serves as the general operating model, but your business has flexibility to adopt a specialized operating model based on your required level of support and sensitivity.

Consider who is responsible for the day-to-day operations management for a workload. Your responsibility approach affects your commitments.

## Manage cloud tenancy

Typically, you can manage assets easier when they reside in a single tenant. But you might need to maintain multiple tenants. For more information about why you might require a multitenant Azure environment, see [Centralize management operations with Azure Lighthouse](../centralize-operations.md).

## Consider soft-cost factors

The next section outlines an approach to determine comparative returns that are associated with various levels of management processes and tooling. For each analyzed workload, you can measure the cost of management relative to the forecasted impact of business disruptions. Use the following method to determine if you need to invest in more extensive management approaches.

Before you calculate the numbers, consider the soft-cost factors. Soft-cost factors produce a return, but that return is difficult to measure through direct hard-cost savings that are visible in a profit-and-loss statement. Soft-cost factors can indicate a need to invest in a higher level of management than is fiscally prudent.

A few examples of soft-cost factors include:

- Daily workload usage by the board or CEO.

- Workload usage by the top *x%* of customers that leads to a greater revenue impact elsewhere.
- Impact on employee satisfaction.

To make a commitment, the next data point that you should evaluate is a list of soft-cost factors. You don't need to document these factors at this stage, but make business stakeholders aware of their importance and their exclusion from the following calculations.

## Calculate loss avoidance ROI

When the IT team that's responsible for cloud operations calculates the relative return on operations management costs, they should complete the previously mentioned prerequisites and assume a minimum level of management for all workloads.

The next commitment that your business should make is to accept the costs that are associated with the baseline-managed offering. Determine whether your business agrees to invest in the baseline offering to meet the minimum standards of cloud operations.

If your business doesn't agree to that level of management, you must create a solution so that your business can proceed. Ensure that your solution doesn't materially affect the cloud operations of other workloads.

You might want more than the standard management level. The following section helps validate that investment and the associated returns in the form of loss avoidance.

### Increase levels of management

For managed solutions, you can apply several design principles and template solutions in addition to the management baseline. Each design principle for reliability and resiliency adds operating cost to the workload. IT and your business must agree on these extra commitments, so you must understand potential losses that you can avoid when you implement more principles.

The following calculations provide formulas to help you better understand the differences between losses and increased management investments. For more information about calculating the cost of increased management, see [Workload automation](./workload.md) and [Platform automation](./platform.md).

> [!TIP]
> If you use the [operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) to plan for cloud management, update the operations management fields to reflect each conversation. These changes update the ROI formulas and each of the following fields.

#### Estimate outage

The composite service-level objective (SLO) is the SLA that's based on the deployment of each asset in the workload. The composite SLO field drives the *estimated outage*, which is labeled `Est. Outage` in the workbook. To calculate the estimated outage in hours per year without using the workbook, apply the following formula:

> *Estimated outage = (1 - composite SLO percentage) &#215; number of hours in a year*

The workbook uses the default value of *8,760 hours per year*.

#### Standard loss impact

The *standard loss impact* forecasts the financial impact of any outage, assuming that the *estimated outage* prediction proves accurate. The standard loss impact is labeled `Standard Impact` in the workbook. To calculate this forecast without using the workbook, apply the following formula:

> *Standard impact = estimated outage @ three 9s of uptime &#215; time-value impact*

The value serves as a baseline for cost if the business stakeholders invest in a higher level of management.

#### Composite-SLO impact

The *composite-SLO impact* provides the updated fiscal impact, based on the changes to the uptime SLA. Use this calculation to compare the projected financial impact of both options. The composite-SLO impact is labeled `Commitment level impact` in the workbook. To calculate this forecasted impact without the spreadsheet, apply the following formula:

> *Composite-SLO impact = estimated outage &#215; time-value impact*

The value represents the potential losses that the changed commitment level and the new composite SLO should prevent.

#### Comparison basis

The *Comparison basis* field evaluates the standard impact and composite-SLO impact to determine the amount of return in the *Annual ROI* field.

#### Return on loss avoidance

If the cost of managing a workload exceeds the potential losses, the proposed investment in cloud management might not be fruitful. To compare the *Return on loss avoidance*, see the column labeled `Annual ROI`. To calculate this column on your own, use the following formula:

> *Return on loss avoidance = (comparison basis - (monthly cost &#215; 12) ) &#247; (monthly cost &#215; 12)*

Unless you have other soft-cost factors to consider, this comparison can quickly determine if you need to invest more in cloud operations, resiliency, reliability, or other areas.

### Validate the commitment

At this point in the process, your business can make commitments, including centralized or delegated responsibility and Azure tenancy, and determine the level of commitment. You can validate and document each commitment to ensure that the cloud operations team, cloud strategy team, and business stakeholders align on these commitments to manage the workload.

## Next step

After you make commitments, the responsible operations teams can configure the workload in question. To get started, evaluate various approaches to inventory and visibility.

> [!div class="nextstepaction"]
> [Inventory and visibility options](./inventory.md)
