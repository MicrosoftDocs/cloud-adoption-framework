---
title: Capacity planning for Oracle on Azure
description: Learn about capacity planning for Oracle workloads on Azure IaaS.
author: Jfaurskov
ms.author: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Capacity planning for migrating Oracle workloads to Azure landing zones

This article extends the Azure cloud adoption framework by offering guidance on infrastructure capacity planning for Oracle workloads on Microsoft Azure. The article includes recommendations and tools to assist with this planning process.

Capacity planning is essential for efficient performance and cost management when running Oracle database workloads on Azure. This article describes guidelines, methods, and tools to accurately allocate resources, balance performance needs, and optimize costs. The specific capacity requirements depend on the performance characteristics of the database workload. These characteristics are transactional, analytical, or mixed. The constraining factors for Oracle database workloads are typically processing power, memory, and throughput. Capacity planning helps you select the appropriate infrastructure for Oracle architecture on Azure. Understanding database storage capacity is a crucial component of this process.

## Capacity planning considerations

Capacity planning for Oracle workloads on Azure IaaS is a process that requires a deep understanding of the workload requirements and the available Azure resources. The following are several key considerations for capacity planning:

> [!NOTE]
> The following considerations are for Oracle databases running on Azure virtual machines. For Oracle Database@Azure, reach out to your local Oracle sales team for sizing guidance.

### Overall performance considerations

- It's important to note that your existing environment might not serve as an accurate sizing measure for Oracle database workload requirements on Azure. Use Oracle Automatic Workload Repository (AWR) reports to understand the performance characteristics of the workload or workloads for migration. AWRs contain performance statistics for your Oracle database workloads.

- You can use the existing environment as a sizing measure for application servers because there are no AWR performance statistics available. You should collect performance metrics from application servers to ensure that the application servers and any platform as a service (PaaS) services are sized appropriately.

> [!NOTE]
> To collect AWRs, you need to purchase the Oracle Diagnostic Pack license for your database workload. You can use Statspack reports as an alternative to AWRs. Statspack is a subset of AWRs and does not require the Diagnostic Pack license.

- Observe the following guidelines when you collect AWRs for your database workload:

  - Collect AWR reports when the workload is experiencing peak load. If peak load time isn't known, use the [busiest_awr script](https://github.com/Azure/Oracle-Workloads-for-Azure/blob/main/az-oracle-sizing/busiest_awr.sql) to determine the busiest AWR.
  
  - Collect AWR reports for a period that's representative of peak load. For example, take the AWR report during the month-end process if the peak load is a month-end process. The time period should only include peak load times and exclude extended periods of low load. If you include periods of low load in your AWR report, the performance statistics represent an average and not the actual workload performance requirements.
  
  - If there are batch processes or other activities that constitute significant load on the database, collect AWRs for these activities.
  
- Collect AWR reports during peak load and similar scenarios, and use the guidance in [Sizing Azure resources based on an Oracle AWR report](https://aka.ms/oracle/azure-iaas-sizing) to determine the appropriate virtual machine (VM) SKU and storage configuration. If you're managing multiple Oracle database workloads and are considering consolidating several on the same VMs, use the [Oracle Migration Assistant Tool (OMAT)](https://aka.ms/lza/oracle/omat). OMAT is an automated sizing assessment tool that generates an infrastructure assessment based on AWR reports and provides suggestions for possible VM and storage configurations.

### Compute considerations

After you determine the basic performance requirements for the database workload, consider the following recommendations for VM planning:

- Use constrained cores if applicable. Constrained cores allow you to have the memory and throughput capacity of a larger VM SKU, with vCPU capacity of a smaller VM SKU. Constrained cores are preferable from an Oracle licensing cost perspective because Oracle licensing is based on processor cores. For more information about how Oracle licensing works on Azure, see [Licensing Oracle Software in the Cloud Computing Environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf). For more information about constrained cores, see [Azure VM sizes](/azure/virtual-machines/sizes).

- Use memory-optimized VMs for Oracle workloads. Memory-optimized VMs have a higher memory to vCPU ratio than general purpose VMs. These VMs are preferred for Oracle workloads, which are typically memory intensive. For more information about memory-optimized VMs, see [Azure VM sizes](/azure/virtual-machines/sizes-memory).

- When you evaluate your overall architecture, include any other VMs required for high availability, nonproduction environments, and more.

### Storage considerations

The performance and reliability of Oracle database workloads heavily rely on the design and configuration of the underlying storage infrastructure. The following are several key considerations for storage planning:

- If you use managed disks, make sure to use premium, premium v2, or ultra disk storage for Oracle workloads. Standard SSD or standard HDD isn't recommended for production Oracle workloads. For details on premium v2 and ultra disk limitations, see [Azure managed disks](/azure/virtual-machines/disks-types).

- Disk latency might be a concern depending on the characteristics of your workload. For more information about disk latency, see [Azure managed disk types](/azure/virtual-machines/disks-types#disk-type-comparison).

- If you use premium SSD, configure host-caching to ReadOnly for all data disks and to ReadWrite for the OsDisk. Note that host disk caching isn't supported for disks larger than 4,095 GB. To create volumes that are larger than a P50 (such as a 4 TB), allocate multiple premium SSD disks to build RAID-0 striped logical volumes. Use a volume manager such as Linux LVM2, or allocate multiple premium SSD disks to build Oracle ASM diskgroups to meet desired capacity or required throughput.

- When you use managed disks, the cumulative throughput of all disks attached to the VM and constrained by the VM SKU determine disk throughput. For more information, see [Virtual machine and disk performance](/azure/virtual-machines/disks-performance#disk-io-capping).

- When you use managed disks with a write-intensive workload, consider using ultra disks for redo logs.

- If throughput requirements exceed the maximum throughput of a single VM, consider using network storage such as [Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-introduction) because the VM is constrained on (egress) network throughput rather than disk throughput for such a configuration.

- If Oracle temporary files are heavily used, consider selecting a VM SKU with a temporary disk and home the temporary files on the temporary disk. This configuration reduces the input output (I/O) load on the data disks.

## Next steps

- [Migration planning for Oracle on Azure](./oracle-migration-planning.md)
- [Performance best practices for Oracle on Azure VMs](/azure/virtual-machines/workloads/oracle/oracle-performance-best-practice)
