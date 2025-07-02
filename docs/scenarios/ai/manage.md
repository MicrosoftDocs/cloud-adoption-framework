---
title: Manage AI
description: Learn the process to manage AI with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# Manage AI

This article provides guidance to manage AI workloads throughout their lifecycle. Organizations achieve consistent AI performance when they establish structured operational processes, implement proper deployment governance, and maintain comprehensive monitoring practices.

## Manage AI operations

Operational frameworks provide structure for managing complex AI projects. These frameworks ensure consistency across development teams and reduce errors that slow delivery cycles. You must establish clear operational processes to achieve reliable AI workload management. Here's how:

1. **Establish an AI center of excellence for strategic guidance.** An AI center of excellence provides strategic oversight and technical guidance for AI deployments across the organization. This group ensures that AI approaches align with business objectives and technical requirements. Use your [AI center of excellence](./center-of-excellence.md) to evaluate which management approach fits your organization's needs and create deployment standards that support governance and innovation.

1. **Select the right operational framework for your workload type.** Different AI workloads require different operational approaches that affect team processes and tooling decisions. This choice determines your development methodology and technology stack integration. Use [MLOps](/azure/architecture/ai-ml/guide/machine-learning-operations-v2) frameworks for traditional machine learning workflows and [GenAIOps](/azure/architecture/ai-ml/guide/genaiops-for-mlops) for generative AI workloads.

1. **Standardize development tools across all teams.** Consistent tooling eliminates compatibility problems between team environments and reduces learning curves for developers. This approach prevents integration issues and accelerates development cycles. Define and standardize the use of SDKs and APIs for consistency across development teams. For more information, see [Choose the right SDK to support your use case](/microsoft-365/agents-sdk/choose-agent-solution)

1. **Create dedicated sandbox environments for experimentation.** Sandbox environments allow safe testing without affecting production systems and provide teams freedom to test new approaches. These environments prevent experimental code from affecting stable workloads. Use a sandbox environment that remains distinct from dev, test, and production environments in the AI development lifecycle. Maintain consistency across dev, test, and prod environments to prevent breaking changes during promotion between environments.

1. **Simplify operations when possible.** New capabilities make it easier to customize and deploy agents and fine-tuned models without specialized expertise. Traditional fine-tuning requires expert data scientists to curate datasets and build task-specific pipelines, which creates operational complexity. Use [Copilot Tuning (preview)](/microsoft-copilot-studio/microsoft-copilot-fine-tune-model) in Microsoft 365 to fine-tune models for internal tasks without requiring specialized expertise.

## Manage AI deployment

AI deployment management defines who can deploy AI resources and governs these endpoints. A structured approach ensures organizations balance development speed with governance requirements. You must establish clear deployment authority to achieve consistent AI resource management. Here's how:

1. **Grant workload teams deployment authority within defined governance boundaries.** Workload teams accelerate development when they control AI resource deployment without waiting for central approval processes. This autonomy reduces bottlenecks and enables rapid response to business requirements while maintaining organizational standards. Use [Azure Policy](/azure/governance/policy/overview) to enforce governance consistently across workload environments and create AI policies that address governance gaps. For Azure AI Foundry, deploy an instance per business unit and use Azure AI Foundry projects for each use case within the business unit rather than creating a centralized shared resource across business units.

1. **Define clear AI deployment policies for both management approaches.** AI policies provide guardrails that prevent configuration drift and security gaps while ensuring compliance with organizational standards. These policies reduce the risk of unauthorized AI resource usage. Create AI policies to enforce content filter settings and prevent the use of disallowed models, then communicate these policies clearly to all teams. Conduct regular audits to ensure compliance.

1. **Create continuous integration and delivery pipelines for deployment.** Automated pipelines reduce manual errors and ensure consistent deployments across environments while providing repeatable processes that catch issues early. These pipelines maintain quality standards throughout development. Create data pipelines that cover code quality checks, unit and integration tests, and experimentation flows. Include production deployment steps with manual approval processes for promoting releases. Maintain separation between models and client interfaces to ensure independent component updates.

## Manage AI models

