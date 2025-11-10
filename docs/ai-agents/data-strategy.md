---
title: Data governance for AI agents
description: Learn Data governance for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Data strategy for AI agents

A comprehensive data strategy defines how an organization uses data to achieve business objectives. For AI agents to deliver meaningful outcomes, decision makers must treat data as a strategic asset and direct their teams to build a foundation that supports accessibility, governance, and scalability.

:::image type="content" source="./images/ai-agent-adoption.png" alt-text="Diagram that shows the process outlined in this guidance: plan, govern, build and secure, integrate, and measure agents across your organization." lightbox="./images/ai-agent-adoption.png" border="false":::

## Data quality and ownership

Assess whether data supports retrieval, reasoning, and summarization. Evaluate structure, tagging, and cleanliness. Validate compliance with access controls, retention rules, and sensitivity classifications. For external or unstructured data, direct platform teams to enrich or transform it. Add a checklist to assess data quality:

- Accuracy: Does the data reflect real-world conditions?
- Completeness: Are all required fields populated?
- Consistency: Are formats and values standardized?
- Timeliness: Is the data current and updated regularly?

## Define data ownership and stewardship

Begin by assigning data ownership and stewardship roles. These roles clarify who holds responsibility for data accuracy, access control, compliance, and lifecycle management. Establish data quality standards that apply uniformly across departments and systems. These standards must include validation rules, completeness checks, and consistency requirements to support reliable decision-making.

## Collect and connect data across systems

Organizations must use secure and consistent methods to connect data from disparate systems, whether hosted on-premises or in the cloud. Direct your teams to use APIs and connectors to integrate data sources with AI agents. Require documentation for each connection method so future initiatives can reuse existing work without duplicating effort.

1. **Establish scalable data reuse practices.** Create a shared space where teams store useful data, connection methods, and tools that clean or enrich data. This helps avoid duplication and speeds up development. When one team solves a problem, others can build on it.

1. **Prepare multimodal data for advanced scenarios.** To support advanced use cases, prepare multimodal data, including images, audio, and video, in addition to structured text and numerical data. Define clear standards for labeling, storing, and accessing this data. These standards allow agents to operate across diverse business functions and unlock more complex capabilities.

1. **Monitor agent performance to refine data quality.** To maintain accuracy and compliance, monitor agent performance and use those insights to refine data quality. Assign accountability for keeping data current and reliable. When agents produce poor results, investigate the underlying data, prompts, and model to correct gaps or errors. This feedback loop improves agent reliability and supports regulatory requirements.

## Organize data systems for governance and reuse

To support scalable and secure AI adoption across the cloud estate, decision makers must direct their teams to organize data systems in ways that protect sensitive information, simplify oversight, and accelerate solution development.

1. **Isolate sensitive data.** Start by isolating sensitive data. In environments like Azure AI Foundry, use separate management groups for internet-facing and internal agents. This separation enforces governance boundaries and reduces the risk of exposing business-critical data. Align this structure with Azure landing zone principles to enable policy inheritance and streamline compliance management.

1. **Unify data.** Data preparation often happens in isolated teams, which creates duplicate effort and inconsistent data quality that slows development and complicates governance. Instead, direct teams to use a shared platform such as Microsoft Fabric where domain experts prepare and refine their data before it enters a central repository. This hub-and-spoke approach combines the strengths of decentralized ownership with centralized visibility. Domain teams retain responsibility for their data quality and validation, while the central platform ensures consistency, enables cross-agent reuse, and strengthens governance across the organization.

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai.md)