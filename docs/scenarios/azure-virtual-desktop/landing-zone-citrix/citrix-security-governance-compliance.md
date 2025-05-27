---
title: Security governance and compliance for Citrix on Azure
description: Learn about key design considerations and recommendations for security governance and compliance in Citrix on Azure infrastructure.
author: BenMartinBaur
ms.author: bebaur
ms.date: 09/17/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Security governance and compliance for Citrix on Azure

Citrix DaaS deployments on Azure require proper security governance and compliance. To achieve operational excellence and success, design your Citrix DaaS environment with appropriate policies.

## Design considerations and recommendations

[Azure Policy](/azure/governance/policy/overview) is an important tool for Citrix on Azure deployments. Policies can help you adhere to security standards that your cloud platform team sets. To support continuous regulatory compliance, policies can automatically enforce regulations and provide reports.

Review your policy baseline with your platform team in accordance with the [Azure governance](../../../ready/landing-zone/design-area/governance.md) guidelines. Apply policy definitions at the top-level root management group so you can assign definitions at inherited scopes.

This article focuses on identity, networking, and antivirus recommendations.

- The [identity sections](#service-principal-roles-and-identity) describe Citrix DaaS service identity and its requirements.

- The [networking section](#networking) describes network security group (NSG) requirements.
- The [antivirus section](#antivirus) provides a link to best practices to configure antivirus protection in a DaaS environment.

## Service principal roles and identity

The following sections describe the creation, roles, and requirements of Citrix DaaS service principals.

### App registration

App registration is the process of creating a one-way trust relationship between a Citrix Cloud account and Azure so that Citrix Cloud trusts Azure. The app registration process creates an Azure service principal account that Citrix Cloud can use for all Azure actions through the hosting connection. The hosting connection that's set up in the Citrix Cloud console links Citrix Cloud through the cloud connectors to resource locations in Azure.

You must grant the service principal access to the resource groups that contain Citrix resources. Depending on your organization's security posture, you can either provide subscription access at the **Contributor** level or create a custom role for the service principal.
 
When you create the service principal in Microsoft Entra ID, set the following values:
 
- Add a **Redirect URI** and set it to **Web** with a value of `https://citrix.cloud.com`.

- For **API Permissions**, add the **Azure Services Management API** from the **APIs my organization uses** tab, and select the **user_impersonation** delegated permission.
- For **Certificates & secrets**, create a **New client secret** that has a recommended expiration period of one year. You must regularly update this secret as part of your security key rotation schedule.
 
You need both the **Application (client) ID** and the client secret **Value** from the app registration to configure the hosting connection setup within Citrix Cloud.
 
### Enterprise applications

Depending on your Citrix Cloud and Microsoft Entra configuration, you can add one or more **Citrix Cloud enterprise applications** to your Microsoft Entra tenant. These applications grant Citrix Cloud access to data that's stored in the Microsoft Entra tenant. The following table lists the application IDs and functions of Citrix Cloud enterprise applications in Microsoft Entra ID.

| Enterprise application ID | Purpose |
|:----|:----|
| f9c0e999-22e7-409f-bb5e-956986abdf02 | The default connection between Microsoft Entra ID and Citrix Cloud |
| 1b32f261-b20c-4399-8368-c8f0092b4470 | Administrator invitations and sign-ins |
| e95c4605-aeab-48d9-9c36-1a262ef8048e | The Workspace subscriber sign-in |
| 5c913119-2257-4316-9994-5e8f3832265b | The default connection between Microsoft Entra ID and Citrix Cloud with Citrix Endpoint Management |
| e067934c-b52d-4e92-b1ca-70700bd1124e | The legacy connection between Microsoft Entra ID and Citrix Cloud with Citrix Endpoint Management | 

Each enterprise application grants Citrix Cloud specific permissions to either the Microsoft Graph API or the Microsoft Entra API. For example, the Workspace subscriber sign-in application grants **User.Read** permissions to both APIs so that users can sign in and read their profiles. For more information, see [Microsoft Entra permissions for Citrix Cloud](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-management/identity-access-management/azure-ad-permissions.html).

### Built-in roles

After you create the service principal, grant it the Contributor role at the subscription level. To grant Contributor permissions at the subscription level, you need at least the Azure Role Based Access Control Administrator role. Azure prompts for the required permissions during the initial connection from Citrix Cloud to Microsoft Entra ID.

Any accounts that you use for authentication when you create the host connection must also be at least a Contributor on the subscription. This level of permissions allows Citrix Cloud to create necessary objects without restriction. Typically, you use this approach when the entire subscription only has Citrix resources.

Some environments don't allow service principals to have Contributor permissions at a subscription level. Citrix provides an alternative solution called a *narrow-scope service principal*. For a narrow-scope service principal, a Cloud Application Administrator completes an application registration manually, and then a subscription administrator manually grants the service principal account the appropriate permissions.

Narrow-scope service principals don't have Contributor permissions to the entire subscription. They only have permissions to the resource groups, networks, and images that they need to create and manage machine catalogs. Narrow-scope service principals require the following roles:

- Precreated resource groups require a **Virtual Machine Contributor**, **Storage Account Contributor**, and **Disk Snapshot Contributor**.

- Virtual networks require a **Virtual Machine Contributor**.
- Storage accounts require a **Virtual Machine Contributor**.
 
### Custom roles

Narrow-scope service principals have broad **Contributor** permissions, which might not suit security-sensitive environments. To provide a more granular approach, you can use two custom roles to provide the service principals with necessary permissions. The **Citrix_Hosting_Connection** role grants access to create a hosting connection, and the **Citrix_Machine_Catalog** role grants access to create Citrix workloads.

#### Citrix_Hosting_Connection role

The following JSON description of the **Citrix_Hosting_Connection** role has the minimum permissions that you need to create a hosting connection. If you use only snapshots or only disks for machine catalog golden images, you can remove the unused permission from the `actions` list.

```json
{
    "id": "",
    "properties": {
        "roleName": "Citrix_Hosting_Connection",
        "description": "Minimum permissions to create a hosting connection. Assign to resource groups that contain Citrix infrastructure such as cloud connectors, golden images, or virtual network resources.",
        "assignableScopes": [
            "/"
        ],
        "permissions": [
            {
                "actions": [
                    "Microsoft.Resources/subscriptions/resourceGroups/read",
                    "Microsoft.Compute/snapshots/read",
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

Assign the **Citrix_Hosting_Connection** custom role to the **Citrix_Infrastructure** resource groups that have cloud connector, golden image, or virtual network resources in them. You can copy and paste this JSON role description directly into your custom Microsoft Entra role definition.
 
#### Citrix_Machine_Catalog role

The following JSON description of the **Citrix_Machine_Catalog** role has the minimum permissions that you need for the Citrix Machine Catalog Wizard to create the required resources within Azure.
 
```json
{
    "id": "",
    "properties": {
    "roleName": "Citrix_Machine_Catalog",
    "description": "The minimum permissions to create a machine catalog. Assign to resource groups that contain Citrix workload servers that run the Virtual Delivery Agent.",
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

Assign the **Citrix_Machine_Catalog** custom role to the **Citrix_MachineCatalog** resource groups that hold the Citrix Virtual Delivery Agent (VDA) virtual machines (VMs). You can copy and paste this JSON role description directly into your custom Microsoft Entra role definition.

## Networking

The NSGs are stateful, so they allow return traffic that can apply to a VM, a subnet, or both. When both subnet and VM NSGs exist, the subnet NSGs apply first for inbound traffic, and the VM NSGs apply first for outbound traffic. By default, a virtual network allows all traffic between hosts and all inbound traffic from a load balancer. By default, a virtual network allows only outbound internet traffic and denies all other outbound traffic.
 
To limit potential attack vectors and increase deployment security, use NSGs to allow only the expected traffic in the Citrix Cloud environment. The following table lists the required networking ports and protocols that a Citrix deployment must allow. This list includes only the ports that the Citrix infrastructure uses and doesn't include the ports that your applications use. In the NSG that protects the VMs, be sure to define all ports.

| Source | Destination | Protocol | Port | Purpose |
|----|----|----|----|----|
| Cloud connectors | `*.digicert.com` | HTTP | 80 | Certificate revocation check |
| Cloud connectors | `*.digicert.com` | HTTPS | 443 | Certificate revocation check |
| Cloud connectors | `dl.cacerts.digicert.com/DigiCertAssuredIDRootCA.crt` | HTTPS | 443 | Certificate revocation check |
| Cloud connectors | `dl.cacerts.digicert.com/DigiCertSHA2AssuredIDCodeSigningCA.crt` | HTTPS | 443 | Certificate revocation check |
| Cloud connectors | Cloud connectors | Transmission Control Protocol (TCP) | 80 | Communication between controllers |
| Cloud connectors | Cloud connectors | TCP | 89 | Local host cache |
| Cloud connectors | Cloud connectors | TCP | 9095 | Orchestration service |
| Cloud connectors | VDA | TCP, User Datagram Protocol (UDP) | 1494 | ICA/HDX protocol <br><br> Enlightened Data Transport (EDT) requires UDP |
| Cloud connectors | VDA | TCP, UDP | 2598 | Session reliability <br><br> EDT requires UDP |
| Cloud connector | VDA | TCP | 80 (bidirect) | Application and performance discovery |
| VDA | Gateway service | TCP | 443 | Rendezvous Protocol |
| VDA | Gateway service | UDP | 443 | EDT and UDP over 443 to Gateway service |
| VDA | `*.nssvc.net` <br><br> `*.c.nssv.net` <br><br> `*.g.nssv.net` | TCP, UDP | 443 | Gateway service domains and subdomains |
| Citrix Provisioning Services | Cloud connectors | HTTPS | 443 | Citrix Cloud Studio integration |
| Citrix License Server | Citrix Cloud | HTTPS | 443 | Citrix Cloud Licensing integration |
| CVAD Remote PowerShell SDK | Citrix Cloud | HTTPS | 443 | Any system that runs remote PowerShell scripts via the SDK |
| Workspace Environment Management (WEM) agent | WEM service | HTTPS | 443 | Agent to service communication |
| WEM agent | Cloud connectors | TCP | 443 | Registration traffic |

For information about network and port requirements for Citrix Application Delivery Management, see [System requirements](https://docs.citrix.com/en-us/citrix-application-delivery-management-service/system-requirements.html#ports).

## Antivirus

Antivirus software is a crucial element for user environment protection. To ensure a smooth operation, configure antivirus appropriately in a Citrix DaaS environment. Incorrect antivirus configuration can result in performance problems, degraded customer experiences, or timeouts and failures of various components. For more information about how to configure antivirus in your Citrix DaaS environment, see [Endpoint security, antivirus, and antimalware best practices](https://community.citrix.com/tech-zone/build/tech-papers/antivirus-best-practices#_=_).

## Next step

Review the critical design considerations and recommendations for business continuity and disaster recovery that's specific to the deployment of Citrix on Azure.

- [Business continuity and disaster recovery](citrix-business-continuity-disaster-recovery.md)
