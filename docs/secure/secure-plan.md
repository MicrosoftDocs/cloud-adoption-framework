---
title: Plan for a Secure Cloud Adoption
description: Learn how to adopt security best practices in your cloud adoption plan to ensure a secure and compliant cloud environment. 
author: claytonsiemens77
ms.author: csiemens
ms.date: 10/23/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Plan for a secure cloud adoption

Developing a cloud adoption plan can be difficult and often have many technical challenges. To ensure success, you must carefully plan each step of your cloud adoption process, specifically when you update legacy workloads for cloud infrastructure. You need to integrate security considerations into every phase of your adoption plan to build a secure cloud estate from the ground up. This approach guarantees that your new cloud environment is secure from the start.

When you make decisions about your migration or implementation, design for the highest security strategy stance that's feasible for your business. Prioritize security over performance and cost efficiency when you start your designs. This approach ensures that you don't introduce risks that could require you to redesign workloads later. The guidance provided in this article can help you develop your cloud adoption plan that has security as a fundamental principle.

This article is a supporting guide to the [Plan](../plan/index.md) methodology. It provides areas of security optimization for you to consider as you move through that phase in your journey.

## Plan for landing zone adoption

To build out your cloud estate foundational elements, use the [landing zone](../ready/landing-zone/index.md) approach. This recommendation applies specifically to enterprise and large organizations. Smaller organizations and start-ups might not benefit from adopting this approach at the beginning of their cloud journey. However, it's important to understand the [design areas](../ready/landing-zone/design-areas.md) because you need to include these areas in your cloud adoption plan, even if you don't create a full landing zone.

The Azure landing zone approach establishes a solid foundation for your cloud estate. This foundation ensures a manageable environment that you can secure according to best practices.

- *Landing Zones:* A landing zone is a preconfigured, secure, and scalable environment in the cloud that serves as a foundation for your workloads. It includes network topology, identity management, security, and governance components.

- *Benefits:* Landing zones can help you standardize cloud environments. This approach ensures consistency and compliance with security policies. Also, they facilitate easier management and scalability.

## Security posture modernization

When you develop a security modernization plan, it's essential to focus on adopting new technologies and operational practices. It's equally important to ensure that you align these security measures with your business objectives.

### Plan for Zero Trust adoption

As you develop your adoption plan, incorporate the principles of Zero Trust across your plan to help structure the phases and steps that teams throughout the organization are responsible for and how they can accomplish their activities.

The Microsoft Zero Trust approach provides guidance for seven technology pillars, including deployment and configuration recommendations. As you build your plan, explore each pillar to ensure comprehensive coverage of these areas.

#### Zero Trust technology pillars

- **[Identity](/security/zero-trust/deploy/identity):** Guidance for verifying identities with strong authentication and controlling access under the principle of least privilege.

- **[Endpoints](/security/zero-trust/deploy/endpoints):** Guidance for securing all endpoints, including devices and apps, that interact with your data. This guidance applies regardless of where the endpoints connect from and how they connect.

- **[Data](/security/zero-trust/deploy/data):** Guidance for securing all data through a defense in depth approach.

- **[Apps](/security/zero-trust/deploy/applications):** Guidance for securing the cloud apps and services that you consume.

- **[Infrastructure](/security/zero-trust/deploy/infrastructure):** Guidance for securing cloud infrastructure through strict policies and enforcement strategies.

- **[Network](/security/zero-trust/deploy/networks):** Guidance for securing your cloud network through segmentation, traffic inspection, and end-to-end encryption.

- **[Visibility, automation, and orchestration](/security/zero-trust/deploy/visibility-automation-orchestration):** Guidance for operational policies and practices that enforce Zero Trust principles.

### Business alignment

Alignment between technology and business stakeholders is critical to the success of your security modernization plan. As such, you must approach the plan development as a collaborative process that's accomplished through negotiations between stakeholders to find the right way to adapt processes and policies. Business stakeholders must understand how the modernization plan affects business functions. Technology stakeholders must know where to make concessions to keep critical business functions secure and intact.

