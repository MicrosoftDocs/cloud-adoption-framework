---
title: Platform landing zone implementation options
description: Determine which Platform landing zone implementation option best fits your requirements.
author: jtracey93
ms.author: jatracey
ms.date: 12/12/2025
ms.topic: concept-article
ms.custom: internal
---
# Platform landing zone implementation options

There are multiple ways to deploy and manage your Platform landing zone, which is part of the Azure landing zone (see [Platform landing zone vs. application landing zones](./index.md#platform-landing-zone-vs-application-landing-zones)). You can choose the method that best fits your organization's needs and expertise.

To summarize, there are multiple options available:

- [Azure landing zone Infrastructure-as-Code (IaC) Accelerator](https://aka.ms/alz/accelerator) ***(recommended approach)***
  - [Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Terraform](https://aka.ms/alz/acc/tf) *(Can also be used outside of the accelerator, if desired)*
  - [Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Bicep](https://aka.ms/alz/acc/bicep) *(Can also be used outside of the accelerator, if desired)*
- [Azure platform landing zone portal accelerator](https://aka.ms/alz/portal)

We highly recommend using Infrastructure-as-Code (IaC) options, such as Bicep or Terraform, via the Azure landing zone Infrastructure-as-Code (IaC) Accelerator for deploying and managing Azure landing zones. These options provide greater flexibility, repeatability, and scalability compared to the portal accelerator. 

But if your organization does not have the necessary expertise in IaC or prefers a more visual approach, the portal accelerator can be a suitable alternative. See [Use infrastructure as code to update Azure landing zones](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code-updates) for more information to help you understand why IaC is the preferred approach.

## Azure landing zone Infrastructure-as-Code (IaC) Accelerator

> [!TIP]
> This is the recommended approach for deploying and managing your Platform landing zone.

The [Azure Landing Zones IaC Accelerator](https://aka.ms/alz/accelerator) provides an opinionated, automated approach to deploying and managing the Platform landing zone using Bicep or Terraform (based on Azure Verified Modules (AVM)). It streamlines the setup of a continuous delivery environment, supporting both Azure DevOps and GitHub for Version Control Systems (VCS) with deployment pipelines, and runners.

It is our recommended approach for organizations looking to implement a Platform landing zone due to its flexibility, repeatability, and scalability. The IaC Accelerator allows you to define your platform landing zone architecture as code, enabling you to version control, automate deployments, and easily replicate environments.

The Azure Landing Zones IaC Accelerator uses a streamlined, four-phase approach to get your environment ready for continuous delivery. 

In phase 0 (Planning) you'll make decisions about your IaC language of choice and VCS, then you’ll move into Phase 1 (Prerequisites) to set up credentials and subscriptions ready for the next phase. In Phase 2 (Bootstrap) you run the PowerShell module and bootstrap your Azure environment and VCS ready for the assets to deploy and manage your Platform landing zone. And finally in Phase 3 (Run) you make final changes to the IaC code based on the customizations you need in your organization before then triggering the Continuous Integration and Delivery (CI/CD) pipelines to deploy your Platform landing zone into your environment. 

Perfect for teams looking to automate and standardize Platform landing zones quickly with recommended best practices.

## Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Bicep and Terraform

We have created and use many existing [Azure Verified Modules (AVM)](https://aka.ms/avm) to allow you to build your Platform landing zone using either [Bicep](https://aka.ms/alz/acc/bicep) or [Terraform](https://aka.ms/alz/acc/tf). These modules are reusable, customizable, and extensible building blocks that help you deploy a Platform landing zone aligned with best practices.

You can use these modules independently or as part of the [Azure Landing Zones IaC Accelerator](https://aka.ms/alz/accelerator) to deploy and manage your Platform landing zone

## Azure platform landing zone portal accelerator

The [Azure platform landing zone portal accelerator](https://aka.ms/alz/portal) is a ready-made deployment experience that allows you to deploy the reference architecture via an Azure portal-based deployment. The portal accelerator deploys the reference architecture and applies predetermined configurations to key components such as management groups and policies.

[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://aka.ms/alz/portal)

It suits organizations who don't have the necessary expertise in Infrastructure-as-Code (IaC) or prefer a more visual approach. However, it is less flexible and scalable compared to IaC options and we highly recommend using IaC options where possible. 

See [Use infrastructure as code to update Azure landing zones](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code-updates) for more information to help you understand why IaC is the preferred approach.

## Next steps

Choose the implementation option that best fits your organization's needs and expertise, and follow the relevant documentation to get started with deploying and managing your Platform landing zone.

> [!div class="nextstepaction"]
> [Azure landing zone IaC Accelerator documentation](https://aka.ms/alz/accelerator)

> [!div class="nextstepaction"]
> [Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Bicep documentation](https://aka.ms/alz/acc/bicep)

> [!div class="nextstepaction"]
> [Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Terraform documentation](https://aka.ms/alz/acc/tf)