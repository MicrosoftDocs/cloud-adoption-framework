---
title: Secure Azure platform services (PaaS) for AI
description: Learn how to secure AI workloads that use platform services on Azure, including Microsoft Foundry.
author: stephen-sumner
ms.author: ssumner
ms.date: 10/09/2026
ms.topic: concept-article
---

# Secure Azure platform services (PaaS) for AI

This article provides security recommendations for organizations that run AI workloads on Azure. The guidance focuses on AI platform services on Azure, including Microsoft Foundry.

## Secure AI resources

Protect the Azure resources that support your AI workloads. Start with standardized security controls, then apply service-specific guidance based on the AI services that you use.

1. **Apply Azure security baselines.** Azure security baselines provide recommended security controls for Azure services. Use the [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for the services that support your AI workloads.

2. **Follow Azure Well-Architected Framework security guidance.** Use the [Well-Architected Framework](/azure/well-architected/) to evaluate security requirements for your AI workloads. Review the relevant [Azure Service Guides](/azure/well-architected/service-guides/?product=popular) for service-specific recommendations.

## Secure AI models

Protect AI models from threats that can manipulate their behavior or compromise the workloads that use them. Use threat protection and model safeguards to reduce these risks. Here's how:

1. **Use Microsoft Defender for Cloud.** Enable the applicable Defender for Cloud protections for your AI environment. Review security recommendations and address risks based on your organization's security requirements. See [Microsoft Defender for Cloud AI threat protection](/azure/defender-for-cloud/ai-threat-protection).

2. **Protect models and agents against prompt injection.** Use Prompt Shields to detect inputs that attempt to override model instructions or manipulate model behavior. Apply protection to user prompts and external content that models or agents consume. In Microsoft Foundry, configure Prompt Shields through guardrail controls. See [Prompt Shields](/azure/foundry/openai/concepts/content-filter-prompt-shields).

3. **Use trusted model sources.** Establish governance for selecting and deploying models. Evaluate the model provider and security requirements before you approve a model for organizational use. Apply additional scrutiny to models from external or community sources.

## Secure AI access

Control access to AI resources based on who or what needs access. Use identity-based authentication and least privilege to reduce unauthorized access. Apply appropriate controls to users, AI agents, and Azure services. Here's how:

1. **Authenticate users with Microsoft Entra ID.** Use Microsoft Entra ID instead of API keys when the Azure service supports it. Identity-based authentication gives you centralized control over who can access AI resources and reduces reliance on stored credentials. If a service requires keys, protect them and rotate them regularly.

2. **Give AI agents their own governed identities.** Assign identities to AI agents so you can control what each agent can access. Use Microsoft Entra Agent ID to manage agent identities and govern their access. Microsoft Foundry can provision agent identities that agents use to access downstream resources without storing credentials in prompts or code. See [Agent identity concepts in Microsoft Foundry](/azure/foundry/agents/concepts/agent-identity).

3. **Restrict agent tools and permissions.** Give each agent access only to the tools and resources required for its approved tasks. Use the agent's identity to authenticate downstream calls, and grant least-privilege permissions to that identity. Review permissions as agent capabilities change.

## Secure AI data

Control which data each AI workload can access. Define clear data boundaries and apply governance controls to reduce unauthorized data access or exposure. Here's how:

1. **Define data boundaries for AI workloads.** Determine which data each application or agent can access based on its purpose and permissions. Enforce those boundaries through identity and data-access controls so that an AI workload can't retrieve data outside its approved scope.

2. **Isolate data based on security requirements.** Determine whether AI workloads require separate data environments based on their security or compliance requirements. Use logical or physical isolation when workloads shouldn't share access to the same data.

3. **Apply data security controls.** Protect the data that AI workloads use based on its security and compliance requirements. Follow [Data security for AI and analytics](/azure/cloud-adoption-framework/data/operational-standards-data-product-security-standards-unify-data-platform?tabs=security).

## Next steps

> [!div class="nextstepaction"]
> [Go to Management guidance](../../scenarios/ai/platform/management.md)