---
title: Implementation guidelines
description: Implementation guidelines.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- cSpell:ignore interdomain VMSS -->

# Implementation guidelines

This section covers how to get started with the enterprise-scale platform-native reference implementation and outline design objectives.

There are three categories of activities that must take place in order to implement the enterprise-scale architecture:

1. **What-must-be-true** for a the enterprise-scale
   * Encompasses activities that must be performed by the Azure and Azure AD administrators to establish an initial configuration; these are sequential by nature and primarily one-off activities.

2. **Enable a new region (_File->New->Region_)**
   * Set of activities that are required whenever there is a need to expand the enterprise-scale platform into a new Azure region.

3. **Deploy a new Landing Zone (_File->New->Landing Zone_)**
   * These are reoccurring activities that are required to instantiate a "Landing Zone"

To operationalize at scale, it is paramount that these activities follow the principal of "Infrastructure-as-Code" and automated using deployment pipelines.

## What must be true for an enterprise-scale landing zone

### Enterprise Agreement (EA) enrollment and Azure AD tenants

1. Setup the EA Administrator and Notification Account.

2. Create Department(s) – Business Domains/Geo Based/Org.

3. Create an EA Account under a Department.

4. Setup Azure AD Connect for each Azure AD Tenant if identity is to be synchronized from on-premises.

5. Establish zero standing access to Azure resources and Just-in time access via Azure AD PIM.

### Management group and subscription

1. Create management group hierarchy following the recommonations in this [article](./management-group-and-subscription-organization.md#define-a-management-group-hierarchy).

2. Define an subscription provisioning criteria along with the responsibilities of a subscription Owner.

3. Create "Management", "Connectivity" and "Identity" Subscriptions for platform management, global networking as well as connectivity and identity resources (such as AD domain controllers).

4. Setup a Git repository to host IaC and Service Principle(s) for use with a platform CI/CD pipeline.

5. Create custom role definitions and manage entitlements using Azure AD PIM for subscription and management group scopes.

6. Assign the Azure Policies in the table below for the Landing Zones.

| Name                  | Description                                                                                   |
|-----------------------|-----------------------------------------------------------------------------------------------|
| [Deny-PublicEndpoints](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policySetDefinitions-Deny-PublicEndpoints.parameters.json)  | Denies the creation of services with public endpoints on all landing zones                    |
| [Deploy-VM-Backup](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-VM-Backup.parameters.json)      | Ensures that backup is configured and deployed to all VMs in the Landing Zones                |
| [Deploy-vNet](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vNet.parameters.json)           | Ensures that all Landing Zones have a VNet deployed and that it is peered to the regonal vHub |

### Global networking and connectivity

1. Allocate an appropriate VNet CIDR range for each Azure region where VWAN VHubs and VNets will be deployed

2. If you decide to create the networking ressources via Azure Policies, assign the Policies listed in the table below to the "Connectivity" subscription. By doing this Azure Policy will ensure the resource in the list below are created based on parameters provided.
   * Create Azure Virtual WAN Standard
   * Create a VWAN VHub for each region. Ensure at least one gateway (ExpressRoute and/or VPN) per VWAN VHub are deployed)
   * Secure VWAN VHubs by deploying Azure Firewall within each VWAN VHub
   * Create required Firewall Policies and assign them to secure VHubs
   * Ensure all connected VNets to a secure VHub are protected by Azure Firewall

3. Deploy and configure an Azure Private DNS zones

