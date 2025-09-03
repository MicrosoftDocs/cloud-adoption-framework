---
title: Azure Arc connectivity design for Oracle Database@Azure
description: Learn about network connectivity requirements and configuration guidance for enabling Azure Arc on Oracle Database@Azure infrastructure.
author: sihbher
ms.author: gereyeso
ms.reviewer: bhbandam
ms.date: 09/02/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Azure Arc connectivity design for Oracle Database@Azure

This article provides network connectivity requirements and configuration guidance for enabling Azure Arc on Oracle Exadata Database@Azure infrastructure. Azure Arc integration enables unified governance and security monitoring while preserving existing Oracle Cloud Infrastructure (OCI) management capabilities and database operations.

## Overview

Azure Arc-enabled servers extend Azure management capabilities to Oracle Exadata Database@Azure VM cluster nodes without modifying existing subnet delegation or OCI management traffic flows. This integration provides additional security monitoring through Microsoft Defender for Cloud and governance through Azure Policy while maintaining full compatibility with existing Oracle security controls and management operations.

## Design considerations

Consider the following guidance when designing Azure Arc connectivity for Oracle Exadata Database@Azure:

- **Outbound connectivity requirements**: Azure Arc agents require outbound HTTPS connectivity to specific Azure service endpoints. Plan for this connectivity without modifying existing network security controls or subnet delegation configuration. For complete endpoint requirements, see [Connected Machine agent network requirements](/azure/azure-arc/servers/network-requirements).

- **Network topology preservation**: Azure Arc integration operates within the existing Oracle Database@Azure network constraints:
  - Maintains existing subnet delegation to OCI
  - Preserves client subnet configurations without NSG support  
  - Works with existing private endpoint configurations
  - Does not require inbound internet access or modifications to existing security groups

- **Regional endpoint considerations**: Azure Arc service endpoints vary by Azure region. Ensure that Arc connectivity endpoints are available in your Oracle Database@Azure deployment region. Cross-region Arc connectivity may introduce latency and compliance considerations.

- **Firewall integration strategies**: Plan Arc connectivity through existing network security infrastructure:
  - Route Arc traffic through Azure Firewall using [explicit proxy configurations](/azure/azure-arc/azure-firewall-explicit-proxy) 
  - Configure network virtual appliances (NVAs) or Azure Firewall to allow Arc service endpoints
  - Maintain existing firewall rules for OCI management traffic

- **Private endpoint compatibility**: Azure Arc agents can operate with private endpoints for specific Azure services. Evaluate private endpoint requirements for Log Analytics workspaces and other Azure services integrated with Arc monitoring.

- **Bandwidth and latency impact**: Arc agent communication introduces minimal network overhead but plan for:
  - Continuous heartbeat traffic to Azure Resource Manager
  - Log and metrics collection to Log Analytics workspaces
  - Policy evaluation and compliance reporting
  - Security assessment data transmission

- **TLS inspection compatibility**: If your organization uses TLS inspection, note that the Azure Connected Machine agent doesn't use certificate pinning and will work with TLS inspection services. However, some Azure Arc extensions may require exclusion from TLS inspection. For details, see [Network security for Azure Arc-enabled servers](/azure/azure-arc/servers/security-networking).

### Microsoft Defender for Cloud integration

- **Plan Defender deployment strategy**: Review [Defender for servers deployment requirements](/azure/defender-for-cloud/plan-defender-for-servers) and [Arc agent deployment considerations](/azure/azure-arc/servers/deployment-options) for Oracle Database@Azure infrastructure integration.

