---
title: Development security architecture
description: This is the Development security architecture best practices section that describes best practices related to the ideal end state and key components of development security.
author: MarkSimos
ms.author: mas
ms.date: 03/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Development security architecture

This is the Development security architecture best practices section that describes best practices related to the ideal end state and key components of development security. Advance to [Development security implementation and operations] section.(add file.md#section-name).

Your security architecture for development must integrate both security best practices as well as innovations in DevOps culture, tools, processes, and technology. It must also embrace and integrate with Infrastructure as Code (IaC) to create consistent, repeatable infrastructure deployments. Operationalizing these elements in DevOps requires aligning security best practices and technologies into the processes and workflows that operationalize DevOps architecture. To be effective in this fast-paced approach, maximize automation and integration of security analysis tools, threat modelling processes, security posture management, and other security techniques into CI/CD processes. Ensure you establish clarity for roles and responsibilities for security elements in the process.

## IaC deployment consistency

Using Infrastructure as Code (IaC) enables both efficiency and security goals, by automating many tasks to ensure they are executed consistently and correctly. IaC enables repeatable infrastructure deployments and environmental design configurations to consistently manage, govern, or support multiple workloads. Security should work with IaC developers to ensure security is integrated into the automation and that the IaC architecture and development processes follow security best practices. 

Azure landing zones with pre-existing code make it easier on your organization's IT and security teams. They offer a repeatable, predictable method to apply a templatized landing zone implementation with design-area considerations for security, management, governance, and platform automation/DevOps. 

We recommend including security tools as part of your broader Azure landing zone architecture implementation that includes:

- Target architectural end-state for most organizations
- Scaled-out, mature environment
- Broad range of Microsoft best practices for Azure environment design
- Strong foundations for organizations to establish continuously improving 
management, governance, and security processes

## Integrated process for security development

Securing code in the cloud needs to be integrated with existing processes to successfully operationalize and sustain it over time. This diagram shows a sample process for how you can integrate and secure development and operations practices into your innovation process.

![High Security DevSecOps Process](./media/integrated-process-security-development.png)

This example process is suitable for business-critical functions that require the highest level of security rigor (e.g. APIs and applications that process financial transactions or business critical information). We recommend you consider developing simpler streamlined version(s) of this process for different use cases as depicted in this diagram

![Find the Right Balance](./media/security-processes-business-agility-balance.png)

Your organization should identify the steps involved in your development workflows, people, and technologies involved, to progress from idea to production and ongoing operations. It is critical practice to also identify the process of resolving major and minor changes and bug fixes during the development lifecycle.

## Next steps:

- [Development security implementation and operations](development-security-implementation-operations.md)
