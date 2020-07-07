---
title: Azure landing zones - Partner implementation options
description: Learn how to validate partner implementation options
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/07/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Evaluate a Microsoft partner's Azure landing zone

The Cloud Adoption Framework approaches cloud adoption as a self-service activity. The objective is to empower each of the teams supporting adoption through standardized approaches. In reality, it is not safe to assume that a self-service approach will be sufficient for all adoption activities.

Successful cloud adoption programs typically involve at least one level of third party support. Many cloud adoption efforts require support from a Systems Integration (SI) or consulting partner who provides services to accelerate cloud adoption. Additionally, successful cloud adoption efforts tend to engage one or more Independent Software Vendors (ISV) who provide software-based services that accelerate cloud adoption. SIs, ISVs, and other forms of Microsoft partners have aligned their offerings to specific methodologies found in the cloud adoption framework. When a partner is aligned to a the Ready methodology of this framework, they will likely offer their own Azure landing zone implementation option.

This article provides a series of questions to help create an understanding of the scope of the partner's Azure landing zone offering.

> [!WARNING]
> Partner offerings and Azure landing zone implementation options are defined by the partner, based on their extensive experience helping customers adopt the cloud.
>
>Partner's may choose to omit the implementation of specific design areas in their initial landing zone implementation. But they should be able to communicate when & how each design area is implemented (& when possible a range of costs to complete that design area).
>Other partner solutions could be flexible enough to support multiple options for each of the questions below.
>Use these questions to ensure you are comparing partner offers and self-service options equally.

## Find a partner

