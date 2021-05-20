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

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items validated in the "Have you done a threat analysis of your workload?" question, but tackled at the CAF level.

- Threat modeling processes are adopted, identified threats are ranked based on organizational impact, mapped to mitigations and communicated to stakeholders.Threat modeling is an engineering technique which can be used to help identify threats, attacks, vulnerabilities and countermeasures that could affect an application. Threat modeling consists of: defining security requirements, identifying threats, mitigating threats, validating threat mitigation. Microsoft uses STRIDE for threat modeling. Tools like Microsoft Threat Modeling Tool can help.

- There's a process to track, triage and address security threats in the application development cycle.The threat modeling tool will produce a report of all the threats identified. This report is typically uploaded into a tracking tool or work items that can be validated and addressed by the developers. Cyber security teams can also use the report to determine attack vectors during a penetration test. As new features are added to the solution, the threat model should be updated and integrated into the code management process. If a security issue is found, there should be a process to triage the issue into the next release cycle or a faster release, depending on the severity.

- Timelines and processess are established to deploy mitigations (security fixes) for identified threats.Fixing identified vulnerabilities in a timely manner helps staying secure and preventing additional attack vectors.

- Security requirements are defined for this workload.Azure resources should be blocked that do not meet the proper security requirements defined during service enablement.

- Threat protection was addressed for this workload.Enterprise workloads are subjected to many threats that can jeopardize confidentiality, availability, or integrity and should be protected with advanced security solutions.

- Security posture was evaluated with standard benchmarks (CIS Control Framework, MITRE framework etc.).Benchmarking enables security program improvement by learning from external organizations. It lets the organization know how its current security state compares to that of other organizations. As an example, the Center for Internet Security (CIS) has created security benchmarks for Azure that map to the CIS Control Framework. Another reference example is the MITRE ATT&CKT framework that defines the various adversary tactics and techniques based on real-world observations.

- Business critical workloads, which may adversely affect operations if they are compromised or become unavailable, were identified and classified.
