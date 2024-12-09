---
title: Governance recommendations for AI workloads on Azure infrastructure (IaaS)
description: Learn how to govern AI workloads on Azure infrastructure (IaaS).
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Governance recommendations for AI workloads on Azure infrastructure (IaaS)

This article provides governance recommendations for organizations running AI workloads on Azure infrastructure (IaaS). These recommendations help organizations establish a structured framework for resource management, cost control, security, and operational efficiency. By following these practices, you can scale your AI workloads responsibly and ensure they meet compliance, security, and financial goals.

## Resource governance

Resource governance establishes rules and standards for managing Azure resources. By enforcing governance policies, organizations can ensure compliance, standardize resource use, and control costs, which support the responsible scaling of AI operations.

- *Enforce tag usage.* Use Azure Policy to enforce rules like resource location, allowed SKUs, and mandatory tags. For example, create policies to restrict the deployment of certain high-cost VMs, helping to manage budgets effectively.

- *Apply governance policies to ensure compliance and standardization.* Use Azure Policy to enforce rules such as resource location, allowed SKUs, and mandatory tags. For example, create policies to restrict the deployment of certain high-cost VMs to control the budget.

- *Use resource groups for lifecycle management.* Deploy AI resources within resource groups that share a common lifecycle. Resource groups allow you to deploy, configure, and delete resources collectively. They also provide extra governance (policy), security (RBAC), and cost (budget) boundaries.

- *Standardize naming conventions.* Implement a standardized naming convention for AI resources. This practice improves tracking and management. Use the [naming rules and restrictions for each Azure resource](/azure/azure-resource-manager/management/resource-name-rules) and follow the [recommended abbreviations](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations), as many resources often have name-length restrictions.

- *Govern infrastructure as code.* Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-devops-introduction) to monitor and enforce IaC security. This tool helps detect IaC misconfigurations and ensures secure deployments.

## Cost management

Cost management monitors and controls expenses related to AI workloads on Azure. Effective cost management enables organizations to set budgets, track spending, and maintain financial sustainability for AI projects.

- *Use tags to allocate costs.* Configure an Azure Policy definition to enforce tagging on resources. Use tags to categorize resources by project, cost center, environment, and owner for better management and billing.

- *Use tag inheritance.* Use [tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance) in Cost Management to apply billing, resource group, and subscription tags to child resource usage records.

- *Manage billing accounts.* Use [Microsoft Billing](/azure/cost-management-billing/cost-management-billing-overview) to oversee billing accounts and handle invoices. Assign a billing account to each AI project or team to facilitate accurate expense tracking.

- *Monitor costs.* Use [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management#monitor-costs-with-alerts) to set budget alerts, cost anomaly alerts, and scheduled alerts. Monitoring costs in this way helps organizations maintain financial discipline.

- *View spending patterns.* Use the Azure [Cost analysis](/azure/cost-management-billing/costs/quick-acm-cost-analysis) to tool to regularly review spending patterns. This process identifies trends and reveals areas for potential savings, especially in VM usage.

- *Allow specific virtual machine SKUs.* Use Azure policy to allow only the virtual machines SKUs that align with your AI budget. The built-in policy definition [*Allowed virtual machine SKUs*](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fcccc23c7-8427-4f53-ad12-b6a63eb452b3) can enforce this control.

- *Consider autoscaling.* Use a [virtual machine scale set](/azure/virtual-machine-scale-sets/overview) to dynamically adjust VM counts based on demand, optimizing costs.

- *Configure VM autoshutdown.* Use the [autoshutdown feature](/azure/virtual-machines/auto-shutdown-vm) to schedule VMs to shut down during off-hours, reducing unnecessary costs.

### Security governance

Security governance addresses the need for robust protection measures across AI workloads. By implementing security policies and access controls, organizations can protect sensitive data and resources. It reduces risk and supports a secure AI environment on Azure.

- *Integrate with Microsoft Entra ID.* Use Microsoft Entra ID for centralized identity management and single sign-on (SSO) capabilities across AI workloads.

- *Implement distinct access controls for each environment.* Limit each deployment pipeline’s identity to its designated environment, reducing the risk of accidental deployments.

- *Enable Azure Defender.* Activate Azure Defender for advanced threat protection. Azure Defender enhances security for workloads, including virtual machines, storage accounts, and databases, promoting a robust security posture for AI workloads.

### Operational governance

Operational governance ensures consistent monitoring and management of AI workloads. By using tools for monitoring, alerting, and automated deployments, organizations can maintain system health, detect issues early, and improve operational efficiency, contributing to reliable and stable AI operations.

- *Deploy monitoring agents.* Ensure that Azure Monitor agents are deployed by default for virtual machines, Azure Virtual Machine Scale Sets, and Azure Arc connected servers. Connect them to a central Log Analytics workspace within the management subscription.

- *Configure alerts.* Enable [recommended alert rules](https://azure.microsoft.com/services/monitor/autoscale) to receive notifications of metric deviations.

- *Use a CI/CD pipeline.* Implement [continuous integration and continuous delivery (CI/CD)](/azure/cloud-adoption-framework/ready/considerations/devops-principles-and-practices#define-your-devops-framework) to automate code testing and deployment to different environments.

## Next step

> [!div class="nextstepaction"]
> [Management IaaS AI](./management.md)
