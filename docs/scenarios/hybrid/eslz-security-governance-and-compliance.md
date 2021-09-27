---
title: Governance, security and compliance baseline for hybrid, multicloud, and edge deployments
description: Expand Azure governance, security and compliance capabilities to hybrid, multicloud, and edge deployments.
author: brianblanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
---

# Governance, security and compliance baseline for hybrid, multicloud, and edge deployments

This article walks through the key design considerations and best practices for security, governance, and compliance in hybrid, multicloud and edge deployments managed by Azure Arc that should be in place as part of a CAF enterprise-scale landing zone implementation.

Defining and applying the proper control mechanisms is key in any cloud implementation as it is the foundational element to stay secured and compliant. In a traditional environment these mechanisms usually involve review processes and manual controls, however the cloud has introduced a new approach to IT governance with automated guardrails and checks. Azure Policy, Azure Blueprints and Azure Security Center are cloud native tools that allow the implementation of these controls, reports, and remediation tasks in an automated fashion. By combining them with Azure Arc, your governance policies and security checks are extended to any resource in public or private clouds.

By the end of this article, you will understand the critical design areas for security, governance, and compliance with clear Microsoft's guidance.

## Design areas

As your hybrid and multicloud resources become part of Azure Resource Manager, they can be managed and governed with Azure tools just as Azure native VMs.

