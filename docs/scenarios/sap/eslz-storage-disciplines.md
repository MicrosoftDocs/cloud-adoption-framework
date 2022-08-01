---
title: Storage disciplines for SAP on Azure
description: Learn more about storage design options for SAP on Azure
author: jhajduk-microsoft
ms.author: jhajduk-microsoft
ms.date: 08/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# Azure storage types
When running SAP on Azure virtual machines, it is important to understand each layer of how the application will run, including storage configurations. Below are design considerations for designing storage configurations for you SAP VMs. The design for SAP on Azure storage is intended keep latency to a minimum and maximize throughput. You will have to consider your specific implementation and how the guidance below can help make architectural decisions for your SAP on Azure implementation. Please take time to read the SAP notes within the documentation and become familiar with [Azure Storage Types](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/planning-guide-storage)

# Storage Configurations for SAP HANA on virtual machines
SAP HANA on Azure should be run on only the types of storage that are certified by SAP. Please take note that certain volumes must be run on certain disk configurations, including enable Write Accelerator and choosing Premium storage, where applicable. Another consideration is to ensure that the filesystem that will run on the chosen storage needs to be compatible with the DBMS that will run on the machine. Please see [Storage Configurations for SAP HANA](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-vm-operations-storage) for more information and ensure that you examine the SAP notes.

# Azure NetApp Files for SAP HANA on virtual machines
An option for NFS shares when running SAP on Azure is to use Azure NetApp Files. ANF has its own throughput and sizing considerations. Please see the information regarding [Azure NetApp Files for SAP virtual machine](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-vm-operations-netapp)

