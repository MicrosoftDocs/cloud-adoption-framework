---
title: "Implementation Guideline"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: North Star landing zone - Implementation Guideline
author: uday31in
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# Implementation Guideline

There are two categories of activities that must take place in order to implement the “North Star” architecture.

1. **What-must-be-true** for a the “North Star”
    - Encompasses activities that must be performed by the Azure and AAD administrators to establish an initial configuration; these are sequential by nature and primarily one-off activities.

2. **File -&gt; New -&gt; Region** and **File -&gt; New -&gt; landing zone**
    - These are reoccurring activities that are required to instantiate a “landing zone” and require user input to kickstart the workflow which will coordinate resource creation within AAD and AD.
    - To operationalize at scale, it is paramount that these activities follow the principal of “Infrastructure-as-Code” and automated using deployment pipelines.

## 1. *What-must-be-true for the “North Star”*

| No         | Area                               | Activities                                                                                                                                                     |
|------------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1          | EA Enrolment & AAD Tenants         | 1.       Setup the EA Administrator and Notification Account.                                                                                                  |
|            |                                    | 2.       Create Departments – Business Domains/Geo Based/Org Hierarchy.                                                                                        |
|            |                                    | 3.       Create an EA Account and assign budget.                                                                                                               |
|            |                                    | 4.       Setup AAD Connect for each AAD Tenant if identity is to be synchronized from on-premises.                                                             |
|            |                                    | 5.       Establish zero standing access to Azure resources and Just-in time access via AAD PIM.                                                                |
| 2.         | Management Group and Subscription  | 1.       Create Management Group hierarchy (ideally using no more than 3 or 4 levels).                                                                         |
|            |                                    | 2.       Create a top-level “Sandbox” Management Group for users to experiment with Azure.                                                                     |
|            |                                    | 3.       Publish a Subscription provisioning criteria along with the responsibilities of a Subscription Owner (potentially as a Wiki).                         |
|            |                                    | 4.       Create “Management” and “Connectivity” subscriptions for platform management and global networking and connectivity resources.                        |
|            |                                    | 5.       Setup a Git repository and Service Principle for use with a platform CI/CD pipeline.                                                                  |
|            |                                    | 6.       Create custom role definitions and manage entitlements using AAD PIM for Subscription and Management Group scopes.                                    |
| 3.         | Global Networking & Connectivity   | 1.       Create Azure Virtual WAN Standard within the “Connectivity” subscription.                                                                             |
|            |                                    | 2.       Create a VHub and allocate an appropriate Vnet CIDR range for each region. Create an ExpressRoute and/or VPN Gateways as required within each region. |
|            |                                    | 3.       Protect Vhub with Azure Firewall Manager by deploying Azure Firewall within each Vhub.                                                                |
|            |                                    | 4.       Deploy and configure an Azure Private DNS zone within a global “Connectivity” subscription.                                                           |
|            |                                    | 5.       Provision ExpressRoute circuit(s) with Private Peering.                                                                                               |
|            |                                    | 6.       Connect on-premises location to Azure VWAN Vhub via established ExpressRoute(s).                                                                      |
|            |                                    | 7.       (Optional) Setup encryption over ExpressRoute Private Peering                                                                                         |
|            |                                    | 8.       (Optional) Connect branches to Azure VWAN Vhub via VPN                                                                                                |
|            |                                    | 9.       Enable Vhub to Vhub connectivity when more than one Vhub exists.                                                                                      |
|            |                                    | 10.   Configure Azure Global Reach when more than one on-premises location is connected to Azure via ExpressRoute.                                             |
|            |                                    | 11.   Setup connectivity for inbound and outbound internet traffic by deploying and configuring Azure Firewall and Application Gateway with WAF.               |
| 4.         | Security, Governance & Compliance  | 1.       Define and apply a service whitelisting framework to ensure Azure services meet enterprise security and governance (see appendix)requirements .       |
|            |                                    | 2.       Create custom RBAC role definitions.                                                                                                                  |
|            |                                    | 3.       Enable PIM and Discover Azure resources to facilitate privileged identity management.                                                                 |
|            |                                    | 4.       Create AAD only groups for the Azure control plane management of resources using PIM.                                                                 |
|            |                                    | 5.       Apply Azure Policy to ensure Azure services are compliant to enterprise requirements.                                                                 |
|            |                                    | 6.       Define a naming convention and enforce it via Azure Policy.                                                                                           |
|            |                                    | 7.       Create a policy matrix at all scopes e.g. enable monitoring for all Azure services.                                                                   |
|            |                                    | 8.       Apply Azure Policies related to Networking, Security, and Monitoring (please refer to the example policies list provided below).                      |
| 5.         | Platform Management and Monitoring | 1.       Create Policy Compliance and Security Dashboards for organizational and resource centric views.                                                       |
|            |                                    | 2.       Create a workflow for platform secrets (service principles and automation account) and key rollover.                                                  |
|            |                                    | 3.       (Optional) Setup an organization wide VM Gallery Image.                                                                                               |
|            |                                    | 4.       Setup long-term archiving and retention for logs within Log Analytics.                                                                                |
|            |                                    | 5.       Setup BCDR for Key Vaults used to store platform secrets.                                                                                             |

