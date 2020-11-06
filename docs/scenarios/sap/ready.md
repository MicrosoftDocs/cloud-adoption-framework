---
title: "Azure Landing Zone review for SAP"
description: Prepare your Azure environment for SAP with Azure Landing Zones
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Landing Zone review for SAP

SAP typically supports mission critical business functions and sensitive data. Before deploying SAP to the cloud, your landing zones should meet any governance, security, and operations requirements for secure, mission critical applications.

If you have followed a central operations model and built your landing zones using the "start small & expand approach to landing zones", you must complete the Govern and Manage methodologies of the cloud adoption framework before deploying SAP. However, if you are just getting started in your cloud journey, SAP is an indicator that you may want to instead consider starting with the "enterprise-scale approach to landing zones". See the article series on [Azure Landing Zones](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/) to get started with either approach.

## SAP Azure Landing Zone evaluation

Azure Landing Zones which will host SAP should meet all of the following criteria:

- Defined processes and tooling for security, governance, and on-going operations
- Acceptable operations management baseline to ensure neccessary monitoring, operational compliance, and recovery requirements
- Network connectivity should allow for sufficient transmission of data between the on-premise data center and the Azure environment, based on the rationalization and plan for your SAP platform assets and all workload assets.
- Given the mission criticality of the SAP platform, you should consider redundancy in network connectivity between Azure and your existing data centers.
- Management groups hierarchies are important to the long term governance of SAP environments in Azure. You should have a minimum of two SAP management groups to allow for the easy application of distinct controls for production and non-production environments. 
- Subscription organization is another important aspect of environmental segmentation for SAP in the cloud. Consider separating out the core platform into a dedicated subsription(s) to isolate your SAP platform from dependant workloads.

If the landing zone provided by the cloud platform team doesn't address the basic requirements, work with the team to solidify the environment before beginning your cloud adoption efforts.

## SAP Azure Landing Zone acceleration

Development of an enterprise-scale environment can be complex and time-consuming. To accelerate Azure Landing Zone deployment for SAP, review the [SAP enterprise-scale construction set](./enterprise-scale-landing-zone.md) for a reference to architect and implement an environment capable of supporting your SAP platform deployment.

## Next step: Assess for SAP

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for SAP](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate SAP](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
