---
title: "AKS Enterprise-scale storage"
description: AKS Guidelines for Enterprise-scale storage
author: gbowerman
ms.author: guybo
ms.date: 08/30/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# AKS Enterprise-scale storage


## Design considerations

Consider the following factors:

- Will your application need to manage secrets (e.g. use Azure Keyvault CSI integration)

- Are stateful workloads required.

- Multi write-read applications are considered.

- Consider performance characteristics and how this relates to premium storage.

- Decide the VM type corresponding to the supported disks needed. 

- consider the different HW resources for different type of applications and whether to use Node pools.

- Consider creating Storage classes and whether retain policies are needed.

- If NFS is needed and Performance is a must consider using Azure NetApp Files

- Choose the appropriate storage type: Azure Disks, Azure Files, 3rd party

## Design recommendations

The following are proven practices for your design:

- Azure Keyvault CSI integration is recommended

- If Stateful workloads are considered, prepare the dynamic storage Azure Disks or Azure Files 

- If multi-pod need to write-read in same storage. Support Azure Files or 3rd party as ANF - Azure NetApp Files 

- In most of the cases it is recommended to use Premium storage - SSD Based Storage

- Node pools

- Create Storage classes

