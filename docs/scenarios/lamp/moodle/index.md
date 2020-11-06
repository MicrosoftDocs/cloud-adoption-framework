---
title: How to perform a manual Moodle migration
description: Learn how to perform a manual Moodle migration.
author: BrianBlanchard
ms.author: TBD
ms.date: 11/06/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---

# How to perform a manual Moodle migration

This document explains how to migrate Moodle application from an on-premises environment to Azure. Two approaches are provided for each step:

- An approach that lets you use the Azure portal.
- An approach that lets you accomplish the same tasks with command line while using Azure CLI.

## Prerequisites

If the versions of the software stack deployed on-premises are lagging with respect to the versions supported in this guide, the expectation is that the on-premises versions will be updated/patched to the versions listed in this guide.

- Must have access to the on-premises infrastructure to take backup of Moodle deployment and configurations (including DB configurations).
- An Azure subscription and Azure Blob storage account should be created prior to migration.
- Open Azure CLI and AzCopy to use them throughout the process.
- Set the Moodle website to **Maintenance mode**.

This migration guide supports the following software versions:

- Ubuntu 18.04 LTS
- Nginx 1.14
- MySQL 5.6, 5.7, or 8.0 database server. This guide uses Azure Database for MYSQL.
- PHP 7.2, 7.3, or 7.4
- Moodle 3.8 and 3

## When to use Azure Resource Manager template for Moodle migrations

Migration of Moodle with an Azure Resource Manager template creates the infrastructure in Azure. Once the infrastructure is created, the Moodle software stack and associated dependencies are migrated.

## Moodle migration tasks

The steps of migration a Moodle application to Azure is broken down in the following three tasks:

1. Pre-migration
1. The practical migration of the application
1. Post-migration

## Next steps