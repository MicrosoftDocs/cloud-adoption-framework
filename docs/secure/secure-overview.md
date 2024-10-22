---
title: Secure overview
description: Learn to establish, maintain, and automate cloud security in Azure.
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Secure overview

The CAF Secure methodology provides a structured approach for securing your Azure cloud estate. 

This set of guidance applies recommendations for topics across the entirety of the CAF methodologies as security must be deeply integrated in every aspect of cloud adoption. As such, you'll find articles aligned with each methodology that provide security recommendations to consider as you work through that phase of your cloud adoption journey.

All of the recommendations in this guidance follow the [Zero Trust principles](/security/zero-trust/zero-trust-overview) of assume compromise (assume breach), least privilege, and explicit verification of trust that should guide your security strategy, architecture, and implementation.

## One component of holistic security guidance

Security is a complex and challenging discipline that must be considered in nearly all aspects of your cloud and overall technology estates. This is because:

- **Anything is a potential target or attack vector:** Attackers in today’s world exploit any weakness in the people, process, and technologies of an organization to achieve their illicit objectives.
- **Security is a team sport:** Defending against these attacks requires a coordinated approach across business, technology, and security teams to each do their part for security and to all work together collaboratively. This point is illustrated by the wide variety of roles required to secure Azure resources described in the [Teams and roles](./secure-teams-roles.md) article.

This CAF Secure guidance is one component of a larger holistic set of Microsoft security guidance that guides different teams through their part of security. The full set of guidance includes:

