---
title: Prepare for management activities
description: Learn how to prepare for management activities when migrating workloads to Azure with the Cloud Adoption Framework.
author: Zimmergren
ms.author: tozimmergren
ms.date: 04/10/2024
ms.topic: conceptual
---

# Prepare for management activities

After a workload migration is complete, you must be prepared to carry out management activities. Organizations that fail to plan for management can experience replicated or delayed workloads. Furthermore, when resources are migrated but not managed, problems such as outages, breaches, or performance issues can occur.

> [!NOTE]
> The guidance in this article builds on the broader Cloud Adoption Framework management guidance. These additional guides might be relevant to building your management routines:
>
> - [Azure landing zones: Management design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management).
> - [Azure Management Guide](/azure/cloud-adoption-framework/manage/azure-management-guide/).
> - [CAF management methodology](/azure/cloud-adoption-framework/manage/).

Ensure you have a management routine in place for each workload.

## Minimum management goals

This list covers minimum management goals you should plan and prepare for each workload:

- **Logs:** Appropriate logs are being collected by your logging system, like Log Analytics. Logs should include:
  - Activity logs to observe changes and events on services.
  - Diagnostic logs to collect metric and service specific logs.
  - System logs from migrated or newly created virtual machines.
- **Alerts deployment:** Deployment of general alerts based on organizational standards and alerts for your workload.
- **Backup:** Backup configurations and processes that you can use to restore state in compliance with your organization’s service-level agreements (SLAs).
- **Business continuity and disaster recovery (BCDR):** A BCDR configuration that allows you to failover and restore service in compliance with your organization’s SLAs.
- **Security posture:** Enrollment in the Defender for Cloud policies selected by your organization to perform security posture management and vulnerability detection.
  - This might include the deployment of vulnerability detection services or the Defender for Endpoint agent.
- **Enable Azure Serial Console:** Enablement of [Serial Console](/troubleshoot/azure/virtual-machines/serial-console-overview) in Azure VMs to help with troubleshooting.
- **Enable Auto-shutdown:** Configuration of auto-shutdown schedules for virtual machines that meet business requirements.
- **Tags:** Deployment of tags and remediation of incorrect tags.
- **Update management:** The periodic update of virtual machines such as with Azure Update Manager.

If you identify a missing management goal, you should add it to your remediation plan for the workload.

## Organizing transition to management

To organize a smooth transition to management for your migrated workloads, you should have a plan in place to ensure:

- **Involve application and workload owners:** The application owners are aware of any changes to activities to the servers being migrated such as deployment of code or installation of modules.
- **Involve monitoring, management, and security teams:** Teams responsible for monitoring, management, and security are aware of changes and responsibilities after the migration.
- **Define and communicate roles and responsibilities:** All teams understand their responsibilities during the migration.

## Next steps

> [!div class="nextstepaction"]
> [Migration testing](./migration-test.md)