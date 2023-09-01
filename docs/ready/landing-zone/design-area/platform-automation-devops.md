---
title: Platform automation and DevOps design area
description: Learn how platform automation and DevOps evaluate opportunities to modernize your approach to environmental deployment with infrastructure as code options.
author: alguadam
ms.author: alguadam
ms.date: 06/24/2022
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Platform automation and DevOps

Platform automation and DevOps evaluate opportunities to modernize your approach to environmental deployment with infrastructure as code options.

## Design area review

**Involved roles or functions:** Platform automation and DevOps might require support from one of the following functions or roles to make decisions: [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md).

**Scope:** The goal of platform automation and DevOps is to align your desired DevOps principles and practices to Azure Landing Zone lifecycle management. This goal includes provisioning, management, evolution, and operations through extreme automation and Infrastructure as Code.

## Design area overview

The scale, agility, and flexibility part of cloud technologies leads to opportunities for new ways of working and modern approaches to service delivery.

Many traditional IT operating models aren't compatible with the cloud and must undergo operational transformation to deliver against enterprise migration targets. You can evaluate using DevOps processes and tools for application and central teams.

## Platform automation

The ability to make changes at scale through a prescribed automated process provides direct benefits to the organization's ability to expand beyond the baseline configuration, which comes from security, governance, and management.

Platform automation is directly applicable to the outcomes associated with implementing a landing zone, and supports the concept of building repeatable, scalable environments.

- [Automation](../../considerations/automation.md) focuses on tools and techniques that enable the streamlining of automation tasks for Azure Landing Zone development, deployment, provisioning, and operations using automation tools such as Azure DevOps Services or GitHub.

### DevOps

These resources address platform automation for DevOps.

- [DevOps considerations](../../considerations/devops-principles-and-practices.md) explores the need to have a clear and common understanding of DevOps in the organization. This resource also describes DevOps principles, practices, and capabilities that apply to workloads and to landing zones.
- [DevOps teams topologies](../../considerations/devops-teams-topologies.md) describes how teams can be organized to own the end-to-end lifecycle of the Azure Landing Zone. Learn how these teams collaborate with other teams in the organization responsible for the end-to-end lifecycle of workloads deployed to Azure.

### Development strategy

These resources address development strategy.

- [Development lifecycle](../../considerations/development-strategy-development-lifecycle.md) explores key design considerations and recommendations for the creation of a landing zone by using automation. This resource discusses the repository, branch, automated builds, deployment, and rollback strategy.
- [Infrastructure as Code](../../considerations/infrastructure-as-code.md) explains the benefits of implementing Azure Landing Zones by using Infrastructure as Code. Learn about considerations around code structure, tools, and technology.
- [Environments](../../considerations/environments.md) explains the purpose of multienvironments to build, test, and release code with greater speed and frequency. This approach makes deployment as straightforward as possible.
- [Test-driven development](../../considerations/development-strategy-test-driven-development.md) addresses how to use unit testing to improve the quality of new features and improvements in the Azure Landing Zone code-base.

### Security considerations

These resources address security considerations in platform automation.

- [Security considerations](../../considerations/security-considerations-overview.md) addresses security and governance considerations for the DevOps lifecycle of Azure Landing Zones.
- [Role-based Access Control for DevOps Tools](../../considerations/security-considerations-tools.md) explains the access control considerations to be considered when addressing Azure Landing Zones lifecycle through DevOps tools.

## Next steps

> [!div class="nextstepaction"]
> [Automation](../../considerations/automation.md)
