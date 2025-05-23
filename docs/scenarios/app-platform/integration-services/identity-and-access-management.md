---
title: Identity and access management considerations for the Azure Integration Services landing zone accelerator
description: Learn about design considerations and recommendations for identity and access management in the Azure Integration Services landing zone accelerator.
author: claytonsiemens77
ms.author: csiemens
ms.date: 03/15/2023
ms.topic: conceptual
---

# Identity and access management considerations for the Azure Integration Services landing zone accelerator

This article builds on the guidance provided in the Azure landing zone article [Azure landing zone design area for identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). The guidance provided in the following article will help you to identify design considerations and recommendations that relate to identity and access management specific to the deployment of Azure Integration Services (AIS). If AIS is deployed to support mission-critical platforms, the guidance on the Azure landing zone design areas should also be included in your design.

## Identity and access management (IAM) overview

For the purposes of this article, Identity and Access Management (IAM) refers to the authentication and authorization options available for deploying or maintaining resources within Azure. In practice, this involves identifying which identities have permission to create, update, delete and manage resources either via the Azure portal, or via the Resource Manager API.

IAM is a separate consideration from  endpoint security, which defines which identities can call into and access your services. Endpoint security is covered in the separate [Security](./security.md) article in this series.  That being said, sometimes the two design areas overlap: for some services in Azure, access to the endpoint is configured via the same RBAC controls used to manage access to the resources.

## Design considerations

- Determine the Azure resource administration boundaries for the resources you deploy, considering separation of duties and operational efficiency.

- Review the Azure administration and management activities you require your teams to perform. Consider the AIS resources you'll deploy and how you'll use them. Determine the best possible distribution of responsibilities within your organization.

## Design recommendations

- Use managed identities for integration services resources - see the [Security](./security.md) article in this series for a detailed description of this recommendation.

- Use Microsoft Entra ID for authentication to integration services resources.

- Consider the level of access needed by roles within your organization and apply the principle of least privilege by role. These roles can include platform owners, workload owners, devops engineers and system administrators, for example.

- Using the principle of least privilege, consider what roles you'll need to manage and maintain your AIS applications.  Questions to ask in this regard:

  - Who will need to view log files from sources like Application Insights, Log Analytics, and Storage Accounts?

  - Does anyone need to view original request data (including sensitive data)?

  - Where can original request data be viewed from (for example, only from your corporate network)?

  - Who can view run history for a workflow?

  - Who can resubmit a failed run?

  - Who needs access to API Management subscription keys?

  - Who can view contents of a Service Bus Topic or Subscription, or see queue/topic metrics?

  - Who needs to be able to administer Key Vault?

  - Who needs to be able to add, edit, or delete keys, secrets and certificates in Key Vault?

  - Who needs to be able to view and read keys, secrets or certificates in Key Vault?

  - Will the existing built-in Microsoft Entra roles and groups cover the requirements that you have identified?

- Create custom roles to either limit access, or to provide more granularity over permissions when built-in roles will not sufficiently lock down access. For example, access to the callback URL for a Logic App requires a single permission, but there is no built-in role for that type of access other than “Contributor” or “Owner”, which are too broad.
  
- Look at using Azure Policy to restrict access to certain resources or to enforce compliance with company policy. For example, you can create a policy that only allows deployment of API Management APIs that use encrypted protocols.

- Review common activities involved in the administration and management of AIS on Azure and assign RBAC permissions appropriately.For more detail on the permissions available, see [resource provider operations](/azure/role-based-access-control/resource-provider-operations).

Some examples of common Azure administration activities include:

| Azure Resource           | Azure Resource Provider             | Activities                                                                                                                                                         |
|--------------------------|-------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| App Service Plan         | Microsoft.Web/serverfarms           | Read, Join, Restart, Get VNet Connections                                                                                                                          |
| API Connection           | Microsoft.Web/connections           | Update, Confirm                                                                                                                                                    |
| Logic Apps and Functions | Microsoft.Web/sites                 | Read, Start, Stop, Restart, Swap, Update Config, Read Diagnostics, Get VNet Connections                                                                            |
| Integration Account      | Microsoft.Logic/integrationAccounts | Read/Add/Update/Delete Assemblies, Read/Add/Update/Delete Maps, Read/Add/Update/Delete Schemas, Read/Add/Update/Delete Agreements, Read/Add/Update/Delete Partners |
| Service Bus              | Microsoft.ServiceBus                | Read, Get Connection String, Update DR Config, Read Queues, Read Topics, Read Subscriptions                                                                        |
| Storage Account          | Microsoft.Storage/storageAccounts   | Read, Change (for example workflow run history)                                                                                                                    |
| API Management           | Microsoft.ApiManagement             | Register/Delete a User, Read APIs, Manage Authorizations, Manage Cache                                                                                             |
| KeyVault                 | Microsoft.KeyVault/vaults           | Create a Vault, Edit Access Policies                                                                                                                               |

## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture. 

> [!div class="nextstepaction"]
> [Network topology and connectivity](./network-topology-and-connectivity.md)

## Recommended content

- [Microsoft Entra identity and access management operations reference guide](/entra/architecture/ops-guide-iam)

- [Azure identity and access management design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access)

- [Azure identity and access for landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones?source=recommendations)

- [Secure access and data in Azure Logic Apps](/azure/logic-apps/logic-apps-securing-a-logic-app?tabs=azure-portal)

- [Create custom roles in Azure](/azure/role-based-access-control/custom-roles)

- [Azure Policy Overview](/azure/governance/policy/overview)

- [Tutorial: Build Azure Policies to enforce compliance](/azure/governance/policy/tutorials/create-and-manage)