- **Cloud Adoption Framework (CAF) Secure Methodology (this documentation):** provides security guidance for teams managing the technology infrastructure that supports all the workload development and operations hosted on Azure
- **[Well Architected Framework (WAF) security guidance](/azure/well-architected/security/):** provides guidance for individual workload owners on how to apply security best practices to application development and DevOps/DevSecOps Processes. This documentation is complemented by Microsoft guidance on how to apply [security practices](https://www.microsoft.com/securityengineering/sdl/practices) and DevSecOps controls in a Security Development Lifecycle (SDL).
- **[Microsoft Cloud Security Benchmark (MCSB)](/security/benchmark/azure/):** provides clear and detailed best practice guidance for all stakeholders on what good looks like for cloud security. This includes security baselines that describe the available security capabilities and the optimal security configurations for Azure product offerings.
- **[Zero Trust guidance](/security/zero-trust/):** provides guidance for security teams to implement technical capabilities to support a Zero Trust modernization initiative. 

Each article looks at several topics as they relate to the methodology with which they align:

- Security posture modernization
- Incident preparation and response
- The CIA Triad (Confidentiality, Integrity, and Availability)
- Security posture sustainment

## Security posture modernization

Throughout your cloud adoption journey, look for opportunities to enhance your overall security posture through modernization. The guidance provided throughout this methodology aligns with the [Microsoft Zero Trust adoption framework](/security/zero-trust/adopt/zero-trust-adoption-overview). This framework provides a detailed step-by-step approach to security posture modernization. As you consider the recommendations for this topic in each phase of the CAF methodology, complement these recommendations with the guidance found in the Zero Trust adoption framework.

## Incident preparation and response

Incident preparation and response are cornerstone elements of your overall security posture. How well you're prepared for incidents and how well you respond to incidents could determine whether you can successfully operate in the cloud. Well-designed preparation mechanisms and operational practices can help you detect threats quicker and minimize the blast radius of incidents, helping you recover quicker. Likewise well-designed response mechanisms and operational practices can help you move efficiently through recovery activities and offer clear areas for improvement throughout the process.

## The CIA Triad (Confidentiality, Integrity, and Availability)

The CIA Triad is a fundamental model in information security representing three core principles: confidentiality, integrity, and availability. 

- **Confidentiality:** Ensures that sensitive information is accessed only by authorized individuals. This involves implementing measures like encryption and access controls to protect data from unauthorized access.

- **Integrity:** Maintains the accuracy and completeness of data. This means protecting data from being altered or tampered with by unauthorized users, ensuring that the information remains reliable.

- **Availability:** Ensures that information and resources are accessible to authorized users when needed. This involves maintaining systems and networks to prevent downtime and ensure continuous access to data.

Adopting the CIA triad helps ensure that the technology that runs your business is reliable and secure and that your operations enforce reliability and security through well-defined, strictly followed, and proven practices. Some of the ways the principles of the triad can help ensure security and reliability are:

- **Data protection:** The CIA Triad helps protect sensitive data from breaches, ensuring privacy and compliance with regulations.

- **Business continuity:** Ensuring data integrity and availability is critical for maintaining business operations and avoiding downtime.

- **Customer trust:** Implementing the CIA Triad builds trust with customers and stakeholders by demonstrating a commitment to data security.

Each methodology-aligned article provides recommendations for each principle of the CIA Triad, helping you ensure that confidentiality, integrity, and availability are thoroughly considered in each phase of your cloud adoption journey.

## Security posture sustainment

Continuous improvement is imperative for sustained success in the cloud. This fact is especially true for your security posture as cyber threats constantly grow more sophisticated and proliferate ever more rapidly. The guidance in these sections will help you think about ways to set your organization up for long-term sustained success by focusing on finding opportunities for continuous improvement as your cloud estate is established and evolves over time.

## Cloud security checklist

Use the cloud security checklist to see all the tasks for each cloud security step. Use the links to quickly navigate to the guidance you need.

| &nbsp; | Cloud security step | Cloud security tasks |
|---|---|---|
|&#9744; | [Understand security teams and roles](./secure-teams-roles.md). | &#9744; [Understand the role of the cloud service provider](./secure-teams-roles.md#cloud-service-provider). <br> &#9744; [Understand the roles of Infrastructure and Platform teams](./secure-teams-roles.md#infrastructureplatform-teams-architecture-engineering-and-operations). <br> &#9744; [Understand the roles of Security architecture, engineering, posture management teams](./secure-teams-roles.md#security-architecture-engineering-and-posture-management-teams). <br> &#9744; [Understand the roles of the Security Operations (SecOps and SOC) teams](./secure-teams-and-roles.md#security-operations-secopssoc). <br> &#9744; [Understand the roles of Security Governance, Risk, and Compliance (GRC) teams](./secure-teams-roles.md#security-governance-risk-and-compliance). <br> &#9744; [Learn about security education and policy](./secure-teams-roles.md#security-education-and-policy).
|&#9744; | [Integrate security into your cloud adoption strategy](./secure-strategy.md). | &#9744; [Security posture modernization strategy](./secure-strategy.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response strategy](./secure-strategy.md#defining-a-strategy-for-incident-preparedness-and-response). <br> &#9744; [Confidentiality strategy](./secure-strategy.md#defining-a-strategy-for-confidentiality). <br> &#9744; [Integrity strategy](./secure-strategy.md#defining-a-strategy-for-integrity). <br> &#9744; [Availability strategy](./secure-strategy.md#defining-a-strategy-for-availability). <br> &#9744; [Security posture sustainment strategy](./secure-strategy.md#defining-a-strategy-for-sustaining-security-posture) |
|&#9744; | [Plan for a secure cloud adoption](./secure-plan.md). | &#9744; [Plan for landing zone adoption](./secure-plan.md#plan-for-landing-zone-adoption). <br> &#9744; [Security posture modernization planning](./secure-plan.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response planning](./secure-plan.md#incident-preparedness-and-response). <br> &#9744; [Confidentiality planning](./secure-plan.md#plan-for-confidentiality). <br> &#9744; [Integrity planning](./secure-plan.md#plan-for-integrity) <br> &#9744; [Availability planning](./secure-plan.md#plan-for-availability) <br> &#9744; [Security posture sustainment planning](./secure-plan.md#adopt-sustainment) |
|&#9744; | [Ready your secure cloud estate](./secure-ready.md). | &#9744; [Ready for security posture modernization](./secure-ready.md#security-posture-modernization). <br> &#9744; [Ready for incident preparedness and response](./secure-ready.md#ready-for-incident-preparedness-and-response). <br> &#9744; [Ready for confidentiality](./secure-ready.md#ready-for-confidentiality). <br> &#9744; [Ready for integrity](./secure-ready.md#ready-for-integrity). <br> &#9744; [Ready for availability](./secure-ready.md#ready-for-availability) <br> &#9744; [Ready for security posture sustainment](./secure-ready.md#ready-for-security-sustainment) |
|&#9744; | [Perform your cloud adoption securely](./secure-adopt.md). | &#9744; [Security posture modernization adoption](./secure-adopt.md#security-posture-modernization-adoption). <br> &#9744; [Adopt incident preparedness and response](./secure-adopt.md#incident-preparedness-and-response-adoption). <br> &#9744; [Adopt confidentiality](./secure-adopt.md#adopt-the-principle-of-confidentiality). <br> &#9744; [Adopt integrity](./secure-adopt.md#adopt-the-principle-of-integrity). <br> &#9744; [Adopt availability](./secure-adopt.md#adopt-the-principle-of-availability). <br> &#9744; [Adopt security posture sustainment](./secure-adopt.md#adopt-security-sustainment) |
|&#9744; | [Securely govern your cloud estate](./secure-govern.md). | &#9744; [Security posture modernization](./secure-govern.md#security-posture-modernization).  <br> &#9744; [Incident preparedness and response governance](./secure-govern.md#incident-preparedness-and-response) <br> &#9744; [Confidentiality governance](./secure-govern.md#confidentiality-governance). <br> &#9744; [Integrity governance](./secure-govern.md#integrity-governance). <br> &#9744; [Availability governance](./secure-govern.md#availability-governance). <br> &#9744; [Sustaining security governance](./secure-govern.md#sustaining-secure-governance) |
|&#9744; | [Securely manage your cloud estate](./secure-manage.md). | &#9744; [Security posture modernization](./secure-manage.md#security-posture-modernization).  <br> &#9744; [Managing incident preparedness and response](./secure-manage.md#managing-incident-preparedness-and-response) <br> &#9744; [Managing confidentiality](./secure-manage.md#managing-confidentiality). <br> &#9744; [Managing integrity](./secure-manage.md#managing-integrity). <br> &#9744; [Managing availability](./secure-manage.md#managing-availability). <br> &#9744; [Managing security sustainment](./secure-manage.md#managing-security-sustainment) |


## Next step

> [!div class="nextstepaction"]
> [Understand cloud security teams, roles, and functions](./secure-teams-roles.md)
