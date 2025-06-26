---
title: Deploy Azure App Service at scale with landing zone accelerator
description: Implement Azure App Service with a landing zone accelerator that provides design guidance and reference implementations for scalable deployments.
author: stephen-sumner
ms.author: pnp
ms.date: 06/24/2025
ms.topic: conceptual
---

# Deploy Azure App Service at scale with the landing zone accelerator

This article helps you accelerate Azure App Service deployments using architectural guidance and reference implementations. The landing zone accelerator provides infrastructure as code templates that prepare a scalable and secure environment for your app workloads, adhering to Cloud Adoption Framework best practices.

## Use a modular approach for flexible implementation

The Azure App Service landing zone accelerator offers a flexible foundation that works for both new implementations and existing App Service deployments. The modular architecture allows you to customize components based on your specific requirements. You need to evaluate your application needs and organizational constraints to create an effective landing zone. Here's how:

1. **Determine your deployment type requirements.** Choose between multitenant App Service for cost-effectiveness or App Service Environment for complete isolation. The accelerator supports both deployment types with specific guidance for each scenario where needed.

2. **Customize the infrastructure templates.** Adapt the provided infrastructure-as-code templates to match your organization's naming conventions, integrate with existing resources, and configure App Service Environment v3 modes based on your requirements.

## Implement a platform foundation

A platform provides the shared services that support your App Service environment. These services handle network connectivity, security controls, identity management, and governance requirements. If you already have a foundation, you can build on it. If you don't have a platform foundation, start with the [Azure landing zone guidance](/azure/cloud-adoption-framework/ready/landing-zone/) to create your cloud foundation.

## Use the assets provided by the accelerator

The landing zone accelerator provides resources to support your App Service implementation:

1. **Tailor the modular architecture components.** Customize environment variables to match your specific workload requirements without rebuilding the entire solution.

2. **Follow design guidelines.** Access expert guidance on key design areas that affect your implementation. The documentation clearly indicates which sections apply to multitenant App Service or App Service Environments.

3. **Deploy a reference implementation.** Deploy a production-ready environment with infrastructure-as-code templates that create all necessary Azure resources.

:::image type="complex" source="./media/app-service-landing-zone-accelerator.svg" alt-text="This Azure architecture diagram illustrates a secure, multitenant App Service Plan (Premium SKU) deployment using a hub-and-spoke network topology." lightbox="./media/app-service-landing-zone-accelerator.svg" border="false":::
    Customers connect to the web application through Azure Front Door, which integrates with a Private Link Service for secure, private access. The web app is hosted in an App Service Environment v3 and is integrated into the virtual network via the Ingress Subnet. This subnet enables the app to  connect to backend resources. The backend resources include Azure Redis Cache, Azure Key Vault, Azure Container Registry, Azure SQL Database, and Azure OpenAI. The spoke virtual network contains the App Service Environment and supporting subnets like Private Link and DevOps. The hub virtual network hosts shared services. These services include Azure Bastion for secure RDP/SSH access, Azure Firewall for traffic control, Azure Monitor, Application Insights, and Microsoft Entra ID. Peering between the hub and spoke networks facilitates secure and efficient communication across the environment.
:::image-end:::

## Apply design guidelines for each key area

Address these design areas when implementing your landing zone:

- [Identity and access management](/azure/cloud-adoption-framework/scenarios/app-platform/app-services/identity-and-access-management): Configure authentication, authorization, and secure resource access.
- [Network topology and connectivity](/azure/cloud-adoption-framework/scenarios/app-platform/app-services/network-topology-and-connectivity): Design network segmentation, connectivity, and security controls.
- [Governance](/azure/cloud-adoption-framework/scenarios/app-platform/app-services/governance): Establish policies, cost management, and compliance controls.
- [Security](/azure/cloud-adoption-framework/scenarios/app-platform/app-services/security): Implement application protection, secret management, and compliance requirements.
- [Management](/azure/cloud-adoption-framework/scenarios/app-platform/app-services/management): Set up monitoring, diagnostics, and operational processes.
- [Platform automation and DevOps](/azure/cloud-adoption-framework/scenarios/app-platform/app-services/platform-automation-and-devops): Implement CI/CD pipelines and infrastructure automation.

## Deploy the reference implementation

Get started with the [Azure App Service landing zone accelerator reference implementation](https://github.com/Azure/appservice-landing-zone-accelerator) on GitHub. The repository contains infrastructure-as-code templates and detailed deployment instructions.

## Next steps

> [!div class="nextstepaction"]
> [Identity and access management considerations](identity-and-access-management.md)