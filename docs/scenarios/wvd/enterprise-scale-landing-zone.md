---
title: Enterprise-scale support for Azure Virtual Desktop
description: Learn how enterprise-scale support for the Azure Virtual Desktop construction set can accelerate your adoption of Azure Virtual Desktop.
author: wahidsaleemi
ms.author: wasaleem
ms.date: 03/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Enterprise-scale support for Microsoft Azure Virtual Desktop

The Microsoft Azure Virtual Desktop (AVD) Landing Zone Accelerator provides a specific architectural approach and reference implementation for preparing landing zone subscriptions for an enterprise Azure Virtual Desktop (AVD) deployment.

Its reference implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones with a particular focus on the enterprise-scale design principles. Although this implementation can be deployed in any Azure environment that complies with the [prerequisites](https://github.com/Azure/avdaccelerator/wiki/Getting-Started#Getting-Started), It is recommended to use this solution after implementing an enterprise-scale landing zone, [enterprise-scale overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md) before deploying the enterprise-scale for Azure Virtual Desktop solution.

This Azure Virtual Desktop solution is open source. You can adapt its templates to create an architecture that meets your specific needs. This article's guidance includes design considerations for building an enterprise ready Azure Virtual Desktop deployment.

## Adopt Azure Virtual Desktop Landing Zone Accelerator

Not everyone adopts Azure Virtual Desktop in the same way; architectures vary between organizations. This landing zone accelerator's technical considerations and design recommendations might result in trade-offs based on your organization's needs.

Some variation is normal. If you follow the core recommendations, your resulting architecture will prepare your organization for sustainable scaling. The Azure Virtual Desktop Landing Zone Accelerator is modular by design to let you customize environmental variables.

### Design guidelines

Learn the guidelines that direct the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. The guidelines cover eight critical design areas:

- [Enterprise enrollment](./eslz-enterprise-enrollment.md)
- [Identity and access management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Resource organization](./eslz-resource-organization.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

### Architecture

The following diagram shows a conceptual reference architecture that demonstrates major design areas and design best practices in an AVD environment.

[![Diagram of a reference architecture for an Azure Virtual Desktop environment.](./media/azure-virtual-desktop-architecture.png)](./media/azure-virtual-desktop-architecture.png#lightbox)

## Deploy Azure Virtual Desktop with the Landing Zone Accelerator

The Azure Virtual Desktop Landing Zone Accelerator includes an open source collection of Azure Resource Manager and Bicep templates to help you set up your Azure Virtual Desktop environment quickly following best practices and Cloud Adoption Framework. The accelerator will create an Azure Virtual Desktop environment including virtual machines, virtual networks, and storage in Azure.

The Azure Virtual Desktop Accelerator is available in the [`AVD Accelerator`](https://github.com/Azure/avdaccelerator) GitHub repository. It contains Infrastructure as Code based on [`Common Azure Resource Modules Library or CARML`](https://github.com/Azure/ResourceModules). The Azure Virtual Desktop Landing Zone Accelerator ([`deployment prerequisites`](https://github.com/Azure/avdaccelerator/wiki/Getting-Started#Getting-Started)) can be deployed using  integration into your CD/CI pipeline(s), command line [`PowerSell or Azure CLI`](https://github.com/Azure/avdaccelerator/tree/main/workload/bicep) or Azure portal deployments:

**Optional: Custom Image Build:**
Deploy a custom image based on the latest version of the Azure Marketplace image to an Azure Compute Gallery.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Favdaccelerator%2Fmain%2Fworkload%2Farm%2Fdeploy-custom-image.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Favdaccelerator%2Fmain%2Fworkload%2Fportal-ui%2Fportal-ui-custom-image.json)

**AVD Accelerator Baseline:**
Deploy Azure Virtual Desktop (AVD) resources and dependent services for establishing the baseline

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Favdaccelerator%2Fmain%2Fworkload%2Farm%2Fdeploy-baseline.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Favdaccelerator%2Fmain%2Fworkload%2Fportal-ui%2Fportal-ui-baseline.json)

The Azure Virtual Accelerator can be used as initial deployment of Azure Virtual Desktop in the enterprise environment. You can develop and customize the code to expand its functionality and/or adapt to your Enterprise-Scale Azure Landing Zones environment.

The Azure Virtual Desktop Accelerator is designed to deploy an Azure Virtual Desktop workload and it is recommended to couple it with an Enterprise-Scale landing zone deployment. See [Deploying Enterprise-Scale Architecture in your own environment](https://github.com/Azure/Enterprise-Scale#deploying-enterprise-scale-architecture-in-your-own-environment).

## Next steps

Review the critical design considerations and recommendations for identity and access management specific to the deployment of Azure Virtual Desktop.

> [!div class="nextstepaction"]
> [Identity and access management](./eslz-identity-and-access-management.md)
