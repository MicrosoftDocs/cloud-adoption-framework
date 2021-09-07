---
title: Cloud organizational antipatterns
description: Avoid cloud adoption antipatterns that can emerge because of organizational issues like misaligned IT departments, partnerships, and engineering assignments.
author: sarahwendel
ms.author: brblanch
ms.date: 02/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: think-tank
---

# Cloud organizational antipatterns

Customers often experience cloud adoption antipatterns within their organizational structure. Many factors can cause these problems:

- Toolsets
- Partners
- Engineers
- Misaligned IT departments

It's important to understand the role of these factors in a successful cloud adoption scenario.

## Antipattern: Treat IT as a cost center

Many companies treat IT departments as cost centers. This approach can lead to the perception that IT doesn't add value to the company. When employees view IT as a provider rather than an enabler, they can become discouraged. It's also hard for the company to attract the right talent. Reduced motivation and long lifecycle times result. The quality of work from IT can suffer, and [silos and fiefdoms](../organize/fiefdoms-silos.md) can develop.

### Example: Treat IT as a cost center

A corporation manages its IT department as a cost center responsible to the chief financial officer (CFO). The managing board perceives IT as a slow service provider that's one of the company's biggest cost drivers. The managing board doesn't realize that the mobility business unit is consuming most of the assets that the IT department ordered. IT purchases a datacenter for all business units to use, but the mobility business unit gets this oversized asset. The board doesn't view IT as an enabler or a partner.

### Preferred outcome: View IT as an enabler

Instead of managing your IT department as a cost center, consider one of these approaches:

- [Chargeback](../strategy/cloud-accounting.md#chargeback): Business units treat IT costs like operating expenses in their budgets.
- [Showback or awareness-back](../strategy/cloud-accounting.md#showback-or-awareness-back): IT functions as an agent. In reports back to the business, IT attributes any direct costs to relevant business units.

Use the cloud as a tool to increase cost and business transparency. For instance, implement [Cost Management discipline](../govern/cost-management/index.md) to increase cost transparency. Then you'll be more aware of the cost of different business units. You'll view the IT department as an enabler for those units.

To improve transparency, focus on visibility, accountability, and optimization when moving to the cloud. For more information, see [Build a cost-conscious organization](../organize/cost-conscious-organization.md).

## Antipattern: Invest in new technology without involving the business

IT departments often invest significant human and financial resources in building and deploying robust platforms and toolsets. But, sometimes IT fails to consider business units and their needs during design and development phases. This omission leads to new platforms with minimal relevance for business units. Employees are then hesitant to accept the new technology. Poor or slow adoption can result. Frustration also builds within IT when business units don't use its platforms.

### Example: Set up a platform without involving business units

The IT department of a data analysis firm sets up and customizes an Azure platform without involving any business units. While using the platform, business unit developers:

- Realize that they don't have the permissions that they need for deployment.
- Can only use a restricted number of services.
- Issue support tickets, which lengthen approval cycles.
- Begin to doubt the new platform.

In the end, some developers purchase an Azure subscription by themselves to avoid the hassle of IT rules and regulations. Shadow IT appears. Since the firm has little control over the shadow IT, high security risks emerge.

### Preferred outcome: Involve business units in decision making

Avoid creating [IT silos](../organize/fiefdoms-silos.md) when deploying an enterprise-ready cloud platform. Involve developers and technical decision makers (TDMs) from business units in design and development processes. To improve platform adoption, listen to business unit input.

Refer to [Start with Cloud Adoption Framework enterprise-scale landing zones](../ready/enterprise-scale/index.md) for Azure best practices and design principles that increase adoption speed and are tailored toward developers. Strike the right balance between compliance and flexibility. For instance, find ways to satisfy governance and security policies while keeping development environments agile.

## Antipattern: Outsource core business functions

Consulting partners and managed service providers (MSPs) can play an important role in a cloud journey. But, companies should take care that the partners' and MSPs' work doesn't provide the most value in their business. Companies that outsource responsibilities to MSPs or cloud consultants shouldn't become dependent on these providers.

### Example: Outsource cloud adoption and migration

A research institute has a time-critical cloud migration project. To shorten the cloud adoption journey, it hires an MSP to build up the Azure foundation and implement the migration. Instead of learning about the cloud adoption phase and building up skills, the institute chooses to hand over all Azure responsibility to the MSP. Since the institute has no cloud or Azure knowledge, the MSP takes the lead on all decisions, making the institute dependent on the MSP.

### Preferred outcome: Make critical design areas the company's responsibility

Keep outsourcing in mind as a good cost-cutting strategy. But, make decisions within your company when they involve these critical design areas:

- Governance
- Risk
- Compliance
- Identity

Keep responsibility inside the company for these and other areas that are critical to your security estate. Use external partners to speed up the adoption journey. But, to avoid becoming dependent on providers, don't outsource everything.

## Antipattern: Hire technical decision makers instead of developing cloud engineers

Companies place importance on finding the right personnel. As a result, they often hire or build up TDMs during initial cloud adoption phases. Successful cloud journeys rely on TDMs. But more importantly, cloud adoptions need engineers with all-hands-on-deck mentalities and deep technical skills.

### Example: Hire TDMs only

A research institute hires several TDMs to lead its cloud journey. After the initial high-level-concept phase ends, the implementation phase starts. The institute then realizes that cloud deployments behave differently than on-premises deployments. It needs extra cloud engineering effort to properly implement [infrastructure as code (IaC)](/devops/deliver/what-is-infrastructure-as-code) concepts and policy-driven governance.

### Preferred outcome: Use cloud engineers for the implementation phase

Remember that engineers are essential for properly implementing cloud automation and landing zone concepts. Responsibilities and tasks can shift significantly when you adopt service models. By shifting responsibilities to a cloud provider, you can go into production faster. You can also use TDMs for decision making, but use capable cloud engineers for tasks that require deep engineering knowledge. Then you'll realize the advantages that the cloud provides.

## Next steps

- [Align responsibilities across teams](../organize/raci-alignment.md)
- [Organizational antipatterns: silos and fiefdoms](../organize/fiefdoms-silos.md)
- [Build a cost-conscious organization](../organize/cost-conscious-organization.md)
