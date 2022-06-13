---
title: Platform automation and DevOps design area
description: Design area guidance for platform automation and DevOps
author: alguadam
ms.author: alguadam
ms.date: 01/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Platform automation and DevOps

Platform automation and DevOps evaluate opportunities to modernize your approach to environmental deployment with infrastructure as code options.

## Design area review

**Involved roles or functions:** Platform automation and DevOps might require support from one of the following functions or roles to make decisions: [cloud platform](../../../organize/cloud-platform.md), and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The goal of Platform automation and DevOps is to align your desired DevOps principles and practices to Azure Landing Zone lifecycle management, including provisioning, management, evolution, and operations through extreme automation and Infrastructure as Code.

## Design area overview

The scale, agility, and flexibility part of cloud technologies leads to opportunities for new ways of working and modern approaches to service delivery.

Many traditional IT operating models aren't compatible with the cloud and must undergo operational transformation to deliver against enterprise migration targets. You can evaluate using DevOps processes and tools for application and central teams.

## Platform automation

The ability to make changes at scale through a prescribed automated process provides direct benefits to the organization's ability to expand beyond the baseline configuration, which comes from security, governance, and management.

Platform automation is directly applicable to the outcomes associated with implementing an Azure landing zone, and supports the concept of building repeatable, scalable environments.

- [Automation considerations](../../considerations/automation-considerations.md) focuses on tools and techniques that enable the streamlining of automation tasks for Landing Zone development, deployment, provisioning and operations using automation tools such as Azure DevOps Services, or GitHub.

## DevOps

- [DevOps considerations](../../considerations/devops-principles-and-practices.md) explores the need of having a clear and common understanding of DevOps in the organization and all DevOps principles, practices, and capabilities that can be applied both to workloads and to Azure Landing Zones
- [DevOps teams topologies](../../considerations/devops-teams-topologies.md) describes how teams can be organized in the organization to own the end-to-end lifecycle of the Azure Landing Zone and how these teams collaborate with other teams in the organizations responsible for the end-to-end lifecycle of workloads deployed to Azure.

## Development Strategy

- [Development lifecycle](../../considerations/development-strategy-development-lifecycle.md) explores key design considerations and recommendations surrounding the repository, branch, automated builds, deployment, and rollback strategy during the creation of the landing zone via automation.
- [Infrastructure as Code](../../considerations/infrastructure-as-code.md) explains the benefits of addressing Azure Landing Zones via Infrastructure as Code and what considerations need to be taken around code structure, tools and technology.
- [Environments](../../considerations/environments.md) explains the purpose of a multi-environments to build, test, and release code with greater speed and frequency so that deployment is as straightforward as possible.
- [Test-driven development](../../considerations/development-strategy-test-driven-development.md) addresses how to use Unit Testing to improve the quality of new features and improvements in the Azure Landing Zone code-base.

## Security considerations

- [Security considerations](../../considerations/security-considerations-overview.md) addresses security and governance considerations that must be taken to account in the DevOps lifecycle of Azure Landing Zones.
- [Role-based Access Control for DevOps Tools](../../considerations/security-considerations-tools.md) explains the access control considerations to be considered when addressing Azure Landing Zones lifecycle through DevOps tools.
