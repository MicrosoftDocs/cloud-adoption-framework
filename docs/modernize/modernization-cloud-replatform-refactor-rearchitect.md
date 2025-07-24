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

VM-based components to Azure PaaS

- [Technology choices for Azure](/azure/architecture/guide/technology-choices/technology-choices-overview) (AAC guide)
- [Reliable web app pattern](azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance) (Architecture)

Other cloud to Azure PaaS

- [AWS to Azure PaaS](/azure/migration/migrate-from-aws) (Migration guide)
- [Google cloud to Azure PaaS](/azure/migration/migrate-from-google-cloud) (Migration guide)

## Refactor

| Refactor category | Refactor guidance |
|-------------------|-------------------|
| Reliability | • [Self-preservation](/azure/well-architected/reliability/self-preservation#application-design-guidance-and-patterns) (WAF guide)<br>• [Monitor applications](/azure/well-architected/reliability/monitoring-alerting-strategy#monitor-applications) (WAF guide) |
| Security | • [Protect application secrets](/azure/well-architected/security/application-secrets) (WAF guide)<br>• [Secure networking](/azure/well-architected/security/networking) (WAF guide) |
| Operational Excellence | • [Upgrade .NET version](/dotnet/core/install/upgrade) (.NET Guide)<br>• [Adopt infrastructure as code](/azure/well-architected/operational-excellence/infrastructure-as-code-design) (WAF guide)<br>• [Instrument application](/azure/well-architected/operational-excellence/instrument-application) (WAF guide)<br>• [Collect app data](/azure/well-architected/operational-excellence/observability#application-data) (WAF guide)<br>• [Task automation](/azure/well-architected/operational-excellence/automate-tasks) (WAF guide)<br>• [Safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) (WAF guide) |
| Cost optimization | • [Optimize flow costs](/azure/well-architected/cost-optimization/optimize-flow-costs) (WAF guide)<br>• [Optimize data costs](/azure/well-architected/cost-optimization/optimize-data-costs) (WAF guide)<br>• [Optimize code costs](/azure/well-architected/cost-optimization/optimize-code-costs) (WAF guide)<br>• [Reduce workload demand](/azure/well-architected/cost-optimization/optimize-scaling-costs#reduce-demand) (WAF guide)<br>• [Optimize development environments](/azure/well-architected/cost-optimization/optimize-personnel-time#optimize-the-development-environment) (WAF guide) |
| Performance efficiency | • [Design application code to scale](/azure/well-architected/performance-efficiency/scale-partition#design-application-to-scale) (WAF guide)<br>• [Partition datasets](/azure/well-architected/performance-efficiency/scale-partition#partition-workload) (WAF guide)<br>• [Optimize code performance](/azure/well-architected/performance-efficiency/optimize-code-infrastructure#optimize-code-performance) (WAF guide)<br>• [Optimize data performance](/azure/well-architected/performance-efficiency/optimize-data-performance) (WAF guide)<br>• [Prioritize critical flows](/azure/well-architected/performance-efficiency/prioritize-critical-flows) (WAF guide) |

## Rearchitect

Decouple tightly coupled components

- [Microservices architecture style](/azure/architecture/guide/architecture-styles/microservices) (Architecture)
- [Modern web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance) (Architecture)

Redesign deployment topology

- [Highly available multi-region design](/azure/well-architected/reliability/highly-available-multi-region-design) (WAF guide)
- [Multi-region load balancing with Traffic Manager](/azure/architecture/high-availability/reference-architecture-traffic-manager-application-gateway) (Architecture)

Consolidate services

- [Consolidation](/azure/well-architected/cost-optimization/consolidation) (WAF Guide)

Replace synchronous communication with asynchronous messaging

- [Asynchronous messaging options](/azure/architecture/guide/technology-choices/messaging) (AAC Guide)
- [Modern web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance) (Architecture)

Transform monolithic applications into microservices.

- [Design infrastructure to scale](/azure/well-architected/performance-efficiency/scale-partition#design-infrastructure-to-scale) (WAF Guide)
- [Microservices architecture](/azure/architecture/guide/architecture-styles/microservices) (AAC Guide)
- [Modern web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance) (Architecture)

Add caching layers

- [Reliable web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance) (Architecture)
- [Use caching](/azure/well-architected/performance-efficiency/optimize-data-performance#use-caching) (WAF Guide)

Data architecture

- [Big data architecture style](/azure/architecture/guide/architecture-styles/big-data) (AAC Guide)
- [Event-driver architecture style](/azure/architecture/guide/architecture-styles/event-driven) (AAC Guide)
- [Use polyglot persistence](/azure/well-architected/performance-efficiency/optimize-data-performance#use-polyglot-persistence) (WAF Guide)

