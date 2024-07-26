---
title: Adopt availability
description: Learn about best practices for optimizing the availability of your cloud estate.
author: claytonsiemens77
ms.author: csiemens
ms.date: 07/19/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Adopt availability

## Introduction

Availability refers to a system's ability to remain operational through normal and abnormal conditions and is a critical aspect of the Microsoft Cloud Adoption Framework (CAF). It is critical in maintaining business continuity and minimizing downtime, which are essential for organizational success in the cloud. Abnormal conditions include spiking utilization, malfunction, or a malicious attack, among other scenarios. A system's availability is dependent upon the reliability mechanisms built into its design. Highly available systems have reliabilty mechanisms built in at every level: infrastructure design, application design, operations, and governance. This article provides guidance on adopting availability in these areas to help ensure that your cloud estate remains operational and is resilient against security threats and malfunctions.

## Strategy

Developing a strategy for ensuring availability in your cloud estate relies on establishing [reliability targets](/azure/well-architected/reliability/metrics). These are metrics negotiated by business and technology stakeholders that define the tolerable amount of downtime for your [workloads](/azure/cloud-adoption-framework/plan/workloads), so are typically defined per workload. Different workloads may have different reliability requirements depending on their criticality, and [user or system flows](/azure/well-architected/cross-cutting-guides/optimize-workload-using-flows) within a given workload may have different reliability requirements depending on their own criticality. The Well-Architected Framework provides detailed guidance for workload-focused reliability strategies, and it is recommended that architects and engineers base their workload designs based on that guidance.

While your availability strategy may primarily be defined by workload-focused metrics, you still need a more holisitic approach to availability as it relates to security, and that is the focus of this article. By necessity, some general workload guidance is included, but it should be considered for applying broadly across your cloud estate.

## Plan

As you plan your cloud estate, ensure that your infrastructure and application designs are optimized for availability. 

### Adopt the landing zone model

The [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/) approach helps you design your cloud foundation to ensure that your entire cloud estate is highly manageable and optimized to allow you to design secure, scalable workloads that are isolated from each other and from functions that are either uninvolved or shared across workloads.

### Resilient architectural design

Designing your infrastructure for resiliency helps ensure that your cloud systems are able to withstand malfunctions or security incidents, allowing the business to continue operations while the affected systems are attended to. A highly available architecture includes the following design decisions:

- **Redundancy and replication:** Minimize single point of failure risks through [redundanct infrastructure design](/azure/well-architected/reliability/redundancy), including data replication.
    - Distribute your workloads across [multiple regions](/azure/well-architected/reliability/highly-available-multi-region-design) to protect against regional issues.
- **Autoscaling:** Implement [automatic scaling](/azure/well-architected/reliability/scaling) in your workloads to protect against resource exhaustion caused by spikes in utilization.
- **Load balancing:** [Choose an appropriate load balancing solution](/azure/architecture/guide/technology-choices/load-balancing-overview) to distribute traffic across multiple servers, ensuring that no single server (or cluster) becomes a point of failure.

### Resilient application design

Adopt application [design patterns](/azure/well-architected/reliability/design-patterns) that increase their resilience to non-infrastructure incidents. Standardize designs that include [self-healing and self-preservation mechanisms](/azure/well-architected/reliability/self-preservation)

- **Microservices and containerization:** Avoid monolithic applications by breaking them down into smaller, independent services that can be deployed and scaled independently.

- **Decouple services:** Isolate services from each other to reduce the blast radius of incidents.

## Ready

### Operational practices to support availability

Maintaining a highly available cloud estate can only be done the teams operating the cloud systems have standardized, mature practices that are strictly followed. These practices should include:

- **Operational continuity:** Organizations must plan for continuous operations even under attack conditions. This includes establishing processes for rapid recovery and maintaining critical services at a degraded level until full recovery is possible. Refer to the [Adopt preparedness](./refresh-adopt-preparedness.md) guide for detailed guidance on this topic.

- **Robust and continuous observability:** An organization's ability to detect security incidents as they happen allows them to initiate their incident response plans quickly, helping to minimize the business impact as much as possible. Incident detection is only possible through a well-designed monitoring and alerting system, following best-practices for threat detection . Refer to the Well-Architected Framework's [observability guide](/azure/well-architected/operational-excellence/observability) and [security monitoring and threat detection guide](/azure/well-architected/security/monitor-threats) for detailed guidance on this topic.

- **Incindent response:** Mitigating security incidents is integral to business continuity. To efficiently respond to incidents, an organization must have strict standard procedures that are applied to every incident and followed by all teams involved in the mitigation. These procedures are captured in the incident response plan. Refer to the Well-Architected Framework's [incident response guide](/azure/well-architected/security/incident-response) for detailed guidance on this topic.

- **Proactive maintenance:** System updates should be standardized and enforced through policies. Schedule regular maintenance windows to apply updates and patches to systems without disrupting services. Conduct regular health checks and maintenance activities to ensure all components are functioning optimally​.

- **Standardized governance policies:** Enforce all security standards through tooling-supported policies. Use a policy management tool like [Azure Policy](/azure/governance/policy/overview) to ensure that all of your systems are compliant with your business requirements by default and that your policies are easily auditable. Refer to the [security governance](./refresh-security-governance.md) guide for further details on this topic.

