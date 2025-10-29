---
title: Secure Overview
description: Learn how to establish, maintain, and automate cloud security in Azure by using the Cloud Adoption Framework for Azure Secure methodology to provide a structured approach.
author: stephen-sumner
ms.author: pnp
ms.date: 09/12/2025
ms.topic: concept-article
ms.custom: internal, UpdateFrequency2
ms.update-cycle: 365-days
---

# Secure overview

The Cloud Adoption Framework for Azure Secure methodology provides a structured approach for securing your Azure cloud estate. This overview introduces security guidance that applies across every methodology phase of the Cloud Adoption Framework. Security spans strategy, planning, readiness, adoption, governance, and operations; gaps in any phase weaken overall posture. You should apply the Secure methodology end to end so every phase decision reinforces protection, detection, and resilience.

:::image type="content" source="./media/caf-secure-overview.png" alt-text="Diagram showing the methodologies involved in cloud adoption. The diagram has boxes for each phase: teams and roles, strategy, plan, ready, adopt, govern, and manage." lightbox="./media/caf-secure-overview.png" border="false":::

## Modernize security posture

Security posture modernization is the continuous elevation of your defenses, detections, and resilience capabilities. This modernization matters here because static controls degrade quickly against evolving attacker trade craft. You should align modernization work with the [Microsoft Zero Trust adoption framework](/security/zero-trust/adopt/zero-trust-adoption-overview) and enrich each phase task with Zero Trust improvements.

Integrate identity strengthening, segmentation, just-in-time and least-privilege access, threat detection tuning, data protection, and platform baseline automation into your landing zones and operations. Prioritize modernization sprints based on measurable risk reduction (for example, exposed privileges, insecure configurations, unmonitored assets). Automate validation through policy, infrastructure as code, continuous compliance scanning, and secure score tracking in Microsoft Defender for Cloud.

## Prepare for and respond to incidents

Incident preparation and response form a primary control layer that limits attacker dwell time and business disruption. This capability matters because even mature preventive controls can't eliminate intrusion attempts. You should implement and continuously improve an end-to-end incident lifecycle covering readiness, detection, triage, containment, eradication, recovery, and post-incident learning.

Codify roles, communication channels, evidence handling, and decision authority. Instrument telemetry ingestion and alert fidelity improvements to cut false positives and accelerate mean time to detect (MTTD). Use Azure incident response guidance to refine runbooks, practice tabletop simulations, and automate containment actions (for example, isolate hosts, revoke tokens, quarantine storage) through orchestrated workflows.

## Adopt CIA Triad principles

CIA Triad principles (confidentiality, integrity, availability) provide a concise model for comprehensive information protection. This model matters here because gaps in any single principle create cascading weaknesses. You should map controls, processes, telemetry, and metrics explicitly to each principle for every phase.

- **Confidentiality** restricts access to sensitive data; encryption, key management, identity, access policies, network segmentation, and data classification controls enforce it.
- **Integrity** preserves data correctness and completeness; hashing, signing, immutable storage patterns, version control, and secure update supply chains enforce trustworthy state.
- **Availability** maintains timely access to services and data; redundancy design, fault domain isolation, autoscaling, health probes, chaos testing, backup, and disaster recovery orchestration sustain accessibility.

Apply the triad to drive:

- **Data protection:** Map sensitivity labels and encryption controls to confidentiality risk.
- **Business continuity:** Engineer integrity and availability safeguards to sustain operations.
- **Stakeholder confidence:** Demonstrate measurable adherence to each principle in audits and compliance reporting.

Each article surfaces tasks that address confidentiality, integrity, and availability so you can embed these principles into strategy, design, build, governance, and operations.

## Sustain security posture

Security posture sustainment is the disciplined cycle of measuring, improving, and validating control efficacy. This sustainment matters because threat actors iterate rapidly and static defenses lose relevance. You should institutionalize recurring assessment, prioritized remediation, control automation, and evidence-based reporting.

Track [secure score security controls](/azure/defender-for-cloud/secure-score-security-controls) in Microsoft Defender for Cloud to quantify gaps, and couple them with risk-based metrics (for example, exposure of high-privilege identities or unencrypted sensitive stores). Automate drift detection through policy, configuration baselines, and deployment pipelines. Feed incident retrospectives and threat intelligence into backlog refinement so posture change aligns with live adversary behaviors.

## Use the cloud security checklist

The cloud security checklist is a consolidated navigation and tracking aid for Secure methodology execution. This checklist matters because it reduces omission risk, accelerates onboarding, and supports audit readiness. You should integrate it into team working agreements and progress reviews as the authoritative task register.

