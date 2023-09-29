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

[Zero Trust](/security/zero-trust/zero-trust-overview) is a security strategy that leverages many products and services in order to adhere to the following security principles:

- **Verify explicitly**, where you always authenticate and authorize based on all available data points.
- **Use least privilege access**, where you limit user access to just enough access, and use tools to provide just in time access with considerations to adaptive risk-based policies.
- **Assume breach**, where you minimize blast radius and segment access, are always proactively looking for threats, and are continually improving defenses.

If your organization is adhering to the Zero Trust strategy, you should include it in your Landing Zone design.  Your Landing Zone will be the foundation of your workloads in Azure, so have it ready to lead the way to Zero Trust adoption.

## Zero Trust Pillars

Zero trust implementation is broken up in to several pillars, all detailed in the [Deploying Zero Trust solutions](/security/zero-trust/deploy/overview) article in the Zero Trust implementation guidance.  There are specific practices that should be adopted for each pillar.  Note that these are not just technical configurations, but practices to adopt the above principles.

Use the below guide for each pillar to address how you will adopt Zero Trust as part of your Landing Zone.

### Identity Pillar

The [Identity Pillar](/security/zero-trust/deploy/identity) has deployment objectives focused on identity federation, conditional access, identity governance, and the use of real time data as part of the decisions for authentication.

From a technology stand point, many of these controls are in Entra ID, and are used by the Microsoft 365 and Dynamics 365 cloud services as well as Azure.  Securing your identity is a foundational part of your security practices, so your organization should look hard at how to adopt these controls.

Refer to the [Identity design area](identity-access.md) for more on how you should design for identity in Azure Landing Zones.

The [Azure Landing Zone reference implementations](../../enterprise-scale/implementation.md#reference-implementation) contains a good foundation for Zero Trust adoption.  It plans for the extension of your existing identity platform to Azure, and contains governance to restrict access to these resources.  There are also built in logging controls.

### Endpoints Pillar

The [Endpoints Pillar](/security/zero-trust/deploy/endpoints) has deployment objectives focused on registering endpoints with cloud identity providers, giving acces solely through cloud-managed compliant endpoints and apps, enforcing DLP and access control on both corporate devices and BYOD, and monitoring device risk for authentication through endpoint threat detection.

These controls are generally applied to the end user compute devices - laptops, desktops, mobile devices - regardless of if they are corporate managed or a "bring your own device."  As a result, these controls are not found in the Azure configuration, but instead are configuring through the Intune portal and other device management tools.

For endpoints located in Azure, Azure Policies and other controls can be applied if needed.  Azure Virtual Desktop, for example, provides enrollment in to Intune to centrally manage client endpoints.

### Applications Pillar

The [Applications Pillar](/security/zero-trust/deploy/applications) has deployment objectives focused on using APIs to gain visibility in to applications, using policies to protect sensitive information, using adaptive access controls, and limiting the reach of shadow IT.

Some of this work is focused on providing consolidated management for both third party and first party applications in your organization.  Using [Defender for Cloud Apps](https://www.microsoft.com/security/business/siem-and-xdr/microsoft-defender-cloud-apps?rtc=1) can make the role of third party applications in your environment visible, and allow for you to plan from there.  There are also standardized policies that you can control to enforce your practices around cloud apps.

### Data Pillar

The [Data Pillar](/security/zero-trust/deploy/data) has deployment objectives focused on classifying and labeling data, access control, and data loss protection.

The landing zone subscription model creates access and network isolation for data resources, and proper logging provides a foundation.  There are policies inside of the [Azure Landing Zone reference implementations](../../enterprise-scale/implementation.md#reference-implementation) for the logging and management of data resources.

However, a zero trust approach to data involves deeper controls.  From an implementation stand point, [Microsoft Purview](/purview/purview) provides tools for data governance, protection, and risk management.  Implementing Purview as part of a [Cloud-scale Analytics](../../../scenarios/cloud-scale-analytics/index.md) deployment can provide a solution to implement at scale.

### Infrastructure Pillar

The [Infrastructure Pillar](/security/zero-trust/deploy/data) has deployment objectives focused on monitoring abnormal behavior in workloads, managing identities used by infrastructure, limiting human access, and using resource segmentation.

The landing zone subscription model creates access resolution to Azure resources that can provide a good baseline for further isolation.  In addition, the configuration of services like [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) and [Just In Time Access](/azure/defender-for-cloud/just-in-time-access-usage) in Defender for Cloud as part of your Landing Zone can be used to advance these deployment objectives.

The [Azure Landing Zone reference implementations](../../enterprise-scale/implementation.md#reference-implementation) provides policies to block unauthorized deployments and to grant access.  However, because there are considerations for individual workloads that will be adopted in to Azure later, you will need to evaluate the workloads as well to make sure that they are following your zero trust requirements.

### Networks Pillar

The [Networks Pillar](/security/zero-trust/deploy/networks) has deployment objectives focused on network segmentation, using cloud native filtering, and least access.

Because the [Azure Landing Zone reference implementations](../../enterprise-scale/implementation.md#reference-implementation) contains Connectivity resources for hybrid connectivity, firewalling, and network isolation, there are detailed guides for deploying out the Landing Zone to support Zero Trust networking.  You can find them at the following locations:

- [Azure landing zone portal accelerator deployment with Zero Trust network principles](https://github.com/Azure/Enterprise-Scale/blob/main/docs/wiki/Deploying-ALZ-ZTNetwork.md)
- [Deploy Networking with Zero Trust network principles](https://github.com/Azure/ALZ-Bicep/blob/main/docs/wiki/DeploymentGuideHSZT.md)
- [Azure landing zone Terraform deployment with Zero Trust network principles](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/blob/main/docs/wiki/%5BExamples%5D-Deploy-ZT-Network.md)

Following these guides will apply Zero Trust principles to your connectivity resources.  However, there are application-based considerations to make as well, such as with web application firewalls.

You can review the [Zero-trust network for web applications](/azure/architecture/example-scenario/gateway/application-gateway-before-azure-firewall) reference architecture, as well as use the [Zero Trust deployment plans with Microsoft Azure](/security/zero-trust/apply-zero-trust-azure-services-overview) for references for how to apply these network principles to your Azure workloads that are deployed to your landing zones.

### Visibility, Automation, and Orchestration Pillar

The [Visibility, Automation, and Orchestration Pillar Pillar](/security/zero-trust/deploy/visibility-automation-orchestration) has deployment objectives focused on establishing visibility, enabling automation, and enabling additional controls through continual improvement.

Because the [Azure Landing Zone reference implementations](../../enterprise-scale/implementation.md#reference-implementation) contains deployments of [Mircosoft Sentinel](/azure/sentinel/overview), they can help you quickly establish visibility in to your Azure environment.  However, true zero trust visibility requires additional connections with Entra ID and other tools like those in M365.  As a result, there is additional work needed to enable all of your signals to be aggregated together.

Once signals are flowing, then the work of continual threat hunting and improving the posture based on findings can begin.

## Next Steps

- Review [Security in the Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/secure/) for other guidance on adopting your security framework.

- Review the [Zero Trust deployment plans with Microsoft Azure](/security/zero-trust/apply-zero-trust-azure-services-overview) for technical guidance on applying Zero Trust principles to services.

- Take the [Evaluate your Zero Trust security posture](https://www.microsoft.com/security/business/zero-trust/maturity-model-assessment-tool) to assess your position in adopting Zero Trust.
