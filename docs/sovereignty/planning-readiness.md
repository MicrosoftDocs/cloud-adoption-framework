---
title: Planning and organizational readiness for sovereignty
description: "Prepare your organization for sovereignty by defining requirements, controls, governance, deployment model, operating model, responsibilities, skilling, cost, FinOps."
#customer intent: As a decision maker, I want to understand the controls and enforcement mechanisms across the deployment options in the Microsoft Sovereign Cloud (public, private, and national partner clouds) and the organizational, operational, and financial preparations required to successfully adopt and operate it at scale.
author: stephen-sumner
ms.author: mileppo
ms.reviewer: ssumner
ms.date: 09/01/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Planning and organizational readiness for sovereignty

*This article helps decision makers prepare their organization to meet their sovereignty requirements. It's the first step in the process to help decision makers with sovereignty adoption.*

:::image type="complex" border="false" source="./images/sovereignty-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for sovereignty adoption." lightbox="./images/sovereignty-adoption-process.svg":::
    Diagram showing the phases of the Microsoft Sovereign Cloud adoption process: Planning and readiness, Azure landing zone architecture and governance, and operational standards. An Azure landing zone is the prerequisite to start and each phase builds on the previous.
:::image-end:::

Sovereignty affects governance, operating models, deployment decisions, skills, funding, and risk management. The objective is to establish a consistent approach for evaluating sovereignty requirements, assessing organizational readiness, and making informed adoption decisions.

**Outcome**: By the end of planning and readiness, you can align deployment decisions, operating responsibilities, skilling, and funding with your sovereignty requirements.

## Decision tree and architectures

# [Decision tree](#tab/decisiontree)

:::image type="complex" source="./images/sovereignty-decision-tree.svg" alt-text="Diagram showing a decision tree for Microsoft Sovereign Cloud that guides organizations from sovereignty requirements to a recommended deployment model, governance architecture, and operational standards." lightbox="./images/sovereignty-decision-tree.svg" border="false":::
    If you need to define sovereignty requirements and controls, start with Sovereignty Planning. If standard Microsoft cloud capabilities and governance controls are sufficient, use Azure Public Cloud. If the workload requires sovereignty controls for governance, data residency, confidentiality, encryption, key management, or operator access oversight, use Sovereign Public Cloud. If the workload requires customer-controlled infrastructure or local operations, determine whether Azure connectivity is required. If connectivity is required, use Sovereign Private Cloud Connected. If connectivity isn't required, use Sovereign Private Cloud Disconnected. If the workload requires infrastructure operated under national jurisdiction by a local provider, use National Partner Cloud. Before onboarding workloads, determine whether sovereignty architecture and governance guidance is required and whether sovereignty operational standards are needed to maintain ongoing compliance. The process concludes with onboarding workloads to the selected Microsoft Sovereign Cloud environment.
:::image-end:::

*Decision tree for the Microsoft Sovereign Cloud. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-microsoft-sovereign-cloud.pptx) of this architecture.* 

# [Conceptual](#tab/conceptual)

:::image type="complex" source="./images/microsoft-sovereign-cloud-conceptual.svg" alt-text="Diagram showing a conceptual view of the three Microsoft Sovereign Cloud deployment options (Sovereign Public Cloud, Sovereign Private Cloud, and National Partner Cloud) and sovereign workloads in an Azure landing zone." lightbox="./images/microsoft-sovereign-cloud-conceptual.svg" border="false":::
    Conceptual architecture diagram showing how an Azure landing zone supports sovereign workloads across multiple deployment models. At the center, a sovereign Azure landing zone in a sovereign public cloud contains a platform landing zone that provides shared governance and management services, along with application landing zones for individual workloads. One application landing zone hosts a sovereign public cloud workload and another hosts a sovereign private cloud workload. Microsoft 365 services, security, identity, and data governance services provide capabilities across the environment. The sovereign private cloud workload extends to an on-premises Azure Local environment, where workloads run on local hardware. A separate national partner cloud deployment model appears alongside the Azure landing zone and shows workloads running on partner-controlled infrastructure. The diagram illustrates how sovereignty controls can be applied across public cloud, private cloud, and partner-operated environments within a unified Cloud Adoption Framework architecture.
:::image-end:::

*Conceptual view of sovereign workloads across the three Microsoft Sovereign Cloud deployment options. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-microsoft-sovereign-cloud.pptx) of this architecture.* 

# [Conceptual + integration](#tab/conceptualintegration)

