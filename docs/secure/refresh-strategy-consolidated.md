---
title: Integrate security in your cloud adoption strategy
description: Learn how to adopt security best practices in your cloud adoption strategy
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Integrate security in your cloud adoption strategy

## Introduction

Moving your organization into the cloud adds significant complexity to security, and to be successful in the cloud, your security strategy needs to meet modern challenges inherent to cloud computing. In the adoption and operation of a cloud estate, security becomes a necessary consideration in all facets, rather than a separate function that is secondarily involved in certain facets, which can be a common approach for organizations running on-premises technology platforms. As you define your cloud adoption strategy, consider the recommendations provided in this article to ensure that security is an integral piece of the strategy and will be built into your cloud adoption plan as you move forward.

This article is a supporting guide to the [Strategy](../strategy/index.md) methodology, offering areas of security optimization that should be considered as you move through that phase in your journey.

## Security posture mondernization 

The strategy of security posture modernization not only involves the adoption of new technologies and new operational practices, it also normally involves a mindset shift across the organization. New [teams and roles](./refresh-teams-and-roles.md) may need to be filled and existing teams and roles may need to be involved in security in ways that they're unaccustomed to. These changes, which can sometimes be monumental for organizations, can be the source of stress and internal conflicts, so it is important to promote healthy, honest, and blame-free communications across the organization throughout the adoption process.

Refer to the [Define a security strategy](../strategy/define-security-strategy.md) guide for a comprehensive overview of these considerations.

### Adopting Zero Trust as a strategy

Adopting [Zero Trust](/security/zero-trust/zero-trust-overview) as a strategy will help start your cloud journey off with a modern approach to security in place. The Zero Trust approach is founded on three principles:

- **Verify explicitly:** Always authenticate and authorize based on all available data points.

- **Use least privilege:** Limit user access with Just-In-Time and Just-Enough-Access (JIT/JEA), risk-based adaptive policies, and data protection.

- **Assume breach:** Minimize blast radius and segment access. Verify end-to-end encryption and use analytics to get visibility into activities related to your systems, drive threat detection, and improve defenses.

By applying these principles across the cloud adoption process, the transformation to modern security can be a smoother experience for the entire organization.

