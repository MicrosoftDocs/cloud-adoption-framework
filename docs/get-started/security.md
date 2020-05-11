---
title: "Get started: Secure the enterprise environment"
description: Get started integrating security at critical points during your cloud adoption efforts and operations.
author: JanetCThomas
ms.author: janet
ms.date: 04/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

<!-- docsTest:ignore Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template -->

<!-- cSpell:ignore CISO passwordless -->

# Get started: Implementing security across the enterprise environment

Security enables business through creating assurances of confidentiality, integrity, and availability with a critical focus on protecting against the potential impact to operations caused by both internal and external malicious and unintentional acts. This roadmap outlines the key steps that will mitigate or avoid the business risk from cybersecurity attacks by rapidly establishing essential security practices in the cloud and integrating security into your cloud adoption process.

The steps in this guide are intended for all roles that support security assurances of cloud environments and landing zones. This includes both immediate risk mitigation priorities, guidance on building a modern security strategy, operationalizing the approach, and executing on that strategy.

Various elements from across the Cloud Adoption Framework are included in this getting started guide:

![Get started with enterprise security](../_images/get-started/security-map.png)

Adhering to the steps in this guide will help you integrate security at critical points in the process to avoid obstacles in cloud adoption and reduce unnecessary business or operational disruption.

Microsoft has built capabilities and resources to help accelerate your implementation of this security guidance on Microsoft Azure (referenced throughout this document). These resources are designed to help you establish, monitor, and enforce security and are frequently updated and reviewed.

This diagram shows the holistic approach that Microsoft recommends for using security guidance and platform tooling to establish security visibility and control over your cloud assets in Azure.

![Security diagram](../_images/security/security-diagram.png)

Use these steps to plan and execute your strategy for securing your cloud assets and using the cloud to modernize security operations:

## Step 1: Establish essential security practices

Security in the cloud starts with sound practices. Whether you are already operating in the cloud or are planning for future adoption, it's important to rapidly establish essential security practices.

In addition to meeting any explicit regulatory compliance requirements, we recommend the following steps to address the top security challenges most organizations face as they move to the cloud.

**Deliverables and supporting guidance:**

