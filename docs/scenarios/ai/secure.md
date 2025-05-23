---
title: Secure AI – Process to secure AI
description: Learn the process to secure AI with best practices and recommendations.
ms.author: pnp
author: stephen-sumner
ms.date: 04/09/2025
ms.topic: conceptual
---

# Secure AI – Process to secure AI

This article outlines the organizational process for securing AI workloads. It focuses on the confidentiality, integrity, and availability (CIA) of AI. Effective security practices reduce the risk of compromise by safeguarding the confidentiality, integrity, and availability of AI models and data. A secure AI environment also aligns with business security goals and enhances trust in AI-driven processes.

:::image type="content" source="./images/secure-ai.svg" alt-text="Diagram showing the AI adoption process: AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI." lightbox="./images/secure-ai.svg" border="false":::

## Discover AI security risks

AI workloads introduce unique vulnerabilities that attackers can exploit to access data, disrupt systems, or manipulate outputs. Identify and evaluate these risks regularly to protect business operations, uphold trust, and defend AI systems from misuse.

- *Identify AI security risks.* AI systems face evolving threats that require specialized evaluation. Use frameworks like [MITRE ATLAS](https://atlas.mitre.org/) and [OWASP Generative AI risk](https://genai.owasp.org/) for identifying risks across all AI workloads.

- *Identify AI data risks.* Sensitive data in AI workflows increases the risk of insider threats or data leaks. Use tools like [Microsoft Purview Insider Risk Management](/purview/insider-risk-management) to assess enterprise-wide data risks and prioritize them based on data sensitivity.

- *Identify AI model risks.* Attackers can extract or manipulate model outputs to access private information or exploit weaknesses. Test models for vulnerabilities like data leakage, prompt injection, and model inversion using data-loss-prevention techniques and adversarial simulations.

- *Conduct red team testing.* Real-world testing uncovers unknown risks that static reviews miss. Red team both [generative AI](/azure/ai-services/openai/concepts/red-teaming) and nongenerative AI models to simulate attacks. Follow these recommendations:

  - *Assess system capabilities and context.* Target testing efforts by understanding the system’s purpose and the risks it introduces. Work backward from potential impacts to design meaningful attack strategies.  
  
  - *Use simple attack techniques first.* Many real-world breaches rely on low-resource techniques. Start with basic prompts and misuse scenarios before escalating to complex methods.
  
  - *Distinguish red teaming from benchmarking.* AI red teaming uncovers unknown risks. Benchmarking assesses known vulnerabilities. Prioritize discovering unknown issues rather than measuring known ones.  
  
  - *Automate to expand risk coverage.* Use automation to scale attack coverage, but review outputs to capture nuanced risks. Use tools like [PyRIT](https://github.com/Azure/PyRIT/tree/main#python-risk-identification-tool-for-generative-ai-pyrit) to test AI systems at scale.
  
  - *Prioritize human judgment in AI red teaming.* Automation aids testing, but use human insight to detect risks related to bias, ethics, and unintended behavior.  
  
  - *Develop reliable methods to measure responsible AI failures.* Responsible AI failures occur when AI systems violate the principles of responsible AI. Unlike security vulnerabilities, these failures are harder to define and measure due to their subjective, social, and ethical implications. Use structured scenarios to assess AI behavior that violates ethical principles even when security controls pass.
  
  - *Secure both traditional and AI-specific threats.* Protect systems from both conventional threats and AI-targeted attacks such as prompt injections or data exfiltration.

    For more information, see [Lessons from red teaming 100 generative AI products](https://aka.ms/AIRTLessonsPaper).

- *Conduct periodic risk assessments.* New threats can emerge as AI models, usage, and threat actors evolve. Run recurring assessments to identify vulnerabilities in models, data pipelines, and deployment environments, and use findings to guide risk mitigation.

## Protect AI resources and data

AI systems increase organizational risk exposure through new data, infrastructure, and attack surfaces. Apply consistent security controls to manage that risk and protect sensitive assets.

### Secure AI resources

AI resources support critical business functions and can become targets for misuse or compromise. Inventory, configure, and govern all models, services, and infrastructure with standardized security controls.

- *Establish a centralized AI asset inventory.* Untracked assets create vulnerabilities that attackers can exploit. Use tools like Azure Resource Graph Explorer and Microsoft Defender for Cloud to build and maintain a full inventory of models, data, and infrastructure. Microsoft Defender for Cloud can [discover generative AI workloads](/azure/defender-for-cloud/identify-ai-workload-model) and in [predeployment generative AI artifacts](/azure/defender-for-cloud/explore-ai-risk).

- *Secure Azure AI platforms.* Inconsistent configurations create vulnerabilities across AI systems. Enforce [Azure security baselines](/security/benchmark/azure/security-baselines-overview) and follow [Azure Service Guides](/azure/well-architected/service-guides/?product=popular) for security guidance.

- *Apply workload-specific security controls.* AI workloads on PaaS and IaaS have different risks and controls. Use tailored guidance for AI on Azure platform services (PaaS) and AI on Azure infrastructure (IaaS):

    > [!div class="nextstepaction"]
    > [AI Security on Azure platforms (PaaS)](./platform/security.md)

    > [!div class="nextstepaction"]
    > [AI Security on Azure infrastructure (IaaS)](./infrastructure/security.md)

### Secure AI data

AI data includes sensitive information that attackers can exfiltrate, manipulate, or misuse. Protect AI data by enforcing access controls, monitoring usage, and isolating high-risk assets.

- *Define and maintain data boundaries.* Misaligned data exposure creates compliance and privacy risks. Match each AI workload with datasets appropriate for its audience and restrict shared access. AI applications accessible to all employees should only process data suitable for all employees. Internet-facing AI applications must use data appropriate for public consumption. Use separate datasets or environments for different AI applications to prevent inadvertent data access. Consider using Microsoft Purview’s suite of [data security](/purview/purview-security) tools to secure your data.

- *Control data access.* Weak access controls enable unauthorized data access. Require user-level verification and limit permissions based on least privilege.

- *Maintain a data catalog.* Untracked data sources increase risk and reduce governance effectiveness. Catalog AI-related data including storage locations and access details. Scan and classify data sensitivity and access level. Consider using [Microsoft Purview Data Catalog](/purview/purview-security).

- *Track changes in data sensitivity.* Data classification can shift as usage or content changes. Monitor sensitivity levels and remove high-risk data from general-purpose AI workloads. Use your data catalog to monitor information used in AI workloads.

- *Protect AI artifacts.* Attackers can steal, poison, or reverse-engineer AI models and datasets. Store artifacts in private, encrypted environments with strict access controls. Store AI models and datasets behind private endpoints and in secure environments such as Azure Blob Storage and dedicated workspaces. Apply strict access policies and encryption to safeguard AI artifacts against unauthorized access or theft to prevent data poisoning.

- *Safeguard sensitive data.* Sensitive data processed in unsecured environments can leak or get exposed. Use sanitized subsets and isolate processing environments with encryption, monitoring, and network restrictions.

- *Train employees on AI-specific risks.* Misuse and misconfiguration often stem from human error. Deliver role-based training on AI security, data handling, and threat awareness for all AI project teams.

## Detect AI security threats

AI systems face evolving threats that can emerge or escalate without warning. Organizations must detect these threats quickly and respond with minimal delay.

- *Detect AI risks.* AI workloads introduce dynamic and hidden threats that static assessments fail to catch. Automate threat detection and response for generative AI risks. Use [AI security posture management](/azure/defender-for-cloud/ai-security-posture) in Microsoft Defender for Cloud to automate detection and remediation of generative AI risks.

- *Detect AI security incidents.* Undetected incidents can lead to data loss, model compromise, or service disruption. Build and test an incident response plan focused on AI, and continuously monitor for indicators of compromise to trigger rapid mitigation.

- *Apply workload-specific monitoring.* AI workloads on PaaS and IaaS have different monitoring needs. Use guidance for AI on Azure PaaS and AI on Azure IaaS:

    > [!div class="nextstepaction"]
    > [AI monitoring on Azure platforms (PaaS)](./platform/management.md)

    > [!div class="nextstepaction"]
    > [AI monitoring on Azure infrastructure (IaaS)](./infrastructure/management.md)

## Next steps

Govern AI, Manage AI, and Secure AI are continuous processes you must iterate through regularly. Revisit each AI Strategy, AI Plan, and AI Ready as needed. Use the AI adoption checklists to determine what your next step should be.

> [!div class="nextstepaction"]
> [AI checklists](index.md#ai-checklists)
