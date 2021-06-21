---
title: Azure Landing Zone conceptual architecture
description: Explore the high-level components of the Azure Landing Zone architecture.
author: DominicAllen
ms.author: DoAlle
ms.date: 05/20/2021
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Azure Landing Zone conceptual architecture

Azure landing zones are the output of a multisubscription Azure environment that accounts for scale, security, governance, networking, and identity. Azure landing zones enable application migrations and greenfield development at enterprise-scale in Azure.

These zones consider all platform resources that are required to support the customer's application portfolio and don't differentiate between infrastructure as a service or platform as a service.

![Diagram that shows a landing zone design.](../enterprise-scale/media/lz-design.png)

## Target architecture

For the majority of organizations, the **Azure Landing Zone conceptual architecture** shown below is the destination - a mature, scaled-out target architecture intended to help organizations operate successful cloud environments that drive their business whilst maintaining best practice security and governance.

This conceptual architecture represents scale and maturity decisions based on a wealth of lessons learned and feedback from customers who have adopted Azure as part of their digital estate.

![Azure Landing Zone conceptual architecture diagram](../enterprise-scale/media/ns-arch-cust-expanded.png)

Azure Landing Zones have been developed  in order to provide best practices, reference architectures and reference implementations that accelerate customer adoption of modern technologies.

As part of this collection there are implementations that are ready 'out of the box' and can be deployed with a portal-driven experience, or with technologies such as ARM templates or Terraform for organizations who wish to use Infrastructure-as-Code (IaC) techniques.

## Azure Landing Zone accelerator

For organizations where this conceptual architecture fits with the operating model and resource structure they plan to use, there is a ready-made deployment experience available which we call the **Azure Landing Zone accelerator**.
 
[![DTA-Button-ALZ](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fadventureworks%2FarmTemplates%2Fes-hubspoke.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fadventureworks%2FarmTemplates%2Fes-portal.json)

## Next steps

### Explore the Azure Landing Zone guidance

If your team needs to explore the architecture - and associated decision processes - further before deciding on the approach that's best for your organization, the rest of the sections in the Azure Landing Zones section of the Cloud Adoption Framework will guide you through everything you need to consider when choosing your path.

> [!div class="nextstepaction"]
> [**Explore the Azure Landing Zone design areas**](./design-areas.md)
