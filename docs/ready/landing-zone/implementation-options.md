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

This article describes options to deploy and manage the platform landing zone, which is part of Azure landing zone. Selecting the appropriate implementation method ensures your environment aligns with organizational requirements and technical capabilities. For context on platform landing zone scope, see [Platform landing zone vs. application landing zones](./index.md#platform-landing-zone-vs-application-landing-zones).  

## Implementation options at a glance

- **Infrastructure-as-Code (IaC) approach (recommended)**: Use the [Azure landing zone infrastructure-as-code (IaC) accelerator](https://aka.ms/alz/accelerator) with Azure Verified Modules (AVMs) for [Terraform](https://aka.ms/alz/acc/tf) or [Bicep](https://aka.ms/alz/acc/bicep). You can use AVMs independently or as part of the accelerator.

- **Portal-based approach**: The [Azure platform landing zone portal accelerator](https://aka.ms/alz/portal) works best for organizations without IaC expertise or those who prefer a visual approach. See [Use infrastructure as code to update Azure landing zones](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code-updates) to understand why IaC is the preferred approach.

For detailed guidance on each option, see the following sections.

## Azure landing zone Infrastructure-as-Code (IaC) accelerator

> [!TIP]
> Use this recommended approach to deploy and manage the platform landing zone.

The [Azure Landing Zones IaC Accelerator](https://aka.ms/alz/accelerator) provides an automated approach to deploy and manage the platform landing zone. It uses Bicep or Terraform based on Azure Verified Modules (AVM). This tool streamlines the setup of a continuous delivery environment and supports Azure DevOps and GitHub for version control systems (VCS), deployment pipelines, and runners.

Define the platform landing zone architecture as code to version control, automate deployments, and replicate environments. This approach standardizes platform landing zones with recommended best practices. The accelerator uses a four-phase approach to prepare the environment for continuous delivery:

1. **Phase 0 (Planning).** Select the preferred IaC language and VCS.
2. **Phase 1 (Prerequisites).** Configure credentials and subscriptions for the deployment.
3. **Phase 2 (Bootstrap).** Run the PowerShell module to bootstrap the Azure environment and VCS. This step prepares the assets to deploy and manage the platform landing zone.
4. **Phase 3 (Run).** Customize the IaC code to meet organizational requirements. Trigger the continuous integration and delivery (CI/CD) pipelines to deploy the platform landing zone.

## Azure Verified Modules for platform landing zones

[Azure Verified Modules (AVM)](https://aka.ms/avm) provide reusable, customizable, and extensible building blocks to build a platform landing zone with [Bicep](https://aka.ms/alz/acc/bicep) or [Terraform](https://aka.ms/alz/acc/tf). These modules help deploy a platform landing zone that aligns with best practices. Using verified modules ensures architectural consistency and reduces the maintenance burden of custom code.

Use these modules independently or as part of the [Azure Landing Zones IaC Accelerator](https://aka.ms/alz/accelerator) to deploy and manage the platform landing zone.

## Azure platform landing zone portal accelerator

The [Azure platform landing zone portal accelerator](https://aka.ms/alz/portal) provides a graphical interface to deploy the reference architecture. This tool applies predetermined configurations to key components, such as management groups and policies. Use this option if the organization lacks infrastructure-as-code (IaC) expertise or prefers a visual deployment method.

[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://aka.ms/alz/portal)

This approach offers less flexibility and scalability than IaC options. Updates and version control are difficult to manage without IaC. Transition to an IaC-based approach when possible to improve manageability.  

See [Use infrastructure as code to update Azure landing zones](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code-updates) to understand why IaC is the preferred approach.

## Next steps

Choose the implementation option that best fits your organization's needs and expertise. Follow the relevant documentation to deploy and manage your platform landing zone.  

> [!div class="nextstepaction"]
> [Azure landing zone IaC Accelerator documentation](https://aka.ms/alz/accelerator)

> [!div class="nextstepaction"]
> [Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Bicep documentation](https://aka.ms/alz/acc/bicep)

> [!div class="nextstepaction"]
> [Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Terraform documentation](https://aka.ms/alz/acc/tf)