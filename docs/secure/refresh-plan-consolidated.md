---
title: Plan for a secure cloud adoption
description: Learn how to adopt security best practices in your cloud adoption plan
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Plan for a secure cloud adoption

## Introduction

Developing a cloud adoption plan is a complex undertaking, often with many technical challenges that need to be carefully strategized to ensure success, like modernizing legacy workloads to run on cloud infrastructure. It is critical that security considerations are integrated into every phase of the adoption plan to ensure that you're new cloud estate is built securely from the ground up. When making decisions about your migration or implementation default to designing for the highest security strategy stance allowable for your business. It is best to start your designs with security taking precedence over performance and cost efficiency to ensure that you're not introducing risks in your design that will have to be dealt with later, which could mean redesigning workloads. The guidance provided in this article is meant to help you develop your cloud adoption plan with security as a cornerstone tenet.

This article is a supporting guide to the [Plan](../plan) methodology, offering areas of security optimization that should be considered as you move through that phase in your journey.

## Plan for landing zone adoption

Microsoft recommends using the [landing zone](../ready/landing-zone/) approach to building out your cloud estate foundational elements. This is especially true for enterprise and large organizations. Smaller organizations and start-ups may not benefit from adopting this approach at the beginning of their cloud journey, but its important to understand the [design areas](../ready/landing-zone/design-areas.md) as you will need to include these areas in your cloud adoption plan whether you build a full-blown landing zone or not.

The Azure landing zone approach will provide you a well-designed foundation for your cloud estate, setting you up for a manageable environment that can be secured according to best practices.

- *Landing Zones:* A landing zone is a pre-configured, secure, and scalable environment in the cloud that serves as a foundation for your workloads. It includes network topology, identity management, security, and governance components.
    
    - *Benefits:* Landing zones help standardize cloud environments, ensuring consistency and compliance with security policies. They also facilitate easier management and scalability.

## Security posture modernization

Building a security modernization plan focuses primarily on the adoption of new technologies and new operational practices, but business alignment is an equally important aspect as well.

### Plan for Zero Trust adoption

As you develop your adoption plan, incorporate the prinicples of Zero Trust across the breadth of the plan to help structure the phases and steps that teams throughout the organization will be responsible for and how their activities will be accomplished.

The Microsoft Zero Trust approach provides guidance for seven technology pillars with deployment and configuration recommendations. Explore each pillar as you bild your plan to ensure that these areas are covered thoroughly.

#### Zero Trust technology pillars

- **[Identity](/security/zero-trust/deploy/identity):** Guidance for verifying identies with strong authentication and controlling access under the principle of least privilege.

- **[Endpoints](/security/zero-trust/deploy/endpoints):** Guidance for securing all endpoints (devices and apps) that interact with your data, regardless of where they connect from and how they connect.

- **[Data](/security/zero-trust/deploy/data):** Guidance for securing all data through a defense in depth approach.

- **[Apps](/security/zero-trust/deploy/applications):** Guidance for securing the cloud apps and services that you consume.

- **[Infrastructure](/security/zero-trust/deploy/infrastructure):** Guidance for securing cloud infrastructure through strict policies and enforcement strategies.

- **[Network](/security/zero-trust/deploy/networks):** Guidance for securing your cloud network through segmentation, traffic inspection, and end-to-end encryption.

- **[Visibility, automation, and orchestration](/security/zero-trust/deploy/visibility-automation-orchestration):** Guidance for operational policies and practices that enforce the Zero Trust principles.

### Business alignment

Alignment between technology and business stakeholders is critical to the success of your security modernization plan. As such, the plan development must be approached as a collaborative process that is accomplished through negotiations between stakeholders to find the right way to adapt processes and policies. Business stakeholders must understand how business functions may be effected by the modernization plan and technology stakeholders must understand where they may need to make concessions to ensure that critical business functions remain intact while being secured.

## Incident preparedness and response

- **Plan for preparedness:** 

