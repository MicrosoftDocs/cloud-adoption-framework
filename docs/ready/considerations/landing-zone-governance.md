---
title: Improve landing zone governance
description: Improve landing zone governance.
author: asudbring
ms.author: allensu
ms.date: 06/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Improve landing zone governance

When a workload or the landing zones that hosts it are deployed and configured, it's important to have overall Governance of the environment.

Adoption of the cloud is a journey, not a destination. When you've reached the Ready state, you have an ongoing responsibility to govern the deployed environment. Focus on objectives and key results when envisioning a governance end state. Map concepts, frameworks, and standards to the disciplines in the CAF [govern methodology](/azure/cloud-adoption-framework/govern/) alongside mapping to roles and responsibilities for human discipline. The govern methodology provides guidance.

The following is an overview of the guidance with links to further details.

## Methodology

Understand the pieces of the methodology and how they fit into the design. Evaluate corporate policies and processes and how they will align with the over all governance strategy. Envision an end state and then grow to that end state. For more information about the govern methodology in the Cloud Adoption Framework, see [Governance in the Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/govern/).

## Benchmark

Assess your transformation journey. The Cloud Adoption Framework provides a governance benchmark tool to help you identify gaps in your organization across six key domains as defined in the framework.

- [Governance benchmark tool](https://cafbaseline.com/): Receive a personalized report that outlines the difference between your current state and business priorities, along with tailored resources to help you get started. Assess your current state and future state to establish a vision for applying the framework.

## Initial cloud governance

It can't be a challenge to have an effective balance between speed and control. Execution of early methodologies within the cloud adoption can conflict between speed and control. The governance guidance within the Cloud Adoption Framework helps provide a balance with an agile approach to adoption.

The following are two examples of a governance foundation, also know as governance MVPs.

- [Standard governance guide](/azure/cloud-adoption-framework/govern/guides/standard/): A guide for most organizations based on the recommended initial two-subscription model, designed for deployments in multiple regions but not spanning public and sovereign/government clouds.

- [Governance guide for complex enterprises](/azure/cloud-adoption-framework/govern/guides/complex/): A guide for enterprises that are managed by multiple independent IT business units or span public and sovereign/government clouds.

## Improve your initial cloud governance foundation

During your cloud adopting plan implementation, risks will emerge from approaches teams want to use to adopt the cloud.

The following is additional guidance that can be used when risks surface during planning conversations.

[Maturity vectors](/azure/cloud-adoption-framework/govern/foundation-improvements#maturity-vectors): Best practices that can be applied to the initial governance foundation to address a risk or need.

## Governance considerations

Changes to business processes or technology platforms introduces risk to the business. Slight changes in the corporate narrative or corporate polices can affect adoption.

The guidance in the following examples can help to develop your corporate policies.

[Business risk](/azure/cloud-adoption-framework/govern/policy-compliance/business-risk): Investigate current cloud adoption plans and data classification to identify risks to the business. Work with the business to balance risk tolerance and mitigation costs.

[Policy and compliance](/azure/cloud-adoption-framework/govern/policy-compliance/policy-definition): Evaluate risk tolerance to inform minimally invasive policies that govern cloud adoption and manage risks. In some industries, third-party compliance affects initial policy creation.

[Processes](/azure/cloud-adoption-framework/govern/policy-compliance/processes): The pace of adoption and innovation activities will naturally create policy violations. Executing relevant processes will aid in monitoring and enforcing adherence to policies.

## Disciplines of Cloud Governance

There are common governance disciplines that inform policies and align toolchains with any cloud platform. The disciplines guide decisions about the level of automation and enforcement of corporate policy across cloud platforms.

The following is additional guidance on the [Five Disciplines of Cloud Governance](/azure/cloud-adoption-framework/govern/governance-disciplines#disciplines-of-cloud-governance).

- [Cost Management](/azure/cloud-adoption-framework/govern/cost-management/): Cost is a primary concern for cloud adoption. Develop policies for cost control for all cloud platforms.

- [Security Baseline](/azure/cloud-adoption-framework/govern/security-baseline/): Security is a complex subject, unique to each company. Once security requirements are established, cloud governance policies and enforcement apply those requirements across network, data, and asset configurations.

- [Identity Baseline](/azure/cloud-adoption-framework/govern/identity-baseline/): Inconsistencies in the application of identity requirements can increase the risk of breach. The Identity Baseline discipline focuses on ensuring that identity is consistently applied across cloud adoption efforts.

- [Resource Consistency](/azure/cloud-adoption-framework/govern/resource-consistency/): Cloud operations depend on consistent resource configuration. Through governance tooling, resources can be configured consistently to manage risks related to onboarding, drift, discoverability, and recovery.

- [Deployment Acceleration](/azure/cloud-adoption-framework/govern/deployment-acceleration/): Centralization, standardization, and consistency in approaches to deployment and configuration improve governance practices. When provided through cloud-based governance tooling, they create a cloud factor that can accelerate deployment activities.

## Landing zone governance best practices

The following list of guides and best practices provide examples of ways to improve landing zone governance:

- [Naming and tagging standards](../azure-best-practices/naming-and-tagging.md): Ensure consistency in naming and tagging, which is the foundational data for establishing sound governance practices.

- [Track costs across workloads](../azure-best-practices/track-costs.md): Begin tracking costs in your first landing zone. Evaluate how you will apply consistency across multiple workloads and roles.

- [Scale with multiple subscriptions](../azure-best-practices/scale-subscriptions.md): Evaluate how this landing zone and other landing zones will scale, as multiple subscriptions become a requirement.

- [Organize subscriptions](../landing-zone/design-area/resource-org.md): Understand how to organize and manage multiple subscriptions.

## Next steps

Cloud adoption will continue to expand with each wave or release of new workloads. To stay ahead of these requirements, cloud platform teams should periodically review the landing zone design areas.

> [!div class="nextstepaction"]
> [Review landing zone design areas](../landing-zone/design-areas.md)
