---
title: Partner options for implementing Azure landing zones
description: Learn how to validate partner implementation options for Azure landing zones.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/07/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Evaluate a Microsoft partner's Azure landing zone

The Cloud Adoption Framework approaches cloud adoption as a self-service activity. The objective is to empower each team that supports adoption through standardized approaches. In practice, you can't assume that a self-service approach is sufficient for all adoption activities.

Successful cloud adoption programs typically involve at least one level of third-party support. Many cloud adoption efforts require support from a systems integrator (SI) or consulting partner who provides services that accelerate cloud adoption. Managed service providers (MSPs) provide enduring value by supporting landing zones and cloud adoption, but they also provide post-adoption operations management support. Additionally, successful cloud adoption efforts tend to engage one or more independent software vendors (ISV) who provide software-based services that accelerate cloud adoption. The rich partner ecosystems of SIs, ISVs, MSPs, and other forms of Microsoft partners have aligned their offerings to specific methodologies found in the Cloud Adoption Framework. When a partner is aligned to the Ready methodology of this framework, they will likely offer their own Azure landing zone implementation option.

This article provides a set of questions that help create an understanding of the scope of the partner's Azure landing zone implementation options.

> [!IMPORTANT]
> Partner offers and Azure landing zone implementation options are defined by the partner, based on their extensive experience helping customers adopt the cloud.
>
> Partners might choose to omit the implementation of specific design areas in their initial landing zone implementation. However, they should be able to communicate when and how each design area is implemented, as well as a range of costs for completing that design area whenever possible.
>
> Other partner solutions might be flexible enough to support multiple options for each of the questions below. Use these questions to ensure you're comparing partner offers and self-service options equally.

## Find a partner

