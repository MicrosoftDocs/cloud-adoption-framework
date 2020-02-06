---
title: "Central IT capabilities"
description: Learn about the formation of central IT capabilities.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/10/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: organize
---

# Central IT capabilities

As cloud adoption scales, cloud governance capabilities alone may not be sufficient to govern adoption efforts. When adoption is gradual, teams tend to organically develop the skills and processes needed to be ready for the cloud over time.

However, when one cloud adoption team uses the cloud to achieve a high-profile business outcome, gradual adoption is seldom the case. Success follows success. This is also true for cloud adoption, but it happens at cloud scale. When cloud adoption expands from one team to multiple teams relatively quickly, additional support from existing IT staff is needed. However, those staff members may lack the training and experience required to support the cloud using cloud-native IT tools. This often drives the formation of a central IT team governing the cloud.

> [!CAUTION]
> While this is a common maturity step, it can present a high risk to adoption, potentially blocking innovation and migration efforts if not managed effectively. See the risk section below to learn how to mitigate the risk of centralization becoming a cultural antipattern.

## Possible sources for central IT expertise

The skills needed to provide centralized IT capabilities could be provided by:

- An existing Central IT team
- Enterprise architects
- IT operations
- IT governance
- IT infrastructure
- Networking
- Identity
- Virtualization
- Business continuity and disaster recovery
- Application owners within IT

> [!WARNING]
> Central IT should only be applied in the cloud when existing delivery on-premises is based on a Central IT model. If the current on-premises model is based on delegated control, consider a cloud center of excellence (CCoE) approach for a more compatible alternative.

## Key responsibilities

Adapt existing IT practices to ensure adoption efforts result in well-governed, well-managed environments in the cloud.

The following tasks are typically executed regularly:

### Strategic tasks

- Review:
  - [business outcomes](../strategy/business-outcomes/index.md)
  - [financial models](../strategy/financial-models.md)
  - [motivations for cloud adoption](../strategy/motivations.md)
  - [business risks](../govern/policy-compliance/risk-tolerance.md)
  - [rationalization of the digital estate](../digital-estate/index.md)
- Monitor adoption plans and progress against the [prioritized migration backlog](../migrate/migration-considerations/assess/release-iteration-backlog.md).
- Identify and prioritize platform changes that are required to support the migration backlog.
- Act as an intermediary or translation layer between cloud adoption needs and existing IT teams.
- Leverage existing IT teams to accelerate platform capabilities and enable adoption.

### Technical tasks

- Build and maintain the cloud platform to support solutions.
- Define and implement the platform architecture.
- Operate and manage the cloud platform.
- Continuously improve the platform.
- Keep up with new innovations in the cloud platform.
- Deliver new cloud capabilities to support business value creation.
- Suggest self-service solutions.
- Ensure that solutions meet existing governance and compliance requirements.
- Create and validate deployment of platform architecture.
- Review release plans for sources of new platform requirements.

## Meeting cadence

Central IT expertise usually comes from a working team. Expect participants to commit much of their daily schedules to alignment efforts. Contributions aren't limited to meetings and feedback cycles.

## Central IT risks

Each of the cloud capabilities and phases of organizational maturity are prefixed with the word "cloud". Central IT is the only exception. Central IT became prevalent when all IT assets could be housed in few locations, managed by a small number of teams, and controlled through a single operations management platform. Global business practices and the digital economy have largely reduced the instances of those centrally managed environments.

In the modern view of IT, assets are globally distributed. Responsibilities are delegated. Operations management is delivered by a mixture of internal staff, managed service providers, and cloud providers. In the digital economy, IT management practices are transitioning to a model of self-service and delegated control with clear guardrails to enforce governance. Central IT can be a valuable contributor to cloud adoption by becoming a cloud broker and a partner for innovation and business agility.

Central IT as a function is well positioned to take valuable knowledge and practices from existing on-premises models and apply those practices to cloud delivery. However, this process will require change. New processes, new skills, and new tools are required to support cloud adoption at scale. When Central IT adapts, it becomes an important partner in cloud adoption efforts. However, if Central IT doesn't adapt to the cloud, or attempts to use the cloud as a catalyst for tight-grain controls, Central IT quickly becomes a blocker to adoption, innovation, and migration.

