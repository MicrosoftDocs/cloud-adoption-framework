---
title: CAF enterprise-scale implementation guidelines
description: Learn about CAF enterprise-scale implementation guidelines in the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- cSpell:ignore interdomain VMSS VWAN -->

# CAF enterprise-scale implementation guidelines

This section covers how to get started with the enterprise-scale platform-native reference implementation and outline design objectives.

There are three categories of activities that must take place in order to implement the enterprise-scale architecture:

<!-- docsTest:disable -->

1. **What-must-be-true for the enterprise-scale architecture:** Encompasses activities that must be performed by the Azure and Azure AD administrators to establish an initial configuration. These activities are sequential by nature and primarily one-off activities.

2. **Enable a new region (File -> New -> Region):** Set of activities that are required whenever there is a need to expand the enterprise-scale platform into a new Azure region.

3. **Deploy a new landing zone (File -> New -> Landing Zone):** These are recurring activities that are required to instantiate a new landing zone.

<!-- docsTest:enable -->

To operationalize at scale, these activities must follow infrastructure-as-code (IaC) principles and must be automated using deployment pipelines.

## What must be true for a CAF enterprise-scale landing zone

### Enterprise Agreement (EA) enrollment and Azure AD tenants

1. Set up the EA administrator and notification account.

2. Create departments: business domains/geo-based/org.

3. Create an EA account under a department.

4. Setup Azure AD Connect for each Azure AD tenant if identity is to be synchronized from on-premises.

5. Establish zero standing access to Azure resources and just-in time access via Azure AD PIM.

### Management group and subscription

