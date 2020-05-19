---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Implementation guideline

This section covers how to get started with the enterprise-scale platform-native reference implementation and outline design objectives, current design, faqs and known issues.

There are two categories of activities that must take place in order to implement the "enterprise-scale" architecture.

1. **What-must-be-true** for the "enterprise-scale"
    - Encompasses activities that must be performed by the Azure and Azure AD administrators to establish an initial configuration; these are sequential by nature and primarily one-off activities.

2. **File -&gt; new -&gt; region** and **File -&gt; New -&gt; landing zone**
    - These are reoccurring activities that are required to instantiate a "landing zone" and require user input to kickstart the workflow which will coordinate resource creation within Azure AD and ad.
    - To operationalize at scale, it is paramount that these activities follow the principal of "infrastructure-as-code" and automated using deployment pipelines.

## 1. *What-must-be-true for the CAF enterprise-scale landing zone*

### 1.1 EA enrollment and Azure AD tenants

| Activities                                                                                       | Parameters required | Enterprise-scale example configuration   |
|--------------------------------------------------------------------------------------------------|---------------------|----------------------------------|
| 1\. Setup the EA administrator and notification account\.                                       |                     |                                  |
| 2\. Create departments&mdash;business domains/geo-based/org hierarchy\.                             |                     |                                  |
| 3\. Create an EA account and assign budget\.                                                    |                     |                                  |
| 4\. Setup Azure AD Connect for each Azure AD tenant if identity is to be synchronized from on\-premises\. |                     |                                  |
| 5\. Establish zero standing access to Azure resources and just\-in time access via Azure AD PIM\.    |                     |                                  |

### 1.2 Management group and subscription

| Activities                                                                                                                            | Parameters required | Enterprise-scale example configuration   |
|---------------------------------------------------------------------------------------------------------------------------------------|---------------------|----------------------------------|
| 1\. Create management group hierarchy \(ideally using no more than 3 or 4 levels\)\.                                                 |                     |                                  |
| 2\. Create a top\-level "sandbox" management group for users to experiment with Azure\.                                              |                     |                                  |
| 3\. Publish a subscription provisioning criteria along with the responsibilities of a subscription owner \(potentially as a wiki\)\. |                     |                                  |
| 4\. Create "management" and "connectivity" subscriptions for platform management and global networking and connectivity resources\.  |                     |                                  |
| 5\. Setup a Git repository and service principle for use with a platform CI/CD pipeline\.                                            |                     |                                  |
| 6\. Create custom role definitions and manage entitlements using Azure AD PIM for subscription and management group scopes\.              |                     |                                  |

### 1.3 Global networking and connectivity

<!-- markdownlint-disable MD033 -->