Plan for incident preparation by evaluating vulnerability management solutions, threat and incident detection systems and robust infrastructure monitoring solutions. Plan for infrastructure hardening to reduce attack surfaces.

- **Plan for incident response:** 

Building a robust incident response plan is critical for cloud security. In the Plan phase, you should begin drafting your incident response plan by identifying roles that will be involved and key phases like investigation, mitigation, and communications that will be fleshed out as you build out your cloud estate.

## Adopt confidentiality

- **Data Loss Protection**
 
Specific DLP policies and procedures must be well planned to ensure organizational data confidentiality will be instantiated across the enterprise. This includes identifying sensitive data, determining how it will be protected, and planning for the deployment of encryption technologies and secure access controls.

- **Include data protection requirements in your cloud migration or development plans**

    - *Data classification:* Identify and classify data based on sensitivity and regulatory requirements. This helps in applying appropriate security measures.

    - *Encryption:* Ensure that data will be encrypted both at rest and in transit. Use strong encryption standards to protect sensitive information.

    - *Access controls:* Implement strict access controls to ensure that only authorized users can access sensitive data. Use multi-factor authentication (MFA) and role-based access control (RBAC), as well as the principle of Zero Trust, Verify Explicitly, always authenticating and authorizing based on all available data points, including user identity, location, device health, service or workload, data classification, and anomalies.
 
## Adopt integrity

In addition to the measures recommended for confidentiality, consider implementing specific data and system integrity measures.

- **Plan for data and system integrity observability and governance:** 

Include plans to monitor data and systems for unauthorized changes and policies for data hygiene in your cloud adoption or development plans.

- **Plan for integrity incidents:** 

Include considerations for integrity in your incident response plan. These considerations should address unauthorized changes to data or systems and remediating invalid or corrupted data that is discovered through your monitoring and data hygiene practices.

## Adopt availability

Your cloud adoption plan should address availability by adopting standards for architecture design and operations. These standards will guide the implementation and further phases, providing a blueprint for how availability requirements will be achieved. Consider the following recommendations as you build out your cloud adoption plan:

- **Standardize infrastructure and application design patterns:** To help ensure that your workloads are reliable, infrastructure and application design patterns must be standardized. Avoid unnecessary complexity to make designs repeatable and to discourage shadow IT behaviors. Follow best practices for [highly available infrastructure](/azure/well-architected/reliability/redundancy) and [resilient applications](azure/well-architected/reliability/self-preservation) as you define your design standards. 

- **Standardize development tools and practices:** Develop well-defined and enforcable [standards for your development tools and practices](/azure/well-architected/operational-excellence/formalize-development-practices) to help ensure that your deployments adhere to the principles of the CIA Triad, incorporating best practices for [safe deployments](/azure/well-architected/operational-excellence/safe-deployments).

- **Standardize operational tools and practices:** Maintaining confidentialiy, integrity, and availabiilty relies on well-defined and strictly enforced standards for operators to follow. Having standards that are always followed and are routinely trained on will help ensure that your systems are resilient to attacks and that you can respond efficiently to incidents.

## Adopt sustainment

Plan for the long-term sustainment of your security posture by adopting a mindset across the organization of continuous improvement. Sustainment involves not only the everyday practices of adhering to operational standards, but always looking for improvement opportunities. Plan for regulary recurring reviews of your standards and policies and for implementing a training program will help you adopt the mindset of continuous improvement.

- **Security baseline planning:** In order to be able to improve, you must first thoroughly understand your current security posture to establish your baseline and move towards finding areas for improvement. Use an automated tool like [Microsoft's Secure Score](/defender-xdr/microsoft-secure-score-improvement-actions) to establish your baseline quickly while gaining deep insights into areas for improvement.

## Next steps

The [Zero trust framework modernization guide](/security/zero-trust/adopt/rapidly-modernize-security-posture#technical-plans-and-skills-readiness) offers a four-staged approach to defining your baseline and planning your continuous improvement strategies.

