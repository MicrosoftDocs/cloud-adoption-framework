---
title: Business continuity and disaster recovery for Red Hat Enterprise Linux (RHEL) on Azure
description: Learn how this design area can improve business continuity and disaster recovery (BCDR) for Red Hat Enterprise Linux (RHEL) on Azure environment.
author: terrymandin
ms.author: terrymandin
ms.date: 04/05/24
ms.topic: conceptual
ms.custom: think-tank
---

# Business continuity and disaster recovery considerations for Red Hat Enterprise Linux (RHEL)trix on Azure

This article describes how you can improve business continuity and disaster recovery (BDCR) for a Red Hat Enterprise Linux (RHEL) on an Azure environment. This document describes how to build workloads using RHEL on Azure.  For specific guidance on RHEL BCDR capabilities for RHEL platform infrastructure see:

- <b>TODO: Add link to Identity HA Architecture</b>
- <b>TODO: Add additional links to other RHEL platform HA guidance in this guide</b>

## RHEL design considerations

Design considerations for RHEL technologies are described here <b>TODO: Add link to RHEL documentation</b>. This guide assists with BCDR architecture planning and considerations for both on-premises and Azure deployments of RHEL.

Because Azure VM availability isn't guaranteed by default (including for reserved instances), we recommend that you use the Azure [on-demand capacity reservation](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-overview) feature to ensure sufficient availability within the required regions when it's most needed.

## Machine catalog availability strategies

You can deploy RHEL architectures in an active/active or active/passive configuration by using a combination of Azure and on-premises workloads. 

The following lists aren't inclusive. They contain key highlights. For more information, see <b>TODO: Add link to RHEL documentation</b>.

### Active/active

<b>TODO: Work in progress</b>
 
### Active/passive

<b>TODO: Work in progress</b>

## Azure feature considerations
https://learn.microsoft.com/azure/expressroute/expressroute-faqs

