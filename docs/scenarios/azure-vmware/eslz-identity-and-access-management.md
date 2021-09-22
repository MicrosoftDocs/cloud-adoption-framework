---
title: Enterprise-scale identity and access management for Azure VMware Solution
description: This article examines the design considerations and recommendations related to identity and access management specific to Azure VMware Solution.
author: E-G-C
ms.author: janet
ms.date: 09/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise-scale identity and access management for Azure VMware Solution

This article builds on considerations and recommendations defined in [Enterprise-scale design area for identity and access management](/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management) and [Azure VMware Solution identity concepts](./concepts-identity.md). This article helps examine design considerations and recommendations related to identity and access management specific to the deployment of Azure VMware Solution.

Identity requirements for Azure VMware Solution vary according to the Azure VMware Solution implementation in Azure. For this reason, this guidance reviews the most common scenarios.

## Design considerations

After successfully planning and deploying Azure VMware Solution, the new environment's vCenter contains a built-in local user called cloudadmin. This local user is assigned to the CloudAdmin role with several permissions in vCenter. As an alternative, you can create custom roles in your Azure VMware Solution environment using the principle of least privilege.

## Design recommendations

- As part of the Identity and Access Management enterprise-scale landing zone, you deploy an Active Directory Domain Services Domain Controller in the identity Subscription.

- Use of the cloudadmin account for connected services isn't recommended.

- When rotating the cloudadmin password, all services using this account should be shut down before credential rotation.

- Limit the number of users that you assign CloudAdmin role. Use custom roles and least privilege to assign users to Azure VMware Solution.

- Use caution when rotating cloudadmin. Ensure HCX Connector passwords are updated with password changes to avoid lockouts. For more information, see, [Rotate the cloudadmin credentials for Azure VMware Solution - Azure VMware](./rotate-cloudadmin-credentials.md)

- Limit Azure VMware Solution role-based access control (RBAC) permissions in Azure to the Resource Group where it's deployed, and the users who need to manage Azure VMware Solution.

- vSphere Permissions with Custom Roles should only be configured at the hierarchy level if needed. It's better to apply permissions at the [appropriate VM Folder](./concepts-identity.md) or Resource Pool. Application of vSphere   permissions at or above the Datacenter level should be avoided.

- Active Directory Sites and Services should be updated to direct Azure and Azure VMware Solution AD DS traffic to the appropriate Domain Controllers.

- Use the [Run Command](./configure-identity-source-vcenter.md) to:

  - Add Active Directory Domain Services (Domain Controller) as an identity source for vCenter and NSX-T.

  - Provide lifecycle operation on the vsphere.local\\CloudAdmins group.

  - Create groups in Active Directory and use Azure RBAC to manage vCenter and NSX-T. You can create custom roles and assign Active Directory groups to the custom roles. To learn more, see:
    - [Create a Custom Role](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.security.doc/GUID-41E5E52E-A95B-4E81-9724-6AD6800BEF78.html)
    - [Using Roles to Assign Privileges](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.security.doc/GUID-18071E9A-EED1-4968-8D51-E0B4F526FDA3.html)

## Next steps

> [!div class="nextstepaction"]
> [Enterprise-scale network topology and connectivity for Azure VMware Solution](./eslz-network-topology-connectivity.md)
