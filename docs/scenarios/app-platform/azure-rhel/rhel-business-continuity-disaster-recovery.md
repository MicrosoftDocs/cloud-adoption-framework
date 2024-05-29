---
title: Business continuity and disaster recovery for Red Hat Enterprise Linux (RHEL) on Azure
description: Learn how this design area can improve business continuity and disaster recovery (BCDR) for Red Hat Enterprise Linux (RHEL) on Azure environment.
author: terrymandin
Authors: Paul Armstrong, Mike Savage, Jon Austin and Terry Mandin
Date: 04/26/2024
Topic: Azure Business Continuity and Disaster Recovery for Red Hat Enterprise Linux
ms.author: temandin
ms.topic: conceptual
---

# Business continuity and disaster recovery considerations for Red Hat Enterprise Linux (RHEL) on Azure

This article describes how you can improve business continuity and disaster recovery (BDCR) for a Red Hat Enterprise Linux (RHEL) on an Azure environment. The documentation provides recommendations for deploying RHEL platform management components, and for supporting RHEL workloads. The Red Hat Management subscription contains the platform components for managing workloads in one or more RHEL Landing zones. These components offer their own BCDR configurations as described in the relevant section. There are separate BCDR considerations and deployment considerations for workload components running in your Red Hat Landing Zone. 

## Design Considerations

### Recovery time objectives (RTO)

A recovery time objective is the amount of time it should take to recover any system to its state prior to a disaster. This would include the time needed to:

- restore minimal functionality to VMs and applications
- restore data required by applications.

In business terms, RTO represents the amount of time that business processes are out of service. For mission-critical workloads, this variable should be relatively low, allowing business processes to resume quickly. For lower-priority workloads, a standard level of RTO might not have a noticeable impact on company performance.

A business should create a management baseline that establishes a standard RTO for non-mission-critical workloads. The business can then use that baseline as a way to justify additional investments in recovery times.

### Recovery point objectives (RPO)

In most cloud management systems, some form of data protection periodically captures and stores data. The recovery point refers to the last time the data was captured. When a system fails, it can be restored only to the most recent recovery point.

The recovery point objective is measured from the most recent recovery point to an outage. If the RPO is measured in hours, a system failure results in the loss of data for the hours between the last recovery point and the outage. If the RPO is measured in days, a system failure results in the loss of data for the days between the last recovery point and the outage. A one-day RPO would theoretically result in the loss of all transactions in the day leading up to the failure.

For mission-critical systems, measuring an RPO in minutes or seconds might help avoid loss in revenue or profits. However, a shorter RPO generally results in increased management costs. To help minimize these costs, a business should create a management baseline that focuses on the longest acceptable RPO. The business can then decrease the RPO of the specific platforms or workloads that warrant more investment.


### Workload BCDR Considerations

High availability and disaster recovery design considerations for Red Hat Enterprise Linux based workloads is dependent on the technologies supporting those workloads. Many modern workloads can take advantage of native Azure services to provide redundancy across availability zone and across regions. Azure’s sophisticated services for managing data replication, autoscaling of availability sets and control of update and fault domains make ensuring the availability of RHEL deployments simpler. Database solutions and other stateful applications may need operating system centric solutions to provide high availability and disaster recovery. It's important to work with the application developer or vendor to verify applicable solutions for those applications. For general Azure BCDR guidance, see [High availability and disaster recovery for IaaS apps](/azure/architecture/example-scenario/infrastructure/iaas-high-availability-disaster-recovery).

