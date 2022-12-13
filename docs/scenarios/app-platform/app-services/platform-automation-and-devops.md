---
title: Platform automation and DevOps for Azure App Service
description: Learn about design considerations and recommendations for platform automation and DevOps in the Azure App Service landing zone accelerator
author: martinekuan
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Platform automation and DevOps for the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for platform automation and DevOps when using the Azure App Service landing zone accelerator. Platform automation and DevOps provide opportunities to modernize your approach to environmental deployment with infrastructure-as-code options.

Learn more about the [platform automation and DevOps](../../../ready/landing-zone/design-area/platform-automation-devops.md) design area.

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service.

- When securing and protecting access to development, test, Q&A, and production environments, consider security options from a CI/CD perspective. Deployments happen automatically, so map access control accordingly.
- Consider using prefixes and suffixes with well-defined conventions to uniquely identify every deployed resource. These naming conventions avoid conflicts when deploying solutions next to each other and improve overall team agility and throughput.
- Consider deploying other resources like subscriptions, tagging, and labels to support your DevOps experience by tracking and tracing deployments and related artifacts.
- Depending on the network configuration, App Services might not be reachable from the public internet and the use of public hosted agents will not work for deployments. Plan to use [self-hosted agents](https://azure.github.io/AppService/2021/01/04/deploying-to-network-secured-sites.html) in that scenario.
- Consider deploying containerized applications to take advantage of simplified deployments using Docker Hub or Azure Container Registry.
- Adopt a branching strategy which will help you collaborate while providing flexibility as well. Keep your strategy simple, use short-living feature isolation and allow modifications back to your main branch through pull requests with manual and automated code analysis.
- Make sure that your business logic is checked by unit tests in the build pipeline. Use integration tests in the release pipeline to check that every service and resource work together after a new release and check the most critical UI elements with automated UI tests. Cover non-functional performance requirements with load tests (eg k6, JMeter) in your staging environment.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of App Service.

- Rely on pipelines or actions to:
    - Maximize applied practices across the team.
    - Remove much of the burden of reinventing the wheel.
    - Provide predictability and insights in overall quality and agility.
- Deploy early and often by using trigger-based and scheduled pipelines. Trigger-based pipelines ensure changes go through proper validation, while scheduled pipelines manage behavior in changing environments.
- Separate infrastructure deployment from application deployment. Core infrastructure changes less than applications. Treat each type of deployment as a separate flow and pipeline.
- Store secrets and other sensitive artifacts in the relevant secret store (eg Azure Key Vault or GitHub secrets), allowing actions and other workflow parts to read them if needed while executing.
-  Strive for maximized deployment concurrency by avoiding hardcoded configuration items and settings.
-  Embrace [shift left](/azure/devops/learn/devops-at-microsoft/shift-left-make-testing-fast-reliable) security by adding vulnerability and secret scanning tools like container scanning early in the pipeline.
- Leverage blue/green deployment using deployment slots to validate application changes and minimize downtime.
