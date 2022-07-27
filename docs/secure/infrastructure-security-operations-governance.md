---
title: Infrastructure security operations and governance
description: Learn about which roles are responsible for security decisions, governance best practices and continuous assessment, and other elements of operations.
author: mpvenables
ms.author: mas
ms.date: 06/17/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Infrastructure security operations and governance

This article describes operations and governance for your organization in the context of infrastructure security.

## Responsibility assignment and awareness

Define which roles are responsible for which security decisions. Advertise responsibility widely throughout your organization and project teams. This approach helps ensure that decisions are made quickly and consistently. It reduces delays in project delivery and security control implementation.

Clarifying role responsibility and expanding the awareness across your organization helps mitigate enterprise risk using native cloud [security governance](/security/compass/governance-risk-compliance-capabilities) and [security operations](/security/compass/security-operations-capabilities) tools. Maintain key roles and responsibilities across your security teams with established lines of responsibility and accountability.

Use this [tracking worksheet](/security/compass/progress-and-role-tracking-worksheets#cloud-role-tracking-worksheet) to capture and share your cloud role tracking and designate parties for specific functions.

## Governance best practices

Security governance extends governance standards over all cloud assets across environments. Consistent execution of security best practices and controls over cloud assets enables on-demand, at-scale, and continuously improving asset visibility. Assets are continuously discovered. The security posture is monitored, including vulnerability management, reporting of security compliance, and automated policy-driven governance implementation.

A comprehensive strategy for security governance includes the holistic implementation of risk management, governance assessment, and security posture management across all assets. Effective risk mitigation includes constant governance compliance validation and assessments. These validations and assessments operationalize best practices governance across your enterprise cloud assets. Security governance incorporates the continuous governance assessment of your cloud resources. It also includes security posture management.

## Continuous governance assessment

Ensure your cloud environments use a secure architecture based on Azure landing zone design principles and design area considerations and recommendations. Employ Zero Trust (ZT) principles and preprovisioned code with security governance controls.

The next critical step is to maintain sound governance strategies to sustain those security assurances and practices across all resources in your environments. This approach minimizes business risk while keeping cloud assets protected and secure.

Use incremental policy improvements to continuously mature resource consistency tasks. Continue to assess your organization's risk tolerance, while seeking to protect and secure your organization's cloud assets.

## Cloud workload protection

Cloud workload protection (CWP) provides your organization with security posture management and intelligent threat protection capabilities. These capabilities protect your workloads across hybrid and multicloud environments.

Deploy Microsoft Defender for Cloud with auto-provisioning across Azure native integrated services. These services include PaaS services, Azure data services, networks, Azure Service Fabric, Azure SQL Database, Azure SQL Managed Instance, and Azure Storage. This approach strengthens your security posture across cloud resources with continuous assessment and tracking of vulnerabilities.

Defender for Cloud implements hardening tasks on resources and services by using Azure Security Benchmark. It issues security alerts for threats to workloads and resources. It integrates with Microsoft Sentinel and you can integrate alerts with SIEM, SOAR, and other IT service management solutions. The security capabilities also extend to multicloud, such as Amazon Web Services, Kubernetes containers, and Linux servers. Defender for Cloud deploys Azure Monitor Logs agents, enabled by Azure Arc, to gather security-related information on non-Azure resources.

## Cloud security posture management

Use modern cloud security posture management (CSPM) tools to continuously report on and mitigate security risks. Tools such as Defender for Cloud and Azure Policy help identify and prioritize security improvements. Improvements focus on disrupting potential attackers' return on investment (ROI).

> [!TIP]
> By default, Azure landing zones assign a policy to enable Defender for Cloud on all subscriptions in its hierarchy. Azure Policy uses the `deployIfNotExists` effect following the Azure landing zone policy governance design principle.

Modern CSPM tools also often measure access control, based on Zero Trust principles. These tools provide real-time risk scoring, continuous monitoring of user access, and threat and vulnerability management (TVM) insights. Modern enterprise attack surface management (EASM) tools, like RiskIQ security management, can supplement this approach with an outside-in perspective on your enterprise attack surface.

Together, these toolsets establish broad visibility and insights into your attack surfaces and risk. You can integrate this visibility into your operational and engineering processes to continuously improve your security posture.

Your processes and procedures should also include:

- Threat modeling systems, architectures, and specific applications.
- Automated governance controls with Azure Policy as code workflows. These controls are guardrails that audit and enforce standards and policies. These code workflows include Azure Resource Management templates, Azure landing zone Bicep modules, and Azure landing zone Terraform modules.

## Next steps

> [!div class="nextstepaction"]
> [Development security strategy](development-security-strategy-overview.md)

> [!div class="nextstepaction"]
> [Infrastructure security operations](security-operations.md)
