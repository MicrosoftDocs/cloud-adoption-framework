---
title: Review your environment or Azure landing zone for an SAP enterprise-scale migration
description: Prepare your Azure environment or Azure landing zone for an SAP enterprise-scale migration.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Review your environment or Azure landing zone for an SAP enterprise-scale migration

The SAP platform typically supports business functions, sensitive data, and workloads that are vital to business operations. Before deploying your SAP platform and workloads to the cloud, your landing zones should meet any governance, security, and operations requirements for secure, mission-critical applications.

If you have followed a central operations model and built your landing zones with a _start small and expand_ approach to landing zones, you must complete the Cloud Adoption Framework [Govern](../../govern/index.md) and [Manage](../../govern/index.md) methodologies before deploying a production SAP platform onto Azure. Featuring an SAP platform in your adoption plan indicates that your cloud environment might have more operations, compliance, and security requirements. However, consider starting with the enterprise-scale approach to landing zones if you're just starting your cloud journey. Read about [Azure landing zones](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/) to understand how to start with either approach.

## How to evaluate an SAP Azure landing zone

Azure landing zones hosting SAP products should meet all of the following criteria:

- They have defined processes and tooling for security, governance, and ongoing operations.

- They offer an acceptable operations management baseline to ensure necessary monitoring, operational compliance, and recovery requirements.

- Network connectivity factors in the rationalization and plan for your SAP platform and all workload assets to allow sufficient data transmission between the on-premises datacenter and the Azure environment.

- Since the SAP platform is mission critical, you should consider redundancy in network connectivity between Azure and your existing datacenters.

- Management groups hierarchies are important to the long-term governance of SAP environments in Azure. You should have at least two SAP management groups to allow distinct controls to be applied easily to production and nonproduction environments.

- Organizing subscriptions is another important aspect of environmental segmentation for your core SAP platform and all dependant workloads in the cloud. To isolate your SAP platform from dependant workloads, consider separating the core platform into dedicated subscription(s). 

If the landing zone provided by the cloud platform team doesn't address the basic requirements, work with the team to solidify the environment before beginning your cloud adoption efforts.

## How to accelerate an SAP Azure landing zone

Developing of an enterprise-scale environment can be complex and time-consuming. Review the [SAP enterprise-scale construction set](./enterprise-scale-landing-zone.md) to accelerate Azure landing zone deployment for SAP products and understand how to architect and implement an environment capable of supporting your SAP platform.

## Next step: Migrate an SAP platform to Azure

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting SAP in Azure.

- [Migrate an SAP platform to Azure](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
