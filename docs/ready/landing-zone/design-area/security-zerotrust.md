---
title: Zero Trust planning for landing zones
description: Learn about starting your Zero Trust journey with Azure Landing Zones
author: brsteph
ms.author: bstephenson
ms.date: 09/20/2023
ms.topic: conceptual
ms.custom: 
---

# Zero Trust planning for landing zones

[Zero Trust](/security/zero-trust/zero-trust-overview) is a security strategy that uses many products and services in order to adhere to the following security principles:

- **Verify explicitly**, where you always authenticate and authorize based on all available data points.
- **Use least privilege access**, where you limit user access to just-enough access, and use tools to provide just in time access with considerations to adaptive risk-based policies.
- **Assume breach**, where you minimize blast radius and segment access, are always proactively looking for threats, and are continually improving defenses.

If your organization is adhering to the Zero Trust strategy, you should include Zero Trust specific deployment objectives as part of your landing zone design areas.  Your landing zone is the foundation of your workloads in Azure, so have it ready to lead the way to Zero Trust adoption.

This article provides guidance for building Zero Trust into your landing zone, and call outs for where adherence to Zero Trust principles uses solutions outside of your landing zone.

## Zero Trust pillars and landing zone design areas

When planning to implement Zero Trust practices as part of your Azure landing zone deployment, you should begin by considering Zero Trust guidance as a part of each landing zone design area.

The [Azure landing zone design areas](../design-areas.md) give guidance on what to consider before deploying a landing zone and guide you through the critical decisions for each area to understand what is needed to be successful.

Zero Trust has pillars organized by concepts and deployment objectives.  Each pillar and its deployment objectives are detailed in the articles under [Deploying Zero Trust solutions](/security/zero-trust/deploy/overview).

These pillars provide specific deployment objectives that organizations should use in order to align with Zero Trust principles.  They offer targeted objectives for each pillar.  These objectives go beyond technical configurations.

For example, in the networking pillar there's a deployment objective for network segmentation.  The objective doesn't provide information on how to configure isolated networks in Azure, but instead offers guidance for creating the architecture pattern.

As a result, there are still design decisions that need to be met in order to implement the deployment objectives.

These pillars can be mapped to the design areas for Azure landing zones.  If your organization has a goal to implement Zero Trust principles, you should include a review of each pillar below.

The below table can be used to understand how to map the Zero Trust pillars to the design areas shown in the following architecture.

:::image type="content" source="../../enterprise-scale/media/ns-arch-cust-expanded.svg" alt-text="A conceptual architecture diagram of an Azure landing zone." lightbox="../../enterprise-scale/media/ns-arch-cust-expanded.svg":::

| Legend | Landing Zone Design area(s) | Zero Trust Pillar(s) |
|--|--|--|
| ![The letter A](../media/diagram-legends/a.png) | [Azure billing and Active Directory tenant](./azure-billing-ad-tenant.md) | [Identity Pillar](/security/zero-trust/deploy/identity) |
| ![The letter B](../media/diagram-legends/b.png) | [Identity and access management](./identity-access.md) |[Identity Pillar](/security/zero-trust/deploy/identity), <br> [Applications Pillar](/security/zero-trust/deploy/applications),<br> [Data Pillar](/security/zero-trust/deploy/data) |
| ![The letter C](../media/diagram-legends/c.png) | [Resource organization](./resource-org.md) | [Identity Pillar](/security/zero-trust/deploy/identity). |
| ![The letter C](../media/diagram-legends/c.png) ![The letter D](../media/diagram-legends/d.png) | [Governance](../design-area/governance.md) | [Visibility, Automation, and Orchestration Pillar](/security/zero-trust/deploy/visibility-automation-orchestration) |
| ![The letter D](../media/diagram-legends/d.png) ![The letter G](../media/diagram-legends/g.png) ![The letter H](../media/diagram-legends/h.png) | [Management](../design-area/management.md) | [Endpoints Pillar](/security/zero-trust/deploy/endpoints), <br> [Applications Pillar](/security/zero-trust/deploy/applications),<br> [Data Pillar](/security/zero-trust/deploy/data),<br> [Infrastructure Pillar](/security/zero-trust/deploy/infrastructure) |
| ![The letter E](../media/diagram-legends/e.png) | [Network topology and connectivity](./network-topology-and-connectivity.md) | [Networks Pillar](/security/zero-trust/deploy/networks) |
| ![The letter F](../media/diagram-legends/f.png) | [Security](../design-area/security.md) | [All Zero Trust Pillars](/security/zero-trust/deploy/overview) |
| ![The letter I](../media/diagram-legends/i.png) | [Platform automation and DevOps](../design-area/platform-automation-devops.md) | [Visibility, Automation, and Orchestration Pillar Pillar](/security/zero-trust/deploy/visibility-automation-orchestration) |

