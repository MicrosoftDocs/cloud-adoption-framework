---
title: Deploy a sandbox for Azure Arc-enabled SQL Managed Instance
description: Learn how to deploy Azure landing zone Azure Arc-enabled data services sandbox to accelerate your adoption of hybrid or multicloud architectures.
author: likamrat
ms.author: likamrat
ms.date: 09/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid, ignite-2022
---

# Deploy a sandbox for Azure Arc-enabled SQL Managed Instance

Microsoft Azure Arc-enabled SQL Managed Instance has near 100% compatibility with the latest SQL Server database engine. Existing SQL Server customers can lift-and-shift their applications to Azure Arc data services with minimal application and database changes, while maintaining data sovereignty. At the same time, SQL Managed Instance includes built-in management capabilities that drastically reduce management overhead.

## Azure landing zone sandbox subscription

You can practice your skills with an automated, easy-to-deploy sandbox solution named *ArcBox* using an Azure Arc-enabled Kubernetes environment. ArcBox runs in your [Azure landing zone sandbox subscription](/azure/cloud-adoption-framework/ready/considerations/sandbox-environments.md) and bootstraps all required Azure resources within a single resource group.

[![Diagram of ArcBox in a sandbox subscription.](./media/arcbox-sandbox-subscription.png)](./media/arcbox-sandbox-subscription.png#lightbox)

*Figure 1: Diagram of ArcBox in a sandbox subscription.*

ArcBox is entirely self-contained within a single Azure subscription and resource group. It lets you get hands-on with Azure Arc-enabled server technology while needing nothing more than an Azure subscription.

[![Diagram of an ArcBox resource group.](./media/arcbox-resource-group.png)](./media/arcbox-resource-group.png#lightbox)

*Figure 2: Diagram of an ArcBox resource group.*

The single resource group that ArcBox deploys contains three Azure Arc-enabled Kubernetes clusters. It also includes a *unified operations* resource layer so you can integrate with Azure services and understand the Azure Arc-enabled data services value proposition.

## Deployment options and prerequisites

The ArcBox solution can be deployed using one of four methods:

- Azure Bicep using the [Azure CLI](/cli/azure/install-azure-cli)
- Terraform using the [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Azure Resource Manager (ARM) template using the Azure CLI
- ARM template using the Azure portal

Based on the desired deployment method, you can install either the Azure CLI or Terraform CLI.

## Next steps

The Azure Arc-enabled data services landing zone accelerator sandbox is based on the fully automated Jumpstart ArcBox solution. For more information, see the [Jumpstart ArcBox overview](https://azurearcjumpstart.io/azure_jumpstart_arcbox).
