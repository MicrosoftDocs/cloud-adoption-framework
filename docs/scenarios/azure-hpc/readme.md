author: Rajani-Janaki-Ram
description: 'Read me for CAF HPC doc set.'
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 10/25/2022

# Template for new tech platform scenarios in the Cloud Adoption Framework

The files in this folder are designed to start a new tech platform scenario with minimum necessary requirements in place.

For the procedure for contributing a scenario to the Cloud Adoption Framework, see [CAF contributor workflow overview](https://review.docs.microsoft.com/en-us/help/contribute/cloud-adoption-framework/caf-contribution-overview?branch=main).

You can review recently published scenarios in the [Cloud Adoption Framework docs](/azure/cloud-adoption-framework/scenarios/overview).

## Individual files for a tech platform scenario

The following table lists the structure and parts of the technical platform scenario template for the Cloud Adoption Framework.

| Level | TOC Entry | Topic Title | Filename | Summary |
|---|---|---|---|---|
| TOC | Introduction to the HPC scenario | Introduction to the HPC scenario | [toc.yml](toc.yml) | The yaml table of contents file contains the outline, the   order and organization, of documents in the scenario. The CAF content team   will make the required updates to the main TOC. This shouldn't be done by a   contributor, unless it's a separate TOC file for an end-to-end scenario. |
| L1 | HPC - Microsoft Cloud Adoption Framework for Azure | Introduction to the HPC scenario | [index.md](index.md) | The landing page describes the context and narrative of the   scenario. |
| L1 | HPC adoption - Microsoft Cloud Adoption Framework   for Azure | NA | NA | Table of contents section. |
| L1 | Strategic impact | Strategic impact of HPC | [strategy.md](strategy.md) | Best practice encourages customers to create a single   centralized cloud adoption strategy, using the [Cloud Adoption Framework's   Strategy   methodology](/azure/cloud-adoption-framework/strategy/). |
| L1 | Technical planning | Plan for HPC | [plan.md](plan.md) | [Cloud Adoption Framework's Plan   methodology](/azure/cloud-adoption-framework/plan/)   helps create an overall cloud adoption plan to guide the programs and teams   involved in your cloud-based digital transformation. |
| L1 | Prepare your environment | NA | NA | Table of contents section. |
| L2 | Azure landing zones | Azure Landing Zone review for HPC | [ready.md](./ready.md) | NA |
| L2 | Design areas | NA | NA | Table of contents section. |
| L3 | Enterprise enrollment |  | [identity-access-management.md](../azure-hpc/manufacturing/identity-access-management.md) | Disclose any required dependency on ALZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Identity and access   management |  | [network-topology-connectivity.md](../azure-hpc/manufacturing/network-topology-connectivity.md) | Disclose any required dependency on ALZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Network topology and  connectivity |  | [resource-organization.md](../azure-hpc/manufacturing/resource-organization.md) | Disclose any required dependency on ALZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Resource organization |  | [security.md](../azure-hpc/manufacturing/security.md) | Disclose any required dependency on ALZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Governance disciplines |  | [management.md](../azure-hpc/manufacturing/management.md) | Disclose any required dependency on ALZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Operations baseline |  | [security-governance-compliance.md](../azure-hpc/manufacturing/security-governance-compliance.md) | Disclose any required dependency on ALZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Business continuity and disaster recovery |  | [business-continuity-disaster-recovery.md](business-continuity-disaster-recovery.md) | Disclose any required dependency on ALZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Deployment options |  | [platform-automation-devops.md](../azure-hpc/manufacturing/platform-automation-devops.md) | Disclose any required dependency on ALZ design area or other   ALZ design areas, with links to those supporting materials. |
| L2 | Implementation options | NA | NA | Table of contents section. |
| L3 | Example |  | NA | Link to a reference architecture |
| L3 | HPC on Azure landing zone accelerator |  | [azure-hpc-landing-zone-accelator.md](../azure-hpc/azure-hpc-landing-zone-accelator.md) | The Azure high-performance computing (HPC) landing zone accelerator is an open-source   collection of Terraform templates that you can use to automate the deployment   of an environment capable of hosting Azure high-performance computing (HPC).  |
| L1 | Govern |  | [govern.md](../azure-hpc/govern.md) | The [Cloud Adoption Framework provides a   methodology](/azure/cloud-adoption-framework/govern/)   to systematically and incrementally improve governance of your cloud   portfolio. |
| L1 | Secure |  | [secure.md](../azure-hpc/secure.md) | Best practice encourages customers to create a single   centralized cloud adoption strategy, using the [Cloud Adoption Framework's   Strategy   methodology](/azure/cloud-adoption-framework/strategy/) |
| L1 | Organize |  | [organize.md](../azure-hpc/organize.md) | Best practice encourages customers to create a single   centralized cloud adoption strategy, using the [Cloud Adoption Framework's   Organize   methodology](/azure/cloud-adoption-framework/organize/).  |
| L1 | Migrate HPC to   Azure |  | [migrate.md](../azure-hpc/migrate.md) | Establish a driving statement to shape migration of this   technology platform. Best practice encourages customers to create a migration   statement, using the [Cloud Adoption Framework's migrate   methodology](/azure/cloud-adoption-framework/migrate/).  |
| L1 | Innovate with   HPC and Azure |  | [innovate.md](../azure-hpc/innovate.md) | The innovate methodology of the Cloud Adoption Framework for   Azure drives adoption through the build-measure-learn cycle. For more   information, see [Innovate   methodology](/azure/cloud-adoption-framework/innovate/). |
| L1 | Manage HPC   platform and workloads |  | [manage.md](../azure-hpc/manage.md) | The [Manage   methodology](/azure/cloud-adoption-framework/manage/)   in the Microsoft Cloud Adoption Framework for Azure outlines a path for   implementing an operations baseline, and maturing that baseline throughout   your cloud adoption lifecycle. |
| L1 | Well-architected   considerations |  | [well-architected-framework.md](../azure-hpc/well-architected-framework.md) | For many of the named workloads, it's important to adhere to a   set of architectural principles. These principles help guide development and   optimization of the workloads. The five architectural constructs are detailed   in the [Azure Well-Architected Framework](/azure/architecture/framework/). |
| L1 | HPC architectures |  | NA | Table of contents section. |
|  | Example |  | NA | Provide a title  and   link in the table of contents for one or more supporting [Azure reference   architectures](/azure/architecture/browse/). |
| L1 | Azure product documentation |  | NA | Table of contents section. |
|  | Example |  | NA | Provide a title  and   link in the table of contents for one or more supporting [Technical documentation](https://learn.microsoft.com/documentation/). |
| L1 | Build skills on Learn |   | NA | Table of contents section. |
|  | Example |  | NA | Provide a title  and   link in the table of contents for one or more supporting [Learn modules](https://learn.microsoft.com/en-us/training/). |

## Token used in the templates

The following table contains the tokens that reappear throughout the templates used in the scenario. You can either search and replace to update the tokens, or use a build automation tool to add your values.

|     Token                            |     Description                                                 |
|--------------------------------------|-----------------------------------------------------------------|
|     HPC                   |     Short   name of the scenario.                               |
|     Azure high-performance computing (HPC)               |     The   long name of the scenario.                            |
|     {{Token-ContributorGithubId}}    |     Author's   GitHub ID.                                       |
|     {{Token-Alias}}                  |     Author's   Microsoft ID.                                    |
|     {{Token-Date}}                   |     Publication   date of the scenario in MM/DD/YYYY format.    |

## CAF work to finalize the scenarios

- For each ALZ page, the headers and metadata need to look more like the corresponding file in the AKS scenario
- CAF team to review the articles and identify any additional requirements for each page
- CAF team to review the articles for quality to ensure we don't start with known errors
- CAF team to update the Ready article to match AKS scenario flow

## ThinkTank team steps to use this template

1. Review the table to understand the purpose of each document in the template.
1. Use the tokens to update the documents with the values for your scenario.
1. All scenario articles (not prefixed with `ALZ`) must accurately reflect the Cloud Adoption Framework (CAF) methodologies **and** the marketing motion to drive this scenario. Each starts with a series of sections that must be evaluated and updated based on CAF links in each section.
1. Add as many (##) H2 sections after the core CAF sections as required to tell the story and guide adoption.
1. Draft all remaining ALZ articles (prefixed with `ALZ`) to reflect any considerations or recommendations required to prepare for the ALZ deployment. Any additional guidance may be added after the H2s for recommendations and considerations.

## For more information

See [CAF contributor workflow overview](https://review.docs.microsoft.com/en-us/help/contribute/cloud-adoption-framework/caf-contribution-overview?branch=main)
