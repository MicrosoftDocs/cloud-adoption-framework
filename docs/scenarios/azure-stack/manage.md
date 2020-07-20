---
title: "Manage workloads running on Azure Stack Hub"
description: Learn how to manage workloads running on Azure Stack Hub.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Manage workloads running on Azure Stack Hub

Operations and management of hybrid solutions across public and private cloud platforms is complex and could introduce risk to business operations. Since Azure Stack Hub is your own private instance of Azure running in your datacenter, the risk of hybrid operations is greatly reduced.

As outlined in the [manage methodology](../../manage/index.md) of the Cloud Adoption Framework, suggested operations management activities focus on the following list of core responsibilities. Those same responsibilities hold true to the operations management teams supporting Azure Stack Hub.

- **Inventory and visibility:** Create an inventory of assets across multiple clouds. Develop visibility into the run state of each asset.
- **Operational compliance:** Establish controls and processes to ensure each state is properly configured and running in a well-governed environment.
- **Protect and recover:** Ensure all managed assets are protected and can be recovered using baseline management tooling.
- **Enhanced baseline options:** Evaluate common additions to the baseline that might meet business needs.
- **Platform operations:** Extend the management baseline with a well-defined service catalog and centrally managed platforms.
- **Workload operations:** Extend the management baseline to include a focus on mission-critical workloads.

## Azure Stack Hub operations management considerations

Some of the standard operations management activities require slightly different technical considerations. The following articles outline those consideration.

- [Self-service support](https://azure.microsoft.com/blog/azure-stack-iaas-part-five/) for your customers, including boot diagnostics, screenshots, serial logs, and metrics.
- [Guest management](https://azure.microsoft.com/blog/azure-stack-iaas-part-one/), including VM extensions, the ability to run custom code, software inventory, and change tracking.
- [Business continuity](https://azure.microsoft.com/blog/azure-stack-iaas-part-four/) through VM backups and disaster recovery options.

## Next step: Integrate this strategy into your cloud adoption journey

Once your Azure Stack Hub migration reaches an operational state, you can begin the next iteration of migrations using Azure Stack Hub or other migration scenarios in Azure's public cloud.

- [Planning for Azure Stack Hub migrations](./plan.md)
- [Environmental readiness](./ready.md)
- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
