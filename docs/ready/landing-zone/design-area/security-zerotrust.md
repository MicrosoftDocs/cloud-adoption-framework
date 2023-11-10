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

[Zero Trust](/security/zero-trust/zero-trust-overview) is a security strategy that uses many products and services in order to adhere to the following security principles:

- **Verify explicitly**, where you always authenticate and authorize based on all available data points.
- **Use least privilege access**, where you limit user access to just enough access, and use tools to provide just in time access with considerations to adaptive risk-based policies.
- **Assume breach**, where you minimize blast radius and segment access, are always proactively looking for threats, and are continually improving defenses.

If your organization is adhering to the Zero Trust strategy, you should include it in your landing zone design.  Your landing zone is the foundation of your workloads in Azure, so have it ready to lead the way to Zero Trust adoption.

## Zero Trust Pillars and Landing Zone Design Areas

If you are planning to implement Zero Trust practices as part of your Azure landing zone deployment, you should begin by considering Zero Trust guidance as a part of each landing zone design area.

The [Azure landing zone design areas](../design-areas.md) give guidance on what to consider before deploying a landing zone.  They guide you through the critical decisions for each area to understand what is needed to be successful.

Zero Trust has pillars organized by concepts and deployment objectives.  These are detailed in the articles under [Deploying Zero Trust solutions](/security/zero-trust/deploy/overview).

:::image type="content" source="./media/diagram-zero-trust-security-elements.png" alt-text="Diagram of elements of visibility, automation, and orchestration in Zero Trust." border="false":::

These pillars provide specific deployment objectives that organizations should use in order to align with Zero Trust principles.  They offer targeted objectives for each pillar.  These objectives go beyond technical configurations.

For example, in the networking pillar there is a deployment objective for network segmentation.  The objective does not provide information on how to configure isolated networks in Azure, but instead offers guidance for creating the architecture pattern.

As a result, there are still design decisions that need to be met in order to implement the deployment objectives.

These pillars can be mapped to the design areas for Azure landing zones.  If your organization has a goal to implement Zero Trust principles, you should include a review of each pillar below.

The below table can be used to understand how to map the Zero Trust pillars to the design areas.

:::image type="content" source="../../enterprise-scale/media/ns-arch-cust-expanded.svg" alt-text="A conceptual architecture diagram of an Azure landing zone." lightbox="../enterprise-scale/media/ns-arch-cust-expanded.svg":::

| Legend | Landing Zone Design area(s) | Zero Trust Pillar(s) |
|--|--|--|
| ![The letter A](../media/diagram-legends/a.png) | [Azure billing and Active Directory tenant](./azure-billing-ad-tenant.md) | [Identity Pillar](/security/zero-trust/deploy/identity) |
| ![The letter B](../media/diagram-legends/b.png) | [Identity and access management](./identity-access.md) |[Identity Pillar](/security/zero-trust/deploy/identity), <br> [Applications Pillar](/security/zero-trust/deploy/applications),<br> [Data Pillar](/security/zero-trust/deploy/data) |
| ![The letter C](../media/diagram-legends/c.png) | [Resource organization](./resource-org.md) | [Identity Pillar](/security/zero-trust/deploy/identity). |
| ![The letter C](../media/diagram-legends/c.png) ![The letter D](../media/diagram-legends/d.png) | [Governance](./design-area/governance.md) | [Visibility, Automation, and Orchestration Pillar](/security/zero-trust/deploy/visibility-automation-orchestration) |
| ![The letter D](../media/diagram-legends/d.png) ![The letter G](../media/diagram-legends/g.png) ![The letter H](../media/diagram-legends/h.png) | [Management](./design-area/management.md) | [Endpoints Pillar](/security/zero-trust/deploy/endpoints), <br> [Applications Pillar](/security/zero-trust/deploy/applications),<br> [Data Pillar](/security/zero-trust/deploy/data),<br> [Infrastructure Pillar](/security/zero-trust/deploy/infrastructure) |
| ![The letter E](../media/diagram-legends/e.png) | [Network topology and connectivity](./network-topology-and-connectivity.md) | [Networks Pillar](/security/zero-trust/deploy/networks) |
| ![The letter F](../media/diagram-legends/f.png) | [Security](./design-area/security.md) | [All Zero Trust Pillars](/security/zero-trust/deploy/overview) |
| ![The letter I](../media/diagram-legends/i.png) | [Platform automation and DevOps](./design-area/platform-automation-devops.md) | [Visibility, Automation, and Orchestration Pillar Pillar](/security/zero-trust/deploy/visibility-automation-orchestration) |

However, not all of the deployment objectives of Zero Trust will be accomplished by the landing zone itself.  Many deployment objectives for Zero Trust will need to be implemented as part of releasing individual workloads to Azure.

In the next sections, we will review each pillar, and give recommendations and considerations for implementing the deployment objectives.

## Identity Pillar

The [Identity Pillar](/security/zero-trust/deploy/identity) has deployment objectives focused on identity federation, conditional access, identity governance, and the use of real time data as part of the decisions for authentication.

From a technology stand point, many of these controls are in Entra ID, and are used by the Microsoft 365 and Dynamics 365 cloud services as well as Azure.  Securing your identity is a foundational part of your security practices, so your organization should look hard at how to adopt these controls.

Refer to the [Identity design area](identity-access.md) for more on how you should design for identity in Azure landing zones.