| Azure feature or service| What is it? | Why is it important? |
|----|----|----|
| [Regions](/azure/virtual-machines/regions) | A group of datacenters that are located close enough to each other to have low network delays. They use a special regional network that connects them to ensure fast data transfer. | When [choosing an Azure region](https://azure.microsoft.com/global-infrastructure/geographies/), you should consider the location of your datacenters, users, and back-end data. You should also check the availability of the services you need in the regions you select. For RHEL deployments, you may begin with one region, but you should plan to use multiple regions in the future for BCDR purposes. |
| [Azure ExpressRoute](/azure/expressroute/expressroute-faqs) | ExpressRoute is an Azure Service that allows you to establish private connections from Microsoft datacenters to your own infrastructure or a colocation facility. | ExpressRoute is a secure and reliable way to connect your organization’s datacenter or colocation facility with a Microsoft datacenter. ExpressRoute bypasses the public internet and provides a dedicated private connection, making it a common requirement for large-scale RHEL deployments. As ExpressRoute is a shared service, you need to plan your bandwidth capacity carefully to meet your enterprise’s overall bandwidth needs. If your bandwidth is insufficient, it can impact the user experience or the access to critical services in the datacenter. Ensure ExpressRoute is deployed in a resilient manner [across regions and peering locations](/azure/cloud-adoption-framework/ready/azure-best-practices/connectivity-to-azure). |
 | [Availability zones](/azure/reliability/availability-zones-overview?tabs=azure-cli) | Separate groups of datacenters within an Azure region that have their own power, cooling, and networking systems. They provide high availability and resilience to data center failures. | To ensure a [high Service Level Agreement (SLA)](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9), use availability zones with RHEL infrastructure when possible. Availability zones offer datacenter redundancy within a region. However, not every region has availability zones, so you need to plan carefully. Specific RHEL services such as Azure Red Hat OpenShift and the landing zone management services  take advantage of Availability Zones.   |
| [Availability sets](/azure/virtual-machines/availability-set-overview) | A logical grouping of Virtual Machines that ensure that at least one Virtual Machine is always up and running during planned or unplanned maintenance events. A fault domain is a subset of an availability set that shares a common physical infrastructure, such as power and network. By distributing VMs across different fault domains, an availability set reduces the impact of hardware failures on the VM availability.  | Availability sets provide a [high SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). They're suitable for RHEL infrastructure when the region lacks availability zones. Availability sets have only hardware redundancy (similar to hypervisor anti-affinity rules). So, if your regions don’t have availability zones, you need a multi-region strategy for datacenter and geographic redundancy. |
| [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) | Azure Load Balancer is a network load balancing service in Microsoft Azure. It can be configured to provide high-volume network traffic efficiently across multiple Red Hat Enterprise Servers. The service operates at low latency and high throughput, improving the performance and availability of applications. It can auto scale according to demand. Network traffic can be distributed across multiple regions in Azure and also between on-premises environments and Azure, facilitating a hybrid deployment of your applications. | Ensures uninterrupted application availability by distributing network traffic across multiple servers, preventing single-point failures. In the event of a disaster, it facilitates rapid failover and recovery by redirecting traffic to operational servers, thus minimizing downtime and maintaining business operations. Traffic can be balanced across on-premises servers to the Azure cloud, or to servers in multiple Azure regions. See: [Load-balancing options](/azure/architecture/guide/technology-choices/load-balancing-overview). |
| [Managed disks](/azure/virtual-machines/managed-disks-overview) | Virtualized disks that Azure handles for you. You choose the disk size and type. Azure distributes disks across different storage units to protect your data from hardware failures. | Managed disks are the best choice for all RHEL infrastructure. Unmanaged disks aren't advisable. To learn more about SLAs for single-instance virtual machines, check out [SLA for Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). Different types of disks have different performance and costs. For RHEL infrastructure machines, Premium is the preferred option. Consider cost, performance, and availability when choosing the disk type. Caution: Local SSD and Ephemeral Disks are removed when a system is deallocated. Backup the data on these disks as appropriate. |
| [Azure Backup](/azure/backup/backup-overview) | A service that provides cost-effective solutions for backing up your data and recovering it from the Azure cloud. | Azure Backup is a reliable and cost-effective solution for protecting your RHEL infrastructure from virtual machine failure or corruption. By using Azure Backup, you can easily restore your entire VM or specific files and folders from the cloud, without having to re-create the VM or lose any data. If you don’t already have a backup solution, consider Azure Backup. In addition to Azure Backup, there are many supported third party solutions. |
| [Azure Arc](/azure/azure-arc/overview) | A platform that extends Azure services to run across diverse environments, including datacenters, edge devices, and multicloud architectures. It enables consistent development, operations, and security management for applications and services. | Azure Arc extends Azure services to manage and secure RHEL workloads consistently across environments. From a BCDR perspective, Azure Arc increases resilience by enabling centralized automated backups and monitoring. |
| [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) | A service that ensures business continuity by providing disaster recovery capabilities. It allows you to replicate and manage workloads, including Azure virtual machines (VMs) and on-premises VMs, across different regions. With Azure Site Recovery, you can set up replication, failover, and recovery processes, safeguarding your applications during both planned and unplanned outages. The service minimizes recovery issues, reduces infrastructure costs, and ensures secure and dependable recovery between Azure regions or from on-premises to Azure | Azure Site Recovery enables workload replication and management across regions, ensuring application protection during planned and unplanned outages. It minimizes recovery issues, cuts infrastructure costs, and provides secure, reliable recovery across Azure regions or from on-premises to Azure. |
| [Resource locks](/azure/azure-resource-manager/management/lock-resources?tabs=json) | An Azure feature that lets you apply a restriction across all users and roles in your organization, to protect your critical resources from accidental or malicious changes. You can lock a resource at different levels of scope, such as subscription, resource group, or individual resource. Depending on the type of lock, you can prevent users from deleting or modifying the resource, while still allowing them to read its configuration. | To protect all RHEL infrastructure and master image VMs, use resource locks on them. Apply Delete at a minimum, so you don’t lose important machines by mistake. Apply ReadOnly to RHEL infrastructure machines as they don’t change often. Only make changes during appropriate change control windows. |	

### RHEL Platform BCDR Considerations

For specific guidance on RHEL BCDR capabilities for RHEL platform infrastructure see: 
- [Satellite HA Architecture](TODOPointToManagementAndMonitoringWhenItIsComplete) 
- [Ansible Automation Platform HA Architecture](https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.1/html-single/deploying_ansible_automation_platform_2.1/index)
- [Identity Management HA Architecture](./rhel-identity-access-management.md#design-recommendations)

## Design Recommendations

For cloud-native applications in Linux containers, opt for a Kubernetes-based platform to ensure scalability, high availability, and redundancy. Consider using the Azure Red Hat OpenShift platform or a self-managed OpenShift deployment with replicated or geo-replicated storage.

For native web application front ends and stateless applications, many of the Azure native services designed to provide application availability can be used. Follow Azure general guidance for such services:

- [Baseline highly available zone-redundant web application](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant)
- [Highly available multi-region web application](/azure/architecture/web-apps/app-service/architectures/multi-region)

The above configurations make use of Azure services for availability zones, Azure Front Door for load balancing services and geo-replication for content.

For many traditional stateful applications that require high availability, Red Hat Enterprise Linux offers pacemaker high availability add-on. The Azure marketplace can deliver systems with this feature, or you can deploy a custom image with the required software components embedded. See Red Hat documentation for details on [Configuring a Red Hat High Availability cluster on Microsoft Azure](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/deploying_rhel_9_on_microsoft_azure/configuring-rhel-high-availability-on-azure_cloud-content-azure).

Availability issues aren't limited to service outages, but also service response time. Service degradation can occur and your customer’s service experience may be degraded. To ensure performance levels are maintained, the Azure [on-demand capacity reservation](/azure/virtual-machines/capacity-reservation-overview) feature can be used to ensure sufficient capacity within the required regions.

### Reliability

Many of the concepts that apply to IaaS VM infrastructures also apply to Red Hat Enterprise Linux architectures. For more details, please see [Reliability design principles](https://learn.microsoft.com/en-us/azure/well-architected/reliability/principles).

### Clusters

Azure currently doesn't support combining ASCS (Application Server Central Services) and database high availability within a single Red Hat Enterprise Linux pacemaker cluster. To address this limitation, separate them into individual clusters. However, you can still combine up to [five central services clusters](/azure/sap/workloads/high-availability-guide-suse-multi-sid?tabs=ensa1) in a pair of virtual machines (VMs).

For [business continuity and disaster recovery on SAP](/azure/cloud-adoption-framework/scenarios/sap/eslz-business-continuity-and-disaster-recovery), consider the following services for running SAP central services clusters, based on the operating system:

- [Red Hat Enterprise Linux Pacemaker Cluster](/azure/sap/workloads/high-availability-guide-rhel-netapp-files?tabs=lb-portal%2Censa1): While STONITH block devices (SBDs) aren't currently supported, you can rely on the Azure fence agent.
- SAP-Certified Third-Party Cluster Software: Explore this option if it aligns with your requirements.

Remember to choose the appropriate service based on your specific needs and the operating system in use.

See also Red Hat HA documentation:

- RHEL 9 - [Configuring a Red Hat High Availability cluster on Microsoft Azure](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/deploying_rhel_9_on_microsoft_azure/configuring-rhel-high-availability-on-azure_cloud-content-azure)
- RHEL 9 - [Configuring and managing high availability clusters](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/configuring_and_managing_high_availability_clusters/index)
- Similar documentation exists for [RHEL 8](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8)

### Azure Gallery Replicas

Azure gallery can be used to store golden images for deployments. These images can be used for disaster recovery of applications and tools. Azure gallery can use highly available [resources with Zone Redundant Storage (ZRS) accounts](/azure/virtual-machines/azure-compute-gallery) in regions that support Availability Zones. ZRS offers better resilience against zonal failures. Furthermore, gallery images can be replicated to other regions/geographies.

Note: recommended practice is to have at least two galleries, in different regions.

### Azure Site Recovery

[Azure Site Recovery](/azure/site-recovery/site-recovery-overview) can enhance the resilience of some RHEL components. For a list of supported RHEL site recovery servers see: [Support matrix for Azure VM disaster recovery with Azure Site Recovery](/azure/site-recovery/azure-to-azure-support-matrix#linux). Azure Site Recovery can also be set up as a [failover from on-premises to the cloud](/azure/site-recovery/failover-failback-overview-modernized).  

### Recovery Cluster Nodes

You can also reduce Recovery Time Objectives (RTOs) and increase resilience by using Active/Standby remote [recovery cluster](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_high_availability_clusters/assembly_configuring-disaster-recovery-configuring-and-managing-high-availability-clusters) nodes. A disaster recovery cluster doesn't set up resources or copy data by itself. The user must configure those items manually. 

