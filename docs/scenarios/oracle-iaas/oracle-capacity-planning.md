---
title: Capacity planning for Oracle on Azure
description: Learn how capacity planning can help you select the appropriate infrastructure for Oracle workloads on Azure IaaS.
author: Jfaurskov
ms.author: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Capacity planning for migrating Oracle workloads to Azure

This article builds on Azure Cloud Adoption Framework guidance and provides considerations about infrastructure capacity planning for Oracle workloads on Microsoft Azure. The article includes recommendations and tools to assist you with this planning process.

Capacity planning is essential for efficient performance and cost management when you run Oracle database workloads on Azure. This article describes guidelines, methods, and tools to accurately allocate resources, balance performance needs, and optimize costs. The specific capacity requirements depend on the performance characteristics of the database workload. These characteristics are transactional, analytical, or mixed. The constraining factors for Oracle database workloads are typically processing power, memory, and throughput.

Capacity planning helps you select the appropriate infrastructure for Oracle architecture on Azure. You must understand database storage capacity to effectively implement this process.

## Capacity planning considerations

Capacity planning for Oracle workloads on Azure infrastructure as a service (IaaS) is a process that requires a deep understanding of the workload requirements and the available Azure resources.

> [!NOTE]
> The following considerations are for Oracle databases that run on Azure virtual machines. For Oracle Database@Azure, [reach out to your local Oracle sales team](https://www.oracle.com/cloud/azure/oracle-database-at-azure/) for sizing guidance.

### Overall performance considerations

- Your existing environment might not serve as an accurate sizing measure for Oracle database workload requirements on Azure. Use Oracle Automatic Workload Repository (AWR) reports to understand the performance characteristics of the workload or workloads for migration. AWR reports contain performance statistics for your Oracle database workloads.

- You can use your existing environment as a sizing measure for application servers when there are no AWR performance statistics available. You should collect performance metrics from application servers to ensure that the application servers and any platform as a service (PaaS) solutions are sized appropriately.

  > [!NOTE]
  > To collect AWR reports, you need to purchase the Oracle Diagnostic Pack license for your database workload. You can use Statspack reports as an alternative to AWR reports. Statspack reports are a subset of AWR reports and don't require the Diagnostic Pack license.

- Collect AWR reports for your database workload:

  - When the workload experiences peak load. If you don't know the peak load time, use the [`busiest_awr` script](https://github.com/Azure/Oracle-Workloads-for-Azure/blob/main/az-oracle-sizing/busiest_awr.sql) to determine the busiest AWR.
  
  - For a period that's representative of peak load. For example, generate the AWR report during the month-end process if the peak load is a month-end process. The time period should include only peak load times and exclude extended periods of low load. If you include periods of low load in your AWR report, the performance statistics represent an average and not the actual workload performance requirements.
  
  - For activities such as batch processes or other activities that constitute significant load on the database.
  
- Collect AWR reports during peak load and similar scenarios. To determine the appropriate virtual machine (VM) SKU and storage configuration, see [Sizing Azure resources based on an Oracle AWR report](https://aka.ms/oracle/azure-iaas-sizing). If you manage multiple Oracle database workloads and are considering consolidating several workloads on the same VMs, use [Oracle Migration Assistant Tool (OMAT)](https://aka.ms/lza/oracle/omat). OMAT is an automated sizing-assessment tool that generates an infrastructure assessment based on AWR reports and provides suggestions for possible VM and storage configurations.

### Compute considerations

After you determine the basic performance requirements for the database workload, consider the following recommendations for VM planning:

- Use constrained cores if applicable. Constrained cores provide the memory and throughput capacity of a larger VM SKU with vCPU capacity of a smaller VM SKU. Constrained cores are preferable from an Oracle licensing cost perspective because Oracle licensing is based on processor cores. For more information about how Oracle licensing works on Azure, see [Licensing Oracle software in the cloud computing environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf). For more information about constrained cores, see [Azure VM sizes](/azure/virtual-machines/sizes).

- Use memory-optimized VMs for Oracle workloads. Memory-optimized VMs have a higher memory to vCPU ratio than general purpose VMs. These VMs are preferred for Oracle workloads, which are typically memory intensive. For more information about memory-optimized VMs, see [Memory-optimized VM sizes](/azure/virtual-machines/sizes-memory).

- When you evaluate your overall architecture, include other VMs that are required for high availability, nonproduction environments, and more.

### Storage considerations

The performance and reliability of Oracle database workloads rely heavily on the design and configuration of the underlying storage infrastructure. Consider the following guidance for storage planning:

- If you use managed disks, make sure to use Azure Premium SSD, Azure Premium SSD v2, or Azure Ultra Disk Storage for Oracle workloads. We don't recommend Azure Standard SSD or Azure Standard HDD for production Oracle workloads. For details about Premium v2 SSD and Ultra Disk Storage limitations, see [Azure managed disks](/azure/virtual-machines/disks-types).

- Disk latency might be a concern depending on the characteristics of your workload. For more information about disk latency, see [Azure managed disk types](/azure/virtual-machines/disks-types#disk-type-comparison).

- If you use Premium SSD, configure host caching to `ReadOnly` for all data disks and to `ReadWrite` for the OSDisk class. Host disk caching isn't supported for disks larger than 4,095 GB. To create volumes that are larger than a P50 parameter, or 4 TB, allocate multiple Premium SSD disks to build RAID-0 striped logical volumes. Use a volume manager such as Linux Logical Volume Manger version 2 (LVM2), or allocate multiple Premium SSD disks to build Oracle automatic storage management (ASM) disk groups to meet your desired capacity or required throughput.

- When you use managed disks, the cumulative throughput of all disks attached to the VM and constrained by the VM SKU determine the disk throughput. For more information, see [Virtual machines and disk performance](/azure/virtual-machines/disks-performance#disk-io-capping).

- When you use managed disks with a write-intensive workload, consider using Ultra Disk Storage for redo logs.

- If throughput requirements exceed the maximum throughput of a single VM, consider using network storage such as [Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-introduction) because the VM is constrained on network throughput, or egress, rather than disk throughput for such a configuration.

- If you use Oracle temporary files frequently, consider selecting a VM SKU with a temporary disk and place the temporary files on the temporary disk. This configuration reduces the input/output (I/O) load on the data disks.

## Next steps

- [Migration planning for Oracle on Azure](./oracle-migration-planning.md)
- [Performance best practices for Oracle on Azure VMs](/azure/virtual-machines/workloads/oracle/oracle-performance-best-practice)
