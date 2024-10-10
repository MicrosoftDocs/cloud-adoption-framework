---
title: Governance for AI workloads on Azure infrastructure
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Governance for AI workloads on Azure infrastructure

By following this guidance, you can establish robust governance, optimize spending, and ensure accountability in managing AI resources on Azure.
Follow these best practices for effective governance and cost management of AI resources on Azure:

## Resource governance

- *Tag AI resources.* Use tags to categorize resources by project, cost center, environment, and owner for better management and billing.
- *Apply governance policies to ensure compliance and standardization.* Use Azure Policy to enforce rules such as resource location, allowed SKUs, and mandatory tags. For example, create policies to restrict the deployment of certain high-cost VMs to control the budget.

## Cost management

- *Create and manage billing accounts.* Set up billing accounts in the Azure portal to monitor and control spending.
- *Utilize cost management features to set budgets and view spending patterns.* Use Azure Cost Management to establish budgets, track expenses, and analyze spending trends.
- *Generate and analyze billing reports.* Regularly review billing reports to gain insights into AI infrastructure spending. Share these reports with stakeholders to maintain transparency and accountability.
  
## Optimize resource usage

- *Implement autoscaling and scheduling.* Use autoscaling to automatically adjust resource allocation based on demand and schedule non-critical resources to shut down during off-hours to minimize costs.
- *Deallocate or shut down unused resources.* Review your resource usage and deallocate or shut down any idle or underutilized resources to avoid unnecessary costs.

### Cost alerts

- *Configure cost alerts.* Set up alerts to receive notifications when spending exceeds predefined thresholds. Use Azure Cost Management + Billing tools to create and manage these alerts.
  