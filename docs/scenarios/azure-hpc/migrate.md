---
title: Migrate workloads for Azure high-performance computing (HPC)
description: As an IT professional, I want to find guidance in the Cloud Adoption Framework covering migration for using Azure High-performance computing (HPC) as part of my IT strategy.
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

Get started by following the [guidelines](https://azure.microsoft.com/resources/hpc-migration-guide/) in an HPC migration:
- **Review the current VM size**: Review your CPU, memory, disk, and networking specifications for existing VMs to determine appropriate VM sizes.
- **Verify Azure subscription quota limits**: Ensure that the quota limits in your Azure subscription accommodate the target VM sizes you choose.
- **Identify the deployment model**: Automate deployment as much as possible by choosing between Azure Resource Manager or Azure Service Manager, previously known as classic deployment.

## HPC process flow

Azure landing zones for HPC do not have any specific considerations or recommendations which would impact billing offer decisions, enterprise enrollment or Active Directory tenant decisions.

However, it could be important to understand any decisions previously made by the cloud platform team to be aware of [existing enterprise enrollment or Azure Active Directory tenant decisions.](../../ready/landing-zone/design-area/azure-billing-ad-tenant.md)

Review the [identity and access management considerations](../../scenarios/sap/eslz-identity-and-access-management.md) to understand how the Azure Active Directory tenant is applied in the design of authentication and authorization solutions.

Evaluate the [resource organization considerations](https://docs.microsoft.com/azure/cloud-adoption-framework/scenarios/sap/eslz-resource-organization) to understand how the enrollment is be organized into management groups, subscriptions, and resource groups.

## HPC workload specific activities

For HPC workload specific activities, you should define a network topology that works best for your deployment model, consider the various factors in large-scale workloads to decide on which storage solution to use, and implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags.

### Network topology and connectivity
Use a network topology based on either Azure Virtual WAN or hub-and-spoke architecture.

Use **Azure Virtual WAN** if your organization plans to deploy resources across several Azure regions and connect your global locations to both Azure and on-premises, fully integrate software-defined WAN deployments with Azure, and deploying up to 2,000 virtual machine workloads across all VNets connected to one Virtual WAN hub.

Use **[hub-and-spoke architecture](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli)** for deploying resources in only select Azure regions, have no need for a global, interconnected network, fewer than 30 IP security tunnels, and full control and granularity to manually configure your Azure network.

### Storage
Large-scale HPC workloads tend to have demands for data storage and access that exceed capabilities of traditional cloud file systems. The factors for storage consideration are:
- Latency
- IOPS,
- Throughput
- File sizes and count
- Job run time
- Cost associated
- Affinity for storage location - on-premises vs Azure

Use [standard or premium blob storage](../../../../azure-docs-pr/articles/storage/blobs/storage-blobs-introduction.md) to provide exabyte scale, lowest cost cloud offering, and optimizing costs by moving to cooler tiers with the ability to perform lifecycle management with last update/access time, intelligent tiering, and customizable policies.

For write-once/read-once applications and random access workloads, use [Azure NetApp Files](https://docs.microsoft.com/azure/azure-netapp-files/) to have the widest choice of file protocols in the public cloud, fast deployment in minutes, and for flexible capacity pool types and performance.


### Resource organization

Resource organization for HPC follows alignment with the [Ready methodology](../../ready/index.md#prepare-for-cloud-adoption) by determining single vs multiple Azure subscriptions based on organizational needs and executing a naming and tagging strategy for components of resource names and metadata tags.

Review the [decision](../../decision-guides/subscriptions/index.md) making process for subscriptions.

The business side of this strategy ensures that resource names and tags include the organizational information you need to identify the teams. Use a resource name along with the business owners who are responsible for resource costs. The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other useful information for managing resources.

Resources to name include VMs, load balancers, DNS labels, availability sets, virtual networks, subnets, ExpressRoute, NSGs, application security groups, tags, route tables, managed disks, and public IPs.

## Next steps

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for HPC](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Govern HPC](./govern.md)
- [Strategic impact of HPC](./secure.md)
- [Organize team members for HPC in Azure](./organize.md)
- [Innovate with HPC](./innovate.md)
- [Manage HPC](./manage.md)