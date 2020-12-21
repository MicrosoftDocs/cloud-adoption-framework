---
title: How GitHub Accelerates Cloud Adoption
description: Use the Cloud Adoption Framework best practices to migrate or deploy Windows Virtual Desktop instances to Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/21/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# How GitHub Accelerates Cloud Adoption

## Overview

Innovation is the new currency in today’s competitive landscape. We've experienced fundamental changes to the way we live our lives with things like ridesharing, streaming content services, self-driving cars, etc. Entire markets have been turned upside down as the competitive landscape has moved from physical assets to digital experiences.

It's these superior digital experiences that are driving this disruption and, more and more, well-established businesses are facing stiff competition from companies that are able to innovate and deliver value to their customers faster.

In order to compete, businesses need to build a culture of innovation and utilize the best tools and cloud services or they risk disruption themselves.

GitHub provides a unique ability to facilitate the cultural shift that needs to occur in order to take full advantage of capabilities and services within Azure to help companies and teams modernize their practices to be more agile and innovative.

By taking advantage of GitHub’s connectedness to the Open Source Community, companies can find thousands of examples of ready-to-deploy cloud solutions that have been iterated on, enhanced and made available by other companies and organizations that have successfully adopted Azure services. They can easily borrow from and iterate on these solutions to tailor them to their business needs. GitHub makes it easy to share with other teams throughout the organization within GitHub which, in turn, makes it faster to modernize and deploy the next application or workload. Borrowing the best practices like sharing and reuse, collaboration and communication, etc. from the Open Source Community and applying it to your own organization is what is called Inner Sourcing and is a fundamental tenet of innovation.

Securing the entire software supply chain--from the Open Source packages to the intellectual property that is written daily--should also be of utmost importance to every company. This requires advanced security technology that is incorporated and automated throughout the entire lifecycle. GitHub provides native capabilities, namely GitHub Advanced Security and GitHub Actions, to do just that.

![Architecture diagram highlighting the security checks that run in various GitHub and Azure components in a GitHub DevSecOps environment.](./media/image1.png)

Architecture diagram highlighting the security checks that run in various GitHub and Azure components in a GitHub DevSecOps environment. Source: [DecSecOps in GitHub](/azure/architecture/solution-ideas/articles/devsecops-in-github)

## Leverage Open Source Assets

Highly effective organizations recognize Open Source Software (OSS) as essential, not optional, for modern software development. They engage with the developer communities they depend on and strategically invest in open source with the help of a secure platform. As a result, these organizations experience rapid innovation, outpace competitors, and cut down costs—all while minimizing risk.

While you might typically think of OSS as the packages, libraries, scripts, dependencies, etc. that are incorporated into your applications, there are thousands of Open Source assets in the form of Infrastructure as Code, documentation and guidance that can help by providing a blueprint for well-defined Azure architectures that can easily be modified, reused and deployed to your own Azure environment. These blueprints have been contributed to the OSS community by Microsoft, partners, vendors, customers and individuals and are readily available to consume in GitHub.

### Infrastructure as Code

Infrastructure as Code (IaC) is the management of infrastructure (networks, virtual machines, load balancers, and connection topology) in a descriptive model, using the same versioning system the DevOps team uses for source code. Like the principle that the same source code generates the same binary, an IaC model generates the same environment every time it is applied. IaC is a key DevOps practice and is used in conjunction with [continuous delivery](/azure/devops/learn/what-is-continuous-delivery).

Infrastructure as Code evolved to solve the problem of *environment drift* in the release pipeline. Without IaC, teams must maintain the settings of individual deployment environments. Over time, each environment becomes a *snowflake*, that is, a unique configuration that cannot be reproduced automatically. Inconsistency among environments leads to issues during deployments. With snowflakes, administration and maintenance of infrastructure involves manual processes which were hard to track and contributed to errors. Infrastructure deployments with IaC are repeatable and prevent runtime issues caused by configuration drift or missing dependencies.

