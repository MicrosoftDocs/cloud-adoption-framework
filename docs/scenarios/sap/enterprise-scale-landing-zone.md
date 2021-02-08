---
title: "Enterprise-Scale support for SAP on Azure Construction Set"
description: Describe how enterprise-scale can accelerate adoption of SAP
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise Scale support for SAP on Azure Construction Set
  
Enterprise scale Construction Sets provide specific architectural approach and reference implementation that enables effective construction and operationalization of platform workload landing zones within the Cloud Adoption Framework Enterprise scale landing zone. The SAP on Azure Construction Set are implementations for after a customer has successfully implemented Enterprise scale landing zone. Please review the enterprise scale [Overview](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/) and [implementation guidance](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) before deploying the SAP on Azure construction set.

## Should I start with SAP on Azure Construction Set?

Not all customers adopt SAP on Azure in the same way, so the Cloud Adoption Framework for Azure enterprise-scale SAP on Azure Construction set architecture varies between customers. The technical considerations and design recommendations of the SAP on Azure Construction Set might lead to different trade-offs based on your organization's scenario. Some variation is expected, but if you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale. The SAP on Azure Construction Set is modular by design so customers can customized environmental variables. The construction set approach to landing zones includes three sets of assets to support cloud teams:

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

![Responsibility Zones](media\Overview_Architecture.png)

## Implementation

SAP Deployment Automation Framework is a collection of processes and a flexible workflow to automate the deployment of SAP on Azure. 

This Github repository contains code that can be used to automatically deploy SAP landscapes in the Azure Cloud.

The templates are split into:
Terraform modules which deploy the infrastructure components (such as VMs, network, storage) in Azure.
Ansible playbooks which run different roles to configure and VMs and install SAP HANA and required applications on the already deployed infrastructure.

Github repo
[Automated SAP Deployments in Azure Cloud](https://github.com/Azure/sap-hana/tree/beta/v2.3) 

![Responsibility Zones](media\Overview_Automation.png)

## Next steps
Review the SAP on Azure Construction Set critical design areas to make complete considerations and recommendations for your SAP on Azure Construction set architecture. [Identity and Access Management](./eslz-identity-and-access-management.md)
