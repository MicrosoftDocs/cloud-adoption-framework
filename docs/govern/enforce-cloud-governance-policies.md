---
title: Enforce cloud governance policies
description: Learn to enforce cloud governance policies in Azure environments. Use automated and manual approaches to ensure compliance and maintain cloud governance.
author: larzstridh
ms.author: pnp
ms.date: 05/22/2025
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Enforce cloud governance policies

This article shows you how to enforce compliance with cloud governance policies. Cloud governance enforcement refers to the controls and procedures you use to align cloud use to the cloud governance policies. The cloud governance team assesses cloud risks and creates cloud governance policies to manage those risks. To ensure compliance with the cloud governance policies, the cloud governance team must delegate enforcement responsibilities. They must empower each team or individual to enforce cloud governance policies within their area of responsibility. The cloud governance team can't do it all. Prefer automated enforcement controls but enforce compliance manually where you can't automate.

:::image type="content" source="./images/enforce.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continuously to maintain cloud governance." lightbox="./images/enforce.svg" border="false":::

## Define an approach for enforcing cloud governance policies

Establish a systematic strategy to enforce compliance with cloud governance policies. The goal is to use automated tools and manual oversight to enforce compliance efficiently. To define an enforcement approach, follow these recommendations:

- *Delegate governance responsibilities*. Empower individuals and teams to enforce governance within their scope of responsibility. For example, platform teams should apply policies that the workloads inherit and workload teams should enforce governance for their workload. The cloud governance team shouldn't be responsible for applying enforcement controls.

- *Adopt an inheritance model*. Apply a hierarchical governance model where specific workloads inherit governance policies from the platform. This model helps ensure that organizational standards apply to the correct environments, such as purchasing requirements for cloud services. Follow the [design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-principles) of Azure landing zones and its [resource organization](/azure/cloud-adoption-framework/ready/landing-zone/design-areas) design area to establish a proper inheritance model.

- *Discuss enforcement specifics*. Discuss where and how you apply governance policies. The goal is to find cost effective ways to enforce compliance that accelerates productivity. Without a discussion, you risk blocking the progress of specific teams. It's important to find a balance that supports the business objectives while managing risk effectively.

- *Have a monitor-first stance*. Don't block actions unless you understand them first. For lower priority risk, start by monitoring compliance with cloud governance policies. After you understand the risk, you can move to more restrictive enforcement controls. A monitor-first approach gives you an opportunity to discuss the governance needs and realign the cloud governance policy and enforcement control to those needs.

- *Prefer blocklists*. Prefer blocklists over allowlists. Blocklists prevent the deployment of specific services. It's better to have a small list of services that you shouldn't use than a long list of services you can use. To avoid lengthy blocklists, don't add new services to the blocklist by default.

- *Define a tagging and naming strategy*. Establish systematic guidelines for naming and tagging cloud resources. It provides a structured framework for resource categorization, cost management, security, and compliance across the cloud environment. Allow teams, such as development teams, to add other tags for their unique needs.

## Enforce cloud governance policies automatically

Use cloud management and governance tools to automate compliance with governance policies. These tools can help in setting up guardrails, monitoring configurations, and ensuring compliance. To set up automated enforcement, follow these recommendations:

- *Start with a small set of automated policies*. Automate compliance on a small set of essential cloud governance policies. Implement and test automation to avoid operational disruptions. Expand your list of automated enforcement controls when ready.

- *Use cloud governance tools*. Use the tools available in your cloud environment to enforce compliance. Azure's primary governance tool is [Azure Policy](/azure/governance/policy/overview). Supplement Azure Policy with [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) (security), [Microsoft Purview](/purview/purview) (data), [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview) (identity), [Azure Monitor](/azure/azure-monitor/overview) (operations), [management groups](/azure/governance/management-groups/overview) (resource management), [infrastructure as code (IaC)](/devops/deliver/what-is-infrastructure-as-code) (resource management), and configurations within each Azure service.

- *Apply governance policies at the right scope*. Use an inheritance system where policies are set at a higher level, such as management groups. Policies at higher levels automatically apply to lower levels, such as subscriptions and resource groups. Policies apply even when there are changes within the cloud environment, lowering management overhead.

- *Use policy enforcement points*. Set up policy enforcement points within your cloud environments that automatically apply governance rules. Consider predeployment checks, runtime monitoring, and automated remediation actions.

