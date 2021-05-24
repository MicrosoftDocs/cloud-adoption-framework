---
title: Cloud SOC functions
description: Understand cloud security operations center (SOC) functions.
author: JanetCThomas
ms.author: janet
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: internal
---

<!-- docutune:casing CDOC "Cyber Defense Operations Center" -->

# Security operations (SecOps) functions

The main objective of a cloud security operations (SecOps) function is to detect, respond to, and recover from active attacks on enterprise assets.

As SecOps matures, security operations should:

- Reactively respond to attacks detected by tools
- Proactively hunt for attacks that slipped past reactive detections

## Modernization

Detecting and responding to threats is currently undergoing significant modernization at all levels.

- **Elevation to business risk management:** SOC is growing into a key component of managing business risk for the organization
- **Metrics and goals:** Tracking SOC effectiveness is evolving from "time to detect" to these key indicators:
  - **Responsiveness** via mean time to acknowledge (MTTA).
  - **Remediation speed** via mean time to remediate (MTTR).
- **Technology evolution:** SOC technology is evolving from exclusive use of static analysis of logs in a SIEM to add the use of specialized tooling and sophisticated analysis techniques. This provides deep insights into assets that provide high quality alerts and investigation experience that complement the breadth view of the SIEM. Both types of tooling are increasingly using AI and machine learning, behavior analytics, and integrated threat intelligence to help spot and prioritize anomalous actions that could be a malicious attacker.
- **Threat hunting:** SOCs are adding hypothesis driven threat hunting to proactively identify advanced attackers and shift noisy alerts out of frontline analyst queues.
- **Incident management:** Discipline is becoming formalized to coordinate nontechnical elements of incidents with legal, communications, and other teams.
**Integration of internal context:** To help prioritize SOC activities such as the relative risk scores of user accounts and devices, sensitivity of data and applications, and key security isolation boundaries to closely defend.

For more information, see:

- [Security operations discipline](../secure/security-operations.md)
- [Security operations best practices videos and slides](/security/compass/security-operations-videos-and-decks)
- [CISO workshop module 4b: threat protection strategy](/security/ciso-workshop/ciso-workshop-module-4b)
- Cyber Defense Operations Center (CDOC) blog series [part 1](https://www.microsoft.com/security/blog/2019/02/21/lessons-learned-from-the-microsoft-soc-part-1-organization), [part 2a](https://www.microsoft.com/security/blog/2019/04/23/lessons-learned-microsoft-soc-part-2-organizing-people), [part 2b](https://www.microsoft.com/security/blog/2019/06/06/lessons-learned-from-the-microsoft-soc-part-2b-career-paths-and-readiness), [part 3a](https://www.microsoft.com/security/blog/2019/10/07/ciso-series-lessons-learned-from-the-microsoft-soc-part-3a-choosing-soc-tools), [part 3b](https://www.microsoft.com/security/blog/2019/12/23/ciso-series-lessons-learned-from-the-microsoft-soc-part-3b-a-day-in-the-life), [part 3c](https://www.microsoft.com/security/blog/2020/05/04/lessons-learned-microsoft-soc-part-3c/), [part 3d](https://www.microsoft.com/security/blog/2020/06/25/zen-and-the-art-of-threat-hunting/)
- [NIST computer security incident handling guide](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-61r2.pdf)
- [NIST guide for cybersecurity event recovery](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-184.pdf)

## Team composition and key relationships

The cloud security operations center is commonly made up of the following types of roles.

- IT operations (close regular contact)
- Threat intelligence
- Security architecture
- Insider risk program
- Legal and human resources
- Communications teams
- Risk organization (if present)
- Industry specific associations, communities, and vendors (before incident occurs)

## Next steps

Review the function of [security architecture](./cloud-security-architecture.md).
