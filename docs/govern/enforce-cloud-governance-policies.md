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

<img src="c:\GitHub\cloud-adoption-framework-pr\docs\govern/media/image7.png" style="width:6.5in;height:0.8625in" alt="A blue rectangle with white text Description automatically generated" />

## Define an approach to enforcing cloud governance policies

Establish a systematic strategy to enforce cloud governance policies. The goal is to use automated tools and manual oversight to enforce policies efficiently. To define an enforcement approach, follow these recommendations:

- 

- *Delegate governance responsibilities.* Empower individuals and teams to enforce governance within their scope of responsibility. For example, platform teams should apply policies that workloads inherit. Workload teams should enforce governance for their workload. The cloud governance team shouldn’t be responsible for applying enforcement controls.

- *Adopt an inheritance model.* Apply a hierarchical governance model where specific workloads inherit governance policies from the platform team. This model helps ensure organizational standards apply to the correct environments, such as purchasing requirements for cloud services.

<!-- -->

- *Discuss enforcement specifics*. Discuss where and how you apply governance policies. The goal is to find cost effective ways to enforce governance that accelerates productivity. Without a discussion, you risk blocking the progress of specific teams. It's important to find a balance that supports the business objectives while managing risk effectively.

<!-- -->

- *Have an audit-first stance.* Don’t block certain actions unless you know they are high risk, such as for understood security and compliance reasons. Lower-risk enforcement controls should start by monitoring compliance with cloud governance policies. Once you understand organizational needs, you should move to more restrictive enforcement policies. A monitor-first approach gives you an opportunity to discuss the need and realign the policy to that need.

<!-- -->

- *Prefer deny lists*: Use deny lists over allow lists. Deny lists prevent the deployment of specific services. It’s better to have a small list of services that you shouldn’t use than a long list of services you can use.

<!-- -->

- *Define a tagging and naming strategy.* Establish systematic guidelines for naming and tagging cloud resources. It provides a structured framework for resource categorization, cost management, security, and compliance across the cloud environment. Allow teams, such as development teams, to add additional tags for their unique needs.

## Enforce cloud governance policies automatically

Use cloud management and governance tools to automate the enforcement of governance policies. These tools can help in setting up guardrails, monitoring configurations, and ensuring compliance. To set up automated enforcement, follow these recommendations:

- *Start with a small set of automated policies.* Begin automating a minimal set of essential cloud governance policies. Implement and test automation to avoid operational disruptions. Automate additional policies when ready.

