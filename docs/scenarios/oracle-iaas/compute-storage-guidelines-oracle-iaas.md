---
title: Compute and storage guidelines for Oracle Workload as IaaS on Azure
description: Learn about compute and storage guidelines for Oracle Workload as IaaS on Azure.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 01/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---


# Compute and storage guidelines for Oracle Workload as IaaS on Azure

This article builds on several considerations and recommendations defined in the Azure cloud adoption framework. It provides guidelines on how to select optimized infrastructure for your Oracle workloads on Microsoft Azure IaaS  Compute (VM) and Storage.  

## Infrastructure Right Sizing 

It’s  crucial to determine the right capacity for optimal performance and cost efficiency for Oracle workloads running on Azure as Infrastructure as a Service (IaaS).  The right-size assessment helps you to select the right VM SKU. Based on the number of vCPU that is assigned to it, you can also get a direction of required Oracle licenses. You Start describing your Oracle workload with AWR report and the follow the Capacity planning design area guidelines to arrive at optimized VM SKUS & storage options either manually using the spreadsheet or OMAT Tool. Both the case knowing compute & storage guidelines helps you to optimize the capacity required on Azure for your Oracle workload. 

## Key guidelines for compute  

Since Oracle products are usually licensed by processor core, selecting a VM with the least number of suitable cores provides the best licensing savings for the customers.  Most Oracle Workloads require a lower number of vCPUs and a higher number of Memories, IOPS and Throughput, for which these VM shapes are beneficial. Consider the maximum number of disks supported by VM, IOPS and MB/sec throughput per disk and overall capped values at VM level is important. The number of network interfaces supported for the VM is another point to consider.  

### Consider using constrained VM for your right sizing

