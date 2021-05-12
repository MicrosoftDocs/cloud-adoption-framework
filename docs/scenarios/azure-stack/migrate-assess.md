---
title: Assess workloads for Azure Stack Hub migration
description: Assess workloads for Azure Stack Hub migration.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Assess workloads for Azure Stack Hub migration

This article assumes that you've decided to [integrate Azure Stack into your cloud strategy](./index.md), you've developed a [plan for Azure Stack Hub migration](./plan.md), and [your environment is ready for migration](./ready.md).

During the rationalization of your organization's digital estate in the Plan methodology, each workload was discovered and inventoried, and initial decisions were made based on quantitative data. Before you deploy each workload, it's important to validate the data and the decisions with qualitative data.

## Placement

The first data point to consider is placement. That is, will this workload be migrated to your public cloud, private cloud, or some other cloud platform, such as a sovereign cloud or service provider's Azure environment?

The information in each of the following sections can help validate your decisions about placement. The information will also help surface data that will be useful during the deployment of your workloads.

## Stakeholder value

Evaluate the value of migrating this workload with business and IT stakeholders:

- Less friction: short-term focus, limited long-term viability.
- More friction: long-term investment, easier to iterate and continue to modernize.
- A balance of the two.

## Governance, risk, and compliance

Assess the impact of regulatory, compliance, and privacy requirements:

- What data can reside on Azure and what data needs to stay on-premises?
- Who can manage the underlying platform?
- Is the data dependent on the location?
- Are there expiration dates for storing the data?

## Success metrics

Determine success metrics and availability tolerances:

- Performance
- Availability
- Resiliency
- Deployment or migration approach

## Licensing

Assess the impact of licensing and support:

- Are there product licensing restrictions that will limit transformation?
- Is the application or dataset supportable in the new environment?
- Are there third-party software vendors who need to provide support statements?

## Operations requirements

- Avoid duplication of effort and optimize service-level agreements (SLAs) by examining the correlation between IT-managed cloud services and application-specific services.
- Consider the automation that's required to orchestrate the provisioning of services during deployment and migration of applications.
- To help meet your operations requirements, consider [scalability and availability](https://azure.microsoft.com/blog/azure-stack-iaas-part-six/) services such as pay per use, availability sets, virtual machine scale sets, network adapters, and the ability to add and resize VMs and disks.

## Monitoring

- Monitor system health and operational status and performance by using well-defined metrics that form the basis of the SLAs that you offer your end users.
- Check security and compliance, evaluating how well the cloud environment meets the regulatory and compliance requirements that are imposed by the application.
- What are the processes for backup/restore and replication/failover?
- Find data-protection services for infrastructure as a service, platform as a service, and software as a service resources.
- Incorporate multiple vendors, technologies, and capabilities to achieve a comprehensive protection strategy.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
