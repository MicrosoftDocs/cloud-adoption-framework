---
title: Choose the landing zone for your organization
description: Learn how to choose the right landing zone for your organization. You can start small and expand or implement an enterprise-scale option.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Choose the landing zone for your organization

There are different approaches to implementing landing zones in the Cloud Adoption Framework. The right approach for your organization has the necessary services to support your business applications without extra overhead to manage. Starting with an implementation that doesn't meet your needs can waste your time and effort.

Microsoft offers two implementation options for landing zones:

- Start small and expand
- Enterprise-scale

Watch the following 15-minute video to learn more about how to choose the Azure landing zone implementation options that best fit your needs.

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
        Provides long-term self-sufficiency
    :::column-end:::
    :::column:::
        Requires Cloud Adoption Framework Govern and Manage methodologies to achieve long-term self-sufficiency.
    :::column-end:::
    :::column:::
        Enterprise-scale architecture landing zones approach and architecture prepare your organization for long-term self-sufficiency. Provides reserved instances to get started.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Enables adoption velocity across the organization
    :::column-end:::
    :::column:::
        Quickly enable low-risk adoption. Build toward security governance and compliance over time.
    :::column-end:::
    :::column:::
        Start with security governance and compliance to enable compliant adoption sooner.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Achieves operational excellence
    :::column-end:::
    :::column:::
        Requires Cloud Adoption Framework Govern and Manage methodologies to achieve operational excellence.
    :::column-end:::
    :::column:::
        Enables operational excellence with autonomy for platform and application teams built on policy-driven governance and management.
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
        Iterative approach. Requires Govern and Manage methodologies to support sensitive data or mission critical workloads.
    :::column-end:::
    :::column:::
        Enterprise-scale architecture includes designs for governance, security segmentation, and separation of duties. This approach empowers teams to act within appropriate landing zones.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        Associated risks while building out security governance and compliance
    :::column-end:::
    :::column:::
        There is a risk of extensive refactoring or even redeployment to attain required needs.
    :::column-end:::
    :::column:::
        There is a risk of enabling cloud-native operations products that may not align to your operating model.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Deployment considerations**
    :::column-end:::
    :::column:::
        Best practices from cloud provider?
    :::column-end:::
    :::column:::
        More best practices are required to be added using Cloud Adoption Framework methodologies to apply security governance and compliance.
    :::column-end:::
    :::column:::
        Enterprise-scale includes Azure best practices and is the target technical state for your Azure environment.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
    :::column-end:::
    :::column:::
        All critical services are present and properly configured according to recommended best practices for identity/access management, governance, security, network, and logging.
    :::column-end:::
    :::column:::
        Partial. Some resources are deployed. Additional offerings aligned to Cloud Adoption Framework methodologies required to apply best practices to support security governance and compliance.
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
        Azure Resource Manager, Azure Policy, and Azure Blueprints can be used to create your own continuous integration/continuous development pipeline.
    :::column-end:::
    :::column:::
        Azure Resource Manager, Azure Policy, and GitHub/Azure DevOps. CI/CD pipeline options are included in the reference implementation guidance.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Timeline considerations**
    :::column-end:::
    :::column:::
        Timeline to adopt or migrate a low-risk workload:
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
        Timeline to achieve security governance and compliance requirements for all workloads:
    :::column-end:::
    :::column:::
        Four to six months
    :::column-end:::
    :::column:::
       Six to eight weeks
    :::column-end:::
:::row-end:::

## Initial considerations

Which operating model better describes your organization? Be aware of not just how your organization looks now but what you expect and want it to be in three months to a year or further.

- Centralized operations: In this small environment, centralized teams for IT operations, security, and other roles manage production and workloads.

- Enterprise operations: In this typically larger or industry specialized environments, enterprise operations have a stable, steady state that's managed centrally.

Centralized operations favor a start-small-and-expand approach. Enterprise operations might be better addressed with enterprise-scale.

Do you need a baseline architecture or environment? The start-small-and-expand approach offers a simple starting point where you can build your own solution. The enterprise-scale approach provides an environment for the entire Azure tenant, which includes cloud-native operations.

For more information about operations types, see [Compare common cloud operating models](../../operating-model/compare.md).

