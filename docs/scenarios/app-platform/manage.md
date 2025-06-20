---
title: Manage modern application platform solutions for optimal performance and reliability
description: Learn how to establish operations management for containerized workloads and Azure Kubernetes Service clusters to ensure optimal performance, security, and cost efficiency.
author: stephen-sumner
ms.author: pnp
ms.date: 01/15/2025
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# Manage modern application platform solutions for optimal performance and reliability

This article helps you establish operations management for containerized workloads and Azure Kubernetes Service (AKS). Effective operations management reduces downtime, improves security posture, and optimizes costs across your container platform. Here's how:

## Implement platform operations

Platform operations provide the specialized tools and processes needed to manage AKS clusters and containerized workloads effectively. Platform operations ensure consistent management across all clusters and reduce operational overhead. You need to implement platform operations. Here's how:

1. **Establish centralized cluster management capabilities.** Centralized management provides consistent policies and reduces operational complexity across multiple clusters. Configure Azure Policy for Kubernetes and Azure Arc-enabled Kubernetes to enforce governance across all clusters regardless of location.

2. **Deploy monitoring and observability foundations.** Comprehensive monitoring enables proactive issue detection and performance optimization. Monitoring foundations provide the data platform and workload teams need for effective operations. Install Azure Monitor for containers and configure Prometheus integration to capture both infrastructure and application metrics.

3. **Implement automated maintenance procedures.** Automated maintenance reduces manual effort and ensures consistent update application across clusters. Automated procedures minimize security vulnerabilities and maintain platform supportability. Establish scheduled upgrade cycles for AKS clusters, node images, and operating system patches using Azure Automation tools.

### Monitor inventory and ensure visibility

Container environments require comprehensive monitoring configurations to capture operational data effectively. Monitoring visibility enables rapid incident response and supports capacity management decisions. You need visibility into cluster health, workload performance, and resource utilization to ensure optimal operations. Here's how:

1. **Deploy Azure Monitor for containers to collect comprehensive telemetry.** Azure Monitor for containers provides the foundation for container operations monitoring. This solution captures critical operational data that platform teams need for infrastructure management and workload teams require for application optimization. Configure [Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview) to monitor these essential areas:

   - Cluster topology and resource utilization across regions
   - Node pool configurations, networking, and storage architectures
   - AKS version and node image compliance status
   - CPU, memory, and storage utilization at cluster and container levels
   - Workload behavior under normal and peak load conditions
   - Automated alerting for threshold breaches and health state changes

2. **Configure standardized queries and dashboards for operational consistency.** Standardized monitoring approaches reduce operational complexity and ensure consistent visibility across teams. Standardized monitoring patterns enable both platform and workload teams to use common operational procedures effectively. Configure [Azure Monitor queries](/azure/azure-monitor/containers/container-insights-log-query) to create standardized dashboards and alerts that align with your operational model and service level agreements.

3. **Integrate application-specific metrics through Prometheus collection.** Application metrics provide insights that infrastructure monitoring cannot capture. Application-level monitoring enables teams to understand workload behavior and optimize performance effectively. Integrate with [Prometheus](/azure/azure-monitor/containers/container-insights-prometheus-integration) to collect custom application metrics and combine them with infrastructure data for comprehensive observability across your container platform.

4. **Extend monitoring coverage to hybrid and multicloud environments.** Consistent monitoring across all container platforms simplifies operations and reduces management overhead. Unified visibility ensures operational consistency regardless of where your containers run. Extend monitoring to include AKS Engine on-premises, Azure Red Hat OpenShift, and Azure Arc-enabled Kubernetes clusters for comprehensive visibility across your entire container portfolio.

### Maintain compliance

Operations compliance in containerized environments requires management at multiple levels: AKS clusters, node images, and node operating systems. Compliance management ensures security vulnerabilities receive timely patches and platforms remain supportable. You must determine whether centralized teams or workload teams handle these compliance responsibilities based on your operational model. Here's how:

