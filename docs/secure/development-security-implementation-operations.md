---
title: Development security implementation and operations
description: This is the Development security implementation and operations best practices section that describes best practices related to these aspects of development security.
author: mpvenables
ms.author: mas
ms.date: 03/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Development security implementation and operations

This is the Development security implementation and operations best practices section that describes best practices related to these aspects of development security. 

We recommend following development [security best practices architecture](security-best-practices-introduction.md) in the previous section. Use secure landing zone deployments with repeatable governance and security tools and controls to help your organization quickly achieve a security baseline. The Security Baseline discipline of governance in the Cloud Adoption Framework doesn't replace existing IT teams, processes, and procedures that your organization uses to secure cloud-deployed resources.

The governance discipline is key to implementation and ongoing operations as it identifies security-related business risks and provides risk-mitigation guidance to staff responsible for both infrastructure and development. As you develop governance policies and processes, make sure to involve relevant IT a development teams in your planning and review processes.

Operationalize these processes, policies, and toolsets with the use of repository tooling such as GitHub workflow management and contributions to code via PRs. We recommend following security best practices when across all [Azure DevOps tooling](/azure/devops/), [GitHub Actions](https://github.com/marketplace?type=actions), etc.

Below is a diagram of DevSecOps architecture with Shift-left strategy—integrating security into developer workflows from the beginning—and across the development lifecycle. Its complex dataflow starts with Azure Active Directory (AD) configured as GitHub identity provider (with multi-factor authentication (MFA) enabled for extra security).

![DevSecOps architecture with Shift-left strategy—integrating security into developer workflows](./media/devsecops-integrated-shift-left-security-development-workflow.png)

The final part of the DevSecOps flow ends with Microsoft Defender for Cloud's (MDFC) active threat monitoring on the Azure Kubernetes Service, across node-level (VM) and internal threats.

For more detailed technical guidance on assessing and deploying well-architected workloads, see further guidance that focuses on improving quality at the workload level with the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/).

- Implement the processes, policies, and tools in the previous sections to continue operationalizing your security engineering approach—integrated across security development lifecycles (SDL) and operations (OSA) processes.
- Align your organization's developers in the use of consistent tooling, focusing on the security pillar of the [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment)—applying security principles to your architecture to protect against attacks on your data and systems.

## DevSecOps controls

Read more about how to [integrate security processes and tools](/azure/cloud-adoption-framework/secure/devsecops-controls) into the DevOps development process. Watch this video for further guidance on how to implement secure and rapid innovation for your organization:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWVu6q]

Read more about core DevOps security controls in the Azure Security Benchmark on [DevOps Security (Security Control v3)](/security/benchmark/azure/security-controls-v3-devops-security).
