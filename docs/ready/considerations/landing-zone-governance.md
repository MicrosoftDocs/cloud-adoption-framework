---
title: Improve landing zone governance
description: Improve landing zone governance.
author: asudbring
ms.author: allensu
ms.date: 06/29/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Improve landing zone governance

When a workload or the landing zones that hosts it are deployed and configured, it's important to have overall Governance of the environment.

As you're exiting the Ready state, you will have established a governance baseline for your current cloud estate. As your cloud estate evolves over time, you will have to evolve your cloud governance policies and processes. Governance is an iterative process. The govern methodology provides guidance.

Below we provide an overview of this guidance with links to the details.

## Methodology

Understand the pieces of the methodology and how they fit into the design as an ongoing exercise. Evaluate corporate policies and processes and how they will align with the overall governance strategy of your existing deployment. For more information about the govern methodology in the Cloud Adoption Framework, see [Governance in the Microsoft Cloud Adoption Framework for Azure](../../govern/index.md).

## Benchmark

Assess your transformation journey. The Cloud Adoption Framework provides a governance benchmark tool to help you identify gaps in your organization across six key domains as defined in the framework.

- [Governance benchmark tool](https://cafbaseline.com/): Receive a personalized report that outlines the difference between your current state and business priorities, along with tailored resources to help you get started. Assess your current state and future state to establish a vision for applying the framework.

## Improve your initial cloud governance foundation

During your cloud adopting plan implementation, risks will emerge from approaches teams want to use to adopt the cloud.

The following is additional guidance that can be used when risks surface during your ongoing cloud adoption and implementation:

- [Maturity vectors](../../govern/foundation-improvements.md#maturity-vectors): Best practices that can be applied to the initial governance foundation to address a risk or need.

## Governance considerations

Changes to business processes or technology platforms introduce risk to the business. Slight changes in the corporate narrative or corporate policies can affect continued adoption of the cloud platform.

The guidance in the following examples can help to develop your corporate policies.

- [Business risk](../../govern/policy-compliance/business-risk.md): Investigate current cloud adoption plans and data classification to identify risks to the business. Work with the business to balance risk tolerance and mitigation costs.

- [Policy and compliance](../../govern/policy-compliance/policy-definition.md): Evaluate risk tolerance to inform minimally invasive policies that govern cloud adoption and manage risks. In some industries, third-party compliance affects initial policy creation.

- [Processes](../../govern/policy-compliance/processes.md): The pace of adoption and innovation activities will naturally create policy violations. Executing relevant processes will aid in monitoring and enforcing adherence to policies.

## Disciplines of Cloud Governance

There are common governance disciplines that inform policies and align toolchains with any cloud platform. The disciplines guide decisions about the level of automation and enforcement of corporate policy across cloud platforms.

The following is additional guidance on the [Five Disciplines of Cloud Governance](../../govern/governance-disciplines.md#disciplines-of-cloud-governance).

- [Cost Management](../../govern/cost-management/index.md): Cost is a primary concern for cloud adoption. Develop policies for cost control for all cloud platforms.

- [Security Baseline](../../govern/security-baseline/index.md): Security is a complex subject, unique to each company. Once security requirements are established, cloud governance policies and enforcement apply those requirements across network, data, and asset configurations.

- [Identity Baseline](../../govern/identity-baseline/index.md): Inconsistencies in the application of identity requirements can increase the risk of breach. The Identity Baseline discipline focuses on ensuring that identity is consistently applied across cloud adoption efforts.

- [Resource Consistency](../../govern/resource-consistency/index.md): Cloud operations depend on consistent resource configuration. Through governance tooling, resources can be configured consistently to manage risks related to onboarding, drift, discoverability, and recovery.

- [Deployment Acceleration](../../govern/deployment-acceleration/index.md): Centralization, standardization, and consistency in approaches to deployment and configuration improve governance practices. When provided through cloud-based governance tooling, they create a cloud factor that can accelerate deployment activities.

## Landing zone governance best practices

The following list of guides and best practices provide examples of ways to improve landing zone governance:

- [Naming and tagging standards](../azure-best-practices/naming-and-tagging.md): Ensure consistency in naming and tagging, which is the foundational data for establishing sound governance practices.

- [Track costs across workloads](../azure-best-practices/track-costs.md): Begin tracking costs in your first landing zone. Evaluate how you will apply consistency across multiple workloads and roles.

- [Scale with multiple subscriptions](../azure-best-practices/scale-subscriptions.md): Evaluate how this landing zone and other landing zones will scale, as multiple subscriptions become a requirement.

- [Organize subscriptions](../landing-zone/design-area/resource-org.md): Understand how to organize and manage multiple subscriptions.

- [Why update your Azure landing zones?](../../govern/resource-consistency/why-update-azure-landing-zone.md): Why you should update your Azure landing zone environment, and how to get more information.

## Next steps

Cloud adoption will continue to expand with each wave or release of new workloads. To stay ahead of these requirements, cloud platform teams should periodically review the landing zone design areas.

> [!div class="nextstepaction"]
> [Review landing zone design areas](../landing-zone/design-areas.md)
