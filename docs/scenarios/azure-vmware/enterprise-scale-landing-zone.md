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

The following guidance provides design considerations for implementing a scalable Azure VMware Solution in your landing zone. The design decisions your organization makes, based on this guidance, lays the groundwork for scalability.

Customers adopt Azure VMware Solution in various ways. You can adopt the enterprise-scale for your Azure VMware Solution set to produce an architecture that fits your needs and puts your organization on a path to sustainable scale.

Azure VMware Solution landing zone accelerator provides these assets to support your project:

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

### Deployment scenarios

1. Brownfield deployment
2. Greenfield deployment

#### Brownfield deployment

In Brownfield deployment scenarios customer have a pre-existing Azure enviroment with different levels of maturity. The idea is to leverage the existing environment and build on top of it. The AVS Accelerator can be used to deploy AVS resources and dependent services in the existing environment.

##### Options for Brownfield Build

1. AVS Greenfield Lite Deployment
2. Manual Build

###### Option #1: AVS Greenfield Lite Deployment

This deployment is a lite version of the full AVS Greenfield Deployment and will deploy the following:

- New AVS Private Cloud - Allows for a custom resource group name and Private Cloud Name or Choose an existing AVS Private Cloud
- [Optional]: Deploy AVS Monitoring
- [Optional]: Deploy HCX and SRM

###### Option #2: Manual Build

Please refer Microsoft documentation for manual build of AVS Private Cloud.
[Click here](https://learn.microsoft.com/en-us/azure/azure-vmware/plan-private-cloud-deployment)

#### Greenfield deployment

Greenfield deployments are net new AVS environments. In this scenario a customer starts fresh and builds the VMware environment on Azure from scratch.

##### Options for Greenfield Build

1. AVS Greenfield Deployment
2. AVS Greenfield Lite Deployment
3. Manual Build

###### Option #1: AVS Greenfield Deployment

This deployment is best suited to those looking to provision a new AVS Private Cloud, the automation will let you choose and deploy the following:

- AVS Private Cloud
- Choose New or Existing virtual network (VNet)
- [Optional]: Deploy Azure Route Server for VPN Connections
- [Optional]: Deploy AVS Monitoring
- [Optional]: Deploy HCX and SRM

###### Option #2: AVS Greenfield Lite Deployment

This deployment is a lite version of the full AVS Greenfield Deployment and will deploy the following:

- New AVS Private Cloud - Allows for a custom resource group name and Private Cloud Name or Choose an existing AVS Private Cloud
- [Optional]: Deploy AVS Monitoring
- [Optional]: Deploy HCX and SRM

###### Option #3: Manual Build

Please refer Microsoft documentation for manual build of AVS Private Cloud.
[Click here](https://learn.microsoft.com/en-us/azure/azure-vmware/plan-private-cloud-deployment)

### Deployment summary table

| Deployment option | Deployment Scenario | Deployment instructions |
|---|---|---|
|Brownfield Deployment (Azure portal UI)          | Brownfield deployment (Option #1) | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.deploy.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.PortalUI.json)      |
|Greenfield Deployment (Azure portal UI)          | Greenfield deployment (Option #1) | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2FPortalUI%2FARM%2FESLZDeploy.deploy.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2FPortalUI%2FARM%2FESLZdeploy.PortalUI.json)      |
|Greenfield Deployment (Command line (Bicep/ARM))              | Greenfield deployment (Option #1)| [![Powershell/Azure CLI](./media/powershell.png)](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/AVS-Landing-Zone/GreenField/Bicep)          |
|Greenfield Deployment (Terraform)                            |Greenfield deployment (Option #1) | [![Terraform](./media/terraform.png)](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/AVS-Landing-Zone/GreenField/Terraform)                  |
|Greenfield Deployment (Azure portal UI)         | AVS Greenfield Lite Deployment (Option #2) | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.deploy.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale-for-AVS%2Fmain%2FAVS-Landing-Zone%2FGreenField%2520Lite%2FPortalUI%2FARM%2FGreenFieldLiteDeploy.PortalUI.json)      |

## Next steps

Review design considerations and recommendations related to identity and access management specific to the deployment of Azure VMware Solution.

> [!div class="nextstepaction"]
> [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
