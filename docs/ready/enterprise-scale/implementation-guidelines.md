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

<<<<<<< HEAD
This section covers how to get started with the enterprise-scale platform-native reference implementation and outline design objectives.
=======
This section helps you get started with the enterprise-scale platform-native reference implementation and outline design objectives, current design, FAQ, and known issues.
>>>>>>> upstream/master

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

<<<<<<< HEAD
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
=======
| Activities | Parameters required | Enterprise-scale example configuration |
|---|---|---|
| 1. Set up the EA administrator and notification account. | | |
| 2. Create departments/business domains/geo-based/org hierarchy. | | |
| 3. Create an EA account and assign budget. | | |
| 4. Set up Azure AD Connect for each Azure AD tenant if identity is to be synchronized from on-premises. | | |
| 5. Establish zero standing access to Azure resources and just-in time access via Azure AD Privileged Identity Management (PIM). | | |

### Management group and subscription

| Activities | Parameters required | Enterprise-scale example configuration |
|---|---|---|
| 1. Create a management group hierarchy (ideally with no more than three or four levels). | | |
| 2. Create a top-level sandbox management group for users to experiment with Azure. | | |
| 3. Publish a subscription provisioning criteria along with the responsibilities of a subscription owner (potentially as a wiki). | | |
| 4. Create management and connectivity subscriptions for platform management and global networking and connectivity resources. | | |
| 5. Set up a Git repo and service principal to use with a platform continuous integration/continuous deployment pipeline. | | |
| 6. Create custom role definitions and manage entitlements using Azure AD PIM for subscription and management group scopes. | | |
>>>>>>> upstream/master

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

<<<<<<< HEAD
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
=======
| Activities | Parameters required | Enterprise-scale example configuration |
|---|---|---|
| 1. Define and apply a service whitelisting framework to ensure Azure services meet enterprise security and governance requirements (see appendix). | | |
| 2. Create custom role-based access control (RBAC) role definitions. | | |
| 3. Enable PIM and discover Azure resources to facilitate PIM. | | |
| 4. Create Azure AD-only groups for the Azure control plane management of resources using PIM. | | |
| 5. Apply Azure Policy to ensure Azure services are compliant to enterprise requirements. | | |
| 6. Define a naming convention and enforce it via Azure Policy. | | |
| 7. Create a policy matrix at all scopes (for example, enable monitoring for all Azure services). | | |
| 8. Apply Azure policies related to networking, security, and monitoring (refer to the example policies list provided below). | | |

### Platform management and monitoring

| Activities | Parameters required | Enterprise-scale example configuration |
|---|---|---|
| 1. Create policy compliance and security dashboards for organizational and resource-centric views. | | |
| 2. Create a workflow for platform secrets (service principals and automation account) and key rollover. | | |
| 3. (Optional:) Set up an organization-wide virtual machine (VM) gallery image. | | |
| 4. Set up long-term archiving and retention for logs within Azure Monitor logs. | | |
| 5. Set up business continuity and disaster recovery for key vaults used to store platform secrets. | | |
| 6. Using Azure Firewall Manager, ensure that all connected virtual networks to a secure virtual hub are protected by Azure Firewall. | | |

The table below provides a list of example Azure policies to enforce typical networking, security, and monitoring controls at a management group scope.

