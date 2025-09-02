---
title: Enterprise-scale support for Azure Virtual Desktop
description: Guidance to deploy Azure Virtual Desktop (AVD) using an enterprise-scale Azure landing zone, prepare identity, network, storage, and automation to scale AVD securely.
author: stephen-sumner
ms.author: pnp
ms.date: 09/02/2025
ms.topic: conceptual
---

# Deploy an enterprise-scale Azure landing zone for Azure Virtual Desktop

This guide explains how to deploy Azure Virtual Desktop at enterprise scale. It describes how to use the application landing zone accelerator for Azure Virtual Desktop to shorten deployment time and apply enterprise governance, security, networking, and automation patterns. Follow this guidance to standardize deployments, enforce compliance controls, and scale AVD across regions with predictable operations.

**What you'll accomplish:**

- Set up enterprise-scale governance and security controls
- Deploy the Azure Virtual Desktop accelerator with best practices built-in
- Configure multi-region expansion for global users (optional)
- Implement automated deployment pipelines

**New to enterprise-scale Azure landing zone?** Start with the [enterprise-scale Azure landing zone overview](/azure/cloud-adoption-framework/ready/enterprise-scale/) to understand the foundational concepts before proceeding with Azure Virtual Desktop deployment.

:::image type="content" source="./media/accelerator-baseline-architecture.svg" alt-text="Enterprise-scale Azure Virtual Desktop landing zone architecture showing networking, storage, compute, management services, and on-premises connectivity via ExpressRoute and VPN." lightbox="./media/accelerator-baseline-architecture.svg" border="false":::

