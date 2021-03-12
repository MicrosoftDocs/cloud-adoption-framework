---
title: Understand application security and DevSecOps functions
description: Understand application security and DevSecOps functions.
author: JanetCThomas
ms.author: janet
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: internal
---

# Application security and DevSecOps functions

The objective of application security and DevSecOps is to integrate security assurances into development processes and custom line of business (LOB) applications.

## Modernization

Application development is rapidly being reshaped in multiple aspects simultaneously including the DevOps team model, DevOps rapid release cadence, and the technical composition of applications via cloud services and APIs. See how the cloud is changing security relationships and responsibilities to understand these changes.

This modernization of antiquated development models presents both opportunity and a requirement to modernize security of applications and development processes. The fusion of security into DevOps processes is often referred to as DevSecOps and drives changes including:

<!-- TODO: Link needed below? -->

- **Security is integrated, not outside approval:** The rapid pace of change in application development makes classic arms-length "scan and report" approaches obsolete. These legacy approaches can't keep up with releases without grinding development to a halt and creating time-to-market delays, developer underutilization, and growth of issue backlog.
  - **Shift left** to engage security earlier in application development processes as fixing issues earlier is cheaper, faster, and more effective. If you wait until after the cake is baked, it is harder to change the shape.
  - **Native integration:** Security practices must be integrated seamlessly to avoid unhealthy friction in development workflows and continuous integration/continuous deployment (CI/CD) processes. For more information about the GitHub approach, see [Securing software, together](https://github.blog/2019-09-18-securing-software-together/).
  - **High-quality security:** Security must provide high-quality findings and guidance that enable developers to fix issues fast and don't waste developer time with false positives.
  - **Converged culture:** Security, development, and operations roles should contribute key elements into a shared culture, shared values, and shared goals and accountabilities.
- **Agile security:** Shift security from a "must be perfect to ship" approach to an agile approach that starts with minimum viable security for applications (and for the processes to develop them) that is continuously improved incrementally.
- **Embrace cloud-native** infrastructure and security features to streamline development processes while integrating security.
- **Supply chain risk management:** Take a zero-trust approach to open-source software (OSS) and third-party components that validate their integrity and ensure that bug fixes and updates are applied to these components.
- **Continuous learning:** The rapid release pace of developer services, sometimes called platform as a service (PaaS) services, and changing composition of applications means that dev, ops, and security team members will be constantly learning new technology.
- **Programmatic approach** to application security to ensure continuous improvement of the agile approach happens.

For additional context, see [Microsoft secure development lifecycle](https://www.microsoft.com/sdl).

## Team composition and key relationships

Application security and DevSecOps functions are ideally performed by security aware developers and operations teams (with the support of security subject matter experts).

This function commonly interacts with other functions and experts including:

- Security architecture and operations
- Infrastructure security
- Communications (training and tooling)
- People security
- Identity and keys
- Compliance/risk management teams
- Key business leaders or their representatives

## Next steps

Review the function of [data security](./cloud-security-data-security.md).
