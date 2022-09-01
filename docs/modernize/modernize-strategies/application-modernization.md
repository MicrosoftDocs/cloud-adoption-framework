---
title: Modernize any application or framework in the cloud
description: Modernize applications in the cloud
author: stephen-sumner
ms.author: ssumner
ms.date: 09/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: 
ms.custom: internal, seo-caf-modernize
keywords: application platform, modern, cloud modernization, cloud adoption framework
---

# Modernize applications in the cloud

Modernizing your applications can rapidly transform your business or organization. The goal of application modernization is to rapidly enhance operations with solutions that allow your business to scale. Adopting platform-as-a-service (PaaS) technologies gives you these benefits.

**PaaS solutions:**

PaaS gives you the flexibility to modernize any application or framework. Your applications running .NET, Java/Spring, Python, or multiple frameworks have a home in a PaaS solution. You can choose three variations of PaaS technologies depending on the balance of control and productivity you want (*see figure*).

:::image type="content" source="../../_images/modernize/app-platforms/app-modernize-586.png" alt-text="Graphic showing the application platform options, moving from control to productivity. The bottom of the graphic shows on-premises solutions. Moving up, you see container platforms, application platforms, and low-code and no-code platforms.":::

- *Container PaaS* - Contains PaaS solutions use container technologies to run your workloads. You provide code and manage agent nodes. The platforms manage health, maintenance, and deployment. Azure Kubernetes Service and Azure Red Hat OpenShift are examples of give you the most control over your workloads.

- *Application PaaS* - Application PaaS solutions use virtualization to run your workload without containers. You provide code and select configuration options. The platform manages health, availability, and deployment. There is less management than with Container PaaS. Azure App Service, Azure Spring Cloud, and Azure Functions give you a balance of control and productivity.

- *Low/No Code PaaS* - Low code PaaS and no-code PaaS solutions let you build apps with little to no coding required. You can rapidly build applications and focus more time on your business. Power Apps and Power Automate are low/no code PaaS solutions that maximize your productivity.

## Step 1 - Use a decision tree to narrow options

Use a [decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to narrow your modernization service options. The goal is to narrow the options, not to decide the right one for you. After you've worked through the tree, return here to find relevant implementation guidance.

## Step 2 - Find the right implementation guidance

Find the right implementation guidance. You'll have a general idea of the service you want to use after working through the decision tree. You still want to make sure the solution gives you the right balance of control and productivity. Finding the right balance is a main consideration in application modernization.

Use the following table to find the balance. Check to see if the solution listed meets your needs. When you find the right solution, follow the implementation guidance to modernize your application.

| Control vs. Productivity | Solution | Your needs | Implementation guidance |
| --- | --- | --- | --- |
| *Most control* | [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) <br><br> [Azure Red Hat OpenShift](/azure/openshift/intro-openshift) | <ul><li>Infrastructure control</li> <li>Less administrative burden orchestrating clusters and nodes</li> </ul> | [Azure Kubernetes Service (AKS)](/azure/aks/tutorial-kubernetes-prepare-app) <br><br> [Azure Red Hat OpenShift](/azure/openshift/tutorial-create-cluster)</li></ul>
| *Balance control & <br>productivity* | [Azure App Service](/rest/api/appservice/) <br><br> [Azure Spring Apps](/azure/spring-apps/overview) <br><br> [Azure Functions](/azure/azure-functions/functions-overview) | <ul><li> Focus on developing customer code</li> <li>Automated infrastructure</li> </ul> | [Azure App Service](/azure/app-service/app-service-migration-assess-net) <br><br> [Azure Spring Apps](/azure/developer/java/migration/migrate-spring-cloud-to-azure-spring-cloud) <br><br> [Azure Functions](/azure/azure-functions/functions-reference)</ul>
| *Most productivity* | [Power Apps](/power-apps/powerapps-overview) <br><br> [Power Automate](/power-automate/getting-started) | <ul><li>Fastest time-to-market</li> <li>Applications and automation built with little to no coding experience</li> </ul> | [Power Apps](/power-apps/powerapps-overview)<br><br> [Power Automate](/power-automate/getting-started)</li></ul> |

## Next steps

Get more guidance with the [Azure Migration and Modernization Program](/migration/migration-modernization-program/#program-form)

If you haven't already, modernize your databases.

>[!div class="nextstepaction"]
> [Modernize your databases](../modernize-strategies/database-modernization.md)
