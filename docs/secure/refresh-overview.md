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

This set of guidance applies recommendations for topics across the entirety of the CAF methodologies as security must be deeply integrated in every aspect of cloud adoption. As such, you will find articles aligned with each methodology that provide security recommendations to consider as you work through that phase of your cloud adoptoin journey.

Each article looks at several topics as they relate to the methodology with which they align:

- Security posture modernization
- The CIA Triad (Confidentiality, Integrity and Availability)
- Incident preparation and response
- Security posture sustainment

## Security posture modernization

Throughout your cloud adoption journey, look for opportunities to enhance your overall security posture through modernization. The guidance provided throughout this methodology align with the [Microsoft Zero Trust adoption framework](/security/zero-trust/adopt/zero-trust-adoption-overview). This framework provides a detailed step-by-step approach to security posture modernization. As you consider the recommendations for this topic in each phase of the CAF methodology, complement these recommendations with the guidance found in the Zero Trust adoption framework.

## Incident preparation and response

Incident preparation and response are cornerstone elements of your overall security posture. How well you are prepared for incidents and how well you respond to incidents could determine whether you can successfully operate in the cloud. Well-designed preparation mechanisms and operational practices can help you detect threats quicker and minimize the blast radius of incidents, helping you recover quicker. Likewise well-designed response mechanisms and operational practices can help you move efficiently through recovery activities and offer clear areas for improvement throughout the process.

## The CIA Triad (Confidentiality, Integrity and Availability)

The CIA Triad is a fundamental model in information security representing three core principles: confidentiality, integrity, and availability. 

- **Confidentiality:** Ensures that sensitive information is accessed only by authorized individuals. This involves implementing measures like encryption and access controls to protect data from unauthorized access.

- **Integrity:** Maintains the accuracy and completeness of data. This means protecting data from being altered or tampered with by unauthorized users, ensuring that the information remains reliable.

- **Availability:** Ensures that information and resources are accessible to authorized users when needed. This involves maintaining systems and networks to prevent downtime and ensure continuous access to data.

Adopting the CIA triad helps ensure that the technology that runs your business is reliable and secure and that your operations enforce reliabilty and security through well-defined, strictly followed, and proven practices. Some of the ways the principles of the triad can help ensure security and reliability are:

- **Data protection:** The CIA Triad helps protect sensitive data from breaches, ensuring privacy and compliance with regulations.

- **Business continuity:** Ensuring data integrity and availability is critical for maintaining business operations and avoiding downtime.

- **Customer trust:** Implementing the CIA Triad builds trust with customers and stakeholders by demonstrating a commitment to data security.

Each methodology-aligned article provides recommendations for each principle of the CIA Triad, helping you ensure that confidentiality, integrity, and availability are thoroughly considered in each phase of your cloud adoption journey.

## Security posture sustainment

Continuous improvement is imperative for sustained success in the cloud. This is especially true for your security posture as cyber threats constantly grow more sophisticated and proliferate ever more rapidly. The guidance in these sections will help you think about ways to set your organization up for long-term sustained success by focusing on finding opportunities for continuous improvement as your cloud estate is established and evolves over time.

## Cloud security checklist

Use the cloud security checklist to see all the tasks for each cloud security step. Use the links to quickly navigate to the guidance you need.

