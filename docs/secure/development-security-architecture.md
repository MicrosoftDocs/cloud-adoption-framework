---
title: Development security architecture
description: Learn development security architecture best practices.
author: MarkSimos
ms.author: mas
ms.date: 06/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Development security architecture

This article provides development security architecture best practices to help you achieve the ideal end state and key components of development security.

Your development security architecture needs to integrate:

- security best practices
- innovations in DevOps culture, tools, processes, and technology
- Infrastructure as Code (IaC), to ensure deployment consistency

Align security best practices and technologies with the processes and workflows that operationalize DevOps architecture. Maximize the automation of your security analysis tools, threat modeling processes, security posture management, and other security techniques, and their integration with CI/CD processes. Establish clear roles and responsibilities for security elements.

## IaC deployment consistency

Using Infrastructure as Code (IaC) to automate many tasks and ensure they're consistently and correctly executed enables you to meet your organization's efficiency and security goals. 

IaC enables repeatable infrastructure deployments and environmental design configurations to consistently manage, govern, or support multiple workloads. 

Security should work with IaC developers to ensure security is integrated into the automation and that the IaC architecture and development processes follow security best practices.

Azure landing zones with pre-existing code make it easier on your organization's IT and security teams. 

They offer a repeatable, predictable method to apply a templatized landing zone implementation with design-area considerations for security, management, governance, and platform automation/DevOps. 

We recommend including security tools as part of your broader Azure landing zone architecture implementation that includes:

- Target architectural end-state for most organizations
- Scaled-out, mature environment
- Broad range of Microsoft best practices for Azure environment design
- Strong foundations for organizations to establish continuously improving management, governance, and security processes

## Integrated process for security development

Securing code in the cloud needs to be integrated with existing processes to successfully operationalize and sustain it over time. This diagram shows a sample process for how you can integrate and secure development and operations practices into your innovation process.

![High security DevSecOps process.](./media/integrated-process-security-development.png)

This example process is suitable for business-critical functions that require the highest level of security rigor (for example, APIs and applications that process financial transactions or business critical information). We recommend you consider developing simpler streamlined version(s) of this process for different use cases as depicted in this diagram:

![Find the right balance.](./media/security-processes-business-agility-balance.png)

Your organization should identify the steps involved in your development workflows, people, and technologies involved, to progress from idea to production and ongoing operations. It's critical practice to also identify the process of resolving major and minor changes and bug fixes during the development lifecycle.

## Next steps

- [Development security implementation and operations](development-security-implementation-operations.md)
