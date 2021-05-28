---
title: Understand and align the portfolio hierarchy
description: Understand and align the portfolio hierarchy
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

<!-- cSpell:ignore matrixed ISVs -->

# Understand and align the portfolio hierarchy

Business needs are often supported, improved, or accelerated through information technology. A collection of technologies that delivers defined business value is called a *workload*. That collection might include applications, servers or virtual machines, data, devices, and other similarly grouped assets.

Typically, a business stakeholder and technical leader share accountability for the ongoing support of each workload. In some phases of the workload lifecycle, those roles are clearly stated. In more operational phases of a workload's lifecycle, those roles might be transitioned to a shared operations management team or cloud operations team. As the number of workloads increases, the roles (stated or implied) become more complex and more matrixed.

Most businesses rely on multiple workloads to deliver vital business functions. The collection of workloads, assets, and supporting factors (projects, people, processes, and investments) is called a *portfolio*. The matrix of business, development, and operations staff requires a portfolio hierarchy to show how the workloads and supporting services all fit together.

This article provides clear definitions for the levels of the portfolio hierarchy. The article aligns various teams with the appropriate accountability in each layer, along with the source of the best guidance for that team to deliver on the expectations for that level. Throughout this article, each level of the hierarchy is also called a *scope*.

## Portfolio hierarchy

### Workloads

Workloads and their supporting assets are at the core of any portfolio. The additional scopes or layers below define how those workloads are viewed and to what extent they're affected by the matrix of potential supporting teams.

<!-- cSpell:ignore buildout -->

![Image of a workload in the cloud, showing workloads and assets together](../../_images/ready/buildout-workload-assets.png)

Although the terms can vary, all IT solutions include assets and workloads:

- **Asset:** The smallest unit of technical function that supports a workload or solution.
- **Workload:** The smallest unit of IT support for the business. A workload is a collection of assets (infrastructure, applications, and data) that supports a common business goal or the execution of a common business process.

When you're deploying your first workload, the workload and its assets might be the only defined scope. The other layers might be explicitly defined as more workloads are deployed.

### IT portfolio

When companies support workloads through matrixed approaches or centralized approaches, a broader hierarchy likely exists to support those workloads:

![Image of an IT portfolio with multiple public and private cloud platforms](../../_images/ready/buildout-cloud-platforms.png)

- **Landing zones:** Landing zones provide workloads with the necessary *foundational utilities* (or shared plumbing) that are provided from a *platform foundation* that's required to support one or more workloads. Landing zones are so critical in the cloud that the entire Ready methodology of the Cloud Adoption Framework focuses on landing zones. For a more detailed definition, see [What is a landing zone?](../../ready/landing-zone/index.md)
- **Foundational utilities:** These shared IT services are required for workloads to operate within the technology and business portfolio.
- **Platform foundation:** This organizational construct centralizes foundational solutions and helps ensure that those controls are enforced for all landing zones.
- **Cloud platforms:** Depending on the overall strategy for supporting the full *portfolio*, customers might need multiple cloud platforms with distinct deployments of the platform foundation to govern multiple regions, hybrid solutions, or even multicloud solutions.
- **Portfolio:** Through a technology lens, the portfolio is a collection of workloads, assets, and supporting resources that span all cloud platforms. Through a business lens, the portfolio is the collection of projects, people, processes, and investments that support and manage the technology portfolio to drive business outcomes. Together, these two lenses capture the *portfolio*.

## Hierarchy accountability and guidance

An accountable team manages each layer of the portfolio hierarchy. The following diagram shows the mapping between the accountable team and the guidance to support its business decisions, technical decisions, and technical implementation.

> [!NOTE]
> The teams mentioned in the following list might be virtual teams or individuals. For some variants of this hierarchy, some of the accountable teams can be collapsed as described later in the accountability variants.

![Accountability aligned to the hierarchy](../../_images/ready/hierarchy-with-roles.png)

<!-- docutune:ignore "Strategy and Plan methodologies" "Migrate and Plan methodologies" "Migrate and Innovate methodologies" -->