## Incident preparedness and response

- **Plan for preparedness:** Plan for incident preparation by evaluating vulnerability management solutions, threat and incident detection systems, and robust infrastructure monitoring solutions. Plan for infrastructure hardening to reduce attack surfaces.

- **Plan for incident response:** Build a robust incident response plan to ensure cloud security. In the Plan phase, start drafting your incident response plan by identifying the roles and key phases such as investigation, mitigation, and communications. These roles and key phases are detailed as you expand your cloud estate.

## Plan for confidentiality

- **Data loss protection:** To ensure that organizational data confidentiality is established across the enterprise, it's crucial to meticulously plan specific data loss prevention policies and procedures. This process includes identifying sensitive data, determining how to protect the data, and planning for the deployment of encryption technologies and secure access controls.

- **Include data protection requirements in your cloud migration or development plans:**

  - *Data classification:* Identify and classify data based on sensitivity and regulatory requirements. This process helps you apply appropriate security measures.

  - *Encryption:* Ensure that data is encrypted at rest and in transit. Use strong encryption standards to protect sensitive information.

  - *Access controls:* Implement strict access controls to ensure that only authorized users can access sensitive data. Use multifactor authentication and role-based access control. Follow the principle of Zero Trust, which includes Verify Explicitly, and always authenticating and authorizing based on all available data points. These data points include user identity, location, device health, service or workload, data classification, and anomalies.

## Plan for integrity

In addition to the measures recommended for confidentiality, consider implementing specific data and system integrity measures.

- **Plan for data and system integrity observability and governance:** In your cloud adoption or development plans, include plans to monitor data and systems for unauthorized changes and policies for data hygiene.

- **Plan for integrity incidents:** In your incident response plan, include considerations for integrity. These considerations should address unauthorized changes to data or systems and how to remediate invalid or corrupted data that's discovered through your monitoring and data hygiene practices.

## Plan for availability

Your cloud adoption plan should address availability by adopting standards for architecture design and operations. These standards will guide the implementation. In further phases, they will provide a blueprint for achieving availability requirements. Consider the following recommendations as you build out your cloud adoption plan.

- **Standardize infrastructure and application design patterns:** Standardize infrastructure and application design patterns to help ensure that your workloads are reliable. Avoid unnecessary complexity to make designs repeatable and to discourage shadow IT behaviors. Follow best practices for [highly available infrastructure](/azure/well-architected/reliability/redundancy) and [resilient applications](/azure/well-architected/reliability/self-preservation) as you define your design standards.

- **Standardize development tools and practices:** Develop well-defined and enforceable [standards for your development tools and practices](/azure/well-architected/operational-excellence/formalize-development-practices). This approach helps ensure that your deployments adhere to the principles of the CIA Triad and incorporates best practices for [safe deployments](/azure/well-architected/operational-excellence/safe-deployments).

- **Standardize operational tools and practices:** Depend on well-defined and strictly enforced standards for operators to follow in order to maintain confidentiality, integrity, and availability. Follow standards consistently and train on them routinely to ensure that your systems are resilient to attacks and can respond efficiently to incidents.

## Adopt sustainment

For the long-term sustainment of your security posture, adopt a mindset of continuous improvement across the organization. This approach includes not only adhering to operational standards in everyday practices but also actively seeking opportunities for enhancement. Regularly review your standards and policies, and implement a training program that fosters continuous improvement mindset.

In order to plan your security baseline, you must first understand your current security posture to establish your baseline and find areas for improvement. Use an automated tool like [Microsoft Secure Score](/defender-xdr/microsoft-secure-score-improvement-actions) to establish your baseline quickly and gain insights into areas for improvement.

## Next step

> [!div class="nextstepaction"]
> [Ready your secure cloud estate](./secure-ready.md)
