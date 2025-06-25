---
title: Create your initial Azure subscriptions to organize workloads
description: Learn how to create your first Azure subscriptions for production, non-production, and sandbox environments to establish a foundation for successful Azure adoption.
author: Zimmergren
ms.author: pnp
ms.date: 06/25/2025
ms.topic: conceptual
ms.custom: internal
---

# Create your initial Azure subscriptions to organize workloads

This article helps you create your Azure subscriptions based on your organization's initial requirements. Proper subscription organization creates a foundation for secure, scalable, and cost-effective Azure adoption.

## Create your initial subscriptions

Subscription boundaries provide clear separation between environments and reduce complexity while increasing security for your Azure workloads. You must create distinct environments to maintain quality and stability throughout the software development lifecycle. You must create at least two subscriptions to establish proper workload isolation. Here's how:

1. **Create a production subscription for live workloads.** This subscription hosts all applications and services that serve your customers or business operations. Production subscriptions require the highest levels of security, monitoring, and availability to ensure business continuity and meet service level agreements.

1. **Create a non-production subscription for controlled development and testing.** This subscription serves as your development, testing, and staging environment for applications. Use [Azure Dev/Test offers](https://azure.microsoft.com/pricing/dev-test/) to reduce costs while maintaining structured development processes with version control, code reviews, and deployment pipelines. Configure this subscription with more flexible policies to enable experimentation while maintaining security. You can place certain types of Azure resources in a non-production subscription for testing purposes. You can enable resource providers for these test resources in your non-production subscription without ever exposing them to your production environment.

1. **Create sandbox subscriptions for unstructured innovation and learning.** Sandbox subscriptions serve a different purpose than non-production subscriptions. Non-production subscriptions support structured development workflows with governance and controls that mirror production environments. Sandbox subscriptions provide isolated environments for unstructured experimentation and learning. You must create sandbox subscriptions when your organization needs spaces for proof-of-concepts, training, or exploring new Azure services without any constraints.These subscriptions allow individuals or teams to explore Azure capabilities, test proof-of-concepts, conduct training, or evaluate new services without following formal development processes. Use [Azure Dev/Test offers](https://azure.microsoft.com/pricing/dev-test/) to benefit from reduced pricing while encouraging innovation. Apply minimal governance to maximize experimentation freedom. Sandbox environments intentionally have fewer restrictions than non-production environments to enable rapid prototyping and learning. However, you still need basic security policies to prevent data exposure or unauthorized external access.

| Aspect | Non-production | Sandbox |
|--------|---------------|---------|
| **Purpose** | Structured development and testing | Unstructured experimentation and learning |
| **Governance** | Mirrors production policies | Minimal policies for safety |
| **Process** | Follows development workflows | No formal processes required |
| **Resource lifecycle** | Managed through deployment pipelines | Created and deleted as needed |
| **Data handling** | May contain production-like data | Should not contain sensitive data |
| **Access control** | Role-based with approval processes | Individual or team-based access |
| **Budget control** | Structured budget with approvals | Small budgets with automatic limits |

## Scale your subscriptions

Scaling your subscriptions ensures your Azure environment can support growing workloads, maintain performance, and meet organizational needs. As your cloud adoption matures, you need additional subscriptions to accommodate increased resource demands, enforce governance, or optimize costs. This section provides guidance on when and how to scale your subscriptions effectively.

## Implement governance for subscription creation

Standardized subscription creation prevents configuration drift and ensures consistent governance across your Azure environment. Automated subscription provisioning reduces manual errors and accelerates deployment timelines while maintaining control. You must establish clear processes for subscription creation to maintain organizational standards and prevent subscription sprawl. Here's how:

1. **Define subscription creation responsibilities and approval workflows.** Identify who can request new subscriptions, who approves requests, and who creates them to maintain proper governance and prevent unauthorized subscription creation that can lead to cost overruns and security gaps.

1. **Create subscription templates with standard configurations.** Define which resource types are available in each subscription type by default and establish what all standard subscriptions should include. Create consistent patterns for Azure role-based access control, policies, tags, and baseline resources that all new subscriptions should receive to ensure compliance and reduce configuration overhead.

1. **Implement programmatic subscription creation for Enterprise Agreement customers.** Use [service principals with proper permissions](/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement) to automate subscription creation through approved workflows, which provides better control and audit trails than manual processes while ensuring consistency.

1. **Request non-EA subscription blocking for Enterprise Agreement customers.** Contact Azure Support to prevent creation of non-Enterprise Agreement subscriptions in your organization to maintain billing consistency and governance control across all Azure resources.

1. **Consider cross-subscription networking costs in your architecture.** Data transfer between subscriptions incurs additional charges that can significantly impact your budget over time. Plan your network architecture to minimize unnecessary data movement between subscriptions and optimize costs by keeping related resources within the same subscription boundary when possible.

1. **Plan for Classic deployment model resource isolation.** Legacy resources created with the classic deployment model cannot use Azure policies, role-based access control, resource grouping, or tags effectively. Move these resources to dedicated subscriptions to avoid management complications and enable proper governance of modern Azure Resource Manager resources. For more information, see [Move Azure resources to another resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

### Monitor subscription constraints

Technical constraints often necessitate new subscriptions to maintain service availability and performance. Subscription limits affect resource deployment and require proactive planning to avoid service disruptions. You must monitor usage and create additional subscriptions when approaching resource limits to ensure continuous operations. Here's how:

1. **Monitor subscription quotas and limits.** Azure subscriptions have defined limits for different resource types that can affect your ability to deploy new resources. Track usage patterns to identify when you need additional subscriptions before hitting limits that could disrupt operations. For more information, see [Azure subscription limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits#general-limits).

1. **Create subscriptions for shared platform services.** This subscription hosts resources like domain controllers, DNS servers, or connectivity monitoring systems that multiple environments require. Centralized shared services reduce duplication and simplify management across your Azure environment. The shared services subscription should align with your organization's long-term Azure strategy and provide the foundation for scaling your cloud environment effectively while maintaining consistent security and governance standards.

## Azure resources

| Category | Tool | Description |
|----------|------|-------------|
| Subscription Management | [Azure portal subscriptions](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade) | Create and manage Azure subscriptions with role-based access control |
| Cost Management | [Azure Cost Management](https://learn.microsoft.com/azure/cost-management-billing/) | Track and optimize spending across multiple subscriptions with budgets and alerts |
| Cost Optimization | [Azure Dev/Test offers](https://azure.microsoft.com/pricing/dev-test/) | Reduce costs for non-production and sandbox environments with discounted pricing |
| Governance | [Azure management groups](https://learn.microsoft.com/azure/governance/management-groups/) | Organize subscriptions hierarchically for policy and access management at scale |
| Policy Enforcement | [Azure Policy](https://learn.microsoft.com/azure/governance/policy/) | Enforce organizational standards and compliance requirements across subscriptions |
| Resource Organization | [Azure Resource Graph](https://learn.microsoft.com/azure/governance/resource-graph/) | Query and discover resources across multiple subscriptions for management and compliance |

## Next steps

> [!div class="nextstepaction"]
> [Scale your Azure environment with additional subscriptions](./scale-subscriptions.md)