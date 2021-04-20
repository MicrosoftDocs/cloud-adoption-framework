---
title: Review Azure Landing Zones for SAP
description: The following process will aid in review of any Azure Landing Zone to prepare for production release of SAP.
author: brianblanchard
ms.author: brblanch
ms.date: 3/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-sap
---

# Review Azure Landing Zones for SAP on Azure

## Review strategic objectives

- Review the cloud adoption strategy
- Review the strategy for the SAP adoption scenario

## Review the project plan

- Understand who the plan fits into the broader cloud adoption plan
- Understand who is involved in this specific project plan
- Review current state progress against the project plan

## Evaluate the environment

Azure landing zones hosting SAP products should meet all of the following criteria:

- The landing zone enforces defined processes and tooling for security, governance, and ongoing operations.
- The landing zone enforces offer an acceptable operations management baseline to ensure necessary monitoring, operational compliance, and recovery requirements.
- Network connectivity factors in the rationalization and plan for your SAP platform and all workload assets to allow sufficient data transmission between the on-premises datacenter and the Azure environment.
- Since the SAP platform is mission critical, you should consider redundancy in network connectivity between Azure and your existing datacenters.
- Management groups hierarchies are important to the long-term governance of SAP environments in Azure. You should have at least two SAP management groups to allow distinct controls to be applied easily to production and nonproduction environments.
- Organizing subscriptions is another important aspect of environmental segmentation for your core SAP platform and all dependant workloads in the cloud. To isolate your SAP platform from dependant workloads, consider separating the core platform into dedicated subscription(s).

If the landing zone provided by the cloud platform team doesn't address the basic requirements, work with the team to solidify the environment before beginning your cloud adoption efforts.

For deeper details during the evaluation of the Azure Landing Zone(s), see each of the Azure design area articles:

- [Enterprise enrollment](eslz-enterprise-enrollment.md)
- [Identity and access management](eslz-identity-and-access-management.md)
- [Network topology and connectivity](eslz-network-topology-and-connectivity.md)
- [Resource Organization](eslz-resource-organization.md)
- [Governance disciplines](eslz-security-governance-and-compliance.md)
- [Operations baseline](eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](eslz-business-continuity-and-disaster-recovery.md)
- [Deployment options](eslz-platform-automation-and-devops.md)

## Evaluate the SAP platform deployment


## How to accelerate an Azure landing zone for SAP

Developing of an enterprise-scale environment can be complex and time-consuming. Review the [enterprise-scale landing zone for SAP](./enterprise-scale-landing-zone.md) to accelerate Azure landing zone deployment for SAP products and understand how to architect and implement an environment capable of supporting your SAP platform in production.

## Identify opportunities to improve

- Before suggesting any changes as a result of the review, evaluate those suggestions with the teams who have implemented the plan so far.
- Identify and remove best practices which are purposefully not included due to technical or non-technical requirements.
- Develop a plan to iterate and include best practices which align to the technical and non-technical requirements but have not yet been deployed as part of the project plan.

## Get production ready
