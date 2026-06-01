---
title: AI Platform Sharing Decision Guidance
description: Azure AI resource sharing guidance to define colocation boundaries, isolation policies, and exception criteria for Microsoft Foundry and Azure Machine Learning
#customer intent: As a decision maker defining AI adoption policy for my organization, I want guidance on how to decide when to isolate workload environments by using dedicated instances of AI platform resources, and when it is acceptable to colocate multiple workload environments on shared AI platform resources, so that I can establish a clear operational standard for AI workload teams to follow. Examples of AI platform resources include Microsoft AI Foundry instances and Azure Machine Learning workspaces.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 05/26/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# AI platform sharing decision guidance

An AI platform is where your organization runs and operates AI models. It provides the networking perimeter, identity model, data plane, and quota allocation that surround your models, deployments, indexes, evaluations, and related assets. Microsoft Foundry and Azure Machine Learning are two Azure AI platforms. Every deployment of either service creates a new instance.

Your organization must decide how to place AI workload environments across AI platform instances. You can isolate each environment such as dev, test, or prod in its own platform instance. You can also allow multiple workloads or environments to share the same instance. This decision, often called colocation, affects the blast radius of operational or security issues. It also affects compliance boundaries and platform cost. 

**Recommendation:** Establish an organization-wide policy that defines default isolation requirements, approved sharing boundaries, exception criteria, and separate expectations for production and pre-production AI platform environments.

**Decision guidance:**

## 1. Define AI platform sharing boundaries

Every organization needs boundaries across which workloads must never share an AI platform instance. This boundary applies in every environment, production and pre-production alike. Workloads inside the same boundary can potentially share a platform instance. Workloads in different boundaries cannot.

- **Why draw sharing boundaries?** Without sharing boundaries, workload teams default to whatever pattern is convenient in the moment, and the AI platform accumulates conflicting requirements over time. Over time, that creates inconsistent ownership models, conflicting compliance requirements, unclear cost allocation, and shared operational risk across unrelated workloads. For example, unrelated business areas might share quota on the same platform instance to reduce cost. The result is an AI platform with inconsistent governance boundaries that become difficult to understand and audit.

- **Common boundaries.** Choose a boundary model that aligns to how your organization already assigns responsibility and governs technology decisions. Common models include:

    - A **business unit** boundary optimizes for common operational ownership and funding

    - A **data domain** boundary optimizes for common compliance and data handling requirements

    - A **product owner** boundary optimizes for a common engineering lifecycle and platform operations

    Inside the boundary, teams can still choose dedicated platform instances when isolation makes sense. Outside the boundary, sharing is not permitted.

- **Find what works best.** No single model is universally correct. Consistency matters more than which model you select, because a clearly enforced boundary model keeps governance understandable as the AI platform grows.

## 2. Define a production AI platform sharing policy

AI platform sharing in production is the practice of running more than one production AI workload environment on the same Microsoft Foundry resource or Azure Machine Learning workspace. In Azure, the AI platform instance defines the network boundary, identity boundary, and quota boundary for the workload environments that use it. For that reason, organizations should define a specific policy for production AI platform sharing.

**1. Default to a single AI platform instance per production workload.** Production AI environments should default to production environment isolation. Don't colocate multiple production workloads on the same Microsoft Foundry resource or Azure Machine Learning workspace unless a documented exception exists. A dedicated AI platform instance for each production workload environment should be the standard approach. Treat AI platform sharing as an exception, not a default practice.

- **Why default to isolation?** Shared AI platforms also create shared operational risk. A security issue, misconfiguration, service outage, or quota exhaustion event can affect every colocated workload environment. Isolation also reduces the risk of accidental cross-workload access exposure and prevents one workload from consuming GPU capacity or quota needed by another workload. Production environments usually have the highest business impact and regulatory exposure. Most organizations require clear ownership boundaries and strong operational isolation for these environments.

- **Tradeoff:** Isolation increases cost and management overhead. Each platform instance carries its own operational overhead for networking, identity, monitoring, and operations. Organizations must balance these costs against the operational and security benefits of stronger containment.

**2. Permit colocation only through a documented exception.** Colocation reduces overhead and consolidates platform operations. It also merges the blast radius, identity boundary, and quota pool of every workload that shares the instance. For example, if use cases share the same data sources as input, co-location solves for having to repeatedly set up connectivity and authentication from the AI Platform to those resources.

- Only permit production workloads to share instances of Microsoft Foundry or Azure Machine Learning when each of the following conditions holds:

  1. All colocated workloads share the same regulatory scope, data classification, residency requirements, and data handling standards.

  2. All workloads operate inside the same network boundary, same DNS namespace, and the same identity boundary.

  3. The organization accepts the shared outage risk and the shared quota exhaustion risk that colocation introduces.

  4. The cost or operational overhead of separate instances materially outweighs the isolation benefit. Cost pressure alone isn't sufficient justification.

  5. The team accepts that splitting workloads apart later is costly. AI platform state doesn't transfer cleanly between instances and often requires recreation or reconfiguration.

- **Tradeoff:** Every shared AI platform instance requires a clearly identified platform owner responsible for quota management, network configuration, access reviews, lifecycle operations, and incident coordination.

**3. Segment use cases within the AI platform instance.**  Whether a platform instance is isolated or colocated, use in-product segmentation features to isolate use cases. Treat each distinct use case, such as wholly distinct user experiences within a single workload, as its own logical deployment inside the platform instance. For example:

- In Microsoft Foundry, provision one [project](/azure/foundry/how-to/create-projects) per use case inside the Foundry resource.

- In Azure Machine Learning, use a [hub workspace](/azure/machine-learning/concept-hub-workspace) with project workspaces to segment use cases.

These constructs give each use case its own assets and role assignments, while sharing a common set of infrastructure components for security and connectivity, without provisioning a new instance for every scenario.

- When colocation is permitted under the exception process, elevate this in-product separation from a recommendation to an enforced policy requirement.

- If a workload requires complex segmentation across multiple Foundry projects or Azure Machine Learning workspaces, reassess whether the current sharing model still provides acceptable operational simplicity and isolation.

For background on the constructs that anchor these decisions, see [Microsoft Foundry resources](/azure/foundry/how-to/create-projects) and [Azure Machine Learning workspaces](/azure/machine-learning/concept-hub-workspace).

## 3. Define a preproduction AI platform sharing policy

Preproduction environments invert the production default. These environments support experimentation and prerelease validation across development, test, and stage tiers. Dedicated instances of AI platform resources rarely justify their cost in those tiers. Default to a shared instance per environment tier.

- **When to isolate in preproduction environments.** Use a dedicated preproduction instance per workload only when a workload processes regulated data in test or must mirror its production topology for performance validation. Treat that requirement as an exception and require explicit approval before provisioning.

- **Tradeoff:** Preproduction colocation lowers idle capacity cost and keeps the platform inventory smaller. However, it exposes every workload to interference from another team's experiments. A misconfigured fine-tuning job or a runaway evaluation run can consume shared quota and slow other teams. Test results captured on a shared instance also don't always predict production behavior. Workloads with strict performance or compliance validation needs require a dedicated environment despite the higher cost.

## References 

* [Microsoft Foundry documentation](https://learn.microsoft.com/en-us/azure/foundry/what-is-foundry?tabs=python)
* [Microsoft Foundry rollout across my organization](/azure/foundry/concepts/planning)
