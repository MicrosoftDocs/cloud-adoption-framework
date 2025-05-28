---
title: Integrate Security Into Your Cloud Adoption Strategy
description: Learn how to integrate security best practices into your cloud adoption strategy. View an example strategy document. 
author: claytonsiemens77
ms.author: pnp
ms.date: 11/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Integrate security into your cloud adoption strategy

Moving your organization to the cloud adds significant complexity to security. To be successful in the cloud, your security strategy needs to meet modern challenges that are inherent to cloud computing. In the adoption and operation of a cloud estate, security becomes a necessary consideration in all facets of the organization. It's not a separate function that's secondarily applied to certain facets, as can be common for organizations that run on-premises technology platforms. When you define your cloud adoption strategy, consider the recommendations provided in this article to ensure that security is an integral part of the strategy and will be built into your cloud adoption plan as you move forward.

:::image type="content" source="./media/caf-secure-strategy.png" alt-text="Diagram showing the methodologies involved in cloud adoption. The diagram has boxes for each phase: teams and roles, strategy, plan, ready, adopt, govern, and manage. The box for this article is highlighted." lightbox="./media/caf-secure-strategy.png" border="false":::

This article is a supporting guide to the [Strategy](../strategy/index.md) methodology. It describes areas of security optimization that you should  consider as you move through that phase in your journey.

## Security posture modernization

The strategy of security posture modernization doesn't just involve the adoption of new technologies and new operational practices. It typically also  involves a mindset shift across the organization. New [teams and roles](./teams-roles.md) might need to be filled, and existing teams and roles might need to be involved in security in ways that they're unaccustomed to. These changes, which can sometimes be monumental for organizations, can be the source of stress and internal conflicts, so it's important to promote healthy, honest, and blame-free communications across the organization throughout the adoption process.

See the [Define a security strategy](../strategy/define-security-strategy.md) guide for a comprehensive overview of these considerations.

### Adopting Zero Trust as a strategy

Adopting [Zero Trust](/security/zero-trust/zero-trust-overview) as a strategy helps you start your cloud journey with a modern approach to security in place. The Zero Trust approach is founded on three principles:

- **Verify explicitly.** Always authenticate and authorize based on all available data points.

- **Use least privilege.** Limit user access with Just-In-Time and Just-Enough-Access (JIT/JEA), risk-based adaptive policies, and data protection.

- **Assume breach.** Minimize the blast radius and segment access. Verify end-to-end encryption, and use analytics to get visibility into activities related to your systems, drive threat detection, and improve defenses.

If you apply these principles across the cloud adoption process, the transformation to modern security can be a smoother experience for the entire organization.

