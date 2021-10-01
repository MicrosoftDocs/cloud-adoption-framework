---
title: Enterprise-scale identity and access management - Azure VMware Solution
description: This article examines the design considerations and recommendations related to identity and access management specific to Azure VMware Solution.
author: E-G-C
ms.author: janet
ms.date: 09/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank
---

# Enterprise-scale identity and access management for Azure VMware Solution

This article builds on the information found in [Identity and access management](/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management) and [Azure VMware Solution identity concepts](/azure/azure-vmware/concepts-identity).

Use this information to examine design considerations and recommendations for identity and access management that's specific to the deployment of Azure VMware Solution.

Identity requirements for Azure VMware Solution vary according to its implementation in Azure. The information provided in this article is based on the most common scenarios.

## Design considerations

After you deploy Azure VMware Solution, the new environment's vCenter contains a built-in local user called `cloudadmin`. This user is assigned to the CloudAdmin role with several permissions in vCenter. You can also create custom roles in your Azure VMware Solution environment using the principle of least privilege.

## Design recommendations

- As part of the identity and access management enterprise-scale landing zone, deploy an Active Directory Domain Services (AD DS) domain controller in the identity subscription.

- Limit the number of users that you assign the CloudAdmin role. Use custom roles and least privilege to assign users to Azure VMware Solution.

- Use caution when [rotating cloudadmin and NSX admin passwords](/azure/azure-vmware/rotate-cloudadmin-credentials). Ensure HCX Connector passwords are updated with password changes to avoid lockouts.

- Limit Azure VMware Solution role-based access control (RBAC) permissions in Azure to the resource group where it's deployed, and the users who need to manage Azure VMware Solution.

- Only configure vSphere permissions with custom roles at the hierarchy level if needed. It's better to apply permissions at the [appropriate VM folder](/azure/azure-vmware/concepts-identity) or resource pool. Avoid application of vSphere permissions at or above the datacenter level.

- Update Active Directory Sites and Services to direct Azure and Azure VMware Solution AD DS traffic to the appropriate domain controllers.

- Use the `Run` command to:

  - Add an AD DS domain controller as an identity source for vCenter and NSX-T.

  - Provide lifecycle operation on the `vsphere.local\CloudAdmins` group.

- Create groups in Active Directory and use RBAC to manage vCenter and NSX-T. You can create [custom roles](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.security.doc/GUID-41E5E52E-A95B-4E81-9724-6AD6800BEF78.html) and [assign](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.security.doc/GUID-18071E9A-EED1-4968-8D51-E0B4F526FDA3.html) Active Directory groups to the custom roles.

## Next steps

Learn about network topology and connectivity for an Azure VMware Solution enterprise-scale scenario. Examine design considerations and best practices about networking and connectivity with Microsoft Azure and Azure VMware Solution.

> [!div class="nextstepaction"]
> [Network topology and connectivity](eslz-network-topology-connectivity.md)
