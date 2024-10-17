---
title: Governance recommendations for AI workloads on Azure infrastructure (IaaS)
description: Learn how to govern AI workloads on Azure infrastructure (IaaS)
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Governance recommendations for AI workloads on Azure infrastructure (IaaS)

This article provides recommendations for governing AI workloads using Azure infrastructure as a service (IaaS). For broader AI governance on Azure, refer to [Govern AI](../govern.md).

## Resource governance

Resource governance involves setting rules and standards for managing Azure resources. Organizations can ensure compliance, standardize resource use, and control costs by enforcing these governance policies, which helps in scaling AI operations responsibly.

- *Enforce tag usage.* Use Azure policy to enforce tags for resource tracking to avoid orphaned resources. Use tags to categorize resources by project, cost center, environment, and owner for better management and billing.

- *Apply governance policies to ensure compliance and standardization.* Use Azure Policy to enforce rules such as resource location, allowed SKUs, and mandatory tags. For example, create policies to restrict the deployment of certain high-cost VMs to control the budget.

- *Use resource groups for resources that share a common lifecycle.* Deploy AI resources to resource groups that you can deploy, configure, and delete together. Resource groups also provide additional governance (policy), security (RBAC), and cost (budget) boundaries.

- *Standardize naming conventions.* Use a standard naming convention for AI resources so you can easily track AI resources. Use the [naming rules and restrictions for each Azure resource](/azure/azure-resource-manager/management/resource-name-rules) to develop resource names. Apply the [recommended abbreviations](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) since resources often have name-length restrictions.

- *Govern infrastructure as code.* Govern IaC templates by using [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-devops-introduction) to Detect IaC misconfigurations and enforce secure deployments.

## Cost management

Cost management focuses on monitoring and controlling expenses associated with AI workloads on Azure. This is important because it enables organizations to set budgets, track spending, and stay within financial limits, ensuring that AI projects remain sustainable.

- *Use tags to allocate costs.* Configure an Azure Policy definition to enforce tagging on resources. Use tags to categorize resources by project, cost center, environment, and owner for better management and billing.

- *Use tag inheritance.* Use the [tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance) setting in Cost Management. When enabled, tag inheritance applies billing, resource group, and subscription tags to child resource usage records.

- *Manage billing accounts.* Use [Microsoft Billing](/azure/cost-management-billing/cost-management-billing-overview) to manage your billing account and pay invoices. Ensure each AI project or team has a designated billing account to accurately track expenses.

- *Monitor costs.* Use [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management#monitor-costs-with-alerts) to set budget alerts, cost anomaly alerts, and scheduled alerts for different AI projects. This helps in tracking spending against allocated budgets and maintaining financial discipline.

- *View spending patterns.* Use the Azure [Cost analysis](/azure/cost-management-billing/costs/quick-acm-cost-analysis) to tool to regularly review spending patterns to identify trends and areas for potential savings in VM usage.

- *Allow specific virtual machine SKUs.* Use Azure policy to allow only the virtual machines SKUs that align with your AI budget. The built-in policy definition [*Allowed virtual machine SKUs*](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fcccc23c7-8427-4f53-ad12-b6a63eb452b3) in Azure policy to allow the deployment of only the SKUs you need.

- *Consider autoscaling.* Use a [virtual machine scale set](/azure/virtual-machine-scale-sets/overview) to add or remove virtual machine count to match demand and optimize cost.

- *Configure VM auto-shutdown.* Use the [auto-shutdown feature](/azure/virtual-machines/auto-shutdown-vm) in Azure to shut down the VMs during off hours when they aren't needed and automatically restart them when they're needed again.

### Security governance

Security governance addresses the need for robust protection measures across AI workloads. By implementing security policies and access controls, organizations can protect sensitive data and resources, which reduces risks and supports a secure AI environment on Azure.

- *Integrate with Entra ID.* Use Entra ID for centralized identity management and single sign-on (SSO) capabilities in your AI workloads.

- *Implement distinct access controls for each environment.* Protect resources from accidental deployments by limiting each deployment pipeline's identity to its specific environment.

- *Activate Azure Defender.* Enable Azure Defender to provide advanced threat protection for your workloads, including virtual machines, storage accounts, and databases. This will help ensure a robust security posture for your AI workloads on Azure Virtual Machines.

### Operational governance

Operational governance ensures that organizations monitor and manage their AI workloads consistently. With tools for monitoring, alerting, and automated deployments, organizations can maintain system health, detect issues early, and improve operational efficiency, which contributes to stable and reliable AI operations.

- *Ensure monitoring by default.* Deploy the required Azure Monitor agents for virtual machines and Azure Virtual Machine Scale Sets, including Azure Arc connected servers. Connect them to the central Log Analytics workspace in the management subscription.

- *Configure alerts.* Enable [recommended alert rules](https://azure.microsoft.com/services/monitor/autoscale) to receive notifications of metric deviations.

- *Use a CI/CD pipeline.* Implement [continuous integration and continuous delivery (CI/CD)](/azure/cloud-adoption-framework/ready/considerations/devops-principles-and-practices#define-your-devops-framework) to automate code testing and deployment to different environments.

## Next step

> [!div class="nextstepaction"]
> [IaaS AI management](./management.md)