The [Azure landing zone reference implementations](https://aka.ms/alz/aac#platform) contains a good foundation for Zero Trust adoption.  It plans for the extension of your existing identity platform to Azure, and contains governance to restrict access to these resources.  There are also built in logging controls enforced via Azure Policy.



## Endpoints Pillar

The [Endpoints Pillar](/security/zero-trust/deploy/endpoints) has deployment objectives focused on registering endpoints with cloud identity providers, giving access solely through cloud-managed compliant endpoints and apps.  It also includes enforcing DLP and access control on both corporate devices and BYOD, and monitoring device risk for authentication through endpoint threat detection.

These controls are applied to the end user compute devices - laptops, desktops, mobile devices - regardless of if they're corporate managed or a "bring your own device."  As a result, these controls aren't found in the Azure configuration, but instead are configuring through the Intune portal and other device management tools.

For endpoints located in Azure, Azure Policies and other controls can be applied if needed.  Azure Virtual Desktop, for example, provides enrollment in to Intune to centrally manage client endpoints.

## Applications Pillar

The [Applications Pillar](/security/zero-trust/deploy/applications) has deployment objectives focused on using APIs to gain visibility in to applications, using policies to protect sensitive information, using adaptive access controls, and limiting the reach of shadow IT.

Some of this work is focused on providing consolidated management for both third party and first party applications in your organization.  Using [Defender for Cloud Apps](https://www.microsoft.com/security/business/siem-and-xdr/microsoft-defender-cloud-apps?rtc=1) can make the role of third party applications in your environment visible, and allow for you to plan from there.  There are also standardized policies that you can control to enforce your practices around cloud apps.

## Data Pillar

The [Data Pillar](/security/zero-trust/deploy/data) has deployment objectives focused on classifying and labeling data, access control, and data loss protection.

The landing zone subscription democratization principle and model creates access and network isolation for data resources, and proper logging provides a foundation. There are [policies](https://aka.ms/alz/policies) inside of the [Azure landing zone reference implementations](https://aka.ms/alz/aac#platform) for the logging and management of data resources.

However, a zero trust approach to data involves deeper controls.  From an implementation stand point, [Microsoft Purview](/purview/purview) provides tools for data governance, protection, and risk management.  Implementing Purview as part of a [Cloud-scale Analytics](../../../scenarios/cloud-scale-analytics/index.md) deployment can provide a solution to implement at scale.

## Infrastructure Pillar

The [Infrastructure Pillar](/security/zero-trust/deploy/infrastructure) has deployment objectives focused on monitoring abnormal behavior in workloads, managing infrastructure identities, limiting human access, and segmenting resources.

The landing zone subscription model creates access resolution to Azure resources that can provide a good baseline for further isolation.  In addition, the configuration of services like [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) and [Just In Time Access](/azure/defender-for-cloud/just-in-time-access-usage) in Defender for Cloud as part of your landing zone can be used to advance these deployment objectives.

The [Azure landing zone reference implementations](https://aka.ms/alz/aac#platform) provides and assigns [policies](https://aka.ms/alz/policies) to block non-compliant deployments and resources.

There are also considerations for individual workloads in Azure.  You'll need to evaluate the workloads as well to make sure that they are following your zero trust requirements.

## Networks Pillar

The [Networks Pillar](/security/zero-trust/deploy/networks) has deployment objectives focused on network segmentation, using cloud native filtering, and least access.

Because the [Azure landing zone reference implementations](https://aka.ms/alz/aac#platform) contains Connectivity resources for hybrid connectivity, firewalling, and network isolation, there are detailed guides for deploying out the landing zone to support Zero Trust networking.  You can find them at the following locations:

- [Azure landing zone portal accelerator deployment with Zero Trust network principles](https://github.com/Azure/Enterprise-Scale/blob/main/docs/wiki/Deploying-ALZ-ZTNetwork.md)
- [Deploy Networking with Zero Trust network principles](https://github.com/Azure/ALZ-Bicep/blob/main/docs/wiki/DeploymentGuideHSZT.md)
- [Azure landing zone Terraform deployment with Zero Trust network principles](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/blob/main/docs/wiki/%5BExamples%5D-Deploy-ZT-Network.md)

Following these guides will apply Zero Trust principles to your connectivity resources.  However, there are application-based considerations to make as well, such as with web application firewalls.

You can review the [Zero-trust network for web applications](/azure/architecture/example-scenario/gateway/application-gateway-before-azure-firewall) reference architecture to understand how to apply Zero Trust principles to application delivery.  For more hands on guidance on configuring workloads with secure networking,use the [Zero Trust deployment plans with Microsoft Azure](/security/zero-trust/apply-zero-trust-azure-services-overview).

## Visibility, Automation, and Orchestration Pillar

The [Visibility, Automation, and Orchestration Pillar](/security/zero-trust/deploy/visibility-automation-orchestration) has deployment objectives focused on establishing visibility, enabling automation, and enabling additional controls through continual improvement.

Because the [Azure landing zone reference implementations](https://aka.ms/alz/aac#platform) contains deployments of [Microsoft Sentinel](/azure/sentinel/overview), they can help you quickly establish visibility in to your Azure environment.  However, true zero trust visibility requires additional connections with Entra ID and other tools like those in Microsoft 365.  As a result, there is additional work needed to enable all of your signals to be aggregated together.

Once signals are flowing, then the work of continual threat hunting and improving the posture based on findings can begin.

## Next Steps

- Review [Security in the Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/secure/) for other guidance on adopting your security framework.

- Review the [Zero Trust deployment plans with Microsoft Azure](/security/zero-trust/apply-zero-trust-azure-services-overview) for technical guidance on applying Zero Trust principles to services.

- Take the [Evaluate your Zero Trust security posture](https://www.microsoft.com/security/business/zero-trust/maturity-model-assessment-tool) to assess your position in adopting Zero Trust.
