---
title: Deployment Acceleration through consistency and repeatability
description: Consistent and repeatable deployment processes, such as fully automated DevOps pipelines, are keys to deployment acceleration.
author: robbagby
ms.author: robbag
ms.date: 10/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Consistency and repeatability in deployment

A key to accelerating deployments is the automation of all deployment processes. Manual processes introduce risk into the system and should be avoided. Manual processes are time consuming, are prone to failure and add to the following risks:

- Deployment failures: Failed deployments lead to the inability to release hot fixes or new features.
- Broken releases: Manual deployment processes can lead to down time of production applications, which includes the deployment of configuration changes.
- Time to deployment: Risky and brittle manual deployment processes generally lead teams to limit the number of deployments.

Automated deployment processes limit the above risks. Automated processes shouldn't be limited to application updates, but should include:

- Infrastructure updates
- Configuration updates
- Updates to libraries
- Updates to secrets, keys, and certificates

Automated deployments should include the appropriate release processes to minimize risk. These processes should include automated testing of deployments, and gradual rollout through processes such as A/B or canary testing.

## Guidance

Develop fully automated pull request (PR) and continuous integration and continuous deployment (CI/CD) pipelines to manage adding, deploying and releasing changes to your application through development, staging, and production environments.

- Store all deployment artifacts, including deployment templates and scripts in source control.
- Introduce PR and CI/CD pipelines as a first step for new projects.
- Ensure PR pipelines include unit testing, while CI/CD pipelines implement integration, acceptance and performance testing.
- Utilize A/B or Canary testing to incrementally release changes.
- Read and understand the design considerations and consider the design recommendations in [Deployment and testing for mission-critical workloads on Azure](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing)

Implement zero-trust access control at the control plane level. Limit the ability to deploy to principals that run automated processes. Zero-trust access control will prevent users from deploying changes manually. Limit the use of secrets, where possible. Use automation to rotate keys.

- Read and understand the design considerations and consider the design recommendations in [Azure identity and access for landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones)
- If the Azure built-in roles don't meet your needs, consider the [suggested role definitions](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones#rbac-recommendations) listed in Azure identity and access for landing zones.
- Use Azure AD managed identities for Azure resources to avoid credential-based authentication. When secrets, keys or certificates are required, store them in Azure Key Vault.
- Apply fully automated key-rotation processes that run periodically within each required solution.
- Use Azure AD Privileged Identity Management (PIM) to establish zero-trust and least privilege access.

## Enforce

Azure Role Based Access Control (RBAC) should be configured so users don't have access to deploy or make changes to environments such as staging and production.

## Audit

- [Audit Azure RBAC changes](/azure/role-based-access-control/change-history-report)
- [View activity and audit history for Azure resource roles in Privileged Identity Management](/azure/active-directory/privileged-identity-management/azure-pim-resource-rbac)
- [Audit Azure subscription RBAC assignments](https://github.com/azureautomation/audit-azure-subscription-rbac-assignments)