| Category   | Policy |
|------------|--------------------------------------------------------------------------------------------------_|
| Network    | 1. (Preview:) Container Registry should use a virtual network service endpoint.                   |
|            | 2. A custom IP security/internet key exchange policy must be applied to all Azure Virtual Network gateway connections. |
|            | 3. App Service should use a virtual network service endpoint (internal apps only)..                |
|            | 4. Azure VPN gateways should not use a SKU.                            |
|            | 5. Azure Cosmos DB should use a virtual network service endpoint.                                 |
|            | 6. Deploy Network Watcher when virtual networks are created.                                      |
|            | 7. Event hub should use a virtual network service endpoint.                                       |
|            | 8. Gateway subnets should not be configured with a network security group.                        |
|            | 9. Key Vault should use a virtual network service endpoint.                                       |
|            | 10. Network interfaces should disable IP forwarding.                                              |
|            | 11. Service Bus should use a virtual network service endpoint.                                    |
|            | 12. SQL Server should use a virtual network service endpoint.                                     |
|            | 13. Storage accounts should use a virtual network service endpoint.                               |
|            | 14. Subnets should be associated with a network security group.                                   |
|            | 15. Monitor unprotected network endpoints in Azure Security Center.                          |
| Security   | 1. [Preview]: Audit the Microsoft Monitoring Agent deployment - VM image (OS) unlisted.                         |
|            | 2. [Preview]: Audit the Microsoft Monitoring Agent deployment in VMSS - VM image (OS) unlisted.                 |
|            | 3. [Preview]: Audit Azure Monitor Log Analytics agent deployment - VM image (OS) unlisted.                      |
|            | 4. [Preview]: Audit Azure Monitor Log Analytics agent deployment in VMSS - VM image (OS) unlisted.              |
|            | 5. [Preview]: Audit Azure Monitor Log Analytics workspace for VM - report mismatch.                             |
|            | 6. [Preview]: Deploy the Microsoft Dependency Agent for Linux VMs.                                              |
|            | 7. [Preview]: Deploy the Microsoft Dependency Agent for Windows VMs.                                            |
|            | 8. [Preview]: Deploy Azure Monitor Log Analytics agent for Linux VMs.                                           |
|            | 9. [Preview]: Deploy Azure Monitor Log Analytics agent for Windows VMs.                                         |
|            | 10. Activity log should be retained for at least one year.                                        |
|            | 11. Audit diagnostic setting.                                                                     |
|            | 12. Azure Monitor log profile should collect logs for categories `write`, `delete`, and `action`. |
|            | 13. Azure Monitor should collect activity logs from all regions.                                  |
|            | 14. Azure Monitor solution 'security and audit' must be deployed.                                 |
|            | 15. Azure subscriptions should have a log profile for activity log.                               |
|            | 16. Deploy diagnostic settings for batch account to event hub.                                    |
|            | 17. Deploy diagnostic settings for batch account to Azure Monitor Log Analytics workspace.                      |
|            | 18. Deploy diagnostic settings for Data Lake Analytics to event hub.                              |
|            | 19. Deploy diagnostic settings for Data Lake Analytics to Azure Monitor Log Analytics workspace.                |
|            | 20. Deploy diagnostic settings for Data Lake Storage gen1 to event hub.                           |
|            | 21. Deploy diagnostic settings for Data Lake Storage gen1 to Azure Monitor Log Analytics workspace.             |
|            | 22. Deploy diagnostic settings for event hub to event hub.                                        |
|            | 23. Deploy diagnostic settings for event hub to Azure Monitor Log Analytics workspace.                          |
|            | 24. Deploy diagnostic settings for Key Vault to Azure Monitor Log Analytics workspace.                          |
|            | 25. Deploy diagnostic settings for Logic Apps to event hub.                                       |
|            | 26. Deploy diagnostic settings for Logic Apps to Azure Monitor Log Analytics workspace.                         |
|            | 27. Deploy diagnostic settings for network security groups.                                       |
|            | 28. Deploy diagnostic settings for search services to event hub.                                  |
|            | 29. Deploy diagnostic settings for search services to Azure Monitor Log Analytics workspace.                    |
|            | 30. Deploy diagnostic settings for Service Bus to event hub.                                      |
|            | 31. Deploy diagnostic settings for Service Bus to Azure Monitor Log Analytics workspace.                        |
|            | 32. Deploy diagnostic settings for stream analytics to event hub.                                 |
|            | 33. Deploy diagnostic settings for stream analytics to Azure Monitor Log Analytics workspace.                   |
|            | 34. The Azure Monitor Log Analytics agent should be installed on VM scale sets.                    |
|            | 35. The Azure Monitor Log Analytics agent should be installed on VMs.                              |
| Monitoring | 36. [Preview]: Audit the Microsoft Dependency Agent deployment - VM image (OS) unlisted.                        |
|            | 37. [Preview]: Audit the Microsoft Dependency Agent deployment in VMSS - VM image (OS) unlisted.                |
|            | 38. [Preview]: Audit Azure Monitor Log Analytics agent deployment - VM image (OS) unlisted.                     |
|            | 39. [Preview]: Audit Azure Monitor Log Analytics agent deployment in VMSS - VM image (OS) unlisted.             |
|            | 40. [Preview]: Audit Azure Monitor Log Analytics workspace for VM - report mismatch.                            |
|            | 41. [Preview]: Deploy the Microsoft Dependency Agent for Linux VMs.                                             |
|            | 42. [Preview]: Deploy the Microsoft Dependency Agent for Windows VMs.                                           |
|            | 43. [Preview]: Deploy Azure Monitor Log Analytics agent for Linux VMs.                                          |
|            | 44. [Preview]: Deploy Azure Monitor Log Analytics agent for Windows VMs.                                        |
|            | 45. Activity log should be retained for at least one year.                                        |
|            | 46. Audit diagnostic setting.                                                                     |
|            | 47. Azure Monitor log profile should collect logs for categories `write`, `delete`, and `action`. |
|            | 48. Azure Monitor should collect activity logs from all regions.                                  |
|            | 49. Azure Monitor solution `security and audit` must be deployed.                                 |
|            | 50. Azure subscriptions should have a log profile for activity log.                               |
|            | 51. Deploy diagnostic settings for batch account to event hub.                                    |
|            | 52. Deploy diagnostic settings for batch account to Azure Monitor Log Analytics workspace.                      |
|            | 53. Deploy diagnostic settings for Data Lake Analytics to event hub.                              |
|            | 54. Deploy diagnostic settings for Data Lake Analytics to Azure Monitor Log Analytics workspace.                |
|            | 55. Deploy diagnostic settings for Data Lake Storage gen1 to event hub.                           |
|            | 56. Deploy diagnostic settings for Data Lake Storage gen1 to Azure Monitor Log Analytics workspace.             |
|            | 57. Deploy diagnostic settings for event hub to event hub.                                        |
|            | 58. Deploy diagnostic settings for event hub to Azure Monitor Log Analytics workspace.                          |
|            | 59. Deploy diagnostic settings for Key Vault to Azure Monitor Log Analytics workspace.                          |
|            | 60. Deploy diagnostic settings for Logic Apps to event hub.                                       |
|            | 61. Deploy diagnostic settings for Logic Apps to Azure Monitor Log Analytics workspace.                         |
|            | 62. Deploy diagnostic settings for network security groups.                                       |
|            | 63. Deploy diagnostic settings for search services to event hub.                                  |
|            | 64. Deploy diagnostic settings for search services to Azure Monitor Log Analytics workspace.                    |
|            | 65. Deploy diagnostic settings for Service Bus to event hub.                                      |
|            | 66. Deploy diagnostic settings for Service Bus to Azure Monitor Log Analytics workspace.                        |
|            | 67. Deploy diagnostic settings for stream analytics to event hub.                                 |
|            | 68. Deploy diagnostic settings for stream analytics to Azure Monitor Log Analytics workspace.                   |
|            | 69. The Azure Monitor Log Analytics agent should be installed on VM scale sets.                    |
|            | 70. The Azure Monitor Log Analytics agent should be installed on VMs.                              |
| Key Vault  | 71. [Preview]: Manage allowed certificate key types.                                              |
|            | 72. [Preview]: Manage allowed curve names for elliptic curve cryptography certificates.           |
|            | 73. [Preview]: Manage certificate lifetime action triggers.                                       |
|            | 74. [Preview]: Manage certificate validity period.                                                |
|            | 75. [Preview]: Manage certificates issued by a nonintegrated certificate authority.                                 |
|            | 76. [Preview]: Manage certificates issued by an integrated certificate authority.                                    |
|            | 77. [Preview]: Manage certificates that are within a specified number of days of expiration.      |
|            | 78. [Preview]: Manage minimum key size for RSA certificates.                                      |
|            | 79. Deploy diagnostic settings for Key Vault to event hub.                                        |
|            | 80. Diagnostic logs in Key Vault should be enabled.                                               |
|            | 81. Enable soft delete for Key Vault.                                                             |

