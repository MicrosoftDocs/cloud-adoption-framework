---
title: "Assess Windows Virtual Desktop for Azure"
description: Use the Cloud Adoption Framework for Azure to learn Windows Virtual Desktop migration best practices to reduce complexity and standardize the migration process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Windows Virtual Desktop assessment

The [Windows Virtual Desktop proof of concept](./proof-of-concept.md) provides initial scope as a baseline implementation. The output of that proof of concept is unlikely to meet production needs. The assessment process serves as a focused means of testing assumptions through a data-driven process. Assessment data will help answer a series of important questions, validate/invalidate the assumptions, and refine scope when necessary to support your Windows Virtual Desktop scenario. Using this assumption-validation approach will accelerate the migration or deployment of end-user desktops to WVD.

## Assess Windows Virtual Desktop deployments

Each Windows Virtual Desktop assessment will evaluate a combinations of a user persona, a consistent host pool (VMs), end-user applications and data, and user profiles (data). During assessment, the objective is to use data to answer the questions in this section. Those answers will shape the actual scope of the deployment and release of the WVD migration.

The answers to these questions start with data. In the Plan methodology, specifically [best practices](../../plan/index.md) and [digital estate assessment](../../digital-estate/index.md), data should already be collected and analyzed to create your migration plan. However, the questions in this specific workload assessment will likely require additional data. Specifically, data about the desktops, users, and workloads used by each user is required to develop a WVD deployment plan.

If you use [Movere](https://docs.microsoft.com/azure/migrate/migrate-services-overview#movere) as the data collection tool, you will likely have the data you need to develop personas and answer these questions using data in [Azure Migrate](https://docs.microsoft.com/azure/migrate) just like any other migration scenario.

If you don't have the data needed to answer all of the questions in this section, there is an additional third-party software vendor that can provide a separate discovery process to augment the data you have. [Lakeside](https://docs.microsoft.com/azure/migrate/migrate-services-overview#isv-integration) is also integrated with Azure Migrate within the "VDI" migration goals section and map out a plan for WVD deployment including personas, host pools, applications, and user profiles.

### User personas

How many distinct personas will be required to support all of the users included in this migration scenario? Defining personas will come as a result of bucketing users based on the following:

- **Personal pools:** Do specific group of users require dedicated desktops, instead of pools? For example, security, compliance, high performance, or noisy-neighbor requirements may lead to some users running on dedicated desktops that are not part of a pooling strategy. This will be set by specifying a [host pool type of personal during the WVD host pool deployment](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#begin-the-host-pool-setup-process).
- **Density:** Do specific groups of users require lower density desktop experiences? Ex. Heavy users require 2 users per vCPU instead of the light user assumption of 6 users per vCPU. This will be entered in the [pool settings of the WVD host pool deployment](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#begin-the-host-pool-setup-process).
- **Performance:** Do specific groups of users require higher performance desktop experiences? Ex. Some users require more memory per vCPU than the assumed 4 GB of RAM per vCPU. The VM sizing will be entered in the [virtual machine details of the WVD host pool deployment](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- **Graphical processing (GPU):** Do specific groups of users have higher graphical requirements? For example, some users require GPU-based VMs in Azure, demonstrated in this [guide for configuring GPU VMs](https://docs.microsoft.com/azure/virtual-desktop/configure-vm-gpu).
- **Azure region:** Do specific group OS users operate from various geographic regions? For example, before configuring the host pool, a user from each region should test latency to Azure using the [estimation tool](https://azure.microsoft.com/services/virtual-desktop/assessment/#estimation-tool). The test user should share the lowest latency Azure region and the latency in milliseconds for the top three Azure regions.
- **Business functions:** Can the specific groupings of users be bucketed by business unit, charge code, or their business function? This type of grouping will help align corporate costs in later stages of operations.
- **User count:** How many users will be in each distinct persona?
- **Max session counts:** Based on geography and hours of operations, how many concurrent users are expected for each persona during maximum load?

Distinctions in each of the above questions will start to illustrate user personas by **business function, cost center**, geographic region, and technical requirements. The following table can aid in recording responses to populate a completed assessment or design document.

|  | Persona group 1  | Persona group 2  | Persona group 3  |
|---------|---------|---------|---------|
| **Pools**  | Pools | Pools | Dedicated (security concerns) |
| **Density** | Light (6 users/vCPU) | Heavy (2 users/vCPU) | Dedicate (1 users/vCPU) |
| **Performance** | Low | High memory | Low |
| **GPU** | N/A | Required | N/A |
| **Azure region** | North America | Western Europe | North America |
| **User count** | 1000 | 50 | 20 |
| **Session count** | 200 | 50 | 10 |

Each persona (or each group of users with distinct business functions) which also has distinct technical requirements would require a specific host pool configuration.

The end-user assessment will provide the data needed: pool type, density, size, CPU/GPU, landing zone region, etc.

Host pool configuration assessment will now map that data to a deployment plan. Aligning the technical requirements, business requirements, and cost will help determine the proper number and configuration of the host pools.

See examples for pricing in the [East US](https://azure.com/e/448606254c9a44f88798892bb8e0ef3c), [West Europe](https://azure.com/e/61a376d5f5a641e8ac31d1884ade9e55), or [Southeast Asia](https://azure.com/e/7cf555068922461587d0aa99a476f926) regions.

### Application groups

Both Movere and lakeside scans of the current on-premises environment will provide data regarding the applications that are run on end-user desktops. Using that data, create a list of all applications required per each persona. For each required application, the answers to the following questions will shape deployment iterations.

- Do any applications need to be installed for the persona to use this desktop? Unless the persona uses 100% web-based software-as-a-service applications, you will likely need to [configure a custom master VHD image](https://docs.microsoft.com/azure/virtual-desktop/set-up-customize-master-image) for each persona, with the required applications installed on the master image.
- Does this persona need Office 365 applications? If so, you will need to [add Office 365 to a customized master VHD image](https://docs.microsoft.com/azure/virtual-desktop/install-office-on-wvd-master-image).
- Is this application compatible with Windows 10 multi-session? If applications aren't compatible, a [personal pool](https://docs.microsoft.com/azure/virtual-desktop/configure-host-pool-personal-desktop-assignment-type) may be required to run the custom VHD image. For application compatibility issues with Windows Virtual Desktop, the [desktop application assure](https://docs.microsoft.com/fasttrack/win-10-app-assure-assistance-offered) service can also offer assistance.
- Are mission-critical applications likely to suffer from latency between the virtual desktop and any back-end systems? If so, you may want to consider migrating the back-end systems supporting the application to Azure.

The answers to these questions may require the plan to include remediation to the desktop images or supporting application components prior to desktop migration or deployment.

## Next step: Deploy or migrate Windows Virtual Desktop instances

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey.

- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
