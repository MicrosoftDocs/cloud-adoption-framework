---
title: Implementation guidelines
description: Implementation guidelines
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Implementation guidelines

This section covers how to get started with the enterprise-scale platform-native reference implementation and outline design objectives, current design, FAQs, and known issues.

There are two categories of activities that must take place in order to implement enterprise-scale architecture. One is what must be true for the enterprise-scale. It encompasses activities that must be performed by the Microsoft Azure Active Directory administrators to establish an initial configuration. These are sequential by nature and are primarily one-off activities. The other is **File -&gt; new -&gt; region** and **File -&gt; New -&gt; landing zone.** These are recurring activities required to instantiate a landing zone, and they need user input to kickstart the workflow to coordinate resource creation within Azure AD. To operationalize at scale, it's key for these activities to follow the principle of _infrastructure as code_ and automation with deployment pipelines.

## What must be true for a CAF enterprise-scale landing zone

### Enterprise agreement (EA) enrollment and Azure AD tenants

| Activities | Parameters required | Enterprise-scale example configuration |
|---|---|---|
| 1. Set up the EA administrator and notification account. |                     |                                  |
| 2. Create departments&mdash;business domains/geo-based/org hierarchy. |                     |                                  |
| 3. Create an EA account and assign budget. |                                  |
| 4. Set up Azure AD Connect for each Azure AD tenant if identity is to be synchronized from on-premises. |                     |                                  |
| 5. Establish zero standing access to Azure resources and just-in time access via Azure AD Privileged Identity Management (PIM).    |                     |                                  |

### Management group and subscription

| Activities                                                                                                                            | Parameters required | Enterprise-scale example configuration   |
|---------------------------------------------------------------------------------------------------------------------------------------|---------------------|----------------------------------|
| 1. Create a management group hierarchy (ideally using no more than 3 or 4 levels).                      |                                  |
| 2. Create a top-level `sandbox` management group for users to experiment with Azure.                                              |                     |                                  |
| 3. Publish a subscription provisioning criteria along with the responsibilities of a subscription owner (potentially as a wiki). |                     |                                  |
| 4. Create `management` and `connectivity` subscriptions for platform management and global networking and connectivity resources.  |                     |                                  |
| 5. Set up a Git repo and service principal to use with a platform CI/CD pipeline.                                            |                     |                                  |
| 6. Create custom role definitions and manage entitlements using Azure AD PIM for subscription and management group scopes.              |                     |                                  |

### Global networking and connectivity

<!-- markdownlint-disable MD033 -->

