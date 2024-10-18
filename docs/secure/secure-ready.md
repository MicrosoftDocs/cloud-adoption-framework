---
title: Ready your secure cloud estate
description: Learn how to adopt security best practices in your cloud estate setup phase
author: claytonsiemens77
ms.author: csiemens
ms.date: 10/18/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Ready your secure cloud estate

The Ready phase of a cloud adoption journey focuses on building out the foundation of the estate. Microsoft's [Azure landing zone](../ready/landing-zone/index.md) approach offers enterprises and large organizations a secure, scalable, and modular design pattern to follow when implementing their estates. Smaller organizations and startups may not need the level of organization that the landing zone approach uses, but understanding the landing zone philosophy can help any organization strategize their foundational design to ensure a high degree of security and scalability.

After defining your cloud adoption [strategy](./refresh-strategy-consolidated.md) and [plan](./refresh-plan-consolidated.md), you can begin the implementation phase by designing the foundation. Use the recommendations in this guide to ensure that your foundation design and implementation prioritize security.

This article is a supporting guide to the [Ready](../ready/index.md) methodology, offering areas of security optimization that should be considered as you move through that phase in your journey.

## Security posture modernization

The first implementation steps in modernizing your security posture are building your landing zone or cloud foundation and creating or modernizing your identity, authorization, and access platform.

- **Adopting the landing zone approach:** Adopting the landing zone approach or incorporating the design principles of the landing zone approach to the extent practical for your use case allows you to start your implementation off in an optimized way. As your cloud estate evolves, keeping different domains of your estate separated helps keep the entire estate more secure and manageable.

    - If you don't plan on adopting a full-blown enterprise landing zone, it's still important to understand the [design areas](../ready/landing-zone/design-areas.md) and apply guidance that is relevant to your cloud estate. You'll still need to think about all of these design areas and implement controls specific to each area no matter how your foundation is architected. For example, using management groups will help you govern your cloud estate even if it only consists of a few subscriptions.

Develop secure, scalable landing zones that provide controlled environments for deploying cloud resources. These zones ensure that security policies are consistently applied and that resources are segregated according to their security requirements. Refer to the [security design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security) for detailed guidance on this topic.

- **Modern identity, authorization, and access:** Following the principles of Zero Trust, the modern approach to identity, authorization, and access moves from trust-by-default to trust-by-exception. As such, users, devices, systems, and apps should only be allowed to access resources that they require, and only for as long as required to fulfill their function. The same guidance applies to the foundational elements of your estate: tightly control permissions to subscriptions, networking resources, governance solutions, the identity and access management (IAM) platform, and tenants using the same recommendations as the workloads that you run. Refer to the [identity and access management design area](../ready/landing-zone/design-area/identity-access.md) for detailed guidance on this topic.

### Azure facilitation

- **Azure landing zone accelerators:** Microsoft maintains several landing zone accelerators, which are prepackaged deployments of a given workload type that can be easily deployed into a landing zone to get you up and running quickly. They include [Azure Integration Services](../scenarios/app-platform/integration-services/landing-zone-accelerator.md), [Azure Kubernetes Service (AKS)](../scenarios/app-platform/aks/landing-zone-accelerator.md), [Azure API Management](../scenarios/app-platform/api-management/landing-zone-accelerator.md), and others. Refer to the [Modern application platform scenario](../scenarios/app-platform/index.md) section of CAF for a full list of accelerators and other topics related to modern application considerations.

- **Azure landing zones Terraform module:** You can optimize your landing zones deployments with automation by using the [Azure landing zones Terraform module](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest). Using your continuous deployment and continuous integration (CI/CD) pipeline to deploy landing zones ensures that all of your landing zones are deployed identically, with all security mechanisms in place.

