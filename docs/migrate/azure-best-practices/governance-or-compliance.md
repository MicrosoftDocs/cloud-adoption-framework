---
title: Governance or compliance strategy
description: Governance or compliance strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Governance or compliance strategy

When governance or compliance is required throughout a migration effort, you need to broaden your scope to account for these requirements. The following guidance expands the scope of the [Azure migration guide](../azure-migration-guide/index.md) to address different approaches to addressing governance or compliance requirements.

## General scope expansion

Prerequisite activities are affected the most when governance or compliance are required. Additional adjustments can also be required during assessment, migration, and optimization.

## Suggested prerequisites

Configuration of the base Azure environment can change significantly when you're integrating governance or compliance requirements. To understand how prerequisites change, it's important to understand the nature of the requirements. Prior to beginning any migration that requires governance or compliance, you should choose and implement an approach in the cloud environment. The following are a few high-level approaches commonly seen during migrations:

**Common governance approach:** For most organizations, the [Cloud Adoption Framework governance model](../../govern/guides/index.md) is a sufficient approach. It consists of a minimum viable product (MVP) implementation, followed by targeted iterations of governance maturity to address tangible risks identified in the adoption plan. This approach provides the minimum tooling needed to establish consistent governance, so the team can understand the tools. It then expands on those tools to address common governance concerns.

**International Organization for Standardization (ISO) 27001 compliance blueprints:** If your organization is required to adhere to ISO compliance standards, the [ISO 27001 Shared Services blueprint samples](/azure/governance/blueprints/samples/iso27001-shared/) can serve as a more effective MVP. The blueprint can produce richer governance constraints, earlier in the iterative process. The [ISO 27001 App Service Environment/SQL Database workload blueprint sample](/azure/governance/blueprints/samples/iso27001-ase-sql-workload/) expands on the ISO 27001 Shared Services blueprint, to map controls and deploy a common architecture for an application environment.

**Cloud Adoption Framework enterprise-scale landing zone:** You might require a more robust governance starting point. If so, consider the [Cloud Adoption Framework enterprise-scale landing zone](../../ready/enterprise-scale/index.md). The Cloud Adoption Framework enterprise-scale landing zone approach focuses on adoption teams who have a mid-term objective (within 24 months) to host more than 1,000 assets (applications, infrastructure, or data assets) in the cloud. The Cloud Adoption Framework enterprise-scale landing zone is the de facto choice for complex governance scenarios for these larger cloud adoption efforts.

### Partnership option to complete prerequisites

**Microsoft Services:** Microsoft Services provides solution offerings that can align to the Cloud Adoption Framework governance model, compliance blueprints, or Cloud Adoption Framework enterprise-scale landing zone options. This option helps you to ensure that you're using the most appropriate governance or compliance model. Use the [Secure Cloud Insights](https://download.microsoft.com/download/C/7/C/C7CEA89D-7BDB-4E08-B998-737C13107361/Secure_Cloud_Insights_Datasheet_EN_US.pdf) solution to establish a data-driven picture of a customer deployment in Azure. This solution also validates the customer´s Azure implementation maturity while identifying optimization of existing deployment architectures. Secure Cloud Insights also helps you reduce risk pertaining to governance, security, and availability. Based on customer insights, you should lead with the following approaches:

- **Cloud foundation:** Establish the customer's core Azure designs, patterns, and governance architecture with the [hybrid cloud foundation](https://download.microsoft.com/download/D/8/7/D872DFD0-1C46-4145-95E4-B5EAB2958B96/Hybrid_Cloud_Foundation_Datasheet_EN_US.pdf) solution. Map the customer's requirements to the most appropriate reference architecture. Implement a minimum viable product consisting of shared services and IaaS workloads.
- **Cloud modernization:** Use the [cloud modernization](https://download.microsoft.com/download/3/7/3/373F90E3-8568-44F3-B096-CD9C1CD28AB7/Cloud_Modernization_Datasheet_EN_US.pdf) solution as a comprehensive approach to move applications, data, and infrastructure to an enterprise-ready cloud. You can also optimize and modernize after cloud deployment.
- **Innovate with cloud:** Engage the customer through the [cloud center of excellence (CCoE)](https://download.microsoft.com/download/F/8/B/F8BBE4BD-E5F8-4DFB-82F7-C0A4E17051BB/Cloud_Center_of_Excellence_Datasheet_EN_US.pdf) solution. It implements an agile approach to capture business requirements, and to reuse deployment packages aligned with security, compliance, and service management policies. It also maintains the alignment of the Azure platform with operational procedures.

## Assess process changes

During assessment, you must make additional decisions to align to the required governance approach. The cloud governance team provides all members of the cloud adoption team with any policy statements, architectural guidance, or governance or compliance requirements prior to the assessment of a workload.

### Suggested action during the assessment process

Governance and compliance assessment requirements are too customer-specific to provide general guidance on the actual steps taken during assessment. The process should include tasks and time for aligning to compliance and governance requirements.

For a deeper understanding of governance, read the overview of the [Disciplines of Cloud Governance](../../govern/governance-disciplines.md). This section of the Cloud Adoption Framework includes templates to document the policies, guidance, and requirements for each of the following sections:

- [Cost Management discipline](../../govern/cost-management/template.md)
- [Security Baseline discipline](../../govern/security-baseline/template.md)
- [Resource Consistency discipline](../../govern/resource-consistency/template.md)
- [Identity Baseline discipline](../../govern/identity-baseline/template.md)
- [Deployment Acceleration discipline](../../govern/deployment-acceleration/template.md)

For information about developing governance guidance based on the Cloud Adoption Framework governance model, see [Implement a cloud governance strategy](../../govern/corporate-policy.md).

## Optimize and promote process changes

During the optimization and promotion processes, the cloud governance team should invest time to test and validate adherence to governance and compliance standards. Additionally, this step is a good time for the cloud governance team to curate templates that provide additional guidance for future projects, particularly in the Deployment Acceleration discipline.

### Suggested action during the optimize and promote process

During this process, the project plan should include time allocations for the cloud governance team to execute a compliance review, for each workload planned for production promotion.

## Next steps

Return to the checklist to reevaluate any additional scope requirements for the migration effort.

> [!div class="nextstepaction"]
> [Migration best practices checklist](./index.md)
