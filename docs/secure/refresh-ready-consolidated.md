---
title: Ready your secure cloud estate
description: Learn how to adopt security best practices in your cloud estate setup phase
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Ready your secure cloud estate

## Introduction

The Ready phase of a cloud adoption journey focuses on building out the foundation of the estate. Microsoft's [Azure landing zone](../ready/landing-zone/) approach offers enterprises and large organizations a secure, scalable, and modular design pattern to follow when implementing their estates. Smaller organizations and startups may not need the level of organization that the landing zone approach uses, but understanding the landing zone philosophy can help any organization strategize their foundational design to ensure a high degree of security and scalability.

After defining your cloud adoption [strategy](./refresh-strategy-consolidated.md) and [plan](./refresh-plan-consolidated.md), you can turn begin the implementation phase by designing the foundation. Use the recommendations in this guide to ensure that your foundation design and implementation prioritize security.

This article is a supporting guide to the [Ready](../ready) methodology, offering areas of security optimization that should be considered as you move through that phase in your journey.

## Security posture modernization



## Ready for incident preparedness and response

After defining your strategy and developing your plan for incident preparedness and response, you can begin your implementation. Using the Azure landing zone approach, you can lay down a secure foundation for your cloud environment, preparing you for the full implementation phase and the management phase.

- **Landing zones:** Develop secure, scalable landing zones that provide controlled environments for deploying cloud resources. These zones ensure that security policies are consistently applied and that resources are segregated according to their security requirements. Refer to the [security design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security) for detailed guidance on this topic.

- **Network segmentation:** Design a network architecture with proper segmentation and isolation to minimize attack surfaces and contain potential breaches. Use techniques such as virtual private clouds (VPCs), subnets, and security groups to manage and control traffic. Refer to the [Plan for network segmentation](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-landing-zone-network-segmentation) article for detailed guidance on this topic.

## Ready for confidentiality

Data access controls are critical for maintaining confidentiality in cloud environments. They ensure that only authorized users can access sensitive data. 

- *Principle of least privilege:* Grant users the minimum access required to perform their tasks.

- *Role-based access control (RBAC):* Assign roles and permissions based on job responsibilities. This helps in managing access efficiently and reduces the risk of unauthorized access.

- *Multi-factor authentication (MFA):* Implement MFA to add an extra layer of security.

- *Data confidentiality and sensitivity protections:* Implement data classification and labeling to identify and protect sensitive information. Use encryption both at rest and in transit to safeguard data from unauthorized access and breaches.

- *Conditional access controls:* Conditional access controls provide additional security by enforcing policies based on specific conditions. Policies can include enforcing MFA or blocking access based on geography, among many other scenarios. Conditional access is built in to many identity and authorization solutions, like [Microsoft Entra Conditional Access](/entra/identity/conditional-access/overview)

## Ready for integrity

### Data management practices

- *Data classification:* Create a data classification framework and sensitivity label taxonomy that defines high level categories of data security risk. That taxonomy will be used to simplify everything from data inventory or activity insights, to policy management to investigation prioritization. Refer to the [Create a well-designed data classification framework](/compliance/assurance/assurance-create-data-classification-framework) for detailed guidance on this topic.

- *Data verification and validation:* Invest in tooling that automates data verification and validation to relieve burden on your data engineers and administrators and to reduce the risk of human error.