The table below provides a list of example Azure Policies to enforce typical Networking, Security and Monitoring controls at a Management Group scope.

| Category   | Policy                                                                                           |
|------------|--------------------------------------------------------------------------------------------------|
| Network    | 1. [Preview]: Container Registry should use a virtual network service endpoint                   |
|            | 2. A custom Ipsec/IKE policy must be applied to all Azure virtual network gateway connections    |
|            | 3. App Service should use a virtual network service endpoint [Internal Apps Only]                |
|            | 4. Azure VPN gateways should not use ‘basic’ SKU                                                 |
|            | 5. Cosmos DB should use a virtual network service endpoint                                       |
|            | 6. Deploy network watcher when virtual networks are created                                      |
|            | 7. Event Hub should use a virtual network service endpoint                                       |
|            | 8. Gateway subnets should not be configured with a network security group                        |
|            | 9. Key Vault should use a virtual network service endpoint                                       |
|            | 10. Network interfaces should disable IP forwarding                                              |
|            | 11. Service Bus should use a virtual network service endpoint                                    |
|            | 12. SQL Server should use a virtual network service endpoint                                     |
|            | 13. Storage Accounts should use a virtual network service endpoint                               |
|            | 14. Subnets should be associated with a Network Security Group                                   |
|            | 15. Monitor unprotected network endpoints in Azure Security Center.                              |
| Security   | 1. [Preview]: Audit Dependency Agent Deployment – VM Image (OS) unlisted                         |
|            | 2. [Preview]: Audit Dependency Agent Deployment in VMSS – VM Image (OS) unlisted                 |
|            | 3. [Preview]: Audit Log Analytics Agent Deployment – VM Image (OS) unlisted                      |
|            | 4. [Preview]: Audit Log Analytics Agent Deployment in VMSS – VM Image (OS) unlisted              |
|            | 5. [Preview]: Audit Log Analytics Workspace for VM – Report Mismatch                             |
|            | 6. [Preview]: Deploy Dependency Agent for Linux VMs                                              |
|            | 7. [Preview]: Deploy Dependency Agent for Windows VMs                                            |
|            | 8. [Preview]: Deploy Log Analytics Agent for Linux VMs                                           |
|            | 9. [Preview]: Deploy Log Analytics Agent for Windows VMs                                         |
|            | 10. Activity log should be retained for at least one year                                        |
|            | 11. Audit diagnostic setting                                                                     |
|            | 12. Azure Monitor log profile should collect logs for categories ‘write,’ ‘delete,’ and ‘action’ |
|            | 13. Azure Monitor should collect activity logs from all regions                                  |
|            | 14. Azure Monitor solution ‘Security and Audit’ must be deployed                                 |
|            | 15. Azure subscriptions should have a log profile for Activity Log                               |
|            | 16. Deploy Diagnostic Settings for Batch Account to Event Hub                                    |
|            | 17. Deploy Diagnostic Settings for Batch Account to Log Analytics workspace                      |
|            | 18. Deploy Diagnostic Settings for Data Lake Analytics to Event Hub                              |
|            | 19. Deploy Diagnostic Settings for Data Lake Analytics to Log Analytics workspace                |
|            | 20. Deploy Diagnostic Settings for Data Lake Storage Gen1 to Event Hub                           |
|            | 21. Deploy Diagnostic Settings for Data Lake Storage Gen1 to Log Analytics workspace             |
|            | 22. Deploy Diagnostic Settings for Event Hub to Event Hub                                        |
|            | 23. Deploy Diagnostic Settings for Event Hub to Log Analytics workspace                          |
|            | 24. Deploy Diagnostic Settings for Key Vault to Log Analytics workspace                          |
|            | 25. Deploy Diagnostic Settings for Logic Apps to Event Hub                                       |
|            | 26. Deploy Diagnostic Settings for Logic Apps to Log Analytics workspace                         |
|            | 27. Deploy Diagnostic Settings for Network Security Groups                                       |
|            | 28. Deploy Diagnostic Settings for Search Services to Event Hub                                  |
|            | 29. Deploy Diagnostic Settings for Search Services to Log Analytics workspace                    |
|            | 30. Deploy Diagnostic Settings for Service Bus to Event Hub                                      |
|            | 31. Deploy Diagnostic Settings for Service Bus to Log Analytics workspace                        |
|            | 32. Deploy Diagnostic Settings for Stream Analytics to Event Hub                                 |
|            | 33. Deploy Diagnostic Settings for Stream Analytics to Log Analytics workspace                   |
|            | 34. The Log Analytics agent should be installed on Virtual Machine Scale Sets                    |
|            | 35. The Log Analytics agent should be installed on virtual machines                              |
| Monitoring | 36. [Preview]: Audit Dependency Agent Deployment – VM Image (OS) unlisted                        |
|            | 37. [Preview]: Audit Dependency Agent Deployment in VMSS – VM Image (OS) unlisted                |
|            | 38. [Preview]: Audit Log Analytics Agent Deployment – VM Image (OS) unlisted                     |
|            | 39. [Preview]: Audit Log Analytics Agent Deployment in VMSS – VM Image (OS) unlisted             |
|            | 40. [Preview]: Audit Log Analytics Workspace for VM – Report Mismatch                            |
|            | 41. [Preview]: Deploy Dependency Agent for Linux VMs                                             |
|            | 42. [Preview]: Deploy Dependency Agent for Windows VMs                                           |
|            | 43. [Preview]: Deploy Log Analytics Agent for Linux VMs                                          |
|            | 44. [Preview]: Deploy Log Analytics Agent for Windows VMs                                        |
|            | 45. Activity log should be retained for at least one year                                        |
|            | 46. Audit diagnostic setting                                                                     |
|            | 47. Azure Monitor log profile should collect logs for categories ‘write,’ ‘delete,’ and ‘action’ |
|            | 48. Azure Monitor should collect activity logs from all regions                                  |
|            | 49. Azure Monitor solution ‘Security and Audit’ must be deployed                                 |
|            | 50. Azure subscriptions should have a log profile for Activity Log                               |
|            | 51. Deploy Diagnostic Settings for Batch Account to Event Hub                                    |
|            | 52. Deploy Diagnostic Settings for Batch Account to Log Analytics workspace                      |
|            | 53. Deploy Diagnostic Settings for Data Lake Analytics to Event Hub                              |
|            | 54. Deploy Diagnostic Settings for Data Lake Analytics to Log Analytics workspace                |
|            | 55. Deploy Diagnostic Settings for Data Lake Storage Gen1 to Event Hub                           |
|            | 56. Deploy Diagnostic Settings for Data Lake Storage Gen1 to Log Analytics workspace             |
|            | 57. Deploy Diagnostic Settings for Event Hub to Event Hub                                        |
|            | 58. Deploy Diagnostic Settings for Event Hub to Log Analytics workspace                          |
|            | 59. Deploy Diagnostic Settings for Key Vault to Log Analytics workspace                          |
|            | 60. Deploy Diagnostic Settings for Logic Apps to Event Hub                                       |
|            | 61. Deploy Diagnostic Settings for Logic Apps to Log Analytics workspace                         |
|            | 62. Deploy Diagnostic Settings for Network Security Groups                                       |
|            | 63. Deploy Diagnostic Settings for Search Services to Event Hub                                  |
|            | 64. Deploy Diagnostic Settings for Search Services to Log Analytics workspace                    |
|            | 65. Deploy Diagnostic Settings for Service Bus to Event Hub                                      |
|            | 66. Deploy Diagnostic Settings for Service Bus to Log Analytics workspace                        |
|            | 67. Deploy Diagnostic Settings for Stream Analytics to Event Hub                                 |
|            | 68. Deploy Diagnostic Settings for Stream Analytics to Log Analytics workspace                   |
|            | 69. The Log Analytics agent should be installed on Virtual Machine Scale Sets                    |
|            | 70. The Log Analytics agent should be installed on virtual machines                              |
| Key Vault  | 71. [Preview]: Manage allowed certificate key types                                              |
|            | 72. [Preview]: Manage allowed curve names for elliptic curve cryptography certificates           |
|            | 73. [Preview]: Manage certificate lifetime action triggers                                       |
|            | 74. [Preview]: Manage certificate validity period                                                |
|            | 75. [Preview]: Manage certificates issued by a non-integrated CA                                 |
|            | 76. [Preview]: Manage certificates issued by an integrated CA                                    |
|            | 77. [Preview]: Manage certificates that are within a specified number of days of expiration      |
|            | 78. [Preview]: Manage minimum key size for RSA certificates                                      |
|            | 79. Deploy Diagnostic Settings for Key Vault to Event Hub                                        |
|            | 80. Diagnostic logs in Key Vault should be enabled                                               |
|            | 81. Enable Soft Delete for Key Vault                                                             |