## **File -&gt; new -&gt; region** and **File -&gt; New -&gt; landing zone**

### File -&gt; new -&gt; region

1. Within the connectivity subscription, create a new virtual hub within the existing Azure Virtual WAN.

2. Secure the virtual hub with Azure Firewall Manager by deploying an Azure Firewall within the virtual hub, and link existing or new firewall policies to Azure Firewall.

3. Using Azure Firewall Manager, ensure that all connected virtual networks to a secure virtual hub are protected by Azure Firewall.

4. Connect the virtual hub to on-premises using ExpressRoute or via a VPN.

5. (Optional:) Set up encryption over ExpressRoute private peering.

6. Protect virtual network traffic across virtual hubs with network security groups.

### File -&gt; new -&gt; landing zone for applications and workloads

1. Create a subscription and assign the requester as the subscription owner.

2. Assign the subscription within the management group hierarchy.

3. Set a budget and alert notifications.

4. Set up a security contact email address and phone number.

5. Create Azure AD groups for the subscription (n) owner, reader, contributor, and more.

6. Create Azure AD PIM entitlements for established Azure AD groups.

7. Provision the virtual network CIDR range if it requires virtual network connectivity.

8. Peer the virtual network with the regional virtual hub.

9. Provision required shared services (for example, domain controllers).