AI model management involves governance structures, continuous monitoring, and performance maintenance over time. This process helps organizations align models with ethical standards, track model performance, and ensure AI systems remain effective and aligned with business objectives. You must establish comprehensive model management processes to achieve reliable AI performance. Here's how:

1. **Define an AI measurement baseline for performance tracking.** Measurement baselines ensure AI models align with business goals and ethical standards. These baselines provide objective criteria for evaluating model performance and responsible AI compliance across your organization. Establish KPIs related to responsible AI principles like fairness, transparency, and accuracy, then map these KPIs to specific AI workloads.

1. **Identify root causes of performance issues quickly.** Visibility into each stage of AI interactions helps isolate problems and implement corrective actions efficiently, preventing cascading failures across systems. For example, determine whether chatbot errors originate from prompt crafting or model context understanding. Use built-in tools like Azure Monitor and Application Insights to identify performance bottlenecks and anomalies proactively.

1. **Retrain AI models based on performance criteria.** Models degrade over time due to data changes and require retraining to maintain relevance. Regular retraining ensures AI systems stay current with business needs and data patterns. Schedule retraining based on model performance metrics or business requirements to keep AI systems relevant. Assess initial training costs to evaluate optimal retraining frequency since retraining can be expensive. Maintain version control for models and ensure rollback mechanisms for underperforming versions.

1. **Establish model promotion processes with quality gates.** Quality gates ensure only validated models reach production environments. These processes prevent poorly performing models from affecting business operations and maintain consistent quality standards. Use performance criteria to promote trained, fine-tuned, and retrained models to higher environments. Define performance criteria that are unique to each application and establish clear promotion workflows that include testing and validation steps.

1. **Track model retirement schedules to prevent service disruptions.** Model retirement tracking prevents performance issues when vendor support ends. Organizations that miss retirement dates face unexpected service degradation or compatibility problems. Monitor retirement dates for pretrained models to maintain functionality when vendors deprecate services. For instance, update generative AI models before deprecation to maintain system functionality. Use [Azure AI Foundry portal](https://ai.azure.com?cid=learnDocs) to view model retirement dates for all deployments.

## Manage AI costs

AI cost management ensures organizations control expenses while maintaining performance across compute, storage, and token usage. Organizations need structured cost oversight and optimization strategies to prevent budget overruns and maximize resource efficiency. You must establish comprehensive cost management processes to achieve predictable AI spending. Here's how:

1. **Implement cost management best practices for each Azure AI service.** Different Azure AI services have unique pricing models and optimization features that affect total cost of ownership. Understanding service-specific cost structures helps organizations select the most cost-effective options for their workloads. For example, follow cost management guidance for [Azure AI Foundry](/azure/ai-studio/how-to/costs-plan-manage) to optimize expenses for each service type.

1. **Monitor usage patterns to maximize billing efficiency.** Understanding cost breakpoints prevents unnecessary charges and helps organizations optimize resource allocation. Tracking usage patterns reveals opportunities to adjust models and architecture for better cost performance. Monitor tokens per minute (TPM) and requests per minute (RPM) to understand usage patterns, then adjust models and architecture based on these patterns. Use fixed-price thresholds for services like image generation or hourly fine-tuning to avoid unexpected charges. Consider commitment-based billing models for consistent usage patterns to reduce overall costs.

1. **Establish automated cost monitoring and alerts.** Automated alerts prevent budget overruns by notifying teams of unexpected charges before they impact project budgets. These alerts enable proactive cost management and help organizations maintain financial control over AI initiatives. Set up budget alerts in Azure Cost Management to track spending against predefined thresholds and establish budgeting strategies that align with business objectives. Create alerts at multiple thresholds to provide early warning of cost increases.

## Manage AI data

AI data management ensures accuracy, integrity, and compliance throughout the AI lifecycle. Organizations need structured data governance and quality control processes to maintain reliable AI performance. You must establish comprehensive data management practices to achieve consistent AI outcomes. Here's how:

1. **Create and maintain golden datasets for consistent validation.** Golden datasets provide standardized benchmarks for testing AI models across different environments and versions. These authoritative datasets ensure consistent evaluation criteria and help detect performance degradation over time. Develop golden datasets that represent your production data patterns and use these datasets for regular testing and validation across all AI workloads. Update golden datasets regularly to reflect current business requirements and data patterns.

1. **Implement secure data pipelines with integrity controls.** Data pipeline integrity prevents corruption and ensures reliable AI model performance. Secure pipelines protect sensitive information and maintain data quality from collection through preprocessing and storage. Build custom data pipelines that include validation checks at each stage and implement security controls to protect data throughout the pipeline process. Use automated testing to verify data quality and consistency before feeding data into AI models.

1. **Monitor data sensitivity classifications and respond to changes.** Data sensitivity classifications change due to business requirements and regulatory updates. Organizations must track these changes and update AI systems accordingly to maintain compliance and security. Develop processes to identify when data sensitivity changes and implement procedures to remove or replace sensitive data in downstream AI systems. Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/data-security-posture-enable) and [Microsoft Purview](/purview/purview-security) to label and manage sensitive data throughout your organization. When sensitivity changes occur, identify all AI models that use the affected data and retrain models with datasets that exclude the reclassified sensitive information.

