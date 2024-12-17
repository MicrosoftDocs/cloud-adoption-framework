---
title: Understand the functions of a central IT team
description: Understand the function of a central IT team, including the source, scope, deliverables, and risks.
author: martinekuan
ms.author: martinek
ms.date: 05/07/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency3
---

# Understand the functions of a central IT team

As cloud adoption scales, cloud governance functions alone might not be sufficient to govern adoption efforts. When adoption is gradual, teams tend to organically develop the necessary skills and processes to be ready for the cloud over time.

But when one cloud adoption team uses the cloud to achieve a high-profile business outcome, gradual adoption is seldom the case. Success follows success. This result is also true for cloud adoption, but it happens at cloud scale. When cloud adoption expands from one team to multiple teams relatively quickly, the organization needs more support from existing IT staff. But those staff members might lack the training and experience required to support the cloud using cloud-native IT tools. This gap in training and experience often drives the formation of a central IT team to govern the cloud.

> [!CAUTION]
> While setting up a central IT team is a common signal of maturity, if not managed effectively, it can become a high risk to adoption, potentially blocking innovation and migration efforts. See the following [Central IT team risks](#central-it-team-risks) section to learn how to mitigate the risk of centralization becoming a cultural antipattern.

The following disciplines and structures cover the requirements for setting up centralized IT functions:

- An existing central IT team
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
> You should only apply centralized IT in the cloud when you've based your existing delivery on-premises on the central IT team model. If you based your current on-premises model on delegated control, consider a cloud center of excellence (CCoE) approach for a more cloud-compatible alternative.

## Key responsibilities

Adapt existing IT practices to ensure that adoption efforts result in well-governed, well-managed environments in the cloud.

Typically, your team does the following tasks regularly:

### Strategic tasks

- Review:
  - [Business outcomes](../strategy/business-outcomes/index.md)
  - [Financial models](../strategy/cloud-migration-business-case.md)
  - [Motivations for cloud adoption](../strategy/motivations.md)
  - [Business risks](../govern/policy-compliance/risk-tolerance.md)
  - [Rationalize the digital estate](../digital-estate/index.md)
- Monitor adoption plans and progress against the [prioritized migration backlog](../migrate/migration-considerations/assess/release-iteration-backlog.md).
- Identify and prioritize required platform changes that support the migration backlog.
- Act as an intermediary or translation layer between cloud adoption needs and existing IT teams.
- Take advantage of existing IT teams to accelerate platform functions and enable adoption.

### Technical tasks

- Build and maintain the cloud platform to support solutions.
- Define and implement the platform architecture.
- Operate and manage the cloud platform.
- Continuously improve the platform.
- Keep up with new innovations in the cloud platform.
- Deliver new cloud functionality to support business value creation.
- Suggest self-service solutions.
- Ensure that solutions meet existing governance and compliance requirements.
- Create and validate deployment of platform architecture.
- Review release plans for sources of new platform requirements.

## Meeting cadence

Central IT team expertise usually comes from a working team. Expect participants to commit much of their daily schedules to alignment efforts. Contributions aren't limited to meetings and feedback cycles.

## Central IT team risks

Prefix each of the cloud functions and phases of organizational maturity with the word "cloud". The central IT team is the only exception. Centralized IT became prevalent when all IT assets could be housed in few locations, managed by a few teams, and controlled through a single operations management platform. Global business practices and the digital economy have largely reduced the instances of those centrally managed environments.

In the modern view of IT, assets are globally distributed. Responsibilities are delegated. A mixture of internal staff, managed service providers, and cloud providers deliver operations management. In the digital economy, IT management practices are transitioning to a model of self-service and delegated control with clear guardrails to enforce governance. A central IT team can be a valuable contributor to cloud adoption by becoming a cloud broker and a partner for innovation and business agility.

A central IT team is well positioned to take valuable knowledge and practices from existing on-premises models and apply those practices to cloud delivery. But this process requires change. It requires new processes, new skills, and new tools to support cloud adoption at scale. When a central IT team adapts, it becomes an important partner in cloud adoption efforts. But if the central IT team doesn't adapt to the cloud, or attempts to use the cloud as a catalyst for tight-grain controls, it quickly becomes a blocker to adoption, innovation, and migration.

The measures of this risk are speed and flexibility. The cloud simplifies adopting new technologies quickly. When new cloud functionality can be deployed within minutes, but the reviews by the central IT team add weeks or months to the deployment process, these centralized processes become a major impediment to business success. When you encounter this indicator, consider alternative strategies to IT delivery.

### Exceptions

Many industries require rigid adherence to third-party compliance. Some compliance requirements still demand centralized IT control. Delivering on these compliance measures can add time to deployment processes, especially for new technologies that haven't been used broadly. In these scenarios, expect delays in deployment during the early stages of adoption. Similar situations might exist for companies that deal with sensitive customer data, but might not be governed by a third-party compliance requirement.

### Operate within the exceptions

When centralized IT processes are required and those processes create appropriate checkpoints in adoption of new technologies, these innovation checkpoints can still be addressed quickly. Governance and compliance requirements are designed to protect those things that are sensitive, not to protect everything. The cloud provides simple mechanisms for acquiring and deploying isolated resources while maintaining proper guardrails.

A mature central IT team maintains necessary protections but negotiates practices that still enable innovation. Demonstrating this level of maturity depends on proper classification and isolation of resources.

### Example narrative of operating within exceptions to empower adoption

This example narrative illustrates the approach taken by a mature central IT team at the fictional company Contoso to empower adoption.

Contoso adopts a central IT team model to support the business's cloud resources. To deliver this model, they implement tight controls for various shared services such as ingress network connections. This wise move reduces the exposure of their cloud environment and provides a single "break-glass" device to block all traffic if a breach occurs. Their Security Baseline policies state that all ingress traffic must come through a shared device managed by the central IT team.

But one of their cloud adoption teams now requires an environment with a dedicated and specially configured ingress network connection to use a specific cloud technology. An immature central IT team would just refuse the request and prioritize its existing processes over adoption needs. Contoso's central IT team is different. They quickly identify a simple four-part solution to this dilemma:

  1. **Classification**: Because the cloud adoption team is in the early stages of building a new solution and doesn't have any sensitive data or mission-critical support needs, they classify the assets in the environment as low risk and noncritical. Effective classification shows maturity in a central IT team. Classifying all assets and environments allows for clearer policies.
  
  1. **Negotiation**: Classification alone isn't sufficient. The company implements shared services to consistently operate sensitive and mission-critical assets. Changing the rules compromises governance and compliance policies designed for the assets that need more protection. Empowering adoption can't happen at the cost of stability, security, or governance. This leads to a negotiation with the adoption team to answer specific questions. Can a business-led DevOps team provide operations management for this environment? Does this solution require direct access to other internal resources? If the cloud adoption team is comfortable with the tradeoffs, the ingress traffic might be possible.
  
  1. **Isolation**: Because the business provides its own ongoing operations management, and because the solution doesn't rely on direct traffic to other internal assets, the solution is then cordoned off in a new subscription. That subscription is also added to a separate node of the new management group hierarchy.
  
  1. **Automation**: Automation principles are another sign of maturity for this team. The team uses Azure Policy to automate policy enforcement. They also use infrastructure as code (IaC) to automate deployment of common platform components and enforce adherence to the defined identity baseline. The policies and templates vary slightly for this subscription and for all others in the new management group. Policies that block ingress bandwidth are lifted. The policies are then replaced by requirements to route traffic through the shared services subscription, like ingress traffic, to enforce traffic isolation. Because the on-premises operations management tooling can't access this subscription, agents for that tool are also no longer required. All other governance guardrails required by other subscriptions in the management group hierarchy are still enforced, which ensures sufficient guardrails.

The mature creative approach of Contoso's central IT team provides a solution that doesn't compromise governance or compliance, but still encourages adoption. This approach of brokering rather than owning cloud-native approaches to centralized IT is the first step toward building a cloud center of excellence (CCoE). Adopting this approach to quickly evolve existing policies allows for centralized control when it's required and governance guardrails when more flexibility is acceptable. Balancing these two considerations mitigates the risks associated with centralized IT in the cloud.

## Next steps

- As a central IT team matures its cloud capabilities, the next maturity step is typically a looser coupling of cloud operations. The availability of cloud-native operations management tooling and lower operating costs for PaaS-first solutions often lead to business teams (or more specifically, DevOps teams within the business) assuming responsibility for cloud operations.

Learn more about:

- [Cloud operations functions](./cloud-operations.md)