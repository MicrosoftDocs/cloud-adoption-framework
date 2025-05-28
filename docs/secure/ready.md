---
title: Prepare Your Secure Cloud Estate
description: Learn how to adopt security best practices during your cloud estate setup phase. Prepare for incident preparedness, confidentiality, availability, and more. 
author: claytonsiemens77
ms.author: pnp
ms.date: 11/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Prepare your secure cloud estate

During the Ready phase of a cloud adoption journey, you focus on creating the foundation of the estate. The Microsoft [Azure landing zone](../ready/landing-zone/index.md) approach provides enterprises and large organizations with a more secure, scalable, modular design pattern to follow when they implement their estates. Smaller organizations and startups might not need the level of organization that the landing zone approach provides, but an understanding of the landing zone philosophy can help any organization strategize a foundational design and gain a high degree of security and scalability.

After you define your cloud adoption [strategy](./strategy.md) and [plan](./plan.md), you can begin the implementation phase by designing the foundation. Use the recommendations in this guide to ensure that your foundation design and implementation prioritize security.

:::image type="content" source="./media/caf-secure-ready.png" alt-text="Diagram showing the methodologies involved in cloud adoption. The diagram has boxes for each phase: teams and roles, strategy, plan, ready, adopt, govern, and manage. The box for this article is highlighted." lightbox="./media/caf-secure-ready.png" border="false":::

This article is a supporting guide to the [Ready](../ready/index.md) methodology. It describes areas of security optimization that you should consider as you move through that phase in your journey.

## Security posture modernization

The first implementation steps in modernizing your security posture are building your landing zone or cloud foundation and creating or modernizing your identity, authorization, and access platform.

- **Adopting the landing zone approach:** Adopting the landing zone approach or incorporating the design principles of the landing zone approach to the extent practical for your use case allows you to start your implementation in an optimized way. As your cloud estate evolves, keeping different domains of your estate separated helps keep the entire estate more secure and manageable.

    - If you don't plan to adopt a complete enterprise landing zone, you still need to understand the [design areas](../ready/landing-zone/design-areas.md) and apply guidance that's relevant to your cloud estate. You need to think about all of these design areas and implement controls that are specific to each area, no matter how your foundation is architected. For example, using management groups can help you govern your cloud estate even if it only consists of a few subscriptions.

Develop secure, scalable landing zones that provide controlled environments for deploying cloud resources. These zones help you ensure that security policies are consistently applied and that resources are segregated according to their security requirements. See the [security design area](../ready/landing-zone/design-area/security.md) for detailed guidance on this topic.

- **Modern identity, authorization, and access:** Based on the principles of Zero Trust, the modern approach to identity, authorization, and access moves from trust-by-default to trust-by-exception. It follows from these principles that users, devices, systems, and apps should be allowed to access only resources that they require, and only for as long as needed to meet their needs. The same guidance applies to the foundational elements of your estate: tightly control permissions to subscriptions, networking resources, governance solutions, the identity and access management (IAM) platform, and tenants by following the same recommendations that you follow for the workloads that you run. See the [identity and access management design area](../ready/landing-zone/design-area/identity-access.md) for detailed guidance on this topic.

### Azure facilitation

- **Azure landing zone accelerators:** Microsoft maintains several landing zone accelerators, which are prepackaged deployments of a given workload type that can be easily deployed into a landing zone to quickly get you started. They include accelerators for [Azure Integration Services](../scenarios/app-platform/integration-services/landing-zone-accelerator.md), [Azure Kubernetes Service (AKS)](../scenarios/app-platform/aks/landing-zone-accelerator.md), [Azure API Management](../scenarios/app-platform/api-management/landing-zone-accelerator.md), and others. See the [Modern application platform scenario](../scenarios/app-platform/index.md) section of the Cloud Adoption Framework for Azure documentation for a full list of accelerators and other topics related to modern application considerations.

- **Azure landing zones Terraform module:** You can optimize your landing zone deployments with automation by using the [Azure landing zones Terraform module](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest). By using your continuous integration and continuous deployment (CI/CD) pipeline to deploy landing zones, you can ensure that all of your landing zones are deployed identically, with all security mechanisms in place.