- *Robust access control management:* Protecting data from unauthorized modifications requires a strong access control strategy. Refer to the [guidance](./refresh-adopt-confidentiality.md#identity-and-access-management) provided in the "Adopt confidentialty" guide for detailed guidance on this topic.

- *Backup policies:* Codify backup policies to ensure that all data is regularly backed up. Backups and restores should be regularly tested to ensure that backups are both successfully occuring and for data correctness and consistency.

- *Strong encryption:* Ensure that your cloud provider encrypts your data at rest and in transit by default. In Azure, your data is encrypted end-to-end. Refer to the [Microsoft Trust Center](https://www.microsoft.com/en-us/trust-center/privacy#securing_your_data) for full details. For the services that you use in your workloads, ensure that strong encryption is supported and appropriately configured to meet your business requirements.

### System integrity design patterns

- *Security monitoring:* To help detect unauthorized changes to your cloud systems, design a robust security monitoring platform as part of your overall monitoring and observability strategy. Refer to the Manage methodology [monitoring section](/azure/cloud-adoption-framework/manage/monitor/) for detailed guidance on overall guidance and the Zero Trust [Visibility, automation, and orchestration](/security/zero-trust/deploy/visibility-automation-orchestration) guide for recommendations on security monitoring.

    - *Security information and event management (SIEM) and threat detection:* Include the use of SIEM tooling like [Microsoft Sentinel](/azure/sentinel/overview) and threat detection tooling like [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) to detect suspicious activities and potential threats to your infrastructure. 

- *Automated configuration management:* Codify the use of tooling like [Azure Policy](/azure/governance/policy) and [Microsoft Defender for Cloud](/defender-for-cloud/defender-for-cloud-introduction) to automate configuration management. Automation helps ensure that all system configurations are consistent, free from human error, and enforced .

- *Automated patch management:* Codify the use of tooling like [Azure Update Manager](/azure/update-manager/overview) to manage and govern updates for virtual machines (VMs). Automated patching helps ensure that all systems are patched regularly and system versions are consistent.

- *Automated infrastructure deployments:* Codify the use of infrastructure as code (IaC) for all deployments, and deploy them as part of your continuous integration and continuous deployment (CI/CD) pipelines. Apply the same [safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) for IaC deployments as you would for software deployments.

## Ready for availability

Designing your workloads for resiliency helps ensure that the business is able to withstand malfunctions or security incidents, and to continue operations while the affected systems are attended to. The following recommendations will help you design resilient workloads, aligning to CAF principles:

- **Resilient Application Design:** Adopt application design patterns that enhance resilience to both infrastructure and non-infrastructure incidents, aligning with the broader principles of the Cloud Adoption Framework. Standardize designs that incorporate self-healing and self-preservation mechanisms to ensure continuous operation and rapid recovery. For detailed guidance on resilient design patterns, refer to the Well-Architected Framework's [Reliability](/azure/well-architected/reliability) pillar.
 
- **Adopt serverless architecture:** Utilize serverless technologies including platform as a service (PaaS), software as a service (SaaS), and function as a service (FaaS) to reduce server management overhead, automatically scale with demand, and ensure high availability. This supports CAF’s emphasis on modernizing workloads and optimizing operational efficiency.
 
- **Microservices and containerization:** Implement microservices and containerization to avoid monolithic applications, breaking them down into smaller, independent services that can be deployed and scaled independently. This aligns with CAF’s principles of agility and scalability in cloud environments.
 
- **Decouple services:** Strategically isolate services from each other to reduce the blast radius of incidents, ensuring that failures in one component do not affect the entire system. This approach supports CAF’s governance model, promoting robust service boundaries and operational resilience.
 
- **Enable automatic scaling:** Ensure your application architecture supports automatic scaling to handle varying loads, maintaining availability during traffic spikes. This practice aligns with CAF’s guidance on building scalable and responsive cloud environments.
Implement fault isolation: Design your application to isolate failures to individual tasks or functions, preventing widespread outages and enhancing resilience. This supports CAF’s focus on creating reliable and fault-tolerant systems.
 
- **Ensure high availability:** Incorporate built-in redundancy and disaster recovery mechanisms to maintain continuous operation, following CAF’s best practices for high availability and business continuity planning.
 
- **Plan for automatic failover:** Deploy applications across multiple regions to support seamless failover and uninterrupted service, aligning with CAF’s strategy for geographic redundancy and disaster recovery.

## Ready for security sustainment