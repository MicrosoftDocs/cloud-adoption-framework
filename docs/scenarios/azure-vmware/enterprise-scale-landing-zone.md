---
title: Landing Zone Accelerator for Microsoft Azure VMware Solution
description: Learn how the Microsoft Azure VMware Solution landing zone accelerator can speed adoption of Microsoft Azure VMware Solution.
author: pgandham
ms.author: pnp
ms.reviewer: tozimmergren
ms.date: 01/20/2025
ms.topic: conceptual
ms.custom: e2e-azure-vmware, think-tank, engagement-fy23
---

# Azure VMware Solution landing zone accelerator

The Microsoft Azure VMware Solution landing zone accelerator is an open-source collection of Azure Resource Manager, Bicep and Terraform templates. It represents the strategic design path and target technical state for an Azure VMware Solution deployment. This open-source solution provides an architectural approach and reference implementation to prepare Azure landing zone subscriptions for a scalable Azure VMware Solution. The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones, focusing on enterprise-scale design principles.

The Azure VMware Solution accelerator provides a reference implementation for a scalable Azure VMware Solution in your landing zone. The design decisions your organization makes, based on the guidance provided by the accelerator, lay the groundwork for scalability.

Customers adopt Azure VMware Solution in various ways. You can adapt the enterprise scale for your Azure VMware Solution set to produce an architecture that fits your needs and puts your organization on a path to a sustainable scale.

The Azure VMware Solution landing zone accelerator has the following features:

- Design guidelines to aid in evaluating critical decisions.
- A modular approach to customize environment variables.
- Landing zone architecture.
- An implementation that includes:
  - A deployable reference to create the environment for your Azure VMware Solution deployment.
  - A Microsoft-approved Azure VMware Solution reference implementation to test the deployed environment.

## Design guidelines

The following articles provide guidelines for creating your Azure VMware Solution landing zone:

- [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
- [Network topology and connectivity for Azure VMware Solution](./eslz-network-topology-connectivity.md)
- [Network considerations for Azure VMware Solution dual-region deployments](./eslz-dual-region-network-topology.md)
- [Management and monitoring for an Azure VMware Solution enterprise-scale scenario](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery for Azure VMware Solution enterprise-scale scenario](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance for Azure VMware Solution](./eslz-security-governance-and-compliance.md)
- [Platform automation for Azure VMware Solution enterprise-scale scenario](./eslz-platform-automation-and-devops.md)

## Architecture

The following architecture diagram is an example that shows design areas and best practices.

:::image type="content" source="./media/enterprise-scale-architecture-azure-vmware-solution.svg" alt-text="Diagram that shows the Azure VMware Solution landing zone accelerator architecture." lightbox="./media/enterprise-scale-architecture-azure-vmware-solution.svg" border="false":::

## Deploy Azure VMware Solution resources and dependent services

The Azure VMware Solution accelerator can be used as the initial deployment of Azure VMware Solution in the enterprise environment. You can develop and customize the code to expand its functionality and/or adapt to your Enterprise-Scale Azure Landing Zones environment.

There are various implementation options for Azure VMware Solution using automation. These methodologies can be used in both "Brownfield" and "Greenfield" scenarios.

#### Automated Azure VMware Solution implementation options

| Implementation option                                 | Description                        | Deployment link to GitHub repo |
| ------------------------------------------------- | ------------------------------------------ | --------------------------|
| Deploy Azure VMware Solution and dependencies ***with*** a connection to Azure  | This deployment is best suited provisioning a new Azure VMware Solution private cloud. It's a full-fledged version of deployment and helps you create all the different supporting components. These components include Azure connectivity, monitoring and addons. <br><br> There are three deployment options: Azure portal UI, PowerShell, and Terraform. Each deployment option lets you choose to deploy the following resources: <br><br/>▪ Azure VMware Solution private cloud <br/>▪ Choose New or Existing virtual network (VNet) <br/>▪ Deploy Azure Route Server for VPN Connections (_Optional_) <br/>▪ Deploy Azure VMware Solution Monitoring (_Optional_) <br/>▪ Deploy HCX and SRM (_Optional_) | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2FPortalUI%2FARM%2FESLZDeploy.deploy.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2FPortalUI%2FARM%2FESLZdeploy.PortalUI.json)  (_Azure portal UI_) <br><br> [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/AVS-Landing-Zone/GreenField/Bicep)(_PowerShell_)   <br><br>[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/AVS-Landing-Zone/GreenField/Terraform)(_Terraform module_) |
| Deploy Azure VMware Solution ***without*** a connection to Azure| This deployment is a lighter version. It's better suited for a proof of concept (POC) or pilot. It lets you deploy the following resources:<br><br>▪ New Azure VMware Solution private cloud: (1) custom resource group name and private cloud name or (2) choose an existing Azure VMware Solution private cloud. <br/>▪ Deploy Azure VMware Solution Monitoring (_Optional_). <br/>▪ Deploy HCX and SRM (_Optional_). | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.deploy.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.PortalUI.json) (_Azure portal UI_) |


## Next steps

Review design considerations and recommendations related to identity and access management specific to the deployment of Azure VMware Solution.

> [!div class="nextstepaction"]
> [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