Microsoft provides a [Zero Trust-based security modernization blueprint](/security/zero-trust/adopt/rapidly-modernize-security-posture) that organizations can use as a guide. Refer to the [Define strategy phase](/security/zero-trust/adopt/rapidly-modernize-security-posture#define-strategy-phase) for strategy recommendations.

## Defining a strategy for incident preparedness and response

Establish a clear vision and well-defined, specific objectives for cloud security readiness. Focus on creating security capacity and developing security skills. Align your incident preparedness and response strategy to the overall business strategy to ensure that the business strategy isn't impeded by security. Understand business requirements for reliability and performance to ensure that your strategy can accommodate those requirements while creating the necessary technology foundation to prepare for and respond to incidents.

## Defining a strategy for confidentiality

When you define a strategy for adopting confidentiality in an enterprise cloud environment, you need to consider several key points:

- **Prioritize data privacy and protection.** Establish clear business objectives that emphasize the importance of data privacy and protection. These objectives include compliance with relevant regulations like GDPR, HIPAA, and industry standards.

- **Plan for a risk management strategy.** Identify and assess potential risks to data confidentiality and develop strategies to mitigate these risks.

- **Develop a data loss protection (DLP) strategy.** DLP is a set of tools and processes that helps ensure that sensitive data isn't lost, misused, or accessed by unauthorized users. In terms of the principle of confidentiality, it involves defining clear data protection objectives and establishing a framework for implementing robust encryption and access controls. During the strategy phase, DLP is integrated into the overall security vision to help ensure that sensitive data is protected from unauthorized access.

## Defining a strategy for integrity

Maintaining data and system integrity requires many of the same strategies as those suggested for confidentiality, like well-designed data protection controls and risk management. These strategies should be augmented with additional considerations for data and system integrity:

- **Prioritize data and system integrity.** Maintaining data and system integrity should be a key tenet in business requirements and objectives. To that end, prioritize security controls and operational practices that support a high level of integrity. In particular, use automation through tooling for as much of your data and system integrity management as is practical. Automation can be used for many functions that are related to integrity, like:

    - *Policy management.*

    - *Data classification and management.*

    - *Infrastructure deployments and update management.*

## Defining a strategy for availability

Including considerations for availability in your cloud adoption strategy helps ensure that you're prepared to implement a reliable and resilient cloud estate and that you can be confident about meeting your business requirements as they relate to availability.

Availability requirements and objectives span across the entire cloud estate, including all business functions and workloads and the underlying cloud platform. Ensure that, as you develop your cloud adoption strategy, you start with high-level goals for determining the criticality of various aspects of your cloud estate and begin discussions among stakeholders about what the proper level of availability must be, while still balancing cost and performance requirements and objectives. This approach helps structure your cloud adoption plans so that you can work toward more defined targets as you progress to the next phases in your cloud adoption journey, laying the groundwork for appropriately scoped designs and standards.

## Defining a strategy for sustaining security posture

The journey toward a modern, robust security posture doesn't end with the initial implementation. To keep up with new threats, you need to continuously review and refine your security practices while maintaining strict adherence to standards. Sustaining security is an ongoing effort of running day-to-day operations that meet the expectations your organization has set for itself while preparing for emerging threats and technological changes. Adoption of this principle codifies your continuous improvement approach. It provides security teams with guiding standards for maintaining vigilant security practices and gives stakeholders confidence that security remains a cornerstone tenet of the cloud adoption journey. 

When you develop a sustainment strategy, you focus on learning how your overall security strategy performs in the real world and on applying lessons to evolve it continuously. A sustainment strategy should incorporate long-term business goals to ensure that long-term security goals are aligned. When these goals are taken into account, the sustainment strategy defines how the security posture must evolve to stay in alignment.

## Example strategy

Your organization should develop your cloud adoption strategy in the way that works best for the organization. The following example shows how you might incorporate the guidance offered in this article into a narrative artifact, like a Word document.

### Motivations

The motivation for moving to the cloud is to modernize our line-of-business (LOB) workload and take advantage of the Microsoft worldwide cloud infrastructure to efficiently scale out across the globe as our customer base grows.

**Business considerations:**

- *Board and senior leadership buy-in.* We must present an executive summary of our cloud adoption plan, with financial projections, to the board for approval. The executive summary must be co-developed by senior leadership to ensure that the leadership team is in agreement about the high-level plan.

**Security considerations:**

- *Technical readiness.* Our IT and Security teams will need upskilling to successfully define our migration plan. We might need to add new [teams and roles](./teams-roles.md) as we prepare to move to the cloud.

### Business outcome: Global reach

We currently operate only in North America. Our five-year plan is to expand into Europe and Asia. Taking advantage of the Microsoft global Azure cloud will allow us to build out the necessary infrastructure to efficiently deliver our LOB application in Europe and Asia.

- **Business owner:** COO

- **Technical owner:** CTO

- **Security owner:** CISO

**Business considerations:**

- *Budget forecasting.* As part of developing our cloud migration plan, IT, Security, and Sales must co-develop budget forecasting models with the Finance department to ensure that stakeholders understand the potential costs of expanding into Europe and Asia.

**Security considerations:**

- *Increased attack surfaces.* Expanding across the globe will dramatically increase our attack surfaces by placing publicly exposed systems in multiple regions. We need to rapidly [modernize our security posture](#security-posture-modernization). We'll follow the [Zero Trust guidance](/security/zero-trust/zero-trust-ramp-overview) to ensure that we follow best practices.

- *Cloud-focused threats.* Our move to the cloud will bring new threats that we haven't been exposed to. These threats aren't limited to malicious attacks on our systems. The cloud provider is also a major target for threats, and incidents that affect the provider can have downstream effects on our systems or business. We need to review our [incident preparedness and response](#defining-a-strategy-for-incident-preparedness-and-response) processes and incorporate necessary improvements as part of our plan.

### Business outcome: Data innovation

As our global expansion progresses, our data estate will grow exponentially. Handling that data will be unsustainable unless we adopt cloud-scale data and analytics technologies.

- **Business owner:** CEO

- **Technical owner:** CTO

- **Security owner:** CISO

**Business considerations:**

- *Local compliance requirements.* We must work with experts on local compliance regulations to ensure that the business is ready to support the technical teams with maintaining compliance. This might mean setting up business entities in certain geographies or using sovereign clouds in countries like Germany and China.

**Security considerations:**

- *Data confidentiality and integrity at scale.* We must review and improve our [confidentiality](#defining-a-strategy-for-confidentiality) and [integrity](#defining-a-strategy-for-integrity) strategies and mechanisms to ensure that, as we adopt new technologies and move into new geographies, we don't put our data or our customers' data at risk of corruption, breach, or loss, and that we comply with regulatory frameworks by default.

- *Zero Trust access and authorization strategy.* We must adopt the Zero Trust approach to ensure that our access and authorization strategy meets modern best practices and is manageable as we expand globally.

### Business outcome: Performance and reliability

As we expand across the globe, our LOB workload must maintain the high performance and zero-downtime availability that our customers rely on.

- **Business owner:** COO
 
- **Technical owner:** CTO

- **Security owner:** CISO

**Business considerations:**

- *Maintaining performance and reliability throughout the migration.* Our customers have high expectations for our LOB application. We can't afford to suffer reputational and financial damage if the application experiences downtime or prolonged degraded service over the course of the migration to the cloud. Engaging our Microsoft support team to help design the migration plan and be involved in the migration will minimize the risks of downtime or degraded service.

**Security considerations:**

- We must develop secure design patterns to ensure that we can efficiently and securely deploy identical infrastructure packages in each new region we expand into. Our [availability](#defining-a-strategy-for-availability) strategy should consider tradeoffs that we'll need to make to ensure that security isn't compromised by our performance designs and that our performance targets aren't affected by our security measures.
    
    - We must include system [integrity](#defining-a-strategy-for-integrity) processes and mechanisms in our design patterns to ensure that our systems are protected by default when we deploy our workload in new geographies.

## Next step

> [!div class="nextstepaction"]
> [Plan for a secure cloud adoption](./plan.md)
