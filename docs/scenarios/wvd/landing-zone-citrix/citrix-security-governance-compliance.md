---
title: Security governance and compliance for Citrix on Azure
description: Learn about key design considerations and recommendations for security governance and compliance in Citrix on Azure infrastructure.
author: BenMartinBaur
ms.author: nataliak
ms.date: 02/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Security governance and compliance for Citrix on Azure

Security governance and compliance are critical to Citrix DaaS deployments on Azure. To achieve operational excellence and success, design your Citrix DaaS environment with appropriate policies.

## Design considerations and recommendations

[Azure Policy](/azure/governance/policy/overview) is an important tool for Citrix on Azure deployments. Policies can help you adhere to security standards set by your cloud platform team. Policies provide automatic enforcement and reporting to support continuous regulatory compliance.

Review your policy baseline with your platform team per the [Design area: Azure governance](../../../ready/landing-zone/design-area/governance.md#plan-for-governance) guidelines. Apply policy definitions at the top-level root management group so you can assign them at inherited scopes.

The following sections focus on identity, networking, and antivirus recommendations.

- The identity sections discuss Citrix DaaS service identity and its requirements.
- The networking section drills into network security group (NSG) requirements.
- The antivirus section provides a link to best practices for configuring antivirus protection in a DaaS environment.

## Service principal roles and identity

The following sections discuss Citrix DaaS service principal creation, roles, and requirements.

### App registration

App registration is the process of creating a one-way trust relationship between a Citrix Cloud account and Azure, such that the Citrix Cloud trusts Azure. The app registration process creates an Azure service principal account that the Citrix Cloud can use for all Azure actions through the hosting connection. The hosting connection set up in the Citrix Cloud console links the Citrix Cloud through the Cloud Connectors to resource locations in Azure.

You must grant the service principal access to the resource groups that contain Citrix resources. Depending on your organization's security posture, you can either provide subscription access at the **Contributor** level, or create a custom role for the service principal.
 
When you create the service principal in Azure Active Directory (Azure AD), set the following values:
 
- Add a **Redirect URI** and set it to **Web** with a value of `https://citrix.cloud.com`.
- For **API Permissions**, add the **Azure Services Management API** from the **APIs my organization uses** tab, and select the **user_impersonation** delegated permission.
- For **Certificates & secrets**, create a **New client secret** with a recommended expiration period of one year. You must keep this secret updated as part of your security key rotation schedule.
 
You need both the **Application (client) ID** and the client secret **Value** from App Registration to configure the hosting connection setup within the Citrix Cloud.
 
### Enterprise Applications

Depending on your Citrix Cloud and Azure AD configuration, you can add one or more **Citrix Cloud Enterprise Applications** to your Azure AD tenant. These applications allow Citrix Cloud to access data stored in the Azure AD tenant. The following table lists the Application IDs and functions of the Citrix Cloud Enterprise Applications in Azure AD.

| Enterprise Application ID | Purpose |
|:----|:----|
| f9c0e999-22e7-409f-bb5e-956986abdf02 | Default connection between Azure AD and Citrix Cloud |
| 1b32f261-b20c-4399-8368-c8f0092b4470 | Administrator invitations and sign-ins |
| e95c4605-aeab-48d9-9c36-1a262ef8048e | Workspace subscriber sign-in |
| 5c913119-2257-4316-9994-5e8f3832265b | Default connection between Azure AD and Citrix Cloud with Citrix Endpoint Management |
| e067934c-b52d-4e92-b1ca-70700bd1124e | Legacy connection between Azure AD and Citrix Cloud with Citrix Endpoint Management | 

Each Enterprise Application grants Citrix Cloud specific permissions to either the Microsoft Graph API or the Azure AD API. For example, the Workspace subscriber sign-in application grants **User.Read** permissions to both APIs, so that users can sign in and read their profiles. For more information about the permissions granted, see [Azure Active Directory Permissions for Citrix Cloud](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-management/identity-access-management/azure-ad-permissions.html). 

### Built-in roles

The **Contributor** built-in role contains the broadest permission set, and works well to assign to service principal accounts at the subscription level. Granting contributor permissions at the subscription level requires an Azure AD global administrator account. Once granted, Azure prompts for the required permissions during the initial connection from Citrix Cloud to Azure AD.

Any accounts used for authentication during host connection creation must also be at least co-administrators on the subscription. This level of permissions allows Citrix Cloud to create necessary objects without restriction. Typically, you use this approach when the entire subscription is dedicated to Citrix resources.
 
Some environments don't allow service principals to have **Contributor** permissions at a subscription level. Citrix provides an alternative solution called a *narrow-scope service principal*. For a narrow-scope service principal, an Azure AD global administrator completes an application registration manually, and then a subscription administrator manually grants the service principal account the appropriate permissions.

Narrow-scoped service principals don't have **Contributor** permissions to the entire subscription, just to the resource groups, networks, and images required to create and manage machine catalogs. Narrow-scoped service principals require the following **Contributor** permissions:

- Pre-created resource groups: **Virtual Machine Contributor**, **Storage Account Contributor**, and **Disk Snapshot Contributor**
- Virtual networks: **Virtual Machine Contributor**
- Storage accounts: **Virtual Machine Contributor**
 
### Custom roles

Narrow-scope service principals, while limited in scope, are still granted broad **Contributor** permissions, which might still be unacceptable in security-sensitive environments. To provide a more granular approach, you can use two custom roles to provide the service principals with necessary permissions. The **Citrix_Hosting_Connection** role grants access to create a hosting connection, and the **Citrix_Machine_Catalog** role grants access to create Citrix workloads.

#### Citrix_Hosting_Connection role

The following JSON description of the **Citrix_Hosting_Connection** role has the minimum permissions needed to create a hosting connection. If you use only snapshots or only disks for machine catalog master images, you can remove the unused permission from the `actions` list.

```json
{
    "id": "",
    "properties": {
        "roleName": "Citrix_Hosting_Connection",
        "description": "Minimum permissions to create a hosting connection. Assign to resource groups that contain Citrix infrastructure such as Cloud Connectors, master images, or virtual network resources.",
        "assignableScopes": [
            "/"
        ],
        "permissions": [
            {
                "actions": [
                    "Microsoft.Resources/subscriptions/resourceGroups/read",
                    "Microsoft.Compute/snapshots/read"
                    "Microsoft.Compute/disks/read",
                    "Microsoft.Network/virtualNetworks/read",
                    "Microsoft.Network/virtualNetworks/subnets/join/action"
                ],
                "notActions": [],
                "dataActions": [],
                "notDataActions": []
            }
        ]
    }
}
```

The **Citrix_Hosting_Connection** custom role should be assigned to the **Citrix_Infrastructure** resource groups that have Cloud Connector, master image, or virtual network resources in them. You can copy and paste this JSON role description directly into your custom Azure AD role definition.
 
#### Citrix_Machine_Catalog role

The following JSON description of the **Citrix_Machine_Catalog** role has the minimum permissions needed for the Citrix Machine Catalog Wizard to create the required resources within Azure.
 
```json
{
    "id": "",
    "properties": {
    "roleName": "Citrix_Machine_Catalog",
    "description": "Minimum permissions to create a machine catalog. Assign to resource groups that contain Citrix workload servers that are running the Virtual Delivery Agent.",
    "assignableScopes": [
    "/"
    ],
        "permissions": [
            {
                "actions": [
                    "Microsoft.Resources/subscriptions/resourceGroups/read",
                    "Microsoft.Storage/storageAccounts/listkeys/action",
                    "Microsoft.Storage/storageAccounts/read",
                    "Microsoft.Storage/storageAccounts/write",
                    "Microsoft.Network/networkSecurityGroups/write",
                    "Microsoft.Compute/virtualMachines/write",
                    "Microsoft.Compute/virtualMachines/start/action",
                    "Microsoft.Compute/virtualMachines/restart/action",
                    "Microsoft.Compute/virtualMachines/read",
                    "Microsoft.Compute/virtualMachines/powerOff/action",
                    "Microsoft.Compute/virtualMachines/performMaintenance/action",
                    "Microsoft.Compute/virtualMachines/deallocate/action",
                    "Microsoft.Compute/virtualMachines/delete",
                    "Microsoft.Compute/virtualMachines/convertToManagedDisks/action",
                    "Microsoft.Compute/virtualMachines/capture/action",
                    "Microsoft.Compute/snapshots/endGetAccess/action",
                    "Microsoft.Compute/snapshots/beginGetAccess/action",
                    "Microsoft.Compute/snapshots/delete",
                    "Microsoft.Compute/snapshots/write",
                    "Microsoft.Compute/snapshots/read",
                    "Microsoft.Compute/disks/endGetAccess/action",
                    "Microsoft.Compute/disks/delete",
                    "Microsoft.Compute/disks/beginGetAccess/action",
                    "Microsoft.Compute/disks/write",
                    "Microsoft.Network/networkSecurityGroups/read",
                    "Microsoft.Network/networkInterfaces/delete",
                    "Microsoft.Network/networkInterfaces/join/action",
                    "Microsoft.Network/networkInterfaces/write",
                    "Microsoft.Network/networkInterfaces/read",
                    "Microsoft.Storage/storageAccounts/listServiceSas/action",
                    "Microsoft.Storage/storageAccounts/listAccountSas/action",
                    "Microsoft.Storage/storageAccounts/delete",
                    "Microsoft.Compute/disks/read",
                    "Microsoft.Resources/subscriptions/resourceGroups/delete",
                    "Microsoft.Resources/subscriptions/resourceGroups/write",
                    "Microsoft.Network/virtualNetworks/subnets/join/action",
                    "Microsoft.Network/virtualNetworks/subnets/read",
                    "Microsoft.Network/virtualNetworks/read",
                    "Microsoft.Network/networkSecurityGroups/join/action"
                ],
                "notActions": [],
                "dataActions": [],
                "notDataActions": []
            }
        ]
    }
}
```

Assign the **Citrix_Machine_Catalog** custom role to the **Citrix_MachineCatalog** resource groups that hold the Citrix Virtual Delivery Agent (VDA) virtual machines (VMs). You can copy and paste this JSON role description directly into your custom Azure AD role definition.

## Networking

The NSGs are stateful, so they allow return traffic that can apply to a VM, a subnet, or both. When both subnet and VM NSGs exist, the subnet NSGs apply first for inbound traffic, and the VM NSGs apply first for outbound traffic. By default, all traffic between hosts is allowed within a virtual network, along with all inbound traffic from a load balancer. By default, only outbound internet traffic is allowed, and all other outbound traffic is denied.
 
By using NSGs to allow only expected traffic in the Citrix Cloud environment, you can limit potential attack vectors and significantly increase deployment security. The following table lists the required networking ports and protocols that a Citrix deployment must allow. This list includes only the ports the Citrix infrastructure uses, and doesn't include the ports your applications use. Be sure to define all ports in the NSG that protects the VMs.

| Source | Destination | Protocol | Port | Purpose |
|----|----|----|----|----|
| Cloud Connectors | \*.digicert.com | HTTP | 80 | Certificate Revocation Check |
| Cloud Connectors | \*.digicert.com | HTTPS | 443 | Certificate Revocation Check |
| Cloud Connectors | dl.cacerts.digicert.com/DigiCertAssuredIDRootCA.crt | HTTPS | 443 | Certificate Revocation Check |
| Cloud Connectors | dl.cacerts.digicert.com/DigiCertSHA2AssuredIDCodeSigningCA.crt | HTTPS | 443 | Certificate Revocation Check |
| Cloud Connectors | Cloud Connectors | TCP | 80 | Communication between controllers |
| Cloud Connectors | Cloud Connectors | TCP | 89 | Local host cache |
| Cloud Connectors | Cloud Connectors | TCP | 9095 | Orchestration service |
| Cloud Connectors | VDA | TCP UDP | 1494 | ICA/HDX protocol <br> EDT requires UDP |
| Cloud Connectors | VDA | TCP UDP | 2598 | Session reliability <br> EDT requires UDP |
| Cloud Connector | VDA | TCP | 80 (bidirect) | Application and performance discovery |
| VDA | Gateway Service | TCP | 443 | Rendezvous Protocol |
| VDA | Gateway Service | UDP | 443 | EDT UDP over 443 to Gateway Service |
| VDA | \*.nssvc.net <br> \*.c.nssv.net <br> \*.g.nssv.net | TCP UDP | 443 | Gateway service domains and subdomains |
| Citrix Provisioning Services | Cloud Connectors | HTTPS | 443 | Citrix Cloud Studio integration |
| Citrix License Server | Citrix Cloud | HTTPS | 443 | Citrix Cloud Licensing integration |
| CVAD Remote PowerShell SDK | Citrix Cloud | HTTPS | 443 | Any system running remote PowerShell scripts via the SDK |
| WEM Agent | WEM Service | HTTPS | 443 | Agent to service communication |
| WEM Agent | Cloud Connectors | TCP | 443 | Registration traffic |

If you use Citrix Application Delivery Management (ADM), see [System Requirements](https://docs.citrix.com/en-us/citrix-application-delivery-management-service/system-requirements.html#ports) for network and port requirements.

## Antivirus

Antivirus software is a crucial element for end user environment protection. Configuring antivirus appropriately in a Citrix DaaS environment is key to a smooth operation. Incorrect antivirus configuration can result in performance issues, degraded user experiences, or timeouts and failures of various components. For more information about how to configure antivirus in your Citrix DaaS environment, see [Tech Paper: Endpoint Security, Antivirus, and Antimalware Best Practices](https://docs.citrix.com/en-us/tech-zone/build/tech-papers/antivirus-best-practices.html).

## Next step

Review the critical design considerations and recommendations for business continuity and disaster recovery (BCDR) specific to the deployment of Citrix on Azure.

- [Business continuity and disaster recovery](citrix-business-continuity-disaster-recovery.md)
