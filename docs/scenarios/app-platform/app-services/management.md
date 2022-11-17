---
title: Operations management considerations for Azure App Service
description: Learn about design considerations and recommendations for operations management in the Azure App Service landing zone accelerator
author: BrianBlanchard
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Operations management considerations for the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for operations management when using the Azure App Service landing zone accelerator. Operations management covers multiple aspects including:

- Application Gateway
- Traffic Manager
- Geographic Redundancy
- Preparing for business continuity and disaster recovery

Learn more about the [management](../../../ready/landing-zone/design-area/management.md) design area.

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service.

- If an Application Gateway is used along with [App Service](/azure/app-service/networking/app-gateway-with-service-endpoints) or [App Service Environment](/azure/app-service/environment/integrate-with-application-gateway#:~:text=The%20integration%20of%20the%20application%20gateway%20with%20the,specific%20apps%20in%20your%20ILB%20App%20Service%20Environment.), consider Recovery Point Objective (RPO) and Recovery Time Objective(RTO) requirements, as those will dictate if App Gateway needs to be deployed in:
  - Single region or multiregion
  - Active-Active or Active-Standby Configuration

- Consider whether a single point of entry or multiple entry points is required based on where the requests are coming from. This will facilitate decision for [Traffic Manager](/azure/traffic-manager/traffic-manager-overview) or [Azure Front Door](/azure/frontdoor/front-door-overview)
  - Is cost a concern?
  - Is latency or an extra hop a concern?
  - Any third-party solution used to direct traffic to App Gateway?
- Backup of App Gateway configuration – Only ARM Template? Where is it stored and how it’ll be utilized – Manually or through automation e.g., ADO pipelines?
- Consider the [information that can be backed up](/azure/app-service/manage-backup#what-gets-backed-up) and the [requirements and restrictions](/azure/app-service/manage-backup#requirements-and-restrictions)

### Multi-Tenanted

- If your application needs to be redundant across regions, deploy the solution in more than one region and use Traffic Manager or Azure Front Door to balance load between these deployments.
- If your application spans geographies, consider deploying to a single region in each applicable geography and use Traffic Manager or Azure Front Door to provide geography-based routing.  This will provide enhanced performance and increased redundancy.
- If you need to recover from a disaster, consider if redeploying the application from a CI/CD process would be adequate.  Also consider that a web app is a component in a larger solution, and you will need to consider the DR processes for the other components in the solution.

### App Service Environment

- Guidance on designing an [ASE-based solution for high availability within a region](/azure/architecture/reference-architectures/enterprise-integration/ase-high-availability-deployment)
- Guidance on [geographic redundancy](/azure/app-service/environment/app-service-app-service-environment-geo-distributed-scale)

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of App Service.

### Multi-Tenanted

- Deploy your App Service solution to at least two regions, and possibly to multiple geographies, if required.
- Utilize Azure Front Door to provide load balancing and WAF capabilities between the different deployments.
- Modify your CI/CD processes so that changes to the solution are deployed to each target region.
- Ensure that your CI/CD processes are set up to redeploy the solution in case a disaster impacts one or more of the deployments.

### App Service Environment

- Deploy one instance of the ASE in two separate Availability Zones in the same region, or in two different regions if cross-regional high availability is required.
- Where your ASE instances are deployed across Availability Zones in the same region, use Azure Application Gateway to provide load balancing and WAF capabilities between the instances.
- Where cross-regional high availability is required, utilize Azure Front Door to provide load balancing and WAF capabilities between the different instances.
- Modify your CI/CD processes so that changes to the solution are deployed to each target ASE instance.
