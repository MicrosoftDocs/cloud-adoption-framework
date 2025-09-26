---
title: Azure application landing zone accelerators
description: Learn about Azure application landing zone accelerators
author: stephen-sumner
ms.author: pnp
ms.reviewer: tozimmergren
ms.date: 09/26/2025
ms.topic: conceptual
---

# Azure application landing zone accelerators

When you follow the guidance for Azure landing zones, you establish a robust foundation that streamlines the deployment of application workloads. This foundational setup is the Azure environment architecture. It includes your Customer Agreement, identity and access management, resource hierarchy, governance, and platform landing zones as needed.

**Platform landing zones** are subscriptions for shared services such as connectivity, identity, management, and security resources. You only need to deploy the ones that are relevant to your environment. For smaller or cloud-native footprints, especially those without on-premises connectivity, many shared services might not be necessary.

**Application landing zones** are designed to plug directly into this foundation. They inherit and align with the architecture you have already built. This enables faster, more consistent, and more secure workload deployments. Each workload has one application landing zone for each environment. These environments include development, testing, and production.

:::image type="content" source="../../_images/ready/azure-landing-zones-conceptual-architecture.png" alt-text="Diagram showing the conceptual components of your cloud environment as it aligns with Azure landing zones." lightbox="./../_images/ready/azure-landing-zones-conceptual-architecture.png" border="false":::

## Application landing zone accelerators

To help you deploy application landing zones faster and more reliably, Microsoft provides a set of Application Landing Zone Accelerators. These are opinionated and extensible reference implementations that align with Azure landing zone principles and best practices. They are infrastructure-as-code templates hosted in GitHub. You deploy these templates to your environment, followed by your application code and configurations on top of that infrastructure.

- **Azure Integration Services:** Deploy integration workloads using Logic Apps, Service Bus, Event Grid, and API Management.

- **Azure Kubernetes Service (AKS):** Run containerized applications at scale with built-in support for DevOps, monitoring, and security.

- **Azure API Management:** Manage, secure, and scale your APIs with a fully managed API gateway.

- **Azure App Service:** Host web apps and APIs with built-in scaling, patching, and CI/CD integration.

- **Azure Red Hat Enterprise Linux (RHEL):** Deploy enterprise-grade Linux workloads with Microsoft and Red Hat joint support.

- **Azure Red Hat OpenShift (ARO):** Run OpenShift clusters with integrated Azure services and enterprise support.

- **Azure Container Apps:** Build and deploy microservices and event-driven apps without managing Kubernetes.

These accelerators help you move faster while maintaining alignment with enterprise architecture standards. Whether you are modernizing legacy applications or building new cloud-native solutions, application landing zones provide a consistent and scalable path forward.
