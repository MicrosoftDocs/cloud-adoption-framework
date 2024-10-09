---
title: Resource organization for AI on Azure infrastructure
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Resource organization for AI on Azure infrastructure

Effectively organizing Azure resources for AI infrastructure supports efficient management, security, compliance, scalability, resource dependency identification, and collaboration. Follow these guidelines to structure and manage your AI resources:

## Separate subscriptions

- *Create a separate subscription for each AI workload.* This improves security, compliance, and cost management. For more information on managing subscriptions, refer to the [Azure Landing Zone documentation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/).

## Management groups

- *Organize resources using management groups.* This structure helps align resources with organizational needs and project requirements, allowing you to apply policies, control access, and manage budgets across similar resource types.
  - *Organizational structure:* Structure resources based on organizational divisions such as AI Research and AI Product Development to improve visibility and streamline resource management.
  - *AI projects:* Separate resources by AI project type, such as AI Inferencing and AI Training, to optimize resource allocation and tracking for each project.
  - *Development environments:* Use groupings like Dev Environment and Test Environment to align resources with the development lifecycle and control access.
  - *Data pipelines:* Organize resources into pipeline stages like Data Ingestion and Preprocessing to manage data flows effectively and support end-to-end AI workflows.
  - *Geographical regions:* Group resources based on physical location to ensure compliance with data residency requirements and optimize performance for regional users.

## Resource groups

- *Use resource groups to organize AI resources.* Grouping by lifecycle, management needs, or workflow stage simplifies administration and helps maintain consistent configurations across similar resources.
  - *Lifecycle and management requirements:* Group resources with similar lifecycles and management requirements for coordinated updates and simplified monitoring.
  - *AI workflow stages:* Organize resources by stages such as Data Collection, Preprocessing, Model Training, and Deployment to facilitate structured workflows and resource tracking.
  - *Model deployment types:* Separate Inference and Training resources to ensure dedicated configurations for each deployment type and to optimize scaling.
  - *Data pipeline stages:* Group resources into stages like Data Ingestion and Preprocessing to align with data flow processes and improve manageability.

## Tags

- *Implement a consistent tagging strategy.* Tags help categorize resources by project, cost center, environment, and owner, aiding in management and billing. Use the [Azure Naming and Tagging](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) guidance for best practices. Examples of useful tags:
  - Tag all resources related to a specific AI project with `Project: AIResearch2024` and `Environment: Production`.

## Review existing policies for AI initiatives

- *Extend existing management groups as needed.* If you are deploying AI resources within an existing management group, review your current policies and governance rules. Ensure AI-related SKUs are included in the allowed list or adjust the policy rule scope to include these resources as needed.

By following this resource organization strategy, you can effectively manage and scale your AI infrastructure on Azure, ensuring alignment with organizational needs and compliance requirements.