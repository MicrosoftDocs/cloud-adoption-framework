---
title: Development Strategy - Environments
description: Design area guidance for multistage environments in the development strategy
author: elbatane
ms.author: elbatane
ms.date: 03/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Environments

## Introduction

[Continuous Delivery](../considerations/development-strategy-development-lifecycle.md#deployment-strategy) is the process that delivers new value to production in a safe and quick way. 
You can deliver frequently, which means the changes are small, reducing the risk of problems but other factors impact the "deployment pain to production": one of them is the adoption of multiple delivery/deployment environments. 

The purpose of a multi-environments approach is to build, test, and release code with greater speed and frequency so that deployment is as straightforward as possible.

As the manual release in production contains an element of risk, the manual overhead is removed and development is automated with a multistage process that targets different environments. A common 4 tier architecture for environments includes development, test, staging, and production. Your product should transition in order from Development (the environment in which changes to the software are developed) through to Production (the environment that users directly interact with). Sometimes a User Acceptance Test (UAT) environment is also introduced to validate end-to-end business flow.

| Environment | Description |
| - | - |
| Development | The development environment (dev) is the environment in which changes to the software are developed. | 
| Test | The purpose of the test environment is to allow either automated tests or human testers to exercise the new and changed code. After the developer accepts the new code and configurations through unit testing in the development environment, the items are moved to one or more test environments. |
| Staging | Staging is an environment for final testing immediately prior to deploying to production. It seeks to mirror the actual production environment as closely as possible. |
| UAT | The purpose of User Acceptance Testing (UAT) is to allow end-users or clients to perform tests to verify/accept the software system before moving the software application to the production environment. |
| Production | The production environment (prod) is also known as live as it is the environment which users directly interact with. |

## Principles and practices design considerations

The following considerations can be applied both to Azure Landing Zones and Workloads development: 

- Having test environments is important for platform developers to test changes before deploying to production. It consequently reduces the risk related to delivery in production.
- Having environments as similar as possible allows finding environment's related errors in the first phases of the tests. It makes the development and test process faster and more reliable.
- When there are discrepancies between the configuration of different environments, we get "configuration drift". It is recommended to reduce this kind of inconsistencies that can result in data loss, slower deployments, and cause failures.
The adoption of Infrastructure as Code (IaC) is recommended to speed up deployments, improve environment consistency and reduce "configuration drift" between environments.
- Consider the adoption of methods like Canary or Blue-Green Deployments to make new features available only to a limited set of test users in production initially, reducing the time to release into production.
- The transition of the code from the Development to the Production environment should be controlled by checks on tests' results. These controls can be automated, in this case failing tests should prevent the process from automatically deploying changes to the next environment. 
- Designated users should review Pull Requests before code deployments to production. Consider using repositories, with opportune [branch strategy](../considerations/development-strategy-development-lifecycle.md#branch-strategy) for this.
- All the developers should be able to access all the environments to avoid silos.

## Recommendations for Environments and practices 

### Workloads

For recommendation about how to manage environments for Workloads refer to [Enterprise-scale FAQ](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture).

### Azure Landing Zones

The adoption of multiple environments for Azure Landing Zones deployments is common in scenarios where customers want to test the impact and results of new Azure Policy Assignments, Azure RBAC role assignments, Azure AD group memberships, Azure resources' creation, etc. Two different approaches are described in [Testing approach for enterprise-scale](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach):
- Replication of management group hierarchy in Canary and Production environment 
- Sandbox subscriptions 

Independently from the selected scenario, its recommended to:
- adopt at least one environment for performing tests on
- protect your environments, using separated Service Principal for test and production purposes
- implement automated checks and approvals to validate and approve changes by a designated user(s) prior to deploying a change to a particular environment

## Next steps
- [Create and Target Environments in Azure DevOps](/azure/devops/pipelines/process/environments)

- [Using environments for deployment in GitHub](https://docs.github.com/en/github-ae@latest/actions/deployment/targeting-different-environments/using-environments-for-deployment)