| Azure feature or service| What is it? | Why is it important? |
|----|----|----|
| [Regions](https://learn.microsoft.com/azure/virtual-machines/regions) | A group of datacenters that are located close enough to each other to have low network delays. They use a special regional network that connects them to ensure fast data transfer. | When [choosing an Azure region](https://azure.microsoft.com/global-infrastructure/geographies/), you should consider the location of your datacenters, users, and back-end data. You should also check the availability of the services you need in the regions you select. For RHEL deployments, you may begin with one region, but you should plan to use multiple regions in the future for BCDR purposes. |
| [Azure ExpressRoute](https://learn.microsoft.com/azure/expressroute/expressroute-faqs) | ExpressRoute is an Azure Service that allows you to establish private connections from Microsoft datacenters to your own infrastructure or a colocation facility. | ExpressRoute is a secure and reliable way to connect your organization’s datacenter or colocation facility with a Microsoft datacenter. It bypasses the public internet and provides a dedicated private connection. This makes it a common requirement for large-scale RHEL deployments. As ExpressRoute is a shared service, you need to plan your bandwidth capacity carefully to meet your enterprise’s overall bandwidth needs. If your bandwidth is insufficient, it can impact the user experience or the access to critical services in the datacenter.  Ensure ExpressRoute is deployed in a resilient manner [across regions and peering locations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/connectivity-to-azure). |
 | [Availability zones](https://learn.microsoft.com/azure/reliability/availability-zones-overview?tabs=azure-cli) | Separate groups of datacenters within an Azure region that have their own power, cooling, and networking systems. They provide high availability and resilience to data center failures. | To ensure a [high SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9), use availability zones with RHEL infrastructure when possible. Availability zones offer datacenter redundancy within a region.  However, not every region has availability zones, so you need to plan carefully.  Specific RHEL services such as Azure Red Hat OpenShift and the landing zone management services  take advantage of Availability Zones.   |
| [Availability sets](https://learn.microsoft.com/azure/virtual-machines/availability-set-overview) | A logical grouping of VMs that ensure that at least one VM is always up and running during planned or unplanned maintenance events. A fault domain is a subset of an availability set that shares a common physical infrastructure, such as power and network. By distributing VMs across different fault domains, an availability set reduces the impact of hardware failures on the VM availability.  | Availability sets provide a [high SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). They are suitable for RHEL infrastructure when the region lacks availability zones. Availability sets have only hardware redundancy (similar to hypervisor anti-affinity rules). So, if your regions don’t have availability zones, you need a multi-region strategy for datacenter and geographic redundancy. |
| [Managed disks](https://learn.microsoft.com/azure/virtual-machines/managed-disks-overview) | Virtualized disks that Azure handles for you. You choose the disk size and type. Azure distributes disks across different storage units to protect your data from hardware failures. | Managed disks are the best choice for all RHEL infrastructure. Unmanaged disks are not advisable. To learn more about SLAs for single-instance virtual machines, check out [SLA for Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). Different types of disks have different performance and costs. For RHEL infrastructure machines, Premium is the preferred option. Consider cost, performance, and availability when choosing the disk type. Caution: When using Local SSD and Ephemeral Disks, these disks are removed when a system is deallocated.  Backup the data on these disks as appropriate. |
| [Azure Arc](https://learn.microsoft.com/azure/azure-arc/overview) | A platform that extends Azure services to run across diverse environments, including datacenters, edge devices, and multi-cloud architectures. It enables consistent development, operations, and security management for applications and services. | Azure Arc extends Azure services to manage and secure RHEL workloads consistently across environments.  From a BCDR perspective, Azure Arc increases resilience by enabling centralized automated backups and monitoring. |
| [Azure Backup](https://learn.microsoft.com/azure/backup/backup-overview) | A service that provides cost-effective solutions for backing up your data and recovering it from the Azure cloud. | Azure Backup is a reliable and cost-effective solution for protecting your RHEL infrastructure from virtual machine failure or corruption. By using Azure Backup, you can easily restore your entire VM or specific files and folders from the cloud, without having to recreate the VM or lose any data. If you don’t already have a backup solution, consider Azure Backup.  In addition to Azure Backup there are many supported 3rd party solutions. <b>TODO: Add Cross region replication </b> |
| [Azure Site Recovery (ASR)](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview) | A service that ensures business continuity by providing disaster recovery capabilities. It allows you to replicate and manage workloads, including Azure virtual machines (VMs) and on-premises VMs, across different regions. With ASR, you can set up replication, failover, and recovery processes, safeguarding your applications during both planned and unplanned outages. The service minimizes recovery issues, reduces infrastructure costs, and ensures secure and dependable recovery between Azure regions or from on-premises to Azure | ASR allows replication and management of workloads across different regions, safeguarding applications during both planned and unplanned outages, minimizing recovery issues, reducing infrastructure costs, and ensuring secure and dependable recovery between Azure regions or from on-premises to Azure . |
| [Resource locks](https://learn.microsoft.com/azure/azure-resource-manager/management/lock-resources?tabs=json) | An Azure feature that lets you apply a restriction across all users and roles in your organization, to protect your critical resources from accidental or malicious changes. You can lock a resource at different levels of scope, such as subscription, resource group, or individual resource. Depending on the type of lock, you can prevent users from deleting or modifying the resource, while still allowing them to read its configuration. | To protect all RHEL infrastructure and master image VMs, use resource locks on them. Apply Delete at a minimum, so you don’t lose important machines by mistake. Apply ReadOnly to RHEL infrastructure machines as they don’t change often. Only make changes during appropriate change control windows |	

## RHEL design recommendations
  
Design guidance for RHEL on Azure is available on <b>TODO: Add link to RHEL documentation</b>. The article highlights the system, workload, user, and network considerations for aligning RHEL deployments with Cloud Adoption Framework design principles.

[Azure Site Recovery (ASR)](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview) can enhance the resilience of some RHEL components.  For a list of supported RHEL site recovery servers see: [Support matrix for Azure VM disaster recovery with Azure Site Recovery](https://learn.microsoft.com/azure/site-recovery/azure-to-azure-support-matrix#linux). You can also reduce RTOs and increase resilience by using Active/Standby remote [recovery cluster](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_high_availability_clusters/assembly_configuring-disaster-recovery-configuring-and-managing-high-availability-clusters) nodes. A disaster recovery cluster does not set up resources or copy data by itself. The user must configure those items manually. <b>TODO: Add relevant content here from RH peer</b>

