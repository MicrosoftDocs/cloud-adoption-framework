---
title: Manage modern application platform solutions for optimal performance and reliability
description: Learn how to establish operations management for containerized workloads and Azure Kubernetes Service clusters to ensure optimal performance, security, and cost efficiency.
author: stephen-sumner
ms.author: pnp
ms.date: 06/19/2025
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# Manage modern application platform solutions for optimal performance and reliability

This article helps you establish operations management for containerized workloads and Azure Kubernetes Service (AKS) clusters. Proper operations management ensures your modern application platforms deliver optimal performance, security, and cost efficiency while maintaining high availability for your business-critical applications.

## Align your business needs with operations management

Containers improve resource utilization, enable faster deployments, and simplify scaling. Operations management must integrate container-specific practices with existing cloud strategies to achieve these benefits. Here's how:

1. **Define operations ownership.** Decide whether centralized teams manage container platforms while workload teams handle applications, or adopt a decentralized approach. Consider technology diversity, team expertise, business criticality, and security requirements.

1. **Evaluate state management.** Identify whether applications are stateless or require persistent data. Stateless apps simplify operations, while stateful apps need specialized storage and backup strategies.

## Implement platform operations

Platform operations extend your operations baseline with container-specific management capabilities. Platform operations provide the specialized tools and processes needed to manage AKS clusters and containerized workloads effectively. You need to implement platform operations unless containers represent your organization's first cloud deployment.

### Monitor inventory and ensure visibility

Container environments require specialized monitoring configurations to capture unique monitoring data. Standard operations tools must extend to support container-specific metrics and analysis. You need comprehensive visibility into cluster health, workload performance, and resource utilization to ensure optimal operations. Here's how:

1. **Deploy Azure Monitor for containers to collect comprehensive telemetry.** Azure Monitor for containers provides the foundation for container operations monitoring. This solution captures critical operational data that platform teams need for infrastructure management and workload teams require for application optimization. Configure [Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview) to monitor these essential areas:

    - Cluster topology and resource utilization across regions
    - Node pool configurations, networking, and storage architectures
    - AKS version and node image compliance status
    - CPU, memory, and storage utilization at cluster and container levels
    - Workload behavior under normal and peak load conditions
    - Automated alerting for threshold breaches and health state changes

1. **Configure standardized queries and dashboards for operational consistency.** Standardized monitoring approaches reduce operational complexity and ensure consistent visibility across teams. You must establish common monitoring patterns that both platform and workload teams can use effectively. Configure [Azure Monitor queries](/azure/azure-monitor/containers/container-insights-log-query) to create standardized dashboards and alerts that align with your operational model and service level agreements.

1. **Integrate application-specific metrics through Prometheus collection.** Application metrics provide insights that infrastructure monitoring can't capture. You need application-level monitoring to understand workload behavior and optimize performance effectively. Integrate with [Prometheus](/azure/azure-monitor/containers/container-insights-prometheus-integration) to collect custom application metrics and combine them with infrastructure data for comprehensive observability across your container platform.

1. **Extend monitoring coverage to hybrid and multicloud environments.** Consistent monitoring across all container platforms simplifies operations and reduces management overhead. You must maintain unified visibility regardless of where your containers run to ensure operational consistency. Extend monitoring to include AKS Engine on-premises, Azure Red Hat OpenShift, and Azure Arc-enabled Kubernetes clusters for comprehensive visibility across your entire container portfolio.

### Maintain operations compliance

Operations compliance in containerized environments requires management at multiple levels: AKS clusters, node images, and node operating systems. Operations compliance ensures security, performance, and supportability through regular updates and patches. You must determine whether centralized teams or workload teams handle these responsibilities based on your operational model.

Operations teams monitor usage patterns, resize resources to balance performance and cost, and apply patches to minimize security risks and configuration drift. The complexity of container operations requires clear ownership models and well-defined processes.

1. **Evaluate operations ownership models for your environment.** Operations ownership affects update frequency, testing procedures, and incident response. You need to choose an ownership model that aligns with your team structure and business requirements. Consider these approaches:

   - Workload team ownership provides granular control and faster updates but requires more team expertise
   - Centralized ownership offers standardization and cost efficiency but reduces flexibility and responsiveness

2. **Implement systematic upgrade and maintenance procedures.** Regular maintenance prevents security vulnerabilities and ensures platform supportability. You must establish scheduled maintenance windows and testing procedures to minimize business impact. Follow these Azure-specific procedures:

   - [Upgrade AKS clusters](/azure/aks/upgrade-cluster) using blue-green or rolling update strategies
   - [Upgrade node images](/azure/aks/node-image-upgrade) to include latest security patches
   - [Process node OS updates](/azure/aks/node-updates-kured) using automated tools like Kured
   - Apply [patching and upgrade best practices](/azure/architecture/operator-guides/aks/aks-upgrade-practices) for enterprise environments