- **Portfolio:** The cloud strategy team and the cloud center of excellence (CCoE) use the Strategy and Plan methodologies to guide decisions that affect the overall portfolio. The cloud strategy team is accountable for the enterprise level of the cloud portfolio hierarchy. The cloud strategy team should also be informed of decisions about the environment, landing zones, and high-priority workloads.
- **Cloud platforms:** The cloud governance team is accountable for the disciplines that ensure consistency across each environment in alignment with the Govern methodology. The cloud governance team is accountable for governance of all resources in all environments. The cloud governance team should be consulted on changes that might require an exception or change to governing policies. The cloud governance team should also be informed of progress with workload and asset adoption.
- **Landing zones and cloud foundation:** The cloud platform team is accountable for developing the landing zones and platform utilities that support adoption. The cloud automation team is accountable for automating the development of, and ongoing support for, those landing zones and platform utilities. Both teams use the Ready methodology to guide implementation. Both teams should be informed of progress with workload adoption and any changes to the enterprise or environment.
- **Workloads:** Adoption happens at the workload level. Cloud adoption teams use the Migrate and Innovate methodologies to establish scalable processes to accelerate adoption. After adoption is complete, the ownership of workloads is likely transferred to a cloud operations team that uses the Manage methodology to guide operations management. Both teams should be comfortable using the Microsoft Azure Well-Architected Framework to make detailed architectural decisions that affect the workloads they support. Both teams should be informed of changes to landing zones and environments. Both teams might occasionally contribute to landing zone features.
- **Assets:** Assets are typically the responsibility of the cloud operations team. That team uses the management baseline in the Manage methodology to guide operations management decisions. It should also use Azure Advisor and the Azure Well-Architected Framework to make detailed resource and architectural changes that are required to deliver on operations requirements.

### Accountability variants

- **Single environment:** When an enterprise needs only one environment, a CCoE is typically not required.
- **Single landing zone:** If an environment has only a single landing zone, the governance and platform capabilities can likely be combined into one team.
- **Single workload:** Some businesses need only one workload, or few workloads, in a single landing zone and a single environment. In those cases, there's little need for a separation of duties between governance, platform, and operations teams.

## Common workload and accountability examples

The following examples illustrate the portfolio hierarchy.

### COTS workloads

Traditionally, enterprises have favored commercial-off-the-shelf (COTS) software solutions to power business processes. These solutions are installed, configured, and then operated. There is little change to the solutions architecture after configuration.

In these scenarios, any cloud adoption of COTS solutions ends with a transition to a cloud operations team. The cloud operations team then becomes the technical owner for that software and assumes accountability for managing configuration, cost, patching cycles, and other operational needs.

These workloads include accounting packages, logistics software, or industry-specific solutions. In Microsoft terminology, the vendors of these packages are called independent software vendors (ISVs). Many ISVs offer a service to deploy and maintain an instance of their software package in your subscriptions. They might also offer a version of the software package that runs in their own cloud-hosted environment, providing a platform as a service (PaaS) alternative to the workload.

With the exception of PaaS offerings, cloud operations teams are responsible for ensuring basic operational compliance requirements for those workloads. A cloud operations team should work with the cloud governance team to align cost, performance, and other architecture pillars.

### In development with active revisions

When a COTS solution or PaaS offering isn't aligned to the business need, or no solution exists, enterprises build custom-developed workloads. Typically, a small percentage of the IT portfolio uses this workload approach. But these workloads tend to drive a disproportionately high percentage of IT's contribution to business outcomes, especially outcomes related to new revenue streams. These workloads tend to map well to new innovation ideas.

Given various movements that are rooted in agile methodologies and DevOps practices, these workloads favor a business/DevOps alignment over traditional IT management. For these workloads, there might not be a handoff to the cloud operations team for several years. In those cases, the development team serves as the technical owner of the workload.

Due to extensive time and associated capital constraints, custom development options are often limited to high-value opportunities. Typical examples include application innovations, deep data analysis, or mission-critical business functions.

### Break/fix or sunset development

After a custom-developed workload reaches peak maturity, the development team might be reassigned to other projects. In these cases, technical ownership typically transitions to a cloud operations team. When there's a need for small fixes, the operations team will enlist developers to resolve the error.

In some cases, the development team moves to a project that will eventually replace the current workload. Alternatively, the team might move on because the business opportunity supported by the workload is being phased out. These are examples of sunset scenarios, where the cloud operations team serves as the technical owner until the workload is no longer needed.