- **Microsoft Entra:** [Microsoft Entra](/entra/fundamentals/what-is-entra) is a family of identity and network access products. It enables organizations to implement a Zero Trust security strategy and create a [trust fabric](https://www.microsoft.com/security/blog/2024/05/08/how-implementing-a-trust-fabric-strengthens-identity-and-network/) that verifies identities, validates access conditions, checks permissions, encrypts connection channels, and monitors for compromise.

## Prepare for incident preparedness and response

After you define your strategy and develop your plan for incident preparedness and response, you can begin your implementation. Whether you adopt a full enterprise landing zone design or a smaller foundational design, network segregation is critical for maintaining a high degree of security.

**Network segmentation:** Design a network architecture with proper segmentation and isolation to minimize attack surfaces and contain potential breaches. Use techniques like virtual private clouds (VPCs), subnets, and security groups to manage and control traffic. See the [Plan for network segmentation](../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md) article for detailed guidance on this topic. Be sure to review the rest of the Azure landing zone network security guides. The guidance includes recommendations for [inbound and outbound connectivity](../ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md), [network encryption](../ready/azure-best-practices/define-network-encryption-requirements.md), and [traffic inspection](../ready/azure-best-practices/plan-for-traffic-inspection.md).

### Azure facilitation 

- **Azure Virtual WAN:** [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) is a networking service that consolidates many networking, security, and routing functionalities to provide a single operational interface. The design is a hub-and-spoke architecture that has scale and performance built in for branches (VPN/SD-WAN devices), users (Azure VPN/OpenVPN/IKEv2 clients), Azure ExpressRoute circuits, and virtual networks. When you implement your landing zones, Azure Virtual WAN can help you optimize your network through segmentation and security mechanisms.

## Prepare for confidentiality

During the Ready phase, preparing for your workloads from a confidentiality standpoint is a process of ensuring that your IAM policies and standards are implemented and enforced. This preparation ensures that, when you deploy workloads, your data will be secured by default. Be sure to have well-governed policies and standards for:

- *The principle of least privilege.* Grant users the minimum access required to perform their tasks.

- *Role-based access control (RBAC).* Assign roles and permissions based on job responsibilities. Doing so helps you manage access efficiently and reduces the risk of unauthorized access.

- *Multifactor authentication (MFA).* Implement MFA to add an extra layer of security.

- *Conditional Access controls.* Conditional Access controls provide additional security by enforcing policies based on specific conditions. Policies can include enforcing MFA, blocking access based on geography, and many other scenarios. When you choose an IAM platform, be sure that Conditional Access is supported and that the implementation meets your requirements.

### Azure facilitation
 
- [Microsoft Entra Conditional Access](/entra/identity/conditional-access/overview) is the Microsoft Zero Trust policy engine. It takes signals from various sources into account when enforcing policy decisions.

## Prepare for integrity

As with your confidentiality preparations, ensure that you have well-governed policies and standards for data and system integrity so you deploy workloads with improved security by default. Define policies and standards for the following areas.

### Data management practices

- *Data classification:* Create a data classification framework and sensitivity-label taxonomy that defines high-level categories of data security risk. You'll use that taxonomy to simplify everything from data inventory or activity insights, to policy management, to investigation prioritization. See [Create a well-designed data classification framework](/compliance/assurance/assurance-create-data-classification-framework) for detailed guidance on this topic.

- *Data verification and validation:* Invest in tooling that automates data verification and validation to reduce the burden on your data engineers and administrators and to decrease the risk of human error.

- *Backup policies:* Codify backup policies to ensure that all data is regularly backed up. Test backups and restores regularly to ensure that backups succeed and that data is correct and consistent. Align these policies with your organization's recovery time objective (RTO) and recovery point objective (RPO) targets.

- *Strong encryption:* Ensure that your cloud provider encrypts your data at rest and in transit by default. On Azure, your data is encrypted end to end. See the [Microsoft Trust Center](https://www.microsoft.com/trust-center/privacy#securing_your_data) for details. For the services that you use in your workloads, ensure that strong encryption is supported and appropriately configured to meet your business requirements.

### System integrity design patterns

- *Security monitoring:* To detect unauthorized changes to your cloud systems, design a robust security monitoring platform as part of your overall monitoring and observability strategy. See the Manage methodology [monitoring section](/azure/cloud-adoption-framework/manage/monitor/) for detailed overall guidance. See the Zero Trust [Visibility, automation, and orchestration](/security/zero-trust/deploy/visibility-automation-orchestration) guide for recommendations on security monitoring.

    - *SIEM and threat detection:* Use security information and event management (SIEM) and security orchestration, automation, and response (SOAR) tooling and threat detection tooling to detect suspicious activities and potential threats to your infrastructure. 

- *Automated configuration management:* Codify the use of tooling to automate configuration management. Automation helps you ensure that all system configurations are consistent, free from human error, and enforced automatically.

- *Automated patch management:* Codify the use of tooling for managing and governing updates for virtual machines. Automated patching helps ensure that all systems are patched regularly and that system versions are consistent.

- *Automated infrastructure deployments:* Codify the use of infrastructure as code (IaC) for all deployments. Deploy IaC as part of your CI/CD pipelines. Apply the same [safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) for IaC deployments as you would for software deployments.

### Azure facilitation

- [Azure Policy](/azure/governance/policy) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) work together to help you define and enforce security policies across your cloud estate. Both solutions support the governance of your foundational elements and your workload resources.

- [Azure Update Manager](/azure/update-manager/overview) is the native Azure update and patch management solution. You can extend it to on-premises systems and Arc-enabled systems.

- [Microsoft Sentinel](/azure/sentinel/overview) is the Microsoft SIEM and SOAR solution. It provides cyberthreat detection, investigation, and response, proactive hunting, and a comprehensive view across your enterprise.

## Prepare for availability

Designing your workloads for resiliency helps ensure that your business can withstand malfunctions and security incidents, and that operations can continue while problems with affected systems are addressed. The following recommendations, which align to Cloud Adoption Framework principles, can help you design resilient workloads:

- **Implement resilient application design.** Adopt application design patterns that enhance resilience against both infrastructure and non-infrastructure incidents, aligning with the broader principles of the Cloud Adoption Framework. Standardize on designs that incorporate self-healing and self-preservation mechanisms to ensure continuous operation and rapid recovery. For detailed guidance on resilient design patterns, see the Well-Architected Framework's [Reliability](/azure/well-architected/reliability) pillar.
 
- **Adopt serverless architecture.** Use serverless technologies, including platform as a service (PaaS), software as a service (SaaS), and function as a service (FaaS), to reduce server management overhead, automatically scale with demand, and improve availability. This approach supports the Cloud Adoption Framework emphasis on modernizing workloads and optimizing operational efficiency.
 
- **Use microservices and containerization.** Implement microservices and containerization to avoid monolithic applications by breaking them down into smaller, independent services that you can deploy and scale independently. This approach aligns with Cloud Adoption Framework principles of agility and scalability in cloud environments.
 
- **Decouple services.** Strategically isolate services from each other to reduce the blast radius of incidents. This strategy helps to ensure that failures in one component don't affect the entire system. It supports the Cloud Adoption Framework governance model by promoting robust service boundaries and operational resilience.
 
- **Enable automatic scaling.** Ensure that your application architecture supports automatic scaling to handle varying loads so that it can maintain availability during traffic spikes. This practice aligns with Cloud Adoption Framework guidance on creating scalable and responsive cloud environments and can help you keep costs manageable and predictable.

- **Implement fault isolation.** Design your application to isolate failures to individual tasks or functions. Doing so can help prevent widespread outages and enhance resilience. This approach supports the Cloud Adoption Framework focus on creating reliable and fault-tolerant systems.
 
- **Ensure high availability.** Incorporate built-in redundancy and disaster recovery mechanisms to maintain continuous operation. This approach supports Cloud Adoption Framework best practices for high availability and business continuity planning.
 
- **Plan for automatic failover.** Deploy applications across multiple regions to support seamless failover and uninterrupted service. This approach aligns with the Cloud Adoption Framework strategy for geographic redundancy and disaster recovery.

## Prepare for security sustainment

During the Ready phase, preparing for long-term security sustainment involves ensuring that the foundational elements of your estate adhere to security best practices for the initial workloads but are also scalable. Doing so helps you ensure that, as your estate grows and evolves, your security won't be compromised and the management of your security won't become too complex and burdensome. This, in turn, helps you avoid shadow IT behaviors. To that end, during the Ready phase, think about how your business goals for the longer term can be accomplished without major architectural redesigns or major overhauls to operational practices. Even if you choose to establish a much simpler foundation than a landing zone design, ensure that you can transition your foundational design to an enterprise architecture without needing to redeploy major elements of your estate, like networking and critical workloads. Creating a design that can grow as your estate grows, but still remain secure, is instrumental to the success of your cloud journey.

See [Transition an existing Azure environment to the Azure landing zone conceptual architecture](../ready/enterprise-scale/transition.md) for recommendations on moving an existing Azure footprint into a landing zone architecture.

## Next step

> [!div class="nextstepaction"]
> [Perform your cloud adoption with enhanced security](./adopt.md)
