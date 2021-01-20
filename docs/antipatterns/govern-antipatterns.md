---
title: "Govern Antipatterns"
description: When adopting the cloud, a company needs to have a good understanding of their responsibilities, the cloud providers responsibilities. and cloud governance and security standards.
author: sarahwendel
ms.author: brblanch
ms.date: 01/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: think-tank
---

# Govern Antipatterns

Customers frequently experience a number of common cloud adoption antipatterns while in the govern phase of cloud adoption.
When adopting the cloud, you need to have an understanding of shared responsibilities, and build your security strategy on existing frameworks rather than creating your own.

## Antipattern: Misalignment on shared responsibility

When adopting the cloud, a company needs to have a good understanding where their responsibility ends, and the cloud providers responsibility starts, respectively the other way around regarding the different “as a Service” models. It's important that employees have essential skilling and cloud knowledge to be able to understand and build processes and practices around potential work items that result in different as-a-service models.

### Example of misalignment antipattern

Some of A. Datum's HR department set up several Windows servers in the cloud using Infrastructure as a Service. They assumed that Update Management is taken care of by the cloud platform/provider, since on-premises the IT takes care about installing updates. However, the deployment and installation of Operation System Updates is not done by Azure and needs to be configured separately. This results in the servers being uncompliant and a security risk.

### Preferred outcome: readiness plan that outlines responsibilities

Make sure that employees are familiar with the [shared responsibility](/azure/security/fundamentals/shared-responsibility.md) aspect in the cloud. To get the most out of your cloud initiative, build and create a [readiness plan](../plan/adapt-roles-skills-processes.md). A readiness plan can create momentum and keep the momentum for learning and developing expertise going.

## Antipattern: Take out-of-the-box security as a given

Security is often received as a given in the cloud. Whilst the initial assumption of given security is correct, it can differ to the requirements that a compliance framework needs the environment to adhere to. Basic security is provided in Azure. The Azure portal also provides help for improving the security state, for example the Azure Security Center. But enforcing a compliance and security standard is not an out-of-the-box experience when creating a subscription.

### Example of out-of-the-box security antipattern

Contoso developed a new application in the cloud. The chosen architecture is based on several PaaS services but also on some IaaS components for debugging purposes. After releasing the application to production, they slowly realize that one of their Jump Servers has been compromised and was extracting data to an unknown IP. This was because the Jump Server had a public IP, and a password that was easy to guess. This could have been easily avoided if they had more focus on cloud security.

### Preferred outcome: define a cloud security strategy

Companies should make sure that they have defined a proper (Cloud) [Security Strategy](../strategy/define-security-strategy.md) in place. The CISO can get a better understanding when exploring the [CISO cloud readiness guide](../govern/policy-compliance/cloud-security-readiness.md). It discusses topics like: Security platform resources, Privacy and controls, Compliance and Compliance, Transparency.

When it comes to a secure cloud workload, the [Azure Security Benchmark](https://docs.microsoft.com/azure/security/benchmarks/introduction) is a great place to start. Building up on the Center for Internet Security (CIS) Controls Version 7.1 and National Institute of Standards and Technology (NIST) SP800-53 Framework, this benchmark is equipped to address most security risks and measures.

Considering platform security and a holistic view on cloud security the Azure Security Guide can be used to identify risks, adapt best practices, and improve the company’s security posture.

Furthermore, company-specific compliance and security requirements need to be implemented or enabled to meet requirements. [Azure Policy](/azure/governance/policy/overview.md) and [Azure Blueprints](/azure/governance/blueprints/overview.md) automate compliance and security in Azure.

## Antipattern: Establishing your own compliance or governance framework

Introducing a custom compliance and governance framework that is not based on industry standards, can substantially increase the adoption time, since they are often not easily translatable towards cloud settings. This results in increased effort of translating custom measures and requirements into implementable security controls for the company. Even though most companies have similar security & compliance requirements that they need to comply to. Which often leads then to a custom compliance and security framework that only differs a little to existing compliance frameworks. If additional security requirements exist, reconsider building up a whole framework.

### Example of this antipattern

The CISO of Contoso has assigned its IT Security employees to come up with a cloud security strategy and framework. Rather than building up on an already existing standard the IT Security department decides to come up with a new framework that builds on the existing on-premises security policy. After completing the cloud security policy, AppOps/DevOps teams have difficulties implementing the cloud security policy.

As the controls in Azure differ and offer more comprehensive security and compliance structure. This leads to the impression by the CISO team that they are not able to comply with their existing compliance and security rules, even though this is only dependent on the way they tried to introduce security controls.

### Preferred outcome: Build on existing frameworks

Use, or build on existing frameworks such as, Center for Internet Security (CIS) Controls Version 7.1 or National Institute of Standards and Technology (NIST) SP800-53. Do this before establishing or introducing your custom company compliance framework. It will make the translation into cloud security settings easier and be more measurable. Find more framework implementations on the [Azure Blueprints samples page](/azure/governance/blueprints/samples). There are also blueprints for common [compliance frameworks](/azure/governance/blueprints/samples) available for Azure.

## Next steps

- [Adapt existing roles, skills, and processes for the cloud](../plan/adapt-roles-skills-processes.md)
- [Define a security strategy](../strategy/define-security-strategy.md)
