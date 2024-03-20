---
title: Prepare for management
description: Learn how to prepare for management activities when migrating workloads to Azure with the Cloud Adoption Framework.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/20/2024
ms.topic: conceptual
---

# Prepare for management

When a migration is complete, you must make sure you're ready to complete management activities. When organizations fail to plan for management, they often get replicated workloads that get delayed. Or worse, they migrate resources but don't manage them, creating outages, breaches, or performance issues.

> [!NOTE]
> The guidance in this article builds on the broader Cloud Adoption Framework management guidance. These additional guides might be relevant to build your management routines:
>
> - [Azure landing zones: Management design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management).
> - [Azure Management Guide](/azure/cloud-adoption-framework/manage/azure-management-guide/).
> - [CAF Manage methodology](/azure/cloud-adoption-framework/manage/).

Ensure you have a management routine in place for each workload.

## Minimum management goals

This list covers minimum management goals you should have planned and prepared for each workload:

- **Logs:** Appropriate logs are being collected by your logging system, like Log Analytics. Logs should include:
  - Activity Logs to observe changes and events on services.
  - Diagnostic Logs to collect metric and service specific logs.
  - System logs from migrated or newly created virtual machines.
- **Alerts deployment:** Deployment of both general alerts based on organizational standards, and alerts for your workload.
- **Backup:** Backup configurations and processes that allow you to restore state in line with your organization’s SLAs.
- **Business continuity and disaster recovery (BCDR):** A BCDR configuration that allows you to fail over and restore service in line with your organization’s SLAs.
- **Security posture:** Enrollment in the Defender for Cloud policies selected by your organization, to perform security posture management and vulnerability detection.
  - This might include the deployment of vulnerability detection services or the Defender for Endpoint agent.
- **Enable Serial Console:** Enablement of [Azure Serial Console](/troubleshoot/azure/virtual-machines/serial-console-overview) in Azure VMs to help with troubleshooting.
- **Enable Auto-shutdown:** Configuration of auto shutdown schedules for VMs that meet business requirements.
- **Tags:** Deployment of tags and remediation of incorrect tags.
- **Update management:** The periodic update of virtual machines, such as with Azure Update Manager.

If you identify a missing management goal, you should add it to your remediation plan for the workload.

## Organizing transition to management

To ensure a smooth transition to management for your migrated workloads, you should have a plan in place to ensure:

- **Involve application and workload owners:** Ensure the application owners are aware of any changes to activities, such as deployment of code or installation of modules, to the servers being migrated.
- **Involve monitoring, management, and security teams:** Ensure teams responsible for monitoring, management, and security are aware of changes and responsibilities after the migration.
- **Define and communicate roles and responsibilities:** Ensure all teams understand their responsibilities during the migration.

## Next steps

> [!div class="nextstepaction"]
> [Migration testing](./migration-testing.md)