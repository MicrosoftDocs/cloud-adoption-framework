---
title: Security governance and compliance
description: Use the Cloud Adoption Framework for Azure to learn about governance and compliance considerations regarding security.
author: joanabmartins
ms.author: joamar
ms.date: 04/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Security governance and compliance

Organizations of all sizes are constrained by their available resources: financial, people, and time. To achieve an effective return on investment (ROI), organizations must prioritize where they will invest. Implementation of security across the organization is also constrained by this, so to achieve an appropriate ROI on security the organization needs to first understand and define its security priorities.

The primary audience for this guidance is your organization's cloud architects and other members of your cloud governance team. The decisions, policies, and processes that emerge from this discipline should involve engagement and discussions with relevant members of your IT and security teams, especially those technical leaders responsible for implementing networking, encryption, and identity services. Therefore, important first actions to take include:

- Ensuring that the relevant stakeholders in these teams are identified
- Setting up the appropriate communication and collaboration mechanisms with them

## Landing zone concept

The term *landing zone* refers to components that are already defined and in place before the workloads are getting deployed by the workload owners, such as a hub and spoke network topology. The landing zone ensures that when a workload lands in Azure, the required plumbing is already in place, providing greater agility and compliance with enterprise security and governance requirements. It's crucial that a landing zone is handed over to the workload owner with the security guardrails already deployed.

As you establish corporate policy and plan your governance strategies, you can use tools and services like [Azure Policy, Azure Blueprints, and Azure Security Center](../../ready/azure-setup-guide/govern-org-compliance.md?tabs=AzureBlueprints) to enforce and automate your organization's governance decisions.

## Management groups

Azure [management groups](../../ready/azure-best-practices/organize-subscriptions.md#azure-management-groups) help you efficiently manage access, policies, and compliance for your subscriptions. Each management group is a container for one or more subscriptions. Any access or policy applied at one level in the hierarchy is inherited by the levels that follow it. A resource owner or subscription owner can't alter an inherited policy. This limitation helps improve governance.

The top level is called the root management group and any changes that are applied using this group should be carefully considered. The root management group ensures consistency across the enterprise by applying policies, permissions, and tags across all subscriptions. This group can affect all resources in Azure and incorrect use can affect the security of all workloads in Azure. For more information, see [Management group and subscription organization](../../ready/enterprise-scale/management-group-and-subscription-organization.md).

## Azure Policy

Defining organizational policy is not effective unless it can be [enforced across your organization](../../decision-guides/policy-enforcement/index.md). A key aspect of planning any cloud implementation is determining how best to combine tools provided by the cloud platform with your existing IT processes to maximize policy compliance across your entire cloud estate. Azure policies can be used on multiple levels. It's recommended to apply organizational wide security controls on Azure platform level. These policies build the guardrails of a landing zone.

You can determine the scope of your policy enforcement processes by focusing on these key elements:

- Your organization's [cloud governance requirements](../../govern/index.md)
- The size and nature of your cloud estate, and
- How your organization is reflected in your [subscription design](../../decision-guides/subscriptions/index.md).

## Regulatory and governance requirements

Compliance is challenging for multinational organizations, especially in heavily regulated industries like healthcare and financial services. Standards and regulations abound, and in certain cases may change frequently, making it difficult for businesses to keep up with changing international electronic data handling laws.

As with security controls, organizations should understand the division of responsibilities regarding regulatory compliance in the cloud. Whilst cloud providers strive to ensure that their platforms and services are compliant, organizations also need to confirm that their applications, the infrastructure those applications depend on, and services supplied by third parties are also certified as compliant, as the responsibilities are shared. For more information, see [Shared responsibility in the cloud](/azure/security/fundamentals/shared-responsibility).

[Introduction to regulatory compliance](../../govern/policy-compliance/regulatory-compliance.md) describes compliance regulations in various industries and geographies. Use this information to help identify which regulations are relevant for your organization.

 More detailed information about [Azure compliance offerings](/compliance/regulatory/offering-home) is available at the [Microsoft Trust Center](https://www.microsoft.com/trust-center). Moreover, all downloadable documentation is available to certain Azure customers from the [Microsoft Service Trust Portal](https://servicetrust.microsoft.com).

## Monitoring compliance

Compliance attestations should be regularly performed via [well-thought-out processes](../../govern/security-baseline/compliance-processes.md). Knowing whether your cloud resources are in compliance with standards mandated by governments or industry organizations (such as GDPR) is essential in today's globalized world. This requires constant involvement of the cloud governance team and interested business and IT stakeholders to review and update policy and ensure policy compliance through different processes. In addition, many ongoing monitoring and enforcement processes can be automated or supplemented with tooling to reduce the overhead of governance and allow for faster response to policy deviation. Continuous monitoring and assessing workload increases the overall security and compliance of your workload in Azure. For example [Azure Security Center](https://azure.microsoft.com/services/security-center/) provides a regulatory compliance dashboard.

## External or internal audits

Compliance is important for several reasons. Auditing security-related activities with IT staff and identifying any compliance issues not already handled should be part of the [ongoing monitoring and enforcement processes](../../govern/security-baseline/compliance-processes.md#planning-review-and-reporting-processes). The result of this audit is a report for the cloud strategy team and each cloud adoption team to communicate overall adherence to policy. The report is also stored for auditing and legal purposes. Noncompliance with regulatory guidelines may bring sanctions and penalties.

## Revision process

Best practices and guidelines, based on industry recommendations, should be reviewed and applied proactively. For guidance on proactively and comprehensively applying best practices to all systems as your cloud program is implemented, see [Security best practices](../security-top-10.md) .

## Attacker vs. defender costs

Cybersecurity attacks are planned and conducted by human attackers that must manage their return on investment into attacks (return could include profit or achieving an assigned objective). As you invest in security, you should carefully consider how you can damage the *attacker's return on investment* with your defensive investments.

The best way to damage an attacker's ability to successfully attack your organization is to increase their cost by preventing and detecting easy and cheap attack methods. Removing cheap and easy attacks impacts the effectiveness of all attackers and lowers your risk overall.

## Attacker access containment

The actual security risk for an organization is heavily influenced by how much access an adversary can or does obtain to valuable systems and data. Your investments should be focused on ensuring your security measures constrain how much access an adversary gets.

This should be covered on two fronts:

- **Time:** Limit how long the adversary can have access to your environment during an attack operation. This is primarily achieved through security operations and defining [metrics and indicators](../../govern/security-baseline/metrics-tolerance.md), that rapidly detect potential attacks, prioritizing potential detections so your team is focused on quickly investigating real attacks (vs. false positives), and reducing your mean time to remediate those real incidents.
- **Privilege:** Limit the privileges and permissions that an adversary can gain during an attack operation (by permissions and by the amount of time privileges that are assigned). As a vital first step, create a solid [identity baseline](../../govern/identity-baseline/index.md)

## Security plan

A security plan should be part of the main planning documentation for the cloud. It should include several core elements including organizational functions, security skilling, technical security architecture, and a capabilities roadmap.

We have created a [template](../../govern/security-baseline/template.md) to guide your organization discussions around your security baseline.
