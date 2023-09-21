---
title: Zero Trust Planning for Landing Zones
description: Learn about starting your Zero Trust journey with Azure Landing Zones
author: brsteph
ms.author: bstephenson
ms.date: 09/20/2023
ms.topic: conceptual
ms.custom: 
---

# Zero Trust Planning for Landing Zones

[Zero Trust](../../../../security/zero-trust/) is a security strategy that leverages many products and services in order to adhere to the following security principles:

- **Verify explicitly**, where you always authenticate and authorize based on all available data points.
- **Use least privilege access**, where you limit user access to just enough access, and use tools to provide just in time access with considerations to adaptive risk-based policies.
- **Assume breach**, where you minimize blast radius and segment access, are always proactively looking for threats, and are continually improving defenses.

If your organization is adhering to the Zero Trust strategy, you should include it in your Landing Zone design.  Your Landing Zone will be the foundation of your workloads in Azure, so have it ready to lead the way to Zero Trust adoption.

## Zero Trust Pillars

Zero trust implementation is broken up in to several pillars, all detailed in the [Deploying Zero Trust solutions](../../../../zero-trust/deploy/overview) article in the Zero Trust implementation guidance.  There are specific practices that should be adopted for each pillar.  Note that these are not just technical configurations, but practices to adopt the above principles.

Use the below guide for each pillar to address how you will adopt Zero Trust as part of your Landing Zone.

### Identity Pillar

The [Identity Pillar](../../../../zero-trust/deploy/identity) has deployment objectives focused on identity federation, conditional access, identity governance, and the use of real time data as part of the decisions for authentication.

From a technology stand point, many of these controls are in Entra ID, and are used by the Microsoft 365 and Dynamics 365 cloud services as well as Azure.  Securing your identity is a foundational part of your security practices, so your organization should look hard at how to adopt these controls.

Refer to the [Identity design area](identity-access) for more on how you should design for identity in Azure Landing Zones.

The [Azure Landing Zone reference implementations](../../enterprise-scale/implementation#reference-implementation) contains a good foundation for Zero Trust adoption.  It plans for the extension of your existing identity platform to Azure, and contains governance to restrict access to these resources.  There are also built in logging controls.

### Endpoints Pillar

The [Endpoints Pillar](../../../../zero-trust/deploy/endpoints) has deployment objectives focused on ...

### Applications Pillar

The [Applications Pillar](../../../../zero-trust/deploy/applications) has deployment objectives focused on ...

### Data Pillar

The [Data Pillar](../../../../zero-trust/deploy/data) has deployment objectives focused on classifying and labeling data, access control, and data loss protection.

The landing zone subscription model creates access and network isolation for data resources, and proper logging provides a foundation.  There are policies inside of the [Azure Landing Zone reference implementations](../../enterprise-scale/implementation#reference-implementation) for the logging and management of data resources.

However, a zero trust approach to data involves deeper controls.  From an implementation stand point, [Microsoft Purview](../../../../purview/purview) provides tools for data governance, protection, and risk management.  Implementing Purview as part of a [Cloud-scale Analytics](../../../scenarios/cloud-scale-analytics/) deployment can provide a solution to implement at scale.

### Infrastructure Pillar

The [Infrastructure Pillar](../../../../zero-trust/deploy/data) has deployment objectives focused on monitoring abnormal behavior in workloads, managing identities used by infrastructure, limiting human access, and using resource segmentation.

The landing zone subscription model creates access resolution to Azure resources that can provide a good baseline for further isolation.  In addition, the configuration of services like [Privileged Identity Management](../../../../azure/active-directory/privileged-identity-management/pim-configure) and [Just In Time Access](../../../../azure/defender-for-cloud/just-in-time-access-usage) in Defender for Cloud as part of your Landing Zone can be used to advance these deployment objectives.

The [Azure Landing Zone reference implementations](../../enterprise-scale/implementation#reference-implementation) provides policies to block unauthorized deployments and to grant access.  However, because there are considerations for individual workloads that will be adopted in to Azure later, you will need to evaluate the workloads as well to make sure that they are following your zero trust requirements.

### Networks Pillar

The [Networks Pillar](../../../../zero-trust/deploy/networks) has deployment objectives focused on network segmentation, using cloud native filtering, and least access.

Because the [Azure Landing Zone reference implementations](../../enterprise-scale/implementation#reference-implementation) contains Connectivity resources for hybrid connectivity, firewalling, and network isolation, there are detailed guides for deploying out the Landing Zone to support Zero Trust networking.  You can find them at the following locations:

- [Azure landing zone portal accelerator deployment with Zero Trust network principles](https://github.com/Azure/Enterprise-Scale/blob/main/docs/wiki/Deploying-ALZ-ZTNetwork.md)
- [Deploy Networking with Zero Trust network principles](https://github.com/Azure/ALZ-Bicep/blob/main/docs/wiki/DeploymentGuideHSZT.md)
- [Azure landing zone Terraform deployment with Zero Trust network principles](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/blob/main/docs/wiki/%5BExamples%5D-Deploy-ZT-Network.md)

Following these guides will apply Zero Trust principles to your connectivity resources.  However, there are application-based considerations to make as well, such as with web application firewalls.

You can review the [Zero-trust network for web applications](../../../../azure/architecture/example-scenario/gateway/application-gateway-before-azure-firewall) reference architecture, as well as use the [Zero Trust deployment plans with Microsoft Azure](../../../../security/zero-trust/apply-zero-trust-azure-services-overview) for references for how to apply these network principles to your Azure workloads that are deployed to your landing zones.

### Visibility, Automation, and Orchestration Pillar

The [Visibility, Automation, and Orchestration Pillar Pillar](../../../../zero-trust/deploy/visibility-automation-orchestration) has deployment objectives focused on ...

## Next Steps

- Review [Security in the Microsoft Cloud Adoption Framework for Azure](../../../../azure/cloud-adoption-framework/secure/) for other guidance on adopting your security framework.

- Review the [Zero Trust deployment plans with Microsoft Azure](../../../../security/zero-trust/apply-zero-trust-azure-services-overview) for technical guidance on applying Zero Trust principles to services.

- Take the [Evaluate your Zero Trust security posture](https://www.microsoft.comsecurity/business/zero-trust/maturity-model-assessment-tool) to assess your position in adopting Zero Trust.
