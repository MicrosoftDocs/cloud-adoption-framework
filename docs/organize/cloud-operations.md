---
title: Understand cloud operation functions
description: Understand the formation of cloud operations functionality and staff your team appropriately.
author: JanetCThomas
ms.author: janet
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: internal
---

# Cloud operations functions

An operations team focuses on monitoring, repairing, and the remediation of issues related to traditional IT operations and assets. In the cloud, many of the capital costs and operations activities are transferred to the cloud provider, giving IT operations the opportunity to improve and provide significant additional value.

The skills needed to provide cloud operations functions can be provided by:

- IT operations
- Outsource IT operations vendors
- Cloud service providers
- Cloud-managed service providers
- Application-specific operations teams
- Business application operations teams
- DevOps teams

> [!IMPORTANT]
> The individuals or teams accountable for cloud operations are generally responsible for making reactive changes to configuration during remediation. They're also likely to be responsible for proactive configuration changes to minimize operational disruptions. Depending on the organizations cloud operating model, those changes could be delivered via infrastructure-as-code, Azure Pipelines, or direct configuration in the portal. Since operations team will likely have elevated permissions, it is extremely important that those who fill this role are following [identity and access control best practices](/security/benchmark/azure/security-control-identity-access-control) to minimize unintended access or production changes.

## Preparation

- [Manage resources in Azure](/learn/paths/manage-resources-in-azure/): Learn how to work through the Azure CLI and web portal to create, manage, and control cloud-based resources.
- [Azure network services](/learn/modules/azure-networking-fundamentals/): Learn Azure networking basics and how to improve resiliency and reduce latency.

Review the following:

- [Business outcomes](../strategy/business-outcomes/index.md)
- [Financial models](../strategy/cloud-migration-business-case.md)
- [Motivations for cloud adoption](../strategy/motivations.md)
- [Business risks](../govern/policy-compliance/risk-tolerance.md)
- [Rationalization of the digital estate](../digital-estate/index.md)

## Minimum scope

The duties of the people on the cloud operations team involve delivering maximum workload performance and minimum business interruptions within an agreed-upon operations budget.

- Determine workload criticality, impact of disruptions, or performance degradation.
- Establish business-approved cost and performance commitments.
- Monitor and operate cloud workloads.

## Deliverables

- Maintain asset and workload inventory
- Monitor performance of workloads
- Maintain operational compliance
- Protect workloads and associated assets
- Recover assets if there is performance degradation or business interruption
- Mature functionality of core platforms
- Continuously improve workload performance
- Improve budgetary and design requirements of workloads to fit commitments to the business

### Meeting cadence

The cloud operations team should be involved in release planning and cloud center of excellence planning to provide feedback and prepare for operational requirements.

## Out of scope

Traditional IT operations that focus on maintaining current-state operations for low-level technical assets is out of scope for the cloud operations team. Things like storage, CPU, memory, network equipment, servers, and virtual machine hosts require continuous maintenance, monitoring, repair, and remediation of issues to maintain peak operations. In the cloud, many of these capital costs and operations activities are transferred to the cloud provider.

## Next steps

As adoption and operations scale, it's important to define and automate governance best practices that extend existing IT requirements. Forming a cloud center of excellence is an important step to scaling cloud adoption, cloud operations, and cloud governance efforts.

Learn more about:

- [Cloud center of excellence](./cloud-center-of-excellence.md) functions.
- [Organizational antipatterns: silos and fiefdoms](./fiefdoms-silos.md).

Learn to align responsibilities across teams by developing a cross-team matrix that identifies responsible, accountable, consulted, and informed (RACI) parties. Download and modify the [RACI template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/organize/raci-template.xlsx).