10. Assign required policies for the subscription scope as mandated by the policy matrix defined by organization.

\* Optional for sandbox subscriptions.

The table below provides a list of example Azure policies to enforce typical enterprise controls at a subscription scope.

| Category          | Policy                                                                                                 |
|-------------------|--------------------------------------------------------------------------------------------------------|
| Resource and tags | 1. Allowed locations                                                                                   |
|                   | 2. Allowed locations for resource groups                                                               |
|                   | 3. Allowed resource types                                                                              |
|                   | 4. Audit usage of custom RBAC rules                                                                    |
|                   | 5. Custom subscription owner roles should not exist                                                    |
|                   | 6. Not allowed resource types                                                                          |
|                   | 7. Add a tag to resource groups                                                                        |
|                   | 8. Add a tag to resources                                                                              |
|                   | 9. Inherit a tag from the resource group if missing                                                    |
|                   | 10. Require tag and its value                                                                          |
|                   | 11. Require tag and its value on resource groups                                                       |
| Compute           | 12. Allowed VM SKUs                                                                       |
|                   | 13. Audit VMs without disaster recovery configured                                        |
|                   | 14. Audit VMs that do not use managed disks                                                            |
|                   | 15. Deploy default Microsoft infrastructure as a service (IaaS) anti-malware extension for Windows Server                              |
|                   | 16. Diagnostic logs in VM scale sets should be enabled                                    |
|                   | 17. Microsoft Antimalware for Azure should be configured to automatically update protection signatures |
|                   | 18. Microsoft Antimalware Extension for Windows should be deployed on Windows servers                          |
|                   | 19. Only approved VM extensions should be installed                                                    |
|                   | 20. Require automatic OS image patching on VM scale sets                                  |
|                   | 21. Unattached disks should be encrypted                                                               |
|                   | 22. Network interfaces should not have public IPs                                                      |
|                   | 23. VMs should be connected to an approved virtual network                                |
|                   | 24. Virtual networks should use specified virtual network gateway                                      |
>>>>>>> upstream/master
