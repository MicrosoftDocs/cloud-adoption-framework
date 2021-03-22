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

This article explores how to integrate security into DevSecOps processes in order to align security, development, and operational practices.

## Secure by design

As development teams adopt cloud technologies as part of their development environment there is an opportunity to integrate tools and techniques to make security a default part of the development lifecycle.
Modern software development is typically orientated around code repositories and build pipelines, which created an effective method of collaboration between teams and enables high volume, repeatable build and release of code into a variety of environments.

This simple and easy process removes a number of manual steps from the development process which can result in the reduced need for manual review and approval during the development cycle. This is a huge benefit, but can also introduce a risk of unintentional security issues if not approached correctly.
By building security checks into development cycles can reduce the risk of tokens or credentials being checked into a code repository or left in a software release. Scanning for vulnerabilities in third-party libraries can also help to reduce the risk of vulnerabilities in code and in environments.

Setting these techniques as default behavior within the development process - and, crucially automating it - helps organizations move closer to the principle of secure by design, as opposed to security being a waterfall activity after development finishes.

## What is DevSecOps