:::image type="complex" source="./images/microsoft-sovereign-cloud-conceptual-enterprise-integration.svg" alt-text="Diagram showing a conceptual view of the three Microsoft Sovereign Cloud deployment options (Sovereign Public Cloud, Sovereign Private Cloud, and National Partner Cloud), sovereign workloads in an Azure landing zone, and how it integrates with your Microsoft enterprise architecture." lightbox="./images/microsoft-sovereign-cloud-conceptual-enterprise-integration.svg" border="false":::
    Conceptual architecture diagram showing how an Azure landing zone supports sovereign workloads across multiple deployment models. At the center, a sovereign Azure landing zone in a sovereign public cloud contains a platform landing zone that provides shared governance and management services, along with application landing zones for individual workloads. One application landing zone hosts a sovereign public cloud workload and another hosts a sovereign private cloud workload. Microsoft 365 services, security, identity, and data governance services provide capabilities across the environment. The sovereign private cloud workload extends to an on-premises Azure Local environment, where workloads run on local hardware. A separate national partner cloud deployment model appears alongside the Azure landing zone and shows workloads running on partner-controlled infrastructure. The diagram illustrates how sovereignty controls can be applied across public cloud, private cloud, and partner-operated environments within a unified Cloud Adoption Framework architecture.
    Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*Conceptual view of sovereign workloads across the three Microsoft Sovereign Cloud deployment options that shows enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-microsoft-sovereign-cloud.pptx) of this architecture.* 

---

## 1. Requirements

This section helps decision makers establish sovereignty requirements before selecting controls. Base sovereignty decisions on risk. The objective is to understand which requirements apply, determine the consequences of noncompliance, and define the controls needed to reduce risk to an acceptable level.

### 1.1 Requirements gathering

*What must we do?* Identify the sovereignty requirements that apply to your organization before evaluating technology solutions. Get requirements from laws, regulations, government policy, contractual obligations, and internal risk policies. 

**Outcome**: You should have an approved sovereignty requirements catalog that identifies sovereignty requirements, their sources, accountable owners, consequences of noncompliance, and risk significance.

1.  **Collect the sovereignty drivers.** Review the sources that create sovereignty obligations. Record each source and identify the accountable owner. These drivers establish the criteria for future sovereignty decisions.

2.  **Collect requirements.** Translate each driver into clear requirements that you can assess and govern. Record the source of each requirement and the consequence of noncompliance. Sovereignty requirements typically align to data residency, data confidentiality, operator control, infrastructure control, sovereign AI, and resilience requirements.

3.  **Assess the risk.** Determine the impact of failing to meet each requirement. Consider regulatory exposure, contractual penalties, operational disruption, and reputational damage. The level of risk influences the controls that you need to implement. 

4. **Establish traceability.** Maintain traceability from sovereignty driver, to requirement, to risk, to control, and to compliance evidence. Traceability helps demonstrate that every control is implemented to address a documented requirement or approved risk treatment.

*See table for common sovereignty requirements and definitions.*

| Sovereignty requirement | Definition |
|---|---|
| Cloud governance, security, and management | Governance: Automated and manual means of policy enforcement. Security: Prevent and detect security threats and risks. Management: Workloads are resilient and provide business continuity. |
| Data residency | Data stays inside approved boundaries, regions and/or locally, to meet availability mitigation requirements. |
| Data confidentiality at rest | Data is encrypted when it's stored. |
| Data confidentiality in transit | Data is encrypted when it moves across a network. |
| Data confidentiality in use | Data stays protected in memory during processing. |
| Data confidentiality with key control | Hold and control the encryption keys that protect data. |
| Operator access control | Cloud operators can't perform privileged actions in your environment without your approval. |
| Operator auditing | See and audit what the cloud provider operators did in your environment and when. |
| Infrastructure control | You or a local partner controls the physical hardware and decides who operates it. |

### 1.2 Classifications

*How can we scale sovereignty?* Most organizations can't evaluate and apply sovereignty requirements individually for every workload. Instead, create a small number of sovereignty classifications that group requirements commonly needed together. 

A sovereignty classification is a reusable grouping of sovereignty requirements. ***Classifications aren't maturity levels. Each classification represents a different combination of sovereignty requirements.*** Workloads assigned to the same classification have the same sovereignty requirements and inherit the same controls. Classifications improve consistency, simplify governance, and help ensure similar workloads receive the same level of protection.

**Outcome**: You should have a small set of approved sovereignty classifications that group common requirements and provide a consistent governance model for affected workloads.