| Activities                                                                                                                                                      | Parameters required                 | Enterprise-scale example configuration             |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------|--------------------------------------------|
| 1\. Allocate an appropriate virtual network cidr range for each Azure region where virtual WAN virtual hubs and virtual networks will be deployed\.                                                | 1X cidr range per region            |  North Europe: 10.0.0.0/16<br>West Europe: 10.1.0.0/16<br>East US: 10.2.0.0/16 |
| 2\. Create Azure Virtual WAN standard within the "connectivity" subscription\.                                                                                 | Virtual WAN name<br>Azure region | Virtual WAN name: Contoso-vwan<br>Azure region: North Europe |
| 3\. Create a virtual WAN virtual hub for each region\. Ensure at least one gateway \(ExpressRoute and/or VPN\) per virtual WAN virtual hub are deployed\.                                  | Virtual WAN name<br>Virtual hub name<br>Virtual hub region<br>Virtual hub address space<br>ExpressRoute gateway<br>VPN gateway | Virtual WAN: Contoso-vwan<br>Virtual hub region: North Europe<br>Virtual hub name: virtual hub-neu<br>Virtual hub address space: 10.0.0.0/16<br>ExpressRoute gateway: yes (1 scale unit) <br>VPN gateway: no |
| 4\. Using Azure Firewall Manager, secure virtual WAN virtual hubs by deploying Azure Firewall within each virtual WAN virtual hub\.                                                        | Virtual hub name                           | Virtual hub name: virtual hub\-neu                       |
| 5\. Create required firewall policies within the "connectivity" subscription and assign them to secure virtual hubs\.                                                 | Azure Firewall policy name<br>Firewall policy inbound/outbound rules | Firewall policy name: Contoso-global-fw-policy<br> Allow outbound rules to *.Microsoft.COM  |
| 6\. Using Azure Firewall Manager, ensure all connected virtual networks to a secure virtual hub are protected by Azure Firewall\.                                                | Virtual hub name<br>internet traffic - traffic from virtual networks | Virtual hub name: virtual hub-neu<br>internet traffic - traffic from virtual networks - send via Azure Firewall |
| 7\. Deploy and configure an Azure Private DNS zone within the global "connectivity" subscription\.                                                             | Private DNS zone name               | Private DNS zone name: Azure\.Contoso\.COM |
| 8\. Provision ExpressRoute circuit\(s\) with private peering\.                                                                                                 | [Follow instructions as per article](https://docs.microsoft.com/azure/expressroute/expressroute-howto-routing-portal-resource-manager#private) | [Follow instructions as per article](https://docs.microsoft.com/azure/expressroute/expressroute-howto-routing-portal-resource-manager#private) |
| 9\. Connect on\-premises hqs/DCs to Azure Virtual WAN virtual hub via ExpressRoute circuits\.                                                                                | Authorization key<br>Virtual hub name | Authoriztion key: xxxxxxxx<br>Virtual hub: virtual hub-neu |
| 10\.  \(Optional\) setup encryption over ExpressRoute private peering\.                                                                                         | [Follow instructions as per article](https://docs.microsoft.com/azure/virtual-wan/vpn-over-expressroute) | [Follow instrunctions as per article](https://docs.microsoft.com/azure/virtual-wan/vpn-over-expressroute) |
| 11\.  \(Optional\) connect branches to Azure Virtual WAN virtual hub via VPN\.                                                                                                | [Follow instructions as per article](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-site-to-site-portal) | [Follow instructions as per article](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-site-to-site-portal) |
| 12\. Protect virtual network traffic across virtual hubs with NSGs\.                                                                                                             | Inbound rules<br>Outbound rules | Inbound rules<br>Outbound rules |
| 13\. Configure ExpressRoute Global Reach for connecting on\-premises hqs/DCs when more than one on\-premises location is connected to Azure via ExpressRoute\. | [Follow instructions as per article](https://docs.microsoft.com/azure/expressroute/expressroute-howto-set-global-reach) | [Follow instructions as per article](https://docs.microsoft.com/azure/expressroute/expressroute-howto-set-global-reach) |

<!-- markdownlint-enable MD033 -->

### 1.4 Security, governance and compliance

| Activities                                                                                                                                              | Parameters required | Enterprise-scale example configuration   |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|----------------------------------|
| 1\. Define and apply a service whitelisting framework to ensure Azure services meet enterprise security and governance \(see appendix\) requirements \. |                     |                                  |
| 2\. Create custom RBAC role definitions\.                                                                                                              |                     |                                  |
| 3\. Enable PIM and discover Azure resources to facilitate privileged identity management\.                                                             |                     |                                  |
| 4\. Create Azure AD only groups for the Azure control plane management of resources using PIM\.                                                             |                     |                                  |
| 5\. Apply Azure Policy to ensure Azure services are compliant to enterprise requirements\.                                                             |                     |                                  |
| 6\. Define a naming convention and enforce it via Azure Policy\.                                                                                       |                     |                                  |
| 7\. Create a policy matrix at all scopes e\.g\. Enable monitoring for all Azure services\.                                                             |                     |                                  |
| 8\. Apply Azure policies related to networking, security, and monitoring \(please refer to the example policies list provided below\)\.                |                     |                                  |

### 1.5 Platform management and monitoring

| Activities                                                                                                       | Parameters required | Enterprise-scale example configuration   |
|------------------------------------------------------------------------------------------------------------------|---------------------|----------------------------------|
| 1\. Create policy compliance and security dashboards for organizational and resource centric views\.            |                     |                                  |
| 2\. Create a workflow for platform secrets \(service principles and automation account\) and key rollover\.     |                     |                                  |
| 3\.  \(Optional\) setup an organization wide VM gallery image\.                                                  |                     |                                  |
| 4\. Setup long\-term archiving and retention for logs within Log Analytics\.                                    |                     |                                  |
| 5\. Setup BCDR for key vaults used to store platform secrets\.                                                  |                     |                                  |
| 6\. Using Azure Firewall Manager, ensure all connected virtual networks to a secure virtual hub are protected by Azure Firewall\. |                     |                                  |

The table below provides a list of example Azure policies to enforce typical networking, security and monitoring controls at a management group scope.

| Category   | Policy                                                                                           |
|------------|--------------------------------------------------------------------------------------------------|
| Network    | 1. [Preview]: Container Registry should use a virtual network service endpoint                   |
|            | 2. A custom IPsec/ike policy must be applied to all Azure Virtual Network gateway connections    |
|            | 3. App Service should use a virtual network service endpoint [internal apps only]                |
|            | 4. Azure VPN gateways should not use 'basic' SKU                                                 |
|            | 5. Azure Cosmos DB should use a virtual network service endpoint                                       |
|            | 6. Deploy Network Watcher when virtual networks are created                                      |
|            | 7. Event hub should use a virtual network service endpoint                                       |
|            | 8. Gateway subnets should not be configured with a network security group                        |
|            | 9. Key Vault should use a virtual network service endpoint                                       |
|            | 10. Network interfaces should disable IP forwarding                                              |
|            | 11. Service Bus should use a virtual network service endpoint                                    |
|            | 12. SQL Server should use a virtual network service endpoint                                     |
|            | 13. Storage accounts should use a virtual network service endpoint                               |
|            | 14. Subnets should be associated with a network security group                                   |
|            | 15. Monitor unprotected network endpoints in Azure Security Center.                              |
| Security   | 1. [Preview]: Audit dependency agent deployment&mdash;VM image (OS) unlisted                         |
|            | 2. [Preview]: Audit dependency agent deployment in vmss&mdash;VM image (OS) unlisted                 |
|            | 3. [Preview]: Audit Log Analytics agent deployment&mdash;VM image (OS) unlisted                      |
|            | 4. [Preview]: Audit Log Analytics agent deployment in vmss&mdash;VM image (OS) unlisted              |
|            | 5. [Preview]: Audit Log Analytics workspace for VM&mdash;report mismatch                             |
|            | 6. [Preview]: Deploy dependency agent for Linux VMs                                              |
|            | 7. [Preview]: Deploy dependency agent for Windows VMs                                            |
|            | 8. [Preview]: Deploy Log Analytics agent for Linux VMs                                           |
|            | 9. [Preview]: Deploy Log Analytics agent for Windows VMs                                         |
|            | 10. Activity log should be retained for at least one year                                        |
|            | 11. Audit diagnostic setting                                                                     |
|            | 12. Azure Monitor log profile should collect logs for categories 'write,' 'delete,' and 'action' |
|            | 13. Azure Monitor should collect activity logs from all regions                                  |
|            | 14. Azure Monitor solution 'security and audit' must be deployed                                 |
|            | 15. Azure subscriptions should have a log profile for activity log                               |
|            | 16. Deploy diagnostic settings for batch account to event hub                                    |
|            | 17. Deploy diagnostic settings for batch account to Log Analytics workspace                      |
|            | 18. Deploy diagnostic settings for Data Lake Analytics to event hub                              |
|            | 19. Deploy diagnostic settings for Data Lake Analytics to Log Analytics workspace                |
|            | 20. Deploy diagnostic settings for Data Lake Storage gen1 to event hub                           |
|            | 21. Deploy diagnostic settings for Data Lake Storage gen1 to Log Analytics workspace             |
|            | 22. Deploy diagnostic settings for event hub to event hub                                        |
|            | 23. Deploy diagnostic settings for event hub to Log Analytics workspace                          |
|            | 24. Deploy diagnostic settings for Key Vault to Log Analytics workspace                          |
|            | 25. Deploy diagnostic settings for Logic Apps to event hub                                       |
|            | 26. Deploy diagnostic settings for Logic Apps to Log Analytics workspace                         |
|            | 27. Deploy diagnostic settings for network security groups                                       |
|            | 28. Deploy diagnostic settings for search services to event hub                                  |
|            | 29. Deploy diagnostic settings for search services to Log Analytics workspace                    |
|            | 30. Deploy diagnostic settings for Service Bus to event hub                                      |
|            | 31. Deploy diagnostic settings for Service Bus to Log Analytics workspace                        |
|            | 32. Deploy diagnostic settings for stream analytics to event hub                                 |
|            | 33. Deploy diagnostic settings for stream analytics to Log Analytics workspace                   |
|            | 34. The Log Analytics agent should be installed on virtual machine scale sets                    |
|            | 35. The Log Analytics agent should be installed on virtual machines                              |
| Monitoring | 36. [Preview]: Audit dependency agent deployment&mdash;VM image (OS) unlisted                        |
|            | 37. [Preview]: Audit dependency agent deployment in vmss&mdash;VM image (OS) unlisted                |
|            | 38. [Preview]: Audit Log Analytics agent deployment&mdash;VM image (OS) unlisted                     |
|            | 39. [Preview]: Audit Log Analytics agent deployment in vmss&mdash;VM image (OS) unlisted             |
|            | 40. [Preview]: Audit Log Analytics workspace for VM&mdash;report mismatch                            |
|            | 41. [Preview]: Deploy dependency agent for Linux VMs                                             |
|            | 42. [Preview]: Deploy dependency agent for Windows VMs                                           |
|            | 43. [Preview]: Deploy Log Analytics agent for Linux VMs                                          |
|            | 44. [Preview]: Deploy Log Analytics agent for Windows VMs                                        |
|            | 45. Activity log should be retained for at least one year                                        |
|            | 46. Audit diagnostic setting                                                                     |
|            | 47. Azure Monitor log profile should collect logs for categories 'write,' 'delete,' and 'action' |
|            | 48. Azure Monitor should collect activity logs from all regions                                  |
|            | 49. Azure Monitor solution 'security and audit' must be deployed                                 |
|            | 50. Azure subscriptions should have a log profile for activity log                               |
|            | 51. Deploy diagnostic settings for batch account to event hub                                    |
|            | 52. Deploy diagnostic settings for batch account to Log Analytics workspace                      |
|            | 53. Deploy diagnostic settings for Data Lake Analytics to event hub                              |
|            | 54. Deploy diagnostic settings for Data Lake Analytics to Log Analytics workspace                |
|            | 55. Deploy diagnostic settings for Data Lake Storage gen1 to event hub                           |
|            | 56. Deploy diagnostic settings for Data Lake Storage gen1 to Log Analytics workspace             |
|            | 57. Deploy diagnostic settings for event hub to event hub                                        |
|            | 58. Deploy diagnostic settings for event hub to Log Analytics workspace                          |
|            | 59. Deploy diagnostic settings for Key Vault to Log Analytics workspace                          |
|            | 60. Deploy diagnostic settings for Logic Apps to event hub                                       |
|            | 61. Deploy diagnostic settings for Logic Apps to Log Analytics workspace                         |
|            | 62. Deploy diagnostic settings for network security groups                                       |
|            | 63. Deploy diagnostic settings for search services to event hub                                  |
|            | 64. Deploy diagnostic settings for search services to Log Analytics workspace                    |
|            | 65. Deploy diagnostic settings for Service Bus to event hub                                      |
|            | 66. Deploy diagnostic settings for Service Bus to Log Analytics workspace                        |
|            | 67. Deploy diagnostic settings for stream analytics to event hub                                 |
|            | 68. Deploy diagnostic settings for stream analytics to Log Analytics workspace                   |
|            | 69. The Log Analytics agent should be installed on virtual machine scale sets                    |
|            | 70. The Log Analytics agent should be installed on virtual machines                              |
| Key Vault  | 71. [Preview]: Manage allowed certificate key types                                              |
|            | 72. [Preview]: Manage allowed curve names for elliptic curve cryptography certificates           |
|            | 73. [Preview]: Manage certificate lifetime action triggers                                       |
|            | 74. [Preview]: Manage certificate validity period                                                |
|            | 75. [Preview]: Manage certificates issued by a nonintegrated ca                                 |
|            | 76. [Preview]: Manage certificates issued by an integrated ca                                    |
|            | 77. [Preview]: Manage certificates that are within a specified number of days of expiration      |
|            | 78. [Preview]: Manage minimum key size for rsa certificates                                      |
|            | 79. Deploy diagnostic settings for Key Vault to event hub                                        |
|            | 80. Diagnostic logs in Key Vault should be enabled                                               |
|            | 81. Enable soft delete for Key Vault                                                             |

## 2.  **File -&gt; new -&gt; region** and **File -&gt; New -&gt; landing zone**

## File -&gt; new -&gt; region

1. Within the "connectivity" subscription, create a new virtual hub within the existing Azure Virtual WAN.

2. Secure virtual hub with Azure Firewall Manager by deploying an Azure Firewall within the virtual hub and link existing or new firewall policies to Azure Firewall.

3. Using Azure Firewall Manager, ensure all connected virtual networks to a secure virtual hub are protected by Azure Firewall

4. Connect the virtual hub to on-premises using ExpressRoute or alternatively via VPN.

5. (Optional) setup encryption over ExpressRoute private peering.

6. Protect virtual network traffic across virtual hubs with NSGs.

## File -&gt; new -&gt; "landing zone" for applications and workloads

1. Create a subscription and assign the requestor as the "subscription owner".

2. Assign the subscription within the management group hierarchy.

3. Set a budget and alert notifications.

4. Setup a security contact email address and phone number.

5. Create Azure AD groups for the subscription (n) &mdash;owner, reader, contributor etc.

6. Create Azure AD PIM entitlements for established Azure AD groups.

7. Provision the virtual network cidr range if it requires virtual network connectivity\*.

8. Peer the virtual network with the regional virtual hub \*.

9. Provision required shared services, e.g. Domain controllers\*

10. Assign required policies for the subscription scope as mandated by the policy matrix defined by organization.

\*Optional for sandbox subscriptions.

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
|                   | 15. Deploy default Microsoft iaasantimalware extension for Windows Server                              |
|                   | 16. Diagnostic logs in virtual machine scale sets should be enabled                                    |
|                   | 17. Microsoft antimalware for Azure should be configured to automatically update protection signatures |
|                   | 18. Microsoft iaasantimalware extension should be deployed on Windows servers                          |
|                   | 19. Only approved VM extensions should be installed                                                    |
|                   | 20. Require automatic OS image patching on virtual machine scale sets                                  |
|                   | 21. Unattached disks should be encrypted                                                               |
|                   | 22. Network interfaces should not have public IPs                                                      |
|                   | 23. Virtual machines should be connected to an approved virtual network                                |
|                   | 24. Virtual networks should use specified virtual network gateway                                      |
