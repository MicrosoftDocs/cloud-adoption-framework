---
title: Plan your Azure Virtual Desktop migration
description: Use the Cloud Adoption Framework for Azure to plan your Azure Virtual Desktop migration using best practices that reduce complexity and standardize the migration process.
author: martinekuan
ms.author: martinek
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Virtual Desktop planning

Virtual Desktop deployment scenarios follow the same Migrate methodology as other migration efforts.

This consistent approach allows migration factories or existing migration teams to adopt the process with little change to non-technical requirements.

![Migrate methodology of the Cloud Adoption Framework.](../../_images/migrate/methodology.png)

## Plan your migration

As with other migrations, your team will assess workloads, deploy them, and then release them to end users. However, Azure Virtual Desktop or Citrix DaaS include specific requirements that necessitate a review of the Azure landing zones during assessment of the workloads. The process also requires a proof of concept before the first deployment.

To build your plan, see the [cloud adoption plan DevOps template](../../plan/template.md) for an existing migration backlog in Azure DevOps. Use the template to create a detailed plan of activities.

## Business justification

Part of your planning requires articulating the business benefits of moving to Azure Virtual Desktop or Citrix DaaS.

The following items should be included in a business case:

- The Azure Virtual Desktop control plane or management plane is provided as a service to customers. The control plane manages end users' seamless global connectivity into their desktop, and the centralized deployment and orchestration that IT requires. This is a platform as a service (PaaS) capability eliminating the need for procuring, deploying, patching, or supporting hardware. It's an evergreen service that you consume. It's a free service that you are entitled to via a license that you likely already own, helping you achieve cost savings through efficiency. Also, after migration you don't need to manage or troubleshoot an on-premises virtual desktop management service. This allows IT to focus on delivering business value, like providing customers with the best user experience possible when accessing applications and data.

- No upfront costs are incurred. Running an on-premises virtual desktop environment requires you to either upfront payment or a lengthy leasing agreement for the hardware required to meet the peak load. This requirement applies even if the hardware is not ultimately used as the project progresses, or if the hardware is not fully used when the project is complete. With Azure Virtual Desktop and Azure's consumption-based model, you only pay for what you use, and you can scale up and down based on your business needs, helping you reduce your costs.

- Like other Azure services, Azure Virtual Desktop have a quicker delivery cadence for new features and capabilities. On-premises hardware and off-the-shelf software typically don't provide large new feature sets or new capabilities as frequently, and often require a costly project to implement. Conversely, Azure services such as Azure Virtual Desktop regularly provide new capabilities, with deployment managed by Microsoft. Azure Virtual Desktop is an evergreen service. Organizations don't need a project to roll out new services to provide business users with new features. These new features could provide competitive advantage or reduce the risk of technical debt.

- Azure is a hyperscale cloud that provides services at massive scale. This functionality provides substantial agility to your organization. Microsoft hosts services in an ever-increasing number of Azure regions, enabling the infrastructure or services to be closer to your end users.

- Azure Virtual Desktop provides the rich Windows 10 experience that users expect, at multisession cost. Azure Virtual Desktop enables the scale of Windows Server with Remote Desktop Services combined with the user experience of Windows 10, without compromising application compatibility. Windows 10 Enterprise multisession runs only on Azure Virtual Desktop.

- There's no requirement for client access licenses with Windows 10 Enterprise multisession, because Windows 10 Enterprise multisession doesn't require a client access license (CAL).

- In Azure Virtual Desktop, if you deploy Windows Server 2012 R2, 2016, or 2019, there's no requirement to purchase a Windows Server license.

- All Azure Virtual Desktop virtual machines are charged at the base compute rate. Azure Virtual Desktop is entitled through another license that you might already own, Microsoft 365 E3+, which includes a Windows license.

- All Windows 7 virtual machines in Azure Virtual Desktop received free extended security updates until January 14, 2023.

- Citrix DaaS supports using Azure capabilities along with a broader range of identity providers, OS types, peripherals, collaboration solutions, and locations, such as existing on-premises datacenters. This extensibility streamlines the migration process by enabling deployment of Azure Virtual Desktop use cases while supporting existing systems with a consistent user experience.

- Citrix DaaS enables secure access to Windows, Linux, and Web apps, and Windows and Linux virtual desktops.

- Citrix DaaS manages apps and desktops centrally across multiple resource locations or clouds while maintaining a great end user experience.


## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Review your environment or Azure landing zones](./ready.md)
- [Complete an Azure Virtual Desktop proof of concept](./proof-of-concept.md)
- [Assess Azure Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Azure Virtual Desktop instances](./migrate-deploy.md)
- [Release your Azure Virtual Desktop deployment to production](./migrate-release.md)
