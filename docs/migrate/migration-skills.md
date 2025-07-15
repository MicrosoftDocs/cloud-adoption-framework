---
title: Migration skills required for Azure adoption
description: Comprehensive list of skills required to successfully execute workload migrations to Azure using the Cloud Adoption Framework methodology.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Migration skills required for Azure adoption
| Skill area                | Required skills                                                                 | Why it matters                                                                                              |
|---------------------------|--------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| Cloud Strategy and Planning | - Cloud Adoption Framework (CAF) planning<br>- Migration wave planning<br>- Stakeholder communication<br>- Risk and rollback planning<br>- RACI modeling | Aligns migration with business goals, ensures accountability, and reduces risk through structured planning and communication. |
| Dependency Mapping & Architecture | - Dependency mapping<br>- Azure architecture design<br>- Hybrid/cloud integration planning<br>- Network and DNS planning | Prevents broken integrations and performance issues by grouping interdependent systems and designing resilient architectures. |
| Infrastructure as Code (IaC) | - Bicep or Terraform<br>- GitHub or Azure DevOps<br>- CI/CD pipeline creation | Enables repeatable, consistent deployments and accelerates migration through automation and version control. |
| Workload Assessment & Readiness | - Azure Migrate<br>- OS and driver compatibility checks<br>- Refactoring for Azure services<br>- Identity and access management | Identifies and resolves compatibility issues early, reducing cutover risk and ensuring workloads are Azure-ready. |
| Migration Execution       | - Offline and online migration strategies<br>- Azure Database Migration Service<br>- Data transfer tools<br>- DNS and traffic redirection<br>- Continuous synchronization | Ensures smooth and timely migration with minimal disruption, using the right strategy and tools for each workload. |
| Testing and Validation    | - Azure resource provisioning<br>- Functional and performance testing<br>- Data integrity validation<br>- Failover testing<br>- Controlled cutover sequencing | Confirms workloads function correctly in Azure before production cutover, reducing the risk of post-migration issues. |
| Post-Migration Optimization | - Azure Monitor and Advisor<br>- Azure Cost Management<br>- Backup validation<br>- User feedback collection<br>- Support team readiness | Ensures workloads are stable, secure, and cost-effective after migration, and that support teams are prepared to manage the new environment. |
| Monitoring and Observability | - Azure Monitor<br>- Application Insights<br>- Log Analytics<br>- Alerting and automated response systems | Provides visibility into workload performance and enables proactive issue resolution. |
| Cost Management and Optimization | - Azure Cost Management<br>- Azure Advisor<br>- Reserved instances<br>- Azure Hybrid Benefit | Ensures efficient resource utilization and budget control in Azure. |
| Security and Compliance Validation | - Microsoft Defender for Cloud<br>- Azure Policy<br>- Backup validation<br>- Disaster recovery testing | Ensures workloads maintain appropriate protection and meet regulatory requirements. |
| Operational Readiness and Support | - Runbook creation<br>- Training and documentation<br>- Escalation procedures<br>- User feedback collection<br>- Enhanced support coverage | Ensures teams can effectively manage and support migrated workloads. |
| Fallback Preparation | - Source environment retention<br>- DNS reversion<br>- Configuration restoration | Provides safety nets during the critical post-migration period to maintain business continuity. |

> [!div class="nextstepaction"]
> [Plan migration execution](plan-migration-execution.md)
