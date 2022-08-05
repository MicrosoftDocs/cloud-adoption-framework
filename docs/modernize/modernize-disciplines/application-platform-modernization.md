---
title: Modernize your applications in the cloud
description: Learn to adopt and deploy modern application platforms during cloud adoption-related modernization.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: 
ms.custom: internal, seo-caf-modernize
keywords: application platform, modern, cloud modernization, cloud adoption framework
---
<!--
Dependencies: Cross-link to [Compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json) - We are concerned with a subset of this decision tree that relates to app plat)
Primary Deliverable: CAF/modernize/application-platform-modernization.md
This should fit into one net new article.
-->

# Modernize your application in the cloud

Learn how to modernize any application or framework in the cloud.

:::image type="content" source="../../_images/modernize/app-platforms/app-modernize-586.png" alt-text="Graphic showing the application platform options, moving from control to productivity. On the bottom is on-premises. Moving up, you see container platforms, app platforms, and low code platforms.":::

## Modernize applications

Modernize your applications and find the balance of control and productivity that meets your needs.

In the table, find your desired level of control vs. productivity. Then, see if the solution meets your needs. Follow the implementation guidance for your use case.

| Control vs. Productivity | Your solution... | When you need... | Implementation guidance for... |
| --- | --- | --- | --- |
| *Most Control* | [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) <br><br> [Azure Red Hat OpenShift](/azure/openshift/intro-openshift) | <ul><li>Infrastructure control</li> <li>Less administrative burden orchestrating clusters and nodes</li> </ul> | [Azure Kubernetes Service (AKS)](/azure/aks/tutorial-kubernetes-prepare-app) <br><br> [Azure Red Hat OpenShift](/azure/openshift/tutorial-create-cluster)</li></ul>
| *Balance control & <br>productivity* | [Azure App Service](/rest/api/appservice/) <br><br> [Azure Spring Apps](/azure/spring-apps/overview) <br><br> [Azure Functions](/azure/azure-functions/functions-overview) | <ul><li> Focus on developing customer code</li> <li>Automated infrastructure</li> </ul> | [Azure App Service](/azure/app-service/app-service-migration-assess-net) <br><br> [Azure Spring Apps](/azure/developer/java/migration/migrate-spring-cloud-to-azure-spring-cloud) <br><br> [Azure Functions](/azure/azure-functions/functions-reference)</ul>
| *Productivity* | [Power Apps](/power-apps/powerapps-overview) <br><br> [Power Automate](/power-automate/getting-started) | <ul><li>Fastest time-to-market</li> <li>Applications and automation built with little to no coding experience</li> </ul> | [Power Apps](/power-apps/powerapps-overview)<br><br> [Power Automate](/power-automate/getting-started)</li></ul>

## Help choosing the right solution

Use our [app modernization decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) for more help choosing the right solution.

## Supported apps & frameworks

- .NET
- Java
- Spring
- Python
- Multiple frameworks

## Next Step

>[!div class="nextstepaction"]
> [Modernize your database platforms](data-platform-modernization.md)
