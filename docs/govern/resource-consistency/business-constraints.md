---
title: Managing business constraints in the Resource Consistency discipline
description: Guidance for managing common business constraints in the Resource Consistency discipline
author: robbagby
ms.author: robbag
ms.date: 10/05/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal, UpdateFrequency2
---

# Business constraints

There are various constraints that your business must adhere to. Some constraints are imposed by governments, such as data residency requirements, some by industrial bodies, while others are self imposed. You should use tooling in Azure to enforce and audit compliance with these constraints. This article provides guidance on how to manage common business constraints.

## Location

Data residency refers to the geographic location of an organization's data. A governmental or industrial body, or the organization itself can impose limitations or restrictions on where your data must reside.

Consider using the following Azure Policies if you have data residency restrictions.

- The [allowed locations Azure Policy](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fe56962a6-4747-49cd-b67b-bf8b01975c4c) controls where resources are created.
- The [SQL Database should avoid using GRS backup redundancy policy](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fb219b9cf-f672-4f96-9ab0-f5a3ac5e1c13) restricts using the default geo-redundant storage for backups for SQL databases.
- The [Azure Cosmos DB allowed locations policy](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F0473574d-2d43-4217-aefe-941fcdf7e684) enables you to restrict the locations to which your organization can deploy Cosmos DB.

TODO: The allowed locations Azure Policy restricts where all resources can be created. Are there granular policies or controls for data resources themselves (Sql, Cosmos, etc.), or is the above policy what customers use?

## Redundant data storage

Redundant data storage refers to the practice of replicating data in multiple locations to protect against hardware failures, power outages, or network outages.

Consider the following Azure Policies to enforce compliance with data redundancy constraints.

- [Geo-redundant storage should be enabled for Storage Accounts](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fbf045164-79ba-4215-8f95-f8048dc1780b) ensures geo redundant replication is configured for Azure Storage Accounts.

## Backup and disaster recovery

Azure offers [end-to-end backup and disaster recovery solutions](https://azure.microsoft.com/solutions/backup-and-disaster-recovery/#overview) you can use to recover your business services in a timely manner when an incident occurs.

Consider using the following resources to enforce and audit your backup and disaster recovery requirements.

- The [Azure Policy built-in definitions for Azure Backup policies](/azure/backup/policy-reference) is a listing of built-in policies for Azure Backup.
- The [Auto-Enable Backup on VM Creation Azure Policies](/azure/backup/backup-azure-auto-enable-backup?source=recommendations) help ensure your Virtual Machines are configured for backup.
- The [Update backup storage redundancy for Azure Cosmos DB periodic backup accounts policy](/azure/cosmos-db/update-backup-storage-redundancy) can be used to enforce geo-redundant backup storage.

## Resource type

It's recommended that you restrict the deployment of services that your organization hasn't defined governance around. One way to restrict the deployment of resource types is to disable the associated Resource Provider for your subscription. A better way to restrict the deployment of resource types is to enforce with Azure Policy in your Management Groups.

There are two built-in policies to support this function. Use either and customize the list of services as needed. These policies will also identify any resources that have already been deployed.

- The [Allowed resource types policy](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fa08ec900-254a-4555-9bf5-e42af04b5c5c) ensures your organization can only deploy the specified resource types.
- The [Not allowed resource types policy](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749) ensures your organization doesn't deploy specified resource types.

Use the [Service enablement framework](../../ready/landing-zone/design-area/service-enablement-framework.md) to help assess the enterprise security, governance and compliance readiness of Azure resource types and services before it's approved in your organization.

## Monitoring

In order to ensure that critical applications are available to your users, you must monitor the resources that run these services. Monitoring provides visibility into the availability, performance, and operation of the resources.

[Azure Monitor](/azure/azure-monitor/overview) allows you to aggregate logs, metrics and distributed traces from your resources. You should configure [Azure Monitor Agent](/azure/azure-monitor/agents/agents-overview) guest operating systems running on Azure and on premise to collect monitoring data and send it to Azure Monitor. You should configure PaaS and SaaS cloud services to send monitoring data to Azure Monitor.

Use the relevant [Azure Policy built-in definitions for Azure Monitor](/azure/azure-monitor/policy-reference) to audit and enforce monitoring policies in your organization. 

Use the relevant Azure Policies below to ensure guest operating systems are running Azure Monitor Agent.

- Windows
  - [Configure Linux virtual machines to run Azure Monitor Agent with system-assigned managed identity-based authentication](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fa4034bc6-ae50-406d-bf76-50f4ee5a7811)
  - [Configure Linux Virtual Machine Scale Sets to run Azure Monitor Agent with system-assigned managed identity-based authentication](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F56a3e4f8-649b-4fac-887e-5564d11e8d3a)
  - [Configure Linux Arc-enabled machines to run Azure Monitor Agent](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F845857af-0333-4c5d-bbbc-6076697da122)
  - [Configure Linux Machines to be associated with a Data Collection Rule](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F2ea82cdd-f2e8-4500-af75-67a2e084ca74)
- Linux
  - [Configure Windows virtual machines to run Azure Monitor Agent using system-assigned managed identity](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fca817e41-e85a-4783-bc7f-dc532d36235e)
  - [Configure Windows Virtual Machine Scale Sets to run Azure Monitor Agent using system-assigned managed identity](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F4efbd9d8-6bc6-45f6-9be2-7fe9dd5d89ff)
  - [Configure Windows Arc-enabled machines to run Azure Monitor Agent](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F94f686d6-9a24-4e19-91f1-de937dc171a4)
  - [Configure Windows Machines to be associated with a Data Collection Rule](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Feab1f514-22e3-42e3-9a1f-e1dc9199355c)