- **Resource consistency and inventory management:** organize your hybrid resources using [Azure scopes of management](https://docs.microsoft.com/en-us/azure/role-based-access-control/scope-overview) and to locally organize them into a [taxonomy](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json). Apply tags to your non Azure deployments to add additional context that is relevant for your operations.
- **Agent Provisioning:** Define a strategy for provisioning the Azure Arc-enabled servers and for agent secret management. Consider the level and method of automation for [bulk enrollment](https://docs.microsoft.com/en-us/azure/azure-arc/servers/learn/quick-enable-hybrid-vm). Consider how to structure [pilot and production deployments](https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment) and establish a formal plan that takes into account the scope and plan for a deployment including objectives, selection criteria, success criteria, training plans, rollback and risks.
- **Agent Management:** the Connected Machine Agent plays a critical role in your hybrid operations as it enables you to manage your Windows and Linux machines hosted outside of Azure and enforce governance policies, it is important to implement solutions that keep track of unresponsive agents.
- **Agent Security permissions:** secure access to the Connected Machine agent
- **Managed Identity:** Use a managed identity with Azure Arc-enabled servers and define a strategy for identifying which applications running on Arc-enabled servers can use the Azure service assigned identity to request an Azure AD token.
- **Secret and certificate management:** Enable Key Vault to protect security principal accounts and encryption keys. Consider using Azure Key vault for certificate management on your Arc-enabled Servers
- **Policy management and reporting:** define a governance plan for your hybrid servers and machines that translates into Azure Policies and remediation tasks.
- **Data Residency:** consider which Azure region you wish your Azure Arc-enabled machines to be provisioned into, and understand the [metadata that is collected](https://docs.microsoft.com/en-us/azure/azure-arc/servers/data-residency) from theses machines.
- **Log management strategy:** plan for metrics and log collection of your hybrid resources into a Log Analytics workspace for further analysis and auditing.
- **Threat protection and cloud security posture management:** introduce controls to detect security misconfigurations and track compliance. Also, use [Azure's intelligence](https://docs.microsoft.com/en-us/azure/sentinel/overview) to protect your hybrid workloads against threats. [Enable Azure Security Center](https://docs.microsoft.com/en-us/azure/security-center/security-center-get-started) for all subscriptions containing Azure Arc-enabled servers for security baseline monitoring, security posture management and threat protection.
- **Change Tracking and Inventory:** track changes on the operating system, application files and registry to identify operational and security issues on your on-premises and other clouds environments.
- **Software Updates:** define a strategy to assess the status of available updates to maintain security compliance with critical and security updates of your operating systems.
- **Role based access controls:** define administrative, operations, and engineering roles within the organization that will take care of day-to-day operations in the hybrid environment. Mapping each team to actions and responsibilities will  determine Azure role-based access control (RBAC) roles and configuration. Consider using a [RACI](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/organize/raci-alignment) matrix to support this effort and build controls into the management scope hierarchy that you define following the resource consistency and inventory management guidance.
- **Business continuity and disaster recovery:** Review the [business continuity and disaster recovery](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/business-continuity-and-disaster-recovery) guidance for Enterprise scale landing zones to determine if your enterprise requirements are met.
- **Disk Encryption:** secure the Connected Machine agent public key authentication to communicate with the Azure service.

## Design recommendations

### Resource consistency and inventory management

Before onboarding any machine onto Azure Arc it is important to define a structure on how these resources will map to Azure management scopes (management groups, subscriptions and resource groups). This mapping is key, as it will determine how you will be able to interact with these resources when applying RBAC roles and while assigning Azure policies as part of your governance model. Review the Cloud Adoption Framework recommendations on how to [organize resources](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagementGroupsAndHierarchy)

When designing this structure be aware of [Azure Resource Manager service limits](https://docs.microsoft.com/en-us/azure/azure-arc/servers/agent-overview#azure-subscription-and-service-limits), as they are also applicable to Azure Arc enabled servers and it is important to plan for the number of machines to be connected to an specific [resource group](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#resource-group-limits) or [subscription](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits).

After you have created a taxonomy structure and agreed on naming standards it is recommended to apply tags to the Azure Arc enabled server resources. Once a server is registered in Azure it has a resource ID and becomes part of a resource group within a subscription where it can benefit from standard Azure constructs such as [tags](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/arc-inventory-tagging). These provide the ability to add metadata to a resource to quickly locate it and automate operational tasks, as such they are relevant to your day to day tasks as described in the [Cloud Adoption Framework tagging strategy](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging). However, it is a good practice to include a tag that reflects the `hosting platform` for the Azure Arc enabled resource.

### Agent Provisioning

If using a [service principal](https://docs.microsoft.com/en-us/azure/azure-arc/servers/onboard-service-principal) to provision Azure Arc-enabled servers, consider how to securely store and distribute the service principle secret. Consider using [Azure Key vault](https://docs.microsoft.com/en-us/azure/key-vault/) for this purpose.

### Agent Management

The Connected Machine agent is the key piece for Azure Arc-enabled servers, it contains several logical components that play a role in security, governance and management operations. If a Connected Machine agent stops sending heartbeats to Azure or goes offline you will not be able to perform operational tasks on it. Hence, it is necessary to develop a plan to get notified and how you will respond.

Azure Activity Log can be used to set up [resource health notifications](https://docs.microsoft.com/en-us/azure/service-health/resource-health-alert-monitor-guide) and remain informed on current and historical health status of the Connected Machine agent by implementing a [query](https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate).

### Agent Security permissions

Control who has access to the Azure connected machine agent on Azure Arc-enabled servers. The services that compose this agent control all communication and interaction for the Arc-enabled server to Azure. On Windows, members of the local administrator group, and on Linux users with root privileges have permissions to manage the agent.

### Managed Identity

Whilst the Azure Active Directory system assigned identity can only be used to update the status of the Azure Arc-enabled server (for example, the 'last seen' heartbeat), it is possible to allow an applications on your server to use the system assigned identity to access Azure resources (for example, to request secrets from a key vault.) Consider which legitimate use-cases exist for server applications to access Azure resources and plan to control access for to these resources.

[Control which server applications can obtain access tokens](https://docs.microsoft.com/en-us/azure/azure-arc/servers/managed-identity-authentication)

- Control privileged user roles on Azure Arc-enabled servers (On Windows, members of the local administrators or Hybrid Agent Extensions Applications group, On Linux, members of the himds group) to avoid system managed identities being misused to gain unauthorized access to Azure resources.

- Use Azure RBAC to control and and manage the permission for Azure Arc-enabled servers managed identities, and perform periodic access reviews for these identities.

### Secret and certificate management

Consider using Azure key vault to manage certificates on your Azure Arc-enabled servers. Azure Arc-enabled servers have a managed identity which you can use for accessing Azure resources such a [Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/general/overview) and for installing Azure VM extensions. The [Key Vault VM extension](https://techcommunity.microsoft.com/t5/itops-talk-blog/manage-certificates-on-your-hybrid-servers-using-azure-arc-key/ba-p/2142265) allows you to manage the certificate lifecycle on [Windows](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/key-vault-windows) and [Linux](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/key-vault-linux) machines

### Policy management and reporting

Having a policy-driven governance is a foundational principal of cloud-native operations and Cloud Adoption Framework. [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/) provides the mechanism to enforce corporate standards and to assess compliance at scale. Through it, you can implement governance for consistency of deployments, compliance, control costs, and improve your security posture; with its compliance dashboard, you will get an aggregated view of the overall state as well as remediation capabilities. Azure Arc-enabled servers support [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview) at the Azure Resource Management layer, and also within the individual server machine using [Guest Configuration Policies](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/guest-configuration).

Understand the [scope of Azure policy](https://docs.microsoft.com/en-us/azure/role-based-access-control/scope-overview) and where it can be applied (Management Group, subscription, resource group or individual resource level). Create a Management Group design in accordance with the recommended practices outlined in the [Cloud Adoption Framework Enterprise Scale](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/management-group-and-subscription-organization)

- Determine what Azure policies are required by defining business, regulatory and security requirements for Azure Arc-enabled servers.
- Enforce tagging and implement [remediation tasks](https://docs.microsoft.com/en-us/azure/governance/policy/how-to/remediate-resources).
- Understand and evaluate the [Azure Policy built-in definitions for Azure Arc-enabled servers](https://docs.microsoft.com/en-us/azure/azure-arc/servers/policy-reference)
- Understand and evaluate the built-in [Guest Configuration policies](https://docs.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies#guest-configuration) and [initiatives](https://docs.microsoft.com/en-us/azure/governance/policy/samples/built-in-initiatives#guest-configuration).
- Evaluate the need for creating [custom Guest configuration policies](https://docs.microsoft.com/en-us/azure/governance/policy/how-to/guest-configuration-create)
- Define a monitoring and alerting policy that identifies [unhealthy Azure arc-enabled servers](https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate).
- Enable Azure Advisor alerts to identify Azure arc-enabled servers with [outdated agents installed](https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate).
- [Enforce organization standards and assess compliance at scale](https://docs.microsoft.com/en-us/azure/azure-arc/servers/security-controls-policy).
- Use an Azure Policy and Remediation tasks to onboard management services agents via the extension management feature.
- Enable [Azure Monitor](https://techcommunity.microsoft.com/t5/itops-talk-blog/azure-monitor-for-azure-arc-enabled-servers/ba-p/1566654) for compliance and operational monitoring of Azure Arc-enabled servers.

### Data residency

### Log management strategy

Design and plan your Log Analytics Workspace deployment, as it will be the container where data is collected, aggregated and later analyzed. As the Log Analytics Workspace represents a geographical location of your data, a level of isolation and a scope for configurations like data retention you will have to identify the number of workspaces needed and how it maps to your organizational structure.

[Designing your Azure Monitor Logs deployment](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/design-logs-deployment)

### Threat protection and cloud security posture management

Azure Security Center provides an unified security-management platform segmented as a cloud security posture management (CSPM) and cloud workload protection platform (CWPP). As your security is only as strong as your weakest link it is important to protect the data and assets hosted in Azure and elsewhere, Azure Defender for servers extends these capabilities to Azure Arc-enabled servers and together with Microsoft Defender for Endpoint provide a comprehensice EDR.  To heighten security on your hybrid landing zone consider:

- Use Azure Arc-enabled servers to onboard hybrid resources in Azure Defender.
- Implement an Azure Policy to make sure all resources are compliant and its security data is collected into the Log Analytics workspaces.
- Enable Azure Defender for all subscriptions, and use Azure Policy to ensure compliance.
- Leverage security information and event management integration with Azure Security Center and Azure Sentinel.

[Connect your non-Azure machines to Security Center](https://docs.microsoft.com/en-us/azure/security-center/quickstart-onboard-machines?pivots=azure-portal)

### Change Tracking and Inventory

Centralizing logs drives additional reports that can be leveraged as additional layers of security and reduces the chances for gaps in observability. [Change Tracking and Inventory in Azure Automation](https://docs.microsoft.com/en-us/azure/automation/change-tracking/overview) forwards and collects the data in a Log Analytics workspace. When using  Azure Defender for servers you get File Integrity Monitoring (FIM) to examine and track software changes, Windows services and Linux daemos on your Azure Arc-enabled servers.

### Software Updates

With Azure Arc-enabled server it is possible to manage in Azure your enterprise estate with centralized management and monitoring at scale. More specifically, it provides alerts and recommendations to IT teams with full operational visibility that includes managing the updates of your Windows and Linux VM.

Assessing and updating your operating systems should be part of your overall management strategy to maintain security compliance with Critical and Security updates as they are released. Use Update Management in Azure Automation as a long-term patching mechanism for both Azure and hybrid resources and use Azure Policy to ensure and enforce the Update Management configurations to all VMs, including your [Azure Arc-enabled servers](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/arc-update-management).

You can also use [Azure Automanage](https://docs.microsoft.com/en-us/azure/automanage/automanage-virtual-machines), so there is no need to worry about the details of onboarding and maintaining best practices for Update Management on your Arc resources.

### Role based access controls

### Business continuity and disaster recovery

### Disk encryption

The Azure Connected Machine agent uses public key authentication to communicate with the Azure service. After you onboard a server to Azure Arc, a private key is saved to the disk and used whenever the agent communicates with Azure. If stolen, the private key can be used on another server to communicate with the service and act as if it were the original server. This includes getting access to the system assigned identity and any resources that identity has access to. The private key file is protected to only allow the himds account access to read it. To prevent offline attacks, we strongly recommend the use of full disk encryption (for example, BitLocker, dm-crypt, etc.) on the operating system volume of your server.

## Next steps

For more guidance for your cloud adoption journey, see the following article:

- [Manage hybrid and multicloud environments](./manage.md)