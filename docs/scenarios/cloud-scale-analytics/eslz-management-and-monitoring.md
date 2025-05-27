---
title: Management and monitoring for cloud-scale analytics
description: Learn how this enterprise-scale scenario can improve management and monitoring for cloud-scale analytics in Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Management and monitoring

This article provides guidance about maintaining an Azure data analytics estate. It builds on considerations and recommendations of the Azure landing zones. For more information, see [Management and monitoring](../../ready/landing-zone/design-area/management.md).

## Design considerations

Here are some design considerations for data analytics on Azure monitoring and management:

- Consider a centralized Azure Log Analytics workspace with Azure Monitor and Application Insights for platform and application layer monitoring. For more information, see [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace).

- Consider whether individual data landing zones can query the centralized Log Analytics workspace with appropriate permissions. Each landing zone might also need its own Log Analytics workspace.

- Configure Azure Databricks to send monitoring information to Log Analytics. For more information, see [Monitoring Azure Databricks](/azure/architecture/databricks-monitoring/).

- Review sample queries. You can use some without modification or build on them for your own queries. For more information, see [Using queries in Azure Monitor Log Analytics](/azure/azure-monitor/logs/queries).

## Design recommendations

When evaluating cloud-scale analytics, consider the following design recommendations:

- Implement threat protection. For more information, see [Microsoft Sentinel](/azure/sentinel/overview).

- Monitor all services deployed in the data landing zone to a Log Analytics workspace.

- Use Azure Site Recovery to recover virtual machines that support mission-critical workloads. For more information, see [About Site Recovery](/azure/site-recovery/site-recovery-overview).

- In a data landing zone, all monitoring should be sent to the enterprise-scale management subscription for analysis.

## Next steps

- [Management and monitoring](../../ready/landing-zone/design-area/management.md)
- [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace)
- [Business continuity and disaster recovery](eslz-business-continuity-and-disaster-recovery.md)
