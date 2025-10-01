---
title: Azure application landing zone accelerators
description: Learn about Azure application landing zone accelerators
author: stephen-sumner
ms.author: pnp
ms.date: 09/26/2025
ms.topic: conceptual
---

# Azure application landing zone accelerators

To deploy application workloads in Azure successfully, you need to establish a solid foundation. When you follow Azure landing zone guidance, you create an Azure environment that supports scalability, security, and operational consistency. The foundation of your Azure environment is your customer agreement, identity and access management, resource hierarchy, governance, and platform landing zone that host shared services.

After you set up your Azure environment, your **application landing zones** build on top of it. To help you deploy application landing zones faster, Microsoft offers **application landing zone accelerators**. Application landing zone accelerators provide design guidance and sometimes reference implementations that show you how to integrate workloads *in your Azure landing zone.*

:::image type="content" source="../../_images/ready/azure-landing-zones-conceptual-architecture.png" alt-text="Diagram showing the conceptual components of your cloud environment as it aligns with Azure landing zones." lightbox="../../_images/ready/azure-landing-zones-conceptual-architecture.png" border="false":::

An **application landing zone** is one or more subscriptions for each environment in your workload. You might need more than one subscription due to subscription limitations. You place these subscriptions under the appropriate management group. This setup ensures the application landing zone inherit Azure Policy assignments. You create one application landing zone for each workload environment, such as development, testing, and production.

All subscriptions must be configured with Azure Role-Based Access Control, Cost Management, Network Watcher, and Microsoft Defender for Cloud. These services should be consistently enabled across all subscriptions, including both application and platform landing zones. For more information, see [Azure landing zones](../../ready/landing-zone/index.md).

## Find application landing zone accelerators

Here's a list of application landing zone accelerators to help you deploy application landing zones quickly and reliably. Where there's infrastructure-as-code templates hosted in GitHub deploy the templates to your application landing zone, then add your application code and configurations on top of the infrastructure.

- **[Azure Integration Services](./integration-services/landing-zone-accelerator.md):** Deploy integration workloads using Logic Apps, Service Bus, Event Grid, and API Management.

- **[Azure Kubernetes Service (AKS)](./aks/landing-zone-accelerator.md):** Run containerized applications at scale with built-in support for DevOps, monitoring, and security.

- **[Azure API Management](./api-management/landing-zone-accelerator.md):** Manage, secure, and scale your APIs with a fully managed API gateway.

- **[Azure App Service](./app-services/landing-zone-accelerator.md):** Host web apps and APIs with built-in scaling, patching, and CI/CD integration.

- **[Azure Red Hat Enterprise Linux (RHEL)](./azure-red-hat-enterprise-linux/landing-zone-accelerator.md):** Deploy enterprise-grade Linux workloads with Microsoft and Red Hat joint support.

- **[Azure Red Hat OpenShift (ARO)](./azure-red-hat-openshift/landing-zone-accelerator.md):** Run OpenShift clusters with integrated Azure services and enterprise support.

- **[Azure Container Apps](./container-apps/landing-zone-accelerator.md):** Build and deploy microservices and event-driven apps without managing Kubernetes.

## Next step

Start exploring the Application Landing Zone Accelerators to deploy your workloads with confidence and consistency.

If you prefer to build your own solution, you can design custom application landing zones from scratch. Use the [Azure Well-Architected Framework](/azure/well-architected/) and guidance from the [Azure Architecture Center](/azure/architecture/) to align your architecture with best practices for reliability, security, performance, cost optimization, and operational excellence.