However, not all of the deployment objectives of Zero Trust are a part of the landing zone.  Many deployment objectives for Zero Trust are implemented as part of designing and releasing individual workloads to Azure.

The next sections review each pillar, and give recommendations and considerations for implementing the deployment objectives.

## Securing identity

The [Securing identity with Zero Trust](/security/zero-trust/deploy/identity) guidance has deployment objectives focused on identity federation, conditional access, identity governance, and the use of real time data as part of the decisions for authentication.

### Identity considerations

- The [Azure landing zone reference implementations](https://aka.ms/alz/aac#platform) deploy resources used to extend your existing identity platform in to Azure, and manage it with Azure best practices.
- Many of the controls needed for Zero Trust are configured inside of your Microsoft Entra tenant, and impact access to Microsoft 365 and other cloud services that use Microsoft Entra ID.
- As a result, you need to plan for configuration beyond just what is in your Azure landing zone.

### Identity recommendations

- Develop a plan for managing identities in Microsoft Entra ID that go beyond just Azure resources:
  - Federation with on-premises identity systems.
  - Conditional access policies.
  - The use of user, device, location, and behavior information for authorization.
- Deploy your Azure landing zone with separate subscriptions for identity resources like domain controllers, so you can better secure access to them.
- Plan to use Microsoft Entra ID identities where ever possible, such as Managed Identities.

## Securing endpoints

The [Secure endpoints with Zero Trust](/security/zero-trust/deploy/endpoints) guidance has deployment objectives focused on registering endpoints with cloud identity providers, giving access solely through cloud-managed compliant endpoints and apps.  It also includes enforcing DLP and access control on both corporate devices and personal owned devices enrolled in "Bring Your Own Device" or BYOD programs, and monitoring device risk for authentication through endpoint threat detection.

### Endpoints considerations

- Endpoint deployment objectives include end user compute devices - laptops, desktops, and mobile devices.
- Endpoint management can apply both to corporate managed devices, and individual owned devices enrolled in a "bring your own device" program.
- As you plan to adopt Zero Trust for endpoints, solutions that are broader than just what you have in Azure are needed.
- You need to use tools such as Intune and other device management solutions to complete these deployment objectives.
- If you have endpoints located in Azure, such as Azure Virtual Desktop, you can enroll the client experience in Intune while using Azure policies and controls to restrict access to the infrastructure.

### Endpoints recommendations

- Develop a plan for managing endpoints with Zero Trust practices, in addition to your plans to implement an Azure landing zone.
- For devices and servers that go beyond endpoints, see the Infrastructure Pillar for guidance.

## Securing applications

The [Secure applications with Zero Trust](/security/zero-trust/deploy/applications) guidance has deployment objectives focused on using APIs to gain visibility in to applications, using policies to protect sensitive information, using adaptive access controls, and limiting the reach of shadow IT.

### Applications considerations

- The deployment objectives for Applications focus on the management of both third party and first party applications in your organization.
- The objectives aren't focused on securing application infrastructure; instead, they're focused on securing the consumption of applications, especially cloud applications.
- As a result, the Azure landing zone practices don't provide detailed controls for these objectives; these would be configured as part of the application configuration itself.

### Applications recommendations

- Use [Defender for Cloud Apps](https://www.microsoft.com/security/business/siem-and-xdr/microsoft-defender-cloud-apps?rtc=1) to manage access to applications.
- Use the standardized policies included to enforce your practices.
- Develop a plan to onboard your applications to your practices for application access; just because your organization hosts an application, doesn't mean it should be trusted more than third party applications.

## Securing data

The [Secure data with Zero Trust](/security/zero-trust/deploy/data) guidance has deployment objectives focused on classifying and labeling data, access control, and data loss protection.
 [Azure landing zone reference implementations](https://aka.ms/alz/aac#platform) contain guidance for the logging and management of data resources.

However, a zero trust approach to data involves deeper controls.  From an implementation stand point, [Microsoft Purview](/purview/purview) provides tools for data governance, protection, and risk management.  Implementing Purview as part of a [Cloud-scale Analytics](../../../scenarios/cloud-scale-analytics/index.md) deployment can provide a solution to implement at scale.

### Data considerations

- The landing zone subscription democratization principle creates access and network isolation for data resources, and also establishes logging practices.
  - There are [policies](https://aka.ms/alz/policies) inside of the reference implementations for the logging and management of data resources.
- More controls beyond securing the Azure resources are needed to complete the deployment objectives.
  - Zero Trust data security involves classifying data, labeling it for sensitivity, and controlling data access.
  - It also extends beyond database and file systems - you need to consider how to protect data in Teams, Microsoft 365 Groups, and SharePoint sites.

### Data recommendations

- Use [Microsoft Purview](/purview/purview) provides tools for data governance, protection, and risk management.
- Implement Purview as part of a [Cloud-scale Analytics](../../../scenarios/cloud-scale-analytics/index.md) deployment to implement at scale.

## Securing infrastructure

The [Secure infrastructure with Zero Trust](/security/zero-trust/deploy/infrastructure) guidance has deployment objectives focused on monitoring abnormal behavior in workloads, managing infrastructure identities, limiting human access, and segmenting resources.

### Infrastructure considerations

- The infrastructure deployment objectives include:
  - Management for the Azure resources.
  - Management of operating system environments.
  - Access to systems.
  - Workload specific controls.
- The landing zone subscription model creates clear security boundaries to Azure resources, allowing you to assign limited permissions as needed at the Azure level.
- Organizations still need to organize their workloads for management.

### Infrastructure recommendations

- Use the standard [Azure landing zone policies](https://aka.ms/alz/policies) to block non-compliant deployments and resources, and to enforce logging patterns.
- Configure [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) in Microsoft Entra ID to provide just in time access to highly privileged roles
- Configure [Just In Time Access](/azure/defender-for-cloud/just-in-time-access-usage) in Defender for Cloud as part of your landing zone, to restrict access to virtual machines.
- Create a plan to monitor and manage individual workloads that are deployed in Azure.

## Securing networks

The [Secure networks with Zero Trust](/security/zero-trust/deploy/networks) guidance has deployment objectives focused on network segmentation, using cloud native filtering, and least access.

### Networks considerations

- Your your platform resources need to support Zero Trust.  This means deploying firewalls capable of HTTPS traffic inspection, and isolating identity and management network resources from the central hub.
- In addition to the networking resources in the Connectivity subscription, you need to create plans for individual workloads to be micro-segmented in their spoke virtual networks.  One example of this is defining traffic patterns and creating fine grained network security groups for each workload network.

### Networks recommendations

- Use Zero Trust specific deployment guides for deploying your Azure landing zone.  You can find them at the following locations:
  - [Azure landing zone portal accelerator deployment with Zero Trust network principles](https://github.com/Azure/Enterprise-Scale/blob/main/docs/wiki/Deploying-ALZ-ZTNetwork.md)
  - [Deploy Networking with Zero Trust network principles](https://github.com/Azure/ALZ-Bicep/blob/main/docs/wiki/DeploymentGuideHSZT.md)
  - [Azure landing zone Terraform deployment with Zero Trust network principles](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/blob/main/docs/wiki/%5BExamples%5D-Deploy-ZT-Network.md)
- Review the [Zero-trust network for web applications](/azure/architecture/example-scenario/gateway/application-gateway-before-azure-firewall) reference architecture to understand how to apply Zero Trust principles to application delivery.
- Use the [Zero Trust deployment plans with Microsoft Azure](/security/zero-trust/apply-zero-trust-azure-services-overview) to build a plan for workload networking.

## Visibility, automation, and orchestration

The [Visibility, automation, and orchestration with Zero Trust](/security/zero-trust/deploy/visibility-automation-orchestration) guidance has deployment objectives focused on establishing visibility, enabling automation, and enabling additional controls through continual improvement.

### Visibility, automation, and orchestration considerations

- Because the [Azure landing zone reference implementations](https://aka.ms/alz/aac#platform) contains deployments of [Microsoft Sentinel](/azure/sentinel/overview), they can help you quickly establish visibility in to your Azure environment.
- While the reference implementations provide policies for Azure logging, additional integration is needed for other services.
- Automation tools like Azure DevOps and GitHub should also be configured to send signals.

### Visibility, automation, and orchestration recommendations

- Deploy Sentinel as part of your Azure landing zone.
- Build a plan to integrate signals from Microsoft Entra ID and tools in Microsoft 365 to your Sentinel workspace.
- Build a plan to conduct threat hunting exercises and continual security improvement.

## Next Steps

- Review [Security in the Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/secure/) for other guidance on adopting your security framework.

- Review the [Zero Trust deployment plans with Microsoft Azure](/security/zero-trust/apply-zero-trust-azure-services-overview) for technical guidance on applying Zero Trust principles to services.

- Take the [Evaluate your Zero Trust security posture](https://www.microsoft.com/security/business/zero-trust/maturity-model-assessment-tool) to assess your position in adopting Zero Trust.
