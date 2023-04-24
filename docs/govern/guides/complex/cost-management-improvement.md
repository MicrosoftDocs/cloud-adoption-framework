---
title: 'Complex enterprise governance: Improve the Cost Management discipline'
description: Learn how to use the Cloud Adoption Framework for Azure to add cost controls to a complex governance minimum viable product (MVP).
author: martinekuan
ms.author: martinek
ms.date: 09/05/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal, UpdateFrequency2
---

# Governance guide for complex enterprises: Improve the Cost Management discipline

This article advances the narrative by adding cost controls to the minimum viable product (MVP) governance.

## Advancing the narrative

Adoption has grown beyond the tolerance indicator defined in the governance MVP. The increased spending now justifies an investment of time from the cloud governance team to monitor and control spending patterns.

As a clear driver of innovation, IT is no longer seen primarily as a cost center. As the IT organization delivers more value, the CIO and CFO agree that the time is right to shift the role IT plays in the company. Among other changes, the CFO wants to test a direct pay approach to cloud accounting for the Canadian branch of one of the business units. One of the two retired datacenters exclusively hosted assets for that business unit's Canadian operations. In this model, the business unit's Canadian subsidiary is billed directly for the operating expenses related to the hosted assets. This model allows IT to focus less on managing someone else's spending and more on creating value. Before this transition can begin, cost management tooling needs to be in place.

### Changes in the current state

In the previous phase of this narrative, the IT team actively moved production workloads with protected data into Azure.

Since then, some things have changed that affect governance:

- 5,000 assets have been removed from the two datacenters flagged for retirement. Procurement and IT security are now deprovisioning the remaining physical assets.
- The application development teams have implemented CI/CD pipelines to deploy some cloud-native applications, which significantly affects customer experiences.
- The BI team has created aggregation, curation, insight, and prediction processes that drive tangible benefits for business operations. Those predictions empower creative new products and services.

### Incrementally improve the future state

Cost monitoring and reporting should be added to the cloud solution. Reporting should tie direct operating expenses to the functions that are consuming the cloud costs. Other reporting should allow IT to monitor spending and provide technical guidance on cost management. For the Canadian branch, the department is billed directly.

## Changes in risk

**Budget control:** There's an inherent risk that self-service capabilities result in excessive and unexpected costs on the new platform. Governance processes to monitor costs and mitigate ongoing cost risks must be in place to ensure continued alignment with the planned budget.

This business risk can be expanded into a few technical risks:

- There's a risk of actual costs exceeding the plan.
- Business conditions change. When they do, there are cases when a business function needs to consume more cloud services than expected, which leads to spending anomalies. There's a risk that these added costs are considered overages as opposed to a required adjustment to the plan. If successful, the Canadian experiment should help remediate this risk.
- There's a risk of systems being overprovisioned, which results in excess spending.

## Changes to the policy statements

The following changes to policy help remediate the new risks and guide implementation.

- On a weekly basis, the cloud governance team should monitor cloud costs against plan. Monthly, share the reported deviations between cloud costs and plan with IT leadership and finance. Review cloud costs and plan updates with IT leadership and finance monthly.
- Allocate costs to a business function for accountability purposes.
- Continually monitor cloud assets for optimization opportunities.
- Cloud governance tooling must limit asset sizing options to an approved list of configurations. The tooling must ensure that all assets are discoverable and tracked by the cost monitoring solution.
- During deployment planning, document the required cloud resources that are associated with the hosting of production workloads. This documentation helps refine budgets and prepare other automation tools to prevent the use of more expensive options. During this process, consider different discounting tools offered by the cloud provider, such as Azure Reserved VM Instances or license cost reductions.
- All application owners are required to attend training on practices for optimizing workloads to better control cloud costs.

## Incremental improvement of best practices

This section of the article improves the governance MVP design to include new Azure policies and an implementation of Azure Cost Management + Billing. Together, these two design changes fulfill the new corporate policy statements.

1. Make changes in the Azure EA portal to bill the department administrator for the Canadian deployment.
2. Implement Azure Cost Management + Billing.
    1. Establish the right level of access scope to align with the subscription pattern and resource grouping pattern. Assuming the alignment with the governance MVP that's defined in prior articles, this action requires **enrollment account scope** access for the cloud governance team executing on high-level reporting. Other teams outside of governance, like the Canadian procurement team, require **resource group scope** access.
    2. Establish a budget in Azure Cost Management + Billing.
    3. Review and act on initial recommendations. Create a recurring process to support the reporting process.
    4. Configure and execute Azure Cost Management + Billing reporting, both initial and recurring.
3. Update Azure Policy.
    1. Audit tagging, management group, subscription, and resource group values to identify any deviation.
    2. Establish SKU size options to limit deployments to SKUs listed in the deployment planning documentation.

## Conclusion

When you add the processes and changes in this article to the governance MVP, it helps remediate many of the risks that are associated with cost governance. Together, they create the visibility, accountability, and optimization that's needed to control costs.

## Next steps

As cloud adoption grows and delivers added business value, risks and cloud governance needs change. For this fictional company, the next step is to use this governance investment to manage multiple clouds.

> [!div class="nextstepaction"]
> [Multicloud improvement](./multicloud-improvement.md)
