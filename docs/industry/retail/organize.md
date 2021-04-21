---
title: "Organizational structures in the retail industry"
description: Understand organizational structures in the retail industry
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
---

# Organizational structures the Retail industry

Organizational structures within the retail industry, like many other industries, tend to be the result of decades of organic or acquisition based growth. This article will build on the steps in the [Organize methodology of the cloud adoption framework](../../organize/index.md) understand how others in the retail industry have re-organized to capitalize on new technologies.

## Cloud Strategy Team: Understanding retail decision makers

As with any other industry, support of a [Cloud strategy team](../../organize/cloud-strategy.md) to represent the business needs throughout your cloud adoption journey is critical to long term business success. The following roles (or proxies for each) should be included in recurring meetings of the cloud strategy team.

|Business Decision Maker roles  |Desired outcomes  |
|---------|---------|
|<ul><li>Customer Experience Manager</li><li>Chief Marketing Officer</li></ul>|<ul><li>Deliver seamless, personalized experiences across all channels</li><li>Optimize advertising, marketing campaigns, channels, and purchase behavior with insights</li></ul>|
|<ul><li>VP of Human Resources</li></ul>|<ul><li>Ensure remote access and collaboration</li></ul>|
|<ul><li>Chief Financial Officer</li><li>Business Operations</li><li>Head of Supply Chain</li></ul>|<ul><li>Maintain optimal inventory levels</li><li>Make better forecasting decisions</li><li>Reduce loss by tracking assets throughout the logistics journey</li><li>Increase agility and responsiveness across the supply chain</li><li>Increase safety and security of goods/shipments</li></ul>|
|<ul><li>Customer Experience Manager</li><li>Chief Marketing Officer</li></ul>|<ul><li>Optimize energy efficiency and cost savings</li><li>Reduce labor needs with automation</li><li>Facilitate contactless shopping and fulfillment</li><li>Comply with social distancing</li><li>Set up new fulfillment nodes with micro fulfillment centers</li><li>Use location-based personalized advertising</li></ul>|

When aligning the cloud strategy team, it's important to understand these desired outcomes from various roles. By mapping those desired outcomes to your [cloud adoption strategy](./strategy.md), you can ensure that these roles are adequately represented and can provide feedback to guide and support your [cloud adoption plans](./plan.md).

## Understand common growth patterns for retailers

Companies withing the retail industry tend to follow one of three growth patterns. Those corporate growth patterns tend to drive the growth and organization of technology teams.

- Brick and mortar organization with an organically grown ecommerce presence
- Rapid-growth startups with most (or all of revenue) coming from online growth
- Brick and mortar organization which acquired one or more startups

The organizational structures resulting from the above growth patterns has a direct impact on the company's ability to mature in the cloud. To organize around cloud strategies and cloud plans, it is important to understand your current organization. It is also important to compare and contrast between your current organization and the organization required to reach the desired [cloud maturity](./retail-cloud-maturity.md) pictured below.

