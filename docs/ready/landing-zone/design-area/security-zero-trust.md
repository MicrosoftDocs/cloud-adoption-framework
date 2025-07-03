---
title: Incorporate Zero Trust practices in your landing zone
description: Learn how to incorporate Zero Trust-specific deployment objectives in your landing zone design areas, including specific guidance for each design area.
author: brsteph
ms.author: pnp
ms.date: 02/27/2025
ms.topic: conceptual
---

# Incorporate Zero Trust practices in your landing zone

[Zero Trust](/security/zero-trust/zero-trust-overview) is a security strategy in which you incorporate products and services into your design and implementation to adhere to the following security principles:

- **Verify explicitly**: always authenticate and authorize access based on all available data points.

- **Use least-privilege access**: limit users to just-enough access, and use tools to provide just-in-time access with considerations to adaptive risk-based policies.
- **Assume breach**: minimize the blast radius and segment access, proactively look for threats, and continually improve defenses.

If your organization adheres to the Zero Trust strategy, you should incorporate Zero Trust-specific deployment objectives into your landing zone design areas. Your landing zone is the foundation of your workloads in Azure, so it's important to prepare your landing zone for Zero Trust adoption.

This article provides guidance for integrating Zero Trust practices into your landing zone and explains where adherence to Zero Trust principles requires solutions outside your landing zone.

## Zero Trust pillars and landing zone design areas

When you implement Zero Trust practices in your Azure landing zone deployment, you should begin by considering the Zero Trust guidance for each landing zone design area.

For considerations about designing a landing zone and guidance for critical decisions in each area, see [Azure landing zone design areas](../design-areas.md).

The Zero Trust model has pillars that are organized by concepts and deployment objectives. For more information, see [Deploying Zero Trust solutions](/security/zero-trust/deploy/overview).

These pillars provide specific deployment objectives that help organizations align with Zero Trust principles. These objectives go beyond technical configurations. For example, the networking pillar has a deployment objective for network segmentation. The objective doesn't provide information on how to configure isolated networks in Azure but instead offers guidance for creating the architecture pattern. There are other design decisions to consider when you implement a deployment objective.

The following diagram shows the landing zone design areas.

:::image type="content" source="./media/zero-trust-architecture.svg" alt-text="Diagram that shows the architecture of an Azure landing zone." lightbox="./media/zero-trust-architecture.svg":::

The following table correlates the Zero Trust pillars to the design areas shown in the architecture.

| Legend | Landing zone design area | Zero Trust pillar |
|--|--|--|
| ![The letter A](../media/diagram-legends/a.png) | [Azure billing and Microsoft Entra tenant](./azure-billing-microsoft-entra-tenant.md) | [Identity pillar](/security/zero-trust/deploy/identity) |
| ![The letter B](../media/diagram-legends/b.png) | [Identity and access management](./identity-access.md) |[Identity pillar](/security/zero-trust/deploy/identity), <br> [Applications pillar](/security/zero-trust/deploy/applications),<br> [Data pillar](/security/zero-trust/deploy/data) |
| ![The letter C](../media/diagram-legends/c.png) | [Resource organization](./resource-org.md) | [Identity pillar](/security/zero-trust/deploy/identity) |
| ![The letter C](../media/diagram-legends/c.png) ![The letter D](../media/diagram-legends/d.png) | [Governance](../design-area/governance.md) | [Visibility, automation, and orchestration pillar](/security/zero-trust/deploy/visibility-automation-orchestration) |
| ![The letter D](../media/diagram-legends/d.png) ![The letter G](../media/diagram-legends/g.png) ![The letter H](../media/diagram-legends/h.png) | [Management](../design-area/management.md) | [Endpoints pillar](/security/zero-trust/deploy/endpoints), <br> [Applications pillar](/security/zero-trust/deploy/applications),<br> [Data pillar](/security/zero-trust/deploy/data),<br> [Infrastructure pillar](/security/zero-trust/deploy/infrastructure) |
| ![The letter E](../media/diagram-legends/e.png) | [Network topology and connectivity](./network-topology-and-connectivity.md) | [Networks pillar](/security/zero-trust/deploy/networks) |
| ![The letter F](../media/diagram-legends/f.png) | [Security](../design-area/security.md) | [All Zero Trust pillars](/security/zero-trust/deploy/overview) |
| ![The letter I](../media/diagram-legends/i.png) | [Platform automation and DevOps](../design-area/platform-automation-devops.md) | [Visibility, automation, and orchestration pillar](/security/zero-trust/deploy/visibility-automation-orchestration) |

