---
title: Azure landing zone considerations
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- cSpell:ignore CAF -->

# First landing zone

Infrastructure as code is a natural transition during most cloud adoption efforts. Deploying the first landing zone(s) in the cloud are a common starting point to transition into a code-driven environment. This article will define the term _landing zone_ and help you decide which landing zone is most appropriate for your current adoption needs.

## Code-first options to get started

The image below shows a variety of landing zone options. The following options help you select the right landing zone today. It also helps establish a vision for your future landing zone needs.

![Landing zone options](../../_images/ready/landing-zone-options.png)

- Use the CAF Foundations and CAF Migration blueprints to produce consistent, repeatable landing zones. If you are comfortable with refactoring (or refining the code and infrastructure) as you learn, start with a lightweight code base, like the Cloud Adoption Framework's Migrate landing zone blueprint. This approach accelerates adoption success and creates hands-on learning opportunities. However, this type of initial landing zone is not intended for sensitive data or mission-critical workloads without additional refactoring.

- Expand the landing zone as adoption grows and requirements become more clearly identified. The adoption and platform teams will refactor landing zones based on what they learn. The process of expanding landing zones prepares environments for more complex compliance or architecture requirements. [Expand the landing zone](../considerations/index.md) provides decision guides and links to best practices to guide refactoring efforts. Expanding the landing zone can help meet security, operations, and governance requirements.

- Use more advanced blueprints when adoption plans are governed by external compliance requirements. To reduce the burden of meeting compliance requirements, Azure Blueprints provides a few samples. Some of the samples can be added to your first initial blueprint. Other samples also include a specific implementation to serve as a first landing zone.

- When a partner provides ongoing managed services or is contracted to deliver on the adoption plan, they commonly provide their own landing zone. Using a partner landing zone can accelerate adoption efforts and ensure consistent operational management requirements. However, additional considerations should be given to internal governance and security requirements to ensure alignment.

- Start with an enterprise-ready landing zone generated using the CAF Northstar approach when the adoption teams have a midterm objective (within 24 months) to **host more than 1,000 assets (apps, infra, or data assets) in the cloud**, should look to the CAF NorthStar as a guide platform architecture and landing zones. CAF Northstar is a more advanced approach, which includes both target-state platform architecture **and** reference implementations.
    - This approach pulls forward aspects of parallel methodologies including governance and operations to better prepare for mission-critical, secure, complex, and compliance-governed adoption.
    - This approach also creates the ability to generate multiple landing zones from a common architecture.
    - If options A through D are the best starting point, platform teams are still encouraged to leverage the CAF NorthStar implementation and architecture as an end-state reference during refactoring efforts.

## Other data points to influence the choice of a first landing zone

Selection of the first landing zone depends on multiple variables. The following grid captures some of the options for first landing zones, along with variables that may drive the decision.

|Landing Zone  |Cloud experience  |Scale  |Discovery time|Production ready|Hybrid|Sensitive data|Mission critical|Compliance|
|---------|---------|---------|---------|---------|---------|---------|---------|
|[CAF Migrate](./migrate-landing-zone.md)|New to cloud|< 1,000 assets|1 - 5 days|Limited scope ->|Expansion required|Expansion required|Expansion required|Expansion required|
|[CAF Foundation](./foundation-blueprint.md)|Moderate experience|< 1,000 assets|1 - 5 days|Additive to CAF Migrate|Expansion required|Expansion required|Expansion required|Compliance tools deployed - configuration required|
|[CAF NorthStar](./northstar-landing-zone.md)|Deep expertise|> 1,000 assets|10 - 20 weeks|Yes|Configured|Configured|Configured|Compliance tools deployed - configuration required|
|[CAF Terraform](./terraform-landing-zone.md)|Various templates|Various templates|10 - 20 weeks|Limited scope ->|Modules available|Modules available|Modules available|Modules available|

The following table looks at the same landing zones from a slightly different perspective to guide more technical decision processes.

| Landing Zone                                 | Hub                          | Spoke    | Cloud model | Technology      |
|----------------------------------------------|------------------------------|----------|-------------|-----------------|--|--|--|
| [CAF Migrate](./migrate-landing-zone.md)     | Refactor required            | Included | Azure only  | Azure Blueprint |
| [CAF Terraform](./terraform-landing-zone.md) | Included in VDC module       | Included | Multicloud  | Terraform       |

## Next steps

If you're still unsure which first landing zone to choose, we recommend starting with the [CAF Migrate landing zone blueprint](./migrate-landing-zone.md).

> [!div class="nextstepaction"]
> [CAF Migrate landing zone blueprint](./migrate-landing-zone.md)