With IaC, teams make changes to the environment description and version the configuration model, which is typically in well-documented code formats such as JSON ( See [ARM Templates](/azure/azure-resource-manager/templates/overview) ). Developers can simplify their workflows by hosting IaC code in the same GitHub repo as their application source code and adopt the same CI/CD practices for IaC powered by [GitHub Actions](https://github.com/features/actions). See the [AzOps](https://github.com/Azure/azops) GitHub Action as an example of how one can deploy their own ARM templates at various Azure scopes. If you’re new to the concept of ARM templates or IaC, you can also browse the [Azure Quickstart Templates repo](https://github.com/Azure/azure-quickstart-templates) on GitHub, find a template you wish to deploy and simply click the ![Deploy to Azure](./media/image2.png)button to see how it works.

### Cloud Patterns and Best Practices

[DevSecOps in GitHub - Azure Solution Ideas | Microsoft Docs](/azure/architecture/solution-ideas/articles/devsecops-in-github)

#### Components

- [GitHub](https://docs.github.com/en/github) provides a code-hosting platform that developers can use for collaborating on both open-source and inner-source projects.
- [Codespaces](https://docs.github.com/en/github/developing-online-with-codespaces/about-codespaces) is an online development environment. Hosted by GitHub and powered by Visual Studio Code, this tool provides a complete development solution in the cloud.
- [GitHub Security](https://github.com/features/security) works to eliminate threats in a number of ways. Agents and services identify vulnerabilities in repositories and in dependent packages. They also upgrade dependencies to up-to-date, secure versions.
- [GitHub Actions](https://docs.github.com/en/actions/getting-started-with-github-actions/about-github-actions) are custom workflows that provide continuous integration (CI) and continuous deployment (CD) capabilities directly in repositories. Computers called runners host these CI/CD jobs.
- [Azure AD](/azure/active-directory/fundamentals/active-directory-whatis) is a multi-tenant, cloud-based identity service that controls access to Azure and other cloud apps like Microsoft 365 and GitHub.
- [App Service](https://azure.microsoft.com/services/app-service/) provides a framework for building, deploying, and scaling web apps. This platform offers built-in infrastructure maintenance, security patching, and scaling.
- [Azure Policy](/azure/governance/policy/overview) helps teams manage and prevent IT issues through policy definitions that can enforce rules for cloud resources. For instance, if your project is about to deploy a virtual machine with an unrecognized SKU, Azure Policy alerts you to the problem and stops the deployment.
- [Azure Security Center](/azure/security-center/security-center-intro) provides unified security management and advanced threat protection across hybrid cloud workloads.
- [Azure Monitor](/azure/azure-monitor/overview) collects and analyzes app telemetry, such as performance metrics and activity logs. When this service identifies irregular conditions, it alerts apps and personnel.

## Inner Sourcing

### What is Inner Sourcing?

Many companies use the word “innersource” to describe how their engineering teams work together on code. Innersource is a development methodology where engineers build proprietary software using best practices from large-scale open source projects, like Kubernetes or Microsoft’s Visual Studio Code.

Large-scale open source projects require coordination and teamwork across thousands of contributors. The most successful ones are driven by a vision for their future, in addition to day-to-day user needs: speed, reliability, and functionality. The scale at which these operate can teach us a few lessons—and help your business build better software, faster using innersource.

With GitHub’s pull requests and issues, collaboration and code review are built into the development process. Internal and outsourced teams can share work, discuss changes, and get feedback all in one place. This helps organizations share expertise internally and avoid reinventing field-tested solutions developed for other projects.

### The Anatomy of an Innersource Project

The right mix of individuals, teams, and resources can ensure a project’s success. Many open source projects follow a similar organizational structure—one you may want to consider when setting up cross-functional teams to manage your company’s innersource projects. A typical open source project has the following types of people:

- **Maintainers**: Contributors who are responsible for driving the vision and managing the organizational aspects of the project. They are not necessarily the original owners or authors of the code.
- **Contributors**: Everyone who has contributed something back to the project.
- **Community members**: People who use the project. They might be active in conversations or express their opinion on the project’s direction.

Bigger projects may also have subcommittees or working groups focused on different tasks, such as tooling, triage, and community moderation.

Innersource projects are likely to follow a similar structure. Many engineering organizations sort developers into teams like application engineering, platform engineering, and web development. Structuring organizations in this way can leave blind spots that exclude qualified people. Organizing a core decision-making group supported by teams across your organization can help rally the expertise necessary to solve a given problem faster.

Within an enterprise, “contributors” are developers across your company, while “maintainers” are a project’s leaders and key decision makers.

- **Maintainers**: Developers, product managers, and other key decision makers within your company who are responsible for driving a project’s vision and for managing day-to-day contributions.
- **Contributors**: Developers, data scientists, product managers, marketers, and other roles within your company that help drive software forward. Contributors are not necessarily part of the direct project team but help build software by contributing code, submitting bug fixes, and more.

Read the [Introduction to Innersource white paper](https://resources.github.com/whitepapers/introduction-to-innersource/) to learn more.

## Automation

GitHub Actions enables you to create custom workflows directly in your GitHub repository. You can discover, create, and share actions to perform any job you’d like, including CI/CD, and combine actions in a completely customized workflow. You can create continuous integration (CI) workflows that build, and test projects written in different programming languages. Here are several examples:

- [GitHub Actions for JavaScript and TypeScript](https://help.github.com/en/actions/language-and-framework-guides/github-actions-for-javascript-and-typescript)
- [GitHub Actions for Python](https://help.github.com/en/actions/language-and-framework-guides/github-actions-for-python)
- [GitHub Actions for Java](https://help.github.com/en/actions/language-and-framework-guides/github-actions-for-java)
- [GitHub Actions for Docker](https://help.github.com/en/actions/language-and-framework-guides/github-actions-for-docker)

GitHub Actions can be used to combine Infrastructure as Code concepts as well as CI/CD practices to automate the entire end-to-end deployment lifecycle including provisioning or updating the target environment in a repeatable manner to packaging and deploying the application itself.

### Example

[GitHub Actions for Azure](https://github.com/Azure/actions) are specifically built to make it easy to automate your deployment processes to target Azure services such as Azure App Service, Azure Kubernetes Service, Azure Functions and more. The [Azure starter action workflows repository](https://github.com/Azure/actions-workflow-samples) includes end-to-end workflows to build and deploy Web apps of any language, any ecosystem to Azure and you can visit the [GitHub Marketplace](https://github.com/marketplace?query=Azure&type=actions) to see all of the Actions that are available.

## Security

### GitHub’s “Shift-Left” Security Features

Starting with the first steps of development, DevSecOps adheres to security best practices. By using a shift-left strategy, DevSecOps redirects the security focus. Instead of pointing toward auditing at the end, it shifts to development in the beginning. Besides producing robust code, this fail fast approach helps to resolve problems early on, when they're easy to fix.

With many security capabilities, GitHub offers tools that support every part of a DevSecOps workflow:

- Browser-based IDEs with built-in security extensions.
- Agents that continuously monitor security advisories and replace vulnerable and out-of-date dependencies.
- Search capabilities that scan source code for vulnerabilities.
- Action-based workflows that automate every step of development, testing, and deployment.
- Spaces that provide a way to privately discuss and resolve security threats and then publish the information.
- Combined with the monitoring and evaluation power of Azure, these features provide a superb service for building secure cloud solutions.

### Example

GitHub DevSecOps installations cover many security scenarios. Possibilities include the following cases:

- Developers who want to take advantage of pre-configured environments that offer security capabilities.
- Administrators who rely on having up-to-date, prioritized security reports at their fingertips, along with details on affected code and suggested fixes.
- Streamlined organizations that need systems to automatically acquire new, uncompromised security devices when secrets are left exposed in code.
- Development teams that could benefit from automatic upgrades when newer or more secure versions of external packages become available.

[DevSecOps in GitHub - Azure Solution Ideas | Microsoft Docs](/azure/architecture/solution-ideas/articles/devsecops-in-github)

[Code Scanning a GitHub Repository using GitHub Advanced Security within an Azure DevOps Pipeline](https://github.blog/2020-10-27-code-scanning-a-github-repository-using-github-advanced-security-within-an-azure-devops-pipeline/)

[Applying DevSecOps to your software supply chain](https://github.blog/2020-12-03-applying-devsecops-to-your-software-supply-chain/)

## Next Steps

- Choose your implementation team (typically a developer manager and a few developers defined as admins) and deploy GitHub.
- Learn common and advanced workflows in Git to enhance your experience using GitHub.

Note: Links below will redirect you to GitHub Docs.

- [GitHub @ Microsoft Learning](/learn/browse/?products=github)
- [GitHub Learning Lab](https://lab.github.com/)
- [GitHub Docs](https://docs.github.com/en)
- [Tips for getting started with GitHub DevSecOps](https://resources.github.com/whitepapers/Architects-guide-to-DevOps/)
