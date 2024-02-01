---
title: Environments
description: Design area guidance for multistage environments.
author: elbatane
ms.author: elbatane
ms.date: 06/17/2022
ms.topic: conceptual
ms.custom: internal
---

# Environments

Use the [Continuous Delivery](../considerations/development-strategy-development-lifecycle.md#deployment-strategy) process to quickly and safely delivers new value to production. You can deliver small changes frequently, which reduces the risk of problems.

Other factors affect "deployment pain to production", including your adoption of multiple delivery/deployment environments. A multienvironment approach lets you build, test, and release code with greater speed and frequency to make your deployment as straightforward as possible. You can remove manual overhead and the risk of a manual release, and instead automate development with a multistage process targeting different environments.

A common multienvironment architecture includes four tiers:

- Development
- Test
- Staging
- Production

In this architecture, your product transitions in order from Development (the environment where you develop changes to the software) through Production (the environment your users directly interact with). You might also introduce a User Acceptance Test (UAT) environment to validate end-to-end business flow.

| Environment | Description |
| - | - |
| Development | Your development environment (dev) is where changes to software are developed. |
| Test | Your test environment allows either human testers or automated tests to try out new and updated code. Developers must accept new code and configurations through unit testing in your development environment before allowing those items to enter one or more test environments. |
| Staging | Staging is where you do final testing immediately prior to deploying to production. Each staging environment should mirror an actual production environment as accurately as possible. |
| UAT | User Acceptance Testing (UAT) allows your end-users or clients to perform tests to verify/accept the software system before a software application can move to your production environment. |
| Production | Your production environment (production), sometimes called *live*, is the environment your users directly interact with. |

## Design considerations

Apply the following considerations to both Azure Landing Zones and Azure Workloads development:

- Test environments are important because they allow platform developers to test changes before deploying to production, which reduces risk related to delivery in production.
- Keeping your environments as similar as possible makes it easy to find environment-related errors in the first phases of testing, which increases development and testing speed and reliability.
- If there are discrepancies in the configuration of your environments, "configuration drift" happens, which can result in data loss, slower deployments, and failures.
- You can speed up deployments, improve environment consistency, and reduce "configuration drift" between environments by adopting Infrastructure as Code (IaC).
- Consider adopting methods like Canary or Blue-Green Deployments that make new features available only to a limited set of test users in production and help reduce the time to release into production.
- Use checks on test results to control the transition of code from development to production. You can automate these controls so that failing tests prevents changes from automatically deploying to the next environment.
- Have designated users review pull requests before code is deployed to production. Consider using repositories with [branch strategy](../considerations/development-strategy-development-lifecycle.md#branch-strategy) to manage the review process.
- Avoid silos by allowing all developers to access all environments.

## Workloads

To learn how to manage environments for Workloads refer to [Enterprise-scale FAQ](../enterprise-scale/faq.md).

## Azure Landing Zones

Adopting multiple environments for an Azure Landing Zone deployment is common when a customer wants to test the effects and results of new Azure Policy Assignments, Azure RBAC role assignments, Microsoft Entra group memberships, Azure resources' creation, and more.

[Testing approach for enterprise-scale](../enterprise-scale/testing-approach.md) describes two different adoption approaches:

- Replication of management group hierarchy in Canary and Production environment
- Sandbox subscriptions

Regardless of which approach you follow, you should always:
- Adopt at least one environment for testing.
- Use separated Service Principals for test and production purposes to protect your environments.
- Implement automated checks and approvals to validate and approve changes prior to deploying any change to a particular environment

## Next steps

- [Create and target an environment](/azure/devops/pipelines/process/environments)

- [Using environments for deployment (GitHub)](https://docs.github.com/en/github-ae@latest/actions/deployment/targeting-different-environments/using-environments-for-deployment)
