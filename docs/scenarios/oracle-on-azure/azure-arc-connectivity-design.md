---
title: Azure Arc Connectivity Design for Oracle Exadata Database@Azure
description: Learn about network connectivity requirements and configuration guidance for enabling Azure Arc on Oracle Exadata Database@Azure infrastructure.
author: sihbher
ms.author: gereyeso
ms.reviewer: bhbandam
ms.date: 09/02/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Azure Arc connectivity design for Oracle Exadata Database@Azure

This article provides network connectivity guidance for enabling Azure Arc on Oracle Exadata Database@Azure infrastructure. These recommendations enable unified governance and security monitoring while preserving existing Oracle Cloud Infrastructure (OCI) management capabilities and database operations.

Azure Arc extends Azure management capabilities to Oracle Exadata Database@Azure without requiring changes to existing network security controls or subnet delegation. Implement these connectivity patterns to gain comprehensive security monitoring through Microsoft Defender for Cloud and governance through Azure Policy while maintaining full compatibility with existing Oracle operations.

> [!NOTE]
> This guidance is specific to Oracle Exadata Database@Azure deployments. For Oracle Autonomous Database@Azure, Azure Arc connectivity isn't applicable because it's a fully managed service.

## Plan Azure Arc integration strategy

Before you implement Azure Arc connectivity, establish a comprehensive strategy that aligns with your existing Oracle Exadata Database@Azure architecture. This planning phase ensures successful integration without disrupting current operations.

### Select appropriate Azure regions for Azure Arc connectivity

Azure Arc service endpoints vary by Azure region and affect connectivity performance and compliance. Choose the optimal region configuration to minimize latency and meet regulatory requirements.

1. **Deploy Azure Arc connectivity in the same region as your Oracle Exadata Database@Azure infrastructure.** This approach minimizes latency for Azure Arc agent communications and ensures optimal performance for monitoring and governance operations. For regional considerations, see [Azure regions and availability zones](/azure/reliability/availability-zones-overview).