The measures of this risk are speed and flexibility. The cloud simplifies adopting new technologies quickly. When new cloud capabilities can be deployed within minutes, but Central IT reviews add weeks or months to the deployment process, then these centralized processes become a major impediment to business success. When this indicator is encountered, consider alternative strategies to IT delivery.

### Exceptions

Many industries require rigid adherence to third-party compliance. Some compliance requirements still demand centralized IT control. Delivering on these compliance measures can add time to deployment processes, especially for new technologies that haven't been used broadly. In these scenarios, expect delays in deployment during the early stages of adoption. Similar situations my exist for companies that deal with sensitive customer data, but may not be governed by a third-party compliance requirement.

### Operate within the exceptions

When centralized IT processes are required and those processes create appropriate checkpoints in adoption of new technologies, these innovation checkpoints can still be addressed quickly. Governance and compliance requirements are designed to protect those things that are sensitive, not to protect everything. The cloud provides simple mechanisms for acquiring and deploying isolated resources while maintaining proper guardrails.

A mature Central IT team maintains necessary protections but negotiates practices that still enable innovation. Demonstrating this level of maturity depends on proper classification and isolation of resources.

### Example narrative of operating within exceptions to empower adoption

This example narrative illustrates the approach taken by a mature Central IT team to empower adoption.

Contoso, LLC has adopted a Central IT model for the support of the business's cloud resources. To deliver this model, they have implemented tight controls for various shared services such as ingress network connections. This wise move reduced the exposure of their cloud environment and provided a single "break-glass" device to block all traffic in case of a breach. Their security baseline policies state that all ingress traffic must come through a shared device managed by the Central IT team.

However, one of their cloud adoption teams now requires an environment with a dedicated and specially configured ingress network connection to use a specific cloud technology. An immature Central IT team would simply refuse the request and prioritize its existing processes over adoption needs. Contoso's Central IT team is different. They quickly identified a simple four-part solution to this dilemma: Classification, Negotiation, Isolation, and Automation.

**Classification:** Since the cloud adoption team was in the early stages of building a new solution and didn't have any sensitive data or mission-critical support needs, the assets in the environment were classified as low risk and noncritical. Effective classification is a sign of maturity in Central IT. Classifying all assets and environments allows for clearer policies.

**Negotiation:** Classification alone isn't sufficient. Shared services were implemented to consistently operate sensitive and mission-critical assets. Changing the rules would compromise governance and compliance policies designed for the assets that need more protection. Empowering adoption can't happen at the cost of stability, security, or governance. This led to a negotiation with the adoption team to answer specific questions. Would a business-led DevOps team be able to provide operations management for this environment? Would this solution require direct access to other internal resources? If the cloud adoption team is comfortable with those tradeoffs, then the ingress traffic might be possible.

**Isolation:** Since the business can provide its own ongoing operations management, and since the solution doesn't rely on direct traffic to other internal assets, it can be cordoned off in a new subscription. That subscription is also added to a separate node of the new management group hierarchy.

**Automation:** Another sign of maturity in this team is their automation principles. The team uses Azure Policy to automate policy enforcement. They also use Azure Blueprints to automate deployment of common platform components and enforce adherence to the defined identity baseline. For this subscription and any others in the new management group, the policies and templates are slightly different. Policies blocking ingress bandwidth have been lifted. They have been replaced by requirements to route traffic through the shared services subscription, like any ingress traffic, to enforce traffic isolation. Since the on-premises operations management tooling can't access this subscription, agents for that tool are no longer required either. All other governance guardrails required by other subscriptions in the management group hierarchy are still enforced, ensuring sufficient guardrails.

The mature creative approach of Contoso's central IT team provided a solution that didn't compromise governance or compliance, but was still encouraged adoption. This approach of brokering rather than owning cloud-native approaches to centralized IT is the first step toward building a true cloud center of excellence (CCoE). Adopting this approach to quickly evolve existing policies will allow for centralized control when required and governance guardrails when more flexibility is acceptable. Balancing these two considerations mitigates the risks associated with Central IT in the cloud.

## Next steps

As Central IT matures in the cloud, the next maturity step is typically looser coupling of [cloud operations](./cloud-operations.md). The availability of cloud-native operations management tooling and lower operating costs for PaaS-first solutions often lead to business teams (or more specifically, DevOps teams within the business) assuming responsibility for cloud operations.

> [!div class="nextstepaction"]
> [Cloud operations capability](./cloud-operations.md)
