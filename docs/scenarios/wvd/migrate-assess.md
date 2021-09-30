---
title: Assess Azure Virtual Desktop
description: Use the Cloud Adoption Framework for Azure to assess your Azure Virtual Desktop migration scenario using best practices that accelerate the migration or deployment process.
author: DominicAllen
ms.author: doalle
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Azure Virtual Desktop assessment

The Azure Virtual Desktop [proof of concept](./proof-of-concept.md) provides an initial scope as a baseline implementation. However, the output of that proof of concept is unlikely to meet their production needs as-is.

The Azure Virtual Desktop assessment exercise serves as a focused means of testing assumptions through a data-driven process. Assessment data will help the team answer a series of important questions, validate or invalidate their assumptions, and refine the scope as necessary to support the team's Azure Virtual Desktop scenario. By using this assumption-validation approach, the team can accelerate the migration or deployment of its end-user desktops to Azure Virtual Desktop.

## Assess Azure Virtual Desktop deployments

Each Azure Virtual Desktop assessment will evaluate a combination of a user persona, a consistent host pool of virtual machines (VMs), end-user applications and data, and user profiles (data). During the assessment, the team's objective is to use data to answer the questions in this section. The answers will shape the actual scope of the deployment and release of the Azure Virtual Desktop migration.

The answers to these questions start with data. In the Plan methodology, specifically [best practices](../../plan/contoso-migration-assessment.md) and [digital estate assessment](../../digital-estate/index.md), data should already be collected and analyzed to create a migration plan. However, the questions in this specific workload assessment will likely require additional data. Data about the desktops, users, and workloads to be used by each user is required to develop an Azure Virtual Desktop deployment plan.

If you use [Movere](/azure/migrate/migrate-services-overview#movere) as your data collection tool, you'll likely have the data you need to develop personas and answer these questions by using data in [Azure Migrate](/azure/migrate/), just like any other migration scenario.

If you don't have the data that you require to answer all the questions in this section, an additional third-party software vendor can provide a separate discovery process to augment the data you have. The vendor, [Lakeside Software](/azure/migrate/migrate-services-overview#isv-integration), is also integrated with Azure Migrate within the virtual desktop infrastructure migration goals section. The vendor can help you map out a plan for Azure Virtual Desktop deployment, including personas, host pools, applications, and user profiles.

### User personas

How many distinct personas will be required to support all of the users included in this migration scenario? Defining personas will come as a result of bucketing users based on the following criteria:

- **Personal pools:** Do specific groups of users require dedicated desktops, instead of pools? For example, security, compliance, high-performance, or noisy-neighbor requirements might lead to some users running on dedicated desktops that aren't part of a pooling strategy. You'll enter this information by specifying a [host pool type of personal during the Azure Virtual Desktop host pool deployment](/azure/virtual-desktop/create-host-pools-azure-marketplace#begin-the-host-pool-setup-process).
- **Density:** Do specific groups of users require a lower-density desktop experience? For example, heavier density might require two users per virtual central processing unit (vCPU) instead of the light-user assumption of six users per vCPU. You'll enter density information in the [pool settings of the Azure Virtual Desktop host pool deployment](/azure/virtual-desktop/create-host-pools-azure-marketplace#begin-the-host-pool-setup-process).
- **Performance:** Do specific groups of users require a higher-performance desktop experience? For example, some users require more memory per vCPU than the assumed 4&nbsp;gigabytes (GB) of RAM per vCPU. You'll enter the VM sizing in the [virtual machine details of the Azure Virtual Desktop host pool deployment](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- **Graphical processing (GPU):** Do specific groups of users have greater graphical requirements? For example, some users require GPU-based VMs in Azure, as demonstrated in this [guide for configuring GPU VMs](/azure/virtual-desktop/configure-vm-gpu).
- **Azure region:** Do specific groups of OS users operate from various geographic regions? For example, before you configure the host pool, a user from each region should test latency to Azure by using the [estimation tool](https://azure.microsoft.com/services/virtual-desktop/assessment/#estimation-tool). The test user should share the lowest-latency Azure region and the latency in milliseconds for the top three Azure regions.
- **Business functions:** Can the specific groupings of users be bucketed by business unit, charge code, or their business function? This type of grouping will help align corporate costs in later stages of operations.
- **User count:** How many users will be in each distinct persona?
- **Max session counts:** Based on geography and hours of operation, how many concurrent users are expected for each persona during maximum load?

Distinctions in each of the preceding questions will start to illustrate user personas by business function, cost center, geographic region, and technical requirements. The following table can aid in recording responses to populate a completed assessment or design document:

| Criterion | Persona group&nbsp;1 | Persona group&nbsp;2 | Persona group&nbsp;3 |
|---------|---------|---------|---------|
| Pools | Pools | Pools | Dedicated (security concerns) |
| Density | Light (6&nbsp;users/vCPU) | Heavy (2&nbsp;users/vCPU) | Dedicated (1&nbsp;user/vCPU) |
| Performance | Low | High memory | Low |
| GPU | N/A | Required | N/A |
| Azure region | North America | Western Europe | North America |
| User count | 1,000 | 50 | 20 |
| Session count | 200 | 50 | 10 |

Each persona, or each group of users with distinct business functions and technical requirements, would require a specific host-pool configuration.

The end-user assessment provides the required data: pool type, density, size, CPU/GPU, landing zone region, and so on.

Host-pool configuration assessment now maps that data to a deployment plan. Aligning the technical requirements, business requirements, and cost will help determine the proper number and configuration of host pools.

See examples for pricing in the [East US](https://azure.com/e/448606254c9a44f88798892bb8e0ef3c), [West Europe](https://azure.com/e/61a376d5f5a641e8ac31d1884ade9e55), or [Southeast Asia](https://azure.com/e/7cf555068922461587d0aa99a476f926) regions.

### Application groups

Both Movere and Lakeside scans of the current on-premises environment can provide data about the applications that are run on end-user desktops. By using that data, you can create a list of all applications required per each persona. For each required application, the answers to the following questions will shape deployment iterations:

- Do any applications need to be installed for the persona to use this desktop? Unless the persona uses 100 percent web-based software as a service applications, you'll likely need to [configure a custom master VHD image](/azure/virtual-desktop/set-up-customize-master-image) for each persona, with the required applications installed on the master image.
- Does this persona need Microsoft 365 applications? If so, you'll need to select an image from the gallery that has Microsoft 365 apps included or [add Microsoft 365 to a customized master VHD image](/azure/virtual-desktop/install-office-on-wvd-master-image).
- Is this application compatible with Windows&nbsp;10 Enterprise multi-session? If an application isn't compatible, a [personal pool](/azure/virtual-desktop/configure-host-pool-personal-desktop-assignment-type) might be required to run the custom VHD image. For assistance with application and Azure Virtual Desktop compatibility issues, see the [desktop application assure](/fasttrack/products-and-capabilities#app-assure) service.
- Are mission-critical applications likely to suffer from latency between the Azure Virtual Desktop instance and any back-end systems? If so, you might want to consider migrating the back-end systems that support the application to Azure.

The answers to these questions might require the plan to include remediation to the desktop images or supporting application components prior to desktop migration or deployment.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Deploy or migrate Azure Virtual Desktop instances](./migrate-deploy.md)
- [Release your Azure Virtual Desktop deployment to production](./migrate-release.md)
