---
title: Modernization guidance to replatform, refactor, rearchitect
description: Find modernization guidance to replatform, refactor, rearchitect workloads in the cloud
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Modernization guides

Modernizing cloud workloads typically involves one or more of three core strategies: replatform, refactor, and rearchitect. This guide provides categorized links to relevant guidance for each strategy. While not exhaustive, it offers a solid starting point for planning your modernization journey.

## Replatform

Replatforming involves moving workload components to platform-as-a-service (PaaS) offerings with minimal code changes. It's perfect when you need to reduce operational overhead or improve reliability without a full redevelopment.

| Replatform category | Replatform guidance | Guidance type |
|---------------------|---------------------|---------------|
| VM-based components to Azure PaaS | • [Technology choices for Azure](/azure/architecture/guide/technology-choices/technology-choices-overview)<br>• [Reliable web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance) | Architecture guide<br>Architecture |
| Other cloud to Azure PaaS | • [AWS to Azure PaaS](/azure/migration/migrate-from-aws)<br>• [Google cloud to Azure PaaS](/azure/migration/migrate-from-google-cloud) | Migration guide<br>Migration guide |

## Refactor

Refactoring focuses on modifying application code to improve maintainability, performance, or alignment with cloud best practices. Use this approach when technical debt is slowing progress or when the code isn’t optimized for the cloud.

| Refactor category | Refactor guidance | Guidance type |
|-------------------|-------------------|---------------|
| Reliability | • [Self-preservation](/azure/well-architected/reliability/self-preservation#application-design-guidance-and-patterns)<br>• [Monitor applications](/azure/well-architected/reliability/monitoring-alerting-strategy#monitor-applications) | Design guide<br>Design guide |
| Security | • [Protect application secrets](/azure/well-architected/security/application-secrets)<br>• [Secure networking](/azure/well-architected/security/networking) | Design guide<br>Design guide |
| Operational Excellence | • [Upgrade .NET version](/dotnet/core/install/upgrade)<br>• [Adopt infrastructure as code](/azure/well-architected/operational-excellence/infrastructure-as-code-design)<br>• [Instrument application](/azure/well-architected/operational-excellence/instrument-application)<br>• [Collect app data](/azure/well-architected/operational-excellence/observability#application-data)<br>• [Task automation](/azure/well-architected/operational-excellence/automate-tasks)<br>• [Safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) | .NET guide<br>Design guide<br>Design guide<br>Design guide<br>Design guide<br>Design guide |
| Cost optimization | • [Optimize flow costs](/azure/well-architected/cost-optimization/optimize-flow-costs)<br>• [Optimize data costs](/azure/well-architected/cost-optimization/optimize-data-costs)<br>• [Optimize code costs](/azure/well-architected/cost-optimization/optimize-code-costs)<br>• [Reduce workload demand](/azure/well-architected/cost-optimization/optimize-scaling-costs#reduce-demand)<br>• [Optimize development environments](/azure/well-architected/cost-optimization/optimize-personnel-time#optimize-the-development-environment) | Design guide<br>Design guide<br>Design guide<br>Design guide<br>Design guide |
| Performance efficiency | • [Design application code to scale](/azure/well-architected/performance-efficiency/scale-partition#design-application-to-scale)<br>• [Partition datasets](/azure/well-architected/performance-efficiency/scale-partition#partition-workload)<br>• [Optimize code performance](/azure/well-architected/performance-efficiency/optimize-code-infrastructure#optimize-code-performance)<br>• [Optimize data performance](/azure/well-architected/performance-efficiency/optimize-data-performance)<br>• [Prioritize critical flows](/azure/well-architected/performance-efficiency/prioritize-critical-flows) | Design guide<br>Design guide<br>Design guide<br>Design guide<br>Design guide |

## Rearchitect

Rearchitecting involves redesigning the application architecture to unlock scalability, agility, or innovation. Use this approach when the current design limits growth or cloud-native capabilities.

| Rearchitect category | Rearchitect guidance | Guidance type |
|------------------------|----------|---------------|
| Decouple components | • [Microservices architecture style](/azure/architecture/guide/architecture-styles/microservices)<br>• [Modern web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance) | Architecture<br>Architecture |
| Use multiple regions | • [Highly available multi-region design](/azure/well-architected/reliability/highly-available-multi-region-design)<br>• [Multi-region load balancing with Traffic Manager](/azure/architecture/high-availability/reference-architecture-traffic-manager-application-gateway) | Design guide<br>Architecture |
| Consolidate services | • [Consolidation](/azure/well-architected/cost-optimization/consolidation) | Design guide |
| Use asynchronous messaging | • [Asynchronous messaging options](/azure/architecture/guide/technology-choices/messaging)<br>• [Modern web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance) | Architecture guide<br>Architecture |
| Use microservices | • [Design infrastructure to scale](/azure/well-architected/performance-efficiency/scale-partition#design-infrastructure-to-scale)<br>• [Microservices architecture](/azure/architecture/guide/architecture-styles/microservices)<br>• [Modern web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance) | Design guide<br>Architecture guide<br>Architecture |
| Add caching | • [Reliable web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance)<br>• [Use caching](/azure/well-architected/performance-efficiency/optimize-data-performance#use-caching) | Architecture<br>Design guide |
| Change data architecture | • [Big data architecture style](/azure/architecture/guide/architecture-styles/big-data)<br>• [Event-driven architecture style](/azure/architecture/guide/architecture-styles/event-driven)<br>• [Use polyglot persistence](/azure/well-architected/performance-efficiency/optimize-data-performance#use-polyglot-persistence) | Architecture guide<br>Design guide |

## Next steps

1. [Prepare organization for cloud modernization](./prepare-organization-cloud-modernization.md)
1. [Plan your cloud modernization](./plan-cloud-modernization.md)
1. [Execute your cloud modernization](./execute-cloud-modernization.md)
1. [Optimize workloads after modernization](./optimize-after-cloud-modernization.md)
