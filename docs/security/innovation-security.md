---
title: Innovation Security
description: Explore the key themes of consideration for integrating security best practices into innovation areas
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Innovation Security

Cloud technologies enable organizations to envision new ideas and products that were not possible before. Put simply, cloud can enable innovation.
However, that innovation can often introduce new ways of working that test or break existing security or operational processes and controls.
As part of the journey to cloud environment organizations will need to consider and implement new ways of working to ensure secure is at the core of everything that is built.

This article explores how to integrate modern security practices (such as DevSecOps) into processes.
A key objective is to align security, development, and operational practices.

## Secure by design

As development teams adopt cloud technologies as part of their development environment, there is an opportunity to integrate tools and techniques to make security a default part of the development lifecycle.
Modern software development is orientated around code repositories and build pipelines, which created an effective method of collaboration between teams and enables high volume, repeatable build and release of code into various environments.

This streamlined process removes many manual steps from the development process, which can result in the reduced need for manual review and approval during the development cycle. This approach is a huge benefit, but can also introduce a risk of unintentional security issues if not approached correctly.
Building security checks into development cycles can reduce the risk of tokens or credentials being checked into a code repository or left in a software release. Scanning for vulnerabilities in third-party libraries can also help to reduce the risk of vulnerabilities in code and in environments.

Setting these techniques as default behavior within the development process - and, crucially automating it - helps organizations move closer to the principle of secure by design, as opposed to security being a waterfall activity after development finishes.

## What is DevSecOps?

In the same way that DevOps is the combination of people, process, and technology the same is true of DevSecOps - the difference being the expansion of the core teams to include the organization's security functions.

**Development, Security, Operations**. Three key functions within an organization working together in a common model to help build secure, resilient applications.
Developing applications requires many teams to work harmoniously in order to ensure that - from concept to live environment - the code and services that are developed have been regularly checked for vulnerabilities and issues addressed.

[The Cloud Adoption Framework's Organize methodology provides some further context on the team composition and key relationships for DevSecOps structures in an organization](../organize/cloud-security-application-security-devsecops.md)

The fundamental principles of DevSecOps are to bring teams closer together to design and operate applications to be inherently secure, with risks and vulnerabilities found, assessed and mitigated as quickly as possible.
People and process are the most important elements, but tools play a key role in enabling the environments to scale without processes breaking or requiring a cost prohibitive number of people.

## Security in repositories

Typically, developers create, manage, and share their code in repositories such as GitHub or Azure DevOps Repos. This approach provides a central, version controlled library of code that can be collaborate on easily.
However, enabling a number of collaborators on a single codebase can also introduce the risk of changes being introduced that lead to vulnerabilities or the unintentional inclusion of credentials or tokens in commits.

To address this risk, development teams should evaluate and implement a repository scanning capability. Repository scanning tools are intended to perform static code analysis on source code within repositories and look for vulnerabilities or credentials and flag items found for remediation.

This capability acts as a backstop to protect against human error and is a useful safeguard in distributed teams where a number of people are collaborating in the same repository.
The security validation of code can happen both within the Integrated Development Environment (IDE), such as Visual Studio Code, or at the point of creating a pull request to merge code into a branch or repository.

## Security in pipelines

Many organizations use build and release pipelines (often referred to as Continuos Integration and Continuous Delivery or CI/CD) to automate and standardize the processes for building and deploying code into various environments.

This use of pipelines allows development teams to make iterative changes to sections of code quickly and at scale, without the need to spend large amounts of time redeploying or upgrading existing environments.
Using pipelines also enables teams to promote code from development environments, through testing environments and ultimately into production.

As part of this automation, development teams should include security tools that run scripted automated tests when code is deployed into testing environments. This can include tests such as unit testing the applications features to check for vulnerabilities or checking for public endpoints to ensure they are intentionally accessible.

## Security in environments

Alongside scanning and securing the code for applications, its important to ensure that the environments that applications are deployed into are also secure.
This is particular key for organizations moving at pace or innovating and potentially using new technologies or creating environments quickly for experimentation.

Azure has capabilities that enable organization's to create security standards from environments - such as Azure Policy that can be used to create policy sets that prevent the creation of certain workload types or configuration items such as public IP addresses.
These 'guardrails' enable teams to experiment within a safe and controlled environment, therefore balancing innovation and governance.

**Penetration testing** is a recommended practice for environments in order to check for any vulnerabilities in the infrastructure or application configuration that may create weaknesses that attackers could exploit.
There are a number of products and partners that provide penetration testing services and [Microsoft provides guidance on how to provide notification of penetration activities.](../azure/security/fundamentals/pen-testing)

Testing typical covers the following test types:

- Tests on your endpoints to uncover vulnerabilities
- Fuzz testing (finding program errors by supplying malformed input data) of your endpoints
- Port scanning of your endpoints

**Infrastructure scanning**

Azure includes monitoring and security capabilities designed to detect and alert on anomalous events or configurations that require investigation and potential remediation.

Technologies such as Azure Defender, Aure Security Center, and Sentinel are first party tools that natively integrate into the Azure environments being deployed.

These tools compliment the environment and code security tools to provide a broad reaching set of security monitoring to enable organizations to experiment and innovate, at pace, securely.

## Actionable intelligence

Taken together, the above tools and techniques can significantly contribute towards a holistic security model for organization's wishing to move at pace and experiment with new technologies that aim to drive innovation.

A key element of DevSecOps is data-driven, event-driven processes that enable the three functions to operate effectively in identifying, evaluating and responding to potential risks.

Many organizations choose to integrate these alerts and telemetry into their IT Service Management (ITSM) platform in order to bring the same structured workflow to security events that they use for other incidents are requests.

## Feedback loops

![Continuous Security model](./media/continuous-security.png)

All of these techniques and tools enable teams to find and flag risks and vulnerabilities that require investigation and potential resolution.
Operations teams who receive an alert, or discover a potential issue when investigating a support ticket, need a route back to the development team in order to flag items for review.
This feedback loop being a smooth collaboration is vital to issues being addressed quickly and the risk of a vulnerability being minimized as much as possible.

A common pattern for this feedback is to integrate it into the organization's developer work management system - such as Azure DevOps or Github - to link alerts or incidents to work items for developers to plan and action. This process provides an effective way for developers to resolve issues within their standard workflow, including development, testing and, release.