- *Use policy as code*. Use IaC tools to [enforce governance policies through code](/azure/governance/policy/concepts/policy-as-code). Policy as code enhances the automation of governance controls and ensures consistency across different environments. Consider using [Enterprise Azure Policy as Code](https://azure.github.io/enterprise-azure-policy-as-code/) (EPAC) to manage policies aligned with recommended Azure landing zone policies.

- *Develop custom solutions as needed*. For custom governance actions, consider developing custom scripts or applications. Use Azure service APIs to gather data or manage resources directly.

### Azure facilitation: Enforcing cloud governance policies automatically

The following guidance can help you find the right tools to automate compliance with cloud governance policies in Azure. It provides a sample starting point for major categories of cloud governance.

#### Automate regulatory compliance governance

- *Apply regulatory compliance policies*. Use [built-in regulatory compliance policies](/azure/governance/policy/samples/#regulatory-compliance) that align with compliance standards, such as HITRUST/HIPAA, ISO 27001, CMMC, FedRamp, and PCI DSSv4.

- *Automate custom restrictions*. [Create custom policies](/azure/governance/policy/tutorials/create-custom-policy-definition) to define your own rules for working with Azure.

#### Automate security governance

- *Apply security policies*. Use the [built-in security policies](/azure/governance/policy/samples/) and [automated security compliance](/azure/defender-for-cloud/security-policy-concept) to align with common security standards. There's built-in policies for NIST 800 SP series, Center for Internet Security benchmarks, and the Microsoft cloud security benchmark. Use built-in policies to [automate the security configuration](/azure/governance/policy/samples/built-in-policies) of specific Azure services. [Create custom policies](/azure/governance/policy/tutorials/create-custom-policy-definition) to define your own rules for working with Azure.

- *Apply identity governance*. Enable [Microsoft Entra multifactor authentication (MFA)](/entra/identity/authentication/concept-mfa-howitworks) and [self-service password reset](/entra/identity/authentication/concept-sspr-howitworks). [Eliminate weak passwords](/entra/identity/authentication/concept-password-ban-bad-combined-policy). Automate other aspects of [identity governance](/entra/id-governance/identity-governance-overview), such as access request workflows, access reviews, and identity lifecycle management. [Enable just-in-time access](/entra/id-governance/privileged-identity-management/pim-configure) to limit access to important resources. Use [Conditional Access](/entra/identity/conditional-access/concept-conditional-access-policy-common) policies to [grant or block](/entra/identity/conditional-access/concept-conditional-access-grant) user and [device identities](/entra/identity/devices/overview) access to cloud services.

- *Apply access controls*. Use [Azure role-based access control](/azure/role-based-access-control/overview) (RBAC) and [attribute-based access control](/azure/role-based-access-control/conditions-overview) (ABAC) to govern access to specific resources. Grant and deny permissions to users and groups. Apply the permission at the appropriate [scope](/azure/role-based-access-control/scope-overview) (management group, subscription, resource group, or resource) to provide only the permission needed and limit management overhead.

#### Automate cost governance

- *Automate deployment restrictions*. [Disallow certain cloud resources](/azure/governance/policy/tutorials/disallowed-resources) to prevent the use of cost-intensive resources.

- *Automate custom restrictions*. [Create custom policies](/azure/governance/policy/tutorials/create-custom-policy-definition) to define your own rules for working with Azure.

- *Automate cost allocation*. Enforce tagging requirements to [group and allocate costs](/azure/cost-management-billing/costs/enable-tag-inheritance) across environments (development, test, production), departments, or projects. Use tags to identify and track resources that are part of a cost optimization effort.

#### Automate operations governance

- *Automate redundancy*. Use built-in Azure policies to require a specified level of infrastructure redundancy, such as zone-redundant and geo-redundant instances.

- *Apply backup policies*. Use [backup policies](/azure/backup/backup-center-govern-environment) to govern the backup frequency, retention period, and storage location. Align backups policies with data governance, regulatory compliance requirements, recovery time objective (RTO), and recovery point objective (RPO). Use the backup settings in individual Azure services, such as [Azure SQL Database](/azure/azure-sql/database/automated-backups-overview), to configure the settings you need.

- *Meet the target service-level objective*. Restrict the deployment of certain services and service tiers (SKUs) that don't meet your target service-level objective. For example, use the `Not allowed resource types` policy definition in Azure Policy.

#### Automate data governance

- *Automate data governance*. Automate [data governance](/purview/governance-solutions-overview) tasks, such as cataloging, mapping, securely sharing, and applying policies.

- *Automate data lifecycle management*. Implement storage policies and [lifecycle management for storage](/azure/storage/blobs/lifecycle-management-policy-configure?tabs=azure-portal) to ensure data is stored efficiently and compliantly.

- *Automate data security*. Review and enforce [data protection strategies](/azure/security/fundamentals/protection-customer-data), such as data segregation, encryption, and redundancy.

#### Automate resource management governance

- *Create a resource management hierarchy*. Use [management groups](/azure/governance/management-groups/overview) to organize your subscriptions so that you can efficiently govern policies, access, and spending. Follow Azure landing zone [resource organization](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org) best practices.

- *Enforce a tagging strategy*. Ensure all Azure resources are consistently tagged to improve manageability, cost tracking, and compliance. [Define your tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging) and [manage tag governance](/azure/governance/policy/tutorials/govern-tags).

- *Restrict which resources you can deploy*. [Disallow resource types](/azure/governance/policy/tutorials/disallowed-resources) to restrict deployments of services that add unnecessary risk.

- *Restrict deployments to specific regions*. Control where resources are deployed to comply with regulatory requirements, manage costs, and reduce latency. For example, use the `Allowed locations` policy definition in Azure Policy. Also [enforce regional restrictions](/azure/governance/policy/tutorials/policy-devops-pipelines) in your deployment pipeline.

- *Use infrastructure as code (IaC)*. Automate infrastructure deployments using [Bicep, Terraform, or Azure Resource Manager templates (ARM templates)](/azure/templates/). Store your IaC configurations in a source control system (GitHub or Azure Repos) to track changes and collaborate. Use [Azure landing zone accelerators](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-accelerators) to govern the deployment of your platform and application resources and avoid configuration drift over time.

- *Govern hybrid and multicloud environments*. [Govern hybrid and multicloud resources](/azure/azure-arc/overview). Maintain consistency in management and policy enforcement.

#### Automate AI governance

- *Use the retrieval augmented generation (RAG) pattern*. RAG adds an information retrieval system to control the grounding data that a language model uses to generate a response. For example, you can use [the Azure OpenAI Service on your own data feature](/azure/ai-services/openai/concepts/use-your-data) or set up RAG with [Azure AI Search](/azure/search/retrieval-augmented-generation-overview) to constrain generative AI to your content.

- *Use AI development tools*. Use AI tools, like Semantic Kernel, that facilitate and standardize AI orchestration when developing applications that use AI.

- *Govern output generation*. Help [prevent abuse and harmful content generation](/legal/cognitive-services/openai/data-privacy). Use [AI content filtering](/azure/ai-services/openai/concepts/content-filter) and [AI abuse monitoring](/azure/ai-services/openai/concepts/abuse-monitoring).

- *Configure data loss prevention*. Configure [data loss prevention for Azure AI services](/azure/ai-services/cognitive-services-data-loss-prevention). Configure the list of outbound URLs that their AI services resources are allowed to access.

- *Use system messages*. Use [system messages](/azure/ai-services/openai/concepts/system-message) to guide the behavior of an AI system and tailor the outputs.

- *Apply the AI security baseline*. Use the [Azure AI security baseline](/security/benchmark/azure/baselines/cognitive-services-security-baseline) to govern the security of AI systems.

## Enforce cloud governance policies manually

Sometimes a tool limitation or cost makes automated enforcement unpractical. In cases where you can't automate enforcement, enforce cloud governance policies manually. To manually enforce cloud governance, follow these recommendations:

- *Use checklists*. Use governance checklists to make it easy for your teams to follow the cloud governance policies. For more information, see the [example compliance checklists](#example-cloud-governance-compliance-checklists).

- *Provide regular training*. Conduct frequent training sessions for all relevant team members to ensure they're aware of the governance policies.

- *Schedule regular reviews*. Implement a schedule for regular reviews and audits of cloud resources and processes to ensure compliance with governance policies. These reviews are critical for identifying deviations from established policies and taking corrective actions.

- *Monitor manually*. Assign dedicated personnel to monitor the cloud environment for compliance with governance policies. Consider tracking the use of resources, managing access controls, and ensuring data protection measures are in place to align with the policies. For example, define a [comprehensive cost management approach](/azure/cost-management-billing/finops/) to govern cloud costs.

## Review policy enforcement

Regularly review and update compliance enforcement mechanisms. The goal is to keep cloud governance policy enforcement aligned with current needs, including developer, architect, workload, platform, and business requirements. To review policy enforcement, follow these recommendations:

- *Engage with stakeholders.* Discuss the effectiveness of enforcement mechanisms with stakeholders. Ensure cloud governance enforcement aligns with business objectives and compliance requirements.

- *Monitor requirements.* Update or remove enforcement mechanisms to align with new or updated requirements. Track changes in regulations and standards that require updates your enforcement mechanisms. For example, Azure landing zone recommended policies can change over time. You should [detect](https://github.com/Azure/Enterprise-Scale/wiki/Migrate-ALZ-Policies-to-Built%E2%80%90in#detect-updates-to-policy) those policy changes, [update](https://github.com/Azure/Enterprise-Scale/wiki/update-alz-custom-policies-to-latest) to the latest Azure landing zone custom policies, or [migrate](https://github.com/Azure/Enterprise-Scale/wiki/Migrate-ALZ-Policies-to-Built%E2%80%90in) to built-in policies as needed.

## Example cloud governance compliance checklists

Compliance checklists help teams understand the governance policies that apply to them. The example compliance checklists use the policy statement from the [example cloud governance policies](./document-cloud-governance-policies.md#document-cloud-governance-policies) and contain the cloud governance policy ID for cross-referencing.

| Category | Compliance requirement |
|----------|----------------|
| Regulatory compliance | &#9744; Microsoft Purview must be used to monitor sensitive data [(RC01)](document-cloud-governance-policies.md#example-cloud-governance-policies). <br> &#9744; Daily sensitive data compliance reports must be generated from Microsoft Purview [(RC02)](document-cloud-governance-policies.md#example-cloud-governance-policies). |
| Security | &#9744; MFA must be enabled for all users [(SC01)](document-cloud-governance-policies.md#example-cloud-governance-policies). <br> &#9744; Access reviews must be conducted monthly in ID Governance [(SC02)](document-cloud-governance-policies.md). <br> &#9744; Use the specified GitHub organization to host all application and infrastructure code [(SC03)](document-cloud-governance-policies.md#example-cloud-governance-policies). <br> &#9744; Teams that use libraries from public sources must adopt the quarantine pattern [(SC04)](document-cloud-governance-policies.md#example-cloud-governance-policies). |
| Operations | &#9744; Production workloads should have an active-passive architecture across regions [(OP01)](document-cloud-governance-policies.md#example-cloud-governance-policies). <br> &#9744; All mission-critical workloads must implement a cross-region active-active architecture [(OP02)](document-cloud-governance-policies.md#example-cloud-governance-policies). |
| Cost | &#9744; Workload teams must set budgets alerts at the resource group level [(CM01)](document-cloud-governance-policies.md#example-cloud-governance-policies). <br> &#9744; Azure Advisor cost recommendations must be reviewed [(CM02)](document-cloud-governance-policies.md#example-cloud-governance-policies). |
| Data | &#9744; Encryption in transit and at rest must be applied to all sensitive data. [(DG01)](./document-cloud-governance-policies.md) <br> &#9744; Data lifecycle policies must be enabled for all sensitive data [(DG02)](document-cloud-governance-policies.md#example-cloud-governance-policies). |
| Resource management | &#9744; Bicep must be used to deploy resources [(RM01)](document-cloud-governance-policies.md#example-cloud-governance-policies). <br> &#9744; Tags must be enforced on all cloud resources using Azure Policy [(RM02)](document-cloud-governance-policies.md#example-cloud-governance-policies). |
| AI | &#9744; The AI content filtering configuration must be set to medium or higher [(AI01)](document-cloud-governance-policies.md#example-cloud-governance-policies). <br> &#9744; Customer-facing AI systems must be red-teamed monthly [(AI02)](document-cloud-governance-policies.md#example-cloud-governance-policies). |

## Next step

> [!div class="nextstepaction"]
> [Monitor cloud governance](monitor-cloud-governance.md)
