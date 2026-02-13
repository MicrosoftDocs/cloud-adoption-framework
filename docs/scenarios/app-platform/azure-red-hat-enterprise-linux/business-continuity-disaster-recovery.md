---
title: Business continuity and disaster recovery considerations for Red Hat Enterprise Linux on Azure
description: Learn how this design area can improve business continuity and disaster recovery (BCDR) for a Red Hat Enterprise Linux (RHEL) on Azure environment.
author: terrymandin
ms.date: 07/24/2024
ms.author: temandin
ms.topic: concept-article
---

# Business continuity and disaster recovery considerations for Red Hat Enterprise Linux on Azure

This article describes how to improve business continuity and disaster recovery (BCDR) readiness for a Red Hat Enterprise Linux (RHEL)-based environment on Azure. It provides recommendations that you can use to support RHEL workloads and to deploy RHEL platform-management components. The Red Hat Management subscription contains platform components that help manage workloads in one or more RHEL landing zones. These components offer their own BCDR configurations.

## Design considerations

Implement the following considerations to improve the resiliency of your RHEL workloads.

### Recovery time objectives

A recovery time objective (RTO) is the amount of time that it should take your system to recover to its original state after a disaster. The RTO includes the time that it takes to:

- Restore minimal functionality to virtual machines (VMs) and applications.
- Restore data that applications require.

In business terms, the RTO represents the amount of time that business processes are out of service. A low RTO is ideal for [mission-critical workloads](/azure/well-architected/mission-critical/) so that business processes can resume quickly. For lower-priority workloads, a higher RTO might not have a noticeable effect on company performance.

### Recovery point objectives

To successfully operate a cloud environment, you must implement backups, replication, or both to protect data from failures. The recovery point objective (RPO) refers to the last time that data was captured. When a system fails, you can restore it only to the most recent recovery point.

You measure the RPO from the most recent recovery point to the time that an outage occurs. If you measure the RPO in hours, a system failure results in the loss of data for the hours between the last recovery point and the outage. If you measure the RPO in days, a system failure results in the loss of data for the days between the last recovery point and the outage. A one-day RPO theoretically results in the loss of all transactions in the day that leads up to the failure.

For mission-critical systems, measure the RPO in minutes or seconds to help avoid loss in revenue or profits. A short RPO generally results in increased management costs. To help reduce these costs, you should create a management baseline that focuses on the longest acceptable RPO. You can then decrease the RPO of the specific platforms or workloads that warrant more investment.

### Workload BCDR considerations

High availability and disaster recovery design considerations for RHEL-based workloads depend on the technologies that support those workloads. Many modern workloads can take advantage of native Azure services to provide redundancy across availability zones and across regions. Use Azure services to manage data replication, automatically scale availability sets, and control update and fault domains. These practices make it easier to ensure the availability of RHEL deployments.

Database solutions and other stateful applications might need operating system-centric solutions to provide high availability and disaster recovery. Consult with the application developer or vendor to verify the solutions that the applications support.

