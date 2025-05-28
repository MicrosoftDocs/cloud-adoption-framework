---
title: Prepare for management activities
description: Learn how to prepare for management activities when migrating workloads to Azure with the Cloud Adoption Framework.
author: Zimmergren
ms.author: pnp
ms.date: 04/05/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Prepare for management activities

You should prepare to carry out management activities after a workload migration is complete. Organizations that fail to plan for management can experience replicated or delayed workloads. Furthermore, when resources are migrated but not managed, problems such as outages, breaches, or performance problems can occur.

> [!NOTE]
> The guidance in this article builds on the broader Cloud Adoption Framework for Azure management guidance. These additional guides might be relevant to building your management routines:
>
> - [Azure landing zones: Management design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management)
> - [Azure Management Guide](/azure/cloud-adoption-framework/manage/azure-management-guide/)
> - [Cloud Adoption Framework management methodology](/azure/cloud-adoption-framework/manage/)

Ensure you have a management routine in place for each workload.

## Minimum management goals

For each workload, these are the minimum management goals you should plan and prepare for:

- **Logs**: Appropriate logs are being collected by your logging system, like Azure Monitor Logs. Logs should include:
  - Activity logs to observe changes and events on services.
  - Diagnostic logs to collect metric and service-specific logs.
  - System logs from migrated or newly created virtual machines.
- **Alerts deployment**: Deployment of general alerts based on organizational standards and alerts for your workload.
- **Backup**: Backup configurations and processes that you can use to restore state in compliance with your organization's service-level agreements (SLAs).
- **Business continuity and disaster recovery (BCDR)**: A BCDR configuration that allows you to fail over and restore service in compliance with your organization’s SLAs.
- **Security posture**: Enrollment in the Microsoft Defender for Cloud policies selected by your organization to perform security posture management and vulnerability detection. This might include the deployment of vulnerability detection services or the Microsoft Defender for Endpoint agent.
- **Serial console for Azure Virtual Machines**: Enabling a [serial console](/troubleshoot/azure/virtual-machines/serial-console-overview) in Virtual Machines to help with troubleshooting.
- **Enable automatic shutdown**: Configuration of automatic shutdown schedules for virtual machines that meet business requirements.
- **Tags**: Deployment of tags and remediation of incorrect tags.
- **Update management**: The periodic update of virtual machines such as with Azure Update Manager.

If you identify a missing management goal, you should add it to your remediation plan for the workload.

## Organize transition to management

To organize a smooth transition to management for your migrated workloads, you should have a plan in place to ensure that you:

- **Involve application and workload owners**: The application owners are aware of any changes to activities to the servers being migrated such as deployment of code or installation of modules.
- **Involve monitoring, management, and security teams**: Teams responsible for monitoring, management, and security are aware of changes and responsibilities after the migration.
- **Define and communicate roles and responsibilities**: All teams understand their responsibilities during the migration.

## Next step

> [!div class="nextstepaction"]
> [Migration testing](./migration-test.md)
