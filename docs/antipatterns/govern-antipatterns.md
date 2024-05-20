---
title: Govern antipatterns
description: Understand company responsibilities, cloud provider responsibilities, and cloud governance and security standards for cloud adoption.
author: lpassig
ms.author: martinek
ms.date: 05/06/2024
ms.topic: conceptual
ms.subservice: caf-methodology-govern
ms.custom: think-tank,UpdateFrequency5
---

# Govern antipatterns

You might encounter antipatterns during the Govern phase of cloud adoption. Understand shared responsibilities and how to build your security strategy on existing frameworks to help you avoid these antipatterns.

## Antipattern: Misunderstand shared responsibilities

When you adopt the cloud, it's not always clear where your responsibility ends and the cloud provider's responsibility starts regarding the different service models. Cloud skills and knowledge are required to build processes and practices around work items that use service models.

### Example: Assume the cloud provider manages updates

Members of a company's human resources (HR) department use infrastructure as a service (IaaS) to set up multiple Windows servers in the cloud. They assume that the cloud provider manages updates because on-site IT usually handles update installation. The HR department doesn't configure the updates because they're not aware that Azure doesn't deploy and install operating system (OS) updates by default. As a result, the servers are noncompliant and pose a security risk.

### Preferred outcome: Create a readiness plan

Understand [shared responsibility](/azure/security/fundamentals/shared-responsibility) in the cloud. Build and create a [readiness plan](../plan/adapt-roles-skills-processes.md). A readiness plan can create ongoing momentum for learning and developing expertise.

## Antipattern: Assume out-of-the-box solutions provide security

Companies tend to see security as a feature inherent to cloud services. Although this assumption is often correct, most environments need to adhere to compliance framework requirements, which can differ from security requirements. Azure provides basic security, and the [Azure portal](https://portal.azure.com) can provide more advanced security through [Microsoft Defender for Cloud](/azure/security-center/). When you create a subscription, you must customize your solution to enforce a compliance and security standard.

### Example: Neglect cloud security

A company develops a new application in the cloud. It chooses an architecture based on many platform as a service (PaaS) services, plus some IaaS components for debugging purposes. After releasing the application to production, the company realizes that one of its jump servers has been compromised and was extracting data to an unknown IP address. The company discovers that the problem is the jump server's public IP address and a password that's easy to guess. The company could have avoided this situation if it had focused more on cloud security.

### Preferred outcome: Define a cloud security strategy

Define a proper [cloud security strategy](../strategy/define-security-strategy.md). For more information, see the [CISO cloud readiness guide](../govern/policy-compliance/cloud-security-readiness.md). Refer your chief information security officer (CISO) to this guide. The CISO cloud readiness guide discusses topics such as security platform resources, privacy and controls, compliance, and transparency.

Read about secure cloud workloads in the [Azure Security Benchmark](/security/benchmark/azure/introduction). Build upon the [CIS Controls v7.1](https://learn.cisecurity.org/cis-controls-download) from the Center for Internet Security, along with [NIST SP800-53](https://www.nist.gov/privacy-framework/nist-sp-800-53) from the National Institute of Standards and Technology, which address most security risks and measures.

Use Microsoft Defender for Cloud to identify risks, adapt best practices, and improve your company's security posture.

Implement or support company-specific automated compliance and security requirements by using [Azure Policy](/azure/governance/policy/overview) and the [Azure Policy as Code solution](/azure/governance/policy/concepts/policy-as-code).

## Antipattern: Use a custom compliance or governance framework

Introducing a custom compliance and governance framework that isn't based on industry standards can substantially increase cloud adoption time. This is because translation from the custom framework to cloud settings can be complex. This complexity can increase the effort that's required to translate custom measures and requirements into implementable security controls. Companies usually need to comply with similar sets of security and compliance requirements. As a result, most custom compliance and security frameworks differ only slightly from current compliance frameworks. Companies with extra security requirements can consider building new frameworks.

### Example: Use a custom security framework

The CISO of a company assigns IT security employees the task of coming up with a cloud security strategy and framework. Instead of building upon industry standards, the IT security department creates a new framework that builds on the current on-premises security policy. After completing the cloud security policy, the AppOps and DevOps teams have difficulty implementing the cloud security policy.

Azure offers a more comprehensive security and compliance structure that differs from the company's own framework. The CISO team thinks that the Azure controls are incompatible with its own compliance and security rules. If it had based its framework on standardized controls, it wouldn't have come to that conclusion.

### Preferred outcome: Rely on existing frameworks

Use or build on existing frameworks, such as CIS Controls version 7.1 or NIST SP 800-53, before you establish or introduce a custom company compliance framework. Existing frameworks make the transition to cloud security settings easier and more measurable. For more information about framework implementations, see [Azure landing zones implementation options](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options).

## Next steps

- [Adapt existing roles, skills, and processes for the cloud](../plan/adapt-roles-skills-processes.md)
- [Define a security strategy](../strategy/define-security-strategy.md)
