---
title: Adopt for defense cloud adoption
description: Recommendations for adopting cloud technologies in a defense organization
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 12/6/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
---
# Adopt for defense cloud adoption

The adopt methodology focuses on defense workloads and falls in the mission domain of cloud adoption. Workloads are collections of resources that support a specific capability. The mission domain is cyclical. The domain iterates through the adopt, secure, and manage methodologies throughout the lifecycle of workloads.

:::image type="content" source="./images/mission.png" alt-text="Figure that shows a domain tracker. It shows command, platform, and mission. Mission is highlighted to show we're in the mission domain of cloud adoption." border="false":::
*Figure 1: Domain tracker - mission domain*

During the adopt phase, defense workloads start their journey in the cloud and iterative capitalize on cloud benefits over time. Adopt encompasses migration, modernization, and innovation:

- Migration brings workloads to the cloud.
- Modernization lowers the total cost of ownership (TCO) while driving security, performance, and efficiency.
- Innovation is where defense organizations start building cloud native solutions to meet data needs.

There are a few important considerations to be aware of in the adopt phase.

## Create a tailored migration plan

The migration of a defense workload must be secure and often requires minimal downtime. Defense teams should work with their cloud brokers and customer representatives to build a migration plan that meets the needs of each workload. The right migration plan will save time, money, and headaches.  

**Migration considerations** - There are different approaches to migration. An important strategy to consider in defense contexts is a phased migration approach. A phased migration approach is a common strategy for large, legacy workloads that are mission essential. The general idea is to migrate portions of the workload at a time so that the workload remains accessible to end users during the migration. The workload operates in a hybrid state while the migration is in progress. This migration strategy adds complexity and cost but is sometimes necessary.

However, not all applications require a phased migration. Some are small enough or not important enough to warrant this level of attention. Mission owners need to assess the importance of each workload against defense policies to create a migration strategy that works for each workload.

Azure has a migration tool that can migrate defense workloads. For more information, see:

- [Overview of Azure Migrate service](/azure/migrate/migrate-services-overview)
- [Azure Migrate service in Azure Gov cloud](/azure/migrate/deploy-appliance-script-government)

**Secure data transfer** - It’s important to keep data encrypted during migration. There are two main approaches for transferring encrypted data to the cloud. It can be transferred the dedicated connection between the defense network and the cloud environment. But for transfers that would take several days to complete, Azure Import/Export service is the best data migration option. Encrypted data is loaded on an external hard disk, shipped to Azure Government datacenters, and uploaded to the corresponding cloud environment.

For more information, see [using Azure Import/Export](/azure/import-export/storage-import-export-service).

## Incentivize modernization

Modernization is all about maximizing value and should be a priority for mission owners. Without modernization, it’s difficult to experience the true benefits of the cloud, more capabilities for less work and money. Two best practices related to requirements and technology are relevant here.

**Modernization requirements** - The way cloud services are acquired can affect the pace of modernization. It’s common for defense organizations to operate the landing zone separately from the workloads that sit on top of it. The best approach is to have the cloud-broker build and manage the landing zone while mission owner teams manage the workloads on the platform. However, this separation of duties creates security boundaries but can also stifle modernization. So it’s important that mission owners incentivize technical teams to adopt new technologies so that defense workloads can meet current and future demands. Building modernization into requirements and setting milestones against modernization goals is an effective approach. Require proposals for technical solutions to outline how modernization efforts align to process improvements, application enhancement, and database configurations. The proposed solutions should align with mission objectives.

For more information, see [modernization alignment](../../modernize/business-alignment/index.md).

**Consider platform-as-a-service (PaaS)** - Azure infrastructure-as-a-service (IaaS) solutions provide a level of technical control that many defense organizations need. The downside of IaaS control is less productivity. Productivity means doing and getting more with less. The more management technical teams take on the less time they have for innovation.

PaaS solutions provide a balance of control and productivity. If they’re available in Azure Gov Cloud, then they're approved and secure enough to use. Many defense organizations are wary of PaaS solutions because of vendor lock-in and a loss of control. This reaction is good but not applicable here.

PaaS solutions are platforms. Mission owners control the code and data but offload the management of the underlying infrastructure. Azure handles infrastructure hardening, patching, scaling, and provisioning. Platforms create minimal risk of vendor lock-in and can improve security. Defense organizations can focus more on application security and improving code when they optimize routine security tasks. PaaS solutions can help defense organizations meet mission objectives faster.

For more information, see [PaaS adoption](../../modernize/modernize-strategies/index.md).

## Use DevOps where possible

DevOps is an Agile methodology that focuses on delivering value. DevOps synchronizes development and operations into an iterative process that aims to generate value fast. Prioritization of tasks is the key mechanism. When worked is prioritized, teams finish the highest priority tasks first. Work is also time-bound to create a feedback loop that accelerates learning and speeds up delivery.

Defense standards and risk mitigation processes tend to limit the extent that defense organizations can implement true DevOps. Protocols, regulations, and contracting lifecycles force defense development and operations into waterfall framework. However, it’s possible to apply DevOps principles within the confines of these regulations. Here are a few DevOps recommendations:

**Align to existing process** - DevOps shouldn’t break existing structure. It should align to it. It's worth considering how a full adoption of DevOps can enhance workloads, but until that time, DevOps should work within existing operations. If current operations are more waterfall, DevOps strategies can work between those sequential milestones. DevOps implementations should account for the mandatory handoffs and sequential checkpoints many defense risk management processes are founded on. An approach that disregards the current system is destined to fail.

**Improve quickly** - The ability to iterate through tasks multiple times with reviews allows technical teams to improve development and operations quickly. Teams should work on developing a minimum viable product and a proof-of-concept and improve them until they meet mission objectives.

**Use continuous integration and continuous deployment (CI/CD)** - CI/CD is a standard DevOps concept. It’s an automated approach to constantly improve and deploy code into production. Rarely is it a good idea to deploy code changes on mission critical workloads directly into production, so this approach needs to be modified for defense scenarios. We recommend two CI/CD pipelines for mission-critical workloads. The first CI/CD pipeline should create a stage deployment that can be rigorously tested. Code can be deployed to production only after passing all required tests. Development teams will need to fine tune the process to ensure tests can be completed on staged deliverables as quickly as they arrive. For more information our CI/CD capabilities, see [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines).

**DevOps tools** - The adoption of DevOps tools is needed to make DevOps work. Create a list of needed DevOps tools with their impact-level authorizations mapped to their DevOps process. This mapping might be a good requirement for proposals and will help determine how much DevOps can be adopted.

For more information on DevOps, see:

- [Process modernization](../../modernize/modernize-strategies/process-modernization.md)
- [Azure DevOps](/azure/devops/)

## Next step

The secure methodology is next, and the cloud offers security professional useful tools for protecting workloads.

> [!div class="nextstepaction"]
> [Secure](secure.md)