## Adoption plan considerations

The following considerations are key to your adoption plan for either type:

- Long-term self-sufficiency
- Adoption velocity across the organization
- Operational excellence

Enterprise-scale provides long-term self-sufficiency and operational excellence immediately. Enterprise-scale also helps to accelerate compliance adoption across your organization. The enterprise-scale approach builds out a foundation for you. Enterprise-scale includes the guardrails around security, identity, and network. The approach includes CI/CD pipeline options for DevOps and automation.

If you start small and expand, there are ways to achieve self-sufficiency, adoption velocity, and operational excellence. Use the Govern and Manage methodologies of the Cloud Adoption Framework to iteratively build those pieces into the landing zone solution. Use the eight areas of design, [Cloud Adoption Framework enterprise-scale design guidelines](../enterprise-scale/design-guidelines.md), to iteratively improve your design.

To learn more about operational excellence, see [Deliver operational excellence during digital transformation](../../get-started/operational-excellence.md).

## Compliance considerations

Consider the following issues around compliance for your organization:

- Path to reach security governance and compliance
- Risks while building out security governance and compliance

Your organization might need to have a particular workload or application that needs to be compliant in a short amount of time, and this requirement could affect your choice.

Start small and expand is an iterative approach to compliance. Use the Cloud Adoption Framework Govern and Manage methodologies to support sensitive data or critical workloads. For more information, see the [Govern methodology for the cloud](../../govern/methodology.md) and [IT management and operations in the cloud](../../manage/considerations/index.md).

The enterprise-scale architecture includes designs for segmentation and separation to support compliance goals and a [service enablement framework](../enterprise-scale/security-governance-and-compliance.md#service-enablement-framework) to determine how to achieve appropriate levels of governance, security, and compliance.

If possible, identify low-risk workloads to implement first. This technique helps you build infrastructure and skills over time. You can add the Govern and Manage methodologies as you understand how the cloud works.

## Deployment considerations

Deploying your landing zone or landing zones raises several considerations for choosing an implementation:

- Best practices from cloud provider.

- All critical services are present and properly configured according to recommended best practices for identity/access management, governance, security, network, and logging.

- Automation capabilities like IaC and Azure DevOps.

Both implementation offer best practices. Start small and expand lets you add best practices using Cloud Adoption Framework methodologies to apply security governance and compliance.

Enterprise-scale comes with all critical services configured. Start small and expand comes with some resources deployed.

For more information, see [Best practices for Azure readiness](../azure-best-practices/index.md).

Both methodologies offer automation capabilities.

- **Start small and expand:** ARM templates, Azure Policy, and Azure Blueprints. Can create your own CI/CD pipeline.
- **Enterprise-scale:** ARM templates, Azure Policy, GitHub/Azure DevOps, and CI/CD pipeline options are included in the reference implementation guidance.

Start small and expand uses ARM templates, Azure Policy, and Azure Blueprints.

- [CAF Foundation blueprint](./foundation-blueprint.md)
- [CAF Migration landing zone blueprint](./migrate-landing-zone.md)

Enterprise-scale uses ARM templates, Azure Policy, and offers three reference implementation and different deployments.

- [Enterprise-scale foundation](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md)
- [Enterprise-scale Virtual WAN](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md)
- [Enterprise-scale hub and spoke](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md)

Whether you implement start small and expand or enterprise-scale, you can use templates and a portal-based experience. You can include IaC later in the process. Explore this [IaC overview](/dotnet/architecture/cloud-native/infrastructure-as-code) for more information.

## Timeline considerations

Landing zone options take different amounts of time to implement. There are two types of timelines:

- A timeline to adopt or migrate a low-risk workload.
- A timeline to reach security governance and compliance requirements for all workloads.

With a start-small-and-expand approach, you can have a low-risk workload up and running in 3 to 10 days. For workloads with high security governance and compliance requirements, it could take four to six months.

For an enterprise-scale implementation, you can still adopt a low-risk workload in 3 to 10 days, but more elaborate workloads can be ready in six to eight weeks.

## Next steps

[Start small and expand](./migrate-landing-zone.md)

[Start with enterprise-scale](../enterprise-scale/index.md)
