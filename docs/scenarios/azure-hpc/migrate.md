---
title: Migrate workloads for Azure high-performance computing (HPC)
description: #Describe the scenario's impact on migration deployment.
author: ericd-mst-github
ms.author: erd
ms.date: 09/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Migrate Azure high-performance computing (HPC)

Establish a driving statement to shape migration of this technology platform. Best practice encourages customers to create a migration statement, using the [Cloud Adoption Framework's migrate methodology](../../migrate/index.md). Migrate and modernize existing workloads.

## HPC process details

Migrating to newer HPC clusters in Azure is not required, but offers benefits. You should reassess your infrastructure requirements to improve performance and reduce costs by using the relevant type of VMs. It is also possible to move to a more cost-effective, non HPC cluster.

Get started by following the [guidelines](https://azure.microsoft.com/en-us/resources/hpc-migration-guide/) in an HPC migration:
- **Review the current VM size**: Review your CPU, memory, disk, and networking specifications for existing VMs to determine appropriate VM sizes.
- **Verify Azure subscription quota limits**: Ensure that the quota limits in your Azure subscription accommodate the target VM sizes you choose.
- **Identify the deployment model**: Automate deployment as much as possible by choosing between Azure Resource Manager or Azure Service Manager, previously known as classic deployment.

## HPC process flow

Azure landing zones for HPC do not have any specific considerations or recommendations which would impact billing offer decisions, enterprise enrollment or Active Directory tenant decisions.

However, it could be important to understand any decisions previously made by the cloud platform team to be aware of [existing enterprise enrollment or Azure Active Directory tenant decisions.](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-ad-tenant)

Review the [identity and access management considerations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/sap/eslz-identity-and-access-management) to understand how the Azure Active Directory tenant is applied in the design of authentication and authorization solutions. 

Evaluate the [resource organization considerations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/sap/eslz-resource-organization) to understand how the enrollment is be organized into management groups, subscriptions, and resource groups.

## HPC workload specific activities

Are there specific criteria for workloads in that portfolio that would require the customer to run a well-architected review for any workloads?

## Next steps

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for HPC](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Govern HPC](./govern.md)
- [Strategic impact of HPC](./secure.md)
- [Organize team members for HPC in Azure](./organize.md)
- [Innovate with HPC](./innovate.md)
- [Manage HPC](./manage.md)