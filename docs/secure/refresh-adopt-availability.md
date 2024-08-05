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

Availability refers to a system's ability to remain operational through normal and abnormal conditions and is a critical aspect of the Microsoft Cloud Adoption Framework (CAF). It is critical in maintaining business continuity and minimizing downtime, which are essential for organizational success in the cloud. Abnormal conditions include spiking utilization, malfunction, or a malicious attack, among other scenarios. A system's availability is dependent upon the reliability mechanisms built into its design. Highly available systems have reliability mechanisms built in at every level: infrastructure design, application design, operations, and governance. This article provides guidance on adopting availability in these areas to help ensure that your cloud estate remains operational and is resilient against security threats and malfunctions.

## Strategy

Refer to the [cross-cutting recommendations](./refresh-adopt-confidentiality.md#cross-cutting-guidance) in the "Adopt confidentialiy" guide.

## Plan 

Refer to the [cross-cutting recommendations](./refresh-adopt-confidentiality.md#cross-cutting-guidance) in the "Adopt confidentialiy" guide.

## Ready

After completing your cloud adoption strategy and plan, you can begin your move into the Ready phase by configuring your landing zones and defining the design patterns that will be used for your workload deployments.

### Landing zone configuration

Optimizing your landing zone for availability focuses on properly isolating zones from one another and workloads from one another to ensure that an incident has minimal bast radius. Review the [resource organization](../ready/landing-zone/design-area/resource-org.md) and [network segmentation](../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md) guidance to learn about best practices on these topics. 

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

### Summary

Having reslient designs for your landing zones and workloads will build a solid foundation for building a cloud estate that prioritizes availability. Your landing zone design should minimize the blast radius of any incident, which allows your teams to act quickly towards mitigating the incident while keeping other business functions operational. Resilient infrastructure design patterns further minimizes blast radius while removing single points of failure. Resilient application design patterns help your workload function in a degraded state or automatically heal itself.

Refer to the [Ready](../ready/) methodology section for detailed guidance on topics related to preparing for cloud adoption.

### Adopt

With resilient design patterns defined, your organization can move on to the adoption phase. For detailed guidance on workload availability, refer to the Well-Architected Framework's [reliability](/azure/well-architected/reliability) pillar and the [Azure reliability](/azure/reliability/overview) documentation. In the context of cloud adoption, the focus is on establishing and codifying operational practices that support availability.

### Establishing operational practices to support availability

Maintaining a highly available cloud estate can only be done if the teams operating the cloud systems have standardized, mature practices that are strictly followed. These practices should include:

- **Operational continuity:** Organizations must plan for continuous operations even under attack conditions. This includes establishing processes for rapid recovery and maintaining critical services at a degraded level until full recovery is possible. Refer to the [Adopt preparedness](./refresh-adopt-preparedness.md) guide for detailed guidance on this topic.

- **Robust and continuous observability:** An organization's ability to detect security incidents as they happen allows them to initiate their incident response plans quickly, helping to minimize the business impact as much as possible. Incident detection is only possible through a well-designed monitoring and alerting system, following best-practices for threat detection. Refer to the Well-Architected Framework's [observability guide](/azure/well-architected/operational-excellence/observability) and [security monitoring and threat detection guide](/azure/well-architected/security/monitor-threats) for detailed guidance on this topic.

- **Incindent response:** Mitigating security incidents is integral to business continuity. To efficiently respond to incidents, an organization must have strict standard procedures that are applied to every incident and followed by all teams involved in the mitigation. These procedures are captured in the incident response plan. Refer to the Well-Architected Framework's [incident response guide](/azure/well-architected/security/incident-response) for detailed guidance on this topic.

- **Infrastructure as Code deployments:** All infrastructure should be deployed through code, without exception. Reduce the risk of misconfigured infrastructure and unauthorized deployments by mandating this standard. All infrastructure code assets should be colocated with application code assets and treated with same [safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) as software deployments.

- **Proactive maintenance:** System updates should be standardized and enforced through policies. Schedule regular maintenance windows to apply updates and patches to systems without disrupting services. Conduct regular health checks and maintenance activities to ensure all components are functioning optimally​.

- **Standardized governance policies:** Enforce all security standards through tooling-supported policies. Use a policy management tool like [Azure Policy](/azure/governance/policy/overview) to ensure that all of your systems are compliant with your business requirements by default and that your policies are easily auditable. Refer to the [security governance](./refresh-security-governance.md) guide for further details on this topic.

- **Security baselines:** Establish security baselines that include availability requirements to have a well understood foundation to build from. Using a tool like [Microsoft Secure Score](/defender-xdr/microsoft-secure-score-improvement-actions) can help you establish baselines with tangible recommendations for improvements.

- **Automation:** Use automation tools to manage routine tasks, such as scaling resources and applying updates, to reduce the risk of human error and improve consistency. Take advantage of cloud services that have the ability to automate failover and recovery procedures. Automate threat detection and response with tools like the automated investigation and response functionality in [Microsoft Defender XDR](/defender-xdr/m365d-autoir).

- **Disaster recovery preparedness:** Develop and regulary test disaster recovery plans for your workloads to ensure that they will be able to be recovered in the event of a disaster. Refer to the Well-Architected Framework's [disaster recovery guidance](/azure/well-architected/reliability/disaster-recovery) for detailed guidance on this topic.

- **Understanding service-level agreements:** Service-level agreements (SLAs) that are provided by your cloud platform for their services help you understand the guaranteed uptime for the components of your workloads. Using those SLAs as your basis, you can then develop your own target metrics for the SLAs you offer your customers. Microsoft publishes the SLAs for all cloud services at [Service-level agreements for online services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services)

- **Data encryption:** Encrypting data at rest and in transit protects against unauthorized access. In the event of a breach, encrypted data is unreadable without the decryption key, minimizing the impact on operations and reducing downtime associated with breach management. Refer to the [Adopt integrity guide](./refresh-adopt-integrity.md) for detailed guidance on data integrity.

- **Zero Trust access and authorization controls:** Strong access controls and identity management systems ensure that only authorized personnel have access to critical systems and data. This reduces the risk of malicious activities that could disrupt services. Standardizing on strictly enforced role-based access controls (RBAC) and requiring multi-factor authentication (MFA) helps prevent unauthorized access to your systems that could disrupt service availability. Refer to the [Securing identity with Zero Trust](/security/zero-trust/deploy/identity) article for detailed guidance on this topic.

- **Compliance requirements:** Adhering to regulations such as GDPR and HIPAA ensures that systems are designed and maintained to high standards, including those related to availability. Non-compliance can lead to legal actions and fines that might disrupt business operations. Compliance often isn't limited to system configuration. Most compliance frameworks also require risk management and incident response standards. Ensure that your operational standards meet the framework requirements and staff is trained regularly. Refer to the [Adopt preparedness](./refresh-adopt-preparedness.md) article for detailed guidance on this topic.

### Summary

Adopting the availability principle relies on deploying reslient workloads and following well-defined operational practices that support the resilience of the workloads and your business functions. These operational practices should be standardized and enforced to ensure that when incidents happen, your teams act with confidence, working to restore services as efficiently as possible.

Refer to the [Adopt](../adopt/) methodology section for detailed guidance on cloud adoption topics.

## Govern

After establishing and standardizing your operational practices and implementing workloads and other operational functions, proper governance will help ensure that standards are enforced and regularly reviewed to stay up to date as your cloud estate evolves.

1. **Managing and enforcing standards:** Ensure that all standards are documented and stored in highly available and secure storage. Use version control to ensure that documentation is auditable and reviews are tracked. Enforce standards through regularly recurring mandatory incident response drills. Operators should know where to find their procedures and understand all the steps to follow as they go through their drills. Refer to the [Adopt preparedness](./refresh-adopt-preparedness.md) guide for detailed guidance on this topic. Enforce compliance requirment adherence through tooling, like [Azure Policy](/azure/policy) to reduce the risk of misconfiguration or non-compliant systems.

2. **Continuous improvement of standards:** Your cloud estate will evolve over time, and as technology evolves, so must your operational practices. Without keeping your standards up to date, you risk exposing your business to gaps that may have been introduced through the adoption of new technologies or more advanced attack techniques that come about. To protect against these risks, ensure that every standard is reviewed regularly to keep up to date. Use learnings gained from drills to inform updates to your practices. Your standards should always be considered living documents that should be improved as often as possible.

### Summary

Proper governance of your operational standards that support availability will ensure that those standards are enforced, which helps maintain availability throughout incidents. Governance includes properly maintaining documented standards, regularly drilling procedures, and continuous improvement practices.

Refer to the [Govern](../govern/) methodology section for detailed guidance on cloud governance topics.

## Manage

Managing the availability of your cloud estate relies on robust, proactive availability monitoring that is validated through testing.

1. **Availability monitoring:** Ensure that all infrastructure and applications are configured for monitoring and that alerting is configured to notify the appropriate teams. Make use of cloud-native logging and [application instrumenting](/azure/well-architected/operational-excellence/instrument-application) functionality to simplify your monitoring design and reduce operational burden.

1. **Availability testing:** All infrastructure and applications must be tested regularly for availability as part of your overall testing strategy. [Fault injection and chaos testing](/azure/well-architected/reliability/testing-strategy#fault-injection-and-chaos-engineering-guidance) are excellent strategies to test availability and security by purposely introducing malfunctions.

Refer to the [Manage](../manage/) methodology section for detailed guidance on cloud management topics.

## Resources

- [Azure reliability documention](/azure/reliability/overview)
- [Well-Architected Framework reliability pillar documentation](/azure/well-architected/reliability/)
- [Zero Trust implementation guidance](/security/zero-trust/zero-trust-overview)

## Azure facilitation

The following Azure services can help you ensure high availability:

### System and data replication

- **[Azure Site Recovery](/azure/site-recovery/):** A service that helps ensure business continuity by keeping business apps and workloads running during outages. It automates the replication, failover, and recovery of workloads so that they remain available during interruptions.

- **[Azure Backup](/azure/backup/backup-overview):** Regularly back up data to ensure it can be restored in case of accidental deletion or corruption.

### Networking

- **[Azure Front Door](/azure/frontdoor/front-door-overview):** is an application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application like SSL offload, path-based routing, fast failover, and caching to improve performance and high availability of your applications.

- **[Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview):** is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it load balances only at the domain level. For that reason, it can't fail over as quickly as Azure Front Door, because of common challenges around DNS caching and systems not honoring DNS TTLs.

- **[Azure Application Gateway](/azure/application-gateway/overview):** provides application delivery controller as a service, offering various Layer 7 load-balancing capabilities and web application firewall functionality. Use it to transition from public network space into your web servers hosted in private network space within a region.

- **[Azure Load Balancer](/azure/load-balancer/load-balancer-overview):** is a high-performance, ultra-low-latency Layer 4 load-balancing service (inbound and outbound) for all UDP and TCP protocols. It's built to handle millions of requests per second while ensuring your solution is highly available. Load Balancer is zone redundant, ensuring high availability across availability zones. It supports both a regional deployment topology and a [cross-region topology](/azure/load-balancer/cross-region-overview).

- **[Azure Availability Zones](/azure/reliability/availability-zones-overview)**:** Deploy resources across multiple, physically separate locations within an Azure region to protect against datacenter failures.

### Compute and data services

Refer to the [Reliability guides by service](/azure/reliability/overview-reliability-guidance) for details on many Azure compute and data services.