## 2.  **File -&gt; New -&gt; Region** and **File -&gt; New -&gt; landing zone**

## File -&gt; New -&gt; Region

1.  Within the “Connectivity” subscription, create a new VHub within the existing Azure VWAN.

2.  Protect VHub with Azure Firewall Manager by deploying an Azure Firewall within the VHub.

3.  Connect the VHub to on-premises using ExpressRoute or alternatively via VPN.

4.  Allocate an appropriate VNet CIDR range for the VHub and any VNets to be connected to the VHub.

5.  Enable VHub to VHub connectivity across Azure regions.

6.  If it is the first/primary region, provision an AAD DS instance in primary location (optional)

## File -&gt; New -&gt; “landing zone” for Applications and Workloads

1.  Create a Subscription and assign the requestor as the “Subscription Owner”.

2.  Assign the Subscription within the Management Group Hierarchy.

3.  Set a Budget and Alert Notifications.

4.  Setup a security contact email address and phone number.

5.  Create AAD groups for the Subscription (N) – Owner, Reader, Contributor etc.

6.  Create AAD PIM entitlements for established AAD groups.

7.  Provision the VNet CIDR range if it requires VNet connectivity\*.

8.  Peer the VNet with the regional VHub \*.

9.  Provision required shared services, e.g. Domain Controllers\*

10. Assign required policies for the Subscription scope as mandated by the policy matrix defined by organization.

\*optional for Sandbox subscriptions.

The table below provides a list of example Azure Policies to enforce typical enterprise controls at a Subscription scope.

| Category          | Policy                                                                                                 |
|-------------------|--------------------------------------------------------------------------------------------------------|
| Resource and Tags | 1. Allowed locations                                                                                   |
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
|                   | 15. Deploy default Microsoft IaaSAntimalware extension for Windows Server                              |
|                   | 16. Diagnostic logs in Virtual Machine Scale Sets should be enabled                                    |
|                   | 17. Microsoft Antimalware for Azure should be configured to automatically update protection signatures |
|                   | 18. Microsoft IaaSAntimalware extension should be deployed on Windows servers                          |
|                   | 19. Only approved VM extensions should be installed                                                    |
|                   | 20. Require automatic OS image patching on Virtual Machine Scale Sets                                  |
|                   | 21. Unattached disks should be encrypted                                                               |
|                   | 22. Network interfaces should not have public IPs                                                      |
|                   | 23. Virtual machines should be connected to an approved virtual network                                |
|                   | 24. Virtual networks should use specified virtual network gateway                                      |