4. Provision ExpressRoute circuit(s) with Private Peering. Follow instructions as per [article](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-howto-routing-portal-resource-manager#private)

5. Connect on-premises HQs/DCs to Azure VWAN VHub via ExpressRoute circuits

6. Protect VNet traffic across VHubs with NSGs

7. (Optional) Setup encryption over ExpressRoute Private Peering. Follow instructions as per [article](https://docs.microsoft.com/en-us/azure/virtual-wan/vpn-over-expressroute)

8. (Optional) Connect branches to Azure VWAN VHub via VPN. Follow instructions as per [article](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-site-to-site-portal)

9. (Optional) Configure ExpressRoute Global Reach for connecting on\-premises HQs/DCs when more than one on\-premises location is connected to Azure via ExpressRoute. Follow instructions as per [article](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-howto-set-global-reach)

Detailed list of Azure Policies that have be used when implementing networking resources for an enterprise-scale deployment:
| Name                     | Description                                                                            |
|--------------------------|----------------------------------------------------------------------------------------|
| [Deploy-FirewallPolicy](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-FirewallPolicy.parameters.json)  | Creates a Firewall Policy |
| [Deploy-vHUB](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vHUB.parameters.json)        | This Policy deploys a VHub, Azure Firewall, Gateways(VPN/ER) and configures default route on connected VNets to Azure Firewall|
| [Deploy-VWAN](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vWAN.parameters.json)            | Deploys a virtual WAN                             |

### Security, governance, and compliance

1. Define and apply a [Service Enablement Framework](./G-Security-Governance-and-Compliance.md#5-service-enablement-framework) to ensure Azure services meet enterprise security and governance requirements.

2. Create custom Azure RBAC role definitions

3. Enable Azure AD PIM and discover Azure resources to facilitate privileged identity management

4. Create Azure AD only groups for the Azure control plane management of resources using Azure AD PIM

5. Apply Azure Policy listed in the first table below to ensure Azure services are compliant to enterprise requirements

6. Define a naming convention and enforce it via Azure Policy

7. Create a policy matrix at all scopes e.g. enable monitoring for all Azure services via Azure Policy

Detailed list of Azure Policies should be used to enforce company wide compliance status.

| Name                       | Description                                                        |
|----------------------------|--------------------------------------------------------------------|
| [Allowed-ResourceLocation](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Allowed-ResourceLocation.parameters.json)   | Specifies the allowed region where resourcen can be deployed       |
| [Allowed-RGLocation](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Allowed-RGLocation.parameters.json)         | Specifies the allowed region where resource groups can be deployed |
| [Denied-Resources](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Denied-Resources.parameters.json)           | Resource that are denied for the company                           |
| [Deny-AppGW-Without-WAF](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deny-AppGW-Without-WAF.parameters.json)     | Allows Application Gateways deployed with WAF enabled              |
| [Deny-IP-Forwarding](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deny-IP-Forwarding.parameters.json)         | Deny IP forwarding                                                 |
| [Deny-RDP-From-Internet](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deny-RDP-From-Internet.parameters.json)     | Deny RDP connections from internet                                 |
| [Deny-Subnet-Without-Nsg](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deny-Subnet-Without-Nsg.parameters.json)    | Deny Subnet creation without an NSG                                |
| [Deploy-ASC-CE](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-ASC-CE.parameters.json)              | Deploy ASC Continuous Export To Workspace                          |
| [Deploy-ASC-Monitoring](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-ASC-Monitoring.parameters.json)      | Enable Monitoring in Azure Security Center                         |
| [Deploy-ASC-Standard](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-ASC-Standard.parameters.json)        | Ensures that subscriptions have Security Centre Standard enabled.  |
| [Deploy-Diag-ActivityLog](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-Diag-ActivityLog.parameters.json)    | Enables Diagnostics Activitly Log and forwarding to LA             |
| [Deploy-Diag-LogAnalytics](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-Diag-LogAnalytics.parameters.json)   |                                                                    |
| [Deploy-VM-Monitoring](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-VM-Monitoring.parameters.json)       | Ensures that VM monitoring is enabled  

### Platform indentity

1. If you decide to create the indentity ressources via Azure Policies, assign the Policies listed in the table below to the "Indentity" subscription. By doing this Azure Policy will ensure the resource in the list below are created based on parameters provided.

2. Deploy the AD domain controllers

Detailed list of Azure Policies that can be used when implementing identity resources for an enterprise-scale deployment.

| Name                         | Description                                                               |
|------------------------------|---------------------------------------------------------------------------|
| [DataProtectionSecurityCenter](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-DataProtectionSecurityCenter.parameters.json) | ASC DataProtection, utomatically created by Azure Security Center         |
| [Deploy-vNet-Identity](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vNet.parameters.json)         | Deploys a VNet into the idenity subscription to host for explample DC     |

### Platform management and monitoring

1. Create Policy Compliance and Security Dashboards for organizational and resource centric views

2. Create a workflow for platform secrets (service principles and automation account) and key rollover

3. Setup long-term archiving and retention for logs within Log Analytics

4. Setup Azure Key Vaults to store platform secrets

5. If you decide to create the platform management ressources via Azure Policies, assign the Policies listed in the table below to the "Management" subscription. By doing this Azure Policy will ensure the resource in the list below are created based on parameters provided.

| Name                   | Description                                                                            |
|------------------------|----------------------------------------------------------------------------------------|
| [Deploy-LA-Config](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-LA-Config.parameters.json)       | Configuration of the Log Analytics workspace                                           |
| [Deploy-Log-Analytics](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-Log-Analytics.parameters.json)   | Deploys a Log Analytics Workspace |

## **File->New->Region**

1. If you decide to create the networking ressources via Azure Policies, assign the Policies listed in the table below to the "Connectivity" subscription. By doing this Azure Policy will ensure the resource in the list below are created based on parameters provided.
   * Within the "Connectivity" subscription, create a new VHub within the existing Azure VWAN.
   * Secure VHub by deploying an Azure Firewall within the VHub and link existing or new Firewall Policies to Azure Firewall.
   * Ensure all connected VNets to a secure VHub are protected by Azure Firewall

2. Connect the VHub to on-premises using ExpressRoute or alternatively via VPN.

3. Protect VNet traffic across VHubs with NSGs.

4. (Optional) Setup encryption over ExpressRoute Private Peering.

| Name                     | Description                                                                            |
|--------------------------|----------------------------------------------------------------------------------------|
| [Deploy-vHUB](https://github.com/Azure/Enterprise-Scale/tree/main/azopsreference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState/Microsoft.Authorization_policyDefinitions-Deploy-vHUB.parameters.json)        | This Policy deploys a VHub, Azure Firewall, Gateways(VPN/ER) and configures default route on connected VNets to Azure Firewall|

## File->New->"Landing zone" for applications and workloads

1. Create a subscription and move it under the "Landing Zones" management group scope

2. Create Azure AD groups for the subscription (N) – Owner, Reader, Contributor etc.

3. Create Azure AD PIM entitlements for established Azure AD groups.
