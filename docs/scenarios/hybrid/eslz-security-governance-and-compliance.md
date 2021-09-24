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

This article walks through the key design considerations and best practices for security, governance, and compliance in hybrid, multicloud and edge deployments managed by Azure Arc, that should be in place as part of a CAF enterprise-scale landing zone implementation.

Defining and applying the proper control mechanisms is key in any cloud implementation as it is the foundational element to stay secured and compliant. These mechanisms in a traditional environment usually meant review processes and manual controls, however the cloud has introduced a new approach to IT governance with automated guardrails and checks. Azure Policy, Azure Blueprints and Azure Security Center are cloud native tools that allow the implementation of these controls, reports, and remediation tasks in an automated fashion. By combining them with Azure Arc, your governance policies and security checks are extended to any resource in public or private clouds.

By the end of this article, you will understand the critical design areas for security, governance, and compliance with clear Microsoft's guidance.

## Design areas

As your hybrid and multicloud resources become part of Azure Resource Manager, they can be managed and governed with Azure tools just as Azure native VMs.

- **Resource consistency and inventory management:** organize your hybrid resources using Azure scopes of management and to locally organize them into a taxonomy. Apply tags to your non Azure deployments to add additional context that is relevant for your operations.
- **Agent Health Management:** the Connected Machine Agent plays a critical role in your hybrid operations as it enables you to manage your Windows and Linux machines hosted outside of Azure and enforce governance policies, it is important to implement solutions that keep track of unresponsive agents.
- **Agent Provisioning:** Define a strategy for provisioning the Azure arc-enabled servers agent secret management and consider the level and method of automation for [bulk enrollment](https://docs.microsoft.com/en-us/azure/azure-arc/servers/learn/quick-enable-hybrid-vm). Consider how to structure [pilot and production deployments](https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment) and establish a formal plan that considers the scope and plan for a deployment including objectives, selection criteria, success criteria, training plans, rollback and risks.
- **Secret and certificate management:** Enable Key Vault to protect security principal accounts and encryption keys. Consider using Azure Key vault for certificate management on your Arc-enabled Servers
- **Policy management and reporting:** define a governance plan for your hybrid servers and machines that translates into Azure Policies and remediation tasks.
- **Data Residency:** Consider which Azure region you wish your Azure arc-enabled machines to be provisioned into, and understand the [metadata that is collected](https://docs.microsoft.com/en-us/azure/azure-arc/servers/data-residency) from theses machines.
- **Network Security:** Private Link, point to network security?
- **Log management strategy:** plan for metrics and log collection of your hybrid resources into a Log Analytics workspace for further analysis and auditing.
- **Threat protection and cloud security posture management:** introduce controls to detect security misconfigurations and track compliance. Also, use Azure's intelligence to protect your hybrid workloads against threats.
- **Configuration management:** track changes on the operating system, application files and registry to identify operational and security issues on your on-premises and other clouds environments.
- **Software Updates:** define a strategy to assess the status of available updates to maintain security compliance with critical and security updates of your operating systems.
- **Backup and recovery strategy:**
- **Role based access controls:** define administrative, operations, and engineering roles within the organization that will take care of day-two operations in the hybrid environment. Mapping each team to actions and responsibilities will  determine Azure role-based access control (RBAC) roles and configuration. Consider using a RACI matrix to support this effort and build controls into the management scope hierarchy that you define following the resource consistency and inventory management guidance.
- **Identity:** Use a managed identity with Azure Arc-enabled servers and define a strategy for identifying which applications running on Arc-enabled servers can use the Azure service assigned identity to request an Azure AD token.

## Design recommendations

### Resource consistency and inventory management

Before onboarding any machine onto Azure Arc it is important to define a structure on how these resources will map to Azure management scopes: management groups, subscriptions and resource groups.  This mapping is key as it will determine how you will be able to interacy with these resources when applying RBAC roles and while assigning Azure policies as part of your governance model. Review the Cloud Adoption Framework recommendations on how to [organize resources](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagementGroupsAndHierarchy)

When designing this structure be aware of [Azure Resource Manager service limits](https://docs.microsoft.com/en-us/azure/azure-arc/servers/agent-overview#azure-subscription-and-service-limits), as they are also applicable to Azure Arc enabled servers and it is important to plan for the number of machines to be connected to an specific [resource group](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#resource-group-limits) or [subscription](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits).

An effective and well-designed [naming standard](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=NamingStandards) that enables you to identify resources easily is key in any inventory management strategy. Make sure to align this naming standard with your already existing hybrid infrastructure as those resources will be part of your global inventory in Azure. Verify that the Linux hostname or Windows computer name of your hybrid resources do not use [Azure's reserved words or trademarks](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/error-reserved-resource-name) as attempting to register the connected machine with Azure will fail.

After you have created a taxonomy structure and agreed on naming standards it is recommended to apply tags to the Azure Arc enabled server resources. Once a server is registered in Azure it has a resource ID, it becomes part of a resource group within a subscription, and can benefit from standard Azure constructs such as [tags](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/arc-inventory-tagging). They provide the ability to add metadata to a resource to quickly locate it and automate operational tasks, as such they should be relevant to your day to day tasks as described in the [Cloud Adoption Framework tagging strategy](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging). However, it is a good practice to include a tag that reflects the hosting platform for the Azure Arc enabled resource.

### Policy management and reporting
https://docs.microsoft.com/en-us/azure/role-based-access-control/scope-overview

Create a resource health alert and azure advisor alert https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate
Policy:

- Guest Configuration
- ARM policies

### Log management and reporting

https://docs.microsoft.com/en-us/azure/azure-monitor/logs/design-logs-deployment
Well-defined governance starts with sound resource consistency practices. Organizing resources, resource groups, subscriptions, and [management groups allows for ease of governance](/azure/governance/management-groups/overview). Expand your cloud governance practices with a few steps:

- Add a tag for `hosting platform` to all hybrid, multicloud, and edge assets.
- Tag resources from AWS, GCP, and so on.
- Query your resources to see where each is hosted.

To get started, [inventory and tag your hybrid and multicloud resources](../../manage/hybrid/server/best-practices/arc-inventory-tagging.md).

After you establish your tagging standards and bring on some of your assets, you can begin governing those resources by using familiar governance tools like Azure Policy. To assign policies to your hybrid and multicloud resources, see the recommended practices on [managing Azure Arc enabled servers with Azure Policy](../../manage/hybrid/server/best-practices/arc-policies-mma.md).

### Managed Identity

Whilst the Azure Active Directory system assigned identity can only be used the update the status of the Azure Arc-enabled server (for example, the 'last seen' heartbeat), it is possible to allow an application on your server to use the system assigned identity to access Azure resources (for example, to request secrets from a key vault.) Consider which legitimate use-cases exist for server applications to access Azure resources and plan to control access for to these resources. 

[Control which server applications can obtain access tokens](https://docs.microsoft.com/en-us/azure/azure-arc/servers/managed-identity-authentication)

- Control privileged user roles on Azure Arc-enabled servers (On Windows, members of the local administrators or Hybrid Agent Extensions Applications group, On Linux, members of the himds group) to avoid system managed identities being misused to gain unauthorized access to Azure resources.

- Use Azure RBAC to control and and manage the permission for Azure Arc-enabled servers managed identities, and perform periodic access reviews for these identities

### Agent Security permissions

Control who has access to the Azure connected machine agent on Azure Arc-enabled servers. The services that compose this agent control all communication and interaction for the Arc-enabled server to Azure. On Windows, members of the local administrator group, and on Linux users with root privileges have permissions to manage the agent.

### Disk encryption

The Azure Connected Machine agent uses public key authentication to communicate with the Azure service. After you onboard a server to Azure Arc, a private key is saved to the disk and used whenever the agent communicates with Azure. If stolen, the private key can be used on another server to communicate with the service and act as if it were the original server. This includes getting access to the system assigned identity and any resources that identity has access to. The private key file is protected to only allow the himds account access to read it. To prevent offline attacks, we strongly recommend the use of full disk encryption (for example, BitLocker, dm-crypt, etc.) on the operating system volume of your server

### Agent Provisioning

- if using a [service principal](https://docs.microsoft.com/en-us/azure/azure-arc/servers/onboard-service-principal) to provision Azure arc-enabled servers, consider how to securely store and distribute the service principle secret. Consider using [Azure Key vault](https://docs.microsoft.com/en-us/azure/key-vault/) for this purpose.

### Certificate Management

Consider using Azure key vault to manage certificates on your Azure Arc-enabled servers. Azure arc-enabled servers have a managed identity which you can use for accessing Azure resources such a [Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/general/overview) and for installing Azure VM extensions. The [Key Vault VM extension](https://techcommunity.microsoft.com/t5/itops-talk-blog/manage-certificates-on-your-hybrid-servers-using-azure-arc-key/ba-p/2142265) allows you to manage the certificate lifecycle on [Windows](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/key-vault-windows) and [Linux}](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/key-vault-linux) machines

## Governance disciplines

With a basic understanding of unified operations and Azure Arc, you can extend your disciplines of cloud governance to deployments hosted outside of your Azure environments.

Security baselines are among the most common ways that you can expand your governance disciplines in a unified operations scenario. The following best practices will help preserve your security baseline across all environments:

- [Collect and detect security data across clouds with Azure Security Center](/azure/security-center/quickstart-onboard-machines)
- [Investigate and respond to security threats with Azure Sentinel](/azure/sentinel/tutorial-investigate-cases)
- [Connect AWS accounts to Azure Defender](/azure/security-center/quickstart-onboard-aws)
- [Connect GCP accounts to Azure Defender](/azure/security-center/quickstart-onboard-gcp)

## Next steps

For more guidance for your cloud adoption journey, see the following article:

- [Manage hybrid and multicloud environments](./manage.md)