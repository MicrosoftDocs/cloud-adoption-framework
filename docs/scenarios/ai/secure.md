---
title: Secure AI
description: Learn the process to secure AI with best practices and recommendations.
ms.author: ssumner
author: stephen-sumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# Secure AI

This article helps you establish a security process for AI workloads in Azure. A secure AI environment supports business objectives and builds stakeholder confidence in AI solutions.

## Discover AI security risks

AI workloads create new attack surfaces that traditional security measures can't address. You must systematically evaluate AI-specific vulnerabilities to build effective defenses. Here's how:

1. **Identify AI system risks across your environment.** AI systems face evolving threats that require specialized evaluation frameworks to detect. These frameworks help you understand attack vectors specific to machine learning and AI workloads. Use frameworks like [MITRE ATLAS](https://atlas.mitre.org/) and [OWASP Generative AI risk](https://genai.owasp.org/) to identify risks across all AI workloads in your organization.

2. **Assess AI data risks throughout your workflows.** Sensitive data in AI workflows increases the risk of insider threats and data leaks that can compromise business operations. Data risk assessment helps you prioritize security investments based on actual exposure levels. Use tools like [Microsoft Purview Insider Risk Management](/purview/insider-risk-management) to assess enterprise-wide data risks and prioritize them based on data sensitivity levels.

3. **Test AI models for security vulnerabilities.** AI models contain unique vulnerabilities like data leakage, prompt injection, and model inversion that attackers can exploit. Real-world testing uncovers risks that static reviews can't detect. Test models for vulnerabilities using data-loss-prevention techniques and adversarial simulations, and red team both [generative AI](/azure/ai-services/openai/concepts/red-teaming) and nongenerative AI models to simulate real attacks.

4. **Conduct periodic risk assessments.** New threats emerge as AI models, usage patterns, and threat actors evolve over time. Regular assessments ensure your security posture adapts to changing risk landscapes. Run recurring assessments to identify vulnerabilities in models, data pipelines, and deployment environments, and use assessment findings to guide your risk mitigation priorities.

## Protect AI resources and data

AI systems contain valuable assets that require strong protection against unauthorized access and attacks. You must implement specific security controls to safeguard these critical resources.

### Secure AI resources

Comprehensive security measures protect your AI investments and maintain stakeholder trust in your AI solutions. You must apply targeted controls to secure all components of your AI infrastructure. Here's how:

1. **Create a complete AI asset inventory.** Unknown AI assets create security unguarded sides that attackers exploit to gain unauthorized access. A comprehensive inventory enables effective monitoring and rapid incident response for all AI components. Use [Azure Resource Graph Explorer](/azure/governance/resource-graph/) to discover AI resources across subscriptions, implement [Microsoft Defender for Cloud](/azure/defender-for-cloud/identify-ai-workload-model) to identify generative AI workloads, and maintain this inventory through automated scanning and regular validation.

2. **Secure all AI communication channels.** Exposed communication paths between AI components allow data interception and system compromise. Properly secured channels prevent unauthorized access and protect sensitive information in transit. Implement [managed identities](/entra/identity/managed-identities-azure-resources/overview) for secure authentication without stored credentials, use [virtual networks](/azure/ai-foundry/agents/how-to/virtual-networks) to isolate AI communications, and deploy [Azure API Management](/azure/api-management/export-rest-mcp-server) to secure Model Context Protocol server endpoints.

3. **Apply platform-specific security controls.** Different AI deployment models face distinct security threats based on their architecture and exposure points. Platform-tailored controls address the specific vulnerabilities present in each deployment type. Follow dedicated security guidance based on your deployment model:

    - [Azure PaaS security](./platform/security.md)
    - [Azure IaaS security](./infrastructure/security.md)

### Secure AI data

AI workloads rely on data and artifacts that require robust protection to prevent unauthorized access, data leaks, and compliance violations. You must implement comprehensive data security measures to protect AI data and artifacts. Here's how:

1. **Define and maintain data boundaries.** Clear data boundaries ensure AI workloads access only data appropriate for their intended audience and use case. Use [Microsoft Purview](/purview/purview-security) to classify data sensitivity and define access policies. Implement [Azure role-based access control (RBAC)](/azure/role-based-access-control/) to restrict data access by workload and user group. Use [Azure Private Link](/azure/private-link/) to create network-level data isolation between AI applications.

2. **Implement comprehensive data loss prevention.** Unauthorized data exposure through AI responses can compromise sensitive information and violate regulatory requirements. Data loss prevention controls prevent AI models from inadvertently revealing protected data in their outputs. Use [Microsoft Purview Data Loss Prevention](/purview/dlp-learn-about-dlp) to scan and block sensitive data in AI workflows. Configure [content filtering](/azure/ai-foundry/concepts/content-filtering) to prevent sensitive information leakage, and implement custom filters to detect and redact organization-specific sensitive data patterns. For Microsoft Copilot Studio, [Configure data loss prevention policies for agents](/microsoft-copilot-studio/admin-data-loss-prevention).

3. **Protect AI artifacts from compromise.** Unsecured AI models and datasets become targets for theft, poisoning, or reverse engineering attacks. Protected artifacts maintain intellectual property value and prevent malicious manipulation of AI systems. Store models and datasets in [Azure Blob Storage](/azure/storage/blobs/) with private endpoints, apply encryption at rest and in transit, and implement strict access policies with monitoring to detect unauthorized access attempts.

## Detect AI security threats

AI systems face evolving threats that require continuous monitoring to prevent security breaches and service disruptions. Rapid threat detection protects AI investments and maintains business continuity. You must implement automated monitoring and response capabilities to address AI-specific security incidents effectively. Here's how:

1. **Deploy automated AI risk detection across your environment.** AI workloads introduce dynamic threats that manual monitoring can't detect quickly enough to prevent damage. Automated systems provide real-time visibility into emerging risks and enable rapid response to security incidents. Use [AI security posture management](/azure/defender-for-cloud/ai-security-posture) in Microsoft Defender for Cloud to automate detection and remediation of generative AI risks across your Azure environment.

2. **Establish AI-focused incident response procedures.** Undetected security incidents can lead to data loss, model compromise, or service disruption that damages business operations. Specialized incident response procedures address the unique characteristics of AI security events. Build and test incident response plans that address AI-specific threats and continuously monitor for indicators of compromise in AI systems. Establish clear escalation procedures for different types of AI security incidents.

3. **Implement platform-specific monitoring strategies.** AI workloads deployed on different platforms face distinct security challenges that require tailored monitoring approaches. Platform-specific monitoring ensures comprehensive coverage of all potential attack vectors. Apply monitoring guidance based on your deployment architecture:

    - [AI monitoring on Azure platforms (PaaS)](./platform/management.md)
    - [AI monitoring on Azure infrastructure (IaaS)](./infrastructure/management.md)

## Azure resources

| Category | Tool | Description |
|----------|------|-------------|
| Asset Discovery | [Azure Resource Graph Explorer](/azure/governance/resource-graph/) | Discovers and inventories AI resources across Azure subscriptions |
| Security Monitoring | [Microsoft Defender for Cloud](/azure/defender-for-cloud/identify-ai-workload-model) | Identifies generative AI workloads and security risks |
| Identity Management | [Managed Identities](/azure/active-directory/managed-identities-azure-resources/) | Secures AI service authentication without storing credentials |
| Network Security | [Virtual Networks](/azure/ai-foundry/agents/how-to/virtual-networks) | Isolates AI communications and restricts network access |
| API Security | [Azure API Management](/azure/api-management/export-rest-mcp-server) | Secures Model Context Protocol server endpoints |
| Data Protection | [Azure Blob Storage](/azure/storage/blobs/) | Provides encrypted storage for AI artifacts with access controls |
| Data Governance | [Microsoft Purview](/purview/purview-security) | Catalogs and classifies AI data with sensitivity labels |

## Next steps

Govern AI, Manage AI, and Secure AI are continuous processes you must iterate through regularly. Revisit each AI Strategy, AI Plan, and AI Ready as needed. Use the AI adoption checklists to determine what your next step should be.

> [!div class="nextstepaction"]
> [AI checklists](index.md#ai-checklists)