If you need to find a partner to implement your Azure landing zone(s), start with the approved list of Cloud Adoption Framework (CAF) aligned partners. Specifically start with partners who have [offers aligned to the CAF Ready methodology](https://www.microsoft.com/azure/partners/adopt?filters=ready).

Additionally, all [Azure Expert Managed Service Providers (MSPs)](https://www.microsoft.com/en-us/solution-providers/search?cacheId=9c2fed4f-f9e2-42fb-8966-4c565f08f11e) have been audited to validate their ability to deliver each methodology in the Cloud Adoption Framework. While they may not all have an aligned offer, each of these partners has demonstrated alignment during technical delivery.

## Validate partner offer

Once a partner is selected, use the remainder of this article to guide the validation of the partner offer. Each section includes a summary of what to look for & a list of questions to ask the partner. The partner's answers to these questions are not right or wrong. Instead, the questions are designed to help you evaluate if the partner's offer will meet your business requirements.

## Platform development velocity

As outlined in the [Azure landing zone implementation options](./implementation-options.md), there are two high-level approaches to landing zone implementation based on how you want to develop your landing zones.

**Question for the partner:** Which of the following approaches are supported by the partner's Azure landing zone solution?

- Start small and expand: Starts with a smaller, light-weight template to get started. The landing zone solution will be matured over-time, as your desired cloud operating model becomes clearer.
- Start with enterprise scale: Starts with a more comprehensive reference implementation. The reference architecture builds on a well-defined cloud operating model, which requires less iteration to reach a mature solution.
- Other: The partner has a modified approach & should be able to describe the approach.

## Design principles

All Azure landing zones must consider the following set of common design areas. We refer to the way those design areas are implemented as design principles. The following sections will help validate the partner's design principles that define the Azure landing zone implementation.

### Deployment options

Partners who offer an Azure landing zone solution may support one or more options to deploy (or modify/expand the landing zone) the solution to your Azure tenant.

**Question for the partner:** Which of the following does your Azure landing zone solution support?

- Configuration automation: Does the solution deploy the landing zone from a deployment pipeline or deployment tool?
- Manual configuration: Does the solution empower the IT team to manually configure the landing zone, without injecting errors into the landing zone source code?

**Question for the partner:** Which of the Azure landing zone implementation options are supported by the partner's solution? See the [Azure landing zone implementation options](./implementation-options.md) article for a full list of options.

### Enterprise enrollment

Customers can purchase Azure in a "Pay-as-you-go" option, paying for what you use each month. But there are a few options for purchasing Azure that may better meet the business requirements.

**Question for the partner:** Which of the following buying options does the partner solution support?

- Pay-as-you-go (PAYG): The solution deploys and manages landing zones in individual PAYG subscriptions.
- Enterprise tenant: The solution deploys and manages landing zones in an business enrolment/contract which connects multiple subscriptions under one billing and security account.
- Partner tenant: The solution deploys and manages landing zones in partner-owned subscriptions to support managed services &/or IT outsourcing options.

### Identity

Identity is perhaps the most important design area to evaluate in the partner solution.

**Question for the partner:** Which of the following identity management options does the partner solution support?

- Azure AD: The suggested best practice is to use Azure AD and Role-based Access Control to manage identity and access in Azure.
- Active Directory: If required, does the partner solution provide an option to deploy Active directory as an infrastructure-as-a-service solution?
- Third-party identity provider: If your company uses a third-party identity solution, it is important to understand if/how the partner's Azure landing zone integrates with the third-party solution.

### Network topology and connectivity

Network is arguably the second most important design area to evaluate. There are several best practice approaches to network topology and connectivity.

**Question for the partner:** Which of the following options is included with the partner's Azure landing zone solution? Are any of the following options incompatible with the partner's solution?

- Virtual network: Will the partner solution configure a virtual network? Can the network topology of that network we modified to meet your technical or business constraints?
- Virtual private network (VPN): Is VPN configuration included in the partner's landing zone design to connect the cloud to existing data centers or offices?
- High-speed connectivity: Is a high-speed connection, like Azure Express Route included in the landing zone design?
- Virtual network peering (VNet peering): Does the design include connectivity between different subscriptions or virtual networks in Azure?

### Resource organization

Sound governance and operational management of the cloud starts with best practice resource organization.

**Question for the partner:** Does the partner's landing zone design include considerations for the following resource organization practices?

- Naming standards: What [naming standards](../azure-best-practices/naming-and-tagging.md) will this offering follow & is that standard automatically enforced through policy?
- Tagging standards: Does the landing zone configuration follow & enforce a specific [standards for tagging assets](../azure-best-practices/naming-and-tagging.md#metadata-tags)?
- Subscription design: What [subscription design strategies](../../decision-guides/subscriptions/index.md) are supported by the partner's offer?
- Management group design: Does the partner offer follow a defined pattern for the [Azure management group hierarchy](../azure-best-practices/organize-subscriptions.md) to organize subscriptions?

**Question for the partner:** Does the partner provide on-boarding documentation to [track foundational decisions](../../get-started/cloud-concepts.md) and educate staff? See the [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx) for an example of such documentation.

### Governance disciplines

Your governance requirements could heavily influence any complex landing zone designs. Many partners provide a separate offering to fully implement governance disciplines after the landing zone(s) are deployed. But, the following questions will help create clarity around the aspects of governance that will be built into the landing zone(s).

**Question for the partner:** What governance tooling does the partner solution include as part of the landing zone implementation?

- Policy compliance monitoring: Does the partner's landing solution includes defined governance policies & tools/processes to monitor compliance? Does the offer include customization of policies to fit your governance needs?
- Policy enforcement: Does the partner's landing solution include automated enforcement tools & processes?
- Cloud platform governance: Does the partner's offer include a solution for maintaining compliance to a common set of policies across all subscriptions? Or is the scope limited to individual subscriptions?
- N/A: Start small approaches purposefully delay governance decisions until the team has deployed low-risk workloads to Azure. This could be addressed in a separate offer after the landing zone solution has been deployed.

**Question for the partner:** Does the partner offering go beyond governance tooling to also include processes and practices for delivering any of the following Cloud Governance Disciplines?

- Cost management: Does the partner offer prepare the team to evaluate, monitor, and optimize spend while creating cost accountability with workload teams
- Security baseline: Does the partner offer prepare the team to maintain compliance as security requirements change and mature?
- Resource consistency: Does the partner offer prepare the team to ensure that all assets in the cloud are on-boarding into relevant operations management processes?
- Identity baseline: Does the partner offer prepare the team to maintain identify, role definitions, and assignments after the initial landing zone is deployed?

### Operations baseline

Your operations management requirements could influence configuration of specific Azure products during landing zone implementation. Many partners provide a separate offering to fully implement the operations baseline & advanced operations later in the cloud adoption journey, but before your first workload is released for production use. But, the partner's landing solution may include configuration for a number of operations management tools by default.

**Question for the partner:** Does the partner solution include design options to support any of the Cloud Operations Disciplines?

- Inventory & visibility: Does the landing zone include tooling to ensure that 100% of assets are centrally monitored?
- Operational compliance: Does the architecture include tooling and automated processes to enforce patching or other operational compliance requirements?
- Protect & recover: Does the partner's offering include tooling and configuration to ensure a minimal standard of backup and recovery for 100% of assets deployed?
- Platform operations: Does the landing zone offering include tooling or processes to optimize operations across the portfolio?
- Workload operations: Does the landing zone offering include tooling to manage workload-specific operations requirements &/or ensure that each workload is well-architected?

## Next steps

After reviewing the partner's Azure landing zone offer or solution using the questions above, your team will be better equipped to choose the partner whose Azure landing zone most closely aligns to your cloud operating model.

If you determine that a self-service approach to Azure landing zone deployment is a better fit, review (or re-review) the [Azure landing zone implementation options](./implementation-options.md) to find a templated landing zone approach that best aligns with your cloud operating model.
