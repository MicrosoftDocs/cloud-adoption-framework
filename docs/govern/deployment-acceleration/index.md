---
title: Deployment Acceleration discipline overview
description: The Deployment Acceleration discipline in the Cloud Adoption Framework for Azure provides guidance on deployment processes that enable timely release of your solutions.
author: robbagby
ms.author: robbag
ms.date: 10/20/2022
ms.topic: conceptual
s.custom: internal, UpdateFrequency2
---

# Deployment Acceleration discipline

Deployment acceleration is one of the Five Disciplines of Cloud Governance within the Cloud Adoption Framework governance model. This discipline provides guidance on DevOps processes that will accelerate the deployment of your solutions. Implementing automated deployment and release processes that validate both application functionality and compliance with corporate policies at the onset of a project enables stable, compliant and timely releases.

## Tooling

The following tools are available to govern Azure resources.

- [Azure Policy](/azure/governance/policy/overview) is the primary tool to enforce resource consistency of Azure resources and assess compliance at-scale. Policies can be deployed to either audit or enforce compliance.
- [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines) are automated processes you can use to build, test, package, release, or deploy any project. Azure Pipelines integrate with source code repositories such as GitHub.
- [GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows#about-workflows) are automated processes you can use to build, test, package, release, or deploy any project on GitHub.

## Enable accelerated deployments

In this discipline, you'll learn about the DevOps practices that will enable your development teams to deploy quality releases with greater velocity. This discipline provides guidance on making deployments consistent and repeatable and ensuring policy compliance is visible in deployments.

Consider the deployment acceleration guidance for the following areas.

- [Consistency and repeatability in deployments](deployment-consistency-repeatability.md)
- [Policy visibility in deployments](policy-visibility-in-deployment.md)
