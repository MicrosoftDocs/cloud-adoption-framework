---
title: Manage Azure platform services (PaaS) for AI
description: Learn how to manage AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: concept-article
---

# Manage Azure platform services (PaaS) for AI

This article offers management recommendations for organizations running AI workloads on Azure. It focuses on Azure platform-as-a-service (PaaS) solutions for AI.

## AI resource sharing policy

Every deployment of Foundry and Azure Machine Learning creates a separate instance of those resources. Each instance provides its own networking perimeter, identity model, and data plane.

Colocating means when two separate workloads share a single instance of a service.

Decision makers must set the organization's policy on instance isolation and colocation.

- **Isolate production instances of your AI platform sharing.** Production workloads carry the strongest expectations for security and accountability, so the recommended policy default is to give each discrete production workload its own instance of the AI platform.

    - Provision a dedicated instance per production workload when the workload has an independent owner or a distinct compliance scope. Isolation preserves a clean blast radius, lets each workload team manage its own quota, and keeps audit trails attributable to one accountable team. This is the safer choice and should be the organization's standing default.

- **Understand the only conditions it's okay to colocate in production.** Colocate production workloads on a shared instance only when every colocated workload sits behind the same network perimeter and shares one control plane for identity and access. This pattern fits when several workloads belong to one product family under one accountable owner. The tradeoff is that a security incident or quota exhaustion event on the shared instance affects every colocated workload at the same time.
    
    - **Understand the colocation long-term consequences.** Treat any colocation choice as a one-way door. Separating workloads onto their own instances later requires migrating model deployments and connection state, and that state does not move cleanly between instances. Choosing isolation up front avoids this migration cost. For background on the instance constructs in each service, see Azure AI Foundry resources(opens in new window) and Azure Machine Learning workspaces(opens in new window).
    - **Enforce Boundaries Inside Any Shared Instance.** Colocation does not remove the need for separation. Decision makers must define boundaries that hold inside every shared instance so that ownership stays clear and accidental data exposure is prevented.

Define an organizational boundary that scopes which workloads may share an instance. Most successful organizations pick one model and apply it consistently across the company. Common models scope by data domain, by business unit, or by accountable product owner. Choose one and require it everywhere so platform teams and auditors can reason about every shared instance the same way.
Require product-native isolation inside every shared instance. In Azure AI Foundry, this means one project(opens in new window) per workload. In Azure Machine Learning, this means one workspace per workload. These constructs give each workload its own assets and role assignments without the overhead of a separate instance.
Make the in-product boundary a policy requirement, not a recommendation. If a workload cannot fit cleanly inside a project or workspace, treat that as a signal the workload needs its own instance.

- **Colocate non-production instances of your AI platform.** Default to colocation in non-production. Non-production environments exist to support experimentation and pre-release validation, and dedicated instances rarely justify their cost in those environments.

    - A shared instance per environment tier lowers idle capacity cost and keeps the platform inventory small enough to govern efficiently. 
    - The tradeoff is shared noisy-neighbor and shared outage risk, both of which the organization can accept outside production.
    - Provision a dedicated non-production instance only when a workload processes regulated data in test or must mirror its production topology for performance validation. Treat this as the exception and require explicit approval.

## Manage AI deployments

Consistent deployment configurations enhance security, compliance, and operational efficiency across all AI environments. Organizations that standardize their deployment approach reduce configuration drift and ensure reliable performance. You must implement systematic deployment practices that align with your business requirements. Here's how:

2. **Deploy to regions that meet your requirements.** Model placement depends on specific latency, throughput, and compliance requirements that determine optimal performance. Check the Azure region [product availability](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/table) table to confirm support for required hardware, features, and data-residency rules before deployment to ensure performance and regulatory alignment.

3. **Monitor AI deployment resources continuously.** Resource monitoring captures performance data and identifies issues before they affect users. Diagnostic settings capture logs and metrics for all key services including [Foundry and Foundry Tools](/azure/ai-services/diagnostic-logging). This monitoring provides visibility into system health and enables proactive issue resolution.

4. **Manage deployment resources centrally.** Centralized resource management provides consistent oversight and control across all AI deployments. For example, use the [Management center](/azure/ai-foundry/concepts/management-center) in Foundry to configure Foundry projects, track resource utilization, and govern access. This approach ensures standardized resource allocation and cost control. Also [monitor costs in Foundry](/azure/ai-foundry/concepts/management-center).

