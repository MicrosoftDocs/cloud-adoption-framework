---
title: Enterprise-scale FAQ
description: The Enterprise-scale FAQ provides answers to common questions asked about the Enterprise-scale architecture.
author: jtracey93
ms.author: jtracey93
ms.date: 09/13/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise-scale FAQ

This article answers frequently asked questions relating to Enterprise-scale.

<!-- GENERAL -->

## What does a "Landing Zone" map to in Azure in the context of Enterprise-scale?

From an Enterprise-Scale point of view, "Landing Zones" are individual Azure Subscriptions.

## How long does Enterprise-scale take to deploy?

This is dependant on the options you select during the implementation experience. However, it will vary from around 5 minutes to 40 minutes; depending on the options selected.

For example:

- Deploying the conceptual architecture **without** any networking/connectivity options will take around 5 minutes to deploy.
- Deploying the conceptual architecture **with** the hub and spoke networking options, including VPN and ExpressRoute gateways, will take around 40 minutes to deploy.

## Why are there custom policy definitions as part of Enterprise-scale?

We work with, and learn from our customers and partners, this ensures that we evolve and enhance the reference implementations to meet customers and partners requirements. As part of this interaction with our customers and partners we may notice a policy that is required that is not available from the built-in definitions yet, so we will create and test a definition to meet the requirement and include it in Enterprise-scale for everyone to use.

We will then work with the Azure Policy and associated product/service engineering teams to convert the custom policy that has been created into a built-in definition over time.

<!-- IMPLEMENTATION -->

## Why does Enterprise-scale implementation require permission at Tenant root '/' scope?

Management Group creation, Subscription creation, and placing Subscriptions into Management Groups are APIs that operate at the tenant root "`/`" scope.

Therefore, to create the Management Group hierarchy, the Subscriptions, and place them into the Management Groups defined, the initial deployment must  be invoked at the tenant root "`/`" scope. Once you have deployed Enterprise-scale, you can remove the Owner permission from the tenant root "`/`" scope, as you will be made an Owner at the intermediate root Management Group (e.g. "Contoso"), by the Azure platform, that Enterprise-scale has created.

For further guidance on tenant level deployments in Azure, see: [Deploy resources to tenant](/azure/azure-resource-manager/templates/deploy-to-tenant)

## The Azure Landing Zone Accelerator portal based deployment does not display all Subscriptions in the drop-down lists?

When deploying Azure Landing Zone Accelerator portal based experience, the portal is creating the list of Subscriptions to be selected for deployment of the platform Subscriptions (management, connectivity, identity), as well as the landing zones (corp and online). When there are more than 50 Subscriptions, the API the portal calls upon to generate the list of Subscriptions cannot display all Subscriptions in the drop-down lists. To workaround this, perform the following steps:

1. Go through the Azure Landing Zone Accelerator portal based experience as you would normally and select/enable all the options that you desire. When you get to the Subscription drop-downs, select any visible Subscription as a placeholder to view and select/enable all options (some options have dependency on a Subscription being selected before they are displayed).
2. Once you have gone through all the pages/blades, go back to the ‘basics’ page/blade, and click on ‘edit parameters’.
3. Change the value for the specific `subscriptionId` parameter inputs with the actual Subscription IDs you wish to use.
4. Click 'Save'.
5. Click 'Review + create', and submit the deployment.

## Can we use and customize the ARM templates for Enterprise-scale and check them into our repository and deploy it from there instead of the Azure Landing Zone Accelerator portal based experience?

All of the ARM templates for the Enterprise-Scale are developed for, and optimized for the Azure Landing Zone Accelerator portal based experience. Therefore we do not recommend nor support customization of these templates, as they are complex. Based on all of the options we provide for the Azure Landing Zone Accelerator portal based experience, this requires a lot of logical operators and conditions used in the ARM template expressions to handle all of these options and variations. Also there is a specific order that the various ARM deployments (nested templates) must be deployed in to accomplish a successful deployment.

Finally, taking the same templates for day 2 and onwards operations, will require you to re-deploy to the entire tenant for any change, and also require permanent Owner RBAC assignment on the tenant root "`/`" scope.

However, if you wish to deploy and manage Enterprise-scale via infrastructure-as-code, please see the question: [What if we don't want to deploy using the Azure Landing Zone Accelerator portal based experience, but want to deploy with infrastructure-as-code?](#what-if-we-dont-want-to-deploy-using-the-azure-landing-zone-accelerator-portal-based-experience-but-want-to-deploy-with-infrastructure-as-code)

## What if we cannot deploy using the Azure Landing Zone Accelerator portal based experience, but can deploy with infrastructure-as-code?

We have a number of implementation options available:

- The [Azure Landing Zone Accelerator](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-accelerator) portal based experience
  - This can, optionally, integrate and bootstrap a CI/CD pipeline using GitHub with [AzOps](https://github.com/Azure/AzOps) as documented [here.](https://github.com/Azure/Enterprise-Scale/wiki/Deploying-Enterprise-Scale)
- The [Enterprise-scale Do-It-Yourself (DIY) ARM templates](https://github.com/Azure/Enterprise-Scale/tree/main/eslzArm#enterprise-scale-landing-zones-arm-templates) method
- The [Terraform Module for Cloud Adoption Framework Enterprise-scale](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale#terraform-module-for-cloud-adoption-framework-enterprise-scale)

>[!NOTE]
> The Bicep implementation option for Enterprise-scale is coming soon!
