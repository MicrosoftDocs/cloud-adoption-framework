---
title: Prepare for management
description: Learn how to prepare for management activities when migrating workloads to Azure with the Cloud Adoption Framework.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/01/2024
ms.topic: conceptual
---

As you begin to deploy your workloads for migration, you must make sure you're ready to complete management activities when the migration is complete. When organizations fail to plan for management, they often get replicated workloads that get delayed. Or worse, they migrate resources but don't manage them, creating outages, breaches, or performance issues.

As such, you should be preparing for management from the point you begin deploying resources to Azure for your workload.

The expectation of the broader Cloud Adoption Framework is that your organization has done general management planning and design as part of the [Management design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management), and are using tools like the [Azure Management Guide](/azure/cloud-adoption-framework/manage/azure-management-guide/) as part of the [Manage methodology](/azure/cloud-adoption-framework/manage/). (Cloud management - Cloud Adoption Framework | Microsoft Learn)

However, it's critical to confirm that your management framework is in place for each workload.

## Minimum management goals

This list covers minimum management goals you should prepare for each workload.

You should have a plan for:

- Appropriate logs are being collected by your logging system, like Log Analytics. Logs should include:
  - Activity Logs to observe changes and events on services.
  - Diagnostic Logs to collect metric and service specific logs.
  - System logs from migrated or newly created virtual machines.
- Deployment of both general alerts based on organizational standards, and alerts for your workload.
- Backup configurations and processes that allow you to restore state in line with your organization’s SLAs.
- BCDR configuration that allows you to fail over and restore service in line with your organization’s SLAs.
- Enrollment in the Defender for Cloud policies selected by your organization, to perform security posture management and vulnerability detection.
  - This might include the deployment of vulnerability detection services or the Defender for Endpoint agent.
- Enablement of serial console in Azure VMs to help with troubleshooting.
- Configuration of auto shutdown schedules for VMs that meet business requirements.
- Deployment of tags and remediation of incorrect tags.
- The periodic update of virtual machines, such as with Azure Update Manager.

If you identify a missing management goal, you should had it to your remediation plan for the workload.

## Organizing transition to management

In addition, you should make sure of the following:

- The application owners are aware of any changes to activities, such as deployment of code or installation of modules, to the servers being migrated.

That the teams responsible for monitoring, management, and security are aware of changes and responsibilities after the migration.

That all teams understand their responsibilities during the migration itself.

## Next steps

> [!div class="nextstepaction"]
> [Migration testing](./migration-testing.md)