- **Security baselines:** Establish security baselines that include availability requirements to have a well understood foundation to build from. Using a tool like [Microsoft Secure Score](/defender-xdr/microsoft-secure-score-improvement-actions) can help you establish baselines with tangible recommendations for improvements.

- **Automation:** Use automation tools to manage routine tasks, such as scaling resources and applying updates, to reduce the risk of human error and improve consistency. Take advantage of cloud services that have the ability to automate failover and recovery procedures. Automate threat detection and response with tools like the automated investigation and response functionality in [Microsoft Defender XDR](/defender-xdr/m365d-autoir).

- **Disaster recovery preparedness:** Develop and regulary test disaster recovery plans for your workloads to ensure that they will be able to be recovered in the event of a disaster. Refer to the Well-Architected Framework's [disaster recovery guidance](/azure/well-architected/reliability/disaster-recovery) for detailed guidance on this topic.

- **Understanding service-level agreements:** Service-level agreements (SLAs) that are provided by your cloud platform for their services help you understand the guaranteed uptime for the components of your workloads. Using those SLAs as your basis, you can then develop your own target metrics for the SLAs you offer your customers. Microsoft publishes the SLAs for all cloud services at [Service-level agreements for online services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services)

- **Data encryption:** Encrypting data at rest and in transit protects against unauthorized access. In the event of a breach, encrypted data is unreadable without the decryption key, minimizing the impact on operations and reducing downtime associated with breach management. Refer to the [Adopt integrity guide](./refresh-adopt-integrity.md) for detailed guidance on data integrity.

- **Zero Trust access and authorization controls:** Strong access controls and identity management systems ensure that only authorized personnel have access to critical systems and data. This reduces the risk of malicious activities that could disrupt services. Standardizing on strictly enforced role-based access controls (RBAC) and requiring multi-factor authentication (MFA) helps prevent unauthorized access to your systems that could disrupt service availability. Refer to the [Securing identity with Zero Trust](/security/zero-trust/deploy/identity) article for detailed guidance on this topic.

- **Adherence to and enforcement of compliance standards:** Adhering to regulations such as GDPR and HIPAA ensures that systems are designed and maintained to high standards, including those related to availability. Non-compliance can lead to legal actions and fines that might disrupt business operations. Enforce adherence through tooling, like [Azure Policy](/azure/policy) to reduce the risk of misconfiguration or non-compliant systems. Compliance often isn't limited to system configuration. Most compliance frameworks also require risk management and incident response standards. Ensure that your operational standards meet the framework requirements and staff is trained regularly. Refer to the [Adopt preparedness](./refresh-adopt-preparedness.md) article for detailed guidance on this topic.

## Resources

- [Azure reliability documention](/azure/reliability/overview)
- [Well-Architected Framework reliability pillar documentation](/azure/well-architected/reliability/)
- [Zero Trust implementation guidance](/security/zero-trust/zero-trust-overview)

## Azure facilitation

- **[Azure Site Recovery](/azure/site-recovery/):** A service that helps ensure business continuity by keeping business apps and workloads running during outages. It automates the replication, failover, and recovery of workloads so that they remain available during interruptions.

- **[Azure Backup](/azure/backup/backup-overview):** Regularly back up data to ensure it can be restored in case of accidental deletion or corruption.

- **[Azure Front Door](/azure/frontdoor/front-door-overview):** is an application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application like SSL offload, path-based routing, fast failover, and caching to improve performance and high availability of your applications.

- **[Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview):** is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it load balances only at the domain level. For that reason, it can't fail over as quickly as Azure Front Door, because of common challenges around DNS caching and systems not honoring DNS TTLs.

- **[Azure Application Gateway](/azure/application-gateway/overview):** provides application delivery controller as a service, offering various Layer 7 load-balancing capabilities and web application firewall functionality. Use it to transition from public network space into your web servers hosted in private network space within a region.

- **[Azure Load Balancer](/azure/load-balancer/load-balancer-overview):** is a high-performance, ultra-low-latency Layer 4 load-balancing service (inbound and outbound) for all UDP and TCP protocols. It's built to handle millions of requests per second while ensuring your solution is highly available. Load Balancer is zone redundant, ensuring high availability across availability zones. It supports both a regional deployment topology and a [cross-region topology](/azure/load-balancer/cross-region-overview).

- **[Azure Availability Zones](/azure/reliability/availability-zones-overview)**:** Deploy resources across multiple, physically separate locations within an Azure region to protect against datacenter failures.
- 
- **[Azure Virtual Machines (VMs)](/azure/virtual-machines/):**
    - **[Availability sets](/azure/virtual-machines/availability-set-overview):** Ensure that VMs are distributed across multiple isolated hardware nodes in a cluster to avoid single points of failure.
    - **[Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/overview):** Automatically scale the number of VMs based on demand, providing redundancy and improved performance.

- **[Azure Kubernetes Service (AKS)](/azure/aks):**
    - Cluster autoscaling: Automatically adjusts the number of cluster nodes to maintain performance and availability.
    - Node Pools: Manage and scale different types of workloads independently within the same AKS cluster.

- **[Azure Storage](/azure/storage/blobs/storage-blobs-overview):** Various redundancy options are available for storage services, like Locally Redundant Storage (LRS), Geo-Redundant Storage (GRS), and Zone-redundant Storage, ensuring data availability throughout data center or regional outages.

- 