---
title: Administer your Azure cloud estate
description: Learn how to administer your Azure cloud estate and provide control over your operations and business alignment.
author: stephen-sumner
ms.author: ssumner
ms.date: 03/14/2025
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Administer your Azure cloud estate

This article outlines how to administer your Azure estate. Administration is about controlling operational activities to maintain the health of your entire Azure estate. Poor administrative control creates operational, security, and cost-management issues that weaken your cloud's alignment with business objectives.

## Understand your control scope

Your administration responsibilities and scope of control varies by workload type. These administration responsibilities affect the decisions you make to manage your cloud estate. Infrastructure services (IaaS) and platform services (PaaS) operate within Azure and are distinct from the control scope for on-premises and software services (SaaS).

| Administration areas   | On-premises control scope | IaaS control scope (Azure) | PaaS control scope (Azure) | SaaS control scope |
|------------------------|---------------------------|----------------------------|----------------------------|--------------------|
| Data                   | X                         | X                          | X                          | X                  |
| Code and runtime       | X                         | X                          | X                          |                    |
| Cloud resources        | X                         | X                          | X                          |                    |
| Operating system       | X                         | X                          |                            |                    |
| Virtualization layer   | X                         |                            |                            |                    |
| Physical hardware      | X                         |                            |                            |                    |

## Control change

Change is the most common source of problems in the cloud. As a result, you need a change management approach that tracks changes and their approvals. It should also detect unapproved changes and revert them to a desired state. Here’s how:

1. ***Develop a change request process.*** Use a formal system, such as a ticketing tool, pull request (GitHub or Azure DevOps), or designated forms. The change request process must capture key details like the type of change, who requested the change, what environment is affected, the scope, and the reason. Have a separate section or process for service request, like password reset.

1. ***Assess the risk associated with the change.*** To balance speed and risk in change management, assign change risk levels to proposed changes. Classify changes into three risk levels: high, medium, or low risk. Assess factors like downtime allowance (error budget) and criticality. See the following table for an example.