Not all of the Zero Trust deployment objectives are part of a landing zone. Many Zero Trust deployment objectives are for designing and releasing individual workloads to Azure.

The following sections review each pillar and provide considerations and recommendations for implementing deployment objectives.

## Secure identity

For information about deployment objectives for securing identity, see [Securing identity with Zero Trust](/security/zero-trust/deploy/identity). To implement these deployment objectives, you can apply identity federation, Conditional Access, identity governance, and real-time data operations.

#### Identity considerations

- You can use [Azure landing zone reference implementations](/azure/architecture/landing-zones/landing-zone-deploy#platform) to deploy resources that extend your existing identity platform into Azure, and manage the identity platform by implementing Azure best practices.

- You can configure many of the controls for Zero Trust practices in your Microsoft Entra tenant. You can also control access to Microsoft 365 and other cloud services that use Microsoft Entra ID.
- You must plan configuration requirements beyond what's in your Azure landing zone.

#### Identity recommendations

- Develop a plan for managing identities in Microsoft Entra ID that go beyond Azure resources. For example, you can use:
  - Federation with on-premises identity systems.
  - Conditional Access policies.
  - User, device, location, or behavior information for authorization.

- Deploy your Azure landing zone with separate subscriptions for identity resources, like domain controllers, so you can better secure access to resources.
- Use Microsoft Entra managed identities where possible.

## Secure endpoints

For information about deployment objectives for securing endpoints, see [Secure endpoints with Zero Trust](/security/zero-trust/deploy/endpoints). To implement these deployment objectives, you can:

- Register endpoints with cloud identity providers to provide access to resources solely through cloud-managed compliant endpoints and apps.

- Enforce data loss prevention (DLP) and access control for both corporate devices and personal devices that are enrolled in *bring your own device* (BYOD) programs.
- Monitor the device risk for authentication with endpoint threat detection.

#### Endpoint considerations

- Endpoint deployment objectives are for end-user compute devices, such as laptops, desktop computers, and mobile devices.

- As you adopt Zero Trust practices for endpoints, you must implement solutions in Azure and outside Azure.
- You can use tools, such as Microsoft Intune and other device management solutions, to realize deployment objectives.
- If you have endpoints in Azure, such as in Azure Virtual Desktop, you can enroll the client experience in Intune, and apply Azure policies and controls to restrict access to the infrastructure.

#### Endpoint recommendations

- Develop a plan for managing endpoints with Zero Trust practices, in addition to your plans to implement an Azure landing zone.

- For other information about devices and servers, see [Secure infrastructure](#secure-infrastructure).

## Secure applications

For information about deployment objectives for securing applications, see [Secure applications with Zero Trust](/security/zero-trust/deploy/applications). To implement these deployment objectives, you can:

- Use APIs to gain visibility into applications.

- Apply policies to protect sensitive information.
- Apply adaptive access controls.
- Limit the reach of shadow IT.

#### Application considerations

- The deployment objectives for applications focus on managing both third-party and first-party applications in your organization.

- The objectives don't address securing application infrastructure. Instead, they address securing the consumption of applications, especially cloud applications.
- The Azure landing zone practices don't provide detailed controls for application objectives. These controls are configured as part of the application configuration.

#### Application recommendations

- Use [Microsoft Defender for Cloud Apps](https://www.microsoft.com/security/business/siem-and-xdr/microsoft-defender-cloud-apps) to manage access to applications.

- Use the standardized policies included in Defender for Cloud Apps to enforce your practices.
- Develop a plan to onboard your applications to your practices for application access. Don't trust applications that your organization hosts any more than you trust third-party applications.

## Secure data

For information about deployment objectives for securing data, see [Secure data with Zero Trust](/security/zero-trust/deploy/data). To implement these objectives, you can:

- Classify and label data.
- Enable access control.
- Implement data loss protection.

For information about logging and managing data resources, see [Azure landing zone reference implementations](/azure/architecture/landing-zones/landing-zone-deploy#platform).

A Zero Trust approach involves extensive controls for data. From an implementation stand point, [Microsoft Purview](/purview/purview) provides tools for data governance, protection, and risk management. You can use Microsoft Purview as part of a [cloud-scale analytics](../../../scenarios/cloud-scale-analytics/index.md) deployment to provide a solution that you can implement at scale.

#### Data considerations

- In accordance with the landing zone subscription democratization principle, you can create access and network isolation for data resources, and also establish logging practices.

  There are [policies](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies) in the reference implementations for logging and managing data resources.

- You need other controls beyond securing Azure resources to meet the deployment objectives. Zero Trust data security involves classifying data, labeling it for sensitivity, and controlling data access. It also extends beyond database and file systems. You need to consider how to protect data in Microsoft Teams, Microsoft 365 Groups, and SharePoint.

#### Data recommendations

- [Microsoft Purview](/purview/purview) provides tools for data governance, protection, and risk management.

- Implement Microsoft Purview as part of a [cloud-scale analytics](../../../scenarios/cloud-scale-analytics/index.md) deployment to implement your workload at scale.

## Secure infrastructure

For information about deployment objectives for securing infrastructure, see [Secure infrastructure with Zero Trust](/security/zero-trust/deploy/infrastructure). To implement these objectives, you can:

- Monitor abnormal behavior in workloads.
- Manage infrastructure identities.
- Limit human access.
- Segment resources.

#### Infrastructure considerations

- Infrastructure deployment objectives include:
  - Managing Azure resources.
  - Managing operating system environments.
  - Accessing systems.
  - Applying workload-specific controls.

- You can use the landing zone subscription model to create clear security boundaries to Azure resources, and assign limited permissions as needed at the resource level.
- Organizations need to organize their workloads for management.

#### Infrastructure recommendations

- Use the standard [Azure landing zone policies](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies) to block noncompliant deployments and resources, and to enforce logging patterns.

- Configure [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) in Microsoft Entra ID to provide just-in-time access to highly privileged roles.
- Configure [just-in-time access](/azure/defender-for-cloud/just-in-time-access-usage) in Defender for Cloud for your landing zone to restrict access to virtual machines.
- Create a plan to monitor and manage individual workloads that are deployed in Azure.

## Secure networks

For information about deployment objectives for securing networks, see [Secure networks with Zero Trust](/security/zero-trust/deploy/networks). To implement these objectives, you can:

- Implement network segmentation.
- Use cloud-native filtering.
- Implement least-access privilege.

#### Network considerations

- To ensure that your platform resources support the Zero Trust security model, you must deploy firewalls that are capable of HTTPS traffic inspection and isolate identity and management network resources from the central hub.

- In addition to the networking resources in the connectivity subscription, you need to create plans to micro-segment individual workloads in their spoke virtual networks. For example, you can define traffic patterns and create fine-grained network security groups for each workload network.

#### Network recommendations

- Use the following Zero Trust-specific deployment guides to deploy your Azure landing zone:
  - [Azure landing zone portal accelerator deployment with Zero Trust network principles](https://github.com/Azure/Enterprise-Scale/blob/main/docs/wiki/Deploying-ALZ-ZTNetwork.md)
  - [Deploy networking with Zero Trust network principles](https://github.com/Azure/ALZ-Bicep/blob/main/docs/wiki/DeploymentGuideHSZT.md)
  - [Azure landing zone Terraform deployment with Zero Trust network principles](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/blob/main/docs/wiki/%5BExamples%5D-Deploy-ZT-Network.md)

- For information about how to apply Zero Trust principles to the application delivery, see [Zero Trust network for web applications](/azure/architecture/example-scenario/gateway/application-gateway-before-azure-firewall).
- For information about how to create a plan for workload networking, see [Zero Trust deployment plans with Azure](/security/zero-trust/apply-zero-trust-azure-services-overview).

## Visibility, automation, and orchestration

For information about deployment objectives for visibility, automation, and orchestration, see [Visibility, automation, and orchestration with Zero Trust](/security/zero-trust/deploy/visibility-automation-orchestration). To implement these objectives, you can:

- Establish visibility.
- Enable automation.
- Enable additional controls by practicing continual improvement.

#### Visibility, automation, and orchestration considerations

- The [Azure landing zone reference implementations](/azure/architecture/landing-zones/landing-zone-deploy#platform) contain deployments of [Microsoft Sentinel](/azure/sentinel/overview) that you can use to quickly establish visibility in your Azure environment.

- The reference implementations provide policies for Azure logging, but additional integration is needed for other services.
- You should configure automation tools, like Azure DevOps and GitHub, to send signals.

#### Visibility, automation, and orchestration recommendations

- Deploy Microsoft Sentinel as part of your Azure landing zone.

- Create a plan to integrate signals from Microsoft Entra ID and tools into Microsoft 365 to your Microsoft Sentinel workspace.
- Create a plan for conducting threat-hunting exercises and continual security improvements.

## Next steps

- [Security in the Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/secure)
- [Apply Zero Trust principles to Azure services](/security/zero-trust/apply-zero-trust-azure-services-overview)
- [Evaluate your Zero Trust security posture](https://www.microsoft.com/security/business/zero-trust/maturity-model-assessment-tool)
