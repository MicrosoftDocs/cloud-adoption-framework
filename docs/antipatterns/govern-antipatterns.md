---
title: Govern antipatterns
description: When adopting the cloud, understand company responsibilities, cloud provider responsibilities, and cloud governance and security standards.
author: sarahwendel
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: think-tank
---

# Govern antipatterns

Customers often experience antipatterns during the Govern phase of cloud adoption. Taking the time to understand shared responsibilities helps you avoid these antipatterns, as does building your security strategy on existing frameworks instead of creating your own.

## Antipattern: Misunderstand shared responsibilities

When you adopt the cloud, it's not always clear where your responsibility ends and the cloud provider's responsibility starts regarding the different service models. Cloud skills and knowledge are required to build processes and practices around work items that use service models.

### Example: Assume the cloud provider manages updates

Members of a company's human resources (HR) department set up many Windows servers in the cloud using infrastructure as a service (IaaS). They assume that the cloud provider manages updates, because on-site IT usually handles update installation. The HR department doesn't configure the updates because they're not aware that Azure doesn't deploy and install operating system updates by default. As a result, the servers are noncompliant and pose a security risk.

### Preferred outcome: Create a readiness plan

Understand [shared responsibility](/azure/security/fundamentals/shared-responsibility) in the cloud. Build and create a [readiness plan](../plan/adapt-roles-skills-processes.md). A readiness plan can create ongoing momentum for learning and developing expertise.

## Antipattern: Assume out-of-the-box solutions provide security

Companies often perceive security as a given in the cloud. Although this assumption is usually correct, most environments also need to adhere to compliance framework requirements, which can differ from security requirements. Azure provides basic security. And, through the [Azure Security Center](/azure/security-center/), the [Azure portal](https://portal.azure.com) provides help with improving security. But, enforcing a compliance and security standard isn't an out-of-the-box experience when you create a subscription.

### Example: Neglect cloud security

A company develops a new application in the cloud. It chooses an architecture based on many platform as a service (PaaS) services, plus some IaaS components for debugging purposes. After releasing the application to production, the company realizes that one of its jump servers has been compromised and was extracting data to an unknown IP address. The company discovers that the problem is the jump server's public IP address and a password that's easy to guess. The company could have avoided this situation if it had focused more on cloud security.

### Preferred outcome: Define a cloud security strategy

Define a proper [cloud security strategy](../strategy/define-security-strategy.md). See [CISO cloud readiness guide](../govern/policy-compliance/cloud-security-readiness.md) for more information, and refer your chief information security office (CISO) to this guide. It discusses topics such as security platform resources, privacy and controls, compliance, and transparency.

Read about secure cloud workloads in the [Azure Security Benchmark](/security/benchmark/azure/introduction). Build upon the [CIS Controls v7.1](https://learn.cisecurity.org/cis-controls-download) from the Center for Internet Security, along with [NIST SP800-53](https://www.nist.gov/privacy-framework/nist-sp-800-53) from the National Institute of Standards and Technology, which address most security risks and measures.

Use the Azure Security Center to identify risks, adapt best practices, and improve your company's security posture.

Implement or support company-specific, automated compliance and security requirements by using [Azure Policy](/azure/governance/policy/overview) and [Azure Blueprints](/azure/governance/blueprints/overview).

## Antipattern: Use a custom compliance or governance framework

Introducing a custom compliance and governance framework that isn't based on industry standards can substantially increase cloud adoption time, because it can be difficult to translate the custom framework to cloud settings. This scenario can increase the effort that's needed to translate custom measures and requirements into implementable security controls. Most companies need to comply with similar sets of security and compliance requirements. As a result, most custom compliance and security frameworks differ only slightly from current compliance frameworks. Companies with additional security requirements can consider building new frameworks.

### Example: Use a custom security framework

The CISO of a company assigns IT security employees the task of coming up with a cloud security strategy and framework. Instead of building upon industry standards, the IT security department creates a new framework that builds on the current on-premises security policy. After completing the cloud security policy, the AppOps and DevOps teams have difficulty implementing the cloud security policy.

Azure offers a more comprehensive security and compliance structure that differs from the company's own framework. The CISO team thinks that the Azure controls are incompatible with its own compliance and security rules. If it had based its framework on standardized controls, it wouldn't have come to that conclusion.

### Preferred outcome: Rely on existing frameworks

Use or build on existing frameworks, such as CIS Controls v7.1 or NIST SP800-53, before you establish or introduce a custom company compliance framework. Existing frameworks make the transition to cloud security settings easier and more measurable. Find more framework implementations on the [Azure Blueprints samples page](/azure/governance/blueprints/samples/). Blueprints for common compliance frameworks are also available for Azure.

## Next steps

- [Adapt existing roles, skills, and processes for the cloud](../plan/adapt-roles-skills-processes.md)
- [Define a security strategy](../strategy/define-security-strategy.md)
