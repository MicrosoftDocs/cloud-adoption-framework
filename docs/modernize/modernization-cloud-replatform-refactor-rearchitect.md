---
title: Modernization in the cloud replatform, refactor, rearchitect
description: Learn how to implement cloud modernization through replatforming, refactoring, and rearchitecting strategies to improve workload performance, reliability, and maintainability.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Modernization in the cloud: replatform, refactor, rearchitect

## Replatform

☁️ Within Azure
- VM-based components to Azure PaaS services

🌐 Other Cloud to Azure
- VM-based components to Azure PaaS services
- Other cloud PaaS components to Azure PaaS services. See Cloud-to-Azure 

## Refactor

Reliability
- [Self-preservation](/azure/well-architected/reliability/self-preservation#application-design-guidance-and-patterns)
- [Monitor applications](/azure/well-architected/reliability/monitoring-alerting-strategy#monitor-applications)

Security
- [Protect application secrets](/azure/well-architected/security/application-secrets)
- [Secure networking](/azure/well-architected/security/networking)

Operational Excellence
Update developer frameworks to use Azure SDKs
- 5. **Modernize Azure operations.** Infrastructure-as-code and DevOps practices provide standardized, repeatable approaches to infrastructure management. Modern operations enable faster, safer changes and support innovation by allowing teams to quickly create replica test environments. You should adopt infrastructure-as-code to standardize operations and improve deployment consistency. Use Azure Verified Modules. These modules provide pre-tested, standardized infrastructure templates that follow Azure best practices. Azure Verified Modules reduce development time and ensure consistent deployments across environments. Integrate AI-powered development tools. Use GitHub Copilot and Azure Copilot to accelerate code generation and provide intelligent suggestions for infrastructure configurations. These tools help reduce manual coding effort and improve code quality. Establish CI/CD pipelines. Create automated deployment pipelines using Azure DevOps or GitHub Actions to ensure consistent, reliable deployments across all environments.
- [Instrument application](/azure/well-architected/operational-excellence/instrument-application)
- [Collect app data](/azure/well-architected/operational-excellence/observability#application-data)
- [Task automation](/azure/well-architected/operational-excellence/automate-tasks)
- [Safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments)

Cost optimization
- [Optimize flow costs](/azure/well-architected/cost-optimization/optimize-flow-costs)
- [Optimize data costs](/azure/well-architected/cost-optimization/optimize-data-costs)
- [Optimize code costs](/azure/well-architected/cost-optimization/optimize-code-costs)
- [Reduce workload demand](/azure/well-architected/cost-optimization/optimize-scaling-costs#reduce-demand)
- [Optimize development environments](/azure/well-architected/cost-optimization/optimize-personnel-time#optimize-the-development-environment)

Performance efficiency
- [Design application code to scale](/azure/well-architected/performance-efficiency/scale-partition#design-application-to-scale)
- [Partition datasets](/azure/well-architected/performance-efficiency/scale-partition#partition-workload)
- [Optimize code performance](/azure/well-architected/performance-efficiency/optimize-code-infrastructure#optimize-code-performance)
- [Optimize data performance](/azure/well-architected/performance-efficiency/optimize-data-performance)
- [Prioritize critical flows](/azure/well-architected/performance-efficiency/prioritize-critical-flows)

## Rearchitect

**Rearchitecting involves fundamental changes to application architecture and infrastructure topology.** This modernization technique redesigns how components interact, communicate, and deploy to improve scalability, reliability, and maintainability. You should consider rearchitecting when current architecture limits growth or creates operational challenges.

Examples of rearchitecting include:

- **Decouple tightly coupled components.** Transform direct component dependencies into loosely coupled services. For example, replace a web application where the frontend directly calls the backend and database with an API gateway that abstracts backend services behind interfaces.

- **Redesign deployment topology.** Change how and where services deploy to improve availability and performance. For example, move from single-region deployment to multi-region deployment across multiple availability zones.

- **Consolidate or split services.** Reorganize service boundaries to improve cohesion and reduce complexity. For example, consolidate multiple microservices with overlapping responsibilities into fewer, more cohesive services.

- **Replace synchronous communication with asynchronous messaging.** Change how services communicate to improve resilience and scalability. For example, replace direct method calls or REST APIs with message brokers like Azure Service Bus for asynchronous communication.

- **Transform monolithic applications into microservices.** Break large, monolithic applications into smaller, independently deployable services that can scale and evolve separately.
    - WAF
        - [Design infrastructure to scale](/azure/well-architected/performance-efficiency/scale-partition#design-infrastructure-to-scale)
    - AAC
        - [Microservices architecture](/azure/architecture/guide/architecture-styles/microservices)
        - [Reliable web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance)

- **Add caching layers.** Introduce caching between application components and data stores to improve performance. For example, add Azure Cache for Redis between applications and databases to reduce direct database hits.

- **Transition from batch to stream processing.** Change data processing patterns to reduce latency and improve real-time capabilities. For example, replace batch processing with long latency with stream processing using Azure Stream Analytics for near real-time insights.

- **Adopt event-driven architecture.** Replace polling-based integrations with event-driven patterns that respond to changes as they occur.

- **Implement purpose-built databases.** Replace single databases handling multiple workload types with specialized databases optimized for specific use cases. For example, use Azure SQL Database for transactional data and Azure Cosmos DB for high-throughput reads.

- **Replace synchronous API calls with asynchronous messaging.** Change inter-service communication from blocking synchronous calls to non-blocking asynchronous messaging using Azure Service Bus queues or Azure Event Grid.