- **Configure Defender data collection**: Set up [Defender data collection rules](/azure/defender-for-cloud/defender-for-servers-introduction#data-collection) to complement existing Oracle monitoring. For detailed configuration, see [Configure data collection for Defender for servers](/azure/defender-for-cloud/configure-servers-coverage).

- **Security endpoint requirements**: Review [Azure Arc network requirements](/azure/azure-arc/servers/network-requirements) and ensure accessibility through existing Arc connectivity. For Microsoft Sentinel integration endpoints, see [Sentinel network requirements](/azure/sentinel/connect-services-diagnostic-setting-based).

## Design recommendations

Implement the following network connectivity recommendations for Azure Arc integration:

### Network connectivity configuration

- **Configure Arc endpoints through existing security controls**: Route Azure Arc traffic through your established network security infrastructure rather than creating bypass rules:
  - Use Azure Firewall [explicit proxy configurations](/azure/azure-arc/azure-firewall-explicit-proxy) for Arc endpoints
  - Configure network virtual appliances to allow required service endpoints
  - Maintain centralized logging and [monitoring](oracle-manage-monitor-oracle-database-azure.md) of Arc connectivity

- **Implement endpoint allow-listing**: Configure firewall rules to allow Arc-specific endpoints while maintaining security posture. Key endpoint categories include:
  - Azure Resource Manager endpoints for resource registration
  - Azure Arc configuration service endpoints  
  - Log Analytics workspace endpoints for monitoring data
  - Microsoft Defender for Cloud endpoints for security monitoring
  - Azure Policy service endpoints for compliance reporting


### Security and access control

- **Preserve existing security boundaries**: Ensure Arc connectivity doesn't create security bypasses:
  - Route Arc traffic through existing security monitoring tools
  - Apply the same network access logging to Arc endpoints as other outbound traffic
  - Maintain existing intrusion detection and prevention system (IDPS) coverage

- **Implement least-privilege connectivity**: Configure network access controls that provide minimum required connectivity:
  - Restrict Arc endpoint access to specific VM cluster nodes
  - Use service tags where available to define endpoint access

- **Monitor Arc network traffic**: Establish monitoring for Arc-related network connectivity:
  - **Arc agent heartbeat monitoring**: Monitor Azure Arc agent connectivity status through [regular heartbeat messages](/azure/azure-arc/servers/manage-agent#investigate-azure-arc-enabled-server-disconnection) sent to Azure every five minutes. Servers are considered disconnected after 15 minutes without heartbeats.
  - **Resource Health alerts for connectivity monitoring**: Set up [Resource Health alerts](/azure/service-health/resource-health-alert-monitor-guide) to get proactive notifications when Arc-enabled servers become disconnected or experience connectivity issues.
  - **Network connectivity diagnostics**: Use Azure Arc agent diagnostic tools and [troubleshooting guidance](/azure/azure-arc/servers/troubleshoot-connectivity) to investigate connectivity issues and monitor network performance.
    - Track Arc agent heartbeat connectivity
    - Monitor bandwidth utilization for Arc communications  
    - Alert on connectivity failures or degraded performance
    - Log Arc endpoint access for security auditing


### Hybrid connectivity integration

- **Coordinate with existing monitoring**: Integrate Arc connectivity monitoring with existing Oracle and Azure monitoring systems:
  - Correlate Arc connectivity status with Oracle Enterprise Manager alerts
  - Include Arc endpoint health in existing network monitoring dashboards
  - Coordinate Arc connectivity maintenance with Oracle database maintenance windows

- **Document network dependencies**: Maintain clear documentation of Arc network requirements:
  - Arc service endpoint dependencies by Azure region
  - Network path requirements and bandwidth utilization
  - Integration points with existing network security controls
  - Troubleshooting procedures for Arc connectivity issues

### Governance and compliance integration

- **Policy compliance monitoring**: Use [Azure Policy for Arc-enabled servers](/azure/governance/policy/samples/built-in-policies#guest-configuration) to monitor compliance with network security policies and configurations. For comprehensive governance guidance, see [Governance, security, and compliance baseline for Azure Arc-enabled servers](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-security-governance-and-compliance).

- **Machine configuration policies**: Implement [Azure machine configuration policies](/azure/governance/machine-configuration/overview) to enforce network security settings at the operating system level, providing GPO-like control over Arc-connected servers.

## Azure Arc endpoint requirements

The following table summarizes key Azure Arc service endpoints by category:

| Service Category | Endpoint Purpose | Network Requirements |
|---|---|---|
| Azure Resource Manager | VM registration and management | HTTPS/443 outbound |
| Arc Configuration Service | Agent configuration and updates | HTTPS/443 outbound |
| Log Analytics | Monitoring data ingestion | HTTPS/443 outbound |
| Microsoft Defender | Security assessment data | HTTPS/443 outbound |
| Azure Policy | Compliance evaluation | HTTPS/443 outbound |

> [!NOTE]
> Specific endpoint URLs vary by Azure region. For complete regional endpoint lists, see [Connected Machine agent network requirements](/azure/azure-arc/servers/network-requirements). To simplify endpoint management, consider using [Azure Arc gateway (preview)](/azure/azure-arc/servers/arc-gateway) which reduces required endpoints to seven FQDNs. For organizations requiring private connectivity, see [Private Link security for Azure Arc](/azure/azure-arc/servers/private-link-security).

## Implementation guidance

### Pre-deployment network validation

Before enabling Azure Arc on Oracle Exadata Database@Azure infrastructure:

1. **Validate outbound connectivity**: Test connectivity from VM cluster nodes to required Azure Arc endpoints:
   - Use network connectivity testing tools to verify HTTPS/443 access
   - Validate DNS resolution for Arc service endpoints
   - Confirm that existing firewall rules don't block required endpoints

2. **Assess bandwidth requirements**: Evaluate network capacity for Arc communications:
   - Initial onboarding requires higher bandwidth for agent download and registration
   - Ongoing operations require minimal bandwidth for heartbeat and monitoring data
   - Plan for burst capacity during policy evaluation and security assessment periods

3. **Review security controls**: Ensure Arc connectivity aligns with existing security requirements:
   - Validate that Arc endpoints meet organizational security approval processes
   - Confirm that Arc traffic logging integrates with existing SIEM systems
   - Review Arc connectivity against network security policies

### Configuration examples and templates

For detailed configuration examples and step-by-step guidance:

- **Azure Firewall explicit proxy setup**: [Access Azure services over Azure Firewall Explicit Proxy (Public Preview)](/azure/azure-arc/azure-firewall-explicit-proxy)
- **Private Link configuration**: [Use Azure Private Link to securely connect servers to Azure Arc](/azure/azure-arc/servers/private-link-security)  
- **DNS policies for mixed environments**: [DNS policies overview](/windows-server/networking/dns/deploy/dns-policies-overview)
- **Proxy bypass for private endpoints**: [Proxy bypass for private endpoints](/azure/azure-arc/servers/manage-agent?tabs=windows#proxy-bypass-for-private-endpoints)

### Post-deployment monitoring

Monitor Arc connectivity health and performance:

- **Arc agent connectivity status**: Monitor heartbeat connectivity between Arc agents and Azure Resource Manager
- **Network path performance**: Track latency and throughput for Arc service communications
- **Endpoint availability**: Monitor Arc service endpoint health and regional failover scenarios
- **Security event correlation**: Integrate Arc connectivity events with existing Oracle security monitoring

## Troubleshooting and monitoring

For connectivity troubleshooting and monitoring:

- **Arc agent connectivity diagnostics**: [Azure Arc-enabled servers agent overview](/azure/azure-arc/servers/agent-overview#troubleshooting)
- **Network connectivity validation**: Use [Azure Arc Jumpstart](https://azurearcjumpstart.io/) for validation scripts and troubleshooting tools
- **Log Analytics integration**: [Best practices for Azure Monitor Logs](/azure/azure-monitor/logs/best-practices-logs) for Arc monitoring data collection
- **Private Link troubleshooting**: [Private Link security troubleshooting](/azure/azure-arc/servers/private-link-security#troubleshooting)

## Azure resources

| Category | Resource | Description |
|----------|----------|-------------|
| Connectivity | [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) | Hybrid server management for Oracle Database@Azure VM clusters |
| Network security | [Azure Firewall](/azure/firewall/overview) | Network security and Arc endpoint access control |
| Monitoring | [Azure Monitor](/azure/azure-monitor/overview) | Arc connectivity and performance monitoring |
| Security | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Security monitoring for Arc-enabled Oracle infrastructure |
| Governance | [Azure Policy](/azure/governance/policy/overview) | Policy-driven governance and compliance for Arc-enabled Oracle infrastructure |
| Configuration | [Azure machine configuration](/azure/governance/machine-configuration/overview) | Operating system configuration management and compliance |
| Connectivity | [Azure Arc gateway (preview)](/azure/azure-arc/servers/arc-gateway) | Simplified endpoint management for Arc connectivity |
| Documentation | [Azure Arc Jumpstart](https://azurearcjumpstart.io/) | Comprehensive guidance and automation examples for Arc scenarios |

## Next steps

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md)
- [Azure Arc-enabled servers network requirements](/azure/azure-arc/servers/network-requirements)
- [Azure Firewall explicit proxy for Azure Arc](/azure/azure-arc/azure-firewall-explicit-proxy)