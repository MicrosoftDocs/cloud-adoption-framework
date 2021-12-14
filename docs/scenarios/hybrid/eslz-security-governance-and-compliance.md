---
title: Governance and compliance, baseline for Azure Arc-enabled servers
description: Expand Azure governance and compliance, baseline for deployment on Azure Arc-enabled servers.
author: MatthewGrimshaw
ms.author: matgri
ms.date: 06/10/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Governance and compliance, baseline for Azure Arc-enabled servers

This article covers the key design considerations and best practices when implementing governance and compliance in hybrid, multicloud, and edge deployments. Azure Arc manages these deployments and is a part of the CAF enterprise-scale landing zone.

Defining and applying the proper control mechanisms is key in any cloud implementation, as it's the foundational element to stay secured and compliant. In a traditional environment, these mechanisms usually involve review processes and manual controls. However, the cloud has introduced a new approach to IT governance with automated guardrails and checks. [Azure Policy](/azure/governance/policy/overview) and [Microsoft Defender for Cloud](/azure/security-center/defender-for-cloud-introduction) are cloud-native tools that allow the implementation of these controls, reports, and remediation tasks in an automated fashion. By combining them with Azure Arc, your governance policies and security checks are extended to any resource in public or private clouds.

By the end of this article, you'll understand the critical design areas for governance and compliance with clear Microsoft guidance.

## Architecture

The following image displays conceptual reference architecture that demonstrates the compliance and governance design areas for Azure Arc-enabled servers:

[ ![A diagram depicting the enterprise-scale governance and compliance for Azure Arc-enabled servers on Azure conceptual reference architecture.](./media/arc-enabled-servers-security-compliance-governance.png)](./media/arc-enabled-servers-security-compliance-governance.png#lightbox)

## Design considerations

As your hybrid and multicloud resources become a part of Azure Resource Manager, they can be managed and governed with Azure tools, just like Azure native VMs.

### Governance disciplines

- **Threat protection and cloud security posture management:** Introduce controls to detect security misconfigurations and track compliance. Also, use [Azure's intelligence](/azure/sentinel/overview) to protect your hybrid workloads against threats. [Enable Microsoft Defender for servers](/azure/security-center/security-center-get-started) for all subscriptions containing Azure Arc-enabled servers for security baseline monitoring, security posture management, and threat protection.
- **Secret and certificate management:** Enable [Azure Key Vault](/azure/key-vault/general/basic-concepts) to protect service principal credentials. Consider using [Azure Key Vault](/azure/key-vault/general/basic-concepts) for certificate management on your Azure Arc-enabled servers.
- **Policy management and reporting:** Define a governance plan for your hybrid servers and machines that translates into Azure policies and remediation tasks.
- **Data residency:** Consider which Azure region you wish your Azure Arc-enabled servers to be provisioned into, and understand the [metadata that is collected](/azure/azure-arc/servers/data-residency) from these machines.
- **Secure public key:** Secure the Azure connected machine agent public key authentication to communicate with the Azure service.
- **Business continuity and disaster recovery:** Review the [business continuity and disaster recovery](/azure/cloud-adoption-framework/ready/enterprise-scale/business-continuity-and-disaster-recovery) guidance for enterprise-scale landing zones to determine whether your enterprise requirements are met.
- Review the [security, governance, and compliance design area](/azure/cloud-adoption-framework/ready/enterprise-scale/security-governance-and-compliance) of Azure landing zone enterprise-scale, to assess the impact of Azure Arc-enabled servers on your overall security and governance model.

## Design recommendations

### Agent provisioning

If using a [service principal](/azure/azure-arc/servers/onboard-service-principal) to provision Azure Arc-enabled servers, consider how to securely store and distribute the service principal password.

### Agent management

The Azure connected machine agent is the key piece for Azure Arc-enabled servers. It contains several logical components that play a role in security, governance, and management operations. If the Azure connected machine agent stops sending heartbeats to Azure, or goes offline, you will not be able to perform operational tasks on it. Hence, it's necessary to [develop a plan](/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate) for notifications and responses.

Azure activity log can be used to set up [resource health notifications](/azure/service-health/resource-health-alert-monitor-guide). Remain informed on the current and historical health status of the Azure connected machine agent by implementing a [query](/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate).

### Agent security permissions

Control who has access to the Azure connected machine agent on Azure Arc-enabled servers. The services that compose this agent control all communication and interaction for the Azure Arc-enabled servers to Azure. Members of the local administrator group on Windows and users with root privileges on Linux, have permissions to manage the agent.

### Policy management and reporting

Policy-driven governance is a foundational principle of cloud-native operations and the Cloud Adoption Framework. [Azure Policy](/azure/governance/policy/) provides the mechanism to enforce corporate standards and to assess compliance at-scale. You can implement governance for consistency of deployments, compliance, control costs, and improve your security posture. With its compliance dashboard, you will get an aggregated view of the overall state, and remediation capabilities.

Azure Arc-enabled servers support [Azure Policy](/azure/governance/policy/overview) at the Azure resource management layer, and also within the individual server machine using [guest configuration policies](/azure/governance/policy/concepts/guest-configuration).

Understand the [scope of Azure Policy](/azure/role-based-access-control/scope-overview) and where it can be applied (management group, subscription, resource group, or individual resource level). Create a management group design in accordance with the recommended practices outlined in the [Cloud Adoption Framework enterprise-scale](/azure/cloud-adoption-framework/ready/enterprise-scale/management-group-and-subscription-organization)

- Determine what Azure policies are required by defining business, regulatory, and security requirements for Azure Arc-enabled servers.
- Enforce tagging and implement [remediation tasks](/azure/governance/policy/how-to/remediate-resources).
- Understand and evaluate the [Azure Policy built-in definitions for Azure Arc-enabled servers](/azure/azure-arc/servers/policy-reference).
- Understand and evaluate the built-in [Guest configuration policies](/azure/governance/policy/samples/built-in-policies#guest-configuration) and [initiatives](/azure/governance/policy/samples/built-in-initiatives#guest-configuration).
- Evaluate the need for creating [custom guest configuration policies](/azure/governance/policy/how-to/guest-configuration-create).
- Define a monitoring and alerting policy that identifies [unhealthy Azure Arc-enabled servers](/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate).
- Enable Azure Advisor alerts to identify Azure Arc-enabled servers with [outdated agents installed](/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate).
- [Enforce organization standards and assess compliance at-scale](/azure/azure-arc/servers/security-controls-policy).
- Use Azure Policy and remediation tasks to onboard management service agents via the extension management feature.
- Enable [Azure Monitor](/azure/azure-arc/servers/learn/tutorial-enable-vm-insights) for compliance and operational monitoring of Azure Arc-enabled servers.

The following image displays conceptual reference architecture that demonstrates the policy and compliance reporting design areas for Azure Arc-enabled servers:

[ ![A diagram depicting the Azure Policy for Azure Arc-enabled servers on Azure conceptual reference architecture.](./media/arc-enabled-servers-policy.png)](./media/arc-enabled-servers-policy.png#lightbox)


## Next steps

For more guidance for your hybrid cloud adoption journey,  review the following:

- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios
- Review the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enable servers
- Understand how to [manage hybrid and multicloud environments](./manage.md)
- To learn more about Azure Arc, check out the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/)
