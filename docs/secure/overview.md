---
title: Secure Overview
description: Learn how to establish, maintain, and automate cloud security in Azure by using the Cloud Adoption Framework for Azure Secure methodology to provide a structured approach.
author: claytonsiemens77
ms.author: pnp
ms.date: 10/22/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
ms.update-cycle: 1095-days
---

# Secure overview

The Cloud Adoption Framework for Azure Secure methodology provides a structured approach for securing your Azure cloud estate.

The guidance in this series of articles provides recommendations relevant to all methodologies within the Cloud Adoption Framework because security should be an integral part of every phase of your cloud adoption journey. Therefore, you can find articles aligned with each methodology that provide security recommendations for you to consider as you progress through each phase of your cloud adoption journey.

:::image type="content" source="./media/caf-secure-overview.png" alt-text="Diagram showing the methodologies involved in cloud adoption. The diagram has boxes for each phase: teams and roles, strategy, plan, ready, adopt, govern, and manage." lightbox="./media/caf-secure-overview.png" border="false":::

All of the recommendations in this guidance adhere to the [Zero Trust principles](/security/zero-trust/zero-trust-overview) of assume compromise (or assume breach), least privilege, and explicit verification of trust that should guide your security strategy, architecture, and implementation.

## Holistic security guidance

Security is a complex and challenging discipline that you need to consider in nearly all aspects of your cloud and technology environments. Consider the following key points:

- **Anything is a potential target or attack vector:** In today's world, attackers can exploit any weaknesses in an organization's people, processes, and technologies to accomplish their malicious goals.

- **Security is a team sport:** To defend against these attacks, a coordinated approach is required across business, technology, and security teams. Each team must contribute to security efforts and collaborate effectively. For information about the various roles required to secure Azure resources, see [Teams and roles](./teams-roles.md).

This Cloud Adoption Framework Secure guidance is one component of a larger holistic set of Microsoft security guidance designed to help various teams understand and perform their security responsibilities. The complete set includes the following guidance:

- **The Cloud Adoption Framework Secure methodology** provides security guidance for teams that manage the technology infrastructure that supports all the workload development and operations hosted on Azure.

