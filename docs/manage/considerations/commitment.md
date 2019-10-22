---
title: "Business criticality - Cloud Management and Operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Business criticality - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Business commitment in cloud management

Defining a business commitment is an exercise in balancing priorities. The objective is to align the proper level of operational management at an acceptable operating cost. Finding that balance requires a few data points and calculations, outlined in the following sections.

![Balance cost and resiliency](../../_images/manage/business-commitment-scale.png)

Commitments to business stability (via technical resiliency or other SLA impacts) are a business justification decision. For most workloads in an environment, a baseline level of cloud management is sufficient. For others, a 2&ndash;4x cost increase is easily justified because of the potential impact of any business interruptions. The prior articles in this series aid in understanding the classification and impact of interruptions to various workloads. This article will aid in calculating the returns. As outlined in the following image, at each level of cloud management there are inflection points where cost can rise faster than increases in resiliency. Those inflection points will prompt detailed business decisions and business commitments.

## Determining a proper commitment with the business

For each workload in the portfolio, the cloud operations team and cloud strategy team should align on the level of management provided directly by the cloud operations team.

The follow are key aspects to align when establishing a commitment with the business:

- IT operations prerequisites
- Management responsibility
- Cloud tenancy
- Soft-cost factors
- Loss avoidance ROI
- Validate management level

The remainder of this article will outline each of these criteria to aid in making a decision.

## IT operations prerequisites

The [Azure Management Guide](../azure-management-guide/index.md) outlines the management tools available in Azure. Prior to reaching a commitment with the business, IT should determine an acceptable standard level management baseline to be applied to all managed workloads. IT would then calculate a standard management cost for each of the managed workloads in the IT portfolio, based on counts of CPU cores, disk space, and other asset-related variables. IT would also estimate a composite SLA for each workload based on the architecture.

> [!TIP]
> IT operations teams will often use a default minimum of 99.9% uptime for the initial composite SLA. They may also choose to normalize management costs based on the average workload, especially for solutions with minimal logging and storage needs. Averaging the costs of a few medium criticality workloads can provide a starting point for initial conversations.

> [!TIP]
> For readers who are using the [Ops Management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) to plan for cloud management, the Ops management fields should be updated to reflect these pre-requisites. Those fields include Commitment level, Composite SLA, and Monthly Cost. Monthly cost should represent the cost of the added operational management tools on a monthly basis.

The operations management baseline will serve as an initial starting point to be validated in each of the following sections.

## Management responsibility

In a traditional on-premises environment, the cost of managing the environment is commonly assumed to be a sunk cost owned by IT operations. In the cloud, management is a purposeful decision with direct budgetary impact. The costs of each management function can be more directly attributed to each workload deployed to the cloud. This approach allows for greater control, but it does create a requirement for cloud operations teams and cloud strategy teams to first commit to an agreement regarding responsibilities.