1. Create management group hierarchy following the recommendations in this [article](./management-group-and-subscription-organization.md#define-a-management-group-hierarchy).

2. Define subscription-provisioning criteria along with the responsibilities of a subscription owner.

3. Create management, connectivity, and identity subscriptions for platform management, global networking, and connectivity and identity resources like Active Directory domain controllers.

4. Setup a Git repository to host IaC and service principals for use with a platform CI/CD pipeline.

5. Create custom role definitions and manage entitlements using Azure AD PIM for subscription and management group scopes.

6. Create the Azure Policy assignments in the table below for the landing zones.

| Name                  | Description                                                                                   |
|-----------------------|-----------------------------------------------------------------------------------------------|
| [`Deny-PublicEndpoints`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policySetDefinitions-Deny-PublicEndpoints.parameters.json) | Denies the creation of services with public endpoints on all landing zones. |
| [`Deploy-VM-Backup`](https://github.com/Azure/Enterprise-Scale/blob/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/Landing%20Zones/.AzState/Microsoft.Authorization_policyAssignments-Deploy-VM-Backup.parameters.json) | Ensures that backup is configured and deployed to all VMs in the landing zones. |
| [`Deploy-VNet`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vNet.parameters.json) | Ensures that all landing zones have a VNet deployed and that it is peered to the regional virtual hub. |

### Global networking and connectivity

1. Allocate an appropriate VNet CIDR range for each Azure region where virtual hubs and VNets will be deployed

2. If you decide to create the networking resources via Azure Policy, assign the policies listed in the table below to the connectivity subscription. By doing this, Azure Policy ensures the resources in the list below are created based on parameters provided.
   - Create an Azure Virtual WAN Standard instance.
   - Create a Azure Virtual WAN virtual hub for each region. Ensure at least one gateway (ExpressRoute or VPN) per virtual hub is deployed.
   - Secure virtual hubs by deploying Azure Firewall within each virtual hub.
   - Create required Azure Firewall policies and assign them to secure virtual hubs.
   - Ensure all VNets connected to a secure virtual hub are protected by Azure Firewall.

3. Deploy and configure an Azure Private DNS zone.

4. Provision ExpressRoute circuits with Azure private peering. Follow the instructions in [Create and modify peering for an ExpressRoute circuit](https://docs.microsoft.com/azure/expressroute/expressroute-howto-routing-portal-resource-manager#private)

5. Connect on-premises HQs/DCs to Azure Virtual WAN virtual hubs via ExpressRoute circuits.

6. Protect VNet traffic across virtual hubs with NSGs.

7. (Optional:) Set up encryption over ExpressRoute private peering. Follow the instructions in [ExpressRoute encryption: IPsec over ExpressRoute for Virtual WAN](https://docs.microsoft.com/azure/virtual-wan/vpn-over-expressroute).

8. (Optional:) Connect branches to the virtual hub via VPN. Follow the instructions in [Create a Site-to-Site connection using Azure Virtual WAN](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-site-to-site-portal).

9. (Optional:) Configure ExpressRoute Global Reach for connecting on-premises HQs/DCs when more than one on-premises location is connected to Azure via ExpressRoute. Follow the instructions in [Configure ExpressRoute Global Reach](https://docs.microsoft.com/azure/expressroute/expressroute-howto-set-global-reach).

The following list shows Azure Policy assignments used when implementing networking resources for an enterprise-scale deployment:

| Name                     | Description                                                                            |
|--------------------------|----------------------------------------------------------------------------------------|
| [`Deploy-FirewallPolicy`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-FirewallPolicy.parameters.json) | Creates a firewall policy. |
| [`Deploy-VHub`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vHUB.parameters.json) | This policy deploys a virtual hub, Azure Firewall, and VPN/ExpressRoute gateways, and configures the default route on connected VNets to Azure Firewall. |
| [`Deploy-VWAN`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vWAN.parameters.json)| Deploys a Virtual WAN. |

### Security, governance, and compliance

1. Define and apply a [service enablement framework](./security-governance-and-compliance.md#service-enablement-framework) to ensure Azure services meet enterprise security and governance requirements.

2. Create custom Azure RBAC role definitions.

3. Enable Azure AD PIM and discover Azure resources to facilitate Privileged Identity Management.

4. Create Azure-AD-only groups for the Azure control plane management of resources using Azure AD PIM.

5. Apply policies listed in the first table below to ensure Azure services are compliant to enterprise requirements.

6. Define a naming convention and enforce it via Azure Policy.

7. Create a policy matrix at all scopes (for example, enable monitoring for all Azure services via Azure Policy).

The following policies should be used to enforce company-wide compliance status.

| Name                       | Description                                                        |
|----------------------------|--------------------------------------------------------------------|
| [`Allowed-ResourceLocation`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Allowed-ResourceLocation.parameters.json)   | Specifies the allowed region where resources can be deployed. |
| [`Allowed-RGLocation`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Allowed-RGLocation.parameters.json)         | Specifies the allowed region where resource groups can be deployed. |
| [`Denied-Resources`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Denied-Resources.parameters.json)           | Resource that are denied for the company . |
| [`Deny-AppGW-Without-WAF`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deny-AppGW-Without-WAF.parameters.json)     | Allows application gateways deployed with WAF enabled. |
| [`Deny-IP-Forwarding`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Deny-IP-Forwarding.parameters.json)         | Deny IP forwarding. |
| [`Deny-RDP-From-Internet`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Deny-RDP-From-Internet.parameters.json)     | Deny RDP connections from internet. |
| [`Deny-Subnet-Without-Nsg`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deny-Subnet-Without-Nsg.parameters.json)    | Deny subnet creation without an NSG. |
| [`Deploy-ASC-CE`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-ASC-CE.parameters.json)              | Set up Security Center continuous export to your Log Analytics workspace. |
| [`Deploy-ASC-Monitoring`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Deploy-ASC-Monitoring.parameters.json)      | Enable monitoring in Azure Security Center. |
| [`Deploy-ASC-Standard`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-ASC-Standard.parameters.json)        | Ensures that subscriptions have Security Center Standard enabled. |
| [`Deploy-Diag-ActivityLog`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Deploy-Diag-ActivityLog.parameters.json) | Enables diagnostics activity log and forwarding to Log Analytics. |
| [`Deploy-Diag-LogAnalytics`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Deploy-Diag-LogAnalytics.parameters.json) | |
| [`Deploy-VM-Monitoring`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyAssignments-Deploy-VM-Monitoring.parameters.json) | Ensures that VM monitoring is enabled. |

### Platform identity

1. If you decide to create the identity resources via Azure Policy, assign the policies listed in the table below to the identity subscription. By doing this, Azure Policy ensures the resources in the list below are created based on the parameters provided.

2. Deploy the Active Directory domain controllers.

The following list shows policies that can be used when implementing identity resources for an enterprise-scale deployment.

| Name                         | Description                                                               |
|------------------------------|---------------------------------------------------------------------------|
| [`DataProtectionSecurityCenter`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-DataProtectionSecurityCenter.parameters.json) | Data protection automatically created by Azure Security Center. |
| [`Deploy-VNet-Identity`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vNet.parameters.json) | Deploys a VNet into the identity subscription to host (for example, DC.) |

### Platform management and monitoring

1. Create policy compliance and security dashboards for organizational and resource-centric views.

2. Create a workflow for platform secrets (service principals and automation account) and key rollover.

3. Setup long-term archiving and retention for logs within Log Analytics.

4. Setup Azure Key Vault to store platform secrets.

5. If you decide to create the platform management resources via Azure Policy, assign the policies listed in the table below to the management subscription. By doing this, Azure Policy ensures the resource in the list below are created based on parameters provided.

| Name                   | Description                                                                            |
|------------------------|----------------------------------------------------------------------------------------|
| [`Deploy-LA-Config`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-LA-Config.parameters.json) | Configuration of the Log Analytics workspace. |
| [`Deploy-Log-Analytics`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-Log-Analytics.parameters.json) | Deploys a Log Analytics workspace. |

## **File-> New-> Region**

1. If you decide to create the networking resources via Azure Policy, assign the policies listed in the table below to the connectivity subscription. By doing this, Azure Policy will ensure the resource in the list below are created based on parameters provided.

    - In the connectivity subscription, create a new virtual hub within the existing Virtual WAN.
    - Secure virtual hub by deploying Azure Firewall within the virtual hub and link existing or new firewall policies to Azure Firewall.
    - Ensure all VNets connected to a secure virtual hub are protected by Azure Firewall.

2. Connect the virtual hub to the on-premises network via either ExpressRoute or VPN.

3. Protect VNet traffic across virtual hubs via NSGs.

4. (Optional:) Set up encryption over ExpressRoute private peering.

| Name                     | Description                                                                            |
|--------------------------|----------------------------------------------------------------------------------------|
| [`Deploy-VHub`](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vHUB.parameters.json) | This policy deploys a virtual hub, Azure Firewall, gateways (VPN/ExpressRoute) and configures default route on connected VNets to Azure Firewall. |

<!-- docsTest:disable -->

## File -> New -> Landing Zone for applications and workloads

<!-- docsTest:enable -->

1. Create a subscription and move it under the `Landing Zones` management group scope.

2. Create Azure AD groups for the subscription, such as `Owner`, `Reader`, and `Contributor`.

3. Create Azure AD PIM entitlements for established Azure AD groups.
