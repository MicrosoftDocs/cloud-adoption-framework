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

This article walks through key design considerations and best practices for security, governance, and compliance in hybrid, multicloud and edge deployments managed by Azure Arc, that should be in place as part of a CAF enterprise-scale landing zone implementation.

Defining and applying the proper control mechanisms is key in any cloud implementation as it is the foundational element to stay secured and compliant. These mechanisms in a traditional environment ussually meant review processes and manual controls, however the cloud has introduced a new approach to IT governance with automated guardrails and checks. Azure Policy, Azure Blueprints and Azure Security Center are cloud native tools that allow the implementation of these controls, reports, and remediation tasks in an automated fashion. By combining them with Azure Arc, your governance policies and security checks are extended to any resource in public or private clouds.

By the end of this article, you will understand the critical design areas for security, governance, and compliance with clear Microsoft's guidance.

## Design areas

As your hybrid and multicloud resources become part of Azure Resource Manager, they can be managed and governed with Azure tools just as Azure native VMs.

- **Resource consistency and inventory management:** organize your hybrid resources using Azure scopes of management and to locally organize them into a taxonomy. Apply tags to your non Azure deployments to add additional context that is relevant for your operations.
- **Agent Health Management:** the Connected Machine Agent plays a critical role in your hybrid operations as it enables you to manage your Windows and Linux machines hosted outside of Azure and enforce governance policies, it is important to implement solutions that keep track of unresponsive agents.
- **Agent Provisioning:** secret management and disk encryption https://docs.microsoft.com/en-us/azure/azure-arc/servers/security-overview
- **Secret and certificate management:** keyvault integration
- **Policy management and reporting:** define a governance plan for your hybrid servers and machines that translates into Azure Policies and remediation tasks.
- **Data Residency:** https://docs.microsoft.com/en-us/azure/azure-arc/servers/data-residency
- **Network Security:** Private Link, point to network security?
- **Log management strategy:** plan for metrics and log collection of your hybrid resources into a Log Analytics workspace for further analysis and auditing.
- **Threat protection and cloud security posture management:** introduce controls to detect security missconfigurations and track compliance. Also, leverage Azure's intelligence to protect your hybrid workloads againt threats.
- **Configuration management:** track changes on the operating system, application files and registry to identify operational and security issues on your on-premises and other clouds environments.
- **Software Updates:** define a strategy to assess the status of available updates to maintain security compliance with critical and security updates of your operating systems.
- **Backup and recovery strategy:**
- **Role based access controls:** define administrative, operations, and engineering roles within the organization that will take care of day-two operations in the hybrid environment. Mapping each team to actions and responsabilities will  determine Azure role-based access control (RBAC) roles and configuration. Consider using a RACI matrix to support this effort and build controls into the management scope hierarchy that you define following the resource consistency and inventory management guidance.
- **Identity:** managed identity

## Design recommendations

### Resource consistency and inventory management

Before onboarding any machine onto Azure Arc it is important to define a structure on how these resources will map to Azure management scopes: management groups, subscriptions and resource groups.  This mapping is key as it will how you will be able to interacy with these resources when applying RBAC roles and while assigning Azure policies as part of your governance model. Review the Cloud Adoption Framework recommendations on how to [organize resources](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagementGroupsAndHierarchy)

When designing your Be aware of subscription and service limits: https://docs.microsoft.com/en-us/azure/azure-arc/servers/agent-overview#azure-subscription-and-service-limits

As part of your cloud adoption journey you should also have a well-designed [naming standard](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=NamingStandards) that enables you to identify resources easily, make sure to align this naming standard with your already existing hybrid infrastructure as those resources will be part of your inventory in Azure. Be aware that the Linux hostname or Windows computer name of your hybrid resources cannot use [Azure's reserved words or trademarks](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/error-reserved-resource-name) as Azure Arc registration with Azure will fail.

https://docs.microsoft.com/en-us/azure/role-based-access-control/scope-overview

Creare a resource health alert and azure advisor alert https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate

### Policy management and reporting

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