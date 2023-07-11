---
title: Development security strategy
description: Learn about securing code by integrating security practices into the development process, which reduces security risks in code design and implementation.
author: mpvenables
ms.author: mas
ms.date: 06/17/2022
ms.topic: conceptual
ms.subservice: secure
ms.custom: internal
---

# Development security strategy

Development security is a broad technical area with multiple distinct elements. Best practices reflect that fact.

Development security requires protecting the application or code itself, and the underlying infrastructure, platform, or device.

:::image type="content" source="media/development-lifecycle-attacker-opportunities.png" border="false" alt-text="Diagram shows attacker opportunities, including IT infrastructure attacks." lightbox="media/development-lifecycle-attacker-opportunities.png":::

## Integrated security practices

Securing the code requires integrated security practices in the development process. This approach reduces security risks in both the design and the implementation of the code being developed.

Development can take many forms, including:

- Application code to run on a server as an application or API.
- Publishing an API.
- Scripting.
- Automation, such as these examples:
  - **Infrastructure deployment**, for instance, automating a Terraform deployment.
  - **Infrastructure configuration**, such as using an Azure Resource Manager template or Bicep to deploy an Azure Network Security Group and create security group rules.
  - **Operational tasks**, like using Azure Functions to run scheduled tasks by running code on predefined timed intervals.
- Code to be deployed to firmware.
- Mobile apps, an aggregation of application-level code with platform services, deployed as a system.
- Full systems, which include comprised of infrastructure components, operating systems, PaaS services, and code, which are assembled into an executable blueprint deployed to Azure as Infrastructure as Code (IaC).

In addition to the breadth of what can be considered development, advances in processes and technologies have enabled accelerated time to production, including faster Continuous Integration/Continuous Development (CI/CD) pipelines, [DevOps](/devops/what-is-devops), and [DevSecOps](/devops/operate/security-in-devops).

These advances require organizations to step back and evaluate. They need to determine which processes and technologies provide the development agility and speed to meet business demands in a secure and compliant way.

From the start, a good development strategy needs to account for your business and security needs and your organization's developer ecosystem. The goal is to have security *built in* to development processes. The security team should be more of an enabler than a blocker or hindrance to reach production.

Another part of a successful development security strategy is to meet the developers *where they are* and try to make any changes to their work as small and frictionless as possible. Small steps and automation are best. Show the development staff how having security incorporated into development processes can accelerate and remove friction from their efforts.

## Next steps

> [!div class="nextstepaction"]
> [Development innovation security](development-innovation-security.md)