3. **Establish risk management procedures for multitenant clusters.** Multitenant clusters require careful coordination between teams and thorough testing procedures. You need contingency plans for workloads that can't support cluster upgrades and clear communication channels for maintenance activities. Test all upgrades in preproduction environments and maintain detailed rollback procedures.

### Protect and recover workloads

AKS nodes are ephemeral and designed for replacement rather than individual restoration. Recovery operations focus on workload redeployment and data restoration rather than infrastructure repair. You must design protection and recovery strategies that account for the ephemeral nature of container infrastructure while ensuring business continuity. Here's how:

1. **Implement service level agreements and availability measures.** Service level agreements define your recovery objectives and determine your protection investments. You need to establish service level agreements (SLAs) that balance business requirements with operational costs. Consider these protection levels:

   - Add an [uptime SLA to your cluster](/azure/aks/uptime-sla) for improved availability guarantees
   - Implement [multiregion BCDR best practices](/azure/aks/operator-best-practices-multi-region) for mission-critical workloads
   - Design appropriate redundancy and failover mechanisms based on workload criticality

2. **Establish data protection and state management procedures.** Data protection requirements vary significantly between stateless and stateful applications. You must identify applications that require persistent state and implement appropriate backup and recovery mechanisms. Follow these approaches:
   - Use your existing operations baseline guidance for external state restoration
   - Implement [storage best practices](/azure/aks/operator-best-practices-storage) for applications that require persistent state
   - Establish procedures to [back up and restore persistent data](/azure/aks/operator-best-practices-storage#secure-and-back-up-your-data) for stateful workloads
   - Consider platform-specific tools like [Velero](https://github.com/vmware-tanzu/velero) for comprehensive backup and recovery

3. **Standardize recovery toolchains across your portfolio.** Inconsistent recovery approaches increase operational complexity and costs. You must choose a standardized recovery approach for all containerized workloads to reduce management overhead. If applications can't conform to the standard recovery approach, shift the responsibility for alternative solutions to workload teams while providing clear guidance and support.

## Design workload operations

Workload operations address the fundamental question of operations ownership in containerized environments. Organizations must decide whether to treat Kubernetes clusters as centrally managed technology platforms or as workload-specific tools managed by application teams. Both approaches offer distinct advantages and tradeoffs.

Containers and AKS enable workload teams to implement application-specific operational processes and use specialized features that benefit their customers. Workload operations can extend your operations baseline and platform operations, or operate independently through decentralized approaches.

Use the [Azure Well-Architected Framework](/azure/architecture/framework/) and [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment) to define specific operational processes and tools for individual workloads. These tools help you establish workload-specific requirements for reliability, security, cost optimization, operational excellence, and performance efficiency.

## Azure resources

The following Azure tools and resources support the operations management recommendations in this article:

| Category | Tool | Description |
|----------|------|-------------|
| Monitoring and visibility | [Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview) | Provides comprehensive monitoring of AKS clusters, nodes, and containers with built-in dashboards and alerting |
| Monitoring and visibility | [Azure Monitor queries](/azure/azure-monitor/containers/container-insights-log-query) | Enables custom dashboards and detailed analysis of container performance and health metrics |
| Monitoring and visibility | [Prometheus integration](/azure/azure-monitor/containers/container-insights-prometheus-integration) | Collects application-specific metrics and integrates with Azure Monitor for unified observability |
| Operations compliance | [AKS cluster upgrade](/azure/aks/upgrade-cluster) | Provides automated and manual upgrade processes for AKS clusters with minimal downtime |
| Operations compliance | [Node image upgrade](/azure/aks/node-image-upgrade) | Updates node images with latest security patches and operating system updates |
| Operations compliance | [Node OS updates](/azure/aks/node-updates-kured) | Automates node operating system updates using tools like Kured for seamless maintenance |
| Operations compliance | [Patching and upgrade guidance](/azure/architecture/operator-guides/aks/aks-upgrade-practices) | Provides enterprise best practices for AKS maintenance and upgrade procedures |
| Protection and recovery | [AKS uptime SLA](/azure/aks/uptime-sla) | Offers financially backed service level agreements for improved cluster availability |
| Protection and recovery | [Multiregion BCDR practices](/azure/aks/operator-best-practices-multi-region) | Implements business continuity and disaster recovery across multiple Azure regions |
| Protection and recovery | [Storage best practices](/azure/aks/operator-best-practices-storage) | Provides guidance for persistent storage management and data protection in AKS |
| Workload operations | [Azure Well-Architected Framework](/azure/architecture/framework/) | Defines operational excellence principles for individual workloads and applications |
| Workload operations | [Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment) | Provides assessment tools for workload-specific operational requirements and optimization |

## Next steps

> [!div class="nextstepaction"]
> [Strategy for modern application platforms](./strategy.md)
