---
title: "Cloud readiness Antipatterns"
description: Cloud readiness antipatterns include, assuming services ready for production, that there's built in resiliency, and that IT is ready for the cloud.
author: lpassig
ms.author: brblanch
ms.date: 01/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---
# Cloud readiness Antipatterns

Customers frequently experience a number of common cloud adoption antipatterns while in the readiness phase of cloud adoption. Review the following antipatterns to avoid unexpected downtime, inability to recover or keep services available,  

## Assuming released services are always supposed to be used in production

Since cloud computing is evolving rapidly, new services are often released in a preview state. These preview services usually do not provide e.g., an uptime SLA. Additionally, newly available services might have not reached the same maturity as already available service in the cloud. Customers tend to assume that all services that are made available in the cloud can be used already in production environments.

### Example of using a cloud service in production

Trey Research Inc. uses a preview cloud service in production, since they think the service matches their use case. However, they quickly realize that they encounter some problems with the service resulting in unexpected downtime. This leads to the assumption that the cloud is not mature as well as not as resilient as promised. However, they did not perform proper due diligence and did not adhere to reference designs.

### Preferred outcome: pre-approved use of cloud services in production

When deciding on new services that are in preview status, keep in mind to only use preview services within Proof of Concept (PoC) scenarios but not in production environments as they do not have a specified SLA. The IT also needs to find the right balance when they are approving the usage of cloud services. The [Cloud Services Due Diligence Checklist](https://www.microsoft.com/trust-center/compliance/due-diligence-checklist) can help to approve the usage of cloud services quicker based on an already established framework.

## Assuming increased resiliency and availability by default

Increased resiliency (recovering from failures) and availability (running in a healthy state without significant downtime) can be one of the major advantages of cloud computing compared to on-premises. That leads to the perception that resiliency and high availability are on by default and do not have in mind that these factors can lead to additional costs and implicate in some cases additional technical effort.

### Example of resiliency and availability antipattern

Trey Research Inc. implement a mission critical application on IaaS services with a single VM and premium storage, as they know of the single VM SLA of 99,9% uptime and want to cut costs. When the VM fails their application is not able to recover which leads to a downtime that was not expected as they thought the cloud offers high availability by default. They weren’t aware that this can differ depending on the service model (PaaS and SaaS) and the technical architecture (load balanced Availability Sets or Availability Zones).

### Preferred outcome: minimize failure, balance resiliency, availability and cost concerns

Use [reference designs](https://docs.microsoft.com/azure/architecture/reference-architectures) and the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) to identify architectural best practices to be able to minimize the scope of failures. These services are mature in nature and people are familiar with them.

Companies need to identify the right balance between [high resiliency and availability](https://docs.microsoft.com/azure/architecture/framework/resiliency/overview) and cost concerns. Meaning increased resiliency and availability most likely lead to increased costs (single instance cost with no SLA or 99,9% uptime SLA vs. two VMs running the same workload leading to 99,95% to 99,99% uptime SLA). Therefore, the process of requirement engineering is essential when designing a cloud-based solution. [SLA Estimator](https://github.com/mspnp/samples/tree/master/Reliability/SLAEstimator) can help calculate the end-to-end SLA of your application.

## Becoming a Cloud Provider yourself

Some companies introduce programs within their IT with the goal in mind, that the internal IT should become a cloud provider. In this initiative the IT becomes responsible to provide not only reference architectures but also infrastructure/platform as a service to business units. However, since this type of work is usually not the core business of the IT department, the "-as a service" offerings often lack pattern and practices to run or provide these services in a resilient, efficient, and secure way.

### Example of this antipattern

Contoso's IT department has established a Cloud Center of Excellence (CCoE) which serves as a broker between IT and Business Units. To be compliant in the cloud, they have received the assignment from the managing board to provide end-to-end services. So, they setup an internal cloud procurement portal where business units can order a fully managed Cloud VM as a service. The Business Unit does not get access to the Cloud Portal but only gets access to the ordered server via SSH/RDP.

However, the CCoE quickly realized, that they can't provide guidance for all services available in the cloud due to the sheer mass of services. Additionally, the introduced end-to-end service for all cloud services within their portal reduces the time to market by a substantial amount, since everything is managed by the IT and not by the Business Unit.

### Preferred outcome: IT provides the guardrails

When adopting/managing the cloud, the IT department should concentrate on IT workloads first, to experience the cloud firsthand. The Cloud Adoption Framework can help companies identifying such a [First Adoption Project](/azure/cloud-adoption-framework/strategy/first-adoption-project).

This aligns with a matured [cloud operating model](https://docs.microsoft.com/azure/cloud-adoption-framework/operating-model/compare) “Central IT” where the Central IT is responsible to define the platform guardrails like governance. This opens the opportunity for business units to adopting their first cloud project in a secure and consistent manner by moving within the guardrails defined by the IT.

Additionally, companies should consider starting (off) with adopting only one major public-cloud provider, since all major platforms differ significantly in setup, management, and usage.

When it comes to IT tooling, such as: code repositories, continuous integration and continuous delivery and collaboration systems it is recommended to use Software as a Service (SaaS) solutions as much as possible. Considering cloud workloads, the IT should first rely on patterns that they know and can operate safely and securely at scale.

## Next steps

- [Cloud Services Due Diligence Checklist](https://www.microsoft.com/trust-center/compliance/due-diligence-checklist)
- [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/)
- [Overview of the reliability pillar](https://docs.microsoft.com/azure/architecture/framework/resiliency/overview)
- [SLA Estimator](https://github.com/mspnp/samples/tree/master/Reliability/SLAEstimator)
- [First Adoption Project](/azure/cloud-adoption-framework/strategy/first-adoption-project)
