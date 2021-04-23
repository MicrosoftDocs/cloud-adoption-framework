---
title: Governance and compliance
description: Use the Cloud Adoption Framework for Azure to learn about governance and compliance considerations regarding security.
author: joanabmartins
ms.author: joamar
ms.date: 02/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Security Governance and Compliance
Organizations of all sizes are constrained by their available resources: financial, people, and time. To achieve an effective return on investment (ROI) organizations must prioritize where they will invest. Implementation of security across the organization is also constrained by this, so to achieve an appropriate ROI on security the organization needs to first understand and define its security priorities.
The primary audience for this guidance is your organization's cloud architects and other members of your cloud governance team. The decisions, policies, and processes that emerge from this discipline should involve engagement and discussions with relevant members of your IT and security teams, especially those technical leaders responsible for implementing networking, encryption, and identity services.
Therefore, important first actions to take include:
- Ensuring that the relevant stakeholders in these teams are identified
- Setting up the appropriate communication and collaboration mechanisms with them


## Landing Zone concept 
The term "Landing Zone" refers to components that are already defined and in place before the workloads are getting deployed by the workload owners, e.g. network topology with Hub/Spoke concept. The purpose of the "Landing Zone" is to ensure that when a workload lands on Azure, the required "plumbing" is already in place, providing greater agility and compliance with enterprise security and governance requirements. It is crucial that a Landing Zone will be handed over to the workload owner with the security guardrails deployed.

As you establish corporate policy and plan your governance strategies, you can use tools and services like [Azure Policy, Azure Blueprints, and Azure Security Center](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/govern-org-compliance?tabs=AzureBlueprints) to enforce and automate your organization's governance decisions.

## Management groups 
Azure [management groups](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/ready/azure-best-practices/organize-subscriptions#azure-management-groups) help you efficiently manage access, policies, and compliance for your subscriptions. Each management group is a container for one or more subscriptions. Any access or policy applied at one level in the hierarchy is inherited by the levels below it. A resource owner or subscription owner can't alter an inherited policy. This limitation helps improve governance.

The top level is called the root management group and any changes that are applied using this group should be carefully considered.The root management group ensures consistency across the enterprise by applying policies, permissions, and tags across all subscriptions. This group can affect all resources in Azure and incorrect use can impact the security of all workloads in Azure. Please refer to [Management group and subscription organization](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/management-group-and-subscription-organization) for guidance on these points.

## Azure Policies 
Defining organizational policy is not effective unless it can be [enforced across your organization](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/decision-guides/policy-enforcement/). A key aspect of planning any cloud implementation is determining how best to combine tools provided by the cloud platform with your existing IT processes to maximize policy compliance across your entire cloud estate. Azure policies can be used on multiple levels. It is recommended to apply organizational wide security controls on Azure platform level. These policies build the guardrails of a landing zone.

You can  determine the scope of your policy enforcement processes by focusing on these key elements:  
•	Your organization's [cloud governance requirements](https://github.com/MicrosoftDocs/cloud-adoption-framework-pr/blob/release-security-methodology/docs/govern/index.md)
•	The size and nature of your cloud estate, and 
•	How your organization is reflected in your [subscription design](https://github.com/MicrosoftDocs/cloud-adoption-framework-pr/blob/release-security-methodology/docs/security/subscriptions/index.md). 


## Regulatory and governance requirements
Compliance is challenging for multinational organizations, especially in heavily regulated industries like healthcare and financial services. Standards and regulations abound, and in certain cases may change frequently, making it difficult for businesses to keep up with changing international electronic data handling laws.

As with security controls, organizations should understand the division of responsibilities regarding regulatory compliance in the cloud. Whilst cloud providers strive to ensure that their platforms and services are compliant, organizations also need to confirm that their applications, the infrastructure those applications depend on, and services supplied by third parties are also certified as compliant, as the responsibilities are shared (see [Shared responsibility in the cloud](https://docs.microsoft.com/en-us/azure/security/fundamentals/shared-responsibility). 

In the article [Introduction to regulatory compliance](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/govern/policy-compliance/regulatory-compliance) there are descriptions of compliance regulations in various industries and geographies, which you can use to help define which regulations are relevant for you organization 

 More detailed information about [Azure compliance offerings](/compliance/regulatory/offering-home) is available at the [Microsoft Trust Center](https://www.microsoft.com/trust-center). Moreover, all downloadable documentation is available to certain Azure customers from the [Microsoft Service Trust Portal](https://servicetrust.microsoft.com).

## Monitoring Compliance 
Compliance attestations should be regularly performed through [well-thought-out processes](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/govern/security-baseline/compliance-processes). Knowing whether your cloud resources are in compliance with standards mandated by governments or industry organizations is essential in today's globalized world (e.g. GDPR). This requires constant involvement of the cloud governance team and interested business and IT stakeholders to review and update policy and ensure policy compliance through different processes. In addition, many ongoing monitoring and enforcement processes can be automated or supplemented with tooling to reduce the overhead of governance and allow for faster response to policy deviation. Continuous monitoring and assessing workload increases the overall security and compliance of your workload in Azure. For example [Azure Security Center](https://azure.microsoft.com/en-us/services/security-center/) provides a regulatory compliance dashboard.

## External or internal audits 
Compliance is important for several reasons. Auditing security related activities with IT staff and identifying any compliance issues not already handled should be part of the [ongoing monitoring and enforcement processes](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/govern/security-baseline/compliance-processes#planning-review-and-reporting-processes). The result of this audit is a report for the cloud strategy team and each cloud adoption team to communicate overall adherence to policy. The report is also stored for auditing and legal purposes. Noncompliance with regulatory guidelines may bring sanctions and penalties.

## Revision process
Best practices and guidelines, based on industry recommendations, should be reviewed and applied proactively. Please refer to the article [Security best practices](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/security/security-top-10) for guidance on how to proactively and comprehensively apply best practices to all systems as a cloud program is implemented.

## Attacker vs. defender costs 
Cybersecurity attacks are planned and conducted by human attackers that must manage their return on investment into attacks (return could include profit or achieving an assigned objective). As you invest in security, you should carefully consider how you can damage the _attacker’s return on investment_ with your defensive investments.

The best way to damage an attacker’s ability to successfully attack your organization is to increase their cost by preventing and detecting easy and cheap attack methods. Removing cheap and easy attacks impacts the effectiveness of all attackers and lowers your risk overall.

## Attacker access containment 

The actual security risk for an organization is heavily influenced by how much access an adversary can or does obtain to valuable systems and data. Your investments should be focused on ensuring your security measures constrain how much access an adversary gets.

This should be covered in two front:
- **Time** -  Limit how long the adversary can have access to your environment during an attack operation. This is primarily achieved through security operations and defining [metrics and indicators](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/govern/security-baseline/metrics-tolerance), that rapidly detect potential attacks, prioritizing potential detections so your team is focused on quickly investigating real attacks (vs. false positives), and reducing your mean time to remediate those real incidents.
- **Privilege** - Limit the privileges and permissions that an adversary can gain during an attack operation (by permissions and by amount of time privileges are assigned). As a vital first step, create a solid [identity baseline](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/govern/identity-baseline/)

## Security plan 
A security plan should be part of the main planning documentation for the cloud. It should include several core elements including organizational functions, security skilling, technical security architecture and capabilities roadmap.

We have created a [template](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/govern/security-baseline/template) to guide your organization discussions around your Security Baseline.