Organizations may also choose to [outsource some of their ongoing management functions to a service provider](https://www.microsoft.com/cloud-adoption-framework-offers?ot=manage). These service providers can use [Azure Lighthouse](https://azure.com/lighthouse) to provide greater precision and transparency.

**Delegated responsibility:** Since there is no need to centralize and assume operational management overhead, IT operations for many organizations are considering new approaches. One common approach is referred to as delegated responsibility. In a cloud center of excellence model, platform operations and platform automation provide self-service management tools that can be leveraged by business-led operations teams, independent of a central IT operations team. This approach provides the business stakeholders with complete control over management-related budgets. It also allows the CCoE to ensure that a minimum set of guardrails are properly implemented. In this model, IT acts as a broker and a guide to help the business make wise decisions. Business operations oversee day to day operations of dependent workloads.

**Centralized responsibility:** Compliance requirements, technical complexity, and some shared service models may require a Central IT model. In this model, IT continues to maintain operations management responsibilities. As such, environmental design, management controls, and governance tooling may be centrally managed and controlled, which restricts the role of the business stakeholders when making management commitments. But, the cost and architecture visibility of cloud approaches make it much easier for centralized IT to communicate the cost and level of management for each workload.

**Mixed model:** Classification is at the heart of a mixed model to management responsibilities. Companies who are in the midst of a transformation from on-premises to cloud may require an on-premises-first operating model for a while. Other companies that have strict compliance requirements or depend on long-term contracts with IT outsourcing vendors, may require a centralized operating model. In spite of these types of constraints, businesses have a need to innovate. When rapid innovation must flourish, in the midst of a central-IT centralized-responsibility model, classification and a mixed model may provide balance. In this approach, Central IT provides a centralized operating model for all workloads that are mission critical or contain sensitive information. However, all other classifications of workload may be placed in a cloud environment designed for delegated responsibilities. The centralized responsibility approach serves as the general operating model. The business then has flexibility to leverage a specialized operating model, based on required level of support and sensitivity.

The first step is committing to a responsibility approach, which will shape the following commitments.

**Which organization will be responsible for day to day operations management for this workload?**

## Cloud tenancy

For most businesses, management is easier when all assets reside in a single tenant. However, some organizations may need to maintain multiple tenants. The article on [centralizing management operations with Azure Lighthouse](../centralize-operations.md) provides a few examples where businesses may require multi-tenant Azure environments.

**Will this workload reside in a single Azure tenant, alongside all other workloads?**

## Soft-cost factors

The next section of this article outlines an approach to comparative returns associated with levels of management processes and tooling. At the end of that section, each workload analyzed will measure the cost of management relative to the forecasted impact of business disruptions. That approach will provide a relatively easy way to understand if the investment in richer management approaches is warranted.

Before running the numbers, it's important to look at the soft-cost factors. Soft-cost factors produce a return, but that return is difficult to measure through direct hard-cost savings that would be visible in a profit and loss statement. Soft-cost factors are important because they can indicate a need to invest in a higher level of management than is fiscally prudent.

A few examples of these factors would include:

- Daily use a workload by the board or CEO.
- Usage of a workload by top _x%_ of customers that leads to higher revenue impact elsewhere.
- Impact on employee satisfaction.

The next data point required to make a commitment is a list of soft-cost factors. These don't need to be documented at this stage, but the business stakeholder should be aware of the importance of these factors and their exclusion from the following calculations.

## Calculate loss avoidance ROI

When calculating the relative return on operations management costs, the IT team responsible for Cloud Operations should complete the prerequisites above and assume a minimum level of management for all workloads.

The next commitment to be made is an acceptance by the business of the costs associated with the baseline-managed offering.

**Does the business agree to invest in the baseline offering to meet minimum standards of cloud operations?**

If the business does not agree to that level of management, a solution must be devised which allows the business to proceed, without materially affecting cloud operations of other workloads.

If the business wants more than the standard level, then the remainder of this section will help validate that investment and the associated returns (in the form of loss avoidance).

### Increased levels of management: Design principles and service catalog

For managed solutions, there are several design principles and template solutions that can be applied in addition to the management baseline. Each of the design principles for reliability and resiliency adds operating cost to the workload. For IT and the business to agree on these additional commitments, it's important to understand potential losses that can be avoided through that increased investment.

The following calculations will walk through formulas to better understand the comparison between losses and increased management investments. For guidance on calculating the cost of increased management, see the articles on [Workload automation](./workload.md) and [Platform automation](./platform.md).

> [!TIP]
> For readers who are using the [Ops Management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) to plan for cloud management, the Ops management fields should be updated to reflect to reflect each conversation. Those fields include Commitment level, Composite SLA, and Monthly Cost. Monthly cost should represent the cost of the added operational management tools on a monthly basis. Once updated, those fields will update the ROI formulas and each of the following fields.

### Estimate outage (hours per year)

The "Composite SLA" is the service level agreement based on the deployment of each asset in the workload. That field will drive "Estimated Outage" (labeled Est. Outage*** in the workbook). To calculate estimated outage in hours per year without using the workbook, apply the following formula:

**Estimated outage = (1 - Composite SLA percentage) /* Number of hours in a year**

In the workbook, the default value of 8,760 hours per year is used.

### Standard loss impact

Standard loss impact (titled "Standard impact" in the workbook) forecasts the financial impact of any outage, assuming the "Estimated outage" prediction proves accurate. To calculate this forecast without using the workbook, apply the following formula:

**Standard Impact = Estimated outage @ three 9's of uptime /* Time/Value Impact**

This serves as a baseline for cost, should the business stakeholders choose to invest in a higher level of management.

### Composite SLA impact

Composite SLA impact (titled "Commitment level impact" in the workbook) provides updated fiscal impact, based on the changes to the uptime SLA. This allows you to compare the projected financial impact of both options. To calculate this forecasted impact without the spreadsheet, apply the following formula.

**Composite SLA impact = Estimated outage /* Time/Value impact**

The value represents the potential losses to be avoided by the changed commitment level and new composite SLA.

### Comparison basis

Comparison basis evaluates Standard Impact and Composite SLA Impact to determine which is most appropriate in the return column.

### Return on loss avoidance

If the cost of managing a workload exceeds the potential losses, then the proposed investment in cloud management may not be fruitful. To compare the "Return on Loss Avoidance", see the column labeled "Annual ROI****". To calculate this column on your own, use this formula:

**Return on Loss Avoidance = (Comparison basis - (Monthly cost /* 12)) // (Monthly cost /* 12))**

Unless there are other soft-cost factors to consider, this comparison can quickly suggest if there should be a deeper investment in cloud operations, resiliency, reliability, or other areas.

## Validate the commitment

By this point in the process, commitments have been made: centralized or delegated responsibility, Azure tenancy, and level of commitment.
Each commitment should be validated and documented to ensure that the cloud operations team, the cloud strategy team, and the business stakeholders are aligned on this commitment to manage the workload.

## Next steps

Once commitments are made, the responsible operations teams can begin configuration for the workload in question. To get started, evaluate various approaches to [inventory and visibility](./inventory.md).

> [!div class="nextstepaction"]
> [Inventory and visibility options](./inventory.md)