Azure offers certain VM sizes with [constrained VM](https://learn.microsoft.com/azure/virtual-machines/constrained-vcpu) vCPU count in order to reduce the cost of software licensing, while maintaining the same memory, storage, and I/O bandwidth that the Oracle database workloads require.  For example, a “Standard_M16-4 ms” VM has the same performance specifications as a “Standard_M16ms” VM but since it has only 4 available CPUs, it  provides significant Oracle license savings for the customer.  

Particularly [E-series](https://learn.microsoft.com/azure/virtual-machines/ev3-esv3-series) VMs are recommended for Oracle workloads on Azure.  

### Network & storage consideration for selected VM for Oracle workload

When selecting a VM size on Azure, it's important to recall that there are limits on the following resources  

- Number of supported disks  

- IOPS and throughput limits for different disk types  

- [Capped values](https://learn.microsoft.com/azure/virtual-machines/disks-performance) for max cached and uncached IOPS and throughput at VM level  

- Number of supported network interfaces   

- Network Throughput for Network Attached Storages 

Regarding VM disk types, premium storage is highly recommended. For details, see storage [recommendations](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-storage).  

One must consider un-cached IOPS and especially uncached disk throughput values when deciding on the disk capabilities of the required VM size.   

Network throughput is important especially when Oracle Data Guard is used since online redo logs will continually replicate to the standby database instance.

## Key Guidelines for Storage

Azure offers various [storage options](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-storage), each suited for different use cases for your Oracle workload on Azure. Below is some advice to select the right storage: 

- Ultra Disk: Given their high performance, Ultra Disks are ideal for data-intensive applications that require high IOPS and low latency.   
    - High IOPS: Ultra Disks can achieve up to 160,000 I/O operations per second (IOPS) per disk – a level of performance that is essential for heavy workload operations.
    - Low Latency: Ultra Disks boast submillisecond latency, which can significantly speed up the response times of your applications.
    - High Throughput: They can provide up to 2000 MB/s per disk, making them a good choice for data-intensive applications.
    - Dynamic Scalability: With Ultra Disks, you can increase or decrease capacity (size), IOPS, and throughput independently without having to restart your virtual machines (VMs). 
    - VM Compatibility: Ultra Disks are compatible with a specific set of Azure VMs, including the ESv3, DSv3, FS, and M series. It's important to check the Azure documentation for the most up-to-date list of compatible VMs before planning your storage strategy.  

- While Ultra Disks provide superior performance, they also have some constraints:  

    - Regional Availability: Ultra Disks aren't available in all Azure regions. You should check the Azure documentation or portal for the latest information on regional availability.
    - Snapshots are frequently used for backup purposes on Oracle installations on Azure. Currently, snapshots for ultra disks are available as a public preview and only in Sweden Central and US West 3, they aren't available in any other region.
    - No Direct Support for Availability Sets or Azure Disk Encryption: Ultra Disks don't support Availability Sets or Azure Disk Encryption, so you may need to consider other options for high availability and encryption. The only infrastructure redundancy options currently available to ultra disks are availability zones. VMs using any other redundancy options can't attach an ultra disk.
    - Price: Due to their high performance, Ultra Disks are also priced higher than other disk types. Therefore, you should carefully evaluate your application requirements and budget before choosing Ultra Disks.  

Azure ultra disks offer up to 32 TiB per region per subscription by default, but ultra disks support higher capacity by request.

- [Premium SSD](https://learn.microsoft.com/azure/virtual-machines/disks-types): Good fit for most production workloads that require consistent performance and high availability.

    - Balanced Performance: Premium SSDs offer a balanced performance profile, with lower latency and higher throughput than Standard SSDs. They can achieve up to 20,000 I/O operations per second (IOPS) per disk.
    - Consistent Performance: Premium SSDs deliver consistent performance, ensuring that our applications run smoothly even under heavy load. 
    - Durability and Availability: Azure guarantees that Premium SSDs have at least 99.9% availability, providing the reliability you need for your business-critical applications. 
    - VM compatibility: Premium SSDs are compatible with DS-series, DSv2-series, GS-series, and Fs-series Azure VMs, among others. As always, check the Azure documentation for the most up-to-date list of compatible VMs. 

While Premium SSDs offer reliable and consistent performance, there are a few constraints: 

   - Cost: While not as expensive as Ultra Disks, Premium SSDs are more costly than Standard SSDs or HDDs. Carefully evaluate your budget and performance requirements before selecting Premium SSDs.
   - Size and Performance Dependency: The size of the disk determines the performance of a Premium SSD in terms of IOPS and throughput. If you need more IOPS or throughput, you need to provision a larger disk, which could lead to unused capacity.
   - Regional Availability: Most Azure regions support Premium SSDs, but always verify the availability in your desired region.  
   - VM Limits: It's important to note that the use of managed disks in Azure VMs is subject to certain limitations. These constraints include the maximum number of disks a VM can have, and the total amount of uncached data that can be processed 
- ANF-files 

    - Performance: NetApp's storage solutions are known for their high performance, which can significantly enhance Oracle database operations. With features like high IOPS and low latency, NetApp can handle the demanding workloads of Oracle databases. 
    - Data Protection and Recovery: NetApp provides efficient and flexible data protection solutions, such as SnapMirror for data replication and SnapVault for backups. These features work well with Oracle databases, ensuring your data is well protected and easily recoverable.
    - Flexibility and Scalability: NetApp's data fabric strategy provides a unified and integrated approach to manage data across different cloud environments. It allows Oracle workloads to seamlessly move and scale across on-premises and Azure environments.
    - Efficient storage utilization: With features like data de-duplication, compression, and thin provisioning, NetApp offers efficient storage utilization. This can lead to significant cost savings for businesses running Oracle databases.
    - Oracle Certification: NetApp solutions are Oracle-certified, meaning they have been tested and verified to work efficiently with Oracle products. This gives businesses confidence in the compatibility and performance of the combined solution.  

When integrated with Oracle IaaS on Azure, NetApp can deliver a powerful, flexible, and efficient data management solution that can handle the demands of modern businesses.

## Storage metrics

| Workload type         | Premium SSD | Ultra Disk                      | Azure NetApp (ANF) |
| --------------------- | ----------- | ------------------------------- | ------------------ |
| IO up to 750 MBPs     | yes         | *Rarely used, no cost effective | yes                |
| IO up to 2000 MBPS    | No          | Yes                             | Yes                |
| IO up to 5000 MBPS    | No          | no                              | Yes                |
| Regional Availability | No          | Yes                             | Yes                |
| Non-AZ deployment     | No          | Yes                             | No                 |
| Thin Snapshots        | Yes         | Private preview                 | yes                |
|     Storage Scaling                   | Supported                    |

## Next steps

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting Oracle in Azure.

[Network topology and connectivity for Oracle on Azure IaaS](oracle-network-topology.md)

[Security guidelines for Oracle on Azure IaaS](oracle-security-guideline-landing-zone.md).

[Business continuity and disaster recovery (BCDR) for Oracle on Azure IaaS](oracle-disaster-recovery-iaas.md)