| &nbsp; | Cloud security step | Cloud security tasks |
|---|---|---|
|&#9744; | [Understand security teams and roles](./teams-roles.md). | &#9744; [Understand the role of the cloud service provider](./teams-roles.md#cloud-service-provider). <br> &#9744; [Understand the roles of Infrastructure and Platform teams](./teams-roles.md#infrastructureplatform-teams-architecture-engineering-and-operations). <br> &#9744; [Understand the roles of Security architecture, engineering, posture management teams](./teams-roles.md#security-architecture-engineering-and-posture-management-teams). <br> &#9744; [Understand the roles of the Security Operations (SecOps and SOC) teams](./teams-roles.md#security-operations-secopssoc). <br> &#9744; [Understand the roles of Security Governance, Risk, and Compliance (GRC) teams](./teams-roles.md#security-governance-risk-and-compliance). <br> &#9744; [Learn about security education and policy](./teams-roles.md#security-education-and-policy). |
|&#9744; | [Integrate security into your cloud adoption strategy](./strategy.md). | &#9744; [Security posture modernization strategy](./strategy.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response strategy](./strategy.md#defining-a-strategy-for-incident-preparedness-and-response). <br> &#9744; [Confidentiality strategy](./strategy.md#defining-a-strategy-for-confidentiality). <br> &#9744; [Integrity strategy](./strategy.md#defining-a-strategy-for-integrity). <br> &#9744; [Availability strategy](./strategy.md#defining-a-strategy-for-availability). <br> &#9744; [Security posture sustainment strategy](./strategy.md#defining-a-strategy-for-sustaining-security-posture) |
|&#9744; | [Plan for a secure cloud adoption](./plan.md). | &#9744; [Plan for landing zone adoption](./plan.md#plan-for-landing-zone-adoption). <br> &#9744; [Security posture modernization planning](./plan.md#security-posture-modernization). <br> &#9744; [Incident preparedness and response planning](./plan.md#incident-preparedness-and-response). <br> &#9744; [Confidentiality planning](./plan.md#plan-for-confidentiality). <br> &#9744; [Integrity planning](./plan.md#plan-for-integrity) <br> &#9744; [Availability planning](./plan.md#plan-for-availability) <br> &#9744; [Security posture sustainment planning](./plan.md#plan-for-security-sustainment) |
|&#9744; | [Ready your secure cloud estate](./ready.md). | &#9744; [Ready for security posture modernization](./ready.md#security-posture-modernization). <br> &#9744; [Ready for incident preparedness and response](./ready.md#prepare-for-incident-preparedness-and-response). <br> &#9744; [Ready for confidentiality](./ready.md#prepare-for-confidentiality). <br> &#9744; [Ready for integrity](./ready.md#prepare-for-integrity). <br> &#9744; [Ready for availability](./ready.md#prepare-for-availability) <br> &#9744; [Ready for security posture sustainment](./ready.md#prepare-for-security-sustainment) |
|&#9744; | [Perform your cloud adoption securely](./adopt.md). | &#9744; [Security posture modernization adoption](./adopt.md#security-posture-modernization-adoption). <br> &#9744; [Adopt incident preparedness and response](./adopt.md#incident-preparedness-and-response-adoption). <br> &#9744; [Adopt confidentiality](./adopt.md#adopt-the-principle-of-confidentiality). <br> &#9744; [Adopt integrity](./adopt.md#adopt-the-principle-of-integrity). <br> &#9744; [Adopt availability](./adopt.md#adopt-the-principle-of-availability). <br> &#9744; [Adopt security posture sustainment](./adopt.md#adopt-security-sustainment) |
|&#9744; | [Securely govern your cloud estate](./govern.md). | &#9744; [Security posture modernization](./govern.md#security-posture-modernization).  <br> &#9744; [Incident preparedness and response governance](./govern.md#incident-preparedness-and-response) <br> &#9744; [Confidentiality governance](./govern.md#confidentiality-governance). <br> &#9744; [Integrity governance](./govern.md#integrity-governance). <br> &#9744; [Availability governance](./govern.md#availability-governance). <br> &#9744; [Sustaining security governance](./govern.md#sustaining-secure-governance) |
|&#9744; | [Securely manage your cloud estate](./manage.md). | &#9744; [Security posture modernization](./manage.md#security-posture-modernization).  <br> &#9744; [Managing incident preparedness and response](./manage.md#managing-incident-preparedness-and-response) <br> &#9744; [Managing confidentiality](./manage.md#managing-confidentiality). <br> &#9744; [Managing integrity](./manage.md#managing-integrity). <br> &#9744; [Managing availability](./manage.md#managing-availability). <br> &#9744; [Managing security sustainment](./manage.md#managing-security-sustainment) |

## Next step

> [!div class="nextstepaction"]
> [Security teams, roles, and functions](./teams-roles.md)
