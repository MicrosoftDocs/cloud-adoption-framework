---
title: Use the Azure Kubernetes Services (AKS) landing zone accelerator to deploy scalable AKS clusters
description: Prescriptive guidance for deploying scalable Azure Kubernetes Service (AKS) clusters using the AKS landing zone accelerator.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# Use the Azure Kubernetes Services (AKS) landing zone accelerator to deploy scalable AKS clusters

The Azure Kubernetes Services (AKS) landing zone accelerator defines a strategic design path and target technical state for deploying Azure Kubernetes Service (AKS) clusters in enterprise environments. This accelerator provides a modular, reference implementation that aligns with the Cloud Adoption Framework's Azure landing zones and design principles.

## Establish a platform foundation before deploying AKS

A platform foundation provides shared services such as networking, identity, security, and governance. This foundation supports consistent and secure AKS deployments across your environment.

1. **Implement a platform foundation using Azure landing zones.** Use the Cloud Adoption Framework's [Azure landing zone](../../../ready/landing-zone/index.md) guidance to deploy shared services that include identity providers, hub-and-spoke networking, and centralized policy enforcement. This foundation simplifies security and management across your cloud environment.

2. **Skip this step if your organization already has a platform foundation.** If you already have an Azure landing zone, proceed to deploy the AKS landing zone accelerator.

## Deploy the AKS landing zone accelerator

The AKS landing zone accelerator includes open-source templates and reference architectures that support scalable AKS deployments.

1. **Use the templates from the official GitHub repository.** Use the [AKS landing zone accelerator](https://aka.ms/aks-reference-implementation) repo to access ARM template, Bicep, and Terraform templates for deploying AKS infrastructure components fit your environment. Modify environment variables and parameters to align with your organization’s naming conventions, policies, and operational requirements.

2. **Deploy the accelerator in the landing zones management group.** Place the AKS workload in the appropriate subscription and management group to ensure alignment with platform governance and policy enforcement.

## Evaluate the AKS design areas

Design areas help you align your AKS implementation with Azure landing zone principles. Use the following guides to evaluate and configure each area:

- [Azure billing and Active Directory (if needed)](./azure-billing-ad-tenant.md)
- [Identity and access management](./identity-and-access-management.md)
- [Network topology and connectivity](./network-topology-and-connectivity.md)
- [Resource organization](./resource-organization.md)
- [Security](./security.md)
- [Management and business continuity and disaster recovery (BCDR)](./management.md)
- [Platform automation and DevOps](./platform-automation-and-devops.md)
- [Storage](./storage.md)

## Example conceptual reference architecture

The conceptual reference architecture illustrates a golden state for AKS in an Azure landing zone. It shows how AKS integrates with shared services and aligns with the design areas.

:::image type="complex" source="./media/aks-enterprise-scale-landing-zone-architecture.svg" alt-text="Diagram that shows the AKS landing zone accelerator architecture." lightbox="./media/aks-enterprise-scale-landing-zone-architecture.svg" border="false":::
    The diagram shows four management groups: platform subscriptions, sandbox subscriptions, decommissioned subscriptions, and application landing zone subscriptions. The AKS landing zone accelerator deploys to a subscription under the application landing zone management group. Customers connect to the AKS cluster through Azure Application Gateway, which is only accessible through a private virtual network. This private virtual network is peered with the hub connectivity subscription, which provides on-premises connectivity via ExpressRoute, VPN, and an Azure Firewall. The AKS cluster, User Node Pool, and System Node Pool are in a resource group with Azure Key Vault. A separate resource group contains Cosmos DB and MySQL databases behind a private endpoint. A third resource group is a Node Resource Group. The architecture includes Azure dashboards, recovery services vaults, shared services, Azure role-based access control assignments, Azure policy assignments, Network Watcher, Microsoft Defender for Cloud, Azure Container Registry, and Azure Monitor for Containers.
:::image-end:::

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Platform foundation | [Azure landing zone](../../../ready/landing-zone/index.md) | Guidance on deploying an Azure landing zone. |
| Deployment templates | [AKS landing zone accelerator](https://aka.ms/aks-reference-implementation) | AKS deployment templates and instructions. |

## Next steps

> [!div class="nextstepaction"]
> [Azure billing and Active Directory (if needed)](./azure-billing-ad-tenant.md)

> [!div class="nextstepaction"]
> [Identity and access management](./identity-and-access-management.md)