[![Retail cloud maturity](./media/maturity-model.png)](./media/maturity-model.png#lightbox)

The following sections will help compare your current and future state objectives. It will also provide a customized course of action to reach the desired objectives.

## Traditional, Central IT and Centralized operations

When a retail companies foundation is based on brick and mortar business, the technology organization likely formed around specific goals: Keep the lights on and keep products moving. As a result, traditional retail organizations tend to focus on facility management and supply chain technologies. The technology organization tends to also prioritize security, stability, and operations over innovation. Technology teams that have grown in this type of organic growth model often operate as a Central IT organization with a focus on central operations.

This type of technology team organization is well suited for the first two stages of [retail cloud maturity model](retail-cloud-maturity.md): Siloed retail and Connected retail. If your organization needs to go further in that maturity, be sure to read the next section about CCoE and Enterprise operations.

![Central IT team](../../_images/ready/org-ready-central-it.png)

Traditional Central IT teams tend to value consistency and strive to minimize risk, change, or experimentation. This operating model can be replicating in the cloud. To replicate this operating model, the IT organization should study the "Start, Small and Expand approach" to [Azure Landing Zones](./ready.md). From there, the guidance on [Governing](./govern.md) and [Managing](./manage.md) your portfolio will provide valuable information on developing change control practices in the cloud.

To prepare for Central IT and central operations in Azure, the team should evaluate how the current organization structure aligns to the Central IT organizational structure pictured above. New virtual teams (V-teams) or adjustments to the org structure may prove useful to deliver your current operations approaches in Azure. specifically, it is critical that early cloud adoption projects focus on building [cloud governance](../../organize/cloud-governance.md) and [cloud platform](../../organize/cloud-platform.md) functions to extend your Central IT model. Those teams will also need to define a plan for extending or modernizing operations tools to support your overall operating model.

## New paradigms in retail organizations: CCoE and enterprise operations

As retail organizations expand into more mature phases of the [retail cloud maturity model](retail-cloud-maturity.md), Central IT models **could potentially** become an inhibitor to innovation for some organizations. It is possible for Central IT to evolve and support more mature models, but re-organization is common in the most successful of modern retailers.

**Why?** The article on [Cloud Center of Excellence](../../organize/cloud-center-of-excellence.md) details this general paradigm shift in IT management. Summarizing that article & applying it to retail can be reduced to a few statements: Retail consumers are increasingly fickle. Retail competitors respond with rapid innovation to stay relevant. Rapid innovation requires systems and processes that can channel, not block, rapid change.

Rapid growth startups often grow up in this fast pace of change & have processes to channel it. Brick and mortar organizations which have fully embraced & integrate startup acquisition often have some of those controls in place. In either case, innovation tends to have an equal or greater priority, compared to the priority of stability found in the more traditional retail organizations. These organizations tend to empower workload owner to make more decisions & focus on establishing guardrails to protect the company, should poor decisions make it to production. This is a paradigm shift in perspective for traditional Central IT operations teams.

This type of technology team organization is well suited to achieve the latter two stages of [retail cloud maturity model](retail-cloud-maturity.md): analytics-driven retail and intelligent retail. We refer to these organizations as Cloud Center of Excellence (CCoE) teams. Those teams tend to align best with Enterprise Operations.

![Cloud Center of Excellence (CCoE) team](../../_images/ready/org-ready-ccoe.png)

CCoE teams tend to value innovation and delegated responsibility. To replicate this operating model in the cloud, the CCoE team will need to enable advanced cloud capabilities to enable zero trust security, separation of duties, centralized monitoring and visibility, and policies to force adherence to compliance, security & operations guardrails. Those advanced controls can most easily be deployed using the Enterprise-Scale architecture and implementation options of [Azure Landing Zones](./ready.md). From there, the guidance on [Governing](./govern.md) and [Managing](./manage.md) your portfolio will provide valuable on the types of guardrails you will want to review, deploy, and maintain over time.

To prepare for CCoE and enterprise operations in Azure, the team should evaluate how the current organization structure aligns to the CCoE organizational structure pictured above. New virtual teams (V-teams) or adjustments to the org structure will likely be necessary to deliver this advanced operations approach in Azure. Specifically, it is critical that early cloud adoption projects focus on building the [Cloud Center of Excellence](../../organize/cloud-center-of-excellence.md) functions to modernize any existing Central IT models. Those teams may also need to define a plan for replacing existing operations tools used to support any Central IT processes.

## Next step: The cloud adoption journey for the Retail industry

This basic understanding of organizational structures and critical roles in the retail organization will provide enough information to prepare your cloud adoption strategy.

- [Cloud adoption strategy for the Retail industry](./strategy.md)
- [Cloud adoption plan for the Retail industry](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate common Retail industry technologies](./migrate.md)
- [Innovation in the Retail industry](./innovate.md)
- [Governance in the Retail industry](./govern.md)
- [Management in the Retail industry](./manage.md)
