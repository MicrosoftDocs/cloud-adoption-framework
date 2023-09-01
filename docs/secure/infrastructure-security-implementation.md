---
title: Infrastructure security implementation
description: Learn about implementation for your organization in the context of infrastructure security.
author: mpvenables
ms.author: mas
ms.date: 06/17/2022
ms.topic: conceptual
ms.custom: internal
---

# Infrastructure security implementation

This article describes implementation for your organization in the context of infrastructure security.

## Implementation

Follow the Cloud Adoption Framework guidance for deploying Azure landing zones. A landing zone is a starting point to incrementally mature toward the target architecture aligned with best practices. To get started with landing zones, see [What is an Azure landing zone?](../ready/landing-zone/index.md)

> [!NOTE]
> Your organization might already have an environment that needs modification to align to the Azure landing zone target architecture and best practices. To understand the decision points and technical approach to refactoring environments to align with the Ready methodology, see [Transition existing Azure environments](../ready/enterprise-scale/transition.md).

## Infrastructure as code

Security teams should encourage infrastructure teams to adopt Infrastructure as code (IaC) approaches and integrate security controls natively into the process. Automation helps make security easier, more consistent, and more effective. The benefits of this approach include:

- Implement controls as immutable code that is repeatable, auditable, and ensures proper security governance. This approach eliminates environmental drift during release.
- Deploy faster, more consistently, and at scale with a unified set of practices and tools to deliver applications and their infrastructure rapidly and reliably.
- Test applications in production-like environments early in the development cycle.
- Prevent common deployment issues through validation and testing.

Azure Resource Manager is a deployment and management service. Deployments of Azure Resource Manager and [Azure landing zones Bicep module](https://github.com/Azure/ALZ-Bicep) require access at the tenant root (/) scope. Confirm permissions to complete the deployments. For more information, see [Security in the Azure landing zone accelerator](/azure/role-based-access-control/elevate-access-global-admin).

> [!NOTE]
> The Azure landing zones Terraform module doesn't always require these permissions.

## Azure landing zone accelerators

Your organization might decide not to use IaC options. Azure landing zone accelerators deploy Azure Resource Manager templates within a portal experience with pre-provisioned code, with tools and controls to quickly reach a security baseline. Read more about [security tools and controls](../ready/landing-zone/design-area/security.md#security-in-the-azure-landing-zone-accelerator) deployed in the Azure landing zone accelerators.

If your organization is considering IaC deployment options, we recommend that you deploy the [Azure landing zones Bicep module](https://github.com/Azure/ALZ-Bicep) or the [Azure landing zones Terraform module](https://aka.ms/alz/tf).

Bicep templates offer the same capabilities as Azure Resource Manager templates. The templates are converted to Azure Resource Manager templates during deployment. They define the infrastructure that your organization wants to deploy through specified parameters, variables, expressions, and modules. You can use the template throughout the development lifecycle to deploy repeatable and consistent infrastructure. Deploy [Azure landing zones Bicep modules](https://github.com/Azure/ALZ-Bicep) to deliver and deploy the Azure Landing Zone conceptual architecture in a modular approach.

Terraform is an open-source IaC software tool. Read about [how to use, configure, and extend](https://aka.ms/alz/tf) the Azure landing zones Terraform module with your deployments.

## Next steps

> [!div class="nextstepaction"]
> [Infrastructure security operations and governance](infrastructure-security-operations-governance.md)
