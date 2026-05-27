---
title: AI Resource Sharing Decision Guidance
description: Azure AI resource sharing guidance to define colocation boundaries, isolation policies, and exception criteria for Microsoft Foundry and Azure Machine Learning
#customer intent: As a decision maker defining AI adoption policy for my organization, I want guidance on how to decide when to isolate workload environments by using dedicated instances of AI platform resources, and when it is acceptable to colocate multiple workload environments on shared AI platform resources, so that I can establish a clear operational standard for AI workload teams to follow. Examples of AI platform resources include Microsoft AI Foundry instances and Azure Machine Learning workspaces.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 05/26/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# AI resource sharing decision guidance

Every Microsoft Foundry or Azure Machine Learning deployment creates a new instance of that service. The instance carries its own networking perimeter, identity model, data plane, and quota allocation from Azure.

Your organization must decide whether to isolate each workload on its own instance or allow several workloads to share one instance. That choice, often called colocation, shapes the blast radius across your AI estate. It also shapes compliance posture and cost.

**Recommendation:** Establish an organization-wide policy that defines default isolation requirements, approved sharing boundaries, exception criteria, and separate expectations for production and pre-production AI environments.

**Decision guidance:**

## 1. AI resource sharing boundaries

Every organization needs boundaries across which workloads must never share an AI resource. This boundary applies in every environment, production and pre-production alike. Workloads inside the same boundary can potentially share a resource. Workloads in different boundaries cannot.

- Without it, workload teams default to whatever pattern is convenient in the moment, and the platform accumulates conflicting requirements over time. Over time, that creates inconsistent ownership models, conflicting compliance requirements, unclear cost allocation, and shared operational risk across unrelated workloads. For example, might share quota across unrelated business areas to reduce cost. The result is an AI platform with inconsistent governance boundaries that become difficult to understand and audit.

- Choose a boundary model that aligns to how your organization already assigns responsibility and governs technology decisions. Common models include:

    - A **business unit** boundary optimizes for common operational ownership and funding

    - A **data domain** boundary optimizes for common compliance and data handling requirements

    - A **product owner** boundary optimizes for a common engineering lifecycle and platform operations

- Inside the boundary, teams can still choose dedicated instances when isolation makes sense. Outside the boundary, sharing is not permitted. No single model is universally correct. Consistency matters more than which model you select, because a clearly enforced boundary model keeps governance understandable as the platform grows.

## 2. AI production resource sharing

AI production resource sharing is the practice of running more than one production AI workload on the same Microsoft Foundry resource or Azure Machine Learning workspace. Because the instance is the unit of network isolation, identity boundary, and quota allocation in Azure, the sharing decision determines which production workloads share fate during an outage, a security event, or a capacity shortage. Production is also where regulatory exposure and customer impact are highest, so the rules that govern colocation in production deserve a separate, explicit policy rather than an inherited default from lower environments.

**1. Default to instance isolation for production workloads.** Production AI workloads carry the highest expectations for security, operational accountability, and compliance assurance. A dedicated instance creates a clean operational boundary for each workload or product team, and it should be the baseline that requires no exception approval.

- This default protects against the two most common operational failures in shared AI platforms: accidental cross-workload access exposure and noisy-neighbor consumption of shared quota or GPU capacity.

- *Tradeoff:* Isolation increases cost and management overhead. Each instance carries its own operational overhead for networking, identity, monitoring, and operations. Teams must accept that cost as the price of containment.

**2. Permit colocation only through a documented exception.** Colocation reduces overhead and consolidates platform operations. It also merges the blast radius, identity boundary, and quota pool of every workload that shares the instance.

- Only permit production workloads to share instances of Microsoft Foundry or Azure Machine Learning when each of the following conditions holds:

  1.  All colocated workloads must share the same regulatory scope, data classification, residency requirements, and data handling standards.

  2.  All workloads must operate inside the same network boundary, same DNS namespace, and the same identity boundary.

  3.  The organization must accept the shared outage risk and the shared quota exhaustion risk that colocation introduces.

  4.  The cost or operational overhead of separate instances must materially outweigh the isolation benefit. Cost pressure alone is not sufficient justification.

  5.  The team accepts that splitting workloads apart later is costly. Resource-scoped state such as fine-tuned models, deployments, indexes, evaluations, and role assignments does not move cleanly between instances and may need to be rebuilt.

- Valid exception scenarios are narrow. One example is an early-stage product team with a single platform owner and a constrained budget. Another is a portfolio of internal business applications that processes the same low-sensitivity data inside an existing shared infrastructure boundary, such as an internal HR analytics suite.

- **Tradeoff:** Every shared instance requires a clearly identified platform owner responsible for quota management, network configuration, access reviews, lifecycle operations, and incident coordination.

**3. Segment use cases within instance segmentation.** Whether an instance is isolated or colocated, treat each distinct use case as its own logical workload inside the platform. For example:

- In Microsoft Foundry, provision one [project](https://learn.microsoft.com/azure/ai-foundry/how-to/create-projects) per use case inside the Foundry resource.

- In Azure Machine Learning, use a [hub workspace ](https://learn.microsoft.com/en-us/azure/machine-learning/concept-hub-workspace?view=azureml-api-2)with project workspaces.

These constructs give each use case its own assets and role assignments without provisioning a new instance for every team.

- When colocation is permitted under the exception process, elevate this in-product separation from a recommendation to an enforced policy requirement.

- If a workload requires complex segmentation across multiple Foundry projects or Azure Machine Learning workspaces, reassess whether the current sharing model still provides acceptable operational simplicity and isolation.

For background on the constructs that anchor these decisions, see [Microsoft Foundry resources](https://learn.microsoft.com/azure/ai-foundry/concepts/ai-resources) and [Azure Machine Learning workspaces](https://learn.microsoft.com/azure/machine-learning/concept-workspace).

## 3. AI preproduction resource sharing

Preproduction environments invert the production default. These environments support experimentation and prerelease validation across development, test, and stage tiers. Dedicated instances of AI platform resources rarely justify their cost in those tiers. Default to a shared instance per environment tier.

- **When to isolate in preproduction environments.** Use a dedicated preproduction instance per workload only when a workload processes regulated data in test or must mirror its production topology for performance validation. Treat that requirement as an exception and require explicit approval before provisioning.

- *Tradeoff:* This approach lowers idle capacity cost and keeps the platform inventory small enough to govern efficiently. Shared preproduction instances expose every workload to interference from another team's experiments. A misconfigured fine-tuning job or a runaway evaluation run can consume shared quota and slow other teams. Test results captured on a shared instance also don't always predict production behavior. Workloads with strict performance or compliance validation needs require a dedicated environment despite the higher cost.
