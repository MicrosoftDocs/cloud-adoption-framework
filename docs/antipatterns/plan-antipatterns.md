---
title: "Cloud adoption plan antipatterns"
description: Misalignment on the operating model(s), service models can however result in reduced time to market, misunderstandings, and increased pressure on the IT department.
author: mahia127
ms.author: brblanch
ms.date: 01/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
ms.custom: think-tank
---

# Cloud adoption plan antipatterns

Customers frequently experience a number of common cloud adoption antipatterns while in the planning phase of cloud adoption. Misalignment on the operating model(s) can result in reduced time to market, misunderstandings, and increased pressure on the IT department.Companies can use the wrong service model when it is purely based on the assumption that Platform as a Service (PaaS) leads to more cost savings. Change of architecture can lead to major replacement projects, that are not only very complex to manage and execute but also cost intensive.

## The wrong cloud operating model

Based on their strategic priority and scope of the portfolio, that needs to be managed, companies can define different cloud operating models with different types of accountability, landing zones and focus. The misalignment on the operating model(s) can however result in reduced time to market, misunderstandings, and increased pressure on the IT department.

### Example of the wrong operating model

AdventureWorks introduced an operation model in which the IT department has the accountability for everything that runs inside the cloud. However, the team responsible for the cloud, consists of three persons. This leads to a slow adoption journey as the team will only approve something when it fully understood the business, operations and security impact, even though it’s not their (main) area of expertise. This is leading to increased pressure by the business units where Subject Matter Experts want to use the service. Eventually Shadow-IT can be expected, where business units used company credit cards to create environments for themselves.

### Preferred outcome: Review, compare and choose the right operating model

Companies should [review and compare their current cloud operating model](../operating-model/compare.md) to explore different options and to be able to define one or more cloud operating models that suit them. The article mentioned above outlines the four most common cloud operations patterns. As soon as the operating model is decided roles will change. Therefore, it is necessary to [build a skill readiness plan](../plan/adapt-roles-skills-processes.md) upon new roles that are given due to the operating model change when moving to the cloud.

## The wrong "as a Service" model

Companies can use the wrong service model when it is purely based on the assumption that Platform as a Service (PaaS) leads to more cost savings when comparing it to Infrastructure as a Service (IaaS). This phenomenon can mostly be seen in cost-conscious companies that have "cost savings" as one of their main cloud adoption motivations. These companies tend to forget, that with the adoption of PaaS, processes need to be changed as well, especially when certain responsibilities are moved towards the cloud provider. This can lead to unforeseen cost increases and delays because the usage of PaaS can introduce more fundamental changes when looking at: Coordination efforts, engineering practices and delivery pipelines.

### Example of choosing the wrong service model

LitWare Inc. launches a program to migrate their data centers towards the cloud. The goal of the executives is to modernize their current application architecture and tooling all at once, to be most cost efficient and develop a more modern application portfolio. Therefore, the adoption strategy is to use PaaS over IaaS. A year into their cloud adoption journeys LitWare realized, that they have a very slow adoption rate since a lot of processes, practices and tools need to be changed to adopt PaaS to the full extent. The usual impacts and benefits of PaaS are not visible to the board, but the IT is seen slower than ever before, whilst the costs of the data centers are remaining the same.

### Preferred outcome: Adopt the cloud with the least disruption to your business

To reduce the coordination effort when adopting cloud in several cases it is a common strategy to start with IaaS for the first projects combined with introducing a cloud skilling initiative. The experiences that employees gather during the adoption of IaaS, can be used to faster adopt PaaS. The most common migration and modernization paths relate to the 5 Rs being: rehost, refactor, rearchitect, rebuild, replace described in [cloud rationalization](../digital-estate/5-rs-of-rationalization.md). When going for IaaS first you can adopt the cloud almost instantly without much disruption to your business and business processes.

Additionally, the effort of skilling and coordination needed to adapt the processes and practices are more manageable compared to the introduction. Especially in datacenter transformation scenarios, it's recommended to adopt IaaS fist and gradually modernize and adopt PaaS later, while the workload is already in the cloud. Using this strategy, the experiences gathered in the migration project can be used to reduce the effort of skilling and process changes when modernizing.

## Replacing over modernizing

Applications based on PaaS and SaaS are relatively easy to maintain and do not require big management efforts. Therefore, a lot of companies want to replace or redesign an old complex architecture landscapes with SaaS and cloud native concepts in mind, when adopting the cloud.  This change of architecture however, usually leads to major replacement projects, that are not only very complex to manage and execute but also cost intensive. Additionally, there are other substantial risks as processes and the operating model needs to be changed.

### Example of replacing over modernizing

AdventureWorks Inc. has a huge SAP environment. They want to replace the landscape, since they are having several issues when it comes to performance and stability. After starting of a replacement project, they realize that the due diligence list for replacing the whole environment is getting longer day by day as they go on. Therefore, they were exploring the option of gradually modernizing the environment and changing the hosting platform to Azure. They quickly realized that those changes result in a quick performance and stability. Hence, they change the scope of the project to modernizing their landscape, resulting in better performance and reliability for a fraction of the estimated replacement costs.

### Preferred outcome: understand your digital estate and rationalize the best way to migrate or modernize

Before replacing a rather huge and complex application environment, companies should explore the option of incrementally improving the environment by modernizing it, rather than replacing it. Therefore, it's highly recommended to understand the [digital estate companies](../digital-estate/index.md) have and when as well as how to match one of the [five Rs of rationalization](../digital-estate/5-rs-of-rationalization.md), being rehost, refactor, rearchitect, rebuild and replace.

Companies should keep in mind, that relatively small changes to the application environment might already have a huge impact on performance and reliability. Companies should ask themselves more questions before deciding on the innovation strategy by exploring the different options of modernization and evaluating these in e.g., a Proof of Concept (PoC).

## Next steps

- [Compare common cloud operating models](../operating-model/compare.md)
- [Build a skill readiness plan](../plan/adapt-roles-skills-processes.md)
- [Cloud rationalization](../digital-estate/5-rs-of-rationalization.md)
- [What is a digital estate?](../digital-estate/index.md)