- **Technical:** Mitigate top risks and increase visibility and control of assets by enabling passwordless or multi-factor authentication for admins, and by enabling threat protection for cloud resources.
  - [Passwordless or multi-factor authentication for admins](https://docs.microsoft.com/azure/architecture/framework/security/critical-impact-accounts#passwordless-or-multi-factor-authentication-for-admins)
  - [Security operations](https://docs.microsoft.com/azure/architecture/framework/security/security-operations) and [threat protection in Azure Security Center](https://docs.microsoft.com/azure/security-center/threat-protection)
- **Process:** Enable rapid security decisions and continuous improvement by assigning security roles and responsibilities and establishing an incident response process.
  - [Clear lines of responsibility](https://docs.microsoft.com/azure/architecture/framework/security/governance#clear-lines-of-responsibility), [Assign privileges for managing the environment](https://docs.microsoft.com/azure/architecture/framework/security/governance#assign-privileges-for-managing-the-environment), and Operationalize Secure Score <!-- TODO: Improve this and add link to AAF article -->
  - Security roles and responsibilities <!-- TODO: add link to bookmark -->
  - [Incident response reference guide](https://aka.ms/irrg)
- **People:** Provide security teams with the education, tools, and access required to successfully deploy and operate during the transition to the cloud environment.
  - **Educate everyone on concepts** of how cloud and cloud security are evolving:
    - [Evolution of threat environment, roles, and digital strategies](https://docs.microsoft.com/security/compass/microsoft-security-compass-introduction#evolution-of-threat-environment-roles--digital-strategies-2004)
    - [Transformation of security, strategies, tools, and threats](https://docs.microsoft.com/security/compass/microsoft-security-compass-introduction#transformation-of-security-strategies-tools--threats-1513)
  - **Train technical staff** on technical details on cloud security capabilities for the platforms they use. Microsoft provides extensive [Azure security documentation](https://docs.microsoft.com/azure/security).
- **Long-term architectural decisions:** Establish a long-term foundation with the right decisions. These are very difficult and expensive to change later.
  - [Build enterprise segmentation strategy and align technical architectures with it (network segmentation, identity segmentation, etc.)](https://docs.microsoft.com/azure/architecture/framework/security/network-security-containment#align-network-segmentation-with-enterprise-segmentation-strategy)
  - [Single enterprise directory](https://docs.microsoft.com/azure/architecture/framework/security/identity#single-enterprise-directory)
  - [Authentication strategy for services](https://docs.microsoft.com/azure/architecture/framework/security/applications-services#prefer-identity-authentication-over-keys)
  - [Permission assignment strategy](https://docs.microsoft.com/azure/architecture/framework/security/critical-impact-accounts#avoid-granular-and-custom-permissions)

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud security team <br><br><br> | <li> Cloud strategy team <li> Cloud adoption team <li> Cloud center of excellence or Central IT |

During this initial step, governance teams should also start coordinating the creation of security baselines that can be monitored, managed, and enforced across environments. Additional guidance on building this is discussed in step 4 below.

> [!NOTE]
> Each organization should define their own minimum standards, as risk posture and subsequent tolerance to that risk can vary widely based on industry, culture, and other factors. For example, a bank may not tolerate any potential damage to their reputation from even a minor attack on a test system, where some organizations would gladly accept that same risk if it accelerated their digital transformation by three to six months.

## Step 2: Modernize security strategy

Effective security in the cloud requires sound strategy that reflects the current threat environment and the nature of the cloud platform that is hosting the enterprise assets. A clear strategy improves the effort of all teams to provide a secure and sustainable enterprise cloud environment that reduces business risk. The security strategy must enable defined business outcomes, reduce risk to an acceptable level, and enable employees to be productive.

A cloud security strategy provides clear guidance to all teams working on the technology, processes, and people readiness for this adoption. The strategy should inform the cloud architecture and technical capabilities, guide the security architecture and capabilities, and influence the training and education of teams.

**Deliverables:**

The strategy step should result in a document that can easily be communicated to many stakeholders within the organization, potentially including executives on the organizations leadership team.

Because of this, we recommended capturing the strategy in a presentation to facilitate easy discussion and updating. This can be supported with a document as well, depending on the culture and preferences.

- **Strategy presentation:** You may have a single strategy presentation, or you may choose to also create a summary version for leadership audiences.
  - **Full presentation:** This should include the full set of elements for the security strategy in either the main presentation or in optional reference slides.
  - **Executive summaries:** Versions to use with senior executives and board members that contains only critical elements relevant to their role such as risk appetite, top priorities, or accepted risks.
- You can also record motivations, outcomes, and business justification in the [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx).

**Best practices for building security strategy:**

Successful programs incorporate these elements into their security strategy process:

- **Align closely to business strategy:** Security's charter is to protect business value, so it is critical to align all security efforts to that purpose and minimize internal conflict.
  - **Build a shared understanding:** Of business, IT, and security requirements.
  - **Integrate security early into cloud adoption:** To avoid last minute crises from avoidable risks.
  - **Agile approach:** To immediately establish minimum security requirements and continuously improve security assurances over time.
  - **Security culture change:** Through intentional proactive leadership actions.

For more information, see [Transformations, mindsets, and expectations](../strategy/define-security-strategy.md#transformations-mindsets-and-expectations).

- **Modernize security strategy:** The security strategy should include considerations for all aspects of modern technology environment, current threat landscape, and security community resources.
  - **Adapt to the shared responsibility model** of the cloud.
  - **Include all cloud types and multicloud.**
  - **Prefer native cloud controls** to avoid unnecessary and harmful friction.
  - **Security community integration:** To keep up with the pace of attacker evolution.

**Related resources for additional context:**

- [Evolution of threat environment, roles, and digital strategies](https://docs.microsoft.com/security/compass/microsoft-security-compass-introduction#evolution-of-threat-environment-roles--digital-strategies-2004)
- [Transformation of security, strategies, tools, and threats](https://docs.microsoft.com/security/compass/microsoft-security-compass-introduction#transformation-of-security-strategies-tools--threats-1513)
- Cloud Adoption Framework strategy considerations:
  - [Modernize your security strategy](../strategy/define-security-strategy.md#modernize-your-security-strategy)
  - [Cybersecurity resilience](../strategy/define-security-strategy.md#cybersecurity-resilience)
  - [How cloud is changing security relationships and responsibilities](../strategy/define-security-strategy.md#how-the-cloud-is-changing-security)

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Security leadership team (chief information security officer (CISO) or equivalent) | <li> Cloud strategy team <li> Cloud security team <li> Cloud adoption team <li> Cloud center of excellence or Central IT |

**Strategy approval:** Executives and business leaders with accountability for the business outcomes or business risks of business line(s) within the organization (this could include the board of directors depending on the organization).

## Step 3: Develop a security plan

Planning puts the security strategy into action by defining outcomes, milestones, timelines, and task owners. This plan also outlines the roles and responsibilities of the teams.

Security planning and cloud adoption planning should not be done in isolation. It's critical to invite the cloud security team into the planning cycles early to avoid work stoppage or increased risk from security issues being discovered too late. Security planning works best with in-depth knowledge and awareness of the digital estate and existing IT portfolio that comes from being fully integrated into the cloud planning process.

**Deliverables:**

- **Security plan:** Should be part of the main planning documentation for the cloud and may be a document using the [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx), a detailed slide deck, a project file, or combination of these formats depending on organization's size, culture, and standard practices.

- The security plan should include all of these elements:

  - **Organizational functions plan:** So teams know how current security roles and responsibilities will change with the move to the cloud.
    - **Security skills plan** to support team members as they navigate the significant changes in technology, roles, and responsibilities.
  - **Technical security architecture and capabilities roadmap:** To guide technical teams.
  Microsoft provides reference architectures and technology capabilities to help you as you build your architecture and roadmap including:
    - [Azure components and reference model](https://docs.microsoft.com/security/compass/microsoft-security-compass-introduction#azure-components-and-reference-model-2151) to accelerate planning and design of Azure security roles.
      ![Azure administration model](../_images/security/azure-administration-model.png)
      ![Azure RBAC model](../_images/security/azure-rbac-model.png)
    - [Microsoft cybersecurity reference architecture](https://aka.ms/mcra) to build an overall cybersecurity architecture for a hybrid enterprise spanning on-premises and cloud resources.
    - [Security operations center (SOC) reference architecture](https://docs.microsoft.com/security/compass/security-operations-videos-and-decks#part-1-introduction---soc-learnings-strategies-and-technical-integration-2430) to modernize security detection, response, and recovery.
    - [Zero-trust user access reference architecture](https://docs.microsoft.com/security/ciso-workshop/ciso-workshop-module-3#part-5-zero-trust-user-access-reference-architecture-842) to modernize access control architecture for cloud generation.
    - [Azure Security Center](https://docs.microsoft.com/azure/security-center/) and [Microsoft cloud app security](https://docs.microsoft.com/cloud-app-security/) to secure cloud assets.
  - **Security awareness and education plan:** Aso all teams have basic critical security knowledge.
  - **Asset sensitivity marking:** To designate sensitive assets using a taxonomy aligned to business impact (built jointly by business stakeholders, security teams, and other interested parties).

- **Assume a hybrid environment:** That includes software as a service (SaaS) applications, on-premises environments, and multiple cloud infrastructure as a service and platform as a service providers (if applicable).
- **Update cloud plan with security changes:** Update other sections of the main cloud adoption plan to reflect changes triggered by the security plan.

**Best practices for security planning:**
Your security plan is likely to be more successful if your planning takes the approach of:

- **Agile security adoption:** Establish minimum security requirements first and move all noncritical items to a prioritized list of next steps.
This should not be a traditional detailed 3-5 year plan because the cloud and threat environment change too fast to make this type of plan useful. Your plan should focus on developing the beginning steps and end state:
  - **Quick wins:** Detailed plan for the immediate future to capture quick wins and begin longer term initiatives that will deliver a high impact. This can be 3-12 months depending on organizational culture, standard practices, and other factors.
  - **Clear vision** of the desired end state to guide each team's planning process (which may take multiple years to achieve).
- **Sharing the plan broadly:** To increase awareness of, feedback from, and buy-in by stakeholders.
- **Meet the strategic outcomes:** Ensure that your plan aligns to and accomplishes the strategic outcomes described in the security strategy
- **Ownership, accountability, and deadlines:** Ensure that the owners for each task are identified and are committed to completing that task in a specific time frame.
- **Connect with the human side of security:** To engage people during this period transformation and new expectations by:
  - **Actively supporting team member transformation:** With clear communication and coaching on:
    - What skills they need to learn
    - Why they need to learn them (and the benefits of doing so)
    - How to get this knowledge (and provide resources to help them learn).
  This can be documented using the [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) and you can use [online Microsoft security training](https://docs.microsoft.com/security/compass/microsoft-security-compass-introduction) to help with education of your team members.
  - **Make security awareness engaging:** To help people genuinely connect with their part of keeping the organization safe.
- **Review Microsoft learnings and guidance:** Microsoft has published insights and perspectives to help your organization plan their transformation to the cloud and a modern security strategy including recorded training, documentation, and security best practices and recommended standards.
  For technical guidance to help build your plan and architecture, see the [Microsoft security documentation](https://docs.microsoft.com/security).

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud security team | <li> Cloud strategy team <li> Cloud governance team <li> Any risk teams in your organization <li> Cloud center of excellence or Central IT |

**Security plan approval:** Security leadership team (CISO or equivalent).

## Step 4: Secure new workloads

It's a lot easier to start in a secure state than to retrofit security later into your environment. We strongly recommend starting with a secure configuration to ensure workloads are migrated to and developed and tested in a secure environment.

During [landing zone](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone) implementation, many decisions can affect security and risk profiles. The cloud security team should review the landing zone configuration to ensure it meets the security standards and requirements in your organization's security baselines.

**Deliverables:**

- Ensure new landing zones meet the organization's compliance and security requirements.

**Guidance to support deliverable completion:**

- **Blend existing requirements and cloud recommendations:** Start with recommended guidance and then adapt this to your unique security requirements. We have seen challenges with trying to enforce existing on-premises policies and standards, because these often refer to outdated technology or security approaches. Microsoft has published guidance to help you build your security baselines:
  - [Azure security standards for strategy and architecture](https://docs.microsoft.com/security/compass/compass): Strategy and architectural recommendations to shape your environment's security posture.
  - [Azure security benchmarks](https://docs.microsoft.com/azure/security/benchmarks/introduction): Specific configuration recommendations for securing Azure environments.
  - [Azure security baseline training](https://docs.microsoft.com/learn/modules/create-security-baselines).
- **Provide guardrails:** These should have automated policy auditing and enforcement. For these new environments, teams should strive to both audit and enforce your organization's security baselines to minimize security surprises during the development as well as continuous integration and continuous deployment (CI/CD) of workloads.
Microsoft provides several native capabilities in Azure to enable this:
  - [Secure score](https://docs.microsoft.com/azure/security-center/secure-score-security-controls): A scored assessment of your Azure security posture that allows you to track security efforts and projects in your organization.
  - [Azure Blueprints](https://docs.microsoft.com/azure/governance/blueprints/overview): Cloud architects and Central IT groups can define a repeatable set of Azure resources that implements and adheres to an organization's standards, patterns, and requirements.
  - [Azure Policy](https://docs.microsoft.com/azure/governance/policy/): The foundation of the visibility and control capabilities used by these other services. Azure Policy is integrated into [Azure Resource Manager (ARM)](https://docs.microsoft.com/azure/azure-resource-manager), enabling you to audit changes and enforce policies across any resource in Azure before, during, or after its creation.
- [Improve landing zone operations](../ready/considerations/landing-zone-security.md): Use best practices for improving security within a given landing zone.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud security team | <li> Cloud adoption team <li> Cloud platform team <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or Central IT |

## Step 5: Secure existing cloud workloads

Many organizations have already deployed assets to enterprise cloud environments that did not apply the security best practices, creating increased business risk.

After you ensure that new applications and landing zones follow security best practices, you should focus on bringing existing environments up to the same standards.

**Deliverables:**

- Ensure all existing cloud environments and landing zones meet the organization's compliance and security requirements.
- Test operational readiness of production deployments using Security Baseline policies.
- Validate adherence to security baseline design guidance and security requirements.

**Guidance to support deliverable completion:**

- Use the same security baselines that you built in [Step 4](#step-4-secure-new-workloads) as your ideal state. You may have to adjust some policy settings to only audit instead of enforcing them.
- Balance operational and security risk. Since these environments may host production systems that enable critical business processes, you might need to implement security improvements incrementally to avoid risking operational downtime.
- Prioritize the discovery and remediation of security risk by business criticality, starting with workloads that have a high business impact if compromised and workloads with a high exposure to risk.

For more information, see [Identify and classify business critical applications](https://docs.microsoft.com/azure/architecture/framework/security/applications-services?toc=/security/compass/toc.json&bc=/security/compass/breadcrumb/toc.json#identify-and-classify-business-critical-applications).

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud adoption team <li> Cloud strategy team <li> Cloud security team <li> Cloud governance team <li> Cloud center of excellence or Central IT |

## Step 6: Govern to manage and improve security posture

Like all modern disciplines, security is an iterative process that should focus on continuous improvement. Security posture can also decay if organizations do not sustain focus on it over time.

Consistent application of security requirements comes from sound governance disciplines and automated solutions. Once the security baseline(s) are defined by the cloud security team, those requirements should be audited to ensure they are applied consistently to all cloud environments (and enforced where applicable).

**Deliverables:**

- Ensure the organization's security baselines are applied to all relevant systems and anomalies are audited using a [secure score](https://docs.microsoft.com/azure/security-center/secure-score-security-controls) or a similar mechanism.
- Document Security Baseline policies, processes, and design guidance in the [Security Baseline discipline template](../govern/security-baseline/template.md).

**Guidance to support deliverable completion:**

- Use the same security baselines and auditing mechanisms that you built in [Step 4](#step-4-secure-new-workloads) as technical components of monitoring the baselines, complemented by people and process controls to ensure consistency.
- Ensure all workloads and resources follow proper [naming and tagging conventions](../ready/azure-best-practices/naming-and-tagging.md) and [enforce tagging conventions using Azure Policy](https://docs.microsoft.com/azure/governance/policy/tutorials/govern-tags) with a specific emphasis on tags for "data sensitivity".
- If you are new to cloud governance, establish [governance policies, processes, and disciplines](../govern/index.md) using the Govern methodology.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud governance team | <li> Cloud strategy team <li> Cloud security team <li> Cloud center of excellence or Central IT |

## Next steps

These steps will guide you through implementing the right strategy, controls, processes, skills, and culture needed to consistently manage security risks across the enterprise.
As you continue into operations mode of cloud security, consider these next steps in a build on this getting started guidance.

- Review [Microsoft security documentation](https://docs.microsoft.com/security) that provides technical guidance to help security professionals build and improve cybersecurity strategy, architecture, and prioritized roadmaps.
- Review security information for [Azure services built-in security controls](https://docs.microsoft.com/azure/security/fundamentals/security-controls).
- Review Azure security tools and services in [Security services and technologies available on Azure](https://docs.microsoft.com/azure/security/azure-security-services-technologies).
- Review the [Microsoft Trust Center](https://www.microsoft.com/trustcenter/guidance/risk-assessment) as it contains extensive guidance, reports, and related documentation that can help you perform risk assessments as part of your regulatory compliance processes.
- Review third-party tools available to facilitate meeting your security requirements. For more information, see [Integrate security solutions in Azure Security Center](https://docs.microsoft.com/azure/security-center/security-center-partner-integration).
