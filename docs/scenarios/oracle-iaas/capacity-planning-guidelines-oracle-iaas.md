---
title: Capacity planning guidelines for Oracle on Azure VMs landing zone accelerator 
description: Learn about capacity planning guidelines for Oracle on Azure VMs landing zone accelerator. 
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

# Capacity planning guidelines for Oracle on Azure VMs landing zone accelerator

This article builds on several considerations and recommendations defined in the [Azure cloud adoption framework](https://learn.microsoft.com/azure/cloud-adoption-framework/adopt/cloud-adoption). Following the guidance, this article  provides you with the right guidelines for infrastructure capacity planning for your Oracle workloads on Microsoft Azure. Since Oracle is a mission-critical & high-performance workload, all the guidance on the Azure landing zone design areas should also be included in your design.

## Defining the capacity planning

Capacity planning plays a crucial role in ensuring optimal performance and cost efficiency for Oracle workloads running on Azure as Infrastructure as a Service (IaaS).  The article covers key guidelines, methodologies, and tools that can help organizations accurately assess and allocate resources to meet performance requirements while optimizing costs in terms of Azure and Oracle licensing. Your Oracle workloads capacity planning vary depending on the type of data that is processed, such as transactional workloads (OLTP), analytical processing and reporting or mixed workloads. Generally, Oracle databases require ample memory, data storage performance and CPU power. Capacity planning provides you guidelines to choose & scale your infrastructure as well deploy your Oracle workload selecting the right Oracle architecture on Azure. Knowing database storage capacity also key to plan capacity for Oracle on Azure IaaS. 

## Key guidelines for capacity planning

Capacity planning starts with the discovery of your existing Oracle workload – that is, describing every aspect of your Oracle workload. Describing the technical details of your Oracle workload is the key & basis for capacity planning to derive VM SKUs, configurations, & storage options. The available approach is to generate an automatic workload discovery report [AWR / Stats pack, will refer as AWR here onwards in this article] on your existing Oracle databases and then capture key parameters of your AWR report. You can use below SQL scripts with Admin privilege to get your AWR reports. 

``AWR: @$ORACLE_HOME/rdbms/admin/awrrpt.sql``

AWR reports should be taken from specific time periods that represent heavy usage times of the databases (such as peak hours, nightly backup and batch processing, or end of month processing etc.) The AWR based right sizing analysis takes all key performance indicators and provides a buffer for unexpected peaks during the calculation of required VM specifications.  

Capacity for Oracle on Azure fundamentally consists of VM SKU & Storage. We generally recommend the M and E series machines as the right VM SKUs for your Oracle Workload. 

Since your Oracle workload is usually licensed by processor core, selecting a VM with the least number of suitable cores provides the best licensing savings. Azure [constrained](https://learn.microsoft.com/azure/virtual-machines/constrained-vcpu) VMs are recommended for the majority of cases since they provide larger amounts of memory and IOPS capabilities while keeping the number of available cores at a reasonable level.  

Also, Azure VMs have capped value for IOPS, disk and network throughput. Considering the maximum number of disks supported by the VM, IOPS and MB/sec throughput per disk as well as overall capped values at VM level is important. The number of network interfaces supported for the VM is another point to consider.  

For storage, Azure provides multiple native and first party options. You can get the detailed guidance under storage to [select the right storage option](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-storage) from your selected VM SKU. Your Oracle hosting on Azure may require other Azure cloud capabilities like backup and recovery, networking, security etc. Please refer to the respective design guidelines for Oracle on Azure IaaS.

## Capacity planning methodologies

Before you determine the required VM size on Azure for Oracle workloads, you must carefully [analyze your database workloads by using AWR reports](https://github.com/Azure/Oracle-Workloads-for-Azure/tree/main/az-oracle-sizing) to determine the right VM size on Azure which will meet the workload performance requirements.

Don't take the hardware specifications of the existing, on-premises Oracle servers or appliances and map one-to-one to Azure VM specifications. Most Oracle environments are heavily oversized both from a hardware and Oracle licensing perspective to meet peak workloads and future growth. 

The output of the AWR based workload analysis indicates the required amount of memory, number of virtual cores, number, size, and type of disks, and number of network interfaces. However, it is still up to the user to decide on which Azure VM type to select among the [many that Azure offers](https://azure.microsoft.com/pricing/details/virtual-machines/series/).  

## Capacity planning tool

Analysing the AWR to arrive at capacity requirement is quite a time-consuming process. To simplify it, you can leverage OMAT – Oracle Migration to Azure Tool. OMAT will analyse your AWR reports and provide compute recommendations. 

Oracle Migration to Azure Tool takes multiple AWRs from different database instances, calculates the observed and target performance values and makes recommendations on appropriate Azure VM sizes and Azure Storage along with pricing. OMATalong with instructions are provided here. 

## Licensing guidelines 

When computing the Oracle license requirements for Azure, you must count two vCPUs as equivalent to one Oracle Processor license if multi-threading of processor cores is enabled; and one vCPU as equivalent to one Oracle Processor license if multi-threading of processor cores is not enabled. For more information see [Licensing Oracle Software in the Cloud Computing Environment](https://www.oracle.com/assets/cloud-licensing-070579.pdf).  

**Example**: Since the Intel core factor for on-premises systems is 0.5. Therefore an 8-core physical server requires 4 Oracle cores of licensing. In Azure, an 8-core VM (16 vCPUs Hyperthreaded or 8 vCPUs non-hyperthreaded) requires 8 Oracle cores of licensing. However, since most Oracle on-premises environments are oversized (usually purchased considering a time span of 5 to 7 years ahead), you can reduce the number of required cores on Azure by carefully analyzing the actual workloads (called “right sizing”) and what is actually required on Azure (not what you purchased from Oracle).   

## Service and architecture guidelines

Apart from VM SKUS and storage, you can plan for appropriate networking, security and backup solutions for your Oracle on Azure workloads. Oracle doesn't support RAC or Exadata on any other cloud including Azure. See Azure recommended [HA architecture](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-reference-architecture) for your deployment.

Microsoft Azure Well-Architected Framework has specific [architectural examples of Oracle workloads on Azure](https://learn.microsoft.com/azure/well-architected/oracle-iaas/overview).

## Scale guidelines 

So far you have discovered how to arrive the optimally sized Azure infrastructure for your Oracle on Azure. As your business grows, your Oracle workload storage capacity and performance expectations may grow, so you need to modify the Azure infrastructure.  

Also, you should continuously monitor the Oracle performance on Azure IaaS. A few guidelines to follow are: 

- VM CPU Usage - Monitoring 

- IOPS Monitoring: Linux Utility 

- AWR analysis on regular basis & repeat OMAT based sizing exercise /manual.

Inputs from your continuous monitoring solution can help scale your VMs & storage capacity based on the requirements – vertically.

## VM images for Oracle on Azure guidelines

[Azure Marketplace](https://ms.portal.azure.com/#view/Microsoft_Azure_Marketplace/MarketplaceOffersBlade/selectedMenuItemId/home) offers several virtual machine images from Oracle as well as its partners. These include images for Oracle Database 12 and up, several versions of Oracle Linux, Redhat Enterprise Linux as well as Oracle applications and Oracle related 3rd party solutions.  

By using the Oracle images from the Azure marketplace, you can convert your CAPEX license costs to OPEX. You can also bring your own custom virtual machine images to Azure as well.

## Next steps

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting Oracle in Azure.

[Network topology and connectivity for Oracle on Azure IaaS](oracle-network-topology.md)

[Security guidelines for Oracle on Azure IaaS](oracle-security-guideline-landing-zone.md).

[Business continuity and disaster recovery (BCDR) for Oracle on Azure IaaS](oracle-disaster-recovery-iaas.md)