---
title: Well-architected framework for data workloads
description: Leverage the architecture principals of the Azure Well Architected Framework to design and optimized workloads running in your data estate.
author: pratimdas
ms.author: prda # Microsoft employees only
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Well-architected framework for data workloads

The [Plan methodology of this scenario](./plan.md) outlines a process for rationalizing your data estate, prioritizing technical efforts, and identifying data workloads. For many of the named workloads, it will be important to adhere to a set of architectural principals to guide development and optimization of those workloads. The five architectural constructs are detailed in the [Azure Well Architected Framework](/azure/architecture/framework/). Below is a summary of how those principals can be applied to the management of data workloads.

## Cost optimization

It is critical to architect with the right tool for the right solution in mind. This will help you analyse spend over time and the ability to scale out versus scale in when needed. For your data workloads, consider reusability, on-demand scaling, reduced data duplication, and certainly take advantage of the Azure advisor service.  

## Performance efficiency

User delight comes from performance of your workloads. Performance can vary based on external factors. It is key to continuously gather performance telemetry and react as quickly as possible. Build on the shared environmental controls for for management and monitoring to create alerts, dashboards, and notifications specific to the performance of your workload. The key considerations here are storage and compute abstraction, dynamic scaling, partitioning, storage pruning, enhanced drivers, and multi-layer cache, etc.

## Operational excellence

Operational management of your data workloads can include advanced automation improving your ability to quickly respond to events. Build on top of centralized data ops though workload specific process automation, automated testing, and consistency. For AI, considering using the shared MLOps framework as part of your normal release cycle.

## Security

Security and [data management](/azure/architecture/patterns/category/data-management) must be baked into the architectural process at layers for every application and workload. The data management and analytics scenario focuses on establishing a foundation for security through configuration of your Azure landing zone(s), which are managed seperate from the workload. However, the workload team is still responsible for validating that the following minimum requirements. If neccessary, workload specific solutions may be required to augment the configuration of the environment.

- Ensure [confidentiality and integrity of data, including privilege management, data privacy and establishing appropriate controls](https://azure.microsoft.com/resources/seven-key-principles-of-cloud-security-and-privacy/). 
- Implement appropriate [network isolation](/azure/security/fundamentals/network-best-practices) and [end-to-end encryption](/azure/security/fundamentals/encryption-overview), auditing and polices at platform level. 
- Leverage single sign on integration, multi-factor authentication backed conditional access and managed service identities. 
- Adhere to separation of concerns, such as control pane versus data plane, through proper application of [role-based access control (RBAC)](/azure/role-based-access-control/overview), and where possible, attribute-based access control (ABAC). 
- Ensure the workload team is involved in regular or continuous vulnerability assessment, threat protection and compliance monitoring.

## Reliability

Everything has the potential to break and data pipelines are no exception. Hence, great architectures are designed with availability and resiliency in mind. The key considerations are how quickly you can detect change, and how quickly you can resume operations. 

Your data environment should consider resilient architectures, cross region redundancies, service level SLAs and critical support. The existing environment should also include auditing, monitoring, and alerting by using integrated monitoring, and a notification framework.

On top of these environmental controls, the workload team should also consider the following:

- Additional architecture modification to improve service level SLAs
- Redundancy of workload-specific architecture
- Processes for monitoring and notification beyond what is provided by the cloud operations teams
