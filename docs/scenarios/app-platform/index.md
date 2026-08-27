---
title: Azure application landing zone accelerators
description: Learn about Azure application landing zone accelerators
author: stephen-sumner
ms.author: pnp
ms.date: 09/26/2025
ms.topic: concept-article
---

# Azure application landing zone accelerators

> [!IMPORTANT]
> **Deprecation notice:** The articles in this scenario are deprecated and is no longer being updated. To ensure only the best guidance is available, these articles will be removed on September 30th, 2026.
>
> This does **not** affect the application landing zone accelerator in GitHub. See 
>
> If you would like to save this guidance, you can select **Download a PDF** at the bottom left of this page or download the files from [GitHub](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/scenarios/app-platform/index.md).

To deploy workloads in Azure successfully, you need to establish a solid foundation. When you follow Azure landing zone guidance, you create an Azure environment that supports scalability, security, and operational consistency. The foundation of your Azure environment is your customer agreement, identity and access management, resource hierarchy, governance, and platform landing zone that host shared services.

After you set up your Azure environment, your **application landing zones** build on top of it. To help you deploy application landing zones faster, Microsoft offers **application landing zone accelerators**. Application landing zone accelerators provide design guidance and sometimes reference implementations that show you how to integrate workloads *in your Azure landing zone.*

## Find application landing zone accelerators

Here's a list of application landing zone accelerators to help you deploy application landing zones quickly and reliably. Where there's infrastructure-as-code templates hosted in GitHub deploy the templates to your application landing zone, then add your application code and configurations on top of the infrastructure.

- **[Azure Kubernetes Service (AKS)](./aks/landing-zone-accelerator.md):** Run containerized applications at scale with built-in support for DevOps, monitoring, and security.

- **[Azure Red Hat Enterprise Linux (RHEL)](./azure-red-hat-enterprise-linux/landing-zone-accelerator.md):** Deploy enterprise-grade Linux workloads with Microsoft and Red Hat joint support.

- **[Azure Red Hat OpenShift (ARO)](./azure-red-hat-openshift/landing-zone-accelerator.md):** Run OpenShift clusters with integrated Azure services and enterprise support.

## Next step

Start exploring the Application Landing Zone Accelerators to deploy your workloads with confidence and consistency.

If you prefer to build your own solution, you can design custom application landing zones from scratch. Use the [Azure Well-Architected Framework](/azure/well-architected/) and guidance from the [Azure Architecture Center](/azure/architecture/) to align your architecture with best practices for reliability, security, performance, cost optimization, and operational excellence.
