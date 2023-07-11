---
title: The Azure Well-Architected Framework for {{Token-Name}}
description: #Use the Azure Well-Architected Framework architecture principles to design and optimize workloads running in your scenario.
author: {{Token-ContributorGithubId}}
ms.author: {{Token-Alias}}
ms.date: {{Token-Date}}
ms.topic: conceptual
s.custom: think-tank
---

# The Azure Well-Architected Framework for {{Token-Name}}

The [Plan methodology of this scenario](./plan.md) outlines a process for you to rationalize your scenario, prioritize technical efforts, and identify workloads. For many of the named workloads, it's important to adhere to a set of architectural principles. These principles help guide development and optimization of the workloads. The five architectural constructs are detailed in the [Azure Well-Architected Framework](/azure/architecture/framework/). This guidance provides a summary of how you can apply these principles to the management of your data workloads.

## Reliability

Describe the ability of a system to recover from failures and continue to function.

Everything has the potential to break and data pipelines are no exception. Because of this, great architectures are designed with availability and resiliency in mind. The key considerations are how quickly you can detect change, and how quickly you can resume operations.

Your data environment should consider resilient architectures, cross region redundancies, service level, service-level agreements (SLAs), and critical support. The existing environment should also include auditing, monitoring, and alerting by using integrated monitoring and a notification framework.

On top of these environmental controls, the workload team should consider:

- More architecture modification to improve service level SLAs
- Redundancy of workload-specific architecture
- Processes for monitoring and notification beyond what is provided by the cloud operations teams

## Security

Describe how you will protect applications and data from threats.

## Cost optimization

Describe how you will manage costs to maximize the value delivered.

## Operational excellence

Outline the operations processes that keep a system running in production.

## Performance Efficiency

Describe how you will design a system to adapt to changes in load.

## Next steps

[Introduction to architectures for {{Token-Name}}](./index.md)
