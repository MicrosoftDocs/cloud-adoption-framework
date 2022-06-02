---
author: MarkSimos
ms.author: mas
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Operations

## Responsibility assignment and awareness

Define which roles are responsible for which security decisions and advertise this widely throughout the organization and project teams. This helps ensure that decisions are made quickly and consistently, reducing delays in project delivery and security control implementation.

Clarifying role responsibility and expanding the awareness across your organization helps mitigate enterprise risk using native cloud [security governance](/security/compass/governance-risk-compliance-capabilities) and [security operations](/security/compass/security-operations-capabilities) tools. Maintain key roles and responsibilities across your security teams with established lines of responsibility—and accountability.

Use this [tracking worksheet](/security/compass/progress-and-role-tracking-worksheets#cloud-role-tracking-worksheet) to capture and share your cloud role tracking, designated parties for specific functions, etc.

## Governance best practices

Security governance extends governance standards over all cloud assets across environments—stretching consistent execution of security best practices and controls over cloud assets enabling on-demand, at-scale, and continuously improving asset visibility—continuously discovering assets and monitoring security posture, including vulnerability management, reporting of security compliance, and automated policy-driven governance implementation.

A comprehensive strategy for security governance includes the holistic implementation of risk management, governance assessment, and security posture management across all assets in your cloud estate. Effective risk mitigation includes constant governance compliance validation and assessments that operationalize best practices governance across your enterprise cloud assets. Security governance incorporates the continuous governance assessment of your cloud resources, but also includes security posture management of the same.

## Continuous governance assessment

Ensure your environments deployed in the cloud use a secure architecture based on Azure landing zone design principles and design area considerations and recommendations. ZT principles, and preprovisioned code with security governance controls. The next, critical step is to maintain sound governance strategies to sustain those security assurances and practices across all resources in those environments. This minimizes business risk while keeping cloud assets protected and secure.

Continuously mature resource consistency tasks using incremental policy improvements in your governance strategy. Continue to assess your organization's risk tolerance, while seeking to protect and secure your organization's cloud assets.

## Cloud workload protection

Cloud workload protection (CWP) provides your organization with security posture management and intelligent threat protection capabilities, protecting your workloads across hybrid and multicloud environments. Deploy Microsoft Defender for Cloud (MDFC) with auto-provisioning across Azure native integrated (PaaS services, Azure data services, networks, Service Fabric, SQL Database, SQL Managed Instance, and Azure storage) to strengthen your security posture across cloud resources—with continuous assessment and tracking of vulnerabilities. 

Defender for Cloud implements hardening tasks on resources and services with Azure Security Benchmark, and issues security alerts for threats to workloads and resources. It integrates with Microsoft Sentinel, and alerts can be also integrated with other SIEM, SOAR, and other IT service management solutions. Defender for Cloud's security capabilities also extend to multicloud, such as AWS, Kubernetes containers, and Linux servers. Using Azure Arc, Defender for Cloud deploys Log Analytics agents to gather security-related telemetry on non-Azure resources.

## Cloud security posture management

Use modern cloud security posture management (CSPM) tools such as Microsoft Defender for Cloud and Azure Policy as code to continuously report on and mitigate security risks. These help you identify and prioritize security improvements, focusing on disrupting potential attackers' return on investment (ROI).

> [!TIP]
> By default, Azure landing zones assign a policy to enable MDFC on all subscriptions in its hierarchy automatically with Azure Policy using the `deployIfNotExists` effect following the ALZ policy driven governance design principle.

Modern CSPM tools also often measure access control (based on Zero Trust principles), provide real-time risk scoring to continuous monitor user access, and threat and vulnerability management (TVM) insights. Modern enterprise attack surface management (EASM) tools like RiskIQ security management can supplement this with an outside-in perspective on your enterprise attack surface.

Together, these toolsets establish broad visibility and insights into your attack surfaces and risk that you can integrate into your operational and engineering processes to continuously improve your security posture.

Additionally, your DevOps processes and procedures should include:

- threat modeling systems and architectures (and specific applications)
- automated governance controls with Azure policy as code workflows (ARM templates, ~~Azure blueprints~~, ALZ bicep modules, and ALZ Terraform modules) that apply guardrails to audit and enforce standards and policies to technical systems.

## Next steps:

- [Development security](development-security-strategy-overview.md)