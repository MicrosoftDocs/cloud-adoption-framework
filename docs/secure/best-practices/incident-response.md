---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

https://docs.microsoft.com/en-us/security/compass/incident-response-playbooks

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "validate security and incident response" question at the CAF level

**This article may need to be split into multiple articles to cover "How do you validate security" and "Incident/Threat Response" as two topics. // SME review request**

- For containerized workloads, Azure Defender (Azure Security Center) or other third-party solution is used to scan for vulnerabilities.Azure Security Center is the Azure-native solution for securing containers. Security Center can protect virtual machines that are running Docker, Azure Kubernetes Service clusters, Azure Container Registry registries. ASC is able to scan container images and identify security issues, or provide real-time threat detection for containerized environments.
- Penetration testing is performed in-house or a third-party entity performs penetration testing of this workload to validate the current security defenses.Real world validation of security defenses is critical to validate a defense strategy and implementation. Penetration tests or red team programs can be used to simulate either one time, or persistent threats against an organization to validate defenses that have been put in place to protect organizational resources.
- Simulated attacks on users of this workload, such as phishing campaigns, are carried out regularly.People are a critical part of your defense, especially those with elevated permissions, so ensuring they have the knowledge and skills to avoid and resist attacks will reduce your overall organizational risk. Simulating attacks for educational purposes helps to enforce understanding of the various means that an attacker may use to compromise accounts. Tools such as Office 365 Attack Simulation or similar may be used.
- Operational processes for incident response are defined and tested for this workload.Actions executed during an incident and response investigation could impact application availability or performance. It is recommended to define these processes and align them with the responsible (and in most cases central) SecOps team. The impact of such an investigation on the application has to be analyzed.
- Playbooks are built to help incident responders quickly understand the workload and components, to mitigate an attack and do an investigation.Incident responders are part of a central SecOps team and need to understand security insights of an application. Playbooks can help to understand the security concepts and cover the typical investigation activities. These procedures can and should be automated as much as possible (while maintaining confidence and security).
- There's a security operations center (SOC) that leverages a modern security approach.A SOC has a critical role in limiting the time and access an attacker can get to valuable systems and data. In addition, it provides the vital role of detecting the presence of adversaries, reacting to an alert of suspicious activity, or proactively hunting for anomalous events in the enterprise activity logs.
- A security training program is developed and maintained to ensure security staff of this workload are well-informed and equipped with the appropriate skills.
