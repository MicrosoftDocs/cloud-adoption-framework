---
title: Enforce cloud governance policies
description: Learn how to enforce cloud governance policies using automated and manual approaches.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Enforce cloud governance policies

This article shows you how to enforce cloud governance policies. Cloud governance enforcement refers to the controls and procedures that align cloud activity to the cloud governance policies. After the cloud governance team assesses cloud risks and creates cloud governance policies to manage those risks, they must ensure the enforcement of the cloud governance policies. They must delegate governance enforcement responsibilities. The goal is to empower each team or individual to enforce cloud governance policies within their area of responsibility. The cloud governance team can’t do it all. Prefer automated enforcement controls but enforce policies manually where you can’t automate.

:::image type="content" source="./_images/enforce.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continously to maintain cloud governance." lightbox="./_images/enforce.svg" border="false":::

## Define an approach to enforcing cloud governance policies

Establish a systematic strategy to enforce cloud governance policies. The goal is to use automated tools and manual oversight to enforce policies efficiently. To define an enforcement approach, follow these recommendations:

- *Delegate governance responsibilities.* Empower individuals and teams to enforce governance within their scope of responsibility. For example, platform teams should apply policies that workloads inherit. Workload teams should enforce governance for their workload. The cloud governance team shouldn’t be responsible for applying enforcement controls.

- *Adopt an inheritance model.* Apply a hierarchical governance model where specific workloads inherit governance policies from the platform team. This model helps ensure organizational standards apply to the correct environments, such as purchasing requirements for cloud services.

- *Discuss enforcement specifics*. Discuss where and how you apply governance policies. The goal is to find cost effective ways to enforce governance that accelerates productivity. Without a discussion, you risk blocking the progress of specific teams. It's important to find a balance that supports the business objectives while managing risk effectively.

- *Have an audit-first stance.* Don’t block certain actions unless you know they are high risk, such as for understood security and compliance reasons. Lower-risk enforcement controls should start by monitoring compliance with cloud governance policies. Once you understand organizational needs, you should move to more restrictive enforcement policies. A monitor-first approach gives you an opportunity to discuss the need and realign the policy to that need.

- *Prefer deny lists*: Use deny lists over allow lists. Deny lists prevent the deployment of specific services. It’s better to have a small list of services that you shouldn’t use than a long list of services you can use.

- *Define a tagging and naming strategy.* Establish systematic guidelines for naming and tagging cloud resources. It provides a structured framework for resource categorization, cost management, security, and compliance across the cloud environment. Allow teams, such as development teams, to add additional tags for their unique needs.

## Enforce cloud governance policies automatically

Use cloud management and governance tools to automate the enforcement of governance policies. These tools can help in setting up guardrails, monitoring configurations, and ensuring compliance. To set up automated enforcement, follow these recommendations:

- *Start with a small set of automated policies.* Begin automating a minimal set of essential cloud governance policies. Implement and test automation to avoid operational disruptions. Automate additional policies when ready.

- *Use cloud governance tools*. Use the tools available in your cloud environment to enforce governance. Azure’s primary governance tool is [Azure Policy](/azure/governance/policy/overview). Supplement Azure Policy with [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) (security), [Microsoft Purview](/purview/purview) (data), [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview) (identity), [Azure Monitor](/azure/azure-monitor/overview) (operations), [management groups](/azure/governance/management-groups/overview) (resource management), [infrastructure as code](/devops/deliver/what-is-infrastructure-as-code) (resource management), and configurations within each Azure service.

- *Apply governance policies at the right scope.* Use an inheritance system where policies are set at a higher level, such as management group. Policies at higher level automatically apply to lower levels, such as subscriptions and resource groups. Policies apply even when there’s changes within the cloud environment, lowering management overhead.

- *Use policy enforcement points.* Set up policy enforcement points within your cloud environments that automatically apply governance rules. This can include pre-deployment checks, runtime monitoring, and automated remediation actions.

- *Use policy-as-code.* Use IaC tools to [enforce governance policies through code](/azure/governance/policy/concepts/policy-as-code)*.* Policy as code enhances the automation of governance controls and ensures consistency across different environments.

- *Develop custom solutions as needed.* For custom governance actions, consider developing custom scripts or applications. Use Azure service APIs to gather data or manage resources directly.

### Azure facilitation: Enforcing cloud governance policies automatically