|Risk level|Downtime allowance|Criticality|Approval process|Example changes|
|---|---|---|---|---|
|High|No downtime allowed|These changes affect mission-critical systems that require continuous availability with zero tolerance for any downtime.|Automated pipeline flags the change. Multiple senior engineers review via a [fast canary release](/azure/well-architected/operational-excellence/safe-deployments#adopt-a-progressive-exposure-model) and monitoring process.|Critical infrastructure updates|
|Medium|Short downtime allowed|These changes affect important systems with limited tolerance for downtime.|Automated pipeline flags the change. Quick review by engineers if monitoring raises an alert.|Noncritical system updates, feature enhancements during short maintenance windows|
|Low|Ample downtime allowed|These changes affect noncritical systems where extended downtime is acceptable without affecting overall operations.|Fully automated deployment via CI/CD runs predeployment tests and monitoring.|Routine updates, minor policy updates|

1. ***Standardize the change approval process.*** Establish clear criteria for approval and identify the authority levels required for different risk levels. Determine whether certain changes need a single approver or a full review board. Clarify who reviews each change and how feedback is provided and resolved

1. ***Standardize the deployment process.*** Define how you integrate changes into production. Specify procedures for build, testing, and release. For more information, see [Control deployments](#control-deployments).

1. ***Standardize the post-deployment process.*** Implement monitoring and validation steps to confirm successful changes. To restore a stable state quickly if problems arise, outline a rollback plan.

## Control security

Identity is your security perimeter. Verify the identity of all users and devices before granting access to resources. You need a common identity and access management platform to enforce secure authentication and authorization across all identities.

1. ***Control identities.*** Use [Microsoft Entra ID](/azure/entra/fundamentals/whatis) as your identity and access management platform to manage all three identity types. Apply role-based access control (RBAC) in [Microsoft Entra ID](/azure/entra/identity/role-based-access-control/custom-overview). Use [Microsoft Entra ID Governance](/azure/entra/id-governance/identity-governance-overview) to control access request workflows, access reviews, identity lifecycle management, and [enable just-in-time access](/azure/entra/id-governance/privileged-identity-management/pim-configure) (Privileged Identity Management) to important resources.

1. ***Control access.*** Use Azure [role-based access control](/azure/role-based-access-control/overview) (RBAC) and [attribute-based access control](/azure/role-based-access-control/conditions-overview) (ABAC) to grant the least permission to accomplish the job. Prefers role assignments based on [groups](/azure/role-based-access-control/overview#groups) to limit management overhead. Apply the permission at the smallest [scope](/azure/role-based-access-control/role-assignments-steps#step-3-identify-the-needed-scope) needed. Applying permissions at too broad of a scope can lead to elevated permissions. Most users only need access to subscriptions, resource groups, or resources.

1. ***Control resource configurations.*** Use [infrastructure as code](/azure/devops/deliver/what-is-infrastructure-as-code) (IaC) to ensure consistent and reproducible configuration of resources. Then use Azure Policy to enforce organizational standards and assess compliance. Then use [Azure Policy](/azure/governance/policy/samples/built-in-policies) to enforce secure configurations of specific Azure services. Reference the [Security baselines](/azure/security/benchmark/azure/security-baselines-overview) for guidance on available security capabilities and optimal security configurations. As an add-on feature, use security policies in [Defender for Cloud](/azure/defender-for-cloud/security-policy-concept) to align with common security standards.

1. ***Control authentication.*** Enable [Microsoft Entra multifactor authentication (MFA)](/azure/entra/identity/authentication/concept-mfa-howitworks). Configure[self-service password reset](/azure/entra/identity/authentication/concept-sspr-howitworks) and [eliminate weak passwords](/azure/entra/identity/authentication/concept-password-ban-bad-combined-policy). Use [conditional access](/azure/entra/identity/conditional-access/overview) policies to grant or block user and [device identities](/azure/entra/identity/devices/overview) access to cloud services.

## Control compliance

Compliance management ensures that Azure operations remain aligned with established governance policies and regulatory standards. This practice reduces risk by safeguarding the environment from potential violations and misconfigurations.

1. ***Understand your governance policies.*** Governance policies define the high-level constraints that your teams must follow to remain compliant. Review your organization’s policies and map each requirement to your operational processes. If you don’t have governance policies, first [document governance policies](/azure/cloud-adoption-framework/govern/document-cloud-governance-policies).

1. ***Control compliance.*** Enforcing compliance ensures your environment remains aligned with both organizational and regulatory standards. In the [General](/azure/governance/policy/samples/built-in-policies#general) policy definitions of Azure Policy, start with allowed locations, disallowed resource types, and audit custom RBAC roles. Next, use Azure Policy’s free, built-in definitions that align with many [regulatory standards](/azure/governance/policy/samples/#regulatory-compliance), such as [ISO 270001](/azure/governance/policy/samples/iso-27001), [NIST SP 800-53](/azure/governance/policy/samples/nist-sp-800-53-r5), [PCI DSS](/azure/governance/policy/samples/pci-dss-4-0), and [EU General Data Protection Regulation (GDPR)](/azure/governance/policy/samples/built-in-initiatives#regulatory-compliance).

For more information, see [Enforcing compliance in Azure](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies#azure-facilitation-enforcing-cloud-governance-policies-automatically).

## Control data

Controlling data in cloud operations means actively managing data by classifying, segmenting, restricting access, and protecting against deletion. Controlling data proves important because it secures sensitive information, supports compliance, and ensures data remains reliable during changes.

1. ***Discover and classify data.*** Identify and categorize data based on sensitivity and importance. This classification establishes a baseline for applying tailored controls to various data types. Use [Microsoft Purview](/azure/purview/data-governance-overview) for data governance. For more information, see [Data sources that connect to Microsoft Purview Data Map.](/azure/purview/microsoft-purview-connector-overview#azure)

1. ***Control data residency.*** If you have data residency requirements, select regions within your [geography](/azure/reliability/regions-overview#understand-azure-regions-and-geographies), such as the United States or Europe. Verify any exceptions, since [certain Azure services](https://azure.microsoft.com/explore/global-infrastructure/data-residency#select-your-geography) might store data outside your selected region. Lastly, regularly review your Azure data residency settings and compliance requirements to maintain full control over your customer data.

1. ***Isolate internal (“Corp”) and internet-facing (“Online”) workloads.*** Use management groups to separate workloads that are internal or external. Internal workloads usually have the requirement of connectivity, or hybrid connectivity, to the corporate network. External workloads don't require connectivity to corporate networks and might require direct inbound or outbound internet access. For an example, see the "Corp" (internal) and "Online" (internet-facing) management groups in [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups#management-groups-in-the-azure-landing-zone-accelerator-and-alz-bicep-repository).

1. ***Enforce access control.*** Implement robust access control mechanisms, such as Azure RBAC and ABAC, to ensure that only authorized personnel can access sensitive data, aligning with the defined classification.

1. ***Protect data from deletion.*** Use features like soft delete, data versioning, and data immutability, where available. Implement database versioning and prepare rollback procedures. Use Azure Policy to deny the deletion of datastores ([Deny](/azure/governance/policy/concepts/effect-deny) or [DenyAction](/azure/governance/policy/concepts/effect-deny-action)) or audit ([Audit](/azure/governance/policy/concepts/effect-audit) or [auditIfNotExists](/azure/governance/policy/concepts/effect-audit-if-not-exists)) changes. If you use Bicep, consider using [Bicep deployment stacks](/azure/azure-resource-manager/bicep/quickstart-create-deployment-stacks-template-specs) to prevent unauthorized changes. Only use [resource locks](/azure/azure-resource-manager/management/lock-resources) only to prevent unwanted modifications or deletion of critical data, not to protect configurations. They complicate IaC deployments.

1. ***Control workload data.*** Establish controls at the workload level by ensuring that each workload manages its data in line with the organization’s overall policies. Monitor and manage how workload-specific data is accessed, processed, and stored. See the Well-Architected Framework’s recommendations on [Data classification.](/azure/well-architected/security/data-classification)

For more information, see [Enforce data governance](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies#automate-data-governance).

## Control costs

Controlling costs in cloud operations means tracking spending actively both centrally and per workload. Cost control should provide visibility into expenditures and encourage responsible spending. Here’s how

- ***Monitor and review costs.*** Azure lacks a subscription-wide mechanism to cap spending at a certain threshold. Some services, like [Azure Log Analytics workspace](/azure/azure-monitor/logs/daily-cap), have spending caps. Your cost monitoring strategy serves as your primary tool for managing expenses. Use this guidance on how to [monitor cloud costs](/azure/cloud-adoption-framework/manage/monitor#monitor-costs).
- ***Control workload costs.*** Grant billing access to workload teams. Have these teams use the Well-Architected Framework’s Cost Optimization [checklist](/azure/well-architected/cost-optimization/checklist#checklist).

## Control code and runtime

Controlling code and runtime are workload responsibilities. Have your workload teams use the Well-Architected Framework’s [Operational Excellence checklist](/azure/well-architected/operational-excellence/checklist#checklist), which outlines 12 recommendations to control code and runtime.

## Control cloud resources

Controlling cloud resources means managing, governing, and maintaining oversight of all services, deployments, and infrastructure across your Azure estate. Effective control ensures resources align with your organization's standards, security policies, and compliance requirements.

### Control deployments

Standardizing deployment means creating repeatable, consistent processes for creating new services and delivering software and infrastructure changes. Standardized deployments reduce errors and accelerate delivery.

#### Control portal-based deployments

Define protocols and limits for portal-based deployments to minimize the potential for production problems. Here’s how:

1. ***Define portal deployment policy.*** Ensure all significant portal-driven changes follow established change management processes. Portal-based deployments are great for rapid prototyping, troubleshooting, or small modifications in development and testing environments. Unstructured portal changes can cause drift, misconfigurations, and compliance gaps. Instead, use version-controlled infrastructure-as-code (IaC) templates to keep your environment consistent. See [code-based deployments](#control-code-based-deployments).

1. ***Differentiate environments.*** Define clear boundaries among development, testing, and production environments. Avoid using the portal for production changes. Allow portal-based changes only in approved environments. Permit rapid prototyping in dedicated development or testing environments and enforce strict controls in production.

1. ***Restrict portal permissions.*** Limit who can deploy from the portal using role-based access control (RBAC). Assign read-only permissions by default and elevate access only when necessary.

    - ***Grant just-in-time access.*** Use [Privileged Identity Management (PIM)](/azure/entra/id-governance/privileged-identity-management/pim-getting-started) to access Azure and Microsoft Entra resources. Require approvals from multiple individuals or groups in a sequential manner for PIM activations. Only use privileged roles (“A0” super admin roles) for emergencies.

    - ***Structure RBAC based on the operating model.*** Design your RBAC policies around different operational teams. For example, have policies for different support levels, security operations, platform, networking, and workloads.

    - ***Audit all activities.*** Monitor and record all actions in your system. Use Azure Policy to audit ([Audit](/azure/governance/policy/concepts/effect-audit) or [auditIfNotExists](/azure/governance/policy/concepts/effect-audit-if-not-exists)) changes. If you use Bicep, consider using [Bicep deployment stacks](/azure/azure-resource-manager/bicep/quickstart-create-deployment-stacks-template-specs) to lock resources and prevent unauthorized changes. You can also create an [alert in Azure Monitor](/azure/azure-monitor/alerts/alerts-create-log-alert-rule) to notify stakeholders when someone deletes an Azure resource.

1. ***Use version-controlled templates.*** If you're using IaC deployments, limit portal usage to emergencies only. Portal changes cause configuration drift from IaC files. For portal changes, replicate all portal-based changes in version-controlled IaC templates, such as [Bicep](/azure/azure-resource-manager/bicep/modules), [Terraform](/azure/developer/terraform/), or [ARM](/azure/azure-resource-manager/templates/) templates. Replicating your resource configurations to IaC ensures production environments reflect an approved, trackable configuration. Consider [exporting](/azure/azure-resource-manager/templates/export-template-portal) your Azure resource configurations and store them as code, for example, as [Bicep](/azure/azure-resource-manager/templates/export-template-portal), [Terraform](/azure/developer/terraform/azure-export-for-terraform/export-terraform-overview), or [ARM templates](/azure/azure-resource-manager/templates/export-template-portal). You can export Azure resource configurations into Bicep or ARM templates. If you use ARM templates, consider using template specs.

| Tool | Use Case |
|------|----------|
| [Bicep](/azure/azure-resource-manager/bicep/modules) | Manageable, readable Azure-specific IaC |
| [Terraform](/azure/developer/terraform/) | Multicloud solution, broader community support |
| [ARM](/azure/azure-resource-manager/templates/) templates | Full control, comfortable with JSON |

#### Control code-based deployments

Adopt code-based deployments to automate and control complex or large-scale changes. Here’s how:

1. ***Standardize tooling.*** Use a consistent toolset to minimize context switching. Choose developer tools (VS Code, Visual Studio), a code repository (GitHub, [Azure DevOps](/azure/devops/get-started/?view=azure-devops)), a CI/CD pipeline ([GitHub Actions](https://docs.github.com/actions), [Azure Pipelines](/azure/devops/pipelines/?view=azure-devops)), and an IaC solution ([Bicep](/azure/azure-resource-manager/bicep/modules), [Terraform](/azure/developer/terraform/), or [ARM](/azure/azure-resource-manager/templates/) templates) that work together.

1. ***Use version control.*** Maintain a single source of truth for your code. Use version control to reduce configuration drift and simplify rollback procedures.

1. ***Use deployment pipelines.*** A [CI/CD pipeline](/azure/devops/pipelines/architectures/devops-pipelines-baseline-architecture?view=azure-devops) automates the build process, runs tests, and scans code for quality and security issues with each pull request. Use [GitHub Actions](https://docs.github.com/actions) or [Azure Pipelines](/azure/devops/pipelines/?view=azure-devops) to build and deploy application code and IaC files. Enforce precommit hooks and automated scans to catch unauthorized or high-risk changes early.

1. ***Test deployments.*** Your CI/CD pipelines should stage approvals to test deployments before promoting changes. Follow a sequence that includes development, build verifications, integration tests, performance tests, user acceptance testing (UAT), staging, canary releases, preproduction, and production.

1. ***Use infrastructure as code (IaC).*** Use IaC to maintain consistent and version-controlled deployments. Transition from using the Azure portal for proof-of-concepts to using IaC for production. Use [Bicep](/azure/azure-resource-manager/bicep/modules), [Terraform](/azure/developer/terraform/), or [ARM](/azure/azure-resource-manager/templates/) templates to define resources. For Bicep, use [modules](/azure/azure-resource-manager/bicep/modules) and consider [deployment stacks](/azure/azure-resource-manager/bicep/deployment-stacks?tabs=azure-powershell). For ARM template, consider use [template specs](/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell) for versioned deployment.

1. ***Apply code repository best practices.*** Implementing these standards reduces errors, streamlines code reviews, and prevents integration issues. For high-priority production environments:

| Requirement                      | Description                                                              |
|----------------------------------|--------------------------------------------------------------------------|
| Disable direct pushes            | Block direct commits to the main branch                                  |
| Require pull requests            | Require all changes to pass through a pull request                       |
| Require code reviews             | Ensure someone other than the author reviews every pull request          |
| Enforce code coverage thresholds | Ensure a minimum percentage of code passes automated tests for all pull requests |
| Use validation pipelines         | Configure branch protection rules to run a validation pipeline for pull requests |

1.***Require workload team onboarding checks.*** Verify that new codebases and teams align with business goals, standards, and best practices. Use a checklist to confirm code repository structure, naming standards, coding standards, and CI/CD pipeline configurations.

### Control configuration drift

Control configuration drift by detecting and correcting deviations between your intended configuration and your live environment. Here’s how:

1. ***Prevent and detect change.*** Use [Change Analysis](/azure/governance/resource-graph/changes/resource-graph-changes) to detect configuration changes and explain their underlying causes. Use Azure Policy to deny the deletion of datastores ([Deny](/azure/governance/policy/concepts/effect-deny) or [DenyAction](/azure/governance/policy/concepts/effect-deny-action)) or audit ([Audit](/azure/governance/policy/concepts/effect-audit) or [auditIfNotExists](/azure/governance/policy/concepts/effect-audit-if-not-exists)) changes. If you use Bicep, consider using [Bicep deployment stacks](/azure/azure-resource-manager/bicep/quickstart-create-deployment-stacks-template-specs) to prevent unauthorized changes.

1. ***Detect IaC configuration drift.*** Drift occurs when someone updates the IaC configuration (intentional, unintentional) or makes a change in the Azure portal. You detect drift by comparing the live configuration with the desired configuration. Here’s how:

    - ***Store desired and last-known-good configurations.*** Save your desired configuration file in a version-controlled repository. This file shows the original, intended configuration. Also store the last-known-good configuration of that workload. It serves as a proven baseline and gives you a rollback option if problems arise. It also serves to detect drift between your original configuration and any intentional configuration updates you didn't made official.

    - ***Detect configuration drift before deployment.*** Before deployment, preview the proposed configuration change. Run [Terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan), [Bicep what-if](/azure/azure-resource-manager/bicep/deploy-what-if?tabs=azure-powershell%2CCLI), or [ARM template what-if](/azure/azure-resource-manager/templates/deploy-what-if?tabs=azure-powershell) operations before deployment to preview the changes the deployment would make. If it detects change, investigate whether your proposed configuration or the live configuration contains drift from the desired configuration.

	- ***Detect drift post deployment.****Schedule drift detection runs that compare the live configuration and your desired configuration. Integrate these checks into your deployment pipeline or run them manually.

	- ***Rollback to last-known-good configuration.*** Create rollback strategies to minimize downtime and mitigate risks. When drift occurs, use the last-known-good configuration to decide whether to revert the change or update the baseline. Use automated rollback procedures in your CI/CD pipeline.

	- ***Minimize portal-driven changes.*** Limit direct changes outside IaC to emergencies. Non-IaC changes are a primary source of drift. Use strict controls, such as Privileged Identity Management, to restrict access. If you modify resources outside IaC (via the portal or CLI), update the desired configuration to reflect these changes if you plan to keep them.

## Control operating systems

Where you use virtual machines, you need to also control the operating system. Here’s how

1. ***Automate virtual machine maintenance.*** In Azure, use [automation tools](/azure/virtual-machines/infrastructure-automation) to create and manage Azure virtual machines. Use [Azure Machine Configuration](/azure/governance/machine-configuration/overview) to audit or configure operating system settings as code for machines running in Azure and hybrid.

1. ***Update operating systems.****You need to [manage guest updates and host maintenance](/azure/virtual-machines/updates-maintenance-overview) to ensure the operating systems are up to date for security purposes.

1. ***Monitor in-guest operations.*** Use the [Azure Change Tracking and Inventory service](/azure/automation/change-tracking/overview-monitoring-agent) to enhance the auditing and governance for in-guest operations. It monitors changes and provides detailed inventory logs for servers across Azure, on-premises, and other cloud environments.
