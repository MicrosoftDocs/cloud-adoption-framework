---
title: "Assess for SAP"
description: Describe the scenario's impact on migration assessment
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Assess for SAP

SAP is a powerful platform with specific technical requirements. Given the complexity and strict requirements for security and compliance, this platform can seldom be moved in a standardized migration factory. However, it can leverage the same standardized processes to ensure consistency and integration with other efforts. 

## SAP data points

When assessing your SAP Platform and dependent workloads there are a few considerations that aren't commonly factored into the migration process:

- Is the current inventory of platform assets running operating systems which are supported in Azure? Unsupported operating systems will need to be remediated during or before migration.
- Is the current database management system supported in Azure? Unsupported databases will need to be remediated during or before migration.
- Will you be upgrading all or part of the SAP solution before or during migration?

## SAP partners/tools

SAP provides a tool called **SAP Software Update Manager** which can help facilitate the migration of your SAP platform. This tool leverages **Software Provisioning Manager** and **Data Migration Option** features to complete the actual migration.

Dependent workloads can then be migrated using the standardized Azure Migrate tool and processes.

## Next step: Migrate SAP

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Migrate SAP](./migrate-deploy.md)
- [Release SAP to production](./migrate-release.md)
- [Innovate with SAP](./innovate.md)
- [Govern SAP](./govern.md)
- [Manage SAP](./manage.md)
