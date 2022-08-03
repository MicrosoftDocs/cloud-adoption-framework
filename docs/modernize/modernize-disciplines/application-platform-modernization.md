---
title: Modernize with application platforms
description: Learn to adopt and deploy modern application platforms during cloud adoption-related modernization.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal, seo-caf-modernize
keywords: application platform, modern, cloud modernization, cloud adoption framework
---
<!--
Dependencies: Cross-link to [Compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json) - We are concerned with a subset of this decision tree that relates to app plat)
Primary Deliverable: CAF/modernize/application-platform-modernization.md
This should fit into one net new article.
-->


[Application platforms](../../_images/modernize/app-platforms/app-paas-modernize_small.png)

- [App decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree)

# Application platform modernization

Learn how to modernize any application or framework in the cloud with platform-as-a-service (PaaS).

:::image type="content" source="../../_images/modernize/app-platforms/app-paas-modernize-small-2.png" alt-text="Graphic showing the application platform options, moving from control to productivity. On the bottom is on-premises. Moving up, you see container platforms, app platforms, and low code platforms.":::

## Apps and frameworks supported

- .NET
- Java
- Spring
- Python
- Multiple frameworks

## Control vs. productivity

This guidance starts with platforms that provide the most control (container PaaS). It ends with platforms that provide the most productivity (Low Code).

## Container PaaS

Modernize with container PaaS solutions. Container PaaS solutions reduce the administrative burden managing Kubernetes clusters. You manage the infrastructure and the platform manages the orchestration.

- [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes)
- [Azure Red Hat OpenShift](/azure/openshift/intro-openshift)

## Application PaaS

Modernize with Azure PaaS solutions. Azure PaaS solutions manage the infrastructure. You focus on your code.

- [Azure App Service](/rest/api/appservice/)
- [Azure Spring Apps](/azure/spring-apps/overview)

## Low Code PaaS

Modernize with Low Code PaaS solutions. Low Code PaaS enable you to create applications and build automation with little to no code.

- [Power Apps](/power-apps/powerapps-overview)
- [Power Automate](/power-automate/getting-started)

One way of evaluating the different options is to look at productivity versus infrastructure control and the level of infrastructure abstraction. If you want to focus on your code and application functionality first, and not the underlying infrastructure, then options like Serverless or [Azure App Service](/rest/api/appservice/) can be right for you. Here, the underlying infrastructure gets handled for you, which saves you time and allows you to focus only on what’s most important to you.

Alternatively, if you want to keep tighter control over infrastructure management, then options like containers and [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) might be the best choice for you.



You can also use a combination of all of these services. For more information, see the following articles:


