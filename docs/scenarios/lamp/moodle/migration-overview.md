---
title: Overview of Moodle manual migration
description: Review the prerequisites and overall steps for manually migrating Moodle from an on-premises environment to Azure.
author: UmakanthOS
ms.author: brblanch
ms.date: 11/30/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
ms.custom: think-tank
---

# Overview of Moodle manual migration

[Moodle](https://moodle.org/) is a free, open-source learning management system written in PHP. This guide explains how to migrate a Moodle deployment from an on-premises environment to Azure. The guide provides steps for two different approaches that use either the Azure portal or the Azure command-line interface (Azure CLI).

## Prerequisites

Before starting migration, you need the following prerequisites:

- On-premises software updated and patched to the following versions:
  - Ubuntu 18.04 LTS
  - NGINX 1.14
  - MySQL 5.6, 5.7, or 8.0 database server. This guide uses Azure Database for MySQL.
  - PHP 7.2, 7.3, or 7.4
  - Moodle 3.8 or 3
- Your Moodle website set to **Maintenance mode**.
- Access to the on-premises infrastructure, to [back up the Moodle deployment and configurations](./migration-pre.md#back-up-on-premises-data), including database configurations.
- [Azure CLI](./migration-pre.md#install-the-azure-cli) and [AzCopy](./migration-pre.md#download-and-install-azcopy) installed on-premises.
- An [Azure subscription](./migration-pre.md#create-a-subscription) and [Azure Blob Storage account](./migration-pre.md#create-a-storage-account) created.

## Moodle migration process

Migrating Moodle with an Azure Resource Manager (ARM) template creates the infrastructure in Azure, then migrates the Moodle software stack and associated dependencies.

The Moodle migration steps to Azure break down into the following three stages:

1. [Pre-migration](./migration-pre.md)
1. [Application migration](./migration-start.md)
1. [Post-migration](./migration-post.md)

## Next steps

Continue to [How to prepare for a Moodle migration](./migration-pre.md).