In both scenarios, the cloud operations team typically serves as the long-term technical owner and decision maker. That team will likely enlist application developers when operational changes require significant architectural changes.

### Mission-critical workloads

In every company, a few workloads are too important to the business for them to fail. With these mission-critical workloads, there are usually operations and development owners with various levels of responsibility. Those teams should align operational changes and architectural changes to minimize disruptions to the production solution.

These scenarios require a strong focus on separation of duties. To achieve separation of duties, the operations team will generally hold accountability for day-to-day operational changes in the production environment. When those operational changes require an architectural change, they'll be completed by the development or adoption team in a nonproduction environment, before the operations team applies the changes to production.

Examples of mission-critical workloads with a required separation of duties include workloads like SAP, Oracle, or other enterprise resource planning (ERP) solutions, which span multiple business units in the company.

## Strategy portfolio alignment

It's important to understand the strategic objectives of the cloud adoption effort and align the portfolio to support that transformation. A few common types of strategic portfolio alignment help shape the structure of the portfolio hierarchy. The following sections provide examples of the portfolio alignment and impact on the portfolio hierarchy.

### Innovation or development-led portfolio

Some companies, especially fast-growing established startups, have a higher-than-average percentage of custom development projects. In development-heavy portfolios, the environment, landing zone, and workloads are often compressed, so there might be specific environments (either production or nonproduction) for specific workloads. This results in a 1:1 ratio between environment, landing zone, and workload.

Because the environment hosts custom solutions, the DevOps pipeline and application-level reporting might replace the need for operations and governance functions. For those customers, a reduced focus on operations, governance, or other supporting roles is likely. A stronger emphasis on the responsibilities of the cloud adoption and cloud automation teams is also typical.

**Portfolio alignment:** The IT portfolio will likely focus on workloads and workload owners to drive critical architecture decisions. Those teams are likely to find more value in the Azure Well-Architected Framework guidance during adoption and operations activities.

**Boundary definitions:** The logical boundaries, even at an enterprise level, will likely focus on production and nonproduction environment segmentation. There might also be clear segmentation between products in the company's software portfolio. At times, there might also be segmentation between development and hosted customer instances.

### Operations-led portfolio

Multinational enterprise organizations with more established IT operations teams typically have a stronger focus on governance and operations than development. In these organizations, a higher percentage of workloads typically align to the COTS or break/fix categories, maintained by technical owners within the cloud operations team.

**Portfolio alignment:** The IT portfolio will be workload aligned, but those workloads are then aligned to operating units or business units. There might also be organization around funding models, industry, or other business segmentation requirements.

**Boundary definitions:** Landing zones will likely group applications into application archetypes to keep similar operations in a similar segmentation. Environments will likely refer to physical constructs like datacenter, nation, cloud-provider region, or other operational organization standards.

### Migration-led portfolio

Similar to operations-led portfolios, a portfolio that is largely built through migration will be based on specific business drivers that led to the migration of existing assets. Typically, the datacenter is the biggest factor in those drivers.

**Portfolio alignment:** The IT portfolio might be workload aligned, but it's more likely asset aligned. If transitions to IT operations have happened in the company's history, many active-use assets might not be easily mapped to a funded workload. In these cases, many assets might not have a defined workload or clear workload owner until late in the migration process.

**Boundary definitions:** Landing zones will likely group applications into boundaries that reflect on-premises segmentation. Though not a best practice, environments often match the on-premises datacenter name and landing zones that represent network segmentation practices. It's a better practice to adhere to segmentation that more closely aligns with an operations-led portfolio.

### Governance-led portfolio

Alignment to governance teams should happen as early as possible. Through governance practices and cloud governance tooling, portfolios and environmental boundaries can best balance the needs of innovation, operations, and migration efforts.

**Portfolio alignment:** Governance-led portfolios tend to include data points that capture innovation and operations details, such as workload, operations owner, data classification, and operational criticality. These data points create a well-rounded view of the portfolio.

**Boundary definitions:** Boundaries in a governance-led portfolio tend to favor operations over innovation, while using a management-group-driven hierarchy that maps to criteria for business units and development environments. At each level of the hierarchy, a cloud governance boundary can have different degrees of policy enforcement to allow for development and creative flexibility. At the same time, production-grade requirements can be applied to production subscriptions to ensure separation of duties and consistent operations.
