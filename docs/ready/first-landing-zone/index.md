---
title: Azure landing zone considerations
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/20/2019
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# First landing zone

Infrastructure as code is a fundamental building block for cloud adoption. Deploying the first landing zone(s) in the cloud are a common starting point to transition into a code-driven environment. This article will aid in defining the term landing zone and helping decide which landing zone is most appropriate for your current adoption needs.

## Landing zone definition

**Scope:** A landing zone is the basic building block of any cloud adoption environment. The term *landing zone* refers to a logical construct capturing everything that must be true to enable the desired cloud adoption. A fully functioning landing zone considers all platform resources that are required to support the customer’s adoption needs and does not necessarily differentiate between IaaS or PaaS adoption.

**Refactoring:** A functioning landing zone is the final deliverable of any iteration of the Cloud Adoption Framework's Ready methodology. During each iteration, the codebase which defines the landing zone will be refactored and/or expanded. After refactoring, the landing zone may be modified (or redeployed) allowing for new cloud adoption needs.

**Goal:** The goal of the landing zone approach is to create a common set of consistent platform implementations. Those consistent implementations must be in place to ensure that your applications have access to requisite components when deployed. Each landing zone iteration must consequently be designed and deployed in accordance with the requirements of the cloud adoption plan and the subscription design strategy.

**Principle purpose:** The principle purpose of the landing zone is therefore to ensure that when an application lands on Azure, the required "plumbing" is already in place. 

The purpose and scope of the overall cloud adoption plan will define what "plumbing" is required. Additional governance, compliance, security, and operational management requirements will likely add to the initial landing zone scope. During early stages of adoption, landing zones may include less "plumbing" as a result of defined requirements and acceptable risks. The following considerations outline the types of plumbing that are likely to be found in all landing zones.

> [!IMPORTANT]
> One example of an expanded principle purpose, is the [CAF Northstar](../../getting-started/northstar/index.md). The northstar approach focuses on adoption teams who have a mid-term objective (within 24 months) to host more than 1,000 assets (apps, infra, or data assets) in the cloud. For those teams, the scope and principle purpose of landing zones is much richer, as seen in the [CAF Northstar architecture article](../../getting-started/northstar/architecture.md#landing-zone---expanded-definition).

## Landing zone development

The following image shows a variety of landing zone options. The following options aid in selecting the right landing zone today. But, it also helps establish a future state vision for your landing zone needs of tomorrow.

![Landing zone options](../../_images/ready/landing-zone-options.png)

A. In the early phases of cloud adoption, it is common for adoption teams to start with a simple yet consistent landing zone, like the Cloud Adoption Framework's Migrate landing zone blueprint. The Migrate landing zone blueprint provides an automated means of creating a landing zone that can handle production workloads, but is not designed for sensitive data or mission critical workloads.

B. Since the infrastructure in the cloud is defined in code, it can be refactored much like any code base. As adoption grows and requirements become more clearly identified, adoption teams or platform teams will commonly refactor initial landing zones. This process of expanding the landing zone(s) prepares environments for more complex compliance or architecture requirements. [Expand the landing zone](../considerations/index.md) provides decision guides and links to best practices to guide refactoring efforts. Expanding the landing zone can aid in meeting security, operations, and governance requirements.

C. Some cloud adoption plans are governed by external compliance requirements. To reduce the burden of meeting compliance requirements, Azure provides a number of Azure Blueprint samples. Those samples can be added to any initial blueprint. Some of those samples also include reference implementations that could serve directly as a landing zone.

D. When a partner is providing on-going managed services or is contracted to deliver on the adoption plan, they will commonly provide their own landing zone. Leveraging a partner landing zone could accelerate adoption efforts and ensure consistent operational management requirements. However, additional considerations should be given to internal governance and security requirements to ensure alignment.

E. Adoption teams who have a mid-term objective (within 24 months) to host more than 1,000 assets (apps, infra, or data assets) in the cloud, may find value in the CAF NorthStar. CAF Northstar is a more advanced road map, including target-state platform architecture and reference implementations. This road map pulls forward aspects of parallel methodologies including governance and operations to better prepare for mission-critical, secure, complex, and compliance governed adoption.

## Choosing a first landing zone

Selection of the first landing depends on a number of variables. The following grid captures a few of the options for first landing zones, along with some of the variables which may drive the decision.

|Landing Zone  |Cloud experience  |Scale  |Cloud model|Technology|Production ready|Hybrid|Sensitive data|Mission critical|Compliance|
|---------|---------|---------|---------|---------|---------|---------|---------|
|[CAF Migrate](./migrate-landing-zone.md)|New to cloud|< 1,000 assets|Azure only|Azure Blueprint|Limited scope ->|Expansion required|Expansion required|Expansion required|Expansion required|
|[CAF Foundation](./foundation-blueprint.md)|Moderate experience|< 1,000 assets|Azure only|Azure Blueprint|Additive to CAF Migrate|Expansion required|Expansion required|Expansion required|Compliance tools deployed - configuration required|
|[CAF NorthStar](./northstar.md)|Deep expertise|> 1,000 assets|Azure only|Azure Resource Manager|Yes|Configured|Configured|Configured|Configured|Compliance tools deployed - configuration required|
|[CAF Terraform](../expanded-scope/terraform.md)|Various templates|Various templates|Multi-cloud|Terraform|Limited scope ->|Modules available|Modules available|Modules available|Modules available|Modules available|

## Next steps

Click on any of the landing zones above to get started with your first landing zone.
If you're unsure of which landing zone to start with, we suggest beginning with the [CAF Migrate landing zone blueprint](./migrate-landing-zone.md).

> [!div class="nextstepaction"]
> [CAF Migrate landing zone blueprint](./migrate-landing-zone.md)
