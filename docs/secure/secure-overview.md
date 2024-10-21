---
title: Secure Overview
description: Learn how to establish, maintain, and automate cloud security in Azure by using the Microsoft Cloud Adoption Framework Secure Methodology to provide a structured approach.
author: claytonsiemens77
ms.author: csiemens
ms.date: 10/22/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Secure overview

The Microsoft Cloud Adoption Framework Secure Methodology provides a structured approach for securing your Azure cloud estate.

The guidance in this article applies recommendations that apply to topics across all Cloud Adoption Framework methodologies. Security should be an integral part of every phase of your cloud adoption journey. Therefore, you'll find articles aligned with each methodology that provide security recommendations to consider as you progress through each phase of your cloud adoption journey.

All of the recommendations in this guidance adhere to the [Zero Trust principles](/security/zero-trust/zero-trust-overview) of assume compromise (or assume breach), least privilege, and explicit verification of trust that should guide your security strategy, architecture, and implementation.

## Holistic security guidance

Security is a complex and challenging discipline that you need to consider in nearly all aspects of your cloud and technology environments. This is because:

- **Anything is a potential target or attack vector:** In today’s world, attackers can exploit any weaknesses in an organization’s people, processes, and technologies to accomplish their malicious goals.

- **Security is a team sport:** To defend against these attacks, a coordinated approach is required across business, technology, and security teams. Each team must contribute to security efforts and collaborate effectively. This point is illustrated by the various roles that are required to secure Azure resources described in [Teams and roles](./secure-teams-and-roles.md).

This Cloud Adoption Framework Secure guidance is one component of a larger holistic set of Microsoft security guidance designed to help various teams understand and perform their security responsibilities.  The complete set of guidance includes:

- **Cloud Adoption Framework Secure Methodology** provides security guidance for teams that manage the technology infrastructure that supports all the workload development and operations hosted on Azure.

