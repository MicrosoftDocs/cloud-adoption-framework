---
title: Azure landing zone Azure Arc-enabled Kubernetes sandbox
description: Learn how to deploy Azure landing zone Azure Arc-enabled Kubernetes sandbox to accelerate adoption of hybrid or multicloud architectures.
author: likamrat
ms.author: likamrat
ms.date: 04/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid
---

# Azure Arc-enabled Kubernetes Azure landing zone sandbox

With Azure Arc, you can onboard infrastructure assets that are located outside of Azure, or deploy Azure services to any infrastructure, either on-premises or in a multicloud environment.

With Azure Arc-enabled Kubernetes, you can attach and configure Kubernetes clusters that can run anywhere.
You can connect your clusters that run on public cloud providers or clusters that run on your on-premises datacenter to Azure Arc.

## Deployment options and prerequisites

The ArcBox solution can be deployed using one of the four methods:

- Azure Bicep using the Azure CLI
- Terraform using the Terraform CLI
- Azure Resource Manager (ARM) template using the Azure CLI
- Azure Resource Manager (ARM) template using the Azure portal

Based on the desired deployment method, you can install either [Azure CLI](/cli/azure/install-azure-cli) or [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli).

You can practice your skills with an automated, easy-to-deploy sandbox solution in Azure Arc named "ArcBox" using Azure Arc-enabled Kubernetes environment. Azure sandbox solution is powered by Azure Arc Jumpstart, and is designed to be entirely self-contained within a single Azure subscription and resource group. ArcBox makes it easy for a user to get hands-on using Azure Arc-enabled servers technology.

## Azure landing zone sandbox subscription

The ArcBox solution is designed to run in your Azure landing zone sandbox subscription and bootstraps all the required Azure resources inside a single resource group.

:::image type="content" source="./media/arcbox-sandbox-subscription.png" alt-text="Screenshot of ArcBox in a sandbox subscription." lightbox="./media/arcbox-sandbox-subscription.png":::

:::image type="content" source="./media/arcbox-resource-group.png" alt-text="Screenshot of ArcBox resource group" lightbox="./media/arcbox-resource-group.png":::

Once deployed, the resource group will contain two Azure Arc-enabled Kubernetes clusters. A "unified operations" resource layer can be included, to start integrating with Azure services and understand Azure Arc-enabled Kubernetes value proposition.

## Next steps

As mentioned, the Azure Arc-enabled Kubernetes landing zone accelerator sandbox implementation is based on the fully automated Jumpstart ArcBox solution. For more information and guidance on how to get started, refer to the [Jumpstart ArcBox website page](https://aka.ms/JumpstartArcBox).