| Azure feature or service| Definition | Considerations |
|----|----|----|
| [Regions](/azure/virtual-machines/regions) | A group of datacenters that are located close to each other to provide low network delays. To ensure a fast data transfer, a specific regional network connects the datacenters. | When you [choose an Azure region](https://azure.microsoft.com/global-infrastructure/geographies/), consider the location of your datacenters, users, and back-end data. Check the availability of the services that you need in the regions that you select. For RHEL deployments, you might have one region to start, and then you can add more regions in the future for BCDR purposes. |
| [Azure ExpressRoute](/azure/expressroute/expressroute-faqs) | An Azure service that you can use to establish private connections from Microsoft datacenters to your own infrastructure or to a colocation facility. | ExpressRoute bypasses the public internet and provides a dedicated private connection. This configuration is a common requirement for large-scale RHEL deployments. ExpressRoute is a shared service, so you need to plan your bandwidth capacity carefully to meet your enterprise's overall bandwidth needs. <br><br> If you have insufficient bandwidth, you might compromise the user experience or the access to critical services in the datacenter. Ensure that you deploy ExpressRoute in a resilient manner [across regions and peering locations](/azure/cloud-adoption-framework/ready/azure-best-practices/connectivity-to-azure). |
 | [Availability zones](/azure/reliability/availability-zones-overview) | Separate groups of datacenters that have their own power, cooling, and networking systems within an Azure region. Availability zones provide high availability and resiliency to datacenter failures. | To ensure a [high service-level agreement (SLA)](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9), use availability zones with RHEL infrastructure when possible. Availability zones offer datacenter redundancy within a region. But not every region has availability zones, so you need to plan carefully. RHEL services, such as Azure Red Hat OpenShift and the landing zone management services, support availability zones.   |
| [Availability sets](/azure/virtual-machines/availability-set-overview) | A logical grouping of VMs. At least one VM is always up and running during planned or unplanned maintenance events. A fault domain is a subset of an availability set that shares a common physical infrastructure, such as power or network. When you distribute VMs across different fault domains, an availability set reduces the impact of hardware failures on the VM availability.  | Availability sets provide a [high SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). Availability sets are suitable for an RHEL infrastructure when a region lacks availability zones. Availability sets have only hardware redundancy, which is similar to hypervisor anti-affinity rules. So if your regions don't have availability zones, you need a multiregion strategy for datacenter and geographic redundancy. |
| [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) | A network load-balancing service. You can configure Load Balancer to provide high-volume network traffic efficiently across multiple Red Hat Enterprise servers. The service operates at low latency and high throughput, which improves the performance and availability of applications.<br><br> Load Balancer can automatically scale according to demand. To promote a hybrid deployment of your applications, Load Balancer can distribute network traffic across multiple regions in Azure and also between on-premises environments and Azure. | Load Balancer distributes network traffic across multiple servers to provide uninterrupted application availability and prevent single-point failures. If a disaster occurs, Load Balancer redirects traffic to operational servers to provide a rapid failover and recovery. This operation minimizes downtime and maintains business operations. <br><br> Load Balancer can balance traffic across on-premises servers to the Azure cloud or to servers in multiple Azure regions. For more information, see [Load-balancing options](/azure/architecture/guide/technology-choices/load-balancing-overview). |
| [Managed disks](/azure/virtual-machines/managed-disks-overview) | Virtualized disks that Azure manages. You choose the disk size and type. Azure distributes disks across various storage units to protect your data from hardware failures. | Managed disks are the best choice for all RHEL infrastructure. Don't use unmanaged disks. For more information, see [SLAs for VMs](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9). <br><br> Different types of disks have different performance and costs. For RHEL infrastructure machines, we recommend Azure Premium SSD. Consider cost, performance, and availability when you choose the disk type. When you deallocate a system, local SSD and ephemeral disks are removed. Back up the data on these disks as appropriate. |
| [Azure Backup](/azure/backup/backup-overview) | A service that provides cost-effective solutions to back up your data and recover it from the Azure cloud. | Backup is a reliable and cost-effective solution that protects your RHEL infrastructure from VM failure or corruption. Use Backup to easily restore your entire VM or specific files and folders from the cloud, without having to recreate the VM or lose any data. You can also use other supported partner solutions. |
| [Azure Arc](/azure/azure-arc/overview) | A platform that extends Azure services so that they run across diverse environments, including datacenters, edge devices, and multicloud architectures. Use Azure Arc to provide consistent development, operations, and security management for applications and services. | Use Azure Arc to implement centralized automated backups and monitoring, which increases resiliency from a BCDR perspective. |
| [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) | A service that provides disaster recovery capabilities to ensure business continuity. You can replicate and manage workloads, including Azure VMs and on-premises VMs, across different regions. With Site Recovery, you can set up replication, failover, and recovery processes to safeguard your applications during planned outages and unplanned outages. | Use Site Recovery to minimize recovery problems, reduce infrastructure costs, and ensure secure and dependable recovery between Azure regions or from on-premises locations to Azure.  |
| [Resource locks](/azure/azure-resource-manager/management/lock-resources) | An Azure feature that you can use to restrict users and roles in your organization. Protect your critical resources from accidental or malicious changes. You can lock a resource at various levels of scope, such as subscription, resource group, or individual resource levels. Depending on the type of lock, you can prevent users from deleting or modifying a resource, but they can still read its configuration. | To protect all RHEL infrastructure and golden image VMs, use resource locks. To prevent accidentally losing important machines, apply the **Delete** lock at a minimum. Apply the **ReadOnly** lock to RHEL infrastructure machines because they don't change often. Only make changes during appropriate change control windows. |

### RHEL platform BCDR considerations

For more information about BCDR capabilities for an RHEL platform infrastructure, see:

- [Satellite high availability architecture](./management-monitoring.md).
- [Ansible Automation platform high availability architecture](https://docs.redhat.com/documentation/red_hat_ansible_automation_platform/2.1/html-single/deploying_ansible_automation_platform_2.1/index).
- [Identity management high availability architecture](./identity-access-management.md#design-recommendations-for-red-hat-identity-management).

## Design recommendations

For cloud-native applications in Linux containers, use a Kubernetes-based platform to ensure scalability, high availability, and redundancy. Consider using the [Azure Red Hat OpenShift](https://azure.microsoft.com/products/openshift) platform or a self-managed OpenShift deployment with replicated or geo-replicated storage.

For native web application front ends and stateless applications, you can use many of the Azure-native services that provide application availability. For an architecture that uses such services, see [Baseline highly available zone-redundant web application](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant).


The preceding architectures use various Azure services for availability zones. The multiregion architecture uses geo-replication features for content and Azure Front Door as a load balancing service.

For many traditional stateful applications that require high availability, RHEL offers the Pacemaker high availability add-on. You can get systems that have this feature from Microsoft Marketplace, or you can deploy a custom image with the required software components embedded. For more information, see [Configure a Red Hat high availability cluster on Microsoft Azure](https://docs.redhat.com/documentation/red_hat_enterprise_linux/9/html/deploying_rhel_9_on_microsoft_azure/configuring-rhel-high-availability-on-azure_cloud-content-azure).

Availability problems affect service outages and service response times. Service degradation can occur, which might degrade your customer's service experience. To ensure that you maintain performance levels and sufficient capacity within the required regions, use the Azure [on-demand capacity reservation](/azure/virtual-machines/capacity-reservation-overview) feature.

### Reliability

Many of the concepts that apply to infrastructure as a service VM infrastructures also apply to RHEL architectures. For more information, see [Reliability design principles](/azure/well-architected/reliability/principles).

### Clusters

Azure doesn't support combining Application Server Central Services and database high availability within a single RHEL Pacemaker cluster. To address this limitation, separate them into individual clusters. You can combine up to [five central services clusters](/azure/sap/workloads/high-availability-guide-rhel-multi-sid) in a pair of VMs.

For [BCDR on SAP](/azure/cloud-adoption-framework/scenarios/sap/eslz-business-continuity-and-disaster-recovery), consider the following services to run SAP central services clusters:

- [RHEL Pacemaker cluster](/azure/sap/workloads/high-availability-guide-rhel-netapp-files): STONITH block devices aren't supported, but you can rely on the Azure fence agent.
- SAP-certified non-Microsoft cluster software: Explore this option if it aligns with your requirements.

Choose the appropriate service based on your specific needs and your operating system.

For more information, see:

- [Configure a Red Hat high availability cluster on Microsoft Azure for RHEL 9](https://docs.redhat.com/documentation/red_hat_enterprise_linux/9/html/deploying_rhel_9_on_microsoft_azure/configuring-rhel-high-availability-on-azure_cloud-content-azure).
- [Configure and manage high availability clusters for RHEL 9](https://docs.redhat.com/documentation/red_hat_enterprise_linux/9/html/configuring_and_managing_high_availability_clusters/index).
- [RHEL 8 documentation](https://docs.redhat.com/documentation/red_hat_enterprise_linux/8).

### Azure Compute Gallery replicas

You can use Compute Gallery to store golden images for deployments. Use these images for the disaster recovery of applications and tools. Compute Gallery can use highly available [resources with zone-redundant storage (ZRS) accounts](/azure/virtual-machines/azure-compute-gallery) in regions that support availability zones. ZRS offers resiliency against zonal failures. You can also replicate gallery images to other regions or geographies.

> [!NOTE]
> We recommend that you have at least two galleries in different regions.

### Site Recovery

[Site Recovery](/azure/site-recovery/site-recovery-overview) can enhance the resilience of some RHEL components. For a list of supported RHEL site recovery servers, see [Support matrix for Azure VM disaster recovery with Site Recovery](/azure/site-recovery/azure-to-azure-support-matrix#linux). You can also set up Site Recovery as a [failover from on-premises environments to the cloud](/azure/site-recovery/failover-failback-overview-modernized). To get an estimate of Site Recovery costs, use the [Site Recovery deployment planner](/azure/site-recovery/hyper-v-deployment-planner-cost-estimation).

### Recovery cluster nodes

Use active or standby remote recovery cluster nodes to reduce RTO while your primary architecture patterns provide resilience. You must configure disaster recovery cluster items manually. For example, you must apply configurations to set up resources and copy data.

## Next steps

- [Network topology and connectivity considerations for Red Hat Enterprise Linux](./network-topology-connectivity.md)