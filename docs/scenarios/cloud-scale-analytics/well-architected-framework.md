---
title: Azure Well-Architected Framework for data workloads
description: Use Azure Well-Architected Framework architecture principles to design and optimize workloads running in your data estate.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Azure Well-Architected Framework for data workloads

The [Plan methodology of this scenario](./plan.md) outlines a process for you to rationalize your data estate, prioritize technical efforts, and identify data workloads. For many of the named workloads, it's important to adhere to a set of architectural principles. These principles help guide development and optimization of the workloads. The five architectural constructs are detailed in the [Azure Well-Architected Framework](/azure/architecture/framework/). This guidance provides a summary of how you can apply these principles to the management of your data workloads.

## Cost optimization

It's critical to architect with the right tool for the right solution in mind. This principal can help you analyze spend over time. It can also help you analyze your ability to scale out versus scale in when needed. For your data workloads, consider reusability, on-demand scaling, reduced data duplication, and take advantage of the Azure Advisor service.

For more information, see [Design review checklist for Cost Optimization](/azure/well-architected/cost-optimization/checklist).

## Performance efficiency

User delight comes from performance of your workloads. Performance can vary based on external factors. It's key to continuously gather performance telemetry and react as quickly as possible. Build on the shared environmental controls for management and monitoring to create alerts, dashboards, and notifications specific to the performance of your workload. The key considerations are:

- Storage and compute abstraction
- Dynamic scaling
- Partitioning
- Storage pruning
- Enhanced drivers
- Multilayer cache

For more information, see [Design review checklist for Performance Efficiency](/azure/well-architected/performance-efficiency/checklist/).

## Operational excellence

Operational management of your data workloads can include advanced automation that improves your ability to quickly respond to events. Build on top of centralized data operations through workload-specific process automation, automated testing, and consistency. For AI, consider using the shared MLOps framework as part of your normal release cycle.

For more information, see [Design review checklist for Operational Excellence](/azure/well-architected/operational-excellence/checklist).

## Security

Security and [data management](/azure/architecture/patterns/category/data-management) must be built into the architectural process at layers for every application and workload. Cloud-scale analytics focuses on establishing a foundation for security. This foundation is built when you configure your Azure landing zones and you manage them separate from the workload. However, the workload team is still responsible for validating the following minimum requirements. If necessary, workload-specific solutions might be required to augment the configuration of the environment.

- Ensure confidentiality and integrity of data, including privilege management, data privacy, and establishing appropriate controls.
- Implement appropriate [network isolation](/azure/well-architected/security/networking) and [end-to-end encryption](/azure/well-architected/security/encryption), auditing, and policies at the platform level.
- Use single sign-on (SSO) integration, multifactor authentication backed conditional access, and managed service identities.
- Adhere to separation of concerns, such as control pane versus data plane, through proper application of [role-based access control (RBAC)](/azure/role-based-access-control/overview), and where possible, attribute-based access control (ABAC).
- Ensure the workload team is involved in regular or continuous vulnerability assessment, threat protection, and compliance monitoring.
- Secure data 

For more information, see [Design review checklist for Security](/azure/well-architected/security/checklist).

## Reliability

Everything has the potential to break and data pipelines are no exception. Because of this, great architectures are designed with availability and resiliency in mind. The key considerations are how quickly you can detect change, and how quickly you can resume operations.

Your data environment should consider resilient architectures, cross region redundancies, service level, service-level agreements (SLAs), and critical support. The existing environment should also include auditing, monitoring, and alerting by using integrated monitoring and a notification framework.

On top of these environmental controls, the workload team should consider:

- More architecture modification to improve service level SLAs
- Redundancy of workload-specific architecture
- Processes for monitoring and notification beyond what is provided by the cloud operations teams

For more information, see [Design review checklist for Reliability](/azure/well-architected/reliability/checklist).

## Next steps

> [!div class="nextstepaction"]
> [Introduction to architectures for cloud-scale analytics](../cloud-scale-analytics/architectures/overview-architectures.md)
