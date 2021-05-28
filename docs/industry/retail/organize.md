---
title: "Organizational structures in the retail industry"
description: Understand organizational structures in the retail industry for cloud adoption by creating a cloud strategy team and understanding common growth patterns.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
---

# Organizational structures the retail industry

Organizational structures in the retail industry tend to be the result of decades of organic or acquisition-based growth. This article builds on the Organize methodology in the Cloud Adoption Framework to understand how some in the retail industry have reorganized for new technologies. For more information, see [Manage organizational alignment](../../organize/index.md).

## Cloud strategy team

As with any other industry, a cloud strategy team is critical to long-term business success. The members of this team represent business needs throughout your cloud adoption. For more information, see [Cloud strategy functions](../../organize/cloud-strategy.md).

Be sure to include the following roles or proxies for each role in recurring meetings of the cloud strategy team:

:::row:::
    :::column:::
        **Business Decision Maker roles**
    :::column-end:::
    :::column span="2":::
        **Desired outcomes**
    :::column-end:::
:::row-end:::
---
:::row:::
    :::column:::
        Customer Experience Manager
    :::column-end:::
    :::column span="2":::
       Deliver seamless, personalized experiences across all channels
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Chief Marketing Officer
    :::column-end:::
    :::column span="2":::
        Optimize advertising, marketing campaigns, channels, and purchase behavior with insights
    :::column-end:::
:::row-end:::
---
:::row:::
    :::column:::
        VP of Human Resources
    :::column-end:::
    :::column span="2":::
        Ensure remote access and collaboration
    :::column-end:::
:::row-end:::
---
:::row:::
    :::column:::
        Chief Financial Officer
    :::column-end:::
    :::column span="2":::
        Maintain optimal inventory levels
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Business Operations
    :::column-end:::
    :::column span="2":::
        Make better forecasting decisions
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Head of Supply Chain
    :::column-end:::
    :::column span="2":::
        Reduce loss by tracking assets throughout the logistics journey
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column span="2":::
        Increase agility and responsiveness across the supply chain
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column span="2":::
        Increase safety and security of goods and shipments
    :::column-end:::
:::row-end:::
---
:::row:::
    :::column:::
        Customer Experience Manager
    :::column-end:::
    :::column span="2":::
        Optimize energy efficiency and cost savings
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Chief Marketing Officer
    :::column-end:::
    :::column span="2":::
        Reduce labor needs with automation
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column span="2":::
        Facilitate contactless shopping and fulfillment
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column span="2":::
        Comply with social distancing
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column span="2":::
        Set up new fulfillment nodes with micro fulfillment centers
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column span="2":::
        Use location-based personalized advertising
    :::column-end:::
:::row-end:::

Connecting the desired outcomes to your cloud adoption strategy can ensure that these roles are adequately represented. For more information, see [Strategic impact of cloud adoption for the Retail industry](./strategy.md).

The outcomes for roles can also provide feedback to guide and support your cloud adoption plans. For more information, see [Cloud adoption plan for the Retail industry](./plan.md).

## Common growth patterns

Companies in the retail industry tend to follow one of three growth patterns:

- Brick and mortar organization with an organically grown e-commerce presence
- Rapid-growth startups with most or all of their revenue coming from online growth
- Brick and mortar organization that acquired one or more startups

Those corporate growth patterns can drive the growth and organization of technology teams.

To organize around cloud strategies and cloud plans, understand your current organization. The organizational structures resulting from these growth patterns has a direct effect on the company's ability to mature in the cloud. Compare and contrast between your current organization and the organization required to reach the cloud maturity described below. For more information, see [Cloud maturity model for Retail](./retail-cloud-maturity.md).