## Manage AI business continuity

Business continuity management protects AI systems from disruptions and ensures rapid recovery when incidents occur. Organizations need multi-region strategies and tested recovery procedures to maintain AI service availability. Effective continuity planning prevents extended outages that affect business operations. You must establish comprehensive business continuity processes to achieve reliable AI system resilience. Here's how:

1. **Implement continuous monitoring across all AI components.** AI workloads change over time due to data evolution, model updates, or shifts in user behavior. Continuous monitoring detects these changes early and prevents performance degradation that affects business outcomes. Monitor [AI deployments](./platform/management.md#manage-ai-deployments), [AI models](./platform/management.md#manage-ai-models), and [AI data](./platform/management.md#manage-ai-data) to ensure workloads remain aligned with established KPIs. Conduct regular audits to assess AI systems against defined responsible AI principles and metrics.

1. **Deploy AI systems across multiple regions for high availability.** Multi-region deployments prevent single points of failure and ensure AI services remain accessible during regional outages. This approach provides geographic redundancy that protects against infrastructure failures and natural disasters. Deploy both generative and traditional AI systems across multiple Azure regions and implement necessary redundancy for trained and fine-tuned models to avoid retraining during outages. Use [Azure Front Door](/azure/frontdoor/front-door-overview) or [Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) to route traffic between regions automatically.

1. **Test disaster recovery plans regularly to validate effectiveness.** Regular testing identifies gaps in recovery procedures and ensures teams can restore AI systems effectively during real incidents. These tests validate that all components work together properly after recovery and help organizations refine their response procedures. Perform quarterly tests of disaster recovery plans that include data restoration processes and validation procedures for all AI components. Document test results and update recovery procedures based on lessons learned from each test cycle.

1. **Implement version control for all AI system components.** Version control systems track changes and enable quick restoration of previous configurations during recovery scenarios. This approach provides audit trails for modifications and ensures teams can identify and revert problematic changes efficiently. Use Git to manage changes to models, data pipelines, and system configurations across all AI workloads. Implement automated auditing that tracks model and system changes so teams can quickly identify and revert unplanned alterations that affect performance.

1. **Create automated backup strategies for AI assets.** Automated backups ensure critical AI components remain protected without manual intervention. These strategies prevent data loss and reduce recovery time when systems need restoration after incidents. Establish automated backup schedules for trained models, datasets, and configuration files using [Azure Backup](/azure/backup/backup-overview) or [Azure Storage](/azure/storage/common/storage-redundancy) with geo-redundant options. Store backups in separate regions from primary deployments to ensure availability during regional outages.

1. **Document recovery procedures with clear responsibilities.** Clear documentation ensures teams can execute recovery procedures consistently during high-stress situations. Documented procedures reduce recovery time and prevent errors that occur when teams operate without established guidelines. Create runbooks that define step-by-step recovery procedures for different failure scenarios and assign specific roles and responsibilities to team members for each recovery task. Update documentation regularly to reflect changes in AI architecture and recovery processes.

## Next step

> [!div class="nextstepaction"]
> [Secure AI](./secure.md)
