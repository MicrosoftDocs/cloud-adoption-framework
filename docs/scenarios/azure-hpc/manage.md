---
title: Manage Azure high-performance computing (HPC)
description: As an IT professional, I want to find guidance in the Cloud Adoption Framework covering management for using Azure High-performance computing (HPC) as part of my IT strategy.
author: Rajani-Janaki-Ram
ms.author: erd
ms.date: 09/19/2022
ms.topic: conceptual
s.custom: think-tank
---

# Manage Azure high-performance computing (HPC)

The [Manage methodology](../../manage/index.md) in the Microsoft Cloud Adoption Framework for Azure outlines a path for implementing an operations baseline, and maturing that baseline throughout your cloud adoption lifecycle.

Azure landing zones for HPC do not have any specific considerations or recommendations which would impact management related decisions.

However, it could be important to understand any decisions previously made by the cloud platform team to be aware of existing management recommendations.

## HPC business alignment

For [business alignment](../../manage/considerations/business-alignment.md), review your inventory of HPC workloads by mapping them to business processes to determine criticality, understanding the impact of outages for return on investment for cloud management, and commit to developing true partnerships with creating and documenting agreements with your business.

Ensure that IT management delivers processes that have been designed to minimize disruptions when moving your HPC environment to the cloud.

## HPC operations baseline

HPC workloads do not have special requirements for operational compliance but it would be important to review how the [components of operations compliance](../../manage/considerations/operational-compliance.md#components-of-operations-compliance) are implemented by the cloud management team.

Commit to resource consistency for resource organization and tagging, environment consistency for establishing landing zones, resource configuration consistency for changing or newly updated workloads, stabilize update consistency by regular patching/maintenance, and ensure remediation automation is applied when workloads encounter issues.


## HPC platform operations

For defining HPC platform operations, refer to the cloud adoption guidance in [cloud management](../../manage/considerations/platform.md) and establish a service catalog by building and defining your platform operations.

Get started by reviewing how your organization's data is hosted in either specific platforms such as platform as a service (PaaS) or infrastructure as a service (IaaS) when building out your HPC catalog.

## HPC workload operations

Invest in your HPC [workload operations](../../manage/considerations/workload.md) when the cloud adoption strategy, business outcomes, and operational metrics are well understood. There must be rich data about your HPC workload dependencies, application performance, virtual machine telemetry in order to be able to test automation and communicate changes to the workloads.

Determine if some HPC workloads are critical to where the management baseline and platform operations might not even be sufficient to meet business commitments. This highly important subset of workloads requires a specialized focus on the way the workload functions and how it's supported.

## Next steps

- After outlining the management path for your HPC resources, [secure](./secure.md) your environment with a single centralized strategy.
- Learn how [managing virtual machine compliance](/azure/architecture/example-scenario/security/virtual-machine-compliance) is practiced in Azure.