| Activities | Parameters required | Enterprise-scale example configuration |
|---|---|---|
| 1. Allocate an appropriate virtual network classless interdomain routing (CIDR) range for each Azure region where Azure Virtual WAN virtual hubs and virtual networks will be deployed. | One CIDR range per region | North Europe: `10.0.0.0/16` <br> West Europe: `10.1.0.0/16` <br> East US: `10.2.0.0/16` |
| 2. Create Azure Virtual WAN standard within the `connectivity` subscription. | Virtual WAN name<br>Azure region | Virtual WAN name: `contoso-vwan` <br> Azure region: North Europe |
| 3. Create a Virtual WAN virtual hub for each region. Ensure at least one gateway (ExpressRoute or VPN) per Virtual WAN virtual hub is deployed.                                  | Virtual WAN name<br>Virtual hub name<br>Virtual hub region<br>Virtual hub address space<br>ExpressRoute gateway<br>VPN gateway | Virtual WAN: `contoso-vwan`<br>Virtual hub region: `North Europe`<br>Virtual hub name: `vhub-neu` <br> Virtual hub address space: `10.0.0.0/16` <br> ExpressRoute gateway: yes (1 scale unit) <br> VPN gateway: no |
| 4. Using Azure Firewall Manager, secure Virtual WAN virtual hubs by deploying Azure Firewall within each Virtual WAN virtual hub.                                                        | Virtual hub name                           | Virtual hub name: `vhub-neu`                       |
| 5. Create required firewall policies within the `connectivity` subscription and assign them to secure virtual hubs.                                                 | Azure Firewall policy name <br> Firewall policy inbound/outbound rules | Firewall policy name: `contoso-global-fw-policy` <br> Allow outbound rules to `*.microsoft.com`  |
| 6. Using Azure Firewall Manager, ensure all connected virtual networks to a secure virtual hub are protected by Azure Firewall.                                                | Virtual hub name <br> Internet traffic - traffic from virtual networks | Virtual hub name: `vhub-neu` <br> Internet traffic - traffic from virtual networks - send via Azure Firewall |
| 7. Deploy and configure an Azure Private DNS zone within the global `connectivity` subscription.                                                             | Private DNS zone name               | Private DNS zone name: `azure.contoso.com` |
| 8. Provision ExpressRoute circuits with private peering.                                                                                                 | [Follow instructions as per article](https://docs.microsoft.com/azure/expressroute/expressroute-howto-routing-portal-resource-manager#private) | [Follow instructions as per article](https://docs.microsoft.com/azure/expressroute/expressroute-howto-routing-portal-resource-manager#private) |
| 9. Connect on-premises HQs/DCs to Azure Virtual WAN virtual hub via ExpressRoute circuits.                                                                                | Authorization key <br> Virtual hub name | Authorization key: `xxxxxxxx` <br> Virtual hub: `vhub-neu` |
| 10. (Optional): Setup encryption over ExpressRoute private peering.                                                                                         | [Follow instructions as per article](https://docs.microsoft.com/azure/virtual-wan/vpn-over-expressroute) | [Follow instructions as per article](https://docs.microsoft.com/azure/virtual-wan/vpn-over-expressroute) |
| 11. (Optional): Connect branches to Azure Virtual WAN virtual hub via VPN.                                                                                                | [Follow instructions as per article](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-site-to-site-portal) | [Follow instructions as per article](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-site-to-site-portal) |
| 12. Protect virtual network traffic across virtual hubs with NSGs.                                                                                                             | Inbound rules <br> Outbound rules | Inbound rules <br> Outbound rules |
| 13. Configure ExpressRoute Global Reach for connecting on-premises HQs/DCs when more than one on-premises location is connected to Azure via ExpressRoute. | [Follow instructions as per article](https://docs.microsoft.com/azure/expressroute/expressroute-howto-set-global-reach) | [Follow instructions as per article](https://docs.microsoft.com/azure/expressroute/expressroute-howto-set-global-reach) |

<!-- markdownlint-enable MD033 -->

### Security, governance, and compliance

| Activities                                                                                                                                              | Parameters required | Enterprise-scale example configuration   |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|----------------------------------|
| 1. Define and apply a service whitelisting framework to ensure Azure services meet enterprise security and governance requirements (see appendix). |                     |                                  |
| 2. Create custom role-based access control (RBAC) role definitions.                                                                                                              |                     |                                  |
| 3. Enable PIM and discover Azure resources to facilitate privileged identity management.                                                             |                     |                                  |
| 4. Create Azure AD-only groups for the Azure control plane management of resources using PIM.                                                             |                     |                                  |
| 5. Apply Azure Policy to ensure Azure services are compliant to enterprise requirements.                                                             |                     |                                  |
| 6. Define a naming convention and enforce it via Azure Policy.                                                                                       |                     |                                  |
| 7. Create a policy matrix at all scopes (for example, enable monitoring for all Azure services).                                                             |                     |                                  |
| 8. Apply Azure policies related to networking, security, and monitoring (refer to the example policies list provided below).                |                     |                                  |

### Platform management and monitoring

| Activities                                                                                                       | Parameters required | Enterprise-scale example configuration   |
|------------------------------------------------------------------------------------------------------------------|---------------------|----------------------------------|
| 1. Create policy compliance and security dashboards for organizational and resource-centric views.            |                     |                                  |
| 2. Create a workflow for platform secrets (service principals and automation account) and key rollover.     |                     |                                  |
| 3. (Optional): Set up an organization-wide virtual machine gallery image.                                                  |                     |                                  |
| 4. Set up long-term archiving and retention for logs within Azure Monitor Logs.                                    |                     |                                  |
| 5. Set up business continuity and disaster recovery (BCDR) for key vaults used to store platform secrets.                                                  |                     |                                  |
| 6. Using Azure Firewall Manager, ensure that all connected virtual networks to a secure virtual hub are protected by Azure Firewall. |                     |                                  |

The table below provides a list of example Azure policies to enforce typical networking, security, and monitoring controls at a management group scope.

| Category   | Policy                                                                                           |
|------------|--------------------------------------------------------------------------------------------------|
| Network    | 1. (Preview): Container Registry should use a virtual network service endpoint.                   |
|            | 2. A custom IP security/internet key exchange policy must be applied to all Azure Virtual Network gateway connections.    |
|            | 3. App Service should use a virtual network service endpoint (internal apps only).                |
|            | 4. Azure VPN gateways should not use a basic stock-keeping unit (SKU).                                                 |
|            | 5. Azure Cosmos DB should use a virtual network service endpoint.                                       |
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
| Security   | 1. [Preview]: Audit dependency agent deployment&mdash;virtual machine (VM) image (OS) unlisted.                         |
|            | 2. [Preview]: Audit dependency agent deployment in VMSS&mdash;VM image (OS) unlisted.                 |
|            | 3. [Preview]: Audit Azure Monitor Logs agent deployment&mdash;VM image (OS) unlisted.                      |
|            | 4. [Preview]: Audit Azure Monitor Logs agent deployment in VMSS&mdash;VM image (OS) unlisted.              |
|            | 5. [Preview]: Audit Azure Monitor Logs workspace for VM&mdash;report mismatch.                             |
|            | 6. [Preview]: Deploy dependency agent for Linux VMs.                                              |
|            | 7. [Preview]: Deploy dependency agent for Windows VMs.                                            |
|            | 8. [Preview]: Deploy Azure Monitor Logs agent for Linux VMs.                                           |
|            | 9. [Preview]: Deploy Azure Monitor Logs agent for Windows VMs.                                         |
|            | 10. Activity log should be retained for at least one year.                                        |
|            | 11. Audit diagnostic setting.                                                                     |
|            | 12. Azure Monitor log profile should collect logs for categories `write`, `delete`, and `action`. |
|            | 13. Azure Monitor should collect activity logs from all regions.                                  |
|            | 14. Azure Monitor solution 'security and audit' must be deployed.                                 |
|            | 15. Azure subscriptions should have a log profile for activity log.                               |
|            | 16. Deploy diagnostic settings for batch account to event hub.                                    |
|            | 17. Deploy diagnostic settings for batch account to Azure Monitor Logs workspace.                      |
|            | 18. Deploy diagnostic settings for Data Lake Analytics to event hub.                              |
|            | 19. Deploy diagnostic settings for Data Lake Analytics to Azure Monitor Logs workspace.                |
|            | 20. Deploy diagnostic settings for Data Lake Storage gen1 to event hub.                           |
|            | 21. Deploy diagnostic settings for Data Lake Storage gen1 to Azure Monitor Logs workspace.             |
|            | 22. Deploy diagnostic settings for event hub to event hub.                                        |
|            | 23. Deploy diagnostic settings for event hub to Azure Monitor Logs workspace.                          |
|            | 24. Deploy diagnostic settings for Key Vault to Azure Monitor Logs workspace.                          |
|            | 25. Deploy diagnostic settings for Logic Apps to event hub.                                       |
|            | 26. Deploy diagnostic settings for Logic Apps to Azure Monitor Logs workspace.                         |
|            | 27. Deploy diagnostic settings for network security groups.                                       |
|            | 28. Deploy diagnostic settings for search services to event hub.                                  |
|            | 29. Deploy diagnostic settings for search services to Azure Monitor Logs workspace.                    |
|            | 30. Deploy diagnostic settings for Service Bus to event hub.                                      |
|            | 31. Deploy diagnostic settings for Service Bus to Azure Monitor Logs workspace.                        |
|            | 32. Deploy diagnostic settings for stream analytics to event hub.                                 |
|            | 33. Deploy diagnostic settings for stream analytics to Azure Monitor Logs workspace.                   |
|            | 34. The Azure Monitor Logs agent should be installed on virtual machine scale sets.                    |
|            | 35. The Azure Monitor Logs agent should be installed on virtual machines.                              |
| Monitoring | 36. [Preview]: Audit dependency agent deployment&mdash;VM image (OS) unlisted.                        |
|            | 37. [Preview]: Audit dependency agent deployment in VMSS&mdash;VM image (OS) unlisted.                |
|            | 38. [Preview]: Audit Azure Monitor Logs agent deployment&mdash;VM image (OS) unlisted.                     |
|            | 39. [Preview]: Audit Azure Monitor Logs agent deployment in VMSS&mdash;VM image (OS) unlisted.             |
|            | 40. [Preview]: Audit Azure Monitor Logs workspace for VM&mdash;report mismatch.                            |
|            | 41. [Preview]: Deploy dependency agent for Linux VMs.                                             |
|            | 42. [Preview]: Deploy dependency agent for Windows VMs.                                           |
|            | 43. [Preview]: Deploy Azure Monitor Logs agent for Linux VMs.                                          |
|            | 44. [Preview]: Deploy Azure Monitor Logs agent for Windows VMs.                                        |
|            | 45. Activity log should be retained for at least one year.                                        |
|            | 46. Audit diagnostic setting.                                                                     |
|            | 47. Azure Monitor log profile should collect logs for categories `write`, `delete`, and `action`. |
|            | 48. Azure Monitor should collect activity logs from all regions.                                  |
|            | 49. Azure Monitor solution `security and audit` must be deployed.                                 |
|            | 50. Azure subscriptions should have a log profile for activity log.                               |
|            | 51. Deploy diagnostic settings for batch account to event hub.                                    |
|            | 52. Deploy diagnostic settings for batch account to Azure Monitor Logs workspace.                      |
|            | 53. Deploy diagnostic settings for Data Lake Analytics to event hub.                              |
|            | 54. Deploy diagnostic settings for Data Lake Analytics to Azure Monitor Logs workspace.                |
|            | 55. Deploy diagnostic settings for Data Lake Storage gen1 to event hub.                           |
|            | 56. Deploy diagnostic settings for Data Lake Storage gen1 to Azure Monitor Logs workspace.             |
|            | 57. Deploy diagnostic settings for event hub to event hub.                                        |
|            | 58. Deploy diagnostic settings for event hub to Azure Monitor Logs workspace.                          |
|            | 59. Deploy diagnostic settings for Key Vault to Azure Monitor Logs workspace.                          |
|            | 60. Deploy diagnostic settings for Logic Apps to event hub.                                       |
|            | 61. Deploy diagnostic settings for Logic Apps to Azure Monitor Logs workspace.                         |
|            | 62. Deploy diagnostic settings for network security groups.                                       |
|            | 63. Deploy diagnostic settings for search services to event hub.                                  |
|            | 64. Deploy diagnostic settings for search services to Azure Monitor Logs workspace.                    |
|            | 65. Deploy diagnostic settings for Service Bus to event hub.                                      |
|            | 66. Deploy diagnostic settings for Service Bus to Azure Monitor Logs workspace.                        |
|            | 67. Deploy diagnostic settings for stream analytics to event hub.                                 |
|            | 68. Deploy diagnostic settings for stream analytics to Azure Monitor Logs workspace.                   |
|            | 69. The Azure Monitor Logs agent should be installed on virtual machine scale sets.                    |
|            | 70. The Azure Monitor Logs agent should be installed on virtual machines.                              |
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

2. Secure virtual hub with Azure Firewall Manager by deploying an Azure Firewall within the virtual hub and link existing or new firewall policies to Azure Firewall.

3. Using Azure Firewall Manager, ensure that all connected virtual networks to a secure virtual hub are protected by Azure Firewall

4. Connect the virtual hub to on-premises using ExpressRoute or alternatively via VPN.

5. (Optional) set up encryption over ExpressRoute private peering.

6. Protect virtual network traffic across virtual hubs with NSGs.

### File -&gt; new -&gt; landing zone for applications and workloads

1. Create a subscription and assign the requestor as the subscription owner.

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
| Compute           | 12. Allowed virtual machine SKUs                                                                       |
|                   | 13. Audit virtual machines without disaster recovery configured                                        |
|                   | 14. Audit VMs that do not use managed disks                                                            |
|                   | 15. Deploy default Microsoft infrastructure-as-a-service (IaaS) Anti-malware extension for Windows Server                              |
|                   | 16. Diagnostic logs in virtual machine scale sets should be enabled                                    |
|                   | 17. Microsoft Anti-malware for Azure should be configured to automatically update protection signatures |
|                   | 18. Microsoft IaaS Anti-malware extension should be deployed on Windows servers                          |
|                   | 19. Only approved VM extensions should be installed                                                    |
|                   | 20. Require automatic OS image patching on virtual machine scale sets                                  |
|                   | 21. Unattached disks should be encrypted                                                               |
|                   | 22. Network interfaces should not have public IPs                                                      |
|                   | 23. Virtual machines should be connected to an approved virtual network                                |
|                   | 24. Virtual networks should use specified virtual network gateway                                      |
