---
title: Cloud readiness antipatterns
description: Avoid cloud adoption readiness antipatterns like using preview services, assuming built-in resiliency and availability, and assuming IT is ready for the cloud.
author: lpassig
ms.author: brblanch
ms.date: 02/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Cloud readiness antipatterns

Customers often experience antipatterns during the readiness phase of cloud adoption. These antipatterns can lead to unexpected downtime, disaster recovery problems, and availability issues.

## Antipattern: Assume released services are ready for production

Because cloud computing is evolving rapidly, companies often release preview versions of new services. Customers tend to assume that they can use any available cloud service in a production environment. But, problems can result, for these reasons:

- Preview services usually don't provide uptime service-level agreements (SLAs).
- New services often aren't as mature as cloud services that are already available.

### Example: Use a preview service in production

A research institute uses a preview cloud service in production. The service seems to be a good fit for its use case. But, the institute doesn't perform due diligence on the service. The institute also doesn't follow its reference architecture's requirements and guidelines.

Problems come up with the preview service that lead to unexpected downtime. The institute begins to think that cloud services in general aren't as mature or resilient as promised.

### Preferred outcome: Use pre-approved cloud services in production

When evaluating new services that are in preview, only use these services in proof of concept (POC) scenarios. Don't use these services in production environments, because they don't have SLAs. Find the right balance between functionality and maturity when approving cloud services. See [Cloud services due diligence checklist](https://www.microsoft.com/trust-center/compliance/due-diligence-checklist) for an established framework that you can use to quickly evaluate cloud services.

## Antipattern: Assume increased resiliency and availability

Cloud computing often offers advantages over on-premises computing. Examples include:

- **Increased resiliency:** Recovering after failure.
- **Availability:** Running in a healthy state without significant downtime.

Because most cloud services offer these advantages, many companies assume that all cloud services offer resiliency and high availability by default. In reality, these features are often only available at extra cost and with additional technical effort.

### Example: Assume high availability

A start-up implements a mission-critical application on infrastructure as a service (IaaS) services. Developers at the start-up have looked into a virtual machine (VM) with an uptime SLA of 99.9%. Since they'd like to cut costs, they use a single VM and premium storage.

When the VM fails, their application can't recover. Unexpected downtime results. They'd assumed that the cloud offers high availability by default. They weren't aware that performance guarantees can differ between:

- Service models like platform as a service (PaaS) and software as a service (SaaS).
- Technical architectures like load-balanced availability sets and Availability Zones.

### Preferred outcome: Reduce failures while balancing resiliency and costs

See trusted, mature resources for information on architectural best practices that can reduce the scope of failures:

- [Reference architectures](/azure/architecture/browse/)
- [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/)

Identify the right balance between costs and features like [high resiliency and availability](/azure/architecture/framework/resiliency/design-resiliency). Increased resiliency and availability typically lead to increased costs. For instance:

- A single VM might have an SLA with a guaranteed uptime of 99.9%.
- Two VMs running the same workload would provide an SLA with an uptime between 99.95 and 99.99 percent.

Engage in the essential process of *requirements engineering* when designing a cloud-based solution. Use an [SLA estimator](https://github.com/mspnp/samples/tree/master/Reliability/SLAEstimator) to help calculate your application's end-to-end SLA.

## Antipattern: Become a cloud provider

Some companies try to make their internal IT department a cloud provider. IT then becomes responsible for reference architectures. IT also needs to provide IaaS and PaaS to business units. Since this type of work isn't usually part of IT's core business, the resulting service offerings can lack usability, resiliency, efficiency, and security.

### Example: Provide monolithic managed cloud services

A corporation's IT department establishes a cloud center of excellence (CCoE) that serves as a broker between IT and business units. To ensure the corporation is cloud-compliant, the managing board assigns the CCoE the task of providing monolithic end-to-end services. The CCoE sets up an internal cloud procurement portal that business units can use to order a fully managed cloud VM as a service. But, IT controls who can access and use the entire platform. As a result, IT actively prevents business units from taking advantage of the full range of services that Azure provides. Business units can't access the cloud portal. They only get access through Secure Shell (SSH) and Remote Desktop Protocol (RDP) to the server that they order.

For several reasons, the CCoE then has trouble providing a monolithic managed service to wrap each service that's available in the cloud:

- The cloud offers a large number of services across multiple solution areas. Compared with developing IaaS solutions, designing and engineering Internet of Things (IoT) and AI solutions requires different expertise and skill sets.
- Cloud services change frequently.
- Trying to provide monolithic services increases the time to market substantially, with IT managing the process, not the business units.

### Preferred outcome: Provide guardrails

When adopting cloud technologies, have the IT department gain firsthand experience with the cloud by starting with IT workloads. Use the [Microsoft Cloud Adoption Framework for Azure](../index.yml) to identify your [first adoption project](../strategy/motivations.md).

Use a mature [cloud operating model](../operating-model/compare.md) such as [centralized operations](../operating-model/compare.md#centralized-operations) that makes IT responsible for defining platform guardrails like governance. Then business units can adopt cloud projects in a secure and consistent manner, within the guardrails that IT defines.

Consider adopting only one major public cloud provider at the start, because all major platforms differ significantly in setup, management, and usage.

Use SaaS solutions as much as possible for IT tooling, such as:

- Code repositories.
- Continuous integration and continuous delivery (CI/CD).
- Collaboration systems.

For cloud workloads, advise IT to use familiar procedures that operate safely and securely at scale.

## Next steps

- [Overview of the reliability pillar](/azure/architecture/framework/resiliency/design-resiliency)
- [First adoption project](../strategy/motivations.md)