- *Use cloud governance tools*. Use the tools available in your cloud environment to enforce governance. Azure’s primary governance tool is [Azure Policy](https://learn.microsoft.com/en-us/azure/governance/policy/overview). Supplement Azure Policy with [Microsoft Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-cloud-introduction) (security), [Microsoft Purview](https://learn.microsoft.com/en-us/purview/purview) (data), [Microsoft Entra ID Governance](https://learn.microsoft.com/en-us/entra/id-governance/identity-governance-overview) (identity), [Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/overview) (operations), [management groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview) (resource management), [infrastructure as code](https://learn.microsoft.com/en-us/devops/deliver/what-is-infrastructure-as-code) (resource management), and configurations within each Azure service.

<!-- -->

- *Apply governance policies at the right scope.* Use an inheritance system where policies are set at a higher level, such as management group. Policies at higher level automatically apply to lower levels, such as subscriptions and resource groups. Policies apply even when there’s changes within the cloud environment, lowering management overhead.

<!-- -->

- *Use policy enforcement points.* Set up policy enforcement points within your cloud environments that automatically apply governance rules. This can include pre-deployment checks, runtime monitoring, and automated remediation actions.

<!-- -->

- *Use policy-as-code.* Use IaC tools to [enforce governance policies through code](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/policy-as-code)*.* Policy as code enhances the automation of governance controls and ensures consistency across different environments.

<!-- -->

- *Develop custom solutions as needed.* For custom governance actions, consider developing custom scripts or applications. Use Azure service APIs to gather data or manage resources directly.

### Azure facilitation: Enforcing cloud governance policies automatically

The following guidance is meant to help you automate cloud governance policies in Azure. It provides a sample starting point for major categories of cloud governance.

#### Automate regulatory compliance governance in Azure

Achieve continuous alignment with global compliance standards through automated enforcement controls with minimal manual oversight.

- *Apply built-in regulatory compliance policies*. Use [built-in regulatory compliance policies](https://learn.microsoft.com/en-us/azure/governance/policy/samples/#regulatory-compliance) that align with compliance standards, such as HITRUST/HIPAA, ISO 27001, CMMC, FedRamp, and PCI DSSv4.

#### Automate cloud security governance in Azure

Secure cloud environments automatically by enforcing best practices and compliance with security frameworks.

- *Apply built-in security policies.* Use the [built-in security policies](https://microsoft-my.sharepoint.com/personal/ssumner_microsoft_com/Documents/Documents/CAF/CAF%20Govern/For%20more%20information,%20see%20List%20of%20built-in%20policy%20definitions%20and%20Security%20baselines%20for%20Azure%20overview.) to [automate security compliance](https://learn.microsoft.com/en-us/azure/defender-for-cloud/security-policy-concept) with standards, such as NIST 800 SP series, Center for Internet Security benchmarks, and the Microsoft cloud security benchmark. Use built-in policies to [automate the security configuration](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies) of specific Azure services.

- *Apply identity governance.* Enable [multi-factor authentication](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-mfa-howitworks) and [self-service password reset](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-sspr-howitworks). [Eliminate weak passwords](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-password-ban-bad-combined-policy). Automate other aspects of [identity governance](https://learn.microsoft.com/en-us/entra/id-governance/identity-governance-overview), such as access request workflows, access reviews, and identity lifecycle management. [Enable just-in time access](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure) to limit access to important resources.

- *Apply access controls*. Use [Azure role-based access controls](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview) (RBAC) and [attribute-access controls](https://learn.microsoft.com/en-us/azure/role-based-access-control/conditions-overview) (ABAC) to govern access to specific resources. Grant and deny permissions to users and groups. Apply the permission at the appropriate [scope](https://learn.microsoft.com/en-us/azure/role-based-access-control/scope-overview) (management group, subscription, resource group, or resource) to provide only the permission needed and limit management overhead.

#### Automate cloud cost governance in Azure

Automate cost monitoring, budgeting, and optimization processes that prevent overspending and ensure costs align with business goals.

- *Analyze cloud costs.* Conduct a [cost analysis](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/quick-acm-cost-analysis) in Azure to gain full visibility into your cloud costs.

- *Create budgets.* [Create a budget](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-acm-create-budgets) that aligns with your desired investment in the cloud. [Configure usage and spending alerts](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending) to notify stakeholders when you’re approaching budget thresholds.

- *Gather cost recommendations.* Use [cost optimization recommendations](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) and *the Cost optimization workbook* to guide cost management efforts, such as detection of idle resources.

- *Identify anomalous spending.* Create [cost anomaly detection alerts](https://learn.microsoft.com/en-us/azure/cost-management-billing/understand/analyze-unexpected-charges#create-an-anomaly-alert) to get notified about unusual cost behaviors in your subscriptions.

- *Restrict deployments.* [Disallow certain cloud resources](https://learn.microsoft.com/en-us/azure/governance/policy/tutorials/disallowed-resources) from deploying to prevent use of cost-intensive resources.

- *Use tags to track spending.* Use tags to [group and allocate costs](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/enable-tag-inheritance) across environment (e.g., dev, test, prod), department, or project. Use tag to identify and track resources that are part of a cost optimization effort.

- *Monitor commitments-based discounts*. Set [reservation utilization alerts](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/reservation-utilization-alerts) to keep reservations and savings plans usage at or close to full usage.

- 

#### Automate cloud operations governance in Azure

Ensure high availability, data protection, and disaster recovery through automated operational policies.

- *Automate redundancy.* Use built-in policies to require a specified level of infrastructure redundancy, such as zone redundant and geo-redundant instances.

- *Automate backups.* Use [backup policies](https://learn.microsoft.com/en-us/azure/backup/backup-center-govern-environment) to govern backup frequency, retention period, and storage location. Align backups policies with data governance and regulatory compliance requirements. Use the backup settings in individual Azure services, such as [Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/automated-backups-overview?view=azuresql), to configure the settings you need.

<!-- -->

- *Meet target service level objective.* Restrict the deployment of certain services and service tiers (SKUs) that don’t meet your target service level objective. For example, use the \`Not allowed resource types\` policy definition.

#### [*Automate cloud data governance*](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Automate_cloud_data) in Azure

Automate the management, storage, and processing of data in compliance with regulations. Ensure data privacy, security, and lifecycle management without manual intervention.

- *Automate data governance.* Automate [data governance](https://learn.microsoft.com/en-us/purview/governance-solutions-overview) tasks, such as cataloging, mapping, securely sharing, and applying policies.

- *Automate data lifecycle management.* Implement storage policies and [lifecycle management for storage](https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-policy-configure?tabs=azure-portal) to ensure data is stored efficiently and compliantly.

- *Protect data.* Review and enforce [data protection strategies](https://learn.microsoft.com/en-us/azure/security/fundamentals/protection-customer-data), such as data segregation, encryption, and redundancy.

#### [*Automate cloud resource management governance*](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Automate_cloud_resource) in Azure

Achieve streamlined and compliant resource provisioning and management through automated tagging, deployment restrictions, and infrastructure as code practices. Ensure consistency and operational efficiency across environments.

- *Create a resource management hierarchy.* Use [management groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview) to organize your subscriptions so that you can efficiently govern policies, access, and spending. Follow Azure landing zone [resource organization](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org) best practices.

- *Enforce a tagging strategy.* Ensure all Azure resources are consistently tagged to improve manageability, cost tracking, and compliance. Use Azure Policy to [Define your tagging strategy](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging) and [Manage tag governance.](https://learn.microsoft.com/en-us/azure/governance/policy/tutorials/govern-tags)

- *Restrict which resources you can deploy.* [Disallow resource types](https://learn.microsoft.com/en-us/azure/governance/policy/tutorials/disallowed-resources) to restrict deployments of services that add unnecessary risk.

- *Restrict deployments to specific regions.* Control where resources are deployed to comply with regulatory requirements, manage costs, and reduce latency. For example, use the \`Allowed locations\` policy definition in Azure Policy. Also [enforce regional restrictions](https://learn.microsoft.com/en-us/azure/governance/policy/tutorials/policy-devops-pipelines) in your deployment pipeline.

- *Use infrastructure as code.* Automate infrastructure deployments using [Bicep, Terraform, or ARM templates.](https://learn.microsoft.com/en-us/azure/templates/) Store your IaC configurations in a source control system (GitHub, Azure Repos) to track changes and collaborate.

- *Use a CI/CD pipeline.* A CI/CD pipeline can ensure deployments adhere to predefined governance rules and policies. [Integrate compliance scans](https://learn.microsoft.com/en-us/azure/governance/policy/how-to/get-compliance-data#on-demand-evaluation-scan) into CI/CD pipelines to enforce governance.

- *Govern hybrid and multi-cloud environments.* [Govern hybrid and multi-cloud resources](https://learn.microsoft.com/en-us/azure/azure-arc/overview)*.* Maintain consistency in management and policy enforcement.

#### Automate AI governance in Azure

The goal is to govern AI systems to ensure ethical use, content integrity, and compliance with security standards, using automation to prevent misuse and enhance trustworthiness.

- *Use the retrieval augmented generation (RAG) pattern.* RAG adds an information retrieval system to control the grounding data an LLM uses to formulate a response. Use Azure OpenAI on [your own data](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/use-your-data?tabs=ai-search) or set up RAG with [Azure AI Search](https://learn.microsoft.com/en-us/azure/search/retrieval-augmented-generation-overview) to constrain generative AI to your content*.*

- *Use AI development tools.* Use tools, like Semantic Kernel, that facilitate and standardize AI orchestration when developing AI applications.

- *Govern output generation.* Help [prevent abuse and harmful content generation.](https://learn.microsoft.com/en-us/legal/cognitive-services/openai/data-privacy?context=%2Fazure%2Fai-services%2Fopenai%2Fcontext%2Fcontext#preventing-abuse-and-harmful-content-generation) Use [AI content filtering](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/content-filter?tabs=warning%2Cpython) and [AI abuse monitoring](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/abuse-monitoring).

- *Configure data loss prevention.* Configure [data loss prevention for Azure AI services](https://learn.microsoft.com/en-us/azure/ai-services/cognitive-services-data-loss-prevention?tabs=azure-cli). Configure the list of outbound URLs their Azure AI services resources are allowed to access.

- *Use system messages.* Provide meta prompts to guide the behavior of an AI system. Use [system messages](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/system-message) to tailor the generated outputs.

- *Apply the AI security baseline.* Use the [Azure AI security baseline](https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/cognitive-services-security-baseline) to govern the security of AI systems.

## Enforce cloud governance policies manually

In cases where you can’t automate cloud governance policies enforcement, enforce cloud governance policies manually. Sometimes a tool limitation or cost makes automated enforcement unpractical. To manually enforce cloud governance, follow these recommendations:

- *Use checklists.* Use governance checklists to make it easy for your teams to follow the cloud governance policies. See [example Compliance checklists](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Examples:_Compliance_checklists).

- *Provide regular training.* Conduct frequent training sessions for all relevant team members to ensure they are aware of the governance policies.

- *Schedule regular reviews.* Implement a schedule for regular reviews and audits of cloud resources and processes to ensure compliance with governance policies. These reviews are critical for identifying deviations from established policies and taking corrective actions promptly.

- *Monitor manually.* Assign dedicated personnel to monitor the cloud environment for compliance with governance policies. This includes tracking the use of resources, managing access controls, and ensuring data protection measures are in place as per the policies. For example, define a [comprehensive cost management approach](https://learn.microsoft.com/en-us/azure/cost-management-billing/finops/) to govern cloud costs.

## Review policy enforcement

Regularly review and update policy enforcement mechanisms. The goal is to keep cloud governance policy enforcement aligned with current needs, including developer, architect, workload, platform, and business requirements. Engage with stakeholders to ensure cloud governance enforcement aligns with business objectives and compliance requirements.

## Next step

Monitor cloud governance to improve compliance over time.

## Examples: Compliance checklists

Compliance checklists help teams understand the governance policies that apply to them. The example compliance checklists use the policy statement from the [Examples: Cloud governance policies for Azure](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Examples:_Cloud_governance).

### Regulatory compliance checklist

- Microsoft Purview must be used to enforce GDPR.

- Daily GDPR compliance reports must be generated from Microsoft Purview.

### Security compliance checklist

- Multi-Factor Authentication (MFA) must be enabled for all users.

- Access reviews must be conducted monthly in Entra ID Governance.

- Teams must use the specified GitHub organization for secure hosting of all software and infrastructure code.

- Teams utilizing third-party libraries from public sources must adopt the quarantine pattern.

### Operations governance checklist

- Production workloads should have an active-passive architecture across regions.

- All mission-critical workloads must implement a cross-region active-active architecture.

### Cost management checklist

- Workload teams must set budgets alerts at the resource group level.

- Azure Advisor cost recommendations must be reviewed.

### Data governance checklist

- Encryption in transit and at rest must be applied to all sensitive data.

- Data lifecycle policies must be enabled for all sensitive data.

### Resource management checklist

- Bicep must be used to deploy resources.

- Tags must be enforced all cloud resources using Azure Policy.

### AI governance checklist

- AI bias detection and mitigation in Azure OpenAI must be used.

- Customer-facing AI systems must be red-teamed monthly.

> [!div class="nextstepaction"]
> [Monitor cloud governance](monitor-cloud-governance.md)
