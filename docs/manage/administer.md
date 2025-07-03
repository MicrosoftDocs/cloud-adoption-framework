---
title: Administer your Azure cloud estate
description: Learn how to administer your Azure cloud estate and manage your cloud operations to ensure business alignment.
author: stephen-sumner
ms.author: pnp
ms.date: 04/01/2025
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Administer your Azure cloud estate

This article explains how to administer your Azure cloud estate to ensure operational health. You need strong administrative control over your cloud operations to ensure the cloud aligns with your business objectives.

:::image type="content" source="./media/caf-manage-administer.svg" alt-text="Diagram showing the CAF Manage process: ready, administer, monitor, and protect (RAMP)." lightbox="./media/caf-manage-administer.svg" border="false":::

## Identify your management scope

Management responsibilities vary by deployment model. Use the following table to identify your management responsibilities for infrastructure (IaaS), platform (PaaS), software (SaaS), and on-premises deployments.

| Administration areas                         | On-premises | IaaS (Azure) | PaaS (Azure) | SaaS       |
|----------------------------------------------|-------------|--------------|--------------|------------|
| [Change](#manage-change)                     | ✔️          | ✔️           | ✔️           | ✔️         |
| [Security](#manage-security)                 | ✔️          | ✔️           | ✔️           | ✔️         |
| [Compliance](#manage-compliance)             | ✔️          | ✔️           | ✔️           | ✔️         |
| [Data](#manage-data)                         | ✔️          | ✔️           | ✔️           | ✔️         |
| [Code and runtime](#manage-code-and-runtime) | ✔️          | ✔️           | ✔️           |            |
| [Cloud resources](#manage-cloud-resources)   | ✔️          | ✔️           | ✔️           |            |
| [Relocation](#manage-relocation)             | ✔️          | ✔️           | ✔️           |            |
| [Operating system](#manage-operating-systems)| ✔️          | ✔️           |              |            |
| Virtualization layer                         | ✔️          |              |              |            |
| Physical hardware                            | ✔️          |              |              |            |

## Manage change

Change is the most common source of problems in the cloud. As a result, you need a change management approach that tracks changes and their approvals. It should also detect unapproved changes and revert them to a desired state. Follow these steps:

1. ***Develop a change request process.*** Use a formal system, such as a ticketing tool, pull request (GitHub or Azure DevOps), or designated forms. The change request process must capture key details like the type of change, requester identity, target environment, scope, and the reason. Keep separate procedures for routine service requests like password resets.

1. ***Assess the risk associated with the change.*** Assign clear risk categories (high, medium, low) to balance deployment speed with risk management. Evaluate each change according to criteria like downtime tolerance (error budget) and workload criticality. To help determine the appropriate approval workflow, use the following table as an example:

    |Risk level|Downtime allowance|Workload criticality|Approval process|Example changes|
    |---|---|---|---|---|
    |High|No downtime allowed|These changes affect mission-critical systems that require continuous availability with zero tolerance for any downtime.|Multiple senior engineer reviews, automated pipeline alerts, [progressive exposure model](/azure/well-architected/operational-excellence/safe-deployments#adopt-a-progressive-exposure-model), and active monitoring.| Critical infrastructure updates|
    |Medium|Short downtime allowed|These changes affect important systems with limited tolerance for downtime.|Automated pipeline flags the change. Quick review by engineers if monitoring raises an alert.|Noncritical system updates, feature enhancements during short maintenance windows|
    |Low|Ample downtime allowed|These changes affect noncritical systems where extended downtime is acceptable without affecting overall operations.|Fully automated deployment via CI/CD runs predeployment tests and monitoring.|Routine updates, minor policy updates|

1. ***Standardize approval clearly.*** Define approval criteria and authority required at each risk level. Specify who must review each change, whether it's a single approver or a review board, and clarify how reviewers must provide and resolve feedback.

1. ***Standardize the deployment process.*** Clearly outline the procedures for building, testing, and deploying approved changes to production. For details, see [Manage cloud resources](#manage-cloud-resources).

1. ***Standardize the post-deployment process.*** To confirm successful changes, implement monitoring and validation steps. Include a clear rollback strategy to quickly restore service if a change introduces problems.

1. ***Prevent and detect unauthorized change.*** Use [Change Analysis](/azure/governance/resource-graph/changes/resource-graph-changes) to detect configuration changes and explain their underlying causes. Use Azure Policy to deny and audit changes using effects like [Deny](/azure/governance/policy/concepts/effect-deny), [DenyAction](/azure/governance/policy/concepts/effect-deny-action), [Audit](/azure/governance/policy/concepts/effect-audit), and [auditIfNotExists](/azure/governance/policy/concepts/effect-audit-if-not-exists). If you use Bicep, consider using [Bicep deployment stacks](/azure/azure-resource-manager/bicep/quickstart-create-deployment-stacks-template-specs) to prevent unauthorized changes.

## Manage security

Identity is your security perimeter. You must verify identities, restrict permissions, and maintain secure resource configurations. Follow these steps:

1. ***Manage identities.*** Use [Microsoft Entra ID](/entra/fundamentals/whatis) as your unified identity management solution. Clearly define permissions by applying [role-based access control (RBAC)](/entra/identity/role-based-access-control/custom-overview). Use [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview) to control access request workflows, access reviews, and identity lifecycle management. Enable [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) to grant just-in-time privileged access. This strategy reduces unnecessary elevated access. Manage all three identity types (user, application, device) consistently to ensure proper authentication and authorization.

1. ***Manage access.*** Use Azure [role-based access control](/azure/role-based-access-control/overview) (RBAC) and [attribute-based access control](/azure/role-based-access-control/conditions-overview) (ABAC) to grant the least permission to accomplish the job. To limit management overhead, prefer role assignments based on [groups](/azure/role-based-access-control/overview#groups). Grant permissions at the lowest required [scope](/azure/role-based-access-control/role-assignments-steps#step-3-identify-the-needed-scope), such as subscriptions, resource groups, or individual resources. Avoid overly broad permission scopes to prevent unintended privilege escalation. Assign only the necessary permissions for each user's role.

1. ***Manage resource configurations.*** Use [infrastructure as code](/devops/deliver/what-is-infrastructure-as-code) (IaC) to ensure consistent and reproducible configuration of resources. Then use [Azure Policy](/azure/governance/policy/samples/built-in-policies) to enforce secure configurations of specific Azure services. Reference the [Security baselines](/security/benchmark/azure/security-baselines-overview) for guidance on available security capabilities and optimal security configurations. As an add-on feature, use security policies in [Defender for Cloud](/azure/defender-for-cloud/security-policy-concept) to align with common security standards.

1. ***Manage authentication.*** Ensure users adopt strong authentication through multifactor authentication (MFA) and use [Microsoft Entra multifactor authentication (MFA)](/entra/identity/authentication/concept-mfa-howitworks). Always require [Conditional Access](/entra/identity/conditional-access/policy-all-users-mfa-strength) to enforce authentication based on user identity, device health, and access context. Configure [self-service password reset](/entra/identity/authentication/concept-sspr-howitworks) and [eliminate weak passwords](/entra/identity/authentication/concept-password-ban-bad-combined-policy).

1. ***Manage security information.*** Use [Microsoft Sentinel](/azure/sentinel/overview) for security information and even management (SIEM) and security orchestration, automation, and response (SOAR).

1. ***Control workload security.*** For workload security recommendations, see the Well-Architected Framework's [security checklist](/azure/well-architected/security/checklist#checklist) and [Azure service guides](/azure/well-architected/service-guides/#browse-the-catalog-of-azure-services) (*start with the Security section*).

## Manage compliance

Compliance management ensures that Azure operations remain aligned with established governance policies and regulatory standards. You must reduce risk by safeguarding the environment from potential violations and misconfigurations. Follow these steps:

1. ***Understand your governance policies.*** Governance policies define the high-level constraints that your teams must follow to remain compliant. Review your organization's policies and map each requirement to your operational processes. If you don't have governance policies, first [document governance policies](/azure/cloud-adoption-framework/govern/document-cloud-governance-policies).

1. ***Manage compliance.*** Enforcing compliance ensures your environment remains aligned with both organizational and regulatory standards. See the following table for policy recommendations.

    | Recommendation | Details |
    |----------------|---------|
    | Start with [General policy definitions](/azure/governance/policy/samples/built-in-policies#general) | Begin with Azure Policy's general definitions, including allowed locations, disallowed resource types, and audit custom RBAC roles. |
    | Align with [regulatory standards](/azure/governance/policy/samples/#regulatory-compliance) | Use Azure Policy's free, built-in definitions aligned with regulatory standards such as [ISO 27001](/azure/governance/policy/samples/iso-27001), [NIST SP 800-53](/azure/governance/policy/samples/nist-sp-800-53-r5), [PCI DSS](/azure/governance/policy/samples/pci-dss-4-0), [EU GDPR](/azure/governance/policy/samples/built-in-initiatives#regulatory-compliance) |

For more information, see [Enforcing compliance in Azure](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies#azure-facilitation-enforcing-cloud-governance-policies-automatically).

## Manage data

Managing data in cloud operations involves actively classifying, segmenting, securing access, and protecting against deletion. You must safeguard sensitive information, maintains compliance, and ensures data reliability during operational changes. Follow these steps:

1. ***Discover and classify data.*** Identify and categorize data according to sensitivity and importance. This classification guides tailored controls for each data type. Use [Microsoft Purview](/purview/data-governance-overview) for data governance. For more information, see [Data sources that connect to Microsoft Purview Data Map](/purview/microsoft-purview-connector-overview#azure).

1. ***Control data residency.*** Select regions within your [geography](/azure/reliability/regions-overview#understand-azure-regions-and-geographies), such as the United States or Europe, to meet data residency requirements. Verify any exceptions because [certain Azure services](https://azure.microsoft.com/explore/global-infrastructure/data-residency#select-your-geography) might store data outside your selected region. Regularly review Azure data residency settings and compliance requirements to maintain full control over your customer data.

1. ***Isolate internal (“Corp”) and internet-facing (“Online”) workloads.*** Use management groups to separate internal and external workloads. Internal workloads typically require connectivity or hybrid connectivity to your corporate network. External workloads usually don't require corporate network connectivity and might need direct inbound or outbound internet access. For an example, review the "Corp" (internal) and "Online" (internet-facing) management groups in [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups#management-groups-in-the-azure-landing-zone-accelerator-and-alz-bicep-repository).

1. ***Enforce access control.*** Implement robust access controls, such as [Azure RBAC](/azure/role-based-access-control/overview) and [Azure ABAC](/azure/role-based-access-control/conditions-overview), to ensure only authorized personnel access sensitive data based on defined classifications.

1. ***Protect data from deletion.*** Use features such as soft delete, data versioning, and immutability where available. Implement database versioning and prepare rollback procedures. Use Azure Policy to deny datastore deletions with [Deny](/azure/governance/policy/concepts/effect-deny) and [DenyAction](/azure/governance/policy/concepts/effect-deny-action) effects or audit changes with [Audit](/azure/governance/policy/concepts/effect-audit) and [auditIfNotExists](/azure/governance/policy/concepts/effect-audit-if-not-exists) any changes. If you use Bicep, consider using [Bicep deployment stacks](/azure/azure-resource-manager/bicep/quickstart-create-deployment-stacks-template-specs) to prevent unauthorized changes. Only use [resource locks](/azure/azure-resource-manager/management/lock-resources) strictly to prevent unintended modifications or deletions of critical data. Avoid using resource locks to protect configurations, as resource locks complicate IaC deployments.

1. ***Manage workload data.*** See the Well-Architected Framework's recommendations on [Data classification](/azure/well-architected/security/data-classification).

For more information, see [Enforce data governance](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies#automate-data-governance).

## Manage costs

Managing costs in cloud operations means tracking spending actively both centrally and per workload. Cost control should provide visibility into expenditures and encourage responsible spending. Follow these steps:

1. ***Manage and review costs.*** Use Microsoft Cost Management tools to [monitor cloud costs](/azure/cloud-adoption-framework/manage/monitor#monitor-costs). Azure lacks a subscription-wide mechanism to cap spending at a certain threshold. Some services, like [Azure Log Analytics workspace](/azure/azure-monitor/logs/daily-cap), have spending caps. Your cost monitoring strategy serves as your primary tool for managing expenses.

1. ***Manage workload costs.*** Grant billing access to workload teams. Have these teams use the Well-Architected Framework's Cost Optimization [checklist](/azure/well-architected/cost-optimization/checklist#checklist).

## Manage code and runtime

Managing code and runtime are workload responsibilities. Have your workload teams use the Well-Architected Framework's [Operational Excellence checklist](/azure/well-architected/operational-excellence/checklist#checklist), which outlines 12 recommendations to control code and runtime.

## Manage cloud resources

Establish clear deployment protocols and proactive drift and sprawl detection strategies to maintain consistency across environments. This section covers:

- [Portal deployments](#manage-portal-deployments)
- [Code deployments](#manage-code-deployments)
- [Configuration drift](#manage-configuration-drift)
- [Resource sprawl](#manage-resource-sprawl)

### Manage portal deployments

Define protocols and limits for portal deployments to minimize the potential for production problems. Follow these steps:

1. ***Define portal deployment policy.*** Ensure significant portal-based changes adhere to established change management processes. Use portal deployments primarily for rapid prototyping, troubleshooting, or minor adjustments in development and testing environments. Avoid unstructured portal changes because these changes lead to drift, misconfigurations, and compliance issues. Instead, rely on version-controlled infrastructure-as-code (IaC) templates for consistency. For more information, see [manage code deployments](#manage-code-deployments).

1. ***Differentiate environments.*** Limit portal-based changes strictly to nonproduction environments. Allow rapid prototyping exclusively in dedicated development or testing environments and enforce stringent controls in production.

1. ***Restrict portal permissions.*** Limit deployment capabilities from the portal using role-based access control (RBAC). Assign read-only permissions by default, and escalate privileges only when necessary.

    - ***Grant just-in-time access.*** Use [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-getting-started) for accessing Azure and Microsoft Entra resources. Require sequential approvals from multiple individuals or groups for activating PIM. Reserve privileged roles (“A0” super admin roles) exclusively for emergency scenarios.

    - ***Structure RBAC based on the operating model.*** Design RBAC policies tailored to operational teams, including support levels, security operations, platforms, networking, and workloads.

    - ***Audit all activities.*** Monitor and record all actions in your system. Use Azure Policy to audit ([Audit](/azure/governance/policy/concepts/effect-audit) or [auditIfNotExists](/azure/governance/policy/concepts/effect-audit-if-not-exists)) changes. Additionally, configure [alert in Azure Monitor](/azure/azure-monitor/alerts/alerts-create-log-alert-rule) to notify stakeholders when someone deletes an Azure resource. If you use Bicep, consider using [Bicep deployment stacks](/azure/azure-resource-manager/bicep/quickstart-create-deployment-stacks-template-specs) to prevent unauthorized changes.

1. ***Use version-controlled templates.*** Limit portal use to emergency scenarios if employing IaC deployments. Portal changes result in configuration drift from IaC templates. Replicate all portal-based changes immediately in version-controlled IaC templates, such as [Bicep](/azure/azure-resource-manager/bicep/), [Terraform](/azure/developer/terraform/), or [ARM](/azure/azure-resource-manager/templates/) templates. Regularly export Azure resource configurations and store them as IaC to maintain production environments aligned with approved, traceable configurations. See guidance on how export Azure configurations as [Bicep](/azure/azure-resource-manager/templates/export-template-portal), [Terraform](/azure/developer/terraform/azure-export-for-terraform/export-terraform-overview), or [ARM templates](/azure/azure-resource-manager/templates/export-template-portal). Consider [template specs](/azure/azure-resource-manager/templates/template-specs) if using ARM templates.

    | Tool | Use Case |
    |------|----------|
    | [Bicep](/azure/azure-resource-manager/bicep/) | Manageable, readable Azure-specific IaC |
    | [Terraform](/azure/developer/terraform/) | Multicloud solution, broader community support |
    | [ARM templates](/azure/azure-resource-manager/templates/) | Full control, comfortable with JSON |

### Manage code deployments

Adopt best practices to automate and control changes to code and infrastructure. Follow these steps:

1. ***Standardize tooling.*** Use a consistent toolset to minimize context switching. Choose developer tools (VS Code, Visual Studio), a code repository (GitHub, [Azure DevOps](/azure/devops/get-started/)), a CI/CD pipeline ([GitHub Actions](https://docs.github.com/actions), [Azure Pipelines](/azure/devops/pipelines/)), and an IaC solution ([Bicep](/azure/azure-resource-manager/bicep/modules), [Terraform](/azure/developer/terraform/), or [ARM](/azure/azure-resource-manager/templates/) templates) that work together.

1. ***Use version control.*** Maintain a single source of truth for your code. Use version control to reduce configuration drift and simplify rollback procedures.

1. ***Use deployment pipelines.*** A [CI/CD pipeline](/azure/devops/pipelines/architectures/devops-pipelines-baseline-architecture) automates the build process, runs tests, and scans code for quality and security issues with each pull request. Use [GitHub Actions](https://docs.github.com/actions) or [Azure Pipelines](/azure/devops/pipelines/) to build and deploy application code and IaC files. Enforce precommit hooks and automated scans to catch unauthorized or high-risk changes early.

1. ***Test deployments.*** Stage approvals within your CI/CD pipelines to validate deployments progressively. Follow this sequence: development, build verification, integration tests, performance tests, user acceptance testing (UAT), staging, canary releases, preproduction, and finally, production.

1. ***Use infrastructure as code (IaC).*** Use IaC to ensure consistency and manage deployments through version control. Move from Azure portal-based proof-of-concepts to IaC for production environments. Use [Bicep](/azure/azure-resource-manager/bicep/modules), [Terraform](/azure/developer/terraform/), or [ARM](/azure/azure-resource-manager/templates/) templates to define resources. For Bicep, use [modules](/azure/azure-resource-manager/bicep/modules) and consider [deployment stacks](/azure/azure-resource-manager/bicep/deployment-stacks?tabs=azure-powershell). For ARM template, consider [template specs](/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell) for versioned deployment.

1. ***Apply code repository best practices.*** Following these standards reduces errors, streamlines code reviews, and avoids integration issues. For high-priority production environments:

    | Requirement                      | Description                                                              |
    |----------------------------------|--------------------------------------------------------------------------|
    | Disable direct pushes            | Block direct commits to the main branch                                  |
    | Require pull requests            | Require all changes to pass through a pull request                       |
    | Require code reviews             | Ensure someone other than the author reviews every pull request          |
    | Enforce code coverage thresholds | Ensure a minimum percentage of code passes automated tests for all pull requests |
    | Use validation pipelines         | Configure branch protection rules to run a validation pipeline for pull requests |

1. ***Require workload team onboarding checks.*** Verify that new codebases and teams align with business goals, standards, and best practices. Use a checklist to confirm code repository structure, naming standards, coding standards, and CI/CD pipeline configurations.

### Manage configuration drift

Manage configuration drift by identifying and correcting discrepancies between your intended configuration and the live environment. Follow these best practices:

1. ***Prevent and detect change.*** Use [Change Analysis](/azure/governance/resource-graph/changes/resource-graph-changes) to detect configuration changes and explain their underlying causes. Use Azure Policy to deny and audit changes using effects like [Deny](/azure/governance/policy/concepts/effect-deny), [DenyAction](/azure/governance/policy/concepts/effect-deny-action), [Audit](/azure/governance/policy/concepts/effect-audit), and [auditIfNotExists](/azure/governance/policy/concepts/effect-audit-if-not-exists). If you use Bicep, consider using [Bicep deployment stacks](/azure/azure-resource-manager/bicep/quickstart-create-deployment-stacks-template-specs) to prevent unauthorized changes.

1. ***Detect IaC configuration drift.*** Drift occurs when someone updates the IaC file (intentional, unintentional) or makes a change in the Azure portal. Regularly compare the live environment with your desired configuration to detect drift:

    - ***Store desired and last-known-good configurations.*** Save your desired configuration file in a version-controlled repository. This file shows the original, intended configuration. Maintain a last-known-good configuration as a reliable rollback reference and drift detection baseline.

    - ***Detect configuration drift before deployment.*** Preview potential changes before deployment using [Terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan), [Bicep what-if](/azure/azure-resource-manager/bicep/deploy-what-if?tabs=azure-powershell%2CCLI), or [ARM template what-if](/azure/azure-resource-manager/templates/deploy-what-if). Investigate discrepancies thoroughly to ensure proposed changes align with the desired state.

	- ***Detect drift post deployment.*** Regularly compare live environments with desired configurations through regular drift checks. Integrate these checks into your CI/CD pipelines or conduct them manually to maintain consistency. See an example with [Azure Policy and Azure Pipelines](/azure/governance/policy/tutorials/policy-devops-pipelines).

	- ***Rollback to last-known-good configuration.*** Develop clear rollback strategies that use automated procedures within your CI/CD pipeline. Utilize your last-known-good configuration to quickly revert undesired changes and minimize downtime.

	- ***Minimize portal-driven changes.*** Minimize non-IaC changes to emergency scenarios only. Enforce strict access controls such as Privileged Identity Management. Promptly update IaC files if manual adjustments are necessary to preserve the accuracy of your desired configuration.

### Manage resource sprawl

Resource sprawl describes the uncontrolled growth of cloud resources. This growth increases costs, security risks, and management complexity. Follow these steps:

1. ***Implement governance policies.*** Use [Azure Policy](/azure/governance/policy/overview) to enforce standards for [resource provisioning](./administer.md#manage-cloud-resources) and [tagging](/azure/azure-resource-manager/management/tag-policies) across your organization. Create a clear [naming strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) for easier resource visibility.

2. ***Organize resources effectively.*** Structure resources hierarchically with management groups and subscriptions aligned to your organization's needs. This structure improves visibility and resource management. Refer to the [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) guidance for proven best practices.

3. ***Restrict deployment permissions.*** Implement role-based access control (RBAC) best practices outlined in [Azure RBAC](/azure/role-based-access-control/best-practices) and [Microsoft Entra RBAC](/entra/identity/role-based-access-control/best-practices). Assign appropriate permissions to users. Use reader roles to minimize unauthorized resource creation risks.

4. ***Conduct regular audits.*** Use [Azure Advisor](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) to identify unused or underutilized Azure resources. Use [Cost Management](/azure/cost-management-billing/costs/reporting-get-started) to analyze your cloud spending and remove orphaned resources causing unnecessary costs. Keep in mind not all Azure resources incur charges. Run queries in [Azure Resource Graph](/azure/governance/resource-graph/samples/starter) to maintain an accurate resource inventory.

## Manage relocation

Periodically evaluate your current Azure regions to determine if relocating workloads elsewhere improves efficiency, reduces costs, or enhances performance.

- ***Understand relocation drivers.*** Understanding relocation drivers ensures each relocation has valid business justification, given relocation involves risk and cost. Common business justifications for relocation include business expansion, regulatory compliance requirements, and proximity to end users.

- ***Manage relocation risks.*** Managing relocation risks prevents disruption and maintains compliance. Define acceptable downtime windows, communicate impacts to stakeholders, and ensure adherence to organizational policies and industry regulations.

- ***Manage relocation costs.*** Managing relocation costs prevents unnecessary spending during migration. Transfer data once, remove duplicate environments, and compare regional Azure prices. Review the [Azure bandwidth pricing](https://azure.microsoft.com/pricing/details/bandwidth).

- ***Manage relocation projects.*** Small teams should migrate workloads one at a time with focused execution. Large teams should relocate multiple workloads simultaneously to achieve efficiency through coordinated planning.

For more information, see [Relocate workloads](/azure/azure-resource-manager/management/relocate-index).

## Manage operating systems

Where you use virtual machines, you need to also manage the operating system. Follow these steps:

1. ***Automate virtual machine maintenance.*** In Azure, use [automation tools](/azure/virtual-machines/infrastructure-automation) to create and manage Azure virtual machines. Use [Azure Machine Configuration](/azure/governance/machine-configuration/overview) to audit or configure operating system settings as code for machines running in Azure and hybrid.

1. ***Update operating systems.*** You need to [manage guest updates and host maintenance](/azure/virtual-machines/updates-maintenance-overview) to ensure the operating systems are up to date for security purposes.

1. ***Monitor in-guest operations.*** Use the [Azure Change Tracking and Inventory service](/azure/automation/change-tracking/overview-monitoring-agent) to enhance the auditing and governance for in-guest operations. It monitors changes and provides detailed inventory logs for servers across Azure, on-premises, and other cloud environments.

## Azure management tools

| Category                                    | Tool                                                                 | Description                                                    |
|---------------------------------------------|----------------------------------------------------------------------|----------------------------------------------------------------|
| Manage change | [Change Analysis](/azure/governance/resource-graph/changes/resource-graph-changes) | Detects configuration changes and explains their underlying causes |
| Manage change | [Azure Policy](/azure/governance/policy/samples/built-in-policies) | Enforces, audits, or prevents modifications to cloud resources          |
| Manage change | [Bicep deployment stacks](/azure/azure-resource-manager/bicep/quickstart-create-deployment-stacks-template-specs) | Prevents unauthorized changes.
| Manage security | [Azure security baselines](/security/benchmark/azure/security-baselines-overview) | Provides guidance on available security capabilities and optimal security configurations |
| Manage security | [Well Architected Framework's security pillar](/azure/well-architected/security/) | Security guidance for workload design |
| Manage security | [Azure service guides](/azure/well-architected/service-guides/#browse-the-catalog-of-azure-services) (*start with the Security section*)| Security configuration recommendations for Azure services |
| Manage security                             | [Microsoft Entra ID](/entra/fundamentals/whatis)                     | Provides unified identity management                         |
| Manage security                             | [Defender for Cloud](/azure/defender-for-cloud/security-policy-concept) | Aligns resource configurations with security standards         |
| Manage security | [Microsoft Sentinel](/azure/sentinel/overview) | Provides security information and even management (SIEM) and security orchestration, automation, and response (SOAR) |
| Manage security                             | [Azure RBAC](/azure/role-based-access-control/overview)               | Grants secure access with role-based assignments               |
| Manage security                             | [Azure ABAC](/azure/role-based-access-control/conditions-overview)      | Grants secure access based on attribute conditions             |
| Manage security                             | [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview) | Manages access workflows and identity lifecycle           |
| Manage security                             | [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) | Offers just-in-time privileged access                     |
| Manage security                             | [Microsoft Entra multifactor authentication (MFA)](/entra/identity/authentication/concept-mfa-howitworks) | Enforces strong multifactor authentication                |
| Manage security                             | [Conditional Access](/entra/identity/conditional-access/concept-conditional-access-policy-common)      | Enforces context-based authentication                        |
| Manage security                             | [Self-service password reset](/entra/identity/authentication/concept-sspr-howitworks) | Allows secure user password resets                        |
| Manage compliance                           | [Azure Policy](/azure/governance/policy/samples/built-in-policies)       | Enforces standards and secures resource configurations          |
| Manage data                                 | [Microsoft Purview](/purview/data-governance-overview)                  | Governs and classifies sensitive data                          |
| Manage data                           | [Azure Policy](/azure/governance/policy/samples/built-in-policies)       | Prevents or audits unintended modifications or deletions of resources           |
| Manage data                                 | [Resource locks](/azure/azure-resource-manager/management/lock-resources) | Prevents unintended modifications or deletions                 |
| Manage costs | [Monitor costs](/azure/cloud-adoption-framework/manage/monitor#monitor-costs) | Monitoring is essential to managing cloud costs |
| Manage cloud resources | [Azure Policy](/azure/governance/policy/samples/built-in-policies) | Enforces, audits, or prevents modifications to cloud resources          |
| Manage cloud resources (portal deployments) | [ARM template export](/azure/azure-resource-manager/templates/export-template-portal) | Exports resource configurations as IaC templates         |
| Manage cloud resources (portal deployments) | [Azure Monitor alerts](/azure/azure-monitor/alerts/alerts-create-log-alert-rule) | Notifies stakeholders of resource changes                |
| Manage cloud resources (code deployments)   | [Bicep](/azure/azure-resource-manager/bicep/modules)                   | Manages infrastructure as code for Azure resources             |
| Manage cloud resources (code deployments)   | [Bicep deployment stacks](/azure/azure-resource-manager/bicep/deployment-stacks?tabs=azure-powershell) | Supports version-controlled deployments and prevents unauthorized changes |
| Manage cloud resources (code deployments)   | [Terraform](/azure/developer/terraform/)                               | Manages multicloud infrastructure as code                      |
| Manage cloud resources (code deployments)   | [ARM templates](/azure/azure-resource-manager/templates/)                | Defines and deploys Azure resources with templates               |
| Manage cloud resources (code deployments)   | [ARM Template specs](/azure/azure-resource-manager/templates/template-specs) | Versions and manages ARM templates for consistency              |
| Manage cloud resources (code deployments)   | [GitHub Actions](https://docs.github.com/actions)                      | Automates build, test, and deployment pipelines                  |
| Manage cloud resources (code deployments)   | [Azure Pipelines](/azure/devops/pipelines/)                            | Automates build and deployment processes                        |
| Manage drift | [Azure Policy](/azure/governance/policy/samples/built-in-policies) | Enforces, audits, or prevents modifications to cloud resources          |
| Manage drift                                | [Change Analysis](/azure/governance/resource-graph/changes/resource-graph-changes) | Detects and explains configuration changes                     |
| Manage drift                                | [Bicep what-if](/azure/azure-resource-manager/bicep/deploy-what-if?tabs=azure-powershell%2CCLI) | Previews potential configuration changes                       |
| Manage drift                                | [Terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan) | Previews potential changes before Terraform deployment           |
| Manage drift | [ARM template what-if](/azure/azure-resource-manager/templates/deploy-what-if) | Previews potential configuration changes |
| Manage operating systems                    | [Azure Machine Configuration](/azure/governance/machine-configuration/overview) | Audits and configures operating system settings as code         |
| Manage operating systems                    | [Azure Change Tracking and Inventory service](/azure/automation/change-tracking/overview-monitoring-agent) | Monitors and logs changes for operating systems                |
| Manage operating systems                    | [Automation tools](/azure/virtual-machines/infrastructure-automation) | Automates virtual machine maintenance                           |

## Next steps

> [!div class="nextstepaction"]
> [Monitor your Azure cloud estate](./monitor.md)

> [!div class="nextstepaction"]
> [CAF Manage checklist](./index.md#cloud-management-checklist)