1. **Validate Azure Arc service endpoint availability in your target region.** Confirm that all required Azure Arc service endpoints are available in your Oracle Exadata Database@Azure deployment region before implementing. For service availability by region, see [Azure products by region](https://azure.microsoft.com/global-infrastructure/services/).

1. **Assess cross-region connectivity implications when regions differ.** If your Oracle infrastructure and Azure Arc management must operate in different regions, evaluate the latency impact on Azure Arc agent operations and compliance requirements for cross-region data flows.

1. **Plan for bandwidth requirements across regions.** Cross-region Azure Arc connectivity adds bandwidth costs and latency considerations for heartbeat traffic, monitoring data, and policy evaluation communications. For bandwidth planning, see [Azure bandwidth pricing](https://azure.microsoft.com/pricing/details/bandwidth/).

### Preserve existing network topology and security boundaries

Azure Arc integration operates within Oracle Exadata Database@Azure network constraints without requiring changes to existing security configurations. For comprehensive network topology guidance, see [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md).

Azure Arc-specific network preservation requirements include:

1. **Maintain existing subnet delegation to OCI.** Azure Arc doesn't modify the existing [subnet delegation](/azure/virtual-network/subnet-delegation-overview) configuration required for Oracle Database@Azure operations.

1. **Consider network security group (NSG) configuration dependencies.** Azure Arc integration works within the existing network configuration where NSG support depends on network features configuration. Review security rules on both Azure and Oracle (OCI) sides to avoid conflicts that can affect Azure Arc connectivity. For NSG best practices, see [NSG overview](/azure/virtual-network/network-security-groups-overview).

1. **Use existing private endpoint configurations.** Azure Arc agents operate with your current private endpoint setup for Azure services without modification. For private endpoint integration, see [What is Azure Private Endpoint?](/azure/private-link/private-endpoint-overview) and [Azure Arc with Azure Private Link](/azure/azure-arc/servers/private-link-security).

1. **Maintain outbound-only connectivity model.** Arc integration uses only outbound HTTPS connections and doesn't require inbound internet access or security group modifications.

## Configure outbound connectivity for Azure Arc endpoints

Azure Arc agents require secure outbound connectivity to Azure service endpoints. Configure this connectivity through your existing network security infrastructure to maintain security posture while enabling Azure Arc management capabilities.

1. **Plan Azure Arc endpoint connectivity through existing security controls.** Route Azure Arc traffic through your established network security infrastructure rather than creating bypass rules. This approach maintains centralized security monitoring and compliance with organizational policies. For network security design patterns, see [Azure Arc network security](/azure/azure-arc/servers/security-networking).

1. **Use Azure Firewall explicit proxy configurations for Azure Arc endpoints.** Configure [explicit proxy settings](/azure/azure-arc/azure-firewall-explicit-proxy) to route Azure Arc traffic through Azure Firewall. This configuration provides centralized logging and security monitoring while maintaining the required connectivity. For comprehensive firewall configuration, see [Azure Firewall documentation](/azure/firewall/).

1. **Consider Azure NAT Gateway for simplified outbound connectivity.** For organizations requiring simpler outbound connectivity without advanced firewall features, use [Azure NAT Gateway](/azure/nat-gateway/nat-overview) to provide secure outbound internet access for Azure Arc agents. NAT Gateway offers a cost-effective alternative when centralized security monitoring through firewalls isn't required. For NAT Gateway design patterns, see [NAT Gateway design guidance](/azure/nat-gateway/nat-gateway-design).

1. **Configure network virtual appliances (NVAs) to allow required service endpoints.** Update your NVA configurations to permit Azure Arc service endpoints while maintaining existing security rules for OCI management traffic. For NVA integration patterns, see [Network virtual appliance high availability](/azure/architecture/networking/guide/network-virtual-appliance-high-availability).

1. **Validate DNS resolution for Azure Arc service endpoints.** Ensure DNS resolution works for all required Azure Arc endpoints from your VM cluster nodes. Test connectivity before you deploy Azure Arc agents. For DNS configuration guidance, see [Name resolution for resources in Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances).

For complete endpoint requirements, see [Connected Machine agent network requirements](/azure/azure-arc/servers/network-requirements).

Organizations that use Transport Layer Security (TLS) inspection can integrate Azure Arc agents with their security monitoring infrastructure. Configure TLS inspection properly to maintain security visibility while ensuring Azure Arc functionality.

### Configure TLS inspection for Azure Arc agents

Organizations using TLS inspection can integrate Azure Arc agents with their security monitoring infrastructure. Configure TLS inspection properly to maintain security visibility while ensuring Azure Arc functionality.

1. **Use Azure Connected Machine agent compatibility with TLS inspection.** The Azure Connected Machine agent doesn't use certificate pinning and works with TLS inspection services. This compatibility allows you to maintain security monitoring of Azure Arc traffic. For agent configuration, see [Azure Connected Machine agent overview](/azure/azure-arc/servers/agent-overview).

1. **Exclude specific Azure Arc extensions from TLS inspection when required.** Some Azure Arc extensions require exclusion from TLS inspection to function properly. Identify these extensions and configure appropriate bypass rules. For extension management guidance, see [Azure Arc-enabled servers extensions](/azure/azure-arc/servers/manage-vm-extensions).

1. **Maintain security monitoring for Azure Arc traffic.** Configure your TLS inspection infrastructure to monitor and log Azure Arc communications while allowing the necessary traffic to flow. This approach provides security visibility without blocking functionality. For security monitoring patterns, see [Azure Monitor network insights](/azure/network-watcher/network-insights-overview).

1. **Test Azure Arc functionality after TLS inspection configuration.** Validate that all Azure Arc features work correctly with your TLS inspection setup before you deploy to production environments. For testing and validation guidance, see [Troubleshoot Azure Arc-enabled servers connectivity](/azure/azure-arc/servers/troubleshoot-connectivity).

### Integrate Microsoft Defender for Cloud with Arc connectivity

Microsoft Defender for Cloud integration with Azure Arc enhances security monitoring for Oracle Database@Azure infrastructure. For comprehensive security configuration guidance, see [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md).

Azure Arc-specific Defender integration requirements include:

1. **Plan Defender deployment strategy for Azure Arc connectivity.** Review [Defender for servers deployment requirements](/azure/defender-for-cloud/plan-defender-for-servers) and ensure that all security endpoints are accessible through your Azure Arc network configuration.

1. **Configure security endpoint accessibility.** Verify that [Microsoft Defender for Cloud network requirements](/azure/defender-for-cloud/defender-for-cloud-introduction) and [Microsoft Sentinel integration endpoints](/azure/sentinel/connect-services-diagnostic-setting-based) are accessible through your Azure Arc connectivity setup.

1. **Coordinate with existing Oracle security monitoring.** Integrate Defender alerts with existing Oracle security tools to avoid duplication while enhancing overall security posture. For integration patterns, see [Microsoft Defender for Cloud integration](/azure/defender-for-cloud/integration-servicenow).

### Use Entra ID for SSH authentication and privileged access monitoring on Arc-enabled cluster nodes

Enable secure and scalable SSH access to Azure Arc-enabled Oracle Exadata cluster nodes using Entra ID.

1. **Enable SSH access to Arc-enabled Oracle Database@Azure Exadata cluster servers.** Use Entra ID to manage SSH access to Oracle Database@Azure Exadata cluster servers. This approach centralizes identity verification and simplifies access management across hybrid environments. Refer to [SSH access to Azure Arc-enabled servers](/azure/azure-arc/servers/ssh-arc-overview?tabs=azure-cli) for implementation details.

1. **Assign appropriate Entra ID roles and RBAC policies for SSH access.** [Assign Entra ID roles](/azure/azure-arc/servers/ssh-arc-overview?tabs=azure-cli#microsoft-entra-authentication) such as "Virtual Machine User Login" or "Virtual Machine Administrator Login" to control SSH access. Scope these roles to specific resource groups or Arc-enabled servers hosting Oracle workloads. Apply least privilege principles to minimize risk and ensure only authorized personnel access sensitive infrastructure.

1. **Deploy Azure Monitor agent using Arc extensions.** Use Azure Policy to deploy the Azure Monitor agent via Arc extensions. This ensures consistent telemetry collection across all cluster nodes and supports scalable monitoring operations. Review [Azure Monitor Agent overview](/azure/azure-monitor/agents/azure-monitor-agent-overview) for deployment guidance.

1. **Configure data collection rules to capture Syslog telemetry.** Create a [Data Collection Rule (DCR) to route Syslog data to a Log Analytics workspace](/azure/sentinel/forward-syslog-monitor-agent). This enables centralized log aggregation and supports advanced analytics and alerting.

1. **Audit SSH access and privileged actions.** Monitor login attempts and track privileged commands such as sudo usage. [Configure alert rules](/azure/azure-monitor/alerts/alerts-overview) to detect anomalies and notify security teams of suspicious activity. Base rules on ```auth``` facility type. This step supports proactive threat detection and incident response.  

## Implement endpoint allowlisting and security controls

Configure network access controls that provide minimum required connectivity for Azure Arc operations while maintaining your organization's security posture. Use a least-privilege approach to Azure Arc endpoint access.

1. **Configure firewall rules for Azure Arc-specific endpoints.** Allow only the required Azure Arc service endpoints through your firewall configuration. Reference the [Azure Arc endpoint requirements](#azure-arc-endpoint-requirements) table for specific endpoint categories and network requirements. Reference [Azure Monitor Agent required endpoints](/azure/azure-monitor/agents/azure-monitor-agent-network-configuration?tabs=PowerShellWindows#firewall-endpoints) for the Azure Monitor extension.

1. **Restrict Azure Arc endpoint access to specific VM cluster nodes.** Limit network access to Azure Arc endpoints from only the Oracle Database@Azure VM cluster nodes that require Azure Arc management. This approach reduces the attack surface and maintains security boundaries. For access control patterns, see [Azure NSGs](/azure/virtual-network/network-security-groups-overview).

1. **Use service tags for endpoint access definition.** Where available, use Azure service tags to define Azure Arc endpoint access in your network security configurations. [Service tags](/azure/virtual-network/service-tags-overview) provide a more maintainable approach than individual IP address management.

1. **Route Azure Arc traffic through existing security monitoring tools.** Ensure that Azure Arc communications flow through your established network security monitoring infrastructure to maintain visibility and compliance with security policies.

## Monitor Azure Arc network connectivity and performance

Azure Arc connectivity requires ongoing monitoring to ensure reliable operations and quick problem resolution. For comprehensive monitoring guidance that covers Azure Arc connectivity, security monitoring, and performance metrics, see [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md).

To ensure reliable connectivity, focus on the following Azure Arc-specific monitoring requirements:

1. **Monitor Azure Arc agent heartbeat connectivity.** Azure Arc agents send [heartbeat messages](/azure/azure-arc/servers/manage-agent#investigate-azure-arc-enabled-server-disconnection) to Azure every five minutes. Implement monitoring to detect connectivity problems when servers haven't communicated for 15 minutes.

1. **Implement network connectivity diagnostics.** Use [Azure Arc connectivity troubleshooting tools](/azure/azure-arc/servers/troubleshoot-connectivity) to diagnose network path problems and validate endpoint accessibility.

1. **Integrate with existing Oracle monitoring systems.** Coordinate Azure Arc connectivity monitoring with Oracle Enterprise Manager alerts and include Azure Arc endpoint health in existing network monitoring dashboards.

## Document network dependencies and integration points

Maintain comprehensive documentation of Azure Arc network requirements to support operations and troubleshooting. Clear documentation ensures consistent implementation and effective problem resolution.

1. **Document Azure Arc service endpoint dependencies by Azure region.** Maintain current lists of required endpoints for your specific Azure regions. This documentation supports firewall configuration and troubleshooting efforts.

1. **Record network path requirements and bandwidth utilization.** Document the network paths used for Azure Arc connectivity and expected bandwidth utilization patterns. This information supports capacity planning and performance troubleshooting.

1. **Map integration points with existing network security controls.** Document how Azure Arc connectivity integrates with your existing network security infrastructure. This mapping supports security reviews and incident response procedures.

1. **Maintain troubleshooting procedures for Azure Arc connectivity problems.** Create step-by-step procedures for diagnosing and resolving common Azure Arc connectivity problems. Include contact information and escalation procedures for complex problems.

## Use Azure Policy for compliance monitoring and machine configuration

Implement Azure Policy and machine configuration policies to enforce network security settings and maintain compliance across your Azure Arc-enabled Oracle Database@Azure infrastructure.

1. **Use Azure Policy for Azure Arc-enabled servers to monitor network security compliance.** Implement [Azure Policy for Azure Arc-enabled servers](/azure/governance/policy/samples/built-in-policies#guest-configuration) to continuously monitor compliance with your network security policies and configurations.

1. **Implement machine configuration policies for operating system-level network controls.** Use [Azure machine configuration policies](/azure/governance/machine-configuration/overview) to enforce network security settings at the operating system level. This approach provides group policy object (GPO)-like control over Azure Arc-connected servers and ensures consistent security configurations.

1. **Establish governance baseline for comprehensive security management.** Follow the [Governance, security, and compliance baseline for Azure Arc-enabled servers](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-security-governance-and-compliance) to implement comprehensive governance across your hybrid infrastructure.

1. **Monitor policy compliance and remediation status.** Regularly review policy compliance reports and implement automated remediation where possible to maintain security standards across your Azure Arc-enabled infrastructure.

## Validate connectivity before Azure Arc deployment

Complete predeployment validation to ensure successful Azure Arc integration with your Oracle Database@Azure infrastructure. This validation prevents deployment problems and ensures optimal performance.

1. **Test outbound connectivity from VM cluster nodes to required endpoints.** Use network connectivity testing tools to verify HTTPS/443 access to all required Azure Arc service endpoints. Validate DNS resolution for Azure Arc service endpoints and confirm that existing firewall rules don't block required endpoints.

1. **Assess bandwidth requirements for Azure Arc operations.** Evaluate network capacity for Azure Arc communications. Initial onboarding requires higher bandwidth for agent download and registration. Ongoing operations require minimal bandwidth for heartbeat and monitoring data. Plan for burst capacity during policy evaluation and security assessment periods.

1. **Review security controls alignment with Azure Arc connectivity requirements.** Validate that Azure Arc endpoints meet organizational security approval processes. Confirm that Azure Arc traffic logging integrates with existing security information and event management (SIEM) systems. Review Azure Arc connectivity against network security policies to ensure compliance.

1. **Prepare configuration templates and automation.** Create standardized configuration templates for Azure Arc deployment across your Oracle infrastructure. Prepare automation scripts for consistent deployment and configuration management.

## Azure Arc endpoint requirements

The following table summarizes key Azure Arc service endpoints by category. These endpoints must be accessible from your Oracle Database@Azure VM cluster nodes for successful Azure Arc integration.

| Service category | Endpoint purpose | Network requirements |
|---|---|---|
| Azure Resource Manager | VM registration and management | HTTPS/443 outbound |
| Azure Arc configuration service | Agent configuration and updates | HTTPS/443 outbound |
| Log Analytics | Monitoring data ingestion | HTTPS/443 outbound |
| Microsoft Defender | Security assessment data | HTTPS/443 outbound |
| Azure Policy | Compliance evaluation | HTTPS/443 outbound |

> [!NOTE]
> Specific endpoint URLs vary by Azure region. For complete regional endpoint lists, see [Connected Machine agent network requirements](/azure/azure-arc/servers/network-requirements). To simplify endpoint management, consider using [Azure Arc gateway (preview)](/azure/azure-arc/servers/arc-gateway) which reduces required endpoints to seven fully qualified domain names (FQDNs). For organizations that require private connectivity, see [Private Link security for Azure Arc](/azure/azure-arc/servers/private-link-security).

## Implementation resources and troubleshooting guidance

Use these resources to implement and maintain Azure Arc connectivity for your Oracle Database@Azure infrastructure. These resources provide configuration templates, troubleshooting tools, and monitoring guidance specific to Azure Arc connectivity scenarios.

### Configuration templates and examples

- [Azure Firewall explicit proxy for Azure Arc](/azure/azure-arc/azure-firewall-explicit-proxy) - Azure Firewall explicit proxy setup
- [Private Link security for Azure Arc](/azure/azure-arc/servers/private-link-security) - Private Link configuration 
- [DNS policies overview](/windows-server/networking/dns/deploy/dns-policies-overview) - DNS policies for mixed environments
- [Proxy bypass for private endpoints](/azure/azure-arc/servers/manage-agent?tabs=windows#proxy-bypass-for-private-endpoints) - Proxy bypass configuration

### Troubleshooting and validation tools

- [Azure Arc connectivity troubleshooting](/azure/azure-arc/servers/troubleshoot-connectivity) - Azure Arc agent connectivity diagnostics and testing procedures
- [Azure Arc Jumpstart](https://azurearcjumpstart.io/) - Validation scripts and automation examples
- [Azure Monitor best practices](/azure/azure-monitor/logs/best-practices-logs) - Log Analytics integration for Azure Arc monitoring
- [Azure Arc network requirements](/azure/azure-arc/servers/network-requirements) - Complete endpoint reference and bandwidth planning

Monitor Azure Arc connectivity health by tracking agent connectivity status, network path performance, endpoint availability, and security event correlation with existing Oracle monitoring systems.

## Azure tools and resources

| Category | Tool | Description |
|----------|----------|-------------|
| Connectivity | [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) | Hybrid server management for Oracle Database@Azure VM clusters |
| Network security | [Azure Firewall](/azure/firewall/overview) | Network security and Azure Arc endpoint access control |
| Outbound connectivity | [Azure NAT Gateway](/azure/nat-gateway/nat-overview) | Simplified outbound internet connectivity for Azure Arc agents |
| Monitoring | [Azure Monitor](/azure/azure-monitor/fundamentals/overview) | Azure Arc connectivity and performance monitoring |
| Security | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Security monitoring for Azure Arc-enabled Oracle infrastructure |
| Governance | [Azure Policy](/azure/governance/policy/overview) | Policy-driven governance and compliance for Azure Arc-enabled Oracle infrastructure |
| Configuration | [Azure machine configuration](/azure/governance/machine-configuration/overview) | Operating system configuration management and compliance |
| Connectivity | [Azure Arc gateway (preview)](/azure/azure-arc/servers/arc-gateway) | Simplified endpoint management for Azure Arc connectivity |
| Documentation | [Azure Arc Jumpstart](https://azurearcjumpstart.io/) | Comprehensive guidance and automation examples for Azure Arc scenarios |

## Next steps

- [Azure Arc-enabled servers network requirements](/azure/azure-arc/servers/network-requirements)
- [Azure Firewall explicit proxy for Azure Arc](/azure/azure-arc/azure-firewall-explicit-proxy)

## Related resources

- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Manage and monitor Oracle Database@Azure](oracle-manage-monitor-oracle-database-azure.md)
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)