[![Retail cloud maturity](./media/maturity-model.png)](./media/maturity-model.png#lightbox)

The following section compares your current situation and future goals. Use it to provide a customized course of action to reach your goals.

## Traditional central IT and centralized operations

When the foundation of a retail company is a brick and mortar business, the technology organization likely formed around specific goals. Such goals might include "keep the lights on" and "keep products moving". Traditional retail organizations tend to focus on facility management and supply chain technologies. The technology organization tends to emphasize security, stability, and operations over innovation. Technology teams that have grown in this growth model often operate as a central IT organization with a focus on central operations.

This type of technology team is well suited for the first two stages of the retail cloud maturity model. These stages are siloed retail and connected retail. If your organization needs to go further in that maturity, be sure to read the next section about Cloud Center of Excellence (CCoE) and enterprise operations.

![Central IT team](../../_images/ready/org-ready-central-it.png)

Traditional central IT teams  value consistency and strive to minimize risk, change, or experimentation. This operating model can be replicating in the cloud. To replicate this operating model, study the "start small and expand" approach to Azure landing zones. For more information, see  [Azure Landing Zones for the Retail industry](./ready.md). For more information about developing change control practices in the cloud, see [Governance for the Retail industry](./govern.md) and [Managing the cloud for the Retail industry](./manage.md).

To prepare for central IT and central operations in Azure, evaluate how the current organization structure aligns to the central IT organizational structure pictured above. New virtual teams or adjustments to the organization may be useful to deliver your current operations approaches in Azure. Specifically, early cloud adoption projects should focus on building cloud governance and cloud platform functions to extend your central IT model. Those teams also need to define a plan for extending or modernizing operations tools to support your overall operating model. For more information, see [Cloud governance functions](../../organize/cloud-governance.md) and [Cloud platform functions](../../organize/cloud-platform.md).

## Cloud Center of Excellence and enterprise operations

As retail organizations expand into more mature phases of the retail cloud maturity model, central IT models could become an inhibitor to innovation for some organizations. It's possible for central IT to evolve and support more mature models. However, reorganization is common for modern retailers.

Retail consumers are increasingly fickle. Retail competitors respond with rapid innovation to stay relevant. Rapid innovation requires systems and processes that can channel, not block, rapid change. For more information, see [Cloud Center of Excellence](../../organize/cloud-center-of-excellence.md).

Rapid growth startups often begin with this fast pace of change. They have processes to channel the change. Brick and mortar organizations that fully embrace and integrate a startup acquisition often have some of those controls in place. In either case, innovation tends to have an equal or greater priority, compared to stability found in more traditional organizations.

These organizations empower workload owners to make more decisions. They focus on establishing guardrails to protect the company against poor decisions. This approach is a shift in perspective for traditional central IT operations teams.

This type of technology team organization is well suited to achieve the latter two stages of the retail cloud maturity model. These stages are analytics-driven retail and intelligent retail. We refer to these organizations as Cloud Center of Excellence (CCoE) teams. Those teams tend to align best with enterprise operations.

![Cloud Center of Excellence team](../../_images/ready/org-ready-ccoe.png)

CCoE teams tend to value innovation and delegated responsibility. To replicate this operating model in the cloud, the CCoE team enables advanced cloud capabilities:

- Enable zero trust security
- Separate duties
- Centralize monitoring and visibility
- Create policies to force adherence to compliance, security, and operations guardrails

Those advanced controls can most easily be deployed using the enterprise-scale architecture and implementation options of Azure landing zones. For more information, see [Cloud governance functions](../../organize/cloud-governance.md) and [Cloud platform functions](../../organize/cloud-platform.md).

To prepare for CCoE and enterprise operations in Azure, evaluate how the current organization structure aligns to the CCoE organizational structure pictured above. New virtual teams or adjustments to the organization may be useful to deliver this advanced operations approach in Azure. Specifically, early cloud adoption projects should focus on building the CCoE functions to modernize existing central IT models. Those teams may also need to define a plan for replacing existing operations tools used to support any central IT processes.

## Next steps

This basic understanding of organizational structures and critical roles in the retail organization provides information to prepare your cloud adoption strategy.

- [Cloud adoption strategy for the Retail industry](./strategy.md)
- [Cloud adoption plan for the Retail industry](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate common Retail industry technologies](./migrate.md)
- [Innovation in the Retail industry](./innovate.md)
- [Governance in the Retail industry](./govern.md)
- [Management in the Retail industry](./manage.md)
