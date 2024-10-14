---
title: Governance for AI workloads on Azure infrastructure
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Governance for AI workloads on Azure infrastructure

This guidance provides governance recommendations specific to AI workloads on Azure’s Infrastructure as a Service (IaaS). These recommendations help organizations manage AI resources by focusing on compliance, cost control, and accountability. For broader AI governance on Azure, refer to [Govern AI](../govern.md).

## Resource governance

Resource governance involves setting rules and standards for managing Azure resources. Organizations can ensure compliance, standardize resource use, and control costs by enforcing these governance policies, which helps in scaling AI operations responsibly.

- *Tag AI resources.* Use tags to categorize resources by project, cost center, environment, and owner for better management and billing.
- *Apply governance policies to ensure compliance and standardization.* Use Azure Policy to enforce rules such as resource location, allowed SKUs, and mandatory tags. For example, create policies to restrict the deployment of certain high-cost VMs to control the budget.

## Cost management

Cost management focuses on monitoring and controlling expenses associated with AI workloads on Azure. This is important because it enables organizations to set budgets, track spending, and stay within financial limits, ensuring that AI projects remain sustainable.

- *Create and manage billing accounts.* Set up billing accounts in the Azure portal to monitor and control spending.
- *Utilize cost management features to set budgets and view spending patterns.* Use Azure Cost Management to establish budgets, track expenses, and analyze spending trends.
- *Generate and analyze billing reports.* Regularly review billing reports to gain insights into AI infrastructure spending. Share these reports with stakeholders to maintain transparency and accountability.
- *Configure cost alerts.* Set up alerts to receive notifications when spending exceeds predefined thresholds. Use Azure Cost Management + Billing tools to create and manage these alerts.
  
## Optimize resource usage

Optimizing resource usage involves using Azure tools to adjust resource allocation based on demand. By doing so, organizations can minimize costs, reduce waste, and improve the efficiency of their AI workloads, making them more cost-effective and environmentally friendly.

- *Implement autoscaling and scheduling.* Use autoscaling to automatically adjust resource allocation based on demand and schedule non-critical resources to shut down during off-hours to minimize costs.
- *Deallocate or shut down unused resources.* Review your resource usage and deallocate or shut down any idle or underutilized resources to avoid unnecessary costs.

## Next step

> [!div class="nextstepaction"]
> [IaaS AI management](./management.md)
