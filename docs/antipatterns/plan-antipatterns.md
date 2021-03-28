---
title: Cloud adoption plan antipatterns
description: Avoid cloud adoption planning antipatterns like choosing replacement projects over modernization and using the wrong operating or service model.
author: mahia127
ms.author: brblanch
ms.date: 02/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
ms.custom: think-tank
---

# Cloud adoption plan antipatterns

Customers often experience antipatterns while planning a cloud adoption, for many reasons:

- Misaligned operating models can lead to increased time to market, misunderstandings, and increased pressure on IT departments.
- Companies sometimes choose the wrong service model when they assume that platform as a service (PaaS) decreases costs.
- When an organization's architecture changes, major replacement projects can result. Managing these projects is often complex and cost intensive.

## Antipattern: Choose the wrong cloud operating model

A company's strategic priorities and the scope of its portfolio determine its cloud operating model. Models can have different types of accountability, landing zones, and focus. When models don't line up with company goals, problems can result:

- Increased time to market
- Misunderstandings
- Increased pressure on IT departments

### Example: Assign too much responsibility to a small team

A corporation introduces an operating model that makes the IT department accountable for everything that runs inside the cloud. The team that's responsible for the cloud contains three people. This setup leads to a slow adoption journey, because:

- The team only approves measures after fully understanding their impact on the business, operations, and security.
- These issues aren't the team's main area of expertise.

Subject matter experts would like to use the cloud service, so business units increase pressure. Shadow IT will probably emerge as business units use company credit cards to create environments for themselves.

### Preferred outcome: Compare models and build a readiness plan

Review strategic priorities, portfolio scope, requirements, and constraints. Explore operating model options by [comparing the four most common cloud operations patterns](../operating-model/compare.md) with your current cloud operating model. Identify one or more cloud operating models that suit your organization. Then decide on a model. Because roles change with operating models, [build a skill readiness plan](../plan/adapt-roles-skills-processes.md) before moving to the cloud.

## Antipattern: Choose the wrong service model

Companies sometimes assume that PaaS solutions cost less than infrastructure as a service (IaaS) solutions. This assumption can lead to the wrong choice of service model. Cost-conscious companies often make this mistake when their main reason for moving to the cloud is to save costs. These companies forget that they also need to change processes when they adopt PaaS, especially when they move certain responsibilities to cloud providers. Switching to PaaS introduces fundamental changes in coordination efforts, engineering practices, and delivery pipelines. Unexpected cost increases and delays can result.

### Example: Choose PaaS over IaaS

A publisher launches a program to migrate its datacenters to the cloud. The executives would like to modernize their current application architecture and tooling all at once. Their reasons include:

- Maximizing cost efficiency.
- Developing a more modern application portfolio.

For their adoption strategy, they choose PaaS over IaaS. A year into their cloud adoption journey, they have a slow adoption rate. They've had to change numerous processes, practices, and tools to adopt PaaS to the full extent. The board doesn't see the usual impacts and benefits associated with PaaS. At the same time, IT is slower than ever, while datacenter costs remain the same.

### Preferred outcome: Minimize disruption to your business

To reduce coordination efforts, start with IaaS for initial cloud adoption projects. Adopting new processes and practices is more manageable when you move to the cloud later instead of at the outset. Adopt IaaS first, especially in datacenter transformation scenarios. At the same time, launch a cloud skills initiative.

Gradually modernize and adopt PaaS later, after the workload is already in the cloud. The experience that you've gained will help you adopt PaaS faster. You'll need to learn fewer new skills and processes for modernization. You also won't significantly disrupt your business processes.

Evaluate digital assets according to [cloud rationalization](../digital-estate/5-rs-of-rationalization.md). This article describes the most common migration and modernization paths, or the five Rs:

- Rehost
- Refactor
- Rearchitect
- Rebuild
- Replace

## Antipattern: Replace architecture

Applications that are based on PaaS and software as a service (SaaS) are relatively easy to maintain. They usually require little effort from management. As a result, many companies redesign old, complex architecture landscapes by replacing them with SaaS and cloud-native concepts. This architecture change usually leads to major replacement projects. It's a complex, cost-intensive task to manage and execute these projects. Changing processes and the operating model also involves other substantial risks.

### Example: Choose replacement over modernization

A corporation has a large SAP environment. The IT department would like to replace this landscape, which is causing several performance and stability issues. After IT starts on a replacement project, the due diligence list for replacing the entire environment gets longer every day.

### Preferred outcome: Rationalize your digital estate

Before you replace a large or complex application environment, consider incrementally improving your environment by modernizing instead. Relatively small changes to your application environment can have a huge impact on performance and reliability. For instance, changing the hosting platform to Azure can provide stability and quick results. Improved performance and reliability result, at a fraction of the estimated replacement cost.

When deciding on an innovation strategy, explore different modernization options. Evaluate these options in a proof of concept (POC).

Understand your company's [digital estate](../digital-estate/index.md). Determine which of the [five Rs of rationalization](../digital-estate/5-rs-of-rationalization.md) works best for modernizing or migrating your assets:

- Rehost
- Refactor
- Rearchitect
- Rebuild
- Replace

## Next steps

- [Compare common cloud operating models](../operating-model/compare.md)
- [Build a skill readiness plan](../plan/adapt-roles-skills-processes.md)
- [Cloud rationalization](../digital-estate/5-rs-of-rationalization.md)
- [What is a digital estate?](../digital-estate/index.md)
