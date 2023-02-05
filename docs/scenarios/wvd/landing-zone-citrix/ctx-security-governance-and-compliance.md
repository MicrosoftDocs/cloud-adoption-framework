---
title: Security, governance, and compliance for Citrix on Azure infrastructure
description: Learn key design considerations and recommendations for security and governance in Citrix on Azure.
author: bebaur
ms.author: nataliak
ms.date: 01/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Citrix: Governance considerations for Citrix on Azure

Governance is critical to any customer deploying Citrix DaaS on Azure. To achieve operational excellence and success you should properly design your Citrix DaaS environment with appropriate policies in mind.

**Citrix design considerations**

[Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview) is a critical tool for every Citrix on Azure deployment. They can help with adhering to security standards set by you cloud platform team or ensure continuous compliance to regulations with automatic enforcement and reporting. Review your policy baseline with your platform team as, per [Microsoft guidance](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/security-governance-and-compliance#plan-for-governance), definitions may be applied at the top-level root management group so that they can be assigned at inherited scopes. In the sections below, we will focus on recommendations around identity, networking, and antivirus. In the identity section we discuss the Citrix DaaS service identity and its requirements. In the networking section we drill into the NSG requirements. Last but not least, we will provide few pointers on best practises around configuring antivirus in a DaaS environment.

**Citrix design recommendations**

**App Registrations**
An App Registration is the process of creating a one-way trust relationship between your Citrix Cloud account and Azure, such that Citrix Cloud trusts Azure. During the process, an Azure Service Principal account is created to be used by Citrix Cloud for all Azure actions through the hosting connection. The hosting connection is setup in the Citrix Cloud console, and it links Citrix Cloud through the Cloud Connectors to a resource location in Azure. 
 
The service principal will need to be granted access to the resource groups that contain Citrix resources. Depending on the security posture of your company, you can either provide access at the contributor-level to the subscription or create a custom role for the service principal. 
 
When creating the service principal, you will need to set the following values:
 
- Redirect URL should be enabled and set to Web with a value of https://citrix.cloud.com. 
- API Permissions should have the Delegated Permission of user_impersonation selected in the Windows Azure Services Management API found under the APIs my organization uses tab. 
- Certifications & secrets will need a new Client Secret created and the recommended expiration period is one year. Keep in mind this will need to be updated as part of your security key rotation schedule.
 
You will need both the Application (client) ID and the Client SecretKey value from the App Registration to configure the hosting connection setup within Citrix Cloud. 
 
**Enterprise Applications**
	
Depending on how your Citrix Cloud and Azure AD are configured, one or more Enterprise Applications may be created in your Azure AD tenant. These accounts allow Citrix Cloud to access data stored in your Azure AD tenant. Table 3 Citrix Cloud Enterprise Applications in Azure AD lists the Application IDs and their purpose. 

| Enterprise Applications ID | Purpose |
|:----|:----|
| f9c0e999-22e7-409f-bb5e-956986abdf02 | Default connection between Azure AD and Citrix Cloud |
| 1b32f261-b20c-4399-8368-c8f0092b4470 | Administrator invitations and logins |
| e95c4605-aeab-48d9-9c36-1a262ef8048e | Workspace subscriber login |
| 5c913119-2257-4316-9994-5e8f3832265b | Default connection between Azure AD and Citrix Cloud with Citrix Endpoint Management |
| e067934c-b52d-4e92-b1ca-70700bd1124e | Legacy connection between Azure AD and Citrix Cloud with Citrix Endpoint Management | 

Each Enterprise application grants Citrix Cloud specific permissions to either the Microsoft Graph or the Windows Azure Active Directory API. For instance, the Workspace subscriber login grants User.Read permissions to both APIs so that users can sign-in and read their profile. More information about the permissions granted can be found [here](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-management/identity-access-management/azure-ad-permissions.html). 

**Using Built-in Roles**
	
The contributor built-in role contains the broadest permission set and will work well when assigned to service principal accounts at the subscription level. Granting contributor permissions at the subscription level requires an Azure AD global administrator account. Once granted, Azure will prompt for the required permissions during the initial connection from Citrix Cloud to Azure AD. Any accounts used for authentication during the host-connection creation must also be at least co-administrators on the subscription. This level of permissions will allow Citrix Cloud to create any objects necessary without restriction. Typically, this approach is used when the entire subscription is dedicated to Citrix resources.
 
Some environments do not allow service principals to have contributor permissions at a subscription level, so Citrix has provided an alternative solution referred to as a Narrow Scope service principal. With a narrow scope service principal, an application registration is completed manually by an Azure AD global administrator and then a subscription administrator manually grants the service principal account the appropriate permissions. Narrow-scoped service principals do not have contributor permissions on the entire subscription, but rather their contributor permissions are scoped to just the resource groups, networks, and images that are required to create and manage the Machine Catalogs. The narrow-scoped service principal requires the following contributor permissions.
- Pre-Created Resource Group: Virtual machine contributor, Storage account contributor, and Disk snapshot contributor
- Virtual Network: Virtual machine contributor
- Storage Account: Virtual machine contributor
 
**Using Custom Roles**
	
Narrow Scope service principals, while limited in scope still are granting the broad Contributor permissions, which may still be unacceptable to security-sensitive environments. To provide a more granular approach, two custom roles can be used to provide the necessary permissions to the service principal. The Citrix Host Role grants access for the Host Connection to be created, while the Citrix Machine Catalog Role grants access to create the Citrix workloads. 
 
**Citrix Host Role**
	
Here is the JSON description of the Citrix Host Role with the minimum permissions needed for the Hosting Connection Role; If only Snapshots or Disks will be used for the Machine Catalog creation master image, then the unused one can be removed from the “actions” list.
	
*Example Citrix Host Role (JSON)*
	
```	
{
    "id": "",
    "properties": {
        "roleName": "Citrix_Hosting_Connection",
        "description": "Minimum permissions creating a hosting connection. Assign to resource groups that contain Citrix Infrastructure such as Cloud Connectors, Master images, or Virtual Network resources",
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
	
The Citrix_Hosting_Connection custom role should be assigned to the Citrix_Infrastructure resource group(s) that have the Cloud Connector, Master Image or Virtual Network resources in them. This JSON role can be copied and pasted directly into your custom Azure AD role.
 
**Citrix Machine Catalog Role**
	
Here is the JSON description of the Citrix Machine Catalog Role with the minimum permissions needed for the Citrix Machine Catalog Wizard to create the required resources within Azure:
 
*Example Citrix Machine Catalog Role (JSON)*

```	
{
    "id": "",
    "properties": {
	"roleName": "Citrix_Machine_Catalog",
	"description": "Minimum permissions to create a machine catalog. Assign to resource groups that contain Citrix workload servers that are running the Virtual Delivery agent.",
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

The Citrix_Machine_Catalog custom role should be assigned to the Citrix_MachineCatalog resource group(s) that will hold the Citrix VDA virtual machines. This JSON role can be copied and pasted directly into your custom Azure AD role.

**Networking**

The NSGs are stateful so return traffic is allowed and can be applied to a VM, a subnet, or both. When both subnet and VM NSGs exist, the subnet ones are applied first for inbound traffic and the VM NSGs are applied first for outbound traffic. By default, all traffic within a VNET is allowed between hosts along with all inbound traffic from a load balancer. By default, only outbound internet traffic is allowed, and all other outbound traffic is denied. 
 
By using NSGs to limit the traffic in the Citrix Cloud environment to only expected traffic, you can limit the potential attack vectors and significantly increase security for the deployment. Table 1 Citrix Cloud Required Ports and Protocols lists out the networking ports and protocols that must be allowed for your Citrix deployment. These are only the ports used for the Citrix infrastructure and do not include the ports used by your applications. Be sure to define all ports in the NSG protecting the virtual machines as described. 

*Citrix Cloud Required Ports and Protocols*

| Source | Destination | Protocol | Port | Purpose |
|----|----|----|----|----|
| Cloud Connectors | *.digicert.com | HTTP | 80 | Certificate Revocation Check |
| Cloud Connectors | *.digicert.com | HTTPS | 443 | Certificate Revocation Check |
| Cloud Connectors | dl.cacerts.digicert.com/DigiCertAssuredIDRootCA.crt | HTTPS | 443 | Certificate Revocation Check |
| Cloud Connectors | dl.cacerts.digicert.com/DigiCertSHA2AssuredIDCodeSigningCA.crt | HTTPS | 443 | Certificate Revocation Check |
| Cloud Connectors | Cloud Connectors | TCP | 80 | Communication between controllers |
| Cloud Connectors | Cloud Connectors | TCP | 89 | Local host cache |
| Cloud Connectors | Cloud Connectors | TCP | 9095 | Orchestration Service |
| Cloud Connectors | Virtual Delivery Agent | TCP UDP | 1494 | ICA/HDX protocol <br> EDT requires UDP |
| Cloud Connectors | Virtual Delivery Agent | TCP UDP | 2598 | Session Reliability <br> EDT requires UDP |
| Cloud Connector | Virtual Delivery Agent | TCP | 80 (bidirect) | Application and performance discovery |
| Virtual Delivery Agent | Gateway Service | TCP | 443 | Rendezvous Protocol |
| Virtual Delivery Agent | Gateway Service | UDP | 443 | EDT UDP over 443 to Gateway Service |
| Virtual Delivery Agent | *.nssvc.net <br> *.c.nssv.net <br> *.g.nssv.net | TCP UDP | 443 | Gateway service domains and subdomains |
| Citrix Provisioning Services | Cloud Connectors | HTTPS | 443 | Citrix Cloud Studio integration |
| Citrix License Server | Citrix Cloud | HTTPS | 443 | Citrix Cloud Licensing integration |
| CVAD Remote Powershell SDK | Citrix Cloud | HTTPS | 443 | Any system running remote PowerShell scripts via the SDK |
| WEM Agent | WEM Service | HTTPS | 443 | Agent to service communication |
| WEM Agent | Cloud Connectors | TCP | 443 | Registration traffic |

If using ADM, please check the following for network and [port requirements](https://docs.citrix.com/en-us/citrix-application-delivery-management-service/system-requirements.html#ports):

**Antivirus**

Antivirus software is a crucial element for the protection of any end-user environment. Configuring that appropriately in a Citrix DaaS environment is key to a smooth operation.
Incorrect antivirus configuration can result in various issues, ranging from performance issues or degraded user experiences to timeouts and failures of various components.
Please follow the link for the best practices on configuring [antivirus in your Citrix DaaS environment](https://docs.citrix.com/en-us/tech-zone/build/tech-papers/antivirus-best-practices.html).



## Next steps

Review the critical design considerations and recommendations for business continuity and disaster recovery specific to the deployment of Citrix on Azure.

- [Business continuity and disaster recovery](./ctx-business-continuity-and-disaster-recovery.md)
