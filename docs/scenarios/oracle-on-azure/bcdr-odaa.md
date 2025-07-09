---
title: Business continuity and disaster recovery for Oracle Database@Azure
description: Learn about key migration connectivity design considerations and detailed recommendations for Oracle Database@Azure, including best practices.
author: onursenturk
ms.author: onursenturk
ms.date: 07/08/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Business continuity and disaster recovery for Oracle Database@Azure


This article expands on the business continuity and disaster recovery (BCDR) considerations and recommendations described in the [Azure landing zone design area](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). It incorporates the [Oracle Maximum Availability Architecture (MAA)](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/db-azure1.html#GUID-E8360630-A2B8-4A46-9CBF-56EF0BF8A00F) principles for Oracle Database@Azure by using Oracle Exadata Database Service.

The first step to building a resilient architecture for your Oracle databases that run on Oracle Database@Azure is to identify the availability requirements for the solution. It's crucial to establish the recovery time objective (RTO) and recovery point objective (RPO) for different levels of failures, including planned and unplanned events. The RTO defines the maximum downtime that an application or business can tolerate after a disruption. The RPO specifies the maximum duration of data loss that an application or business can tolerate. You should address this prerequisite before you start your BCDR design. After you establish the requirements of your solution, you can design your Oracle Database@Azure environment to align with your RTO and RPO.

For more information, see the Microsoft Azure Well-Architected Framework's guidelines about how to [design a DR strategy](/azure/well-architected/reliability/disaster-recovery).

This page provides business continuity and disaster recovery planning guidance for the two service offerings available under Oracle Database@Azure: Exadata Database Services and Autonomous Database Services. For detailed, service-specific considerations and recommendations—including high availability, backup strategies, failover mechanisms, and disaster recovery configurations—refer to the articles in the table below. These resources offer targeted guidance to help you design resilient deployments and align with best practices for minimizing downtime and data loss.

| Design area                 | Objective                                                                                                                                                |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [Exadata Database Service](oracle-disaster-recovery-oracle-database-azure-exadata.md)            | Understand the business continuity and disaster recovery for Oracle Exadata Database@Azure.                                                        |
| [Autonomous Database](oracle-disaster-recovery-oracle-database-azure-autonomous.md)            | Understand the business continuity and disaster recovery for Oracle Autonomous Database@Azure.                                                        |