1.  **Group common requirements into classifications.** Review your approved requirement catalog and identify common combinations of requirements. Create classifications that represent those combinations. Don't create new requirements at the classification level. 

2. **Map controls to each classification.** Define the governance, security, operational, and infrastructure controls required to meet the requirements of each classification.

3. **Assign workloads to classifications.** Evaluate workload requirements and assign each workload to the classification that best matches its sovereignty needs. Workloads in the same classification should inherit the same controls and governance policies.

4. **Keep classifications manageable.** Most organizations can operate effectively with three to five classifications. Additional classifications increase complexity and make governance harder to maintain consistently. 

*See the following table for example sovereignty classifications.*

| Example sovereignty classification | Example requirements |
|---|---|
| Classification A | Data residency |
| Classification B | Data residency, data confidentiality at rest and in transit |
| Classification C | Data residency, data confidentiality: at rest, in transit, and in use |
| Classification D | Data residency, data confidentiality: at rest, in transit, in use, and key control |
| Classification E | Data residency, data confidentiality: at rest, in transit, in use, and key control, and operator access and auditing |

For an implementation example, see [Design sovereign policy initiatives in Azure](/azure/azure-sovereign-clouds/public/design-sovereign-policies).

### 1.3 Inventory

*Which workloads have sovereignty gaps?* Build an inventory of workloads and assign each workload to the sovereignty classification that best matches its regulatory, contractual, operational, and business obligations. The objective is to determine which workloads have sovereignty requirements, identify the applicable classification, and assess any gaps between current controls and the approved control baseline.

**Outcome**: You should have a workload inventory that identifies assigned sovereignty classifications, compliance gaps, associated risks, and approved risk treatment decisions.

1.  **Assign classifications.** Map each workload to the sovereignty classification that reflects its requirements. Workloads inherit the requirements of that classification.

2.  **Identify gaps.** Compare the current state of each workload against the requirements of its assigned classification. Record unmet requirements and exceptions.

3.  **Assess risk exposure and determine treatment.** Evaluate the regulatory, contractual, operational, and business impact of each identified gap. Determine whether to remediate the gap, implement compensating controls, accept the risk, or approve an exception according to organizational policy.

The inventory should identify affected workloads, assigned classifications, met and unmet requirements, associated sovereignty risks, and the approved treatment for each identified gap, such as accept the risk or mitigate it. 

*See the following table for an example workload sovereignty inventory.*

| Workload  | Classification | Data residency | Data confidentiality at rest | Data confidentiality in transit | Data confidentiality in use | Key control | Operator access control | Operator audit | Infrastructure control |
|---|---|---|---|---|---|---|---|----|
| Workload name | Classification label | Add details | Add details | Add details | Add details | Add details | Add details | Add details |

## 2. Controls

*How do you meet the sovereignty requirements?* Translate sovereignty requirements into a control baseline for each sovereignty classification. The controls should address the risks you identified during classification and inventory. Workload teams inherit the control baseline for their assigned classification.

**Outcome**: You should have an approved control baseline for each sovereignty classification, including enforcement methods and evidence needed to demonstrate compliance.

1. **Map requirements to controls.** For every sovereignty requirement, identify the controls that satisfy it and the evidence used to demonstrate compliance. Maintain traceability from source driver, to requirement, to control, to evidence. Don't create controls without a documented requirement or risk justification.

2.  **Control baseline.** Establish a control baseline for each sovereignty classification. Workload teams inherit the approved baseline and implement it consistently. They shouldn't reinterpret the organization's sovereignty risk tolerance.

3.  **Control enforcement.** Determine how to enforce each control and how to demonstrate compliance. Use preventive controls when deviations aren't acceptable. Use audit and remediation controls when managed exceptions are acceptable. Prefer automated enforcement and continuous evidence where supported. Reassess controls when requirements change or evidence indicates drift. 

*See the table for Sovereignty controls and enforcement methods in Microsoft Sovereign Cloud.*

