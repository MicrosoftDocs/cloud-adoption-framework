---
title: Enterprise-scale landing zone design principles
description: Learn about Enterprise-scale landing zone design principles which influence the design areas for enterprise-scale landing zone implementations
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise-scale landing zone design principles

The Azure landing zone conceptual architecture prescribed in this guidance are universally applied to any Azure landing zone process or implementation. However, if you choose to deploy the Azure Landing Zone Accelerator or use any version of the Enterprise-scale landing zone code base, those implementations build on the conceptual architecture by applying the design principles described here. These principles serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with nonadherence.

Decisions you made during review of each design area made need to be adjusted slightly to adhere to these design principles. Each design principle includes one or more example of how that principle could impact your design area decisions.

## Subscription democratization

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design, development, and testing of new workloads and migration of workloads.

### Impact on design deviation

All Azure landing zone suggest the use of management groups and subscriptions to separate compliance related assets from assets required to support workloads. This principles suggests a further segmentation to allocate a new subscription per workload with responsibility for  production operations transitioned to the business units & workload teams. This more granular segmentation allows for isolation of resources & inherently implements a model for separation of duties, allowing workload owners to have more control of their workloads within the guardrails established by shared platform foundation resources. Customers who require central operations & do not wish to delegate control of production environments to workload teams or business units, may need to make code & subscription design modifications to deviate from this principle. This design principle also forces a specific management group & subscription hierarchy for all operations management subscriptions which could prove problematic if you require separation of duty between operations, security, and governance staff.

## Policy-driven governance

Azure Policy should be used to provide guardrails and ensure continued compliance with your organization's platform, along with the applications deployed onto it. Azure Policy also provides application owners with sufficient freedom and a secure unhindered path to the cloud.

### Impact on design deviation

All Azure landing zones suggest the use of Azure Policy or other equivalent policy automation tools to develop compliance guardrails. This design principles expands upon that belief through the use of DINE (Deploy if not exist) policies to deploy specific parts of the environments configuration. This design principle reduces the risk of compliance deviations, but requires operational skills in ARM template development & specifically development of ARM templates which use Azure DINE policies as an automated & enforced DevOps pipeline.

## Single control and management plane

The Azure landing zone conceptual architecture shouldn't consider any abstraction layers, such as customer-developed portals or tooling. It should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels subject to role-based access and policy-driven controls. Azure can be used to establish a standardized set of policies and controls for governing the entire enterprise estate.

### Impact on design deviation

Accepting this design principle assumes you prefer cloud-first operations tools over a best of breed approach which mixes and matches operational tools from various vendors. This design principle establishes a layered effect across the control plane with dependencies on specific assets, such as a single centralized workspace for Azure Monitor to centralize logs. For customers who are bringing an existing "best of breed" approach to operations, security, or governance, a review of the Azure services is suggested. Replacing individual components to achieve "best of breed" or multi-vendor operations tooling may have limitation & could cause unintended errors due to inherent dependencies. 

## Application-centric and archetype-neutral

The Azure landing zone conceptual architecture should focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. It shouldn't differentiate between old and new applications, infrastructure as a service, or platform as a service applications. Ultimately, it should provide a safe and secure foundation for all application types to be deployed onto your Azure platform.

### Impact on design deviation

Central operating models often separate workload by environment (Prod, QA, Dev) and by archetype (COGS, shared service technology platforms, stable workloads, high-change/DevOps workloads, Web vs internal, etc...), with further segmentation of high-change workloads or isolation of workloads which require risky compliance exceptions. To encourage agility, innovation, & accelerate the pace of change, this design principle codifies a segmentation model which isolates all workloads into their own subscriptions & environments. Support for central operations or archetype based segmentation would require changes to the code base to deviate from this principle.

## Align Azure-native design and roadmaps

The The Azure landing zone conceptual architecture approach advocates using Azure-native platform services and capabilities whenever possible. This approach should align with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help to inform the migration strategy and The Azure landing zone conceptual trajectory.

### Impact on design deviation

To maintain or update your Azure landing zone environment in accordance with changes to the Azure platform, this design principle assumes that you will use an approved code-base as your starting point for landing zone development & fork that codebase to make any changes. When Azure changes the enterprise-scale landing zone team will update the core codebase, you can then merge that update into your fork to integrate those updates & deploy changes out to your environment. When using the Azure landing zone accelerator, you will get the latest version of each Azure service, but capitalizing on this design principle going forward will require manual redeployment or configuration changes to the ARM templates within the DINE Policies.

## Recommendations

Be prepared to trade off functionality because it's unlikely that everything will be required on day one. Use preview services and take dependencies on service roadmaps to remove technical blockers.
