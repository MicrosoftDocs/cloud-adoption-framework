---
title: DevOps Toolchain
description: Guidance on decisions to consider when choosing a DevOps tooling stack
author: ElisaAnzelmo, ElenaBataneroGarcia
ms.author: elanzel, elbatane
ms.date: 04/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# DevOps toolchain
A DevOps toolchain is a collection of tools that enables DevOps teams to collaborate across the entire product lifecycle and tackles key DevOps fundamentals including continuous integration, continuous delivery, automation, and collaboration.
These tools operate as an integrated unit for planning, continuous integration, continuous delivery, operations, collaboration and feedback. Some examples of DevOps techonologies across different DevOps stages are available in [Define your DevOps technology ecosystem](../considerations/devops-principles-and-practices.md#define-your-devops-technology-ecosystem)

## DevOps toolchain considerations
- When selecting the toolchain DevOps processes and tools can be already in use across the organization. You should find the right balance between the adoption of technologies that are suitable for your team's needs and the goal to standardize and avoid heterougeneus DevOps ecosystems across the organization.

- Different kind of DevOps toolchain can be adopted:
    - all-in-one:
      it provides a complete solution that may not integrate with other third-party tools. This can be useful for companies or groups just beginning their DevOps journey, or if a team wants to start a project quickly. The downside of this type of toolchain is that most established teams already have a set of tools they use and prefer, which may not integrate with a complete solution.
    - customized:
      it's a toolchain that can be customized for a team’s needs with different tools. This allows teams to bring the existing tools they know and they have already in use into the wider DevOps toolchain. Integration is essential for these types of toolchains. 

- When adopting customized toolchain assure that the different tools integrate, to avoid team members spending unnecessary time switching between screens, logging in to multiple places, and having the challenge to share information between tools.

- Any tool you choose should support the programming languages, platform and framework you are currently using and leave room for you to adopt new features. A tool that is actively developed and supported is more likely to be updated with support for new trends.   **>>>> so for azure landing zone... terraform, bicep, json testing programs ecc ????**

- Rapid feedback loops are at the heart of the CI/CD process. A CI/CD tool uses that feedback to resolve conditions in the CI/CD workflow logic and displays the information back to users, usually on a dashboard. 
Support for email notifications and integrations with IDEs or communication platforms ensure you stay informed of what’s happening without having to check the dashboard. Ensure you have the flexibility to configure the alerts you receive, as getting too many alerts would transform them in background noise.

- A CI/CD workflow provides access to your source code and environment parameters, and potentially provides access to your production environment. Tools that provide audit trail allowing you to investigate anu unusual behavior should be adopted.

- CI/CD tools should speed up the time to market for your product. Tools that allow you to parallelize tasks and take advantage of elastic scalability on cloud-hosted infrastructure will enhance the performance of your CI/CD process.

- CI/CD workflows will evolve, accruing more tasks and handle more complexity. By monitoring statistics such as test coverage and failures, build duration and time spent in queues, you can identify areas of your procedure that may be slowing down the process and steps that could benefit from being redesigned.
Tools that give you access to a range of metrics and the option to generate reports or export them to other tools for analysis will make it easier.

- When choosing any software tool it’s important to consider the quality of the documentation and whether there’s a thriving developer community where you’ll be able to ask questions and exchange ideas.

- For many enterprises, a paid support option that ensures you can get assistance when you need it by email or online, is a requirement for any product or service that is on the critical path to market.

- When comparing the cost of a CI/CD platform, the license fee is only part of the equation. Ease of use and the level of support available will have a considerable impact on the time you spend setting up and maintaining your pipeline over the longer term. If you’re expecting to scale up in future, the ease of moving to cloud-hosted infrastructure is also worth bearing in mind.

## DevOps toolchain recommendation for Azure Landing Zones


| DevOps stage | Tools recommendations |
| - | - |
| Plan | - |
| Build | - |
| Continuous Integration | - |
| Deploy | - |
| Operate | - |
| Continuous Feedback | - |






