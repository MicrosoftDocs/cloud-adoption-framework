---
title: Brownfield landing zone scenario
description: Document describing remediation around existing azure brown field scenario
author: kevinevansmsft
ms.author: kevinevans
ms.date: 08/02/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Introduction to brown field scenarios  

A brownfield deployment is simply your existing Microsoft Azure environment. This article summarizes guidance found elsewhere in the Cloud Adoption Framework Ready documentation.

## Scenario: Transition existing single Azure subscription environment to the Azure landing zone conceptual architecture

This page describes an example scenario that might match your current Azure environment. We detail steps and considerations about how to migrate and transition your Azure environment into the Azure landing zone conceptual architecture. The scenario covers a single subscription with no management groups.

In this scenario, the customer has already started to use Azure and already hosts a few applications or services within the platform. They currently have a single subscription deployed within the Tenant Root Group, but they've realized their current implementation is limiting their scalability and growth per their "cloud first" strategy.

As part of this expansion, they're also planning to migrate away from their current platform management strategy to CAF aligned platform management structure    (Azure Landing Zones). They'll modernize and transform their management structure to introduce scoped compliance for critical services and introduce landing zones for agnostic workload types.

The customer has evaluated the Azure landing zones conceptual architecture. And they've decided to move from their existing approach to an enterprise-scale architecture. Doing so supports their "cloud first" strategy while having a robust platform that scales with their workload deployment types.

## Current state

In this scenario, the current state of the customer's Azure environment is as follows:

- 	Single Azure subscription.
-	No custom management groups.
-	Non-uniform resource distribution. Platform and workload resources are deployed in the same Azure subscription.
-	Minimal usage of Azure Policy. Policy assignments (audit and deny effects) are done per resource group with exceptions.
-	Resource groups are treated as units of management and scale.
-	RBAC role assignments per resource group.
-	Azure Blueprints are being used.
-	Single VNet
-	No hybrid connectivity (VPN/ExpressRoute).
-	A new subnet is created per application.
-	Multiple self-contained applications in each of the app-xx-rg resource groups.
-	Controlled and operated by different application or service teams.


The following diagram shows the current state of this sample scenario:

![Diagram_That_Shows_Single_Sub_Scenario_Example1](./media/alz-align-scenario-single-sub.png)  


## Transition to the Azure landing zone conceptual architecture

To transition from this scenario's current state to an Azure landing zone conceptual architecture, we suggest this approach:

-   Review the [Azure landing zone conceptual architecture](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/landing-zone/index.md) and [Azure landing zone design areas](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/landing-zone/design-areas.md).

- 	Deploy the [Azure landing zone accelerator](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/landing-zone/index.md#azure-landing-zone-accelerator),[Azure landing zone Terraform deployment](./deploy-landing-zones-with-terraform.md) or the [Azure landing zone Bicep deployment](https://learn.microsoft.com/azure/architecture/landing-zones/bicep/landing-zone-bicep) into the same Azure AD tenant in parallel with the current environment.

Doing so creates a new management group structure. This structure is aligned with Azure landing zones design principles and recommendations. It also ensures that the existing environment is not affected by these changes.

-	(optional) Work with application or service teams to migrate the workloads deployed in the original subscription into new Azure subscriptions, per the guidance in [Transition existing Azure environments to the Azure landing zone conceptual architecture](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/enterprise-scale/transition.md#moving-resources-in-azure). They can be placed into the newly deployed Azure landing zone conceptual architecture management group hierarchy under the correct management group – corporate or online.

Review the policy section in [Transition existing Azure environments to the Azure landing zone conceptual architecture](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/enterprise-scale/transition.md#policy) for details about the effect on resources when migrating. Eventually, the existing Azure subscription can be canceled and placed in the decommissioned management group.

> [!NOTE] 
> The existing applications or services do not necessarily have to be migrated into new landing zones (Azure subscriptions)

-	Create new Azure subscriptions to provide landing zones that can support migration projects from on-premises. Place them under the proper management group (corporate or online).

The following diagram shows the state during the migration approach of this sample scenario:

![Diagram_That_Shows_Single_Sub_Scenario_Example2](./media/alz-align-single-sub-transition-state.png)

## Summary

In this scenario, the customer has helped themselves achieve their expansion and scaling plans within Azure by deploying the [Azure landing zone conceptual architecture](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/landing-zone/index.md#azure-landing-zone-conceptual-architecture) in parallel to their existing environment.