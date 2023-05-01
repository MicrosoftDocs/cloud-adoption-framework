---
title: The Five Disciplines of Cloud Governance
description: The Cloud Adoption Framework covers Cost Management, Security Baseline, Identity Baseline, Resource Consistency, and Deployment Acceleration disciplines.
author: martinekuan
ms.author: martinek
ms.date: 01/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal, UpdateFrequency2
---

# The Five Disciplines of Cloud Governance

<!-- docutune:casing "Disciplines of Cloud Governance" "Cost Management" "Security Baseline" "Identity Baseline" "Resource Consistency" "Deployment Acceleration" -->

:::row:::
    :::column:::
        Any change to business processes or technology platforms introduces risk. Cloud governance teams, whose members are sometimes known as cloud custodians, mitigate risks and ensure minimal interruption to adoption or innovation efforts. <br><br> The Cloud Adoption Framework governance model guides these decisions by focusing on [development of corporate policy](./corporate-policy.md) and the [Five Disciplines of Cloud Governance](#disciplines-of-cloud-governance). [Actionable design guides](./guides/index.md) demonstrate this model using Azure services. Learn about the disciplines of the Cloud Adoption Framework governance model.
    :::column-end:::
    :::column:::
        [![Diagram of the Cloud Adoption Framework governance model corporate policy and governance disciplines.](../_images/operational-transformation-govern-thumbnail.png)](../_images/operational-transformation-govern-large.png#lightbox) <br>
    :::column-end:::
:::row-end:::

## Disciplines of Cloud Governance

With any cloud platform, there are common governance disciplines that help inform policies and align toolchains. These disciplines guide decisions about the proper level of automation and enforcement of corporate policy across cloud platforms.

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> ![Cost Management](../_images/govern/cost-management.png) | <br> [Cost Management](./cost-management/index.md): Cost is a primary concern for cloud users. Develop policies for cost control for all cloud platforms. |
| <br> ![Security Baseline](../_images/govern/security-baseline.png) | <br> [Security Baseline](./security-baseline/index.md): Security is a complex subject, unique to each company. Once security requirements are established, cloud governance policies and enforcement apply those requirements across network, data, and asset configurations.|
| <br> ![Identity Baseline](../_images/govern/identity-baseline.png) | <br> [Identity Baseline](./identity-baseline/index.md): Inconsistencies in the application of identity requirements can increase the risk of breach. The Identity Baseline discipline focuses on ensuring that identity is consistently applied across cloud adoption efforts. |
| <br> ![Resource Consistency](../_images/govern/resource-consistency.png) | <br> [Resource Consistency](./resource-consistency/index.md): Cloud operations depend on consistent resource configuration. Through governance tooling, resources can be configured consistently to manage risks related to onboarding, drift, discoverability, and recovery. |
| <br> ![Deployment Acceleration](../_images/govern/deployment-acceleration.png) | <br> [Deployment Acceleration](./deployment-acceleration/index.md): Centralization, standardization, and consistency in approaches to deployment and configuration improve governance practices. When provided through cloud-based governance tooling, they create a cloud factor that can accelerate deployment activities. |
