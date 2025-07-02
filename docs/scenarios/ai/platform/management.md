---
title: Manage Azure platform services (PaaS) for AI
description: Learn how to manage AI workloads using Azure AI platform services (PaaS) with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# Manage Azure platform services (PaaS) for AI

This article offers management recommendations for organizations running AI workloads on Azure. It focuses on Azure platform-as-a-service (PaaS) solutions for AI.

## Manage AI deployments

Consistent deployment configurations enhance security, compliance, and operational efficiency across all AI environments. Organizations that standardize their deployment approach reduce configuration drift and ensure reliable performance. You must implement systematic deployment practices that align with your business requirements. Here's how:

1. **Select the appropriate operating model for your organization.** Deployment models create logical boundaries such as data domains or business functions to ensure autonomy, governance, and cost tracking. Deploy an instance of Azure AI Foundry for each business unit because sharing a single instance across multiple business units limits cost tracking and creates resource constraints. Define a project per use case and use hub-based projects only when teams require shared resources. For more information, see [What type of Azure AI Foundry project do I need?](/azure/ai-foundry/what-is-azure-ai-foundry#project-types) and [AI Foundry resource types](/azure/ai-foundry/concepts/resource-types).

2. **Deploy to regions that meet your requirements.** Model placement depends on specific latency, throughput, and compliance requirements that determine optimal performance. Check the Azure region [product availability](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/table) table to confirm support for required hardware, features, and data-residency rules before deployment to ensure performance and regulatory alignment.

3. **Monitor AI deployment resources continuously.** Resource monitoring captures performance data and identifies issues before they affect users. Diagnostic settings capture logs and metrics for all key services including [Azure AI Foundry and Azure AI services](/azure/ai-services/diagnostic-logging). This monitoring provides visibility into system health and enables proactive issue resolution. See also [Azure Monitor Baseline Alerts](https://azure.github.io/azure-monitor-baseline-alerts/patterns/artificial-intelligence/).

4. **Manage deployment resources centrally.** Centralized resource management provides consistent oversight and control across all AI deployments. Use the [Management center](/azure/ai-foundry/concepts/management-center) in Azure AI Foundry to configure Foundry projects, track resource utilization, and govern access. This approach ensures standardized resource allocation and cost control. Also [monitor costs in Azure AI Foundry](/azure/ai-foundry/concepts/management-center).

5. **Use Azure API Management as a unified gateway for multiple deployments.** API Management provides consistent security, scalability, rate limiting, token quotas, and centralized monitoring when onboarding multiple applications or teams. This approach standardizes access patterns and reduces management overhead across your AI services. For more information, see [Access Azure OpenAI and other language models through a gateway](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide).

## Manage AI models

Model monitoring ensures outputs align with Responsible AI principles and maintain accuracy over time. AI models experience drift due to changing data, user behaviors, or external factors that can lead to inaccurate results or ethical concerns. You must implement continuous monitoring to detect and address these changes proactively. Here's how:

1. **Monitor model outputs for quality and alignment.** Monitoring processes ensure workloads remain aligned with responsible AI targets and deliver expected results. Use Azure AI Foundry's [observability features](/azure/ai-foundry/concepts/observability) and [monitor applications](/azure/ai-foundry/how-to/monitor-applications). For Azure AI Foundry Agent Service, [monitor agent deployments](/azure/ai-services/agents/how-to/metrics).

2. **Track model performance metrics continuously.** Performance monitoring helps pinpoint issues when accuracy or response quality drops below acceptable thresholds. Monitor latency in response times and accuracy of vector search results through [tracing](/azure/ai-studio/how-to/develop/trace-local-sdk) in Azure AI Foundry.

3. **Consider implementing a generative AI gateway for enhanced monitoring.** Azure API Management enables logging and monitoring capabilities that platforms don't provide natively, including source IP collection, input text tracking, and output text analysis. This approach provides comprehensive audit trails and monitoring data. For more information, see [Implement logging and monitoring for Azure OpenAI Service language models](/azure/architecture/ai-ml/openai/architecture/log-monitor-azure-openai).

4. **Choose compute.** In Azure AI Foundry, compute resources support essential [model deployments](/azure/ai-foundry/concepts/foundry-models-overview#model-deployment-managed-compute-and-serverless-api-deployments) and [fine-tuning](/azure/ai-foundry/concepts/fine-tuning-overview#serverless-or-managed-compute). Standardize compute types, runtimes, and shutdown periods across compute instances, clusters, and serverless options.

## Manage AI data

Data quality determines the accuracy and reliability of AI model outputs. Organizations that maintain high-quality data standards achieve better model performance and reduce the risk of biased or inaccurate results. You must implement systematic data management practices to ensure consistent model quality. Here's how:

1. **Monitor data drift continuously.** Data drift detection identifies when input data patterns change from training baselines, which can degrade model performance over time. Track accuracy and data drift in both generative and nongenerative AI workloads to ensure models remain relevant and responsive to current conditions. Use [evaluations in Azure AI Foundry](/azure/ai-studio/concepts/evaluation-approach-gen-ai) to establish monitoring baselines and detection thresholds.

2. **Set up automated alerts for performance degradation.** Alert systems provide early warning when model performance drops below acceptable thresholds, enabling proactive intervention before issues affect users. Configure custom alerts to detect performance deviations and trigger remediation workflows when models require retraining or adjustment.

3. **Ensure quality data processing standards.** Data preparation requirements differ between AI workload types but must maintain consistent quality standards across all implementations. For generative AI, structure grounding data in the correct format with appropriate chunking, enrichment, and embedding for optimal AI model consumption. For more information, see [Guide to designing and developing a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

## Implement business continuity

Business continuity ensures AI services remain available during regional outages or service disruptions. Service interruptions can affect critical business operations that depend on AI capabilities, making continuity planning essential for organizational resilience. You must implement multi-region deployment strategies to maintain service availability. Here's how:

1. **Deploy AI services across multiple regions.** Multi-region deployments provide redundancy that maintains service availability when individual regions experience outages or capacity constraints. Implement multi-region deployment strategies for [Azure AI Foundry](/azure/ai-studio/how-to/disaster-recovery#plan-for-multi-regional-deployment) and [Azure OpenAI](/azure/ai-services/openai/how-to/business-continuity-disaster-recovery) to ensure consistent service delivery.

2. **Configure automated failover mechanisms.** Automated failover reduces recovery time and ensures continuous service delivery when primary regions become unavailable. Set up traffic routing and load balancing between regions to enable seamless transitions during service disruptions.

## Next step

> [!div class="nextstepaction"]
> [Govern AI](../govern.md)