---
title: Modernize your apps and data
description: Learn how cloud adoption-related modernization can provide business value by unlocking new technical skills and expanded business capabilities.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal, seo-caf-modernize
keywords: cloud innovation, cloud adoption, cloud framework, cloud adoption framework
---
# Modernize your apps and data

When your cloud adoption journey includes modernization, you'll be repackaging, redesigning, and rebuilding your apps and data. Modernization helps you achieve benefits like boosting app innovation, increasing agility, and accelerating developer velocity.

The following exercises help establish the iterative processes to assess, migrate, optimize, secure, and manage those workloads.

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> :::image type="icon" source="../_images/icons/1.png"::: | [Align your modernization efforts to business needs.](business-alignment/index.md) |
| <br> :::image type="icon" source="../_images/icons/2.png"::: | [Build skills and adopt repeatable processes for modernizing waves of workloads.](modernize-disciplines/index.md) |
| <br> :::image type="icon" source="../_images/icons/3.png"::: | Consult the [Modernization Scenarios](modernize-scenarios/modernization-scenarios.md) to find examples of repeatable processes based on the technologies you're modernizing. |
| <br> :::image type="icon" source="../_images/icons/4.png"::: | Review [best practices](modernize-best-practices/improve-devops-practices.md) to find new ways to improve your processes and accelerate modernization. |

## Methodology overview

This methodology is designed to help you modernize a portfolio of applications at scale using repeatable processes. For modernization of individual workloads and deeper review of architectural decisions, consult W Architecture Framework (WAF).

:::image type="content" source="../_images/modernize/modernize-methodology-graphic.png" alt-text="Graphic showing business alignment and modernization disciplines.":::

To further understand the modernization methodology, begin with the following article series, based on your role:

- Decision makers: [Business alignment](business-alignment/index.md)
- Technical readers: [Modernization disciplines](modernize-disciplines/index.md)

## Repackage apps and databases for speed and productivity

When you want to make minimal changes and ensure they connect to Azure, repackage your apps and databases. For example, you might want to reposition relational databases directly into a cloud database service like Azure SQL Database.

## Redesign apps and databases for cloud scalability and productivity

Redesign apps and databases when you want to modify and extend app functionality and code to optimize for cloud scalability. For example, break down monolithic apps into groups of microservices that work together and scale.

## Rebuild with cloud-native technologies to accelerate developer velocity

Consider rebuilding if your existing apps have limited functionality or lifespan. Re-create your apps using Azure cloud solutions.

Modernization is a continuous process that involves significant organizational change management spanning people, process, and technology. Taking a holistic approach helps you navigate the journey successfully and helps ensure that your organization realizes new benefits—including efficiency, agility, and scale, after your workloads are running in the cloud.

## Modernization examples

Modify or extend your apps to further scale and optimize for cloud architectures. Take advantage of Azure platform and service capabilities such as built-in security, patching, high availability, and auto-scaling. Typical projects include the following examples:

- [Modernize on-premises .NET apps by using Azure App Service and Azure SQL Managed Instance](../migrate/azure-best-practices/contoso-migration-refactor-web-app-sql-managed-instance.md)
- [Modernize on-premises .NET apps by using Azure App Service and Azure SQL Database](../migrate/azure-best-practices/contoso-migration-refactor-web-app-sql.md)
- [Modernize Linux web apps by using Azure App Service and Azure Database for MySQL](../migrate/azure-best-practices/contoso-migration-refactor-linux-app-service-mysql.md).
- [Modernize on-premises .NET or Java apps by containerizing them with Azure Kubernetes Service (AKS)](/azure/migrate/tutorial-app-containerization-aspnet-kubernetes)
- [Modernize dev/test environments to Azure DevTest Labs](../migrate/azure-best-practices/contoso-migration-devtest-to-labs.md).

## Next steps

The previously outlined steps can help you modernize at any stage of your cloud adoption journey. Modernizing apps and databases helps you get the most out of Azure capabilities including built-in security, patching, high availability, and auto-scaling.
