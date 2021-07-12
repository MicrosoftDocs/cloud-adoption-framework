---
title: What is an Azure landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

<!-- cSpell:ignore multisubscription -->

# What is an Azure landing zone?

Azure landing zones are the output of a multisubscription Azure environment that accounts for scale, security governance, networking, and identity. Azure landing zones enable application migration, modernization and innovation at enterprise-scale in Azure. These zones consider all platform resources that are required to support the customer's application portfolio and don't differentiate between infrastructure as a service or platform as a service.

![Diagram that shows a landing zone design.](../enterprise-scale/media/lz-design.png)

A landing zone is an environment for hosting your workloads, preprovisioned through code. Watch the following video to learn more.

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4xdvm]

<!-- markdownlint-enable MD034 -->

## Scalable and modular

No single solution fits all technical environments. A few Azure landing zone implementation options can help you meet the deployment and operations needs of your growing cloud portfolio.

- **Scalable:** All Azure landing zones support cloud adoption at scale by providing repeatable environments, with consistent configuration and controls, regardless of the workloads or Azure resources deployed to each landing zone instance.
- **Modular:** All Azure landing zones provide a modular approach to building out your environment, based on a common set of design areas. Each design area can be easily extended to support the distinct needs of various technology platforms like SQL, AKS, WVD, etc.

 Whether you're looking to deploy your first production application to Azure or you're operating a complex portfolio of tech platforms & workloads, the Azure landing zone implementation options can be tailored to your needs.

## Azure Landing Zone conceptual architecture

For the majority of organizations, the **Azure Landing Zone conceptual architecture** shown below represents the destination in their cloud adoption journey - a mature, scaled-out target architecture intended to help organizations operate successful cloud environments that drive their business whilst maintaining best practice security and governance.

This conceptual architecture represents scale and maturity decisions based on a wealth of lessons learned and feedback from customers who have adopted Azure as part of their digital estate.

While your specific implementation may vary, as a result of specific business decisions or existing investments in tools that need to persist in your cloud environment, this conceptual architecture will help set a direction for the overall approach your organization takes to designing and implementing a landing zone.

![Azure Landing Zone conceptual architecture diagram](../enterprise-scale/media/ns-arch-cust-expanded.png)

## Azure Landing Zone accelerator

For organizations where this conceptual architecture fits with the operating model and resource structure they plan to use, there is a ready-made deployment experience available which we call the **Azure Landing Zone accelerator**.
 
[![DTA-Button-ALZ](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fadventureworks%2FarmTemplates%2Fes-hubspoke.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fadventureworks%2FarmTemplates%2Fes-portal.json)

## Next steps

When you're choosing the right Azure landing zone implementation option, you should understand the [Azure landing zone design areas](./design-areas.md).

> [!div class="nextstepaction"]
> [Review design areas](./design-areas.md)