Microsoft offers a [Zero Trust-based security modernization blueprint](/security/zero-trust/adopt/rapidly-modernize-security-posture) that organizations can use as a guide. Refer to the [Define strategy phase](/security/zero-trust/adopt/rapidly-modernize-security-posture#define-strategy-phase) for strategy recommendations.

## Defining a strategy for incident preparedness and response

Establish a clear vision and well-defined, specific objectives for cloud security readiness, focusing on building security capacity and developing security skills. Align your incident preparedness and response strategy to the overall business strategy to ensure that the business strategy isn't impeded by security. Understand business requirements for reliability and performance to ensure that your strategy can accomodate those requirements while building the necessary technology foundation to prepare for and respond to incidents.

## Defining a strategy for confidentiality

When defining a strategy for adopting confidentiality in an enterprise cloud environment, it’s essential to consider several key points:

- **Prioritize data privacy and protection:** Establish clear business objectives that emphasize the importance of data privacy and protection. This includes compliance with relevant regulations like GDPR, HIPAA, and industry standards.

- **Plan for a risk management strategy:** Identify and assess potential risks to data confidentiality and develop strategies to mitigate these risks.

- **Develop a Data Loss Protection (DLP) strategy:** DLP is a set of tools and processes used to ensure that sensitive data is not lost, misused, or accessed by unauthorized users. In terms of the principle of Confidentiality, this involves defining clear data protection objectives and establishing a framework for implementing robust encryption and access controls. In the strategy phase, DLP is integrated into the overall security vision to ensure that sensitive data is protected from unauthorized access.

## Defining a strategy for integrity

Maintaining data and system integrity requires many of the same strategies as those suggested for confidentiality, like well-designed data protection controls and risk management. These strategies should be augmented with additional considerations for data and system integrity:

- **Prioritize data and system integrity:** Maintaining data and system integrity should be a key tenet in business requirements and objectives. To that end, prioritize security controls and operational practices that support a high level of integrity. In particular, embrace automation through tooling for as much of your data and system integrity management as practical. Automation can be used for many functions related to integrity like:

    - *Policy management*

    - *Data classification and management*

    - *Infrastructure deployments and update management*

## Defining a strategy for availability

Including considerations for availability in your cloud adoption strategy will ensure that you are well prepared for a reliable and resilient cloud estate and that you're able to be confident in meeting your business requirements as they relate to availability.

Availability requirements and objectives span across the entire cloud estate, including all business functions and workloads and the underlying cloud platform. Ensure that as you develop your cloud adoption strategy, you start with high-level goals for determining the criticality of various aspects of your cloud estate and begin discussions amongst stakeholders on what the proper level of availbility must be set at while balancing cost and performance requirements and objectives.  This approach will put a structure on your cloud adoption plans that helps you work toward more defined targets as you progress to the next phases in your cloud adoption journey, laying the groundwork for appropriately scoped designs and standards.

## Defining a strategy for security posture sustainment

The journey towards a modern, robust security posture doesn't end with the initial implementation. In order to keep up with new threats, your security practices must be continuously reviewed and refined while maintaining a strict adherence to standards. Sustaining security is an ongoing effort to run day-to-day operations to the expectations your organization has set for itself while preparing for emerging threats and technological changes. Adoption of this principle will codify your continuous improvement approach, providing security teams with their guiding standards to maintain vigilant security practices and giving stakeholders peace of mind that security remains a cornerstone tenet of the cloud adoption journey. 

Developing a sustainment strategy focuses on learning about how your overall security strategy performs in the real world and applying learnings to evolve it continuously. A sustainment strategy should incorporate long term business goals to ensure that long term security goals are aligned. With these goals understood, the sustainment strategy defines how the security posture must evolve to stay in alignment.

## Example strategy

Your organization should develop your cloud adoption strategy in the way that works best for the organization, but the following example shows how you might incorporate the guidance offered in this article into a narrative artifact, like a Word document.

### Motivations

The motivation for moving to the cloud is to modernize our line-of-business (LOB) workload and take advantage of Microsoft's worldwide cloud infrastructure to efficiently scale out across the globe as our customer base grows.

**Business considerations:**

- *Board and senior leadership buy-in:* We must present an executive summary of our cloud adoption plan with financial projections to the board for approval. The executive summary must be co-developed by senior leadership to ensure that the leadership team is in agreement about the high level plan.

**Security considerations:**

- *Technical readiness:* Our IT and Security teams will need up-skilling to successfully define our migration plan, and we may need to add new [teams and roles](./refresh-teams-and-roles.md) as we prepare to move into the cloud.

### Business outcome - global reach

We are currently operating only in North America. Our five-year plan is to expand into Europe and Asia. Leveraging Microsoft's global Azure cloud will allow us to build out the necessary infrastructure to deliver our LOB application in Europe and Asia efficiently.

- **Business owner:** COO

- **Technical owner:** CTO

- **Security owner:** CISO

**Business considerations:**

- *Budget forecasting:* As part of developing our cloud migration plan, IT, Security, and Sales must co-develop budget forecasting models with the Finance department to ensure that stakeholders understand the potential costs of expanding into Europe and Asia.

**Security considerations:**

- *Increased attack surfaces:* Expanding across the globe will dramatically increase our attack surfaces by having publicly exposed systems in mulitple regions. We need to rapidly [modernize our security posture](#security-posture-mondernization). We will follow the [Zero Trust guidance](/security/zero-trust/zero-trust-ramp-overview) to ensure we follow best practices.

- *Cloud-focused threats:* Our move to the cloud will bring new threats that we haven't been exposed to. These threats are not limited to malicious attacks on our systems. The cloud provider is also a major target for threats and incidents affecting the provider can have downstream effects on our systems or business. We need to review our [incident preparedness and response](#defining-a-strategy-for-incident-preparedness-and-response) processes and incorporate necessary improvements as part of our plan.

### Business outcome - data innovation

As our global expansion progresses, our data estate will grow exponentially and handling that data will be unsustainable without adopting cloud-scale data and analytics technologies.

- **Business owner:** CEO

- **Technical owner:** CTO

- **Security owner:** CISO

**Business considerations:**

- *Local compliance requirements:* We must work with experts in local compliance regulations to ensure that the business is ready to support the technical teams for maintaining compliance. This may mean setting up business entities in certain geographies or using sovereign clouds in countries like Germany and China.

**Security considerations:**

- *Data confidentiality and integrity at scale:* We must review and uplift our [confidentialiy](#defining-a-strategy-for-confidentiality) and [integrity](#defining-a-strategy-for-integrity) strategies and mechanisms to ensure that as we adopt new technologies and move into new geographies, we do not put our data or our customers' data at risk of corruption, breach, or loss, and that we comply with regulatory frameworks by default.

- *Zero Trust access and authorization strategy:* We must adopt the Zero Trust approach to ensure that our access and authorization strategy meets modern best practices and is manageable as we expand globally.

### Business outcome - performance and reliability

As we expand across the globe, our LOB workload must maintain the high performance and zero-downtime availability our customer's rely on.

- **Business owner:** COO
 
- **Technical owner:** CTO

- **Security owner:** CISO

**Business considerations:**

- *Maintaining performance and reliability throughout the migration:** Our customers have high expectations for our LOB application and we cannot afford to suffer reputational and financial damage if application experiences downtime or prolonged degraded service over the course of the migration to the cloud. Involving our Microsoft support team to help design the migration plan and engage on the migration will minimize the risks of downtime or degraded service.

**Security considerations:**

- We must develop secure design patterns to ensure that we can deploy identical infrastructure packages in each new region we expand into efficiently and secure at deployment time. Our [availability](#defining-a-strategy-for-availability) strategy should consider trade-offs that we'll need to make to ensure security isn't compromised by our performance designs and our performance targets are not affected by our security measures.
    
    - We must include system [integrity](#defining-a-strategy-for-integrity) processes and mechanisms in our design patterns to ensure that our systems are protected by default as we deploy our workload in new geographies.

## Next step

> [!div class="nextstepaction"]
> [Plan for a secure cloud adoption](./refresh-plan-consolidated.md)