---
title: Understand cloud operations functions
description: Learn how to establish cloud operations functions and staff your team to monitor, maintain, and optimize cloud workloads effectively.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.update-cycle: 1095-days
ms.topic: conceptual
ms.custom: internal, UpdateFrequency3
---

# Understand cloud operations functions

This article helps you establish cloud operations functions that monitor, maintain, and optimize your cloud workloads. Cloud operations teams ensure your applications and infrastructure run reliably while controlling costs and meeting performance expectations.

## Identify who provides cloud operations

Cloud operations functions require specific skills that your organization can source from various teams or partners. The cloud shifts many infrastructure responsibilities to the provider, which allows your operations teams to focus on higher-value activities.

You need to identify who provides these functions in your organization:

- **IT operations teams**: Traditional IT staff who adapt their skills to cloud technologies
- **Outsourced IT operations vendors**: Third-party providers who manage your cloud operations
- **Cloud service providers**: Native cloud provider services that handle operational tasks
- **Cloud-managed service providers**: Specialized partners who manage your entire cloud environment
- **Application-specific operations teams**: Teams dedicated to specific business applications
- **Business application operations teams**: Teams that manage line-of-business applications
- **DevOps teams**: Cross-functional teams that combine development and operations

> [!IMPORTANT]
> Cloud operations teams require elevated permissions to respond to incidents and optimize configurations. These teams make both reactive changes during incident response and proactive changes to prevent issues. You must implement strict [identity and access control best practices](/security/benchmark/azure/security-control-identity-access-control) to prevent unauthorized access or unintended production changes. Your chosen cloud operating model determines whether these changes happen through infrastructure-as-code, Azure Pipelines, or direct portal configuration.

## Prepare your team for cloud operations

Cloud operations teams need specific knowledge to succeed. Focus your preparation on the Azure adoption fundamentals and ongoing operational [skills](../plan/prepare-people-for-cloud.md#understand-the-cloud-skills-you-need)

## Define the scope of cloud operations

Your cloud operations team focuses on delivering maximum workload performance and minimum business interruptions within agreed-upon budgets. The team's core responsibilities include:

1. **Assess workload criticality**: Determine the business impact of disruptions or performance degradation for each workload.
2. **Establish service commitments**: Create business-approved agreements for cost and performance targets.
3. **Monitor and operate workloads**: Continuously track the health and performance of cloud workloads.

## Deliver cloud operations outcomes

Your cloud operations team must consistently deliver specific outcomes that support business objectives:

| Deliverable | Description |
|------------|-------------|
| Asset and workload inventory | Maintain an accurate, up-to-date catalog of all cloud resources and their dependencies |
| Performance monitoring | Track workload performance metrics against established baselines and SLAs |
| Operational compliance | Ensure all workloads meet regulatory and organizational compliance requirements |
| Workload protection | Implement and maintain security controls for workloads and associated assets |
| Incident recovery | Restore normal operations when performance degrades or business interruptions occur |
| Platform maturation | Continuously improve core platform capabilities and features |
| Performance optimization | Enhance workload performance through ongoing analysis and improvements |
| Cost optimization | Refine budgets and architectures to meet business commitments while controlling costs |

### Establish regular team meetings

Your cloud operations team needs regular touchpoints with other teams to ensure smooth operations:

- **Release planning sessions**: Participate in planning to understand upcoming changes and prepare operational support
- **Cloud center of excellence meetings**: Collaborate on standards and best practices that affect operations
- **Incident reviews**: Conduct post-incident reviews to identify improvement opportunities

## Understand what cloud operations excludes

Cloud providers handle many traditional IT operations tasks, which changes your team's focus. These activities now fall outside your cloud operations scope:

- **Physical infrastructure maintenance**: Cloud providers manage storage, CPU, memory, and network equipment
- **Server and host management**: Virtual machine hosts and physical servers become the provider's responsibility
- **Hardware monitoring and repair**: The provider handles hardware failures and replacements
- **Low-level technical operations**: Many routine maintenance tasks transfer to the cloud provider

This shift allows your team to focus on optimizing workload performance and business value rather than maintaining infrastructure.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Management | [Azure CLI](/cli/azure/) | Command-line interface for managing Azure resources programmatically |
| Management | [Azure portal](https://portal.azure.com) | Web-based interface for managing and monitoring Azure resources |
| Monitoring | [Azure Monitor](/azure/azure-monitor/) | Comprehensive solution for collecting, analyzing, and acting on telemetry |
| Networking | [Azure Network Watcher](/azure/network-watcher/) | Tools for monitoring, diagnosing, and gaining insights into network performance |
| Compliance | [Microsoft Defender for Cloud](/azure/defender-for-cloud/) | Security posture management and threat protection for cloud workloads |

## Next steps

As your cloud adoption scales, you need to establish governance practices and create a center of excellence to maintain consistency and quality across your cloud environment.

> [!div class="nextstepaction"]
> [Cloud center of excellence](./cloud-center-of-excellence.md)