The following guidance is meant to help you automate cloud governance policies in Azure. It provides a sample starting point for major categories of cloud governance.

#### Automate regulatory compliance governance in Azure

Achieve continuous alignment with global compliance standards through automated enforcement controls with minimal manual oversight.

- *Apply regulatory compliance policies*. Use [built-in regulatory compliance policies](/azure/governance/policy/samples/#regulatory-compliance) that align with compliance standards, such as HITRUST/HIPAA, ISO 27001, CMMC, FedRamp, and PCI DSSv4. [Create custom policies](/azure/governance/policy/tutorials/create-custom-policy-definition) to define your own rules for working with Azure.

#### Automate cloud security governance in Azure

Secure cloud environments automatically by enforcing best practices and compliance with security frameworks.

- *Apply security policies.* Use the [built-in security policies](/azure/governance/policy/samples/) and [automated security compliance](/azure/defender-for-cloud/security-policy-concept) with standards, such as NIST 800 SP series, Center for Internet Security benchmarks, and the Microsoft cloud security benchmark. Use built-in policies to [automate the security configuration](/azure/governance/policy/samples/built-in-policies) of specific Azure services. [Create custom policies](/azure/governance/policy/tutorials/create-custom-policy-definition) to define your own rules for working with Azure.

- *Apply identity governance.* Enable [multi-factor authentication](/entra/identity/authentication/concept-mfa-howitworks) and [self-service password reset](/entra/identity/authentication/concept-sspr-howitworks). [Eliminate weak passwords](/entra/identity/authentication/concept-password-ban-bad-combined-policy). Automate other aspects of [identity governance](/entra/id-governance/identity-governance-overview), such as access request workflows, access reviews, and identity lifecycle management. [Enable just-in time access](/entra/id-governance/privileged-identity-management/pim-configure) to limit access to important resources.

- *Apply access controls*. Use [Azure role-based access controls](/azure/role-based-access-control/overview) (RBAC) and [attribute-access controls](/azure/role-based-access-control/conditions-overview) (ABAC) to govern access to specific resources. Grant and deny permissions to users and groups. Apply the permission at the appropriate [scope](/azure/role-based-access-control/scope-overview) (management group, subscription, resource group, or resource) to provide only the permission needed and limit management overhead.

#### Automate cloud cost governance in Azure

Automate cost monitoring, budgeting, and optimization processes that prevent overspending and ensure costs align with business goals.

- *Automate deployment restrictions.* [Disallow certain cloud resources](/azure/governance/policy/tutorials/disallowed-resources) from deploying to prevent use of cost-intensive resources. [Create custom policies](/azure/governance/policy/tutorials/create-custom-policy-definition) to define your own rules for working with Azure.

- *Automate cost allocation.* Enforce tagging requirements to [group and allocate costs](/azure/cost-management-billing/costs/enable-tag-inheritance) across environment (e.g., dev, test, prod), department, or project. Use tags to identify and track resources that are part of a cost optimization effort.

#### Automate cloud operations governance in Azure

Ensure high availability, data protection, and disaster recovery through automated operational policies.

- *Automate redundancy.* Use built-in Azure policies to require a specified level of infrastructure redundancy, such as zone redundant and geo-redundant instances.

- *Automate backups.* Use [backup policies](/azure/backup/backup-center-govern-environment) to govern backup frequency, retention period, and storage location. Align backups policies with data governance and regulatory compliance requirements. Use the backup settings in individual Azure services, such as [Azure SQL Database](/azure/azure-sql/database/automated-backups-overview), to configure the settings you need.

- *Meet target service level objective.* Restrict the deployment of certain services and service tiers (SKUs) that don’t meet your target service level objective. For example, use the `Not allowed resource types` policy definition in Azure Policy.

#### Automate cloud data governance in Azure

Automate the management, storage, and processing of data in compliance with regulations. Ensure data privacy, security, and lifecycle management without manual intervention.

- *Automate data governance.* Automate [data governance](/purview/governance-solutions-overview) tasks, such as cataloging, mapping, securely sharing, and applying policies.

- *Automate data lifecycle management.* Implement storage policies and [lifecycle management for storage](/azure/storage/blobs/lifecycle-management-policy-configure?tabs=azure-portal) to ensure data is stored efficiently and compliantly.

- *Automate data security.* Review and enforce [data protection strategies](/azure/security/fundamentals/protection-customer-data), such as data segregation, encryption, and redundancy.

#### Automate cloud resource management governance in Azure

Achieve streamlined and compliant resource provisioning and management through automated tagging, deployment restrictions, and infrastructure as code practices. Ensure consistency and operational efficiency across environments.

- *Create a resource management hierarchy.* Use [management groups](/azure/governance/management-groups/overview) to organize your subscriptions so that you can efficiently govern policies, access, and spending. Follow Azure landing zone [resource organization](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org) best practices.

- *Enforce a tagging strategy.* Ensure all Azure resources are consistently tagged to improve manageability, cost tracking, and compliance. [Define your tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging) and [Manage tag governance](/azure/governance/policy/tutorials/govern-tags).

- *Restrict which resources you can deploy.* [Disallow resource types](/azure/governance/policy/tutorials/disallowed-resources) to restrict deployments of services that add unnecessary risk.

- *Restrict deployments to specific regions.* Control where resources are deployed to comply with regulatory requirements, manage costs, and reduce latency. For example, use the `Allowed locations` policy definition in Azure Policy. Also [enforce regional restrictions](/azure/governance/policy/tutorials/policy-devops-pipelines) in your deployment pipeline.

- *Use infrastructure as code.* Automate infrastructure deployments using [Bicep, Terraform, or ARM templates](/azure/templates/). Store your IaC configurations in a source control system (GitHub, Azure Repos) to track changes and collaborate.

- *Use a CI/CD pipeline.* A CI/CD pipeline can ensure deployments adhere to predefined governance rules and policies. [Integrate compliance scans](/azure/governance/policy/how-to/get-compliance-data#on-demand-evaluation-scan) into CI/CD pipelines to enforce governance.

- *Govern hybrid and multi-cloud environments.* [Govern hybrid and multi-cloud resources](/azure/azure-arc/overview). Maintain consistency in management and policy enforcement.

#### Automate AI governance in Azure

Ensure ethical use, content integrity, and compliance with security standards, using automation to prevent misuse and enhance trustworthiness.

- *Use the retrieval augmented generation (RAG) pattern.* RAG adds an information retrieval system to control the grounding data a large language model uses to generate a response. Use Azure OpenAI on [your own data](/azure/ai-services/openai/concepts/use-your-data) or set up RAG with [Azure AI Search](/azure/search/retrieval-augmented-generation-overview) to constrain generative AI to your content.

- *Use AI development tools.* Use AI tools, like Semantic Kernel, that facilitate and standardize AI orchestration when developing applications that use AI.

- *Govern output generation.* Help [prevent abuse and harmful content generation](/legal/cognitive-services/openai/data-privacy). Use [AI content filtering](/azure/ai-services/openai/concepts/content-filter?) and [AI abuse monitoring](/azure/ai-services/openai/concepts/abuse-monitoring).

- *Configure data loss prevention.* Configure [data loss prevention for Azure AI services](/azure/ai-services/cognitive-services-data-loss-prevention?tabs=azure-cli). Configure the list of outbound URLs their Azure AI services resources are allowed to access.

- *Use system messages.* Provide meta prompts to guide the behavior of an AI system. Use [system messages](/azure/ai-services/openai/concepts/system-message) to tailor the generated outputs.

- *Apply the AI security baseline.* Use the [Azure AI security baseline](/security/benchmark/azure/baselines/cognitive-services-security-baseline) to govern the security of AI systems.

## Enforce cloud governance policies manually

Sometimes a tool limitation or cost makes automated enforcement unpractical. In cases where you can’t automate enforcement, enforce cloud governance policies manually. To manually enforce cloud governance, follow these recommendations:

- *Use checklists.* Use governance checklists to make it easy for your teams to follow the cloud governance policies. For more information, see the [example compliance checklists](#example-cloud-governance-compliance-checklists).

- *Provide regular training.* Conduct frequent training sessions for all relevant team members to ensure they are aware of the governance policies.

- *Schedule regular reviews.* Implement a schedule for regular reviews and audits of cloud resources and processes to ensure compliance with governance policies. These reviews are critical for identifying deviations from established policies and taking corrective actions.

- *Monitor manually.* Assign dedicated personnel to monitor the cloud environment for compliance with governance policies. This includes tracking the use of resources, managing access controls, and ensuring data protection measures are in place as per the policies. For example, define a [comprehensive cost management approach](/azure/cost-management-billing/finops/) to govern cloud costs.

## Review policy enforcement

Regularly review and update policy enforcement mechanisms. The goal is to keep cloud governance policy enforcement aligned with current needs, including developer, architect, workload, platform, and business requirements. Engage with stakeholders to ensure cloud governance enforcement aligns with business objectives and compliance requirements.

## Next step

Monitor cloud governance.

## Example: Cloud governance compliance checklists

Compliance checklists help teams understand the governance policies that apply to them. The example compliance checklists use the policy statement from the [example cloud governance policies](./document-cloud-governance-policies.md#document-cloud-governance-policies).


### Regulatory compliance governance checklist

&#9744; Microsoft Purview must be used to enforce GDPR ([RC01](./document-cloud-governance-policies.md#example-regulatory-compliance-policies)).
&#9744; Daily GDPR compliance reports must be generated from Microsoft Purview ([RC02](./document-cloud-governance-policies.md#example-regulatory-compliance-policies)).

### Security governance checklist

[ ] Multi-Factor Authentication (MFA) must be enabled for all users.
[ ] Access reviews must be conducted monthly in Entra ID Governance.
[ ] Teams must use the specified GitHub organization for secure hosting of all software and infrastructure code.
[ ] Teams utilizing third-party libraries from public sources must adopt the quarantine pattern.

### Operations governance checklist

[ ] Production workloads should have an active-passive architecture across regions.
[ ] All mission-critical workloads must implement a cross-region active-active architecture.

### Cost management governance checklist

- [ ] Workload teams must set budgets alerts at the resource group level.
- [ ] Azure Advisor cost recommendations must be reviewed.

### Data governance checklist

- [ ] Encryption in transit and at rest must be applied to all sensitive data.
- [ ] Data lifecycle policies must be enabled for all sensitive data.

### Resource management governance checklist

- [ ] Bicep must be used to deploy resources.
- [ ] Tags must be enforced all cloud resources using Azure Policy.

### AI governance checklist

- [ ] AI bias detection and mitigation in Azure OpenAI must be used.
- [ ] Customer-facing AI systems must be red-teamed monthly.

### Summary cloud governance checklist

| Category | Checklist Item | Policy ID |
|----------|----------------|-----------|
| Regulatory compliance | Microsoft Purview must be used to enforce GDPR. | [RC01](./document-cloud-governance-policies.md#example-regulatory-compliance-policies) |
| Regulatory compliance | Daily GDPR compliance reports must be generated from Microsoft Purview. | [RC02](./document-cloud-governance-policies.md#example-regulatory-compliance-policies) |
| Security compliance | Multi-Factor Authentication (MFA) must be enabled for all users. | [SC01](./document-cloud-governance-policies.md#example-security-policies) |
| Security compliance | Access reviews must be conducted monthly in Entra ID Governance. | [SC02](./document-cloud-governance-policies.md#example-security-policies) |
| Security compliance | Teams must use the specified GitHub organization for secure hosting of all software and infrastructure code. | [SC03](./document-cloud-governance-policies.md#example-security-policies) |
| Security compliance | Teams utilizing third-party libraries from public sources must adopt the quarantine pattern. | [SC04](./document-cloud-governance-policies.md#example-security-policies) |
| Operations governance | Production workloads should have an active-passive architecture across regions. | OP01 |
| Operations governance | All mission-critical workloads must implement a cross-region active-active architecture. | OP02 |
| Cost management | Workload teams must set budgets alerts at the resource group level. | CM01 |
| Cost management | Azure Advisor cost recommendations must be reviewed. | CM02 |
| Data governance | Encryption in transit and at rest must be applied to all sensitive data. | DG01 |
| Data governance | Data lifecycle policies must be enabled for all sensitive data. | DG02 |
| Resource management | Bicep must be used to deploy resources. | RM01 |
| Resource management | Tags must be enforced all cloud resources using Azure Policy. | RM02 |
| AI governance | AI bias detection and mitigation in Azure OpenAI must be used. | AI01 |
| AI governance | Customer-facing AI systems must be red-teamed monthly. | AI02 |

> [!div class="nextstepaction"]
> [Monitor cloud governance](monitor-cloud-governance.md)
