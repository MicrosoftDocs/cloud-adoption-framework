---
title: Choose the landing zone for your organization
description: Learn how to choose the right landing zone for your organization. You can start small and expand or implement an enterprise-scale option.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/17/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Choose the landing zone for your organization

There are different approaches to implementing landing zones in the Cloud Adoption Framework. Starting with an implementation that doesn't meet your needs can waste your time and effort. The right approach for your organization has the necessary services to support your business applications without extra overhead to manage.

Microsoft offers two implementation options for landing zones:

- Start small and expand
- Enterprise-scale

Watch the following 15-minute video to learn more about how to choose the Azure landing zone implementation option that best fits your needs.

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWwZeg]

<!-- markdownlint-enable MD034 -->

You might also consider third-party implementations. Our partners have many implementations available through their services. For more information, see [Evaluate a Microsoft partner's Azure landing zone](./partner-landing-zone.md).

## Overview of landing zone options

The following table summarizes considerations for each landing zone implementation approach.

:::row:::
    :::column:::
    :::column-end:::
    :::column:::
    :::column-end:::
    :::column:::
        **Start small and expand**
    :::column-end:::
    :::column:::
        **Enterprise-scale**
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Initial considerations**
    :::column-end:::
    :::column:::
        [Operating model alignment](../../operating-model/compare.md#operating-model-comparison)
    :::column-end:::
    :::column:::
        Centralized operations
    :::column-end:::
    :::column:::
        Enterprise operations
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Baseline reference architecture
    :::column-end:::
    :::column:::
        Offers a simple starting point to build your own solution with minimal subscriptions, which you scale only as needed.
    :::column-end:::
    :::column:::
        Offers an entire Azure tenant reference regardless of your scale-point, which includes cloud-native operations.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Adoption plan considerations**
    :::column-end:::
    :::column:::
        Long-term self-sufficiency
    :::column-end:::
    :::column:::
        Requires Cloud Adoption Framework Govern and Manage methodologies to achieve long-term self-sufficiency.
    :::column-end:::
    :::column:::
        Enterprise-scale architecture landing zones approach and architecture prepare your organization for long-term self-sufficiency. Provides reserved instances to get you started.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Adoption velocity across the organization
    :::column-end:::
    :::column:::
        Quickly implement low-risk adoption. Build toward security governance and compliance over time.
    :::column-end:::
    :::column:::
        Start with security governance and compliance to implement compliant adoption sooner.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Operational excellence
    :::column-end:::
    :::column:::
        Requires Cloud Adoption Framework Govern and Manage methodologies to achieve operational excellence.
    :::column-end:::
    :::column:::
        Implement operational excellence with autonomy for platform and application teams that is built on policy-driven governance and management.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Compliance considerations**
    :::column-end:::
    :::column:::
        Path to attain security governance and compliance
    :::column-end:::
    :::column:::
        An iterative approach. Requires Govern and Manage methodologies to support sensitive data or mission critical workloads.
    :::column-end:::
    :::column:::
        Enterprise-scale architecture includes designs for governance, security segmentation, and separation of duties. Empowers teams to act within appropriate landing zones.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Risks while building out security governance and compliance
    :::column-end:::
    :::column:::
        There's a risk of extensive refactoring or even redeployment to attain required needs.
    :::column-end:::
    :::column:::
        There's a risk of enabling cloud-native operations products that might not align with your operating model.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Deployment considerations**
    :::column-end:::
    :::column:::
        Best practices from cloud provider
    :::column-end:::
    :::column:::
        Add more best practices by using Cloud Adoption Framework methodologies to apply security governance and compliance.
    :::column-end:::
    :::column:::
        Enterprise-scale includes Azure best practices and is the target technical state for your Azure environment.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Presence and proper consideration of all critical services, following recommended best practices for identity/access management, governance, security, network, and logging
    :::column-end:::
    :::column:::
        Partial. Some resources are deployed. Other offerings aligned to Cloud Adoption Framework methodologies are required to apply best practices to support security governance and compliance.
    :::column-end:::
    :::column:::
        Enterprise-scale architecture is the target technical state recommendation for your Azure environment that aligns with the Azure platform roadmap.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Automation capabilities like infrastructure as code (IaC) and Azure DevOps
    :::column-end:::
    :::column:::
        Use Azure Resource Manager, Azure Policy, and Azure Blueprints to create your own continuous integration and continuous development (CI/CD) pipeline.
    :::column-end:::
    :::column:::
        You can use Azure Resource Manager, Azure Policy, and GitHub/Azure DevOps. CI/CD pipeline options are included in the reference implementation guidance.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Timeline considerations**
    :::column-end:::
    :::column:::
        Timeline to adopt or migrate a low-risk workload
    :::column-end:::
    :::column:::
        3 to 10 days
    :::column-end:::
    :::column:::
        3 to 10 days
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Timeline to achieve security governance and compliance requirements for all workloads
    :::column-end:::
    :::column:::
        Four to six months
    :::column-end:::
    :::column:::
        Six to eight weeks
    :::column-end:::
:::row-end:::

## Initial considerations

Which operating model better describes your organization? Be aware of both how your organization is now and what you expect and want it to be in three months to a year and beyond.

- Centralized operations: In this small environment, centralized teams for IT operations, security, and other roles manage production and workloads.

- Enterprise operations: In this typically larger or industry specialized environment, enterprise operations have a stable, steady state that's managed centrally.

Centralized operations favor a start small and expand approach. Enterprise operations favor an enterprise-scale approach.

Do you need a baseline architecture or environment? The start small and expand approach offers a simple starting point where you can build your own solution. The enterprise-scale approach provides an environment for the entire Azure tenant, which includes cloud-native operations.

For more information about operations types, learn how to [Compare common cloud operating models](../../operating-model/compare.md).

## Adoption plan considerations

The following considerations are key to your adoption plan for either approach:

- Long-term self-sufficiency
- Adoption velocity across your organization
- Operational excellence

Enterprise-scale immediately provides long-term self-sufficiency and operational excellence. It lays out a foundation with guardrails around security, identity, and network, and helps accelerate compliance adoption across your organization. The enterprise-scale approach also includes CI/CD pipeline options for DevOps and automation.

If you start small and expand, there are ways to achieve self-sufficiency, adoption velocity, and operational excellence. Use the Govern and Manage methodologies of the Cloud Adoption Framework to iteratively build those pieces into the landing zone solution. Use the eight areas of design, [Cloud Adoption Framework enterprise-scale design guidelines](./design-areas.md), to iteratively improve your design.

To better understand operational excellence, learn how to [Deliver operational excellence during digital transformation](../../get-started/operational-excellence.md).

## Compliance considerations

Consider the following issues around compliance for your organization:

- Path to reach security governance and compliance
- Risks while building out security governance and compliance

Your organization might need a particular workload or application that needs to be compliant in a short amount of time. This requirement can affect your choice.

Start small and expand architecture takes an iterative approach to compliance. Use the Cloud Adoption Framework Govern and Manage methodologies to support sensitive data or critical workloads. For more information, review the [Govern methodology for the cloud](../../govern/methodology.md) and [IT management and operations in the cloud](../../manage/considerations/index.md).

Enterprise-scale architecture includes designs for segmentation and separation to support compliance goals and a [service enablement framework](./design-area/governance.md). These designs determine how you can achieve appropriate levels of governance, security, and compliance.

If possible, identify low-risk workloads to implement first. This strategy helps you build infrastructure and skills over time. You can add the Govern and Manage methodologies as you gain understanding of how the cloud works.

## Deployment considerations

Deploying your landing zone or landing zones raises several considerations for choosing an implementation:

- Best practices from cloud provider

- Presence and proper consideration of all critical services, following recommended best practices for identity/access management, governance, security, network, and logging

- Automation capabilities like IaC and Azure DevOps

Both implementations offer best practices. Start small and expand lets you add best practices using Cloud Adoption Framework methodologies to apply security governance and compliance. It comes with some resources deployed. Enterprise-scale comes with all critical services configured.

For more information about best practices, review the [Best practices for Azure readiness](./design-areas.md).

Both methodologies offer automation capabilities:

- **Start small and expand:** ARM templates, Azure Policy, and Azure Blueprints are included. You can create your own CI/CD development pipeline.
- **Enterprise-scale:** ARM templates, Azure Policy, GitHub/Azure DevOps, and CI/CD pipeline options are included.

The start small and expand approach uses ARM templates, Azure Policy, and Azure Blueprints:

- [CAF Foundation blueprint](./foundation-blueprint.md)
- [CAF Migration landing zone blueprint](./migrate-landing-zone.md)

The enterprise-scale approach uses ARM templates and Azure Policy, and offers three reference implementations and different deployments:

- [Enterprise-scale foundation](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md)
- [Enterprise-scale Virtual WAN](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md)
- [Enterprise-scale hub and spoke](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md)

Whether you implement the start small and expand or enterprise-scale approach, you can use templates and a portal-based experience. You can include IaC later in the process. Explore this [IaC overview](/dotnet/architecture/cloud-native/infrastructure-as-code) for more information.

## Timeline considerations

Landing zone options take different amounts of time to implement. There are two types of timelines:

- Timeline to adopt or migrate a low-risk workload
- Timeline to reach security governance and compliance requirements for all workloads

With a start-small-and-expand approach, you can get a low-risk workload up and running in 3 to 10 days. For a workload with high security governance and compliance requirements, it can take four to six months.

For an enterprise-scale implementation, you can also adopt a low-risk workload in 3 to 10 days. Adopting a more elaborate workload can take six to eight weeks.

## Next steps

Choose a landing zone implementation option:

> [!div class="nextstepaction"]
> [Start small and expand](./migrate-landing-zone.md)
>
> [Start with enterprise-scale](../enterprise-scale/index.md)
