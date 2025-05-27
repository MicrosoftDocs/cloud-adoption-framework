---
title: Business continuity and disaster recovery for cloud-scale analytics
description: Learn how this scenario can improve business continuity and disaster recovery for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Business continuity and disaster recovery for cloud-scale analytics

When you design architecture for a cloud service, consider your availability requirements and how to respond to potential interruptions in the service. An issue could be localized to the specific instance or region-wide. Having plans for both is important. Depending on your recovery time objective and the recovery point objective, you might choose an aggressive strategy for high availability and disaster recovery.

High availability and disaster recovery can sometimes be combined. The two areas have slightly different strategies, especially when it comes to data. To learn more, see the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) and its [reliability principles](/azure/architecture/framework/resiliency/principles).

Instead of trying to prevent failures, accept up front that failures can and do happen. Minimize the effects of any single failing component in the lifecycle. Your tolerance for cost, recovery point objective, and recovery time objective determine the type of solution to implement.

## Backup strategies

Many alternative strategies are available for implementing distributed compute across regions. Strategies must be tailored to business requirements and circumstances of your application. At a high level, the approaches fall into the following categories:

- **Backup and restore:** Restore the database application from the last backup copy before the disaster. This approach is commonly used following data corruption or accidental deletion.
- **Redeploy on disaster:** Redeploy the application from scratch at the time of disaster. This approach is appropriate for noncritical applications that don't require a guaranteed recovery time.
- **Warm spare (active/passive):** Create a secondary hosted service in an alternate region. Deploy roles to guarantee minimal capacity. The roles don't receive production traffic. This approach is useful for applications that aren't designed to distribute traffic across regions.
- **Hot spare (active/active):** Design the application to receive production load in multiple regions. You might configure the cloud services in each region for higher capacity than required for disaster recovery purposes. Instead, you could scale out the cloud services as necessary at the time of a disaster and failover.

  This approach requires investment in application design, but has benefits. It offers low and guaranteed recovery time. There's continuous testing of all recovery locations and efficient usage of capacity. For database applications, this approach includes a load balancer for two databases that synchronize with a single connection point.

## Disaster recovery and high availability for Azure services

Cloud Scale Analytics is made of several Azure services which are grouped into platform, core, and data. For more information on service specific reliability guides and disaster recovery, see [Azure reliability documentation](/azure/reliability/)

## Next steps

- [Data Governance Overview](govern.md)