1. **Evaluate operations ownership models for your environment.** Operations ownership affects update frequency, testing procedures, and incident response capabilities. Different ownership models provide different benefits and require different team capabilities. Choose an ownership model that aligns with your team structure and business requirements. Compare these approaches:

   - Workload team ownership provides granular control and faster updates but requires more team expertise
   - Centralized ownership offers standardization and cost efficiency but reduces flexibility and responsiveness

2. **Implement systematic upgrade and maintenance procedures.** Regular maintenance prevents security vulnerabilities and ensures platform supportability. Systematic procedures minimize business impact and provide predictable maintenance windows. You must establish scheduled maintenance windows and testing procedures to minimize business disruption. Follow these Azure-specific procedures:

   - [Upgrade AKS clusters](/azure/aks/upgrade-cluster) using blue-green or rolling update strategies
   - [Upgrade node images](/azure/aks/node-image-upgrade) to include latest security patches
   - [Process node OS updates](/azure/aks/node-updates-kured) using automated tools like Kured
   - Apply [patching and upgrade best practices](/azure/architecture/operator-guides/aks/aks-upgrade-practices) for enterprise environments

3. **Establish risk management procedures for multitenant clusters.** Multitenant clusters require careful coordination between teams and thorough testing procedures. Risk management procedures ensure workload compatibility and provide clear escalation paths. You need contingency plans for workloads that cannot support cluster upgrades and clear communication channels for maintenance activities. Test all upgrades in preproduction environments and maintain detailed rollback procedures.

### Protect and recover workloads

AKS nodes are ephemeral and designed for replacement rather than individual restoration. Protection strategies must account for the ephemeral nature of container infrastructure while ensuring business continuity requirements. You must design protection and recovery strategies that align with workload criticality and recovery time objectives. Here's how:

1. **Evaluate state management requirements for each workload.** State management affects backup strategies and recovery procedures. Different application types require different protection approaches based on their data persistence needs. Identify whether applications are stateless or require persistent data. Stateless apps simplify operations, while stateful apps need specialized storage and backup strategies.

2. **Implement service level agreements and availability measures.** Service level agreements define your recovery objectives and determine your protection investments. Clear service level agreements align operational investments with business requirements. You need to establish service level agreements that balance business requirements with operational costs. Configure these protection levels:

   - Add an [uptime SLA to your cluster](/azure/aks/uptime-sla) for improved availability guarantees
   - Implement [multiregion BCDR best practices](/azure/aks/operator-best-practices-multi-region) for mission-critical workloads
   - Design appropriate redundancy and failover mechanisms based on workload criticality

3. **Establish data protection and state management procedures.** Data protection requirements vary significantly between stateless and stateful applications. Proper data protection ensures business continuity and supports compliance requirements. You must identify applications that require persistent state and implement appropriate backup and recovery mechanisms. Follow these approaches:

   - Use your existing operations baseline guidance for external state restoration
   - Implement [storage best practices](/azure/aks/operator-best-practices-storage) for applications that require persistent state
   - Establish procedures to [back up and restore persistent data](/azure/aks/operator-best-practices-storage#secure-and-back-up-your-data) for stateful workloads
   - Use platform-specific tools like [Velero](https://github.com/vmware-tanzu/velero) for comprehensive backup and recovery

4. **Standardize recovery toolchains across your portfolio.** Inconsistent recovery approaches increase operational complexity and costs. Standardized recovery approaches reduce training requirements and operational overhead. You must choose a standardized recovery approach for all containerized workloads to reduce management overhead. If applications cannot conform to the standard recovery approach, shift the responsibility for alternative solutions to workload teams.

## Design workload operations

Containers and AKS enable workload teams to implement application-specific operational processes and use specialized features that benefit their customers. Use the [Azure Well-Architected Framework](/azure/architecture/framework/) and [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment) to define specific operational processes and tools for individual workloads. These assessment tools help you establish workload-specific requirements for reliability, security, cost optimization, operational excellence, and performance efficiency.

## Azure resources

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
