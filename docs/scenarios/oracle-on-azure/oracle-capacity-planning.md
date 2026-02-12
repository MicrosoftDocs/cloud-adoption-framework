---
title: Capacity Planning for Migrating Oracle Workloads to Azure Virtual Machines
description: Learn how capacity planning can help you select the appropriate infrastructure for Oracle workloads on Azure infrastructure as a service.
author: jessiehaessler
ms.author: jhaessler
ms.date: 06/24/2025
ms.topic: concept-article
ms.custom: UpdateFrequency2, e2e-oracle
---

# Capacity planning for migrating Oracle workloads to Azure Virtual Machines

This article builds on Cloud Adoption Framework for Azure guidance and covers infrastructure capacity planning for Oracle workloads on Microsoft Azure. This guidance includes recommendations and tools to support this planning process.

Capacity planning helps ensure efficient performance and cost management when you run Oracle database workloads on Azure. This article describes guidelines, methods, and tools to allocate resources efficiently, balance performance needs, and optimize costs. Your specific capacity requirements depend on the performance characteristics of the database workload. These characteristics are transactional, analytical, or mixed. Processing power, memory, and throughput typically constrain Oracle database workloads.

Capacity planning helps you select the appropriate infrastructure for Oracle architecture on Azure. To effectively implement this process, you must understand database storage capacity.

## Capacity planning considerations

Capacity planning for Oracle workloads on Azure infrastructure as a service (IaaS) requires understanding the workload requirements and available Azure resources.

### Overall performance considerations

- Use Oracle Automatic Workload Repository (AWR) reports to understand workload performance characteristics for migration. Your existing environment might not accurately measure Oracle database workload requirements on Azure. AWR reports contain performance statistics for Oracle database workloads.

- Use your existing environment to size application servers if AWR performance statistics aren't available. Collect performance metrics from application servers to properly size both application servers and platform as a service (PaaS) solutions.

  > [!NOTE]
  > To collect AWR reports, purchase the Oracle Diagnostic Pack license for your database workload. Use Statspack reports as an alternative to AWR reports. Statspack reports are a subset of AWR reports and don't require the Diagnostic Pack license.

- Collect AWR reports for your database workload in the following scenarios:

  - When the workload experiences peak load. If you don't know the peak load time, use the [busiest_awr script](https://github.com/Azure/Oracle-Workloads-for-Azure/blob/main/az-oracle-sizing/busiest_awr.sql) to determine the busiest AWR.
  
  - For timeframes that represent peak load, such as a month-end process. The time period should include only peak load times and exclude extended periods of low load. If you include periods of low load, the performance statistics represent an average and not the actual workload performance requirements.
  
  - For high-load activities, such as batch processing.
  
- Collect AWR reports during peak load and similar scenarios. To determine the appropriate virtual machine (VM) SKU and storage configuration, see [Sizing Azure resources based on an Oracle AWR report](https://aka.ms/oracle/azure-iaas-sizing). If you manage multiple Oracle database workloads and plan to consolidate several workloads on the same VMs, use the [Oracle Migration Assistant Tool (OMAT)](https://aka.ms/lza/oracle/omat). OMAT is an automated sizing-assessment tool that generates an infrastructure assessment based on AWR reports and provides suggestions for possible VM and storage configurations.

### Compute considerations

After you determine the basic performance requirements for the database workload, consider the following recommendations for VM planning:

- Use constrained cores to optimize Oracle licensing costs. Constrained cores provide the memory and throughput capacity of larger VM SKUs while limiting vCPU capacity to smaller VM SKUs. This configuration reduces Oracle licensing costs because licensing is based on processor cores. For more information, see [Licensing Oracle software in the cloud computing environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf) and [Constrained core sizes](/azure/virtual-machines/constrained-vcpu).

- Select memory-optimized VMs for Oracle workloads. These VMs provide a higher memory-to-vCPU ratio compared to general-purpose VMs. They're ideal for memory-intensive Oracle workloads. For more information, see [M-series VM](/azure/virtual-machines/sizes/memory-optimized/m-family).

- Use the latest VM SKUs to improve performance and compatibility. The latest VM SKUs, such as [Mdsv3](/azure/virtual-machines/sizes/memory-optimized/mdsv3-mm-series) and [Edsv6](/azure/virtual-machines/sizes/memory-optimized/edsv6-series), provide robust memory-optimized options. Choose between Medium Memory and High Memory variants based on your sizing assessment.

- Include multiple VMs for high availability and disaster recovery. Ensure that your architecture accounts for VMs required for high availability, disaster recovery, and nonproduction environments to maintain operational resilience.

### Storage considerations

Oracle database workload performance and reliability depend on the underlying storage infrastructure design and configuration. Consider the following guidance for storage planning:

- Select the appropriate managed disk type based on workload requirements. Use Azure Premium SSD for operating system-related activities to ensure reliable performance. For data disks, use Azure Premium SSD v2 for enhanced performance capabilities. Azure Ultra Disk Storage suits workloads that require extremely high throughput and low latency. Avoid Azure Standard SSD or Azure Standard HDD for production Oracle workloads. For more information, see [Azure managed disks](/azure/virtual-machines/disks-types).

  Other storage options include [Azure NetApp Files](/azure/architecture/example-scenario/file-storage/oracle-azure-netapp-files) and [Azure Elastic SAN](/azure/storage/elastic-san/elastic-san-introduction). 

- Monitor disk latency based on workload characteristics. For more information, see [Azure managed disk types](/azure/virtual-machines/disks-types#disk-type-comparison).

- Use multiple Premium SSD disks in a RAID-0 (striping) configuration if OS-related activities require more than 4 TB. Host disk caching isn't supported for disks larger than 4,095 GB. 

- Understand the differences between Premium SSD v1 and Premium SSD v2. Premium SSD v1 uses the original architecture in Azure. This architecture shares bandwidth with other VM traffic, which might affect performance. Premium SSD v2 uses Direct Drive architecture for improved performance and reduced latency. For more information, see [Differences between Premium SSD v1 and Premium SSD v2](/azure/virtual-machines/disks-types#differences-between-premium-ssd-and-premium-ssd-v2).

- Consider cumulative disk throughput when you use managed disks. The total throughput of all disks attached to the VM is limited by the VM SKU. For more information, see [VMs and disk performance](/azure/virtual-machines/disks-performance#disk-io-capping).

- Use network storage such as [Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-introduction) if throughput requirements exceed the maximum throughput of a single VM. In this configuration, the VM is constrained by network throughput, or egress, rather than disk throughput.

- Place Oracle temporary files on a VM SKU that has a temporary disk if you frequently use temporary files. This configuration reduces the input/output (I/O) load on the data disks.

## Next steps

- [Migration planning for Oracle on Azure](./oracle-migration-planning.md)
- [Performance best practices for Oracle on Azure VMs](/azure/virtual-machines/workloads/oracle/oracle-performance-best-practice)