*Download a [Visio file](https://arch-center.azureedge.net/accelerator-baseline-architecture.vsdx) of this multi-region architecture of a Azure Virtual Desktop deployment in an enterprise-scale Azure landing zone.*

## Establish a scalable and compliant enterprise-scale Azure landing zone

An enterprise-scale Azure landing zone ensures consistent governance, security, and operational readiness across Azure environments. Complete this foundation before deploying Azure Virtual Desktop to ensure security and compliance requirements are met.

> [!div class="nextstepaction"]
> [Get started with an enterprise-scale Azure landing zone](/azure/cloud-adoption-framework/ready/enterprise-scale/)

1. **Deploy the enterprise-scale Azure landing zone.** This deployment includes identity, network, management, and security configurations that support scalable workloads. Use the [step-by-step deployment guide](/azure/cloud-adoption-framework/ready/enterprise-scale/) to configure your environment.

2. **Review implementation guidance to align with enterprise-scale Azure landing zone architecture.** This step ensures that your deployment follows best practices for modularity, scalability, and compliance. See the [enterprise-scale implementation best practices](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation).

## Deploy the application landing zone accelerator for Azure Virtual Desktop

The application landing zone accelerator for Azure Virtual Desktop provides Infrastructure as Code templates that implement enterprise-scale best practices, reducing deployment time and ensuring consistency across environments.

> [!div class="nextstepaction"]
> [Deploy Azure Virtual Desktop to an application landing zone](https://github.com/Azure/avdaccelerator)

1. **Use the application landing zone accelerator to deploy baseline Azure Virtual Desktop resources.** The accelerator includes proven Bicep and ARM templates for virtual networks, storage, and virtual machines. Access the [Azure Virtual Desktop accelerator on GitHub](https://github.com/Azure/avdaccelerator) and review the [deployment prerequisites](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/getting-started-baseline.md#prerequisites) before starting.

2. **Customize the accelerator to meet organizational requirements.** Modify environmental variables and deployment parameters to reflect your identity, network, and compliance needs. This flexibility supports diverse enterprise scenarios while maintaining security standards.

3. **Integrate with CI/CD pipelines for automated deployments.** Automate your Azure Virtual Desktop deployments using PowerShell or Azure CLI. Explore the [accelerator's Bicep automation examples](https://github.com/Azure/avdaccelerator/tree/main/workload/bicep) or deploy through the Azure portal for initial testing and validation.

4. **Deploy custom images to standardize virtual machine configurations.** Create consistent virtual machine images with your required software, security configurations, and organizational policies. Store these images in [Azure Compute Gallery](/azure/virtual-machines/azure-compute-gallery) to reduce deployment time and ensure compliance across all session hosts.

## Expand Azure Virtual Desktop across regions

Growing globally or need more capacity? Regional expansion provides scalability, improves performance for distributed users, and supports business continuity. Choose the expansion scenario that fits your needs:

**Scenario 1: Scale beyond capacity limits** - Add regions when your primary region reaches resource limits
**Scenario 2: Improve user proximity** - Deploy closer to users for better performance and local connectivity

### Expand due to capacity limitations

A secondary region helps organizations scale Azure Virtual Desktop when the primary region reaches capacity limits.

1. **Deploy a new virtual network with non-overlapping IP address space.** This configuration prevents routing conflicts and ensures clean peering between regions. Use CIDR blocks that don't overlap with existing virtual networks in the primary region.

2. **Connect the new region to the primary region using [global VNet peering](/azure/virtual-network/virtual-network-peering-overview) with [gateway transit](/azure/vpn-gateway/vpn-gateway-peering-gateway-transit) enabled.** Gateway transit allows the new region to access shared on-premises resources through VPN or ExpressRoute. This setup supports centralized connectivity and avoids duplicating network infrastructure.

3. **Provision regional storage for user profiles.** Deploy a storage solution in the new region to store [FSLogix profile containers](/azure/virtual-desktop/fslogix-profile-containers). Ensure that users are assigned to desktops in only one region to avoid profile fragmentation across storage systems.

4. **(Optional) Deploy a Domain Controller in the new region.** This deployment improves authentication performance and supports local identity resolution. Consider replicating Active Directory services if latency or availability is a concern.

5. **Configure outbound internet connectivity in the new region.** Use [Network Security Groups (NSGs)](/azure/virtual-network/network-security-groups-overview), Network Virtual Appliances (NVAs), or [Azure Firewall](/azure/firewall/overview) to enforce security policies and control traffic flow.

6. **Deploy Azure Virtual Desktop virtual machines in the new region.** Use the application landing zone accelerator for Azure Virtual Desktop to deploy session hosts and supporting infrastructure. Validate that all dependencies are available in the new region.

7. **Assign users to desktops in only one region.** This single assignment ensures consistent access to their profile data and avoids conflicts caused by multiple profile instances across regions.

### Expand to support regional user proximity

Deploying Azure Virtual Desktop closer to users and on-premises systems improves performance and reduces latency.

1. **Deploy a new virtual network with non-overlapping IP address space.** This configuration ensures clean routing and avoids IP conflicts with existing networks in other regions or on-premises.

2. **Connect the new region to the local on-premises datacenter using VPN or ExpressRoute with private peering.** This setup enables users to access regional applications and services hosted in nearby datacenters. Use ExpressRoute for higher reliability and performance; see [configure ExpressRoute private peering](/azure/expressroute/configure-expressroute-private-peering) for details.

3. **Provision regional storage for user profiles.** Store [FSLogix profile containers](/azure/virtual-desktop/fslogix-profile-containers) in the same region as the session hosts to reduce latency and improve sign-in performance. Avoid cross-region profile access.

4. **(Optional) Deploy a Domain Controller in the new region.** This setup supports local authentication and reduces dependency on cross-region identity services.

5. **Configure outbound internet connectivity in the new region.** Use [NSGs](/azure/virtual-network/network-security-groups-overview), NVAs, or [Azure Firewall](/azure/firewall/overview) to enforce consistent security policies and manage internet-bound traffic.

6. **Deploy Azure Virtual Desktop virtual machines in the new region.** Use the application landing zone accelerator for Azure Virtual Desktop to deploy session hosts and supporting infrastructure. Validate that regional dependencies are available.

7. **Assign users to desktops in only one region.** This setup prevents profile duplication and ensures consistent user experience. Profiles are region-specific and must not be shared across regions.

## Continue your Azure Virtual Desktop journey

Maximize your Azure Virtual Desktop deployment with these essential design guidelines. Each area provides specific guidance to optimize your implementation:

**Core design areas:**

- [🏢 Enterprise enrollment](./eslz-enterprise-enrollment.md) - Optimize subscription and billing management
- [🔐 Identity and access management](./eslz-identity-and-access-management.md) - Secure user authentication and authorization  
- [🌐 Network topology and connectivity](./eslz-network-topology-and-connectivity.md) - Design resilient network patterns
- [📋 Resource organization](./eslz-resource-organization.md) - Implement effective resource grouping and tagging
- [📊 Management and monitoring](./eslz-management-and-monitoring.md) - Set up comprehensive operational management
- [🔄 Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md) - Protect with backup and recovery strategies
- [🛡️ Security governance and compliance](./eslz-security-governance-and-compliance.md) - Enforce security controls and meet compliance requirements
- [⚙️ Platform automation and DevOps](./eslz-platform-automation-and-devops.md) - Streamline automation and deployment pipelines

> [!TIP]
> **Start with identity and networking** if you're new to enterprise-scale patterns. These foundational areas affect all other design decisions.

## Azure tools and resources

**Essential deployment tools:**

| Category | Tool | Why you need it |
|----------|------|-------------|
| 🚀 **Quick start** | [Azure Virtual Desktop accelerator](https://github.com/Azure/avdaccelerator) | Deploy production-ready AVD in hours, not weeks - includes Infrastructure as Code templates with enterprise-scale best practices built-in |
| 🏗️ **Foundation** | [Enterprise-scale Azure landing zone guide](../../ready/enterprise-scale/index.md) | Establish governance, security, and management capabilities that support scalable Azure Virtual Desktop deployments |
| ⚙️ **Automation** | [Bicep and PowerShell deployment scripts](https://github.com/Azure/avdaccelerator/tree/main/workload/bicep) | Automate your Azure Virtual Desktop deployments with proven Infrastructure as Code templates and CI/CD integration examples |

> [!div class="nextstepaction"]
> [Explore all Azure Virtual Desktop resources](/azure/virtual-desktop/)

## Next steps

Ready to secure and manage your Azure Virtual Desktop environment? Start with identity and access management to establish authentication patterns and security controls.

> [!div class="nextstepaction"]
> [Configure identity and access management](./eslz-identity-and-access-management.md)
