---
title: Govern antipatterns
description: When adopting the cloud, a company needs to have a good understanding of their responsibilities, the cloud providers responsibilities, and cloud governance and security standards.
author: sarahwendel
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: think-tank
---

# Govern antipatterns

Customers frequently experience a number of common cloud adoption antipatterns while in the govern phase of cloud adoption. As a best practice, take the time to understand shared responsibilities, and build your security strategy on existing frameworks instead of creating your own.

## Antipattern: Misalignment on shared responsibility

When you adopt the cloud, understand where your responsibility ends and the cloud provider's responsibility starts, and vice-versa, regarding the different as-a-service models. Using the required skills and cloud knowledge, build the processes and practices around work items that result in different as-a-service models.

### Example: Misalignment antipattern

Members of a company's human resources (HR) department set up many Windows servers in the cloud using infrastructure as a service (IaaS). They assume that the cloud provider manages any updates, because on-site IT usually handles update installation. Because Azure doesn't deploy and install the operating system updates, the HR department configures the updates separately. As a result, the servers are noncompliant and a security risk.

### Preferred outcome: Readiness plan that outlines responsibilities

Understand [shared responsibility](/azure/security/fundamentals/shared-responsibility) in the cloud. Build and create a [readiness plan](../plan/adapt-roles-skills-processes.md). A readiness plan can create ongoing momentum to learn and develop expertise.

## Antipattern: Out-of-the-box security as a given

Companies often perceive security as a given in the cloud. Although the initial assumption of given security is correct, a compliance framework needs to adhere to different environments. Azure provides basic security. The [Azure portal](https://portal.azure.com) provides help to improve security using the [Azure Security Center](/azure/security-center/), but enforcing a compliance and security standard isn't an out-of-the-box experience when you create a subscription.

### Example: Out-of-the-box security antipattern

A company develops a new application in the cloud. It chooses an architecture based on many platform as a service (PaaS) services, plus some IaaS components for debugging purposes. After releasing the application to production, the company slowly realizes that one of its jump servers has been compromised and was extracting data to an unknown IP. The company discovers the problem is the jump server's public IP and a password that's easy to guess. The company could have avoided this situation if it had more focus on cloud security.

### Preferred outcome: Cloud security strategy

Define a proper cloud [security strategy](../strategy/define-security-strategy.md). The chief information security office (CISO) can get a better understanding by exploring the [CISO cloud readiness guide](../govern/policy-compliance/cloud-security-readiness.md). The guide discusses such topics as security platform resources, privacy and controls, compliance, and transparency.

Read about secure cloud workloads in the [Azure security benchmark](/azure/security/benchmarks/introduction). Build upon the [Center for Internet Security (CIS) Controls Version 7.1](https://learn.cisecurity.org/cis-controls-download) and [National Institute of Standards and Technology (NIST) SP800-53 Framework](https://www.nist.gov/privacy-framework/nist-sp-800-53), which are able to address most security risks and measures.

Use the Azure Security Guide to identify risks, adapt best practices, and improve the company’s security posture.

Implement or support company-specific, automated compliance and security requirements using [Azure Policy](/azure/governance/policy/overview) and [Azure Blueprints](/azure/governance/blueprints/overview).

## Antipattern: Your own compliance or governance framework

Introducing a custom compliance and governance framework that isn't based on industry standards can substantially increase the adoption time, because the custom framework can be difficult to translate to cloud settings. Because of this scenario, a company expends increased effort to translate custom measures and requirements into implementable security controls. Most companies have similar security and compliance requirements that it needs to comply with, which often leads to a custom compliance and security framework that differs just slightly to existing compliance frameworks. If more security requirements exist, reconsider building up a whole framework.

### Example: Custom framework antipattern

The CISO of a company assigns its IT security employees to come up with a cloud security strategy and framework. Instead of building upon an already existing standard, the IT security department creates a new framework that builds on the existing on-premises security policy. After completing the cloud security policy, AppOps/DevOps teams have difficulties implementing the cloud security policy.

The controls in Azure differ and offer more comprehensive security and compliance structure, so the CISO team thinks that it can't comply with its existing compliance and security rules, even though this is dependent only on how it introduced security controls.

### Preferred outcome: Reliance on existing frameworks

Use or build on existing frameworks, such as CIS Controls Version 7.1 or NIST SP800-53, before you establish or introduce a custom company compliance framework. Existing frameworks make the transition to cloud security settings easier and more measurable. Find more framework implementations on the [Azure Blueprints samples page](/azure/governance/blueprints/samples). Blueprints for common compliance frameworks are also available for Azure.

## Next steps

- [Adapt existing roles, skills, and processes for the cloud](../plan/adapt-roles-skills-processes.md)
- [Define a security strategy](../strategy/define-security-strategy.md)