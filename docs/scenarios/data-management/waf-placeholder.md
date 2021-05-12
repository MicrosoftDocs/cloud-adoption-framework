---
title: Enterprise Scale Analytics and AI Define Strategy
description: Enterprise Scale Analytics and AI Define Strategy
author: pratimdas
ms.author: prda # Microsoft employees only
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Well-architected framework for data workloads

When building data workloads, it's important to focus on the architectural principals. Think about whether you want to continue to manage and maintain your current service or products, or undertake new ones. The five architectural constructs are detailed in the [Azure Well Architected Framework](https://docs.microsoft.com/azure/architecture/framework/) and summarized below.  

### Security

This is about the [confidentiality and integrity of data, including privilege management, data privacy and establishing appropriate controls](https://azure.microsoft.com/resources/seven-key-principles-of-cloud-security-and-privacy/). For all data products and services, [consider network isolation](https://docs.microsoft.com/azure/security/fundamentals/network-best-practices), [end-to-end encryption](https://docs.microsoft.com/azure/security/fundamentals/encryption-overview), auditing and polices at platform level. For identity, consider single sign on integration, multi-factor authentication backed conditional access and managed service identities. It is essential to focus on separation of concerns, such as control pane versus data place, [role-based access control (RBAC)](https://docs.microsoft.com/azure/role-based-access-control/overview), and where possible, attribute-based access control (ABAC). Security and [data management](https://docs.microsoft.com/azure/architecture/patterns/category/data-management) must be baked into the architectural process at layers for every application and workload. In general, set up processes around regular or continuous vulnerability assessment, threat protection and compliance monitoring.

### Reliability

Everything has the potential to break and data pipelines are no exception. Hence, great architectures are designed with availability and resiliency in mind. The key considerations are how quickly you can detect change, and how quickly you can resume operations. When building your data platform, consider resilient architectures, cross region redundancies, service level SLAs and critical support. Set up auditing, monitoring, and alerting by using integrated monitoring, and a notification framework.

### Performance efficiency

User delight comes from the architectural constructs of performance and scalability. Performance can vary based on external factors. It is key to continuously gather performance telemetry and react as quickly as possible, i.e. using the architectural constructs for management and monitoring. The key considerations here are storage and compute abstraction, dynamic scaling, partitioning, storage pruning, enhanced drivers, and multi-layer cache. Take advantage of hardware acceleration such as FPGA network where possible.

### Cost optimization

Every bit of your platform investment must yield value. It is critical to architect with the right tool for the right solution in mind. This will help you analyse spend over time and the ability to scale out versus scale in when needed. For your data and analytics platform, consider reusability, on-demand scaling, reduced data duplication and certainly take advantage of the Azure advisor service.  

### Operational excellence

This is about making the operational management of your data products and service as seamless as possible through automation and your ability to quickly respond to events. Focus on data ops though process automation, automated testing, and consistency. For AI, considering building in a MLOps framework as part of your normal release cycle.