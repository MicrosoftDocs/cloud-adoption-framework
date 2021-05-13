---
title: Plan your Windows Virtual Desktop migration
description: Use the Cloud Adoption Framework for Azure to plan your Windows Virtual Desktop migration using best practices that reduce complexity and standardize the migration process.
author: DominicAllen
ms.author: doalle
ms.date: 4/1/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Windows Virtual Desktop planning

Windows Virtual Desktop deployment scenarios follow the same Migrate methodology as other migration efforts.

This consistent approach allows migration factories or existing migration teams to adopt the process with little change to non-technical requirements.

![Migrate methodology of the Cloud Adoption Framework.](../../_images/migrate/methodology.png)

## Plan your migration

As with other migrations, your team will assess workloads, deploy them, and then release them to end users. However, Windows Virtual Desktop includes specific requirements that will necessitate a review of the Azure landing zones during the assessment of the workloads. The process will also require a proof of concept prior to the first deployment.

To build your plan, see the [cloud adoption plan DevOps template](../../plan/template.md) for an existing migration backlog in Azure DevOps. Use the template to create a detailed plan of activities.

## Business justification

Part of your planning will require being able to articulate the business benefits of moving to Windows Virtual Desktop.

The following list includes items to be used in a business case.

- The Windows Virtual Desktop control plane or management plane is provided as a service to customers. The control plane manages end users' seamless global connectivity into their desktop, and the centralized deployment and orchestration that IT requires. This is a platform as a Service (PaaS) service removing the needed to procure, deploy, patch, or support hardware. It's an evergreen service that you just consume. It has no cost, it's a service that you are entitled to through a license that you likely already own. As a result you can achieve cost savings through efficiency. It also means that after migration you do not need to do the management or troubleshooting of an on-premises Virtual Desktop management service. This allows IT to concentrate on delivering value to the business, for example ensuring customers have the best user experience when they're consuming their applications and data.

- No upfront costs. To run virtual desktops on-premises requires you to either pay up front, or enter into a lengthy leasing agreement for all of the hardware required to meet the peak load. This applies even if that hardware is not used as the project progresses, or if the hardware is not used 100 percent of the time when the project is complete. Windows Virtual Desktop and Azure consumption-based model, so you only pay for what you use. In addition, you can scale up and down, based on your business needs, helping you reduce your costs.

- Windows Virtual Desktop and Azure have a quicker cadence for new features and capabilities. On-premises hardware and off the shelf software typically do not receive large new feature sets or new capabilities as frequently, and often require a costly project to implement. Windows Virtual Desktop and Azure receive regular new capabilities and with deployment managed by Microsoft. Windows Virtual Desktop is an evergreen service. Organizations do not need a project to roll out new services to business users for them to be able to take advantage of new features. These new features may well provide competitive advantage, or reduces the risk of technical debt.

- Azure is a hyperscale cloud that provides services at massive scale. This functionality provides substantial agility to your organization. Microsoft hosts services in an ever-increasing number of Azure regions, enabling the infrastructure or services to be closer to your end users.

- Windows Virtual Desktop provides the rich Windows 10 experience that users expect, at multi-session cost. Windows Virtual Desktop enables the scale of Windows Server with Remote Desktop Services combined with the user experience of Windows 10, without the compromise of application compatibility. Windows 10 Enterprise multi-session runs only on Windows Virtual Desktop.

- There is no requirement for client access licenses with Windows 10 Enterprise multi-session, as Windows 10 multi-session does not require a Client Access License (CAL)

- In Windows Virtual Desktop, if you deploy Windows Server (Windows Server 2012 R2, 2016 or 2019), there is no requirement to purchase a Windows Server license

- All Windows Virtual Desktop virtual machines are charged at the Base compute rate. Windows Virtual Desktop is entitled through another license that you probably already own (Microsoft 365 E3+), that includes a Windows license

- All Windows 7 virtual machines in Windows Virtual Desktop receive free extended security updates until January 14, 2023

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Review your environment or Azure landing zones](./ready.md)
- [Complete a Windows Virtual Desktop proof of concept](./proof-of-concept.md)
- [Assess Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
