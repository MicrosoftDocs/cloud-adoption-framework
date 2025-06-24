---
title: Capacity Planning for Oracle Workloads on Azure Virtual Machines
description: Learn how capacity planning can help you select the appropriate infrastructure for Oracle workloads on Azure infrastructure as a service.
author: jessiehaessler
ms.author: jhaessler
ms.date: 06/24/2025
ms.topic: conceptual
ms.custom: UpdateFrequency2, e2e-oracle
---

# Capacity planning for migrating Oracle workloads to Azure Virtual Machines

This article builds on Azure Cloud Adoption Framework guidance and provides considerations about infrastructure capacity planning for Oracle workloads on Microsoft Azure. The article includes recommendations and tools to assist you with this planning process.

Capacity planning is essential for efficient performance and cost management when you run Oracle database workloads on Azure. This article describes guidelines, methods, and tools to accurately allocate resources, balance performance needs, and optimize costs. The specific capacity requirements depend on the performance characteristics of the database workload. These characteristics are transactional, analytical, or mixed. The constraining factors for Oracle database workloads are typically processing power, memory, and throughput.

Capacity planning helps you select the appropriate infrastructure for Oracle architecture on Azure. You must understand database storage capacity to effectively implement this process.

## Capacity planning considerations

Capacity planning for Oracle workloads on Azure infrastructure as a service (IaaS) is a process that requires a deep understanding of the workload requirements and the available Azure resources.

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

- Use constrained cores to optimize Oracle licensing costs. Constrained cores provide the memory and throughput capacity of larger VM SKUs while limiting vCPU capacity to smaller VM SKUs. This configuration reduces Oracle licensing costs, as licensing is based on processor cores. For more details, see [Licensing Oracle software in the cloud computing environment](https://www.oracle.com/us/corporate/pricing/cloud-licensing-070579.pdf) and [constrained core sizes](/azure/virtual-machines/constrained-vcpu?tabs=family-E).

- Select memory-optimized VMs for Oracle workloads. Memory-optimized VMs offer a higher memory-to-vCPU ratio compared to general-purpose VMs, making them ideal for memory-intensive Oracle workloads. For more information, see [M-series VM](/azure/virtual-machines/sizes/memory-optimized/m-family?tabs=mbsv3%2Cmsv3mm%2Cmsv3hm%2Cmsv2mm).

- Use the latest VM SKUs for improved performance and compatibility.** The latest VM SKUs, such as [Mdsv3](/azure/virtual-machines/sizes/memory-optimized/mdsv3-mm-series?tabs=sizebasic) and [Edsv6](/azure/virtual-machines/sizes/memory-optimized/edsv6-series?tabs=sizebasic), provide robust memory-optimized options. Choose between Medium Memory and High Memory variants based on your sizing assessment.

- Include additional VMs for high availability and disaster recovery. Ensure your architecture accounts for VMs required for high availability, disaster recovery, and non-production environments to maintain operational resilience.

### Storage considerations

The performance and reliability of Oracle database workloads rely heavily on the design and configuration of the underlying storage infrastructure. Consider the following guidance for storage planning:

- Select the appropriate managed disk type based on workload requirements. Use Azure Premium SSD for operating system-related activities to ensure reliable performance. For data disks, we recommend Azure Premium SSD v2 for enhanced performance capabilities. Azure Ultra Disk Storage is suitable for workloads requiring extremely high throughput and low latency. Avoid using Azure Standard SSD or Azure Standard HDD for production Oracle workloads. For more details, see [Azure managed disks](/azure/virtual-machines/disks-types).
Further Storage options include [Azure Netapp Files](/azure/architecture/example-scenario/file-storage/oracle-azure-netapp-files) and [ESAN](/azure/storage/elastic-san/elastic-san-introduction). 

- Disk latency might be a concern depending on the characteristics of your workload. For more information about disk latency, see [Azure managed disk types](/azure/virtual-machines/disks-types#disk-type-comparison).

- If your OS-related activities require larger than 4 TB use multiple Premium SSD disks and stripe it to RAID-0. Host disk caching isn't supported for disks larger than 4,095 GB. 

- Understand the differences between Premium SSD v1 and Premium SSD v2. Premium SSD v1 uses Azure’s original architecture, which shares bandwidth with other VM traffic and may impact performance. Premium SSD v2 leverages Direct Drive architecture for improved performance and reduced latency. For more details, see [differences between Premium SSD and Premium SSD v2](/azure/virtual-machines/disks-types#differences-between-premium-ssd-and-premium-ssd-v2).

- Consider cumulative disk throughput when using managed disks. The cumulative throughput of all disks attached to the VM is constrained by the VM SKU. For more information, see [Virtual machines and disk performance](/azure/virtual-machines/disks-performance#disk-io-capping).

- If throughput requirements exceed the maximum throughput of a single VM, consider using network storage such as [Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-introduction) because the VM is constrained on network throughput, or egress, rather than disk throughput for such a configuration.

- If you use Oracle temporary files frequently, consider selecting a VM SKU with a temporary disk and place the temporary files on the temporary disk. This configuration reduces the input/output (I/O) load on the data disks.

## Next steps

- [Migration planning for Oracle on Azure](./oracle-migration-planning.md)
- [Performance best practices for Oracle on Azure VMs](/azure/virtual-machines/workloads/oracle/oracle-performance-best-practice)
