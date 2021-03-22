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
As part of the journey to cloud environment - and the realization of the benefits - organizations will need to consider and implement new ways of working to ensure secure is at the core of everything that is built.

This article explores how to integrate modern security practices (such as DevSecOps) into processes in order to align security, development, and operational practices.

## Secure by design

As development teams adopt cloud technologies as part of their development environment there is an opportunity to integrate tools and techniques to make security a default part of the development lifecycle.
Modern software development is typically orientated around code repositories and build pipelines, which created an effective method of collaboration between teams and enables high volume, repeatable build and release of code into a variety of environments.

This streamlined process removes a number of manual steps from the development process which can result in the reduced need for manual review and approval during the development cycle. This is a huge benefit, but can also introduce a risk of unintentional security issues if not approached correctly.
By building security checks into development cycles can reduce the risk of tokens or credentials being checked into a code repository or left in a software release. Scanning for vulnerabilities in third-party libraries can also help to reduce the risk of vulnerabilities in code and in environments.

Setting these techniques as default behavior within the development process - and, crucially automating it - helps organizations move closer to the principle of secure by design, as opposed to security being a waterfall activity after development finishes.

## What is DevSecOps?

In the same way that DevOps is the combination of people, process and technology the same is true of DevSecOps - the difference being the expansion of the core teams to include the organization's security functions.

Development, Security, Operations. Three key functions within an organization working together in a common model to help build secure, resilient applications.
Developing applications requires a number of teams to work harmoniously in order to ensure that - from concept to live environment - the code and services that are developed have been regularly checked for vulnerabilities and issues addressed.

## Security in repositories

Typically, developers create, manage and share their code in repositories such as GitHub or Azure DevOps Repos. This provides a central, version controlled library of code that can be collaborate on easily.


## Security in pipelines

Many organizations use build and release pipelines (often referred to as Continuos Integration and Continuous Delivery or CI/CD) to automate and standardize the processes for building and deploying code into various environments.
This use of pipelines allows development teams to make iterative changes to sections of code quickly and at scale, without the need to spend large amounts of time re-deploying or upgrading existing environments.
Using pipelines also enables teams to promote code from development environments, through testing environments and ultimately into production.

## Security in environments

## Actionable intelligence

## Feedback loops