- **[Azure Well-Architected Framework security guidance](/azure/well-architected/security/)** provides guidance for individual workload owners about how to apply security best practices to application development and DevOps and DevSecOps processes. Microsoft provides guidance on how to apply [security practices](https://www.microsoft.com/securityengineering/sdl/practices) and DevSecOps controls in a security development lifecycle that complements this documentation.

- **[Microsoft Cloud Security Benchmark](/security/benchmark/azure/)** provides  best practice guidance for stakeholders to ensure robust cloud security. This guidance includes security baselines that describe the available security features and recommended optimal configurations for Azure services.

- **[Zero Trust guidance](/security/zero-trust/)** provides guidance for security teams to implement technical capabilities to support a Zero Trust modernization initiative.

Each article covers several topics related to its aligned methodology:

- Security posture modernization
- Incident preparation and response
- The Confidentiality, Integrity, and Availability Triad (CIA Triad)
- Security posture sustainment

## Security posture modernization

Throughout your cloud adoption journey, look for opportunities to enhance your overall security posture through modernization. The guidance in this methodology is aligned with the [Microsoft Zero Trust adoption framework](/security/zero-trust/adopt/zero-trust-adoption-overview). This framework provides a detailed, step-by-step approach to modernizing your security posture. As you review the recommendations for each phase of the Cloud Adoption Framework methodology, enhance them by using the guidance provided in the Zero Trust adoption framework.

## Incident preparation and response

Incident preparation and response are cornerstone elements of your overall security posture. Your ability to prepare for and respond to incidents can significantly affect your success in operating within the cloud. Well-designed preparation mechanisms and operational practices enable quicker threat detection and help minimize the blast radius of incidents. This approach facilitates faster recovery. Similarly, well-structured response mechanisms and operational practices ensure efficient navigation through recovery activities and provide clear opportunities for continuous improvement throughout the process. By focusing on these elements, you can enhance your overall security strategy, which ensures resilience and operational continuity in the cloud.

## The CIA Triad

The CIA Triad is a fundamental model in information security that represents three core principles. These principles are confidentiality, integrity, and availability.

- **Confidentiality:** Ensures that only authorized individuals can access sensitive information. This policy includes measures like encryption and access controls to protect data from unauthorized access.

- **Integrity:** Maintains the accuracy and completeness of data. This means protecting data from alterations or tampering by unauthorized users, which ensures that the information remains reliable.

- **Availability:** Ensures that information and resources are accessible to authorized users when needed. This task includes maintaining systems and networks to prevent downtime and ensure continuous access to data.

Adopt the CIA Triad to ensure that your business technology remains reliable and secure. It also enforces reliability and security in your operations through well-defined, strictly followed, and proven practices. Some ways that the triad principles can help ensure security and reliability are:

- **Data protection:** Protects sensitive data from breaches by taking advantage of the CIA Triad, which ensures privacy and compliance with regulations.

- **Business continuity:** Ensures data integrity and availability to maintain business operations and avoid downtime.

- **Customer trust:** Implements the CIA Triad to build trust with customers and stakeholders by demonstrating a commitment to data security.

Each methodology-aligned article provides recommendations for the principles of the CIA Triad. This approach ensures that you can address confidentiality, integrity, and availability. This guidance helps you thoroughly consider these aspects in every phase of your cloud adoption journey.

## Security posture sustainment

Continuous improvement is crucial for maintaining a robust security posture in the cloud because cyber threats continuously evolve and become more sophisticated. To protect against these ever-changing risks, ensure ongoing enhancements. The guidance in these sections can help you set up your organization for long-term success by identifying opportunities for continuous improvement. Focus on these strategies as you establish and evolve your cloud environment over time.

## Cloud security checklist

Use the cloud security checklist to see all tasks for each cloud security step. Use the links to quickly navigate to the guidance that you need.

| &nbsp; | Cloud security step | Cloud security tasks |
|---|---|---|
|&#9744; | [Understand security teams and roles](./secure-teams-and-roles.md). | &#9744; [Understand the role of the cloud service provider](./secure-teams-and-roles.md#cloud-service-provider). <br> &#9744; [Understand the roles of infrastructure and platform teams](./secure-teams-and-roles.md#infrastructureplatform-teams-architecture-engineering-and-operations). <br> &#9744; [Understand the roles of security architecture, engineering, and posture management teams](./secure-teams-and-roles.md#security-architecture-engineering-posture-management-teams). <br> &#9744; [Understand the roles of the security operations (SecOps and SOC) teams](./secure-teams-and-roles.md#security-operations-secopssoc). <br> &#9744; [Understand the roles of security governance, risk, and compliance teams](./secure-teams-and-roles.md#security-governance-risk-and-compliance-grc). <br> &#9744; [Learn about security education and policy](./secure-teams-and-roles.md#security-education-and-policy).
|&#9744; | [Integrate security into your cloud adoption strategy](./secure-strategy.md). | &#9744; [Security posture modernization strategy](./secure-strategy.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response strategy](./secure-strategy.md#defining-a-strategy-for-incident-preparedness-and-response). <br> &#9744; [Confidentiality strategy](./secure-strategy.md#defining-a-strategy-for-confidentiality). <br> &#9744; [Integrity strategy](./secure-strategy.md#defining-a-strategy-for-integrity). <br> &#9744; [Availability strategy](./secure-strategy.md#defining-a-strategy-for-availability). <br> &#9744; [Security posture sustainment strategy](./secure-strategy.md#defining-a-strategy-for-sustaining-security-posture) |
|&#9744; | [Plan for a secure cloud adoption](./secure-plan.md). | &#9744; [Plan for landing zone adoption](./secure-plan.md#plan-for-landing-zone-adoption). <br> &#9744; [Security posture modernization planning](./secure-plan.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response planning](./secure-plan.md#incident-preparedness-and-response). <br> &#9744; [Confidentiality planning](./secure-plan.md#plan-for-confidentiality). <br> &#9744; [Integrity planning](./secure-plan.md#plan-for-integrity) <br> &#9744; [Availability planning](./secure-plan.md#plan-for-availability) <br> &#9744; [Security posture sustainment planning](./secure-plan.md#adopt-sustainment) |
|&#9744; | [Ready your secure cloud estate](./secure-ready.md). | &#9744; [Ready for security posture modernization](./secure-ready.md#security-posture-modernization). <br> &#9744; [Ready for incident preparedness and response](./secure-ready.md#ready-for-incident-preparedness-and-response). <br> &#9744; [Ready for confidentiality](./secure-ready.md#ready-for-confidentiality). <br> &#9744; [Ready for integrity](./secure-ready.md#ready-for-integrity). <br> &#9744; [Ready for availability](./secure-ready.md#ready-for-availability) <br> &#9744; [Ready for security posture sustainment](./secure-ready.md#ready-for-security-sustainment) |
|&#9744; | [Perform your cloud adoption securely](./secure-adopt.md). | &#9744; [Security posture modernization adoption](./secure-adopt.md#security-posture-modernization-adoption). <br> &#9744; [Adopt incident preparedness and response](./secure-adopt.md#incident-preparedness-and-response-adoption). <br> &#9744; [Adopt confidentiality](./secure-adopt.md#adopt-the-principle-of-confidentiality). <br> &#9744; [Adopt integrity](./secure-adopt.md#adopt-the-principle-of-integrity). <br> &#9744; [Adopt availability](./secure-adopt.md#adopt-the-principle-of-availability). <br> &#9744; [Adopt security posture sustainment](./secure-adopt.md#adopt-security-sustainment) |
|&#9744; | [Securely govern your cloud estate](./secure-govern.md). | &#9744; [Security posture modernization](./secure-govern.md#security-posture-modernization).  <br> &#9744; [Incident preparedness and response governance](./secure-govern.md#incident-preparedness-and-response) <br> &#9744; [Confidentiality governance](./secure-govern.md#confidentiality-governance). <br> &#9744; [Integrity governance](./secure-govern.md#integrity-governance). <br> &#9744; [Availability governance](./secure-govern.md#availability-governance). <br> &#9744; [Sustaining security governance](./secure-govern.md#sustaining-secure-governance) |
|&#9744; | [Securely manage your cloud estate](./secure-manage.md). | &#9744; [Security posture modernization](./secure-manage.md#security-posture-modernization).  <br> &#9744; [Manage incident preparedness and response](./secure-manage.md#managing-incident-preparedness-and-response) <br> &#9744; [Manage confidentiality](./secure-manage.md#managing-confidentiality). <br> &#9744; [Manage integrity](./secure-manage.md#managing-integrity). <br> &#9744; [Managing availability](./secure-manage.md#managing-availability). <br> &#9744; [Manage security sustainment](./secure-manage.md#managing-security-sustainment) |

## Next step

> [!div class="nextstepaction"]
> [Understand cloud security teams, roles, and functions](./secure-teams-and-roles.md)
