# Template for new tech platform scenarios in the Cloud Adoption Framework

The files in this folder are designed to start a new tech platform scenario with minimum necessary requirements in place.

For the procedure for contributing a scenario to the Cloud Adoption Framework, see [CAF contributor workflow overview](https://review.docs.microsoft.com/en-us/help/contribute/cloud-adoption-framework/caf-contribution-overview?branch=main).

You can review recently published scenarios in the [Cloud Adoption Framework docs](/azure/cloud-adoption-framework/scenarios/overview).

## Individual files for a tech platform scenario

The following table lists the structure and parts of the technical platform scenario template for the Cloud Adoption Framework.

| Level | TOC Entry | Topic Title | Filename | Summary |
|---|---|---|---|---|
| Table of contents | NA | Introduction to the {{Token-Name}} scenario | [toc.yml](toc.yml) | The yaml table of contents file contains the outline, the order and   organization, of documents in the scenario. The CAF content team will make   the required updates to the main TOC. This shouldn't be done by a   contributor, unless it's a separate TOC file for an end-to-end scenario. |
| L1 | {{Token-Name}} - Microsoft Cloud Adoption Framework for Azure | Introduction to the {{Token-Name}} scenario | [index.md](index.md) | The landing page describes the context and narrative of the scenario. |
| L1 | Strategic impact | Strategic impact of {{Token-Name}} | [strategy.md](strategy.md) | Best practice encourages customers to create a single centralized cloud   adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/). |
| L1 | Technical planning | Plan for {{Token-Name}} | [plan.md](plan.md) | [Cloud Adoption Framework's Plan   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/) helps create an overall   cloud adoption plan to guide the programs and teams involved in your   cloud-based digital transformation. |
| L1 | Prepare your environment | NA | NA | Table of contents section. |
| L2 | Azure Landing Zones | Azure Landing Zone review for {{Token-Name}} | [ready.md](ready.md) | The [Ready methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/) of the   Microsoft Azure Cloud Adoption Framework guides customers through environment   readiness to prepare for cloud adoption. |
| L2 | Design areas | NA | NA | Table of contents section. |
| L3 | Identity and access management | Identity and access management for {{Token-LongName}} enterprise-scale   scenario | [eslz-identity-and-access-management.md](eslz-identity-and-access-management.md) | Disclose any required dependency on ESLZ design area or other ALZ design   areas, with links to those supporting materials. |
| L3 | Network topology and connectivity | Network topology and connectivity for {{Token-LongName}} enterprise-scale   scenario | [eslz-network-topology-and-connectivity.md](eslz-network-topology-and-connectivity.md) | Disclose any required dependency on ESLZ design area or other ALZ design   areas, with links to those supporting materials. |
| L3 | Resource organization | Management group and subscription organization for {{Token-LongName}}   enterprise-scale scenario | [eslz-resource-organization.md](eslz-resource-organization.md) | Disclose any required dependency on ESLZ design area or other ALZ design   areas, with links to those supporting materials. |
| L3 | Security | Security disciplines for {{Token-LongName}} | [eslz-security.md](eslz-security.md) | Disclose any required dependency on ESLZ design area or other ALZ design   areas, with links to those supporting materials. |
| L3 | Management | Management for {{Token-LongName}} enterprise-scale scenario | [eslz-management-and-monitoring.md](eslz-management-and-monitoring.md) | Disclose any required dependency on ESLZ design area or other ALZ design   areas, with links to those supporting materials. |
| L3 | Governance discipline | Governance disciplines for {{Token-LongName}} | [eslz-governance-and-compliance.md](eslz-governance-and-compliance.md) | Disclose any required dependency on ESLZ design area or other ALZ design   areas, with links to those supporting materials. |
| L3 | Platform automation and DevOps | Platform automation and devops for {{Token-LongName}} enterprise-scale   scenario | [eslz-platform-automation-and-devops.md](eslz-platform-automation-and-devops.md) | Disclose any required dependency on ESLZ design area or other ALZ design   areas, with links to those supporting materials. |
| L2 | Implementation options | NA | NA | Table of contents section. |
| L3 | {{Token-Name}} landing zone accelerator | Construction set for {{Token-LongName}} enterprise-scale scenario | [landing-zone-accelerator.md](landing-zone-accelerator.md) | The {{Token-LongName}} construction set is an open-source collection of   Terraform templates that you can use to automate the deployment of an   environment capable of hosting {{Token-LongName}}.  |
| L1 | Migrate {{{{Token-Name}}}} to Azure | Migrate {{Token-Name}} | [migrate.md](migrate.md) | Establish a driving statement to shape migration of this technology   platform. |
| L1 | Innovate with {{{{Token-Name}}}} on Azure | Innovate with {{Token-Name}} | [innovate.md](innovate.md) | The innovate methodology of the Cloud Adoption Framework for Azure drives   adoption through the build-measure-learn cycle.  |
| L1 | Govern {{{{Token-Name}}}} in Azure | Govern {{Token-Name}} | [govern.md](govern.md) | The [Cloud Adoption Framework provides a   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/) to systematically and   incrementally improve governance of your cloud portfolio. |
| L1 | Manage {{{{Token-Name}}}} platform and workloads | Manage {{Token-Name}} | [manage.md](manage.md) | The [Manage methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/) in the   Microsoft Cloud Adoption Framework for Azure outlines a path for implementing   an operations baseline, and maturing that baseline throughout your cloud   adoption lifecycle. |
| L1 | Well-architected | NA | NA | Table of contents section. |
| L2 | Example | NA | NA | Provide a title  and link in the   table of contents for one or more related articles in [application   architecture fundamentals](https://docs.microsoft.com/azure/architecture/guide/). |
| L1 | Architectures | NA | NA | Table of contents section. |
| L2 | Example | NA | NA | Provide a title  and link in the   table of contents for one or more supporting [Azure reference   architectures](https://docs.microsoft.com/azure/architecture/browse/). |
| L1 | Best practices | NA | NA | Table of contents section. |
| L2 | Example | NA | NA | Provide a title  and link in the   table of contents to one or more supporting [cloud best practices](https://docs.microsoft.com/azure/architecture/best-practices/index-best-practices). |
| L1 | Microsoft products | NA | NA | Table of contents section. |
| L2 | Example | NA | NA | Provide a title  and link in the   table of contents to related and supporting technical docs for [Microsoft   products](https://docs.microsoft.com/documentation/) used in the solution. |
| L1 | Learn modules | NA | NA | Table of contents section. |
| L2 | Example | NA | NA | Provide a title  and link in the   table of contents for one or more supporting [Learn modules](https://docs.microsoft.com/learn/). |

## Token used in the templates

The following table contains the tokens that reappear throughout the templates used in the scenario. You can either search and replace to update the tokens, or use a build automation tool to add your values.

|     Token                            |     Description                                                 |
|--------------------------------------|-----------------------------------------------------------------|
|     {{Token-Name}}                   |     Short   name of the scenario.                               |
|     {{Token-LongName}}               |     The   long name of the scenario.                            |
|     {{Token-ContributorGithubId}}    |     Author's   GitHub ID.                                       |
|     {{Token-Alias}}                  |     Author's   Microsoft ID.                                    |
|     {{Token-Date}}                   |     Publication   date of the scenario in MM/DD/YYYY format.    |

## CAF work to finalize the scenarios

- For each ESLZ page, the headers & metadata need to look more like the corresponding file in the AKS scenario
- CAF team to review the articles & identify any additional requirements for each page
- CAF team to review the articles for quality to ensure we don't start with known errors
- CAF team to update the Ready article to match AKS scenario flow

## ThinkTank team steps to use this template

1. All scenario articles (not prefixed with `eslz-`) must accurately reflect the CAF methodologies **and** the marketing motion to drive this scenario. Each starts with a series of sections that must be evaluated & populated based on CAF links in each section.
1. Add as many H2 sections after the core CAF sections as required to tell the story & guide adoption.
1. Codename: *Construction sets* are often at a different scope than the parent scenario. The name of those assets will likely match a hero technology, instead of the business problem reflected in the scenario name.
1. Update the `enterprise-scale-landing-zone.md` file to reflect the demonstrated architecture & link to the actionable deployment.
1. Draft all remaining ESLZ articles (prefixed with `eslz-`) to reflect any considerations or recommendations required to prepare for the ESLZ deployment. Any additional guidance may be added after the H2's for recommendations & considerations.

## For more information

See [CAF contributor workflow overview](https://review.docs.microsoft.com/en-us/help/contribute/cloud-adoption-framework/caf-contribution-overview?branch=main)
