---
title: Manage workloads that run on Azure Stack Hub
description: Learn how to manage workloads running on Azure Stack Hub.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Manage workloads that run on Azure Stack Hub

Operations and management of hybrid solutions across public and private cloud platforms is complex and could introduce risk to business operations. Because Azure Stack Hub is your organization's private instance of Azure running in your datacenter, the risk of hybrid operations is greatly reduced.

As outlined in the [Manage methodology](../../manage/index.md) of the Cloud Adoption Framework, suggested operations management activities focus on the following list of core responsibilities. The same responsibilities hold true for the operations management teams that support Azure Stack Hub.

- **Inventory and visibility:** Create an inventory of assets across multiple clouds. Develop visibility into the run state of each asset.
- **Operational compliance:** Establish controls and processes to ensure that each state is properly configured and running in a well-governed environment.
- **Protect and recover:** Ensure that all managed assets are protected and can be recovered by using baseline management tooling.
- **Enhanced baseline options:** Evaluate common additions to the baseline that might meet business needs.
- **Platform operations:** Extend the management baseline with a well-defined service catalog and centrally managed platforms.
- **Workload operations:** Extend the management baseline to include a focus on mission-critical workloads.

## Considerations for Azure Stack Hub operations management

Some of the standard operations management activities require slightly different technical considerations. The following articles outline those considerations.

- [Self-service support](https://azure.microsoft.com/blog/azure-stack-iaas-part-five/) for your customers, including boot diagnostics, screenshots, serial logs, and metrics.
- [Guest management](https://azure.microsoft.com/blog/azure-stack-iaas-part-one/), including virtual machine (VM) extensions, the ability to run custom code, software inventory, and change tracking.
- [Business continuity](https://azure.microsoft.com/blog/azure-stack-iaas-part-four/) through VM backups and disaster recovery options.

## Next steps

After your Azure Stack Hub migration reaches an operational state, you can begin the next iteration of migrations by using Azure Stack Hub or other migration scenarios in the Azure public cloud.

- [Plan for Azure Stack Hub migrations](./plan.md)
- [Environmental readiness](./ready.md)
- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
