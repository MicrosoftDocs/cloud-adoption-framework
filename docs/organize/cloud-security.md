---
title: Cloud security functions
description: Learn how organizational functions play an important role in managing information security risk in an enterprise.
author: MarkSimos
ms.author: mas
ms.date: 08/02/2022
ms.topic: conceptual
ms.custom: think-tank, UpdateFrequency3
---

# Cloud security functions

Functions are tasks and responsibilities that are key to an organization. In other words, functions are "jobs to be done."

This article provides a summary of organizational functions required to manage information security risk in an enterprise. These roles and responsibilities form the human portion of an overall cybersecurity system.

## Security is a team sport

Individuals on the security team need to work together and see each other as integral parts of the whole organization. They're also part of a larger security community defending against the same adversaries.

This holistic worldview helps the team work through any unplanned gaps and overlaps discovered during the evolution of roles and responsibilities.

## Types of security functions

The following diagram depicts specific organizational functions within security. The functions depicted represent an ideal view of a complete enterprise security team. Security teams with limited resources might not have formal responsibilities defined around all of these functions. Each function could be performed by one or more people, and each person could perform one or more functions depending on factors such as culture, budget, and available resources.

:::image type="content" source="../secure/media/security-responsibilities.png" alt-text="Diagram of the functions of an enterprise security team." lightbox="../secure/media/security-responsibilities-popout.png":::

You can learn more about each function from the following articles. They include a summary of objectives, how the function can evolve, and the relationships and dependencies that are critical to its success.

- [Policy and standards](./cloud-security-policy-standards.md)
- [Security operations](./cloud-security-operations-center.md)
- [Security architecture](./cloud-security-architecture.md)
- [Security compliance management](./cloud-security-compliance-management.md)
- [People security](./cloud-security-people.md)
- [Application security and DevSecOps](./cloud-security-application-security-devsecops.md)
- [Data security](./cloud-security-data-security.md)
- [Infrastructure and endpoint security](./cloud-security-infrastructure-endpoint.md)
- [Identity and key management](./cloud-security-identity-keys.md)
- [Threat intelligence](./cloud-security-threat-intelligence.md)
- [Posture management](./cloud-security-posture-management.md)
- [Incident preparation](./cloud-security-incident-preparation.md)

## Roles and responsibilities

Security roles and responsibilities are referenced throughout Microsoft documentation, including the [Azure Security Benchmark](/security/benchmark/azure/), [rapid modernization plan to secure privileged access](/security/compass/security-rapid-modernization-plan), and [Azure security best practices](../secure/security-top-10.md).

The following diagram depicts how these functions map to role types within an organization:

:::image type="content" source="../secure/media/roles-and-responsibilities.png" alt-text="Diagram of security roles and responsibilities." lightbox="../secure/media/roles-and-responsibilities.png":::

### Mapping security to business outcomes

At the organizational level, security disciplines are mapped to standard plan-build-run phases seen widely across industries and organizations. Security is both a discipline with its own unique functions *and* a critical element to integrate into normal business operations.

## Role types

In the diagram, responsibilities are organized into typical roles that have common skill sets and career profiles. These groupings also help provide clarity on how industry trends affect security professionals:

- **Security leadership:** These roles frequently span functions, ensuring that teams coordinate with each other. They also provide prioritization and set cultural norms, policies, and standards for security.
- **Security architect:** These roles span functions and provide a key governance capability to ensure all of the technical functions work harmoniously within a consistent architecture.
- **Security posture and compliance:** A newer role type that represents the convergence of compliance reporting with traditional security disciplines like vulnerability management and configuration baselines. While the scope and audience are different for security and compliance reporting, they both measure the security of the organization. The way that question is answered is growing more similar via tools like [Microsoft Secure Score](https://www.microsoft.com/security/business/microsoft-secure-score) and [Microsoft Defender for Cloud](https://azure.microsoft.com/services/defender-for-cloud):
  - The use of on-demand data feeds from cloud services reduces the time required to report compliance.
  - The increased scope of data available is enabling security governance to look beyond traditional software updates and discover vulnerabilities from security configurations and operational practices.
- **Platform security engineer:** These technology roles focus on platforms that host multiple workloads&mdash;both access control and asset protection. These roles are often grouped into teams with specialized technical skill sets including network security, infrastructure and endpoints, identity and key management, and others. These teams work on both preventive controls and detective controls, with detective controls being a partnership with SecOps and preventive controls being primarily a partnership with IT operations. For more information, see [Security integration](../secure/security-integration.md).
- **Application security engineer:** These technology roles focus on security controls for specific workloads, supporting both classic development models and modern DevOps/DevSecOps model. They blend application/development security skills for unique code and infrastructure skills for common technical components like VMs, databases, and containers. These roles can be located in central IT or security organizations or within business and development teams, depending on organizational factors.

> [!NOTE]
> As DevOps and infrastructure-as-code trends progress, some security talent will likely migrate from platform security engineering teams to application security teams and posture management roles. The DevOps model requires infrastructure security skills, such as securing the *ops* in DevOps. Governance teams will also require these skills and experience to effectively monitor technical security posture in real time. Additionally, infrastructure-as-code will automate repetitive manual technical tasks, reducing the time required for these skills in the platform security engineer roles (though increasing the need for broad technical skill sets and automation or scripting skills).

## Next steps

Learn more about [security in the Microsoft Cloud Adoption Framework](../secure/index.md).
