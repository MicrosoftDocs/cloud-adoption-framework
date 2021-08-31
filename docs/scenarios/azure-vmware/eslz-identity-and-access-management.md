---
title: Enterprise-scale identity and access management for Azure VMware Solution
description: This article examines the design considerations and recommendations related to identity and access management specific to Azure VMware Solution (AVS).
author: E-G-C
ms.author: janet
ms.date: 08/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for Azure VMware Solution enterprise-scale scenario

This article builds on several considerations and recommendations defined in the
Azure landing zone article [enterprise-scale design area for identity and access
management](/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management) and [Azure VMware Solution identity concepts](/azure/azure-vmware/concepts-identity).
This article will help examine design considerations and recommendations related to 
identity and access management specific to the deployment of Azure VMware Solution (AVS).

We understand that identity requirements for AVS vary according to the AVS
implementation in Azure; therefore, we will work based on the most common scenarios.

## Design considerations

After successfully planning and deploying AVS, the new environment's vCenter contains 
a built-in local user called cloudadmin, assigned to the CloudAdmin role with several
permissions in vCenter. Alternatively, you can create custom roles in your AVS environment
using the principle of least privilege.

## Design recommendations

-   As part of the Identity and Access Management Enterprise Scale Landing Zone
    (ESLZ), an Active Directory Domain Services Domain Controller is deployed in
    the Identity Subscription

-   Limit the number of users that you assign CloudAdmin role. Use custom roles
    and least privilege to assign users to AVS.

-   Use caution when rotating cloudadmin/NSX admin passwords. Ensure HCX
    Connector passwords are updated with password changes to avoid lockouts.
    [Rotate the cloudadmin credentials for Azure VMware Solution - Azure VMware
    Solution \| Microsoft
    Docs](/azure/azure-vmware/rotate-cloudadmin-credentials)

-   Limit AVS RBAC permissions in Azure to the Resource Group where it is
    deployed, as well as the users who need to manage AVS.

-   vSphere Permissions with Custom Roles should only be configured at the
    hierarchy level if needed. It is better to apply permissions at the
    [appropriate VM
    Folder](/azure/azure-vmware/concepts-identity)
    or Resource Pool. Application of vSphere Permissions at or above the
    Datacenter level should be avoided.

-   Active Directory Sites and Services should be updated to direct Azure and
    AVS AD DS traffic to the appropriate Domain Controllers.

-   Use Run Command to:

    -   Add Active Directory Domain Services (Domain Controller) as an identity
        source for vCenter and NSX-T.

    -   To provide lifecycle operation on the vsphere.local\\CloudAdmins group.

-   Create groups in Active Directory and use RBAC to manage vCenter and NSX-T.
    You can create [custom
    roles](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.security.doc/GUID-41E5E52E-A95B-4E81-9724-6AD6800BEF78.html)
    and
    [assign](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.security.doc/GUID-18071E9A-EED1-4968-8D51-E0B4F526FDA3.html)
    Active Directory groups to the custom roles.