5. **Use Azure API Management as a unified gateway for multiple deployments.** API Management provides consistent security, scalability, rate limiting, token quotas, and centralized monitoring when onboarding multiple applications or teams. This approach standardizes access patterns and reduces management overhead across your AI services. For more information, see [Access Azure OpenAI and other language models through a gateway](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide).

## Manage AI models

Model monitoring ensures outputs align with Responsible AI principles and maintain accuracy over time. AI models experience drift due to changing data, user behaviors, or external factors that can lead to inaccurate results or ethical concerns. You must implement continuous monitoring to detect and address these changes proactively. Here's how:

1. **Monitor model outputs for quality and alignment.** Monitoring processes ensure workloads remain aligned with responsible AI targets and deliver expected results. Use Foundry's [observability features](/azure/ai-foundry/concepts/observability) and [monitor applications](/azure/ai-foundry/how-to/monitor-applications). For Foundry Agent Service, [monitor agent deployments](/azure/ai-foundry/agents/how-to/metrics).

2. **Track model performance metrics continuously.** Performance monitoring helps pinpoint issues when accuracy or response quality drops below acceptable thresholds. Monitor latency in response times and accuracy of vector search results through [tracing](/azure/ai-foundry/how-to/develop/trace-local-sdk) in Foundry.

3. **Consider implementing a generative AI gateway for enhanced monitoring.** Azure API Management enables logging and monitoring capabilities that platforms don't provide natively, including source IP collection, input text tracking, and output text analysis. This approach provides comprehensive audit trails and monitoring data. For more information, see [Implement logging and monitoring for Azure OpenAI Service language models](/azure/architecture/ai-ml/openai/architecture/log-monitor-azure-openai).

4. **Choose compute.** In Foundry, compute resources support essential [model deployments](/azure/ai-foundry/concepts/foundry-models-overview#model-deployment-managed-compute-and-serverless-api-deployments) and [fine-tuning](/azure/ai-foundry/concepts/fine-tuning-overview#serverless-or-managed-compute). Standardize compute types, runtimes, and shutdown periods across compute instances, clusters, and serverless options.

## Manage AI data

Data quality determines the accuracy and reliability of AI model outputs. Organizations that maintain high-quality data standards achieve better model performance and reduce the risk of biased or inaccurate results. You must implement systematic data management practices to ensure consistent model quality. Here's how:

1. **Monitor data drift continuously.** Data drift detection identifies when input data patterns change from training baselines, which can degrade model performance over time. Track accuracy and data drift in both generative and nongenerative AI workloads to ensure models remain relevant and responsive to current conditions. Use [evaluations in Foundry](/azure/ai-foundry/concepts/evaluation-approach-gen-ai) to establish monitoring baselines and detection thresholds.

2. **Set up automated alerts for performance degradation.** Alert systems provide early warning when model performance drops below acceptable thresholds, enabling proactive intervention before issues affect users. Configure custom alerts to detect performance deviations and trigger remediation workflows when models require retraining or adjustment.

3. **Ensure quality data processing standards.** Data preparation requirements differ between AI workload types but must maintain consistent quality standards across all implementations. For generative AI, structure grounding data in the correct format with appropriate chunking, enrichment, and embedding for optimal AI model consumption. For more information, see [Guide to designing and developing a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

## Implement business continuity

Business continuity ensures AI services remain available during regional outages or service disruptions. Service interruptions can affect critical business operations that depend on AI capabilities, making continuity planning essential for organizational resilience. You must implement multi-region deployment strategies to maintain service availability. Here's how:

1. **Deploy AI services across multiple regions.** Multi-region deployments provide redundancy that maintains service availability when individual regions experience outages or capacity constraints. Implement multi-region deployment strategies for [Foundry](/azure/ai-foundry/how-to/disaster-recovery#plan-for-multi-regional-deployment) and [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery) to ensure consistent service delivery.

2. **Configure automated failover mechanisms.** Automated failover reduces recovery time and ensures continuous service delivery when primary regions become unavailable. Set up traffic routing and load balancing between regions to enable seamless transitions during service disruptions.

## Next step

> [!div class="nextstepaction"]
> [Govern AI](../../scenarios/ai/govern.md)