| &nbsp; | Cloud security step | Cloud security tasks |
|---|---|---|
|&#9744; | [Understand security teams and roles](./refresh-teams-and-roles.md). | &#9744; [Understand the role of the cloud service provider](./refresh-teams-and-roles.md#cloud-service-provider). <br> &#9744; [Understand the roles of Infrastructure and Platform teams](./refresh-teams-and-roles.md#infrastructureplatform-teams-architecture-engineering-and-operations). <br> &#9744; [Understand the roles of Security architecture, engineering, posture management teams](./refresh-teams-and-roles.md#security-architecture-engineering-posture-management-teams). <br> &#9744; [Understand the roles of the Security Operations (SecOps and SOC) teams](./refresh-teams-and-roles.md#security-operations-secopssoc). <br> &#9744; [Understand the roles of Security Governance, Risk, and Compliance (GRC) teams](./refresh-teams-and-roles.md#security-governance-risk-and-compliance-grc). <br> &#9744; [Learn about security education and policy](./refresh-teams-and-roles.md#security-education-and-policy).
|&#9744; | [Integrate security into your cloud adoption strategy](./refresh-strategy-consolidated.md). | &#9744; [Security posture modernization strategy](./refresh-strategy-consolidated.md#security-posture-mondernization). <br> &#9744; [Incident preparedness and response strategy](./refresh-strategy-consolidated.md#defining-a-strategy-for-incident-preparedness-and-response). <br> &#9744; [Confidentiality strategy](./refresh-strategy-consolidated.md#defining-a-strategy-for-confidentiality). <br> &#9744; [Integrity strategy](./refresh-strategy-consolidated.md#defining-a-strategy-for-integrity). <br> &#9744; [Availability strategy](./refresh-strategy-consolidated.md#defining-a-strategy-for-availability). <br> &#9744; [Security posture sustainment strategy](./refresh-strategy-consolidated.md#defining-a-strategy-for-security-posture-sustainment) |
|&#9744; | [Plan for a secure cloud adoption](./refresh-plan-consolidated.md). | &#9744; [Plan for landing zone adoption](./refresh-plan-consolidated.md#plan-for-landing-zone-adoption). <br> &#9744; [Security posture modernization planning](./refresh-plan-consolidated.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response planning](./refresh-plan-consolidated.md#incident-preparedness-and-response). <br> &#9744; [Confidentiality planning](./refresh-plan-consolidated.md#adopt-confidentiality). <br> &#9744; [Integrity planning](./refresh-plan-consolidated.md#adopt-integrity) <br> &#9744; [Availability planning](./refresh-plan-consolidated.md#adopt-availability) <br> &#9744; [Security posture sustainment planning](./refresh-plan-consolidated.md#adopt-sustainment) |
|&#9744; | [Ready your secure cloud estate](./refresh-ready-consolidated.md). | &#9744; [Ready for security posture modernization](./refresh-ready-consolidated.md#security-posture-modernization). <br> &#9744; [Ready for incident preparedness and response](./refresh-ready-consolidated.md#ready-for-incident-preparedness-and-response). <br> &#9744; [Ready for confidentiality](./refresh-ready-consolidated.md#ready-for-confidentiality). <br> &#9744; [Ready for integrity](./refresh-ready-consolidated.md#ready-for-integrity). <br> &#9744; [Ready for availability](./refresh-ready-consolidated.md#ready-for-availability) <br> &#9744; [Ready for security posture sustainment](./refresh-ready-consolidated.md#ready-for-security-sustainment) |
|&#9744; | [Perform your cloud adoption securely](./refresh-adopt-consolidated.md). | &#9744; [Security posture modernization adoption](./refresh-adopt-consolidated.md#security-posture-modernization-adoption). <br> &#9744; [Adopt incident preparedness and response](./refresh-adopt-consolidated.md#incident-preparedness-and-response-adoption). <br> &#9744; [Adopt confidentiality](./refresh-adopt-consolidated.md#adopt-the-principal-of-confidentiality). <br> &#9744; [Adopt integrity](./refresh-adopt-consolidated.md#adopt-the-principle-of-integrity). <br> &#9744; [Adopt availability](./refresh-adopt-consolidated.md#adopt-the-principle-of-availability). <br> &#9744; [Adopt security posture sustainment](./refresh-adopt-consolidated.md#adopt-security-sustainment) |
|&#9744; | [Securely govern your cloud estate](./refresh-govern-consolidated.md). | &#9744; [Security posture modernization](./refresh-govern-consolidated.md#security-posture-modernization).  <br> &#9744; [Incident preparedness and response governance](./refresh-govern-consolidated.md#incident-preparedness-and-response) <br> &#9744; [Confidentiality governance](./refresh-govern-consolidated.md#conifidentiality-governance). <br> &#9744; [Integrity governance](./refresh-govern-consolidated.md#integrity-governance). <br> &#9744; [Availability governance](./refresh-govern-consolidated.md#availability-governance). <br> &#9744; [Sustaining security governance](./refresh-govern-consolidated.md#sustaining-secure-governance) |
|&#9744; | [Securely manage your cloud estate](./refresh-manage-consolidated.md). | &#9744; [Security posture modernization](./refresh-manage-consolidated.md#security-posture-modernization).  <br> &#9744; [Managing incident preparedness and response](./refresh-manage-consolidated.md#managing-incident-preparedness-and-response) <br> &#9744; [Manageing confidentiality](./refresh-manage-consolidated.md#managing-conifidentiality). <br> &#9744; [Managing integrity](./refresh-manage-consolidated.md#managing-integrity). <br> &#9744; [Managing availability](./refresh-manage-consolidated.md#managing-availability). <br> &#9744; [Managing security sustainment](./refresh-manage-consolidated.md#managing-security-sustainment) |
