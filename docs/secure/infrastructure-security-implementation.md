```
author: MarkSimos
ms.author: mas
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
```

# Infrastructure security implementation, operations, and governance

This is the beginning of the Infrastructure security implementation, operations, and governance section. Advance to [Development security strategy] section.(add file.md#section-name).

## Implementation
Follow the Cloud Adoption Framework guidance for deploying Azure landing zones and get started with [Use Azure landing zones]() as a starting point to incrementally mature towards the target architecture that is best practice-aligned.

> [!NOTE]
> Your organization might already have an existing environment that needs modification to align to the Azure landing zone target architecture and best practices. Use the [transition from brownfield guidance](/azure/cloud-adoption-framework/ready/enterprise-scale/transition) to understand the decision points and technical approach to refactoring environments to align with the guidance in the Ready methodology.

## Infrastructure as code (IaC)

Security teams should encourage infrastructure teams to adopt IaC approaches and integrate security controls natively into the process. Automation helps make security easier, more consistent, and more effective. The benefits of this approach include

- implementing controls as code—immutable code that is repeatable, auditable, ensures proper security governance, and eliminates the potential for environmental drift during release.
- deploying faster, more consistently, and at scale—with a unified set of practices and tools to deliver applications and their infrastructure rapidly and reliably.
- testing applications in production-like environments early in the development cycle.
- preventing common deployment issues through validation and testing.

Using Azure Resource Manager (Azure's deployment and management service), Azure landing zones' ARM and [(ALZ) bicep module](https://github.com/Azure/ALZ-Bicep) deployments will require access at the tenant root (/) scope. Confirm RBAC permissions to complete the deployments. Read more about [elevating access to Azure subscriptions and management groups](/azure/role-based-access-control/elevate-access-global-admin?toc=%252fazure%252factive-directory%252fprivileged-identity-management%252ftoc.json).

> [!NOTE]
> The ALZ Terraform module doesn’t always require these permissions. Read this detailed guidance on GitHub.

## Azure landing zone accelerators

If your organization decides it doesn't want or simply can't use IaC options, Azure landing zone accelerators deploy ARM templates within a portal experience with pre-provisioned code, with tools and controls to quickly reach a security baseline. Read more about [security tools and controls](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security#security-in-the-azure-landing-zone-accelerator) deployed in the Azure landing zone accelerators.

If your organization is considering IaC deployment options, we recommend deployment the [Azure landing zones (ALZ) bicep module](https://github.com/Azure/ALZ-Bicep) or the [Azure landing zones Terraform module](https://aka.ms/alz/tf). Bicep templates offer the same capabilities as ARM templates—and are automatically converted to an ARM template during deployment. They define the infrastructure your organization wants to deploy through specified parameters, variables, expressions, and modules. You can use the template throughout the development lifecycle to deploy repeatable and consistent infrastructure. Deploy [Azure landing zones (ALZ) bicep modules](https://github.com/Azure/ALZ-Bicep) to deliver and deploy the Azure Landing Zone conceptual architecture in a modular approach.

Terraform is an open-source IaC software tool. Read about [how to use, configure and extend](https://aka.ms/alz/tf) the Azure landing zones Terraform module with your deployments.

## Next step

- [Operations](infrastructure-security-operations-governance.md)