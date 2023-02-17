---
title: Enterprise-scale for Microsoft Azure VMware Solution
description: Learn how enterprise-scale can accelerate the adoption of Microsoft Azure VMware Solution.
author: pgandham
ms.author: janet
ms.date: 06/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank
---

# Azure VMware Solution landing zone accelerator

Azure VMware Solution landing zone accelerator is an open-source collection of Azure Resource Manager and Bicep templates. It represents the strategic design path and target technical state for an Azure VMware Solution deployment. This open-source solution provides an architectural approach and reference implementation to prepare Azure landing zone subscriptions for a scalable Azure VMware Solution. The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones, with a focus on the design principles of enterprise-scale.

The AVS accelerator provides reference eimplementation for a scalable Azure VMware Solution in your landing zone. The design decisions your organization makes, based on the guidance provided by accelerator, lays the groundwork for scalability.

Customers adopt Azure VMware Solution in various ways. You can adopt the enterprise-scale for your Azure VMware Solution set to produce an architecture that fits your needs and puts your organization on a path to sustainable scale.

The Azure VMware Solution landing zone accelerator has the following features:

- A modular approach, so that you can customize environment variables
- Design guidelines to aid in evaluating critical decisions
- Landing zone architecture
- An implementation that includes:
  - A deployable reference to create the environment for your Azure VMware Solution deployment
  - A Microsoft-approved Azure VMware Solution reference implementation to test the deployed environment

## Design guidelines

The following articles provide guidelines for creating your Azure VMware Solution landing zone:

- [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
- [Network topology and connectivity for Azure VMware Solution](./eslz-network-topology-connectivity.md)
- [Management and monitoring for an Azure VMware Solution enterprise-scale scenario](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery for Azure VMware Solution enterprise-scale scenario](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance for Azure VMware Solution](./eslz-security-governance-and-compliance.md)
- [Platform automation for Azure VMware Solution enterprise-scale scenario](./eslz-platform-automation-and-devops.md)

## Architecture

The following architecture diagram is an example that shows design areas and best practices.

[![Azure VMware Solution landing zone accelerator architecture](./media/azure-vmware-eslz-architecture.png)](./media/azure-vmware-eslz-architecture.png#lightbox)

## Deploy Azure VMware Solution (AVS) resources and dependent services

The AVS Accelerator can be used as initial deployment of Azure VMware Solution in the enterprise environment. You can develop and customize the code to expand its functionality and/or adapt to your Enterprise-Scale Azure Landing Zones environment.

There are various implementaion options for AVS using automation. These methodologies can be used in both "Brownfield" and "Greenfiled" scenarios.

#### Automated AVS Implementation Options

| Implementation option                                 | Description                        | Deployment Link to Github Repo |
| ------------------------------------------------- | ------------------------------------------ | --------------------------|
| Deploy AVS and dependencies ***with*** a connection to Azure  | This deployment is best suited provisioning a new AVS Private Cloud. It's a full-fledged version of deployment and helps you create all the different supporting components. These components include Azure connectivity, monitoring and addons. <br><br> There are three deployment options: Azure portal UI, PowerShell, and Terraform. Each deployment option lets you choose to deploy the following resources: <br><br/>▪ AVS Private Cloud <br/>▪ Choose New or Existing virtual network (VNet) <br/>▪ Deploy Azure Route Server for VPN Connections (_Optional_) <br/>▪ Deploy AVS Monitoring (_Optional_) <br/>▪ Deploy HCX and SRM (_Optional_)        | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.deploy.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.PortalUI.json)(_Azure Portal UI_) <br><br> [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/AVS-Landing-Zone/GreenField/Bicep)(_Powershell_)   <br><br>[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/AVS-Landing-Zone/GreenField/Terraform)(_Terraform module_) |
| Deploy AVS ***without*** a connection to Azure| This deployment is a lighter version. It's better suited for a proof of concept (POC) or pilot. It lets you deploy the following resources:<br><br>▪ New AVS Private Cloud: (1) custom resource group name and Private Cloud name or (2) choose an existing AVS Private Cloud. <br/>▪ Deploy AVS Monitoring (_Optional_). <br/>▪ Deploy HCX and SRM (_Optional_). | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.deploy.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.PortalUI.json) (_Azure Portal UI_) |


## Next steps

Review design considerations and recommendations related to identity and access management specific to the deployment of Azure VMware Solution.

> [!div class="nextstepaction"]
> [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
