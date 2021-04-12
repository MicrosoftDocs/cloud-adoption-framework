---
title: "Enterprise-Scale support for Windows Virtual Desktop"
description: Describe how enterprise-scale can accelerate adoption of Windows Virtual Desktop
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise Scale support for Windows Virtual Desktop Construction Set
  
Enterprise scale Construction Sets provide specific architectural approach and reference implementation that enables effective construction and operationalization of platform workload landing zones within the Cloud Adoption Framework Enterprise scale landing zone. The Windows Virtual Desktop Construction Set are implementations for after a customer has successfully implemented Enterprise scale landing zone. Please review the enterprise scale [Overview](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/) and [implementation guidance](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) before deploying the Windows Virtual Desktop construction set.

## Should I start with Windows Virtual Desktop Construction Set?

Not all customers adopt Windows Virtual Desktop on Azure in the same way, so the Cloud Adoption Framework for Azure enterprise-scale Construction set architecture varies between customers. The technical considerations and design recommendations of the Windows Virtual Desktop Construction Set might lead to different trade-offs based on your organization's scenario. Some variation is expected, but if you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale. The Windows Virtual Desktop Construction Set is modular by design so customers can customize environmental variables. The construction set approach to landing zones includes three sets of assets to support cloud teams:

## Design guidelines

Guide to the critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. There are 6 critical design areas:

- [Identity and Access Management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

## Architecture

Conceptual reference architecture that demonstrates design areas and best practices. example below

![Construction Set Architecture](media\windowsvirtualdesktoparchitecture.png)

## Implementation with ARM Templates for Remote Desktop Services

ARM WVD Templates is a collection of Infrastructure as Code ARM Tempplate to deploy a WVD enviorment on Azure. 

This Github repository contains code that can be used to automatically deploy WVD enviorments in the Azure Cloud.

Github repo
[Automate WVD Deployments in Azure Cloud](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates) 

## Next steps
Review the Windows Virtual Desktop Construction Set critical design areas to make complete considerations and recommendations for your Windows Virtual Desktop Construction set architecture. [Identity and Access Management](./eslz-identity-and-access-management.md)
