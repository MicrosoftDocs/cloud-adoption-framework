---
title: Landing zone deployment options
description: Which landing zone deployment option best fits your requirements
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Landing zone deployment options

The objective of an [Azure landing zone](./index.md) is to provide cloud adoption teams with a well-architected environment for their workloads. To reach that objective, the Microsoft recommendation is to follow the [landing zone design principles](./design-principles.md) discussed in the prior article.

Each of the following deployment options is built for a specific set of operating model dependencies to support your specific non-functional requirements. Each deployment option includes distinct automation approaches, reference architectures and reference implementations to accelerate your cloud adoption journey. While each is mapped to a different operating model, they all share the same design principles. The difference is how you choose to implement them.

## Platform development velocity

In addition to the recommended design principles, platform development velocity (how fast your platform team can develop the required skills) is a key factor in choosing the best deployment option. There are two primary modes to consider:

**Start with enterprise scale:** When business requirements necessitate a rich initial implementation of landing zones, with fully integrated governance, security, and operations from the start, Microsoft suggests the enterprise scale approach. This approach assumes existing skills in Azure platform automation, experience with GitHub, and deployment of DevOps pipelines with github actions. This approach will also implement opinionated options for platform automation, governance, security, and operations.

This approach will deploy X.

**Start small and scale:** If it is more important to develop these skills and commit to your own decisions as you learn more about the cloud, then a more modular approach may be beneficial. In this approach, the landing zone will only focus on implementing the basic landing zone considerations required to start cloud adoption. As adoption scales, modules in the Govern and Manage methodologies will build on top of your initial landing zone.

This approach will deploy y & iterate over time.

## Deployment options

The following grid captures some of the landing zone deployment options and variables that may drive the decision.

|Landing zone  |Deployment velocity  |Deeper design principles|
|---------|---------|---------|---------|---------|---------|---------|---------|
|[CAF Migrate](./migrate-landing-zone.md)|Start small|Link|
|[CAF Foundation](./foundation-blueprint.md)|Start small|Link|
|[CAF Enterprise-scale](./enterprise-scale.md)|Enterprise-scale|Link|
|[CAF Terraform](./terraform-landing-zone.md)|Either|Link|



|Landing zone  |Deployment velocity  |Scale  |Discovery time|Design principles|Governance principles|Management principles|
|---------|---------|---------|---------|---------|---------|---------|---------|
|[CAF Migrate](./migrate-landing-zone.md)|Start small|< 1,000 assets|one to five days|Included|Added through CAF Govern|Added through CAF Manage|
|[CAF Foundation](./foundation-blueprint.md)|Start small|< 1,000 assets|one to five days|Included|Added through CAF Govern|Added through CAF Manage|
|[CAF Enterprise-scale](./enterprise-scale.md)|Enterprise-scale|> 1,000 assets|3 to 6 weeks|Included|Configuration required|Configuration required|
|[CAF Terraform](./terraform-landing-zone.md)|Either|Various templates|3 to 6 weeks|Included|Added through CAF Govern modules|Added through CAF Manage modules|

The following table looks at the same deployment options from a slightly different perspective to guide more technical decision processes.

| Landing zone                                 | Hub                          | Spoke    | Cloud model | Deployment Technology |
|----------------------------------------------|------------------------------|----------|-------------|-----------------|--|--|--|
| [CAF Enterprise-scale](./enterprise-scale.md) | Included       | Included | Multicloud  | Azure Policy and GitHub |
| [CAF Migrate](./migrate-landing-zone.md)     | Refactor required            | Included | Azure only  | Azure Blueprint |
| [CAF Terraform](./terraform-landing-zone.md) | Included in Virtual Datacenter module       | Included | Multicloud  | Terraform       |

## Next steps

If you're still unsure which landing zone to choose first, we recommend starting with the [CAF Migrate landing zone blueprint](./migrate-landing-zone.md).

> [!div class="nextstepaction"]
> [CAF Migrate landing zone blueprint](./migrate-landing-zone.md)