- **[Azure Well-Architected Framework security guidance](/azure/well-architected/security/)** provides guidance for individual workload owners about how to apply security best practices to application development and DevOps and DevSecOps processes. Microsoft provides guidance that complements this documentation about how to apply [security practices](https://www.microsoft.com/securityengineering/sdl/practices) and DevSecOps controls in a security development lifecycle.

- **[Microsoft Cloud Security Benchmark](/security/benchmark/azure/)** provides best practice guidance for stakeholders to ensure robust cloud security. This guidance includes security baselines that describe the available security features and recommended optimal configurations for Azure services.

- **[Zero Trust guidance](/security/zero-trust/)** provides guidance for security teams to implement technical capabilities to support a Zero Trust modernization initiative.

Each article covers several topics related to its aligned methodology:

- Security posture modernization
- Incident preparation and response
- The Confidentiality, Integrity, and Availability (CIA) Triad
- Security posture sustainment

## Security posture modernization

Throughout your cloud adoption journey, look for opportunities to enhance your overall security posture through modernization. The guidance in this methodology is aligned with the [Microsoft Zero Trust adoption framework](/security/zero-trust/adopt/zero-trust-adoption-overview). This framework provides a detailed, step-by-step approach to modernizing your security posture. As you review the recommendations for each phase of the Cloud Adoption Framework methodology, enhance them by using the guidance provided in the Zero Trust adoption framework.

## Incident preparation and response

Incident preparation and response are cornerstone elements of your overall security posture. Your ability to prepare for and respond to incidents can significantly affect your success in operating within the cloud. Well-designed preparation mechanisms and operational practices enable quicker threat detection and help minimize the blast radius of incidents. This approach facilitates faster recovery. Similarly, well-structured response mechanisms and operational practices ensure efficient navigation through recovery activities and provide clear opportunities for continuous improvement throughout the process. By focusing on these elements, you can enhance your overall security strategy, which ensures resilience and operational continuity in the cloud.

## The CIA Triad

The CIA Triad is a fundamental model in information security that represents three core principles. These principles are confidentiality, integrity, and availability.

- **Confidentiality** ensures that only authorized individuals can access sensitive information. This policy includes measures like encryption and access controls to protect data from unauthorized access.

- **Integrity** maintains the accuracy and completeness of data. This principle means protecting data from alterations or tampering by unauthorized users, which ensures that the information remains reliable.

- **Availability** ensures that information and resources are accessible to authorized users when needed. This task includes maintaining systems and networks to prevent downtime and ensure continuous access to data.

Adopt the CIA Triad to ensure that your business technology remains reliable and secure. Use it to enforce reliability and security in your operations through well-defined, strictly followed, and proven practices. Some ways that the triad principles can help ensure security and reliability are:

- **Data protection:** Protect sensitive data from breaches by taking advantage of the CIA Triad, which ensures privacy and compliance with regulations.

- **Business continuity:** Ensure data integrity and availability to maintain business operations and avoid downtime.

- **Customer trust:** Implement the CIA Triad to build trust with customers and stakeholders by demonstrating a commitment to data security.

Each methodology-aligned article provides recommendations for the principles of the CIA Triad. This approach ensures that you can address confidentiality, integrity, and availability. This guidance helps you thoroughly consider these aspects in every phase of your cloud adoption journey.

## Security posture sustainment

Continuous improvement is crucial for maintaining a robust security posture in the cloud because cyber threats continuously evolve and become more sophisticated. To protect against these ever-changing risks, ensure ongoing enhancements. The guidance in these sections can help you set up your organization for long-term success by identifying opportunities for continuous improvement. Focus on these strategies as you establish and evolve your cloud environment over time.

## Cloud security checklist

Use the cloud security checklist to see all tasks for each cloud security step. Quickly navigate to the guidance that you need.

| &nbsp; | Cloud security step | Cloud security tasks |
|---|---|---|
|&#9744; | [Understand security teams and roles](./teams-roles.md). | &#9744; [Understand the role of the cloud service provider](./teams-roles.md#cloud-service-provider). <br> &#9744; [Understand the roles of Infrastructure and Platform teams](./teams-roles.md#infrastructureplatform-teams-architecture-engineering-and-operations). <br> &#9744; [Understand the roles of Security architecture, engineering, posture management teams](./teams-roles.md#security-architecture-engineering-and-posture-management-teams). <br> &#9744; [Understand the roles of the Security Operations (SecOps and SOC) teams](./teams-roles.md#security-operations-secopssoc). <br> &#9744; [Understand the roles of Security Governance, Risk, and Compliance (GRC) teams](./teams-roles.md#security-governance-risk-and-compliance). <br> &#9744; [Learn about security education and policy](./teams-roles.md#security-education-and-policy).
|&#9744; | [Integrate security into your cloud adoption strategy](./strategy.md). | &#9744; [Security posture modernization strategy](./strategy.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response strategy](./strategy.md#defining-a-strategy-for-incident-preparedness-and-response). <br> &#9744; [Confidentiality strategy](./strategy.md#defining-a-strategy-for-confidentiality). <br> &#9744; [Integrity strategy](./strategy.md#defining-a-strategy-for-integrity). <br> &#9744; [Availability strategy](./strategy.md#defining-a-strategy-for-availability). <br> &#9744; [Security posture sustainment strategy](./strategy.md#defining-a-strategy-for-sustaining-security-posture) |
|&#9744; | [Plan for a secure cloud adoption](./plan.md). | &#9744; [Plan for landing zone adoption](./plan.md#plan-for-landing-zone-adoption). <br> &#9744; [Security posture modernization planning](./plan.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response planning](./plan.md#incident-preparedness-and-response). <br> &#9744; [Confidentiality planning](./plan.md#plan-for-confidentiality). <br> &#9744; [Integrity planning](./plan.md#plan-for-integrity) <br> &#9744; [Availability planning](./plan.md#plan-for-availability) <br> &#9744; [Security posture sustainment planning](./plan.md#plan-for-security-sustainment) |
|&#9744; | [Ready your secure cloud estate](./ready.md). | &#9744; [Ready for security posture modernization](./ready.md#security-posture-modernization). <br> &#9744; [Ready for incident preparedness and response](./ready.md#prepare-for-incident-preparedness-and-response). <br> &#9744; [Ready for confidentiality](./ready.md#prepare-for-confidentiality). <br> &#9744; [Ready for integrity](./ready.md#prepare-for-integrity). <br> &#9744; [Ready for availability](./ready.md#prepare-for-availability) <br> &#9744; [Ready for security posture sustainment](./ready.md#prepare-for-security-sustainment) |
|&#9744; | [Perform your cloud adoption securely](./adopt.md). | &#9744; [Security posture modernization adoption](./adopt.md#security-posture-modernization-adoption). <br> &#9744; [Adopt incident preparedness and response](./adopt.md#incident-preparedness-and-response-adoption). <br> &#9744; [Adopt confidentiality](./adopt.md#adopt-the-principle-of-confidentiality). <br> &#9744; [Adopt integrity](./adopt.md#adopt-the-principle-of-integrity). <br> &#9744; [Adopt availability](./adopt.md#adopt-the-principle-of-availability). <br> &#9744; [Adopt security posture sustainment](./adopt.md#adopt-security-sustainment) |
|&#9744; | [Securely govern your cloud estate](./govern.md). | &#9744; [Security posture modernization](./govern.md#security-posture-modernization).  <br> &#9744; [Incident preparedness and response governance](./govern.md#incident-preparedness-and-response) <br> &#9744; [Confidentiality governance](./govern.md#confidentiality-governance). <br> &#9744; [Integrity governance](./govern.md#integrity-governance). <br> &#9744; [Availability governance](./govern.md#availability-governance). <br> &#9744; [Sustaining security governance](./govern.md#sustaining-secure-governance) |
|&#9744; | [Securely manage your cloud estate](./manage.md). | &#9744; [Security posture modernization](./manage.md#security-posture-modernization).  <br> &#9744; [Managing incident preparedness and response](./manage.md#managing-incident-preparedness-and-response) <br> &#9744; [Managing confidentiality](./manage.md#managing-confidentiality). <br> &#9744; [Managing integrity](./manage.md#managing-integrity). <br> &#9744; [Managing availability](./manage.md#managing-availability). <br> &#9744; [Managing security sustainment](./manage.md#managing-security-sustainment) |


## Next step

> [!div class="nextstepaction"]
> [Security teams, roles, and functions](./teams-roles.md)
