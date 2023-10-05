---
title: Capacity planning for Oracle on Azure
description: Learn about capacity planning for Oracle workloads on Azure IaaS.
author: Jfaurskov
ms.author: janfaurs
ms.date: 09/11/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, UpdateFrequency.5
---

# Capacity planning for Oracle Azure Landing Zone

This article extends the Azure cloud adoption framework by offering guidance on infrastructure capacity planning for Oracle workloads on Microsoft Azure. The article includes recommendations and tools to assist with this planning process.

Capacity planning is essential for achieving efficient performance and cost management when running Oracle database workloads on Azure. This article outlines guidelines, methods, and tools to accurately allocate resources, balancing performance needs and cost optimization. The specific capacity requirements depends on the performance characteristics of the database workload, whether it be transactional, analytical, or mixed. The constraining factors for Oracle database workloads are typically processing power, memory and throughput. This planning helps select the appropriate infrastructure and Oracle architecture on Azure, and understanding database storage capacity is a crucial component of this process

## Capacity planning considerations

Capacity planning for Oracle workloads on Azure IaaS is a process that requires a deep understanding of the workload requirements and the available Azure resources. The following are some of the key considerations for capacity planning:

### Overall performance considerations

- It's important to note that your existing environment may not serve as an accurate sizing measure for Oracle database workload requirements on Azure. Instead, you should use Oracle Automatic Workload Repository (AWR) reports to understand the performance characteristics of the workload or workloads to be migrated. AWRs contain performance statistics for you Oracle database workloads.
- For application servers, as there are no AWR performance statistics available, you can use the existing environment as a sizing measure. You should of course collect performance metrics from application servers to ensure that the application servers and/or any PaaS services are sized appropriately.

> Note that to be able to collect AWRs you need to have purchased the Oracle Diagnostic Pack license for your database workload. As an alternative to AWRs you can use Statspack reports. Statspack is a subset of AWRs and does not require the Diagnostic Pack license.

- When collecting AWRs for your database workload observe the following guidelines:
  - AWRs should be taken when the workload is experiencing peak load. If peak load time is not known, use the [busiest_awr script](https://github.com/Azure/Oracle-Workloads-for-Azure/blob/main/az-oracle-sizing/busiest_awr.sql) to determine the busiest AWR.
  - AWRs should be taken for a period of time that is representative of peak load. For example, if the peak load is a month-end process, then the AWR should be taken during the month-end process. Note that the time period should ideally be only the time period when peak load is experienced and should not stretch over extended periods of low load. If this is done the performance statistics will be averaged out and so will not be representative of actual workload performance requirements.
  - If there are batch processes or other activities which also constitute significant load on the database, AWRs for these activities should also be collected.
- When AWR reports reflecting peak load and similar scenarios have been collected, refer to the guidance in [Sizing Azure resources based on an Oracle AWR report](https://aka.ms/oracle/azure-iaas-sizing) to determine the appropriate VM SKU and storage configuration. Alternatively and/or if you have multiple Oracle database workloads and perhaps wish to co-locate some workloads on the same VMs, Microsoft has developed a tool to help analyze mulitple AWR reports and provide suggestions on possible VM and storage configurations. For more information, see [Oracle Migration Assistant Tool (OMAT)](https://aka.ms/lza/oracle/omat).

### Compute considerations

Once the basic performance requirements for the database workload has been determined, consider the following for VM planning:

- Leverage constrained cores if applicable. Constrained cores allow you to have the memory and throughput capacity of a larger VM SKU, with vCPU capacity of a smaller VM SKU. This is desirable from an Oracle licensing cost perspective, where Oracle licensing is based on processor cores. For more information on how Oracle licensing works on Azure, see [Licensing Oracle Software in the Cloud Computing Environmen](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf). For more information on constrained cores, see [Azure VM sizes](https://docs.microsoft.com/azure/virtual-machines/sizes).
- Use memory optimized VMs for Oracle workloads. Memory optimized VMs have a higher memory to vCPU ratio than general purpose VMs. This is desirable for Oracle workloads, which are typically memory intensive. For more information on memory optimized VMs, see [Azure VM sizes](https://learn.microsoft.com/azure/virtual-machines/sizes-memory).
- When considering your overall architecture include any additional VMs required for high availability, non-prod environments etc.

### Storage considerations

The performance and reliability of Oracle database workloads heavily rely on the design and configuration of the underlying storage infrastructure. The following are some of the key considerations for storage planning:

- If using managed disks use premium, premium v2 or ultra disk storage for Oracle workloads. Standard SSD or standard HDD are not recommended for production Oracle workloads. For detials on premium v2 and ultra disk limitations, see [Azure managed disks](https://docs.microsoft.com/azure/virtual-machines/disks-types).
- Disk latency may be a concern depending on the characteristics of your workload. For details on what to expect in terms of disk latency, see [Azure managed disk types](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types#disk-type-comparison).
- If using managed disks host disk caching should be configured to ReadOnly for data disks and None for redo log disks. In that respect it should be noted that host disk caching is not supported for disks larger than 4TiB as noted in [Frequently asked questions about Azure IaaS VM disks and managed and unmanaged premium disks](https://learn.microsoft.com/azure/virtual-machines/faq-for-disks?tabs=azure-portal#do-we-support-enabling-host-caching-on-all-disk-sizes-). If you require more disk space than 4 TiB for your database files, you should therefore create volumes (ASM, LVM or otherwise) built from multiple disks to achieve the required capacity.
- When using managed disks, disk throughput is determined by the cumulative throughput of all disks attached to the VM, constrained by the VM SKU. This is described in more detail in [Virtual machine and disk performance](https://learn.microsoft.com/azure/virtual-machines/disks-performance#disk-io-capping)
- When using managed disks with a write-intensive workload, consider using ultra disks for redo logs.
- If throughput requirements exceed the maximum throughput of a single VM, consider using network storage such as [Azure NetApp Files](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-introduction), as the VM is constrained on (egress) network throughput rather than disk throughput for such a configuration.
- If oracle temp files are heavily used, consider selecting a VM SKU with a temporary disk, and home the temp files on the temporary disk. This will reduce the I/O load on the data disks.

## Next steps

For details on how to migrate your workload once the appropriate capacity has been determined, see [Oracle database migration to Azure](https://learn.microsoft.com/azure/architecture/solution-ideas/articles/reference-architecture-for-oracle-database-migration-to-azure).