If you need a partner to implement your Azure landing zones, start with the approved list of Cloud Adoption Framework aligned partners. Specifically, start with partners who have [offers aligned to the Ready methodology](https://www.microsoft.com/azure/partners/adopt?filters=ready).

Additionally, all [Azure expert managed service providers (MSPs)](https://www.microsoft.com/azure/partners/azureexpertmsp?filters=all) have been audited to validate their ability to deliver each methodology of the Cloud Adoption Framework. While a particular partner might not have an aligned offer, all partners have demonstrated alignment during technical delivery.

## Validate a partner offer

Once a partner is selected, use the remainder of this article to guide your validation of the partner offer. Each section includes a summary of what to look for and a list of questions to ask the partner. The partner's answers to these questions shouldn't be considered as right or wrong. Instead, the questions are designed to help you evaluate whether the partner offer will meet your business requirements.

## Platform development velocity

As outlined in the [Azure landing zone implementation options](./implementation-options.md), there are two high-level approaches to landing zone implementation based on how you want to develop your landing zones.

**Question for the partner:** Which of the following approaches are supported by the partner's Azure landing zone solution?

- **Start small and expand:** Begin with a lightweight template. The landing zone solution is matured over time as your desired cloud operating model becomes clearer.
- **Start with enterprise-scale:** Begin with a more comprehensive reference implementation. The reference architecture builds on a well-defined cloud operating model that requires less iteration to reach a mature solution.
- **Other:** The partner has a modified approach and should be able to describe the approach.

## Design principles

All Azure landing zones must consider the following set of common design areas. We refer to the way those design areas are implemented as design principles. The following sections will help validate the partner's design principles that define the Azure landing zone implementation.

### Deployment options

Partners who offer an Azure landing zone solution might support one or more options to deploy (or modify/expand the landing zone) the solution to your Azure tenant.

**Question for the partner:** Which of the following does your Azure landing zone solution support?

- **Configuration automation:** Does the solution deploy the landing zone from a deployment pipeline or deployment tool?
- **Manual configuration:** Does the solution empower the IT team to manually configure the landing zone, without injecting errors into the landing zone source code?

**Question for the partner:** Which of the Azure landing zone implementation options are supported by the partner's solution? See the [Azure landing zone implementation options](./implementation-options.md) article for a full list of options.

### Identity

Identity is perhaps the most important design area to evaluate in the partner solution.

**Question for the partner:** Which of the following identity management options does the partner solution support?

- **Azure AD:** The suggested best practice is to use Azure AD and Azure role-based access control to manage identity and access in Azure.
- **Active Directory:** If required, does the partner solution provide an option to deploy Active Directory as an infrastructure as a service solution?
- **Third-party identity provider:** If your company uses a third-party identity solution, determine whether and how the partner's Azure landing zone integrates with the third-party solution.

### Network topology and connectivity

Networking is arguably the second most important design area to evaluate. There are several best practice approaches to network topology and connectivity.

**Question for the partner:** Which of the following options is included with the partner's Azure landing zone solution? Are any of the following options incompatible with the partner's solution?

- **Virtual network:** Does the partner solution configure a virtual network? Can its topology be modified to meet your technical or business constraints?
- **Virtual private network (VPN):** Is VPN configuration included in the partner's landing zone design to connect the cloud to existing datacenters or offices?
- **High-speed connectivity:** Is a high-speed connection such as Azure ExpressRoute included in the landing zone design?
- **Virtual network peering:** Does the design include connectivity between different subscriptions or virtual networks in Azure?

### Resource organization

Sound governance and operational management of the cloud starts with best practice resource organization.

**Question for the partner:** Does the partner's landing zone design include considerations for the following resource organization practices?

- **Naming standards:** What [naming standards](../azure-best-practices/naming-and-tagging.md) will this offering follow and is that standard automatically enforced through policy?
- **Tagging standards:** Does the landing zone configuration follow and enforce specific [standards for tagging assets](../azure-best-practices/resource-tagging.md)?
- **Subscription design:** What [subscription design strategies](../../decision-guides/subscriptions/index.md) are supported by the partner offer?
- **Management group design:** Does the partner offer follow a defined pattern for the [Azure management group hierarchy](../azure-best-practices/organize-subscriptions.md) to organize subscriptions?
- **Resource group alignment:** How are resource groups used to group assets deployed to the cloud? In the partner offer, are resource groups used to group assets into workloads, deployment packages, or other organization standards?

**Question for the partner:** Does the partner provide onboarding documentation to [track foundational decisions](../../get-started/cloud-concepts.md) and educate staff? See the [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx) for an example of such documentation.

### Governance disciplines

Your governance requirements can heavily influence any complex landing zone designs. Many partners provide a separate offering to fully implement governance disciplines after landing zones are deployed. The following questions will help create clarity around the aspects of governance that will be built into any landing zones.

**Question for the partner:** What governance tooling does the partner solution include as part of the landing zone implementation?

- **Policy compliance monitoring:** Does the partner's landing zone solution includes defined governance policies along with tools and processes to monitor compliance? Does the offer include customization of policies to fit your governance needs?
- **Policy enforcement:** Does the partner's landing zone solution include automated enforcement tools and processes?
- **Cloud platform governance:** Does the partner offer include a solution for maintaining compliance to a common set of policies across all subscriptions? Or is the scope limited to individual subscriptions?
- **N/A:** Start-small approaches intentionally postpone governance decisions until the team has deployed low-risk workloads to Azure. This can be addressed in a separate offer after the landing zone solution has been deployed.

**Question for the partner:** Does the partner offer go beyond governance tooling to also include processes and practices for delivering any of the following cloud governance disciplines?

- **Cost management:** Does the partner offer prepare the team to evaluate, monitor, and optimize spend while creating cost accountability with workload teams?
- **Security baseline:** Does the partner offer prepare the team to maintain compliance as security requirements change and mature?
- **Resource consistency:** Does the partner offer prepare the team to ensure that all assets in the cloud are onboarded into relevant operations management processes?
- **Identity baseline:** Does the partner offer prepare the team to maintain identity, role definitions, and assignments after the initial landing zone is deployed?

### Operations baseline

Your operations management requirements could influence configuration of specific Azure products during landing zone implementation. Many partners provide a separate offering to fully implement the operations baseline and advanced operations later in the cloud adoption journey, but before your first workload is released for production use. But, the partner's landing zone solution might include configuration for a number of operations management tools by default.

**Question for the partner:** Does the partner solution include design options to support any of the cloud operations disciplines?

- **Inventory and visibility:** Does the landing zone include tooling to ensure that 100% of assets are centrally monitored?
- **Operational compliance:** Does the architecture include tooling and automated processes to enforce patching or other operational compliance requirements?
- **Protect and recover:** Does the partner offer include tooling and configuration to ensure a minimal standard of backup and recovery for 100% of assets deployed?
- **Platform operations:** Does the landing zone offering include tooling or processes to optimize operations across the portfolio?
- **Workload operations:** Does the landing zone offering include tooling to manage workload-specific operations requirements and ensure that each workload is well-architected?

## Take action

After reviewing the partner's Azure landing zone offer or solution using the questions above, your team will be better equipped to choose the partner whose Azure landing zone most closely aligns to your cloud operating model.

If you determine that a self-service approach to Azure landing zone deployment is a better fit, review or revisit the [Azure landing zone implementation options](./implementation-options.md) to find the templated landing zone approach that best aligns with your cloud operating model.

## Next steps

Learn about the process for refactoring landing zones.

> [!div class="nextstepaction"]
> [Refactor landing zones](./refactor.md)
