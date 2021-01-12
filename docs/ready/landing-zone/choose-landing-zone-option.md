---
title: Choose the landing zone for your organization
description: Learn how to choose the right landing zone for your organization. You can start small and expand or implement an enterprise-scale option.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/15/2021
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Choose the landing zone for your organization

There are different approaches to implementing landing zones in the Cloud Adoption Framework. The right approach for your organization has the necessary services to support your business applications without extra overhead to manage. Starting with an implementation that doesn't meet your needs can waste your time and effort.

Microsoft offers two implementation options for landing zones:

- Start small and expand
- Enterprise scale

You might also consider third-party implementations. Our partners have many implementations available through their services. For more information, see [Evaluate a Microsoft partner's Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/partner-landing-zone).

## Overview of landing zone options

The following table summarizes considerations for the different options.

:::row:::
    :::column:::
        
    :::column-end:::
    :::column:::
        
    :::column-end:::
    :::column:::
        **Start small and expand**
    :::column-end:::
    :::column:::
        **Enterprise scale**
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Initial considerations**
    :::column-end:::
    :::column:::
        Operating model alignment?
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
        Provides a baseline architecture/environment?
    :::column-end:::
    :::column:::
        Offers a simple starting point to build your own solution with minimal subscriptions, which you scale only as needed.
    :::column-end:::
    :::column:::
        Yes, for the entire Azure tenant regardless of your scale-point, which includes cloud-native operations.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Adoption plan considerations**
    :::column-end:::
    :::column:::
        Provides long-term self-sufficiency?
    :::column-end:::
    :::column:::
        Requires Cloud Adoption Framework Govern and Manage methodologies to achieve long-term self-sufficiency.
    :::column-end:::
    :::column:::
        Yes. Enterprise-scale architecture -> 1:N landing zones approach and architecture prepare your organization for long-term self-sufficiency. Provides reserved instances to get started.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column:::
        Enables adoption velocity across the organization?
    :::column-end:::
    :::column:::
        Quickly enable low-risk adoption. Build towards security, governance, and compliance.
    :::column-end:::
    :::column:::
        Start with security, governance, and compliance to enable compliant adoption sooner.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column:::
        Achieves operational excellence?
    :::column-end:::
    :::column:::
        Requires Cloud Adoption Framework Govern and Manage methodologies to achieve operational excellence.
    :::column-end:::
    :::column:::
        Yes. Enables autonomy for platform and application teams with a policy-driven governance and management.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Compliance considerations**
    :::column-end:::
    :::column:::
        Path to reach security, governance, and compliance?
    :::column-end:::
    :::column:::
        Iterative approach. Requires Govern and Manage methodologies to support sensitive data or mission critical workloads.
    :::column-end:::
    :::column:::
        The 1:N landing zones and enterprise-scale architecture includes designs for segmentation and separation of duty. This approach empowers teams to act within appropriate landing zones.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column:::
        Risks while building out security, governance, and compliance?
    :::column-end:::
    :::column:::
        There is a risk of extensive refactoring or even redeployment to deliver on those needs.
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
        Best-practices from cloud provider?
    :::column-end:::
    :::column:::
        Yes. More best practices added using Cloud Adoption Framework methodologies to apply security, governance, and compliance.
    :::column-end:::
    :::column:::
        Yes
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column:::
        All critical services are present and properly configured according to recommended best practices for identity/access management, governance, security, network, and logging?
    :::column-end:::
    :::column:::
        Partial. Some resources are deployed. Additional offerings aligned to Cloud Adoption Framework methodologies required to apply best practices to support security, governance, and compliance.
    :::column-end:::
    :::column:::
        Yes, using a multi-subscription design that aligns with the Azure platform roadmap.
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        
    :::column-end:::
    :::column:::
        Automation capabilities like infrastructure as code (IaC) and Azure DevOps?
    :::column-end:::
    :::column:::
        Yes: Azure Resource Manager, Azure Policy, and Azure Blueprints. Can create your own continuous integration/continuous development pipeline.
    :::column-end:::
    :::column:::
        Yes: Azure Resource Manager, Azure Policy, and GitHub/AzureDevOps. CI/CD pipeline option are included.
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
        Timelines to reach security, governance, and compliance requirements for all workloads:
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

- Enterprise operations: In this typically larger environment, enterprise operations have a stable, steady state that's managed centrally.

Centralized operations favor a start-small-and-expand approach. Enterprise operations might be better addressed with enterprise scale.

Do you need a baseline architecture or environment? The start-small-and-expand approach offers a simple starting point where you can build your own solution. The enterprise-scale approach provides an environment for the entire Azure tenant, which includes cloud-native operations.

For more information about operations types, see [Compare common cloud operating models](/azure/cloud-adoption-framework/operating-model/compare).

## Adoption plan considerations

The following considerations are key to your adoption plan for either type:

- Long-term self-sufficiency
- Adoption velocity across the organization
- Operational excellence

Enterprise scale provides long-term self-sufficiency and operational excellence immediately. Enterprise scale also helps fast, compliant adoption across your organization. The enterprise scale approach builds out a foundation for you. Enterprise scale includes the guard rails around security, identity, network. The approach includes guard rails around DevOps and automation.

If you start small and expand, there are ways to get to self-sufficiency, adoption velocity, and operational excellence. Use the Govern or Manage methodologies inside the Cloud Adoption Framework to iteratively build those pieces into the landing zone solution. Use the eight areas of design, [Cloud Adoption Framework enterprise-scale design guidelines](/azure/cloud-adoption-framework/ready/enterprise-scale/design-guidelines), to iteratively improve your design.

To learn more about operational excellence, see [Deliver operational excellence during digital transformation](/azure/cloud-adoption-framework/get-started/operational-excellence).

## Compliance considerations

Consider the following issues around compliance for your organization:

- Path to reach security, governance, and compliance
- Risks while building out security, governance, and compliance

Your organization might need to have a particular workload or application that needs to be compliant in a short amount of time, and this requirement could affect your choice.

Start small and expand is an iterative approach to compliance. Use the Cloud Adoption Framework Govern and Manage methodologies to support sensitive data or critical workloads. For more information, see the [Govern methodology for the cloud](/azure/cloud-adoption-framework/govern/methodology) and [IT management and operations in the cloud](/azure/cloud-adoption-framework/manage/considerations/).

The enterprise-scale architecture includes designs for segmentation and separation to support compliance goals.

If possible, identify low-risk workloads to implement first. This technique helps you build infrastructure and skills over time. You can add the Govern and Manage methodologies as you understand how the cloud works.

## Deployment considerations

Deploying your landing zone or landing zones raises several considerations for choosing an implementation:

- Best practices from cloud provider.

- All critical services are present and properly configured according to recommended best practices for identity/access management, governance, security, network, and logging.

- Automation capabilities like IaC and Azure DevOps.

Both implementation offer best practices. Start small and expand lets you add best practices using Cloud Adoption Framework methodologies to apply security, governance, and compliance.

Enterprise scale comes with all critical services configured. Start small and expand comes with some resources deployed.

For more information about best practices, see [best practices for Azure readiness](/azure/cloud-adoption-framework/ready/azure-best-practices/).

Both methodologies offer automation capabilities.

- Start small and expand: ARM templates, Azure Policy, and Azure Blueprints. Can create your own CI/CD pipeline.
- Enterprise scale: ARM templates, Azure Policy, GitHub/AzureDevOps, and CI/CD pipeline option included.

Start small and expand uses ARM templates, Azure Policy, and Azure Blueprints. Enterprise scale offers several different deployments.

Whether you implement start small and expand or enterprise scale, you can use templates and a portal-based experience. You can include IaC later in the process. Explore this [IaC overview](/dotnet/architecture/cloud-native/infrastructure-as-code) for more information.

## Timeline considerations

Landing zone options take different amounts of time to implement. There are two types of timelines:

- A timeline to adopt or migrate a low-risk workload
- A timeline to reach security, governance, and compliance requirements for all workloads

With a start-small-and-expand approach, you can have a low-risk workload up and running in 3 to 10 days. For workloads with high security, governance, and compliance requirements, it could take four to six months.

For an enterprise-scale implementation, you can still adopt a low-risk workload in 3 to 10 days, but more elaborate workloads can be ready in six to eight weeks.

## Next steps

[Start small and expand](./migrate-landing-zone.md)

[Start with enterprise-scale](../enterprise-scale/index.md)
