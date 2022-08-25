# Template for new tech platform scenarios in the Cloud Adoption Framework

The files in this folder are designed to start a new tech platform scenario with minimum necessary requirements in place.

For the procedure for contributing a scenario to the Cloud Adoption Framework, see [CAF contributor workflow overview](https://review.docs.microsoft.com/en-us/help/contribute/cloud-adoption-framework/caf-contribution-overview?branch=main).

You can review recently published scenarios in the [Cloud Adoption Framework docs](https://docs.microsoft.com/azure/cloud-adoption-framework/scenarios/overview).

## Individual files for a tech platform scenario

The following table lists the structure and parts of the technical platform scenario template for the Cloud Adoption Framework.

| Level | TOC Entry | Topic Title | Filename | Summary |
|---|---|---|---|---|
| TOC | Introduction to the {{Token-Name}} scenario | Introduction to the {{Token-Name}} scenario | [toc.yml](toc.yml) | The yaml table of contents file contains the outline, the   order and organization, of documents in the scenario. The CAF content team   will make the required updates to the main TOC. This shouldn't be done by a   contributor, unless it's a separate TOC file for an end-to-end scenario. |
| L1 | {{Token-Name}} - Microsoft Cloud Adoption Framework for Azure | Introduction to the {{Token-Name}} scenario | [index.md](index.md) | The landing page describes the context and narrative of the   scenario. |
| L1 | {{Token-Name}} adoption - Microsoft Cloud Adoption Framework   for Azure | NA | NA | Table of contents section. |
| L1 | Strategic impact | Strategic impact of {{Token-Name}} | [strategy.md](strategy.md) | Best practice encourages customers to create a single   centralized cloud adoption strategy, using the [Cloud Adoption Framework's   Strategy   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/). |
| L1 | Technical planning | Plan for {{Token-Name}} | [plan.md](plan.md) | [Cloud Adoption Framework's Plan   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/)   helps create an overall cloud adoption plan to guide the programs and teams   involved in your cloud-based digital transformation. |
| L1 | Prepare your environment | NA | NA | Table of contents section. |
| L2 | Azure landing zones | Azure Landing Zone review for {{Token-Name}} | [ready.md](ready.md) | NA |
| L2 | Design areas | NA | NA | Table of contents section. |
| L3 | Billing and Active Directory tenant |  | [alz-azure-billing-and-active-directory-tenant.md](alz-azure-billing-and-active-directory-tenant.md) | Disclose any required dependency on ESLZ design area or other ALZ design areas, with links to those supporting materials. | 
| L3 | Enterprise enrollment |  | [alz-identity-and-access-management.md](alz-identity-and-access-management.md) | Disclose any required dependency on ESLZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Identity and access   management |  | [alz-network-topology-and-connectivity.md](alz-network-topology-and-connectivity.md) | Disclose any required dependency on ESLZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Network topology and   connectivity |  | [alz-resource-organization.md](alz-resource-organization.md) | Disclose any required dependency on ESLZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Resource organization |  | [alz-security.md](alz-security.md) | Disclose any required dependency on ESLZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Governance disciplines |  | [alz-management-.md](alz-management.md) | Disclose any required dependency on ESLZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Operations baseline |  | [alz-security-governance-and-compliance.md](alz-security-governance-and-compliance.md) | Disclose any required dependency on ESLZ design area or other   ALZ design areas, with links to those supporting materials. |
| L3 | Deployment options |  | [alz-platform-automation-and-devops.md](alz-platform-automation-and-devops.md) | Disclose any required dependency on ESLZ design area or other   ALZ design areas, with links to those supporting materials. |
| L2 | Implementation options | NA | NA | Table of contents section. |
| L3 | Example |  | NA | Link to a reference architecture |
| L3 | {{Token-Name}} on Azure landing zone   accelerator |  | [technology-name-landing-zone-accelerator.md](technology-name-landing-zone-accelerator.md) | The {{Token-LongName}} landing zone accelerator is an open-source   collection of Terraform templates that you can use to automate the deployment of an environment capable of hosting {{Token-LongName}}.  |
| L1 | Govern |  | [govern.md](govern.md) | The [Cloud Adoption Framework provides a   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/)   to systematically and incrementally improve governance of your cloud   portfolio. |
| L1 | Secure |  | [secure.md](secure.md) | Best practice encourages customers to create a single   centralized cloud adoption strategy, using the [Cloud Adoption Framework's   Strategy   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/) |
| L1 | Organize |  | [organize.md](organize.md) | Best practice encourages customers to create a single   centralized cloud adoption strategy, using the [Cloud Adoption Framework's   Organize   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/).  |
| L1 | Migrate {{Token-Name}} to   Azure |  | [migrate.md](migrate.md) | Establish a driving statement to shape migration of this   technology platform. Best practice encourages customers to create a migration   statement, using the [Cloud Adoption Framework's migrate   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/).  |
| L1 | Innovate with   {{Token-Name}} and Azure |  | [innovate.md](innovate.md) | The innovate methodology of the Cloud Adoption Framework for   Azure drives adoption through the build-measure-learn cycle. For more   information, see [Innovate   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/innovate/). |
| L1 | Modernize {{Token-Name}} |  | [modernize.md](modernize.md) | Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Modernize methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/modernize/).
| L1 | Manage {{Token-Name}} platform and workloads |  | [manage.md](manage.md) | The [Manage   methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/)   in the Microsoft Cloud Adoption Framework for Azure outlines a path for   implementing an operations baseline, and maturing that baseline throughout   your cloud adoption lifecycle. |
| L1 | Well-architected   considerations |  | [well-architected-framework.md](well-architected-framework.md) | For many of the named workloads, it's important to adhere to a   set of architectural principles. These principles help guide development and   optimization of the workloads. The five architectural constructs are detailed   in the [Azure Well-Architected Framework](https://docs.microsoft.com/azure/architecture/framework/). |
| L1 | {{Token-Name}} architectures |  | NA | Table of contents section. |
|  | Example |  | NA | Provide a title  and   link in the table of contents for one or more supporting [Azure reference   architectures](https://docs.microsoft.com/azure/architecture/browse/). |
| L1 | Azure product documentation |  | NA | Table of contents section. |
|  | Example |  | NA | Provide a title  and   link in the table of contents for one or more supporting [Technical documentation](https://docs.microsoft.com/documentation/). |
| L1 | Build skills on Learn |   | NA | Table of contents section. |
|  | Example |  | NA | Provide a title  and   link in the table of contents for one or more supporting [Learn modules](https://docs.microsoft.com/learn/). |

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

- For each ESLZ page, the headers and metadata need to look more like the corresponding file in the AKS scenario
- CAF team to review the articles and identify any additional requirements for each page
- CAF team to review the articles for quality to ensure we don't start with known errors
- CAF team to update the Ready article to match AKS scenario flow

## ThinkTank team steps to use this template

1. Review the table to understand the purpose of each document in the template.
1. Use the tokens to update the documents with the values for your sceneario.
1. All scenario articles (not prefixed with `alz-`) must accurately reflect the Cloud Adoption Framework (CAF) methodologies **and** the marketing motion to drive this scenario. Each starts with a series of sections that must be evaluated and updated based on CAF links in each section.
1. Add as many (##) H2 sections after the core CAF sections as required to tell the story and guide adoption.
1. Draft all remaining ESLZ articles (prefixed with `alz-`) to reflect any considerations or recommendations required to prepare for the ESLZ deployment. Any additional guidance may be added after the H2s for recommendations and considerations.

## For more information

See [CAF contributor workflow overview](https://review.docs.microsoft.com/en-us/help/contribute/cloud-adoption-framework/caf-contribution-overview?branch=main)