| Sovereignty requirement category| Sovereign Public Cloud | Sovereign Private Cloud | National Partner Cloud |
|---|---|---|---|
| Foundational | Controls: [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) <br><br>Enforcement: [Azure Policy](/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance), [Microsoft Defender](/azure/cloud-adoption-framework/secure/overview#sustain-security-posture), [Microsoft Entra](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access), [Microsoft Purview](/azure/cloud-adoption-framework/data/governance-security-baselines-purview-data-estate-unify-data-platform) | Controls: [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/), [Security defaults](/azure/azure-local/manage/manage-secure-baseline#configure-security-settings-during-deployment) <br><br>Enforcement: Azure Policy [connected](/azure/governance/policy/overview), [disconnected](/azure/azure-local/manage/disconnected-operations-policy) | Partner-specific |
| [Data residency](https://azure.microsoft.com/explore/global-infrastructure/data-residency/#overview) | Controls: [Region selection](/azure/azure-sovereign-clouds/data-controls#data-residency), [EU Data Boundary](/privacy/eudb/eu-data-boundary-learn), [Microsoft Entra ID](/entra/fundamentals/data-residency) <br><br>Enforcement: [Azure Policy](/azure/governance/policy/samples/mcfs-baseline-confidential#so1---data-residency), [Go-Local](/entra/fundamentals/data-residency#go-local-add-on) | Controls: Customer-controlled infrastructure placement <br><br>Enforcement: Configuration | Partner-specific |
| Data confidentiality at rest | Controls: [Encryption at rest](/azure/security/fundamentals/encryption-atrest) <br><br>Enforcement: Azure default setting | Controls: Encryption at rest [connected](/azure/azure-local/assurance/azure-stack-iso27001-guidance#encrypting-data-with-bitlocker) and [disconnected](/azure/azure-local/manage/disconnected-operations-security#data-at-rest-encryption) <br><br>Enforcement: Manual configuration| Partner-specific |
| Data confidentiality in transit | Controls: [Encryption in transit (TLS 1.2+)](/azure/security/fundamentals/encryption-overview#encryption-in-transit), [Private Link](/azure/private-link/private-link-overview), [Virtual Network integration](/azure/virtual-network/vnet-integration-for-azure-services) <br><br>Enforcement: Azure Policy for [HTTPS](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/c7c0ab87-63da-4706-ba95-ff564e38402b.html), [TLS version](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/f1fe6a81-eee9-47b8-9f7f-80685141209e.html), [Private Link](/azure/governance/policy/samples/built-in-initiatives?context=/azure/governance/policy/context/policy-context#sdn) | Controls: Encryption in transit [connected](/azure/azure-local/assurance/azure-stack-iso27001-guidance) and [disconnected](/azure/azure-local/manage/disconnected-operations-pki) <br><br>Enforcement: Manual configuration | Partner-specific |
| Data confidentiality in use | Controls: [Confidential computing](/azure/confidential-computing/overview) <br><br>Enforcement: [Azure Policy](/azure/governance/policy/samples/mcfs-baseline-confidential#so4---azure-confidential-computing) | Controls: [Confidential VMs](/azure/azure-local/manage/confidential-vm-overview), [Trusted Launch](/azure/azure-local/manage/trusted-launch-vm-overview) <br><br>Enforcement: SKU selection for confidential VMs, Azure Policy for [Trusted Launch](/azure/governance/policy/samples/built-in-policies#trusted-launch) | Partner-specific |
| Data confidentiality with key control | Controls: [Customer-managed keys](/azure/security/fundamentals/encryption-models#server-side-encryption-by-using-customer-managed-keys-in-azure-key-vault-and-azure-key-vault-managed-hsm-optional) (CMK), [managed HSM](/azure/azure-sovereign-clouds/public/external-key-management#azure-key-vault-managed-hsm-key-sovereignty), and/or [External Key Management](/azure/azure-sovereign-clouds/public/external-key-management#managed-hsm-external-key-management-preview) <br><br>Enforcement: Azure Policy for [CMK](/azure/governance/policy/samples/mcfs-baseline-confidential#so3---customer-managed-keys) and [HSM](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/7a00a7fc-fdf4-4ad8-8fa2-a94acc223e8e.html) | Controls: Customer-controlled keys <br><br>Enforcement: Azure Policy for [CMK](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/f15f4d95-c59c-4395-9317-be6978d0743f.html) and [HSM](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/7a00a7fc-fdf4-4ad8-8fa2-a94acc223e8e.html)| Partner-specific |
| Operator access | Controls: [Data Guardian](/azure/azure-sovereign-clouds/public/sovereign-public-cloud-capabilities) (EU and EFTA) and [Customer Lockbox](/azure/security/fundamentals/customer-lockbox-overview)  <br><br>Enforcement: [Enable Customer Lockbox](/azure/security/fundamentals/customer-lockbox-overview#enable-customer-lockbox-for-microsoft-azure) | Controls: Customer operator, identity access for [connected](/azure/azure-local/assurance/azure-stack-iso27001-guidance) and [disconnected](/azure/azure-local/manage/disconnected-operations-security#security-and-compliance-overview)  <br><br>Enforcement: Manual | Partner-specific |
| Operator auditing | Controls: [Confidential ledger](/azure/confidential-ledger/) <br><br>Enforcement: Manual | Controls: Customer operator<br><br>Enforcement: Manual | Partner-specific |
| Infrastructure control | Microsoft-operated | Controls: Customer-owned hardware <br><br>Enforcement: Manual | Partner-specific |
| Policy management | Control: [Sovereign Control Panel](/azure/azure-sovereign-clouds/public/sovereign-control-panel), [Azure Policy](/azure/governance/policy/concepts/regulatory-compliance) <br><br>Enforcement: Manual | Controls: Azure Policy <br><br>Enforcement: Manual | Partner-specific |

## 3. Deployment model

Select the deployment model that satisfies the sovereignty requirements and risk tolerance for the workload classification. Most organizations use a combination of deployment models across their workload portfolio. For workloads with documented sovereignty requirements, start with Sovereign Public Cloud, which is Azure Public Cloud with sovereignty controls and operational assurances configured. Move to Sovereign Private Cloud or National Partner Cloud only when those requirements can't be met through Microsoft's hyperscale cloud services.

- **Sovereign Public Cloud**: Use when sovereignty requirements can be met through controls available in Azure Public Cloud, including data residency, data confidentiality (encryption at rest, encryption in transit, and protection in use), key control, operator access oversight, and auditing. Sovereign Public Cloud is Azure Public Cloud with sovereignty controls and operational assurances applied.

- **Sovereign Private Cloud**: Use when requirements mandate customer-controlled infrastructure, local operations, or disconnected conditions within customer-managed facilities. Determine whether continuous Azure connectivity is required. It can also provide a sovereign recovery environment for the organization's minimum viable operations during a disruption. A deployment may serve either purpose or both.

    Choose validated hardware from the [Azure Local solutions catalog](https://azurelocalsolutions.azure.microsoft.com/) and confirm your workloads run in the mode you intend. Set procurement and facility dates before you set a migration date.

    - **Connected**: Use when workloads require local infrastructure and operations but benefit from Azure-connected services and management capabilities.

    - **Disconnected**: Use when workloads must continue to operate without Azure connectivity or in air-gapped environments.

- **National Partner Cloud**: Use when requirements mandate nationally governed and operated cloud infrastructure that is independent of Microsoft operations. Confirm eligibility requirements, onboarding processes, service availability, and capacity before adoption. Confirm eligibility requirements, onboarding processes, service availability, and capacity constraints for the target National Partner Cloud.

## 4. Operating model

*How do we operate the selected deployment model?* Select an operating model that aligns with the deployment model, sovereignty requirements, and organizational responsibilities. The operating model determines who manages the environment, who owns operational risk, and what skills and processes are required.

- **Sovereign Public Cloud**: Extend your existing cloud operating model to incorporate sovereignty requirements. See [Cloud operating model](/azure/cloud-adoption-framework/plan/prepare-organization-for-cloud#choose-a-cloud-operating-model).

- **Sovereign Private Cloud**: Your organization assumes responsibility for operating the underlying infrastructure. You need local operators to install, manage, maintain, and support the environment regardless of connectivity mode.

  - **Connected**: Platform teams provision and manage subscriptions for workload teams. Workload teams continue to consume application landing zones and platform services in a manner similar to Azure. Smaller environments often manage Azure Local as part of the existing platform team. Larger environments might require a dedicated Azure Local operations team.

  - **Disconnected**: On-premises operations teams manage the infrastructure and platform environment locally. Platform governance and workload onboarding processes remain important, but Azure-connected management capabilities aren't available. Organizations should plan for local administration, monitoring, maintenance, and incident response capabilities.

- **National partner clouds**: Operating model principles remain the same, but operational responsibilities vary by provider. Review the provider's operating model, support model, and service boundaries before adoption.

## 5. Roles and responsibilities

Sovereignty decisions affect legal obligations, risk management, security, architecture, operations, and cost. Different stakeholders often have competing priorities. Clear accountability helps organizations make consistent risk-based decisions, manage exceptions, and integrate sovereignty into existing governance, risk, compliance, and architecture processes.

1.  **Executive sovereignty sponsor**: Assign an executive sponsor with authority over sovereignty strategy, funding, and risk acceptance. The sponsor owns the organization's sovereignty objectives and approves tradeoffs that affect business risk.

2.  **Cross-functional sovereignty team**: Give the sponsor a cross-functional sovereignty team that includes legal, risk, compliance, security, enterprise architecture, and platform engineering. This team defines sovereignty requirements, approves classifications, reviews exceptions, and ensures sovereignty decisions align with organizational risk tolerance.

3.  **Cloud platform team**: Include representation from the platform team responsible for shared platform assets, such as platform landing zones. Many sovereignty requirements are implemented through shared platform capabilities rather than individual workloads. In some organizations, the platform team might also own the architecture and implementation of sovereignty controls across the platform.

## 6. Skilling

Identify the skills required for each selected deployment model and assign an accountable team to every operational duty. Include platform engineering, security operations, identity, networking, hardware lifecycle, compliance evidence, cost management, and incident response.

*See the following table for skills to build by sovereign deployment model.*

| Delivery model | Skills your teams need| Where to learn  |
|---|---|---|
| **Sovereign Public Cloud**  | Apply sovereign policy guardrails, manage customer-controlled keys, run confidential workloads, and approve operator access | [Controls and principles in Sovereign Public Cloud](/azure/azure-sovereign-clouds/public/overview-controls-principles), [Sovereign Public Cloud capabilities](/azure/azure-sovereign-clouds/public/sovereign-public-cloud-capabilities), [Sovereign landing zone](/azure/azure-sovereign-clouds/public/overview-sovereign-landing-zone), and [Sovereign design and implementation considerations](/azure/azure-sovereign-clouds/sovereignty-implementation) |
| **Sovereign Private Cloud** | Operate infrastructure you own, including hardware lifecycle, physical security, and disconnected operations                | [What is Sovereign Private Cloud?](/azure/azure-sovereign-clouds/private/overview/sovereign-private-cloud), [Introduction to Azure Local](/training/modules/azure-local/), and the [Azure Local documentation](/azure/azure-local/) |
| **National Partner Cloud**  | Work within the partner's operating model, support process, and service catalog | [National Partner Clouds](/azure/azure-sovereign-clouds/partner/overview-national-partner-clouds) plus the operator's own onboarding material |

## 7. Cost management and FinOps

*How do you optimize spending?* Plan for the full lifecycle cost of the selected deployment model before adoption. Sovereignty can introduce new infrastructure, operational, staffing, and contractual commitments. The objective is to understand these commitments early and align them with budget, procurement, and long-term operating plans.

- **Sovereign Public Cloud**: Extend existing Cost Management and FinOps practices. Identify any sovereignty capabilities that affect cost, such as customer-controlled keys, confidential workloads, or deployment restrictions. Incorporate these requirements into workload planning and budgeting.

- **Sovereign Private Cloud**: Evaluate infrastructure acquisition, software licensing, third-party software support, support contracts, facility requirements, hardware refresh cycles, staffing, and resiliency requirements before adoption. Establish capacity forecasts and procurement plans that account for expected growth and hardware lead times. Include recurring licensing, maintenance, and vendor support costs in long-term financial planning.

- **National Partner Clouds**: Operating model principles remain the same, but operational responsibilities vary by provider. Review the provider's operating model, support model, and service boundaries before adoption.

## 8. Workload prioritization

*What workloads do you fix first?* Prioritization is a risk decision. The objective is to address the sovereignty risks that create the greatest exposure for the organization.

Business criticality is an important consideration, but sovereignty risk should drive prioritization. A workload with limited business impact might still require immediate attention if noncompliance creates significant consequences.

**Outcome**: You have a prioritized remediation plan that aligns sovereignty investments with organizational risk and compliance objectives.

-  **Evaluate sovereignty risk.**  Work with the cross-functional sovereignty team to review existing practices and risk decisions against applicable legal, regulatory, contractual, and business requirements. Identify gaps, unintended consequences, and any risks transferred or concentrated elsewhere in the organization.

- **Consider business criticality.** Assess how important the workload is to mission outcomes, sovereign services, essential services, or business operations. Consider the consequences if the workload becomes unavailable or requires significant changes to address sovereignty requirements.

- **Prioritize remediation.** Focus first on workloads where sovereignty gaps create the greatest organizational risk. Use business criticality to inform remediation priorities and investment decisions. Align remediation activities with approved risk tolerance and compliance objectives.

The outcome is a prioritized remediation plan that aligns sovereignty investments with organizational risk and compliance objectives.

## Next step

> [!div class="nextstepaction"]
> [Architecture and governance](./azure-landing-zone-architecture-governance.md)
