---
title: Platform automation and DevOps for Azure HPC in the manufacturing industry
description: Azure landing zones for HPC in manufacturing don't have any specific considerations or recommendations that affect platform automation and DevOps decisions.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/14/2022
---

# Platform automation and DevOps for HPC in the manufacturing industry 

Azure [landing zones for HPC](../ready.md) in the manufacturing industry don't have any specific considerations or recommendations that affect decisions related to platform automation and DevOps. Platform automation and DevOps are two of several design areas considered in this documentation.

## Templates 

You can deploy HPC Pack 2019 clusters using pre-existing Azure Resource Manager (ARM) [templates](https://github.com/Azure/hpcpack-template/tree/master/HPCPack2019) on GitHub with the option to deploy straight from the Azure portal. Depending on whether you need an Azure Active Directory (Azure AD) integrated HPC Pack deployment or not, you can choose from a variety of templates that suit your scenario (i.e. Windows vs. Linux requirements, new vs. existing Azure AD domain, high-availability/multiple head node cluster for BC/DR vs. single head node cluster). Note there are some prerequisites prior to deploying HPC Pack 2019, such as having an Azure Key Vault Certificate. Read more in the [README](https://github.com/Azure/hpcpack-template/blob/master/HPCPack2019/README.md).



## Previous recommendations 

Keep in mind that it could be important to understand any decisions made previously by the cloud platform team so you know about existing recommendations for [platform automation and DevOps](../../../ready/landing-zone/design-area/platform-automation-devops.md).

## Next steps

The following articles provide guidance that you might find helpful at various points during your cloud adoption process. They can help you succeed in the cloud adoption scenario for HPC in the manufacturing industry.

- [Azure billing and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Identity and access management](./identity-access-management.md)
- [Management](./management.md)
- [Network topology and connectivity](./network-topology-connectivity.md)
- [Resource organization](./resource-organization.md)
- [Governance](./security-governance-compliance.md)
- [Security for HPC in manufacturing industries](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
