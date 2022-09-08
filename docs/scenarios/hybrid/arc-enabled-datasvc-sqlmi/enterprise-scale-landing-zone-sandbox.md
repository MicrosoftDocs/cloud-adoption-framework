---
title: Azure landing zone Azure Arc-enabled data services sandbox
description: Learn how deploying Azure landing zone Azure Arc-enabled data services sandbox can accelerate your adoption of hybrid or multicloud architectures.
author: likamrat
ms.author: likamrat
ms.date: 09/07/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid, event-tier1-build-2022
---

# Azure Arc-enabled SQL Managed Instance Azure landing zone sandbox

Azure Arc-enabled SQL Managed Instance has near 100% compatibility with the latest SQL Server database engine, and enables existing SQL Server customers to lift and shift their applications to Azure Arc data services with minimal application and database changes while maintaining data sovereignty. At the same time, SQL Managed Instance includes built-in management capabilities that drastically reduce management overhead.

## Azure landing zone sandbox subscription

ArcBox runs in your Azure landing zone sandbox subscription and bootstraps all required Azure resources within a single resource group.

<!-- [![A diagram that shows an ArcBox resource group.](./media/arc-enabled-kubernetes-onboarding.png)](./media/arc-enabled-kubernetes-onboarding.png#lightbox) -->

<!-- The single resource group ArcBox deploys contains two Azure Arc-enabled Kubernetes clusters. It also includes a *unified operations* resource layer so you can integrate with Azure services and understand Azure Arc-enabled Kubernetes value proposition. -->

## Deployment options and prerequisites

The ArcBox solution can be deployed using one of the four methods:

- Azure Bicep using the Azure CLI
- Terraform using the Terraform CLI
- Azure Resource Manager (ARM) template using the Azure CLI
- Azure Resource Manager (ARM) template using the Azure portal

Based on the desired deployment method, you can install either [Azure CLI](/cli/azure/install-azure-cli) or [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli).

You can practice your skills with an automated, easy-to-deploy sandbox solution in Azure Arc named "ArcBox" using Azure Arc-enabled Kubernetes environment. Azure sandbox solution is powered by Azure Arc Jumpstart. ArcBox is entirely self-contained within a single Azure subscription and resource group. It lets you get hands-on with the Azure Arc-enabled servers technology while needing nothing more than an Azure subscription.

## Next steps

The Azure Arc-enabled data services landing zone accelerator sandbox is based on the fully automated Jumpstart ArcBox solution. For more information and guidance on how to get started, refer to the [Jumpstart ArcBox website page](https://aka.ms/JumpstartArcBox).