- **Microsoft Entra:** [Microsoft Entra ID](/entra/fundamentals/what-is-entra) Microsoft Entra is a family of identity and network access products. It enables organizations to implement a Zero Trust security strategy and create a [trust fabric](https://www.microsoft.com/security/blog/2024/05/08/how-implementing-a-trust-fabric-strengthens-identity-and-network/) that verifies identities, validates access conditions, checks permissions, encrypts connection channels, and monitors for compromise.

## Ready for incident preparedness and response

After defining your strategy and developing your plan for incident preparedness and response, you can begin your implementation. Whether you adopt a full enterprise landing zone design or a smaller foundational design, network segregation is critical for maintaining a high degree of security.

**Network segmentation:** Design a network architecture with proper segmentation and isolation to minimize attack surfaces and contain potential breaches. Use techniques such as virtual private clouds (VPCs), subnets, and security groups to manage and control traffic. Refer to the [Plan for network segmentation](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-landing-zone-network-segmentation) article for detailed guidance on this topic. Be sure to review the rest of the Azure landing zone network security guides as part of your landing zone learning. Guidance includes recommendations for [inbound and outbound connectivity](../ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md), [network encryption](../ready/azure-best-practices/define-network-encryption-requirements.md), and [traffic inspection](../ready/azure-best-practices/plan-for-traffic-inspection.md).

### Azure facilitation 

- **Azure Virtual WAN:** [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) is a networking service that brings many networking, security, and routing functionalities together to provide a single operational interface. The design is a hub and spoke architecture with scale and performance built in for branches (VPN/SD-WAN devices), users (Azure VPN/OpenVPN/IKEv2 clients), ExpressRoute circuits, and virtual networks. When implementing your landing zones, Azure Virtual WAN can help you optimize your network through segmentation and security mechanisms.

## Ready for confidentiality

In the Ready phase, preparing for your workloads with confidentiality in mind means ensuring that your IAM policies and standards are implemented and enforced so when you deploy workloads, your data will be secured by default. Ensure that you have well-governed policies and standards for:

- *Principle of least privilege:* Grant users the minimum access required to perform their tasks.

- *Role-based access control (RBAC):* Assign roles and permissions based on job responsibilities. This helps in managing access efficiently and reduces the risk of unauthorized access.

- *Multifactor authentication (MFA):* Implement MFA to add an extra layer of security.

- *Conditional access controls:* Conditional access controls provide additional security by enforcing policies based on specific conditions. Policies can include enforcing MFA or blocking access based on geography, among many other scenarios. When deciding on an IAM platform, ensure that conditional access is supported and will meet your requirements

### Azure facilitation
 
- [Microsoft Entra Conditional Access](/entra/identity/conditional-access/overview) is Microsoft's Zero Trust policy engine taking signals from various sources into account when enforcing policy decisions.

## Ready for integrity

Like your confidentiality preparations, ensure that you have well-governed policies and standards for data and system integrity so you deploy workloads securely by default. Define policies and standards for the following:

### Data management practices

- *Data classification:* Create a data classification framework and sensitivity label taxonomy that defines high level categories of data security risk. That taxonomy will be used to simplify everything from data inventory or activity insights, to policy management to investigation prioritization. Refer to the [Create a well-designed data classification framework](/compliance/assurance/assurance-create-data-classification-framework) for detailed guidance on this topic.

- *Data verification and validation:* Invest in tooling that automates data verification and validation to relieve burden on your data engineers and administrators and to reduce the risk of human error.

- *Backup policies:* Codify backup policies to ensure that all data is regularly backed up. Backups and restores should be regularly tested to ensure that backups are both successfully occurring and for data correctness and consistency. Ensure that you align these policies with your organization's recovery time objective (RTO) and recovery point objective (RPO) targets.

- *Strong encryption:* Ensure that your cloud provider encrypts your data at rest and in transit by default. In Azure, your data is encrypted end-to-end. Refer to the [Microsoft Trust Center](https://www.microsoft.com/en-us/trust-center/privacy#securing_your_data) for full details. For the services that you use in your workloads, ensure that strong encryption is supported and appropriately configured to meet your business requirements.

### System integrity design patterns

- *Security monitoring:* To help detect unauthorized changes to your cloud systems, design a robust security monitoring platform as part of your overall monitoring and observability strategy. Refer to the Manage methodology [monitoring section](/azure/cloud-adoption-framework/manage/monitor/) for detailed guidance on overall guidance and the Zero Trust [Visibility, automation, and orchestration](/security/zero-trust/deploy/visibility-automation-orchestration) guide for recommendations on security monitoring.

    - *Security information and event management (SIEM) and threat detection:* Include the use of security information and event management (SIEM) and security orchestration, automation, and response (SOAR) tooling like  and threat detection tooling to detect suspicious activities and potential threats to your infrastructure. 

- *Automated configuration management:* Codify the use of tooling like to automate configuration management. Automation helps ensure that all system configurations are consistent, free from human error, and enforced automatically.

- *Automated patch management:* Codify the use of tooling to manage and govern updates for virtual machines (VMs). Automated patching helps ensure that all systems are patched regularly and system versions are consistent.

- *Automated infrastructure deployments:* Codify the use of infrastructure as code (IaC) for all deployments, and deploy them as part of your continuous integration and continuous deployment (CI/CD) pipelines. Apply the same [safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) for IaC deployments as you would for software deployments.

### Azure facilitation

- [Azure Policy](/azure/governance/policy) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) work hand-in-hand to help you define and enforce security policies across your cloud estate. Both solutions support the governance of your foundational elements along with workload resources.

- [Azure Update Manager](/azure/update-manager/overview) is Azure's native update and patch management solution. It can be extended to on-premises systems and Arc-enabled systems.

- [Microsoft Sentinel](/azure/sentinel/overview) is Microsoft's SIEM and SOAR solution, providing cyberthreat detection, investigation, response, and proactive hunting, with a bird's-eye view across your enterprise.

## Ready for availability

Designing your workloads for resiliency helps ensure that the business is able to withstand malfunctions or security incidents, and to continue operations while the affected systems are attended to. The following recommendations will help you design resilient workloads, aligning to CAF principles:

- **Resilient application design:** Adopt application design patterns that enhance resilience to both infrastructure and non-infrastructure incidents, aligning with the broader principles of the Cloud Adoption Framework. Standardize designs that incorporate self-healing and self-preservation mechanisms to ensure continuous operation and rapid recovery. For detailed guidance on resilient design patterns, refer to the Well-Architected Framework's [Reliability](/azure/well-architected/reliability) pillar.
 
- **Adopt serverless architecture:** Utilize serverless technologies including platform as a service (PaaS), software as a service (SaaS), and function as a service (FaaS) to reduce server management overhead, automatically scale with demand, and ensure high availability. This approach supports CAF’s emphasis on modernizing workloads and optimizing operational efficiency.
 
- **Microservices and containerization:** Implement microservices and containerization to avoid monolithic applications, breaking them down into smaller, independent services that can be deployed and scaled independently. This aligns with CAF’s principles of agility and scalability in cloud environments.
 
- **Decouple services:** Strategically isolate services from each other to reduce the blast radius of incidents, ensuring that failures in one component don't affect the entire system. This approach supports CAF’s governance model, promoting robust service boundaries and operational resilience.
 
- **Enable automatic scaling:** Ensure your application architecture supports automatic scaling to handle varying loads, maintaining availability during traffic spikes. This practice aligns with CAF’s guidance on building scalable and responsive cloud environments, and helps keep costs manageable and predictable.

- **Implement fault isolation:** Design your application to isolate failures to individual tasks or functions, preventing widespread outages and enhancing resilience. This approach supports CAF’s focus on creating reliable and fault-tolerant systems.
 
- **Ensure high availability:** Incorporate built-in redundancy and disaster recovery mechanisms to maintain continuous operation, following CAF’s best practices for high availability and business continuity planning.
 
- **Plan for automatic failover:** Deploy applications across multiple regions to support seamless failover and uninterrupted service, aligning with CAF’s strategy for geographic redundancy and disaster recovery.

## Ready for security sustainment

In the Ready phase, preparing for long-term security sustainment involves ensuring that the foundational elements of your estate adhere to security best practices for the initial workloads, but are also scalable to ensure that as your estate grows and evolves, your security won't be compromised and the management of your security won't become too complex and burdensome to avoid shadow IT behaviors. To that end, in the Ready phase think about how your business goals for the longer term can be accomplished without major architectural redesigns or major overhauls to operational practices. Even if you choose to lay down a much simpler foundation than a landing zone design, ensure that your foundational design can be uplifted to an enterprise architecture without having to redeploy major elements of your estate like the networking or critical workloads. Having a design that can grow as your estate grows while staying secure will be instrumental to the success of your cloud journey.

Review the [Transition an existing Azure environment to the Azure landing zone conceptual architecture](../ready/enterprise-scale/transition.md) article for recommendations on uplifting an existing Azure footprint into a landing zone architecture.

## Next step

> [!div class="nextstepaction"]
> [Perform your cloud adoption securely](./secure-adopt.md)