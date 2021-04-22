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

Azure landing zones are the output of a multisubscription Azure environment that accounts for scale, security, governance, networking, and identity. Azure landing zones enable application migrations and greenfield development at enterprise-scale in Azure. These zones consider all platform resources that are required to support the customer's application portfolio and don't differentiate between infrastructure as a service or platform as a service.

A landing zone is an environment for hosting your workloads, preprovisioned through code. Watch the following video to learn more.  

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4xdvm]

## Scalable and modular

No single solution fits all technical environments. A few Azure landing zone implementation options can help you meet the deployment and operations needs of your growing cloud portfolio. 

- **Scalable:** All Azure Landing Zones support cloud adoption at scale by providing repeatable environments which remain consistent regardless of the workloads being deployed to each landing zone instance. 
- **Modular:** All Azure Landing Zones provide a modular approach to building out your environment, based on a common set of design areas. Each design area can be easily extended to support the distinct needs of various technology platforms like SQL, AKS, WVD, etc... 

 Whether you're looking to deploy your first production application to Azure or you're operating a complex portfolio of tech platforms & workloads, the Azure landing zone implementation options can be tailored to your needs.

## Next steps

When you're choosing the right Azure landing zone implementation option, you should understand the [Azure landing zone design areas](./design-areas.md).

> [!div class="nextstepaction"]
> [Review design areas](./design-areas.md)
