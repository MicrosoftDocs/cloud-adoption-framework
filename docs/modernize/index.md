---
title: Modernize your apps and data
description: TODO
author: BrianBlanchard
ms.author: brblanch
ms.date: 3/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
---
<!--Acrolinx:93, TODO: meta description, add image-->
# Modernize your apps and data

When your cloud adoption journey includes modernization you'll be refactoring, rearchitecting, or rebuilding your apps and data. Modernization will help you achieve benefits like boosting app innovation, increasing agility, and accelerating developer velocity.

## Refactor apps and databases for speed and productivity

Refactor or repackage apps when you want to make minimal changes and ensure they connect easily to Azure. For example, you might want to refactor relational databases directly into a cloud database service like Azure SQL Database.

## Rearchitect apps and databases for cloud scalability and productivity

Rearchitect apps and databases when you want to modify and extend app functionality and code to optimize for cloud scalability. For example, break down monolithic apps into groups of microservices that work together and scale easily.

## Rebuild with cloud-native technologies to accelerate developer velocity

Rebuild when you need to re-create an app using Azure cloud solutions. Consider rebuilding if your existing apps have limited functionality or lifespan.

Modernization is a continuous process that involves significant organizational change management spanning people, process, and technology. Taking a holistic approach helps you navigate the journey successfully and helps ensure that your organization realizes new benefits—including efficiency, agility, and scale, after your workloads are running in the cloud.

IMAGE PLACEHOLDER

The following exercises will help establish the iterative processes to assess, migrate, optimize, secure, and manage those workloads.

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> :::image type="icon" source="../_images/icons/1.png"::: | <br> Start with a solid plan. [Define and document your motivations](../strategy/motivations.md) for modernizing, create a [business case](../strategy/cloud-migration-business-case.md), align stakeholders, and [build a plan](../plan/plan-intro.md) that breaks out modernization projects. |
| <br> :::image type="icon" source="../_images/icons/2.png"::: | <br> [Review the five Rs of rationalization](../digital-estate/5-rs-of-rationalization.md): You can modernize at any time—before, during, or after migrating your workloads. Iteratively migrate and modernize in waves to refactor, rearchitect, or rebuild your apps and data. |
| <br> :::image type="icon" source="../_images/icons/3.png"::: | <br> [Modernization examples](modernize-overview.md): Use example scenarios to identify common tools and approaches to modernization. |
| <br> :::image type="icon" source="../_images/icons/4.png"::: | <br> [Govern, secure, and manage cloud environments](modernize-overview.md): Is this the right fourth step?  What can we link to here? |

## Modernization examples

Modify or extend your apps to further scale and optimize for cloud architectures. Take advantage of Azure platform and service capabilities such as built-in security, patching, high availability, and auto-scaling. Typical projects include:

- [Modernize on-premises .NET apps by using Azure App Service and Azure SQL Managed Instance](../migrate/azure-best-practices/contoso-migration-refactor-web-app-sql-managed-instance.md)
- [Modernize on-premises .NET apps by using Azure App Service and Azure SQL Database](../migrate/azure-best-practices/contoso-migration-refactor-web-app-sql.md)
- [Modernize Linux web apps by using Azure App Service and Azure Database for MySQL](../migrate/azure-best-practices/contoso-migration-refactor-linux-app-service-mysql.md).
- [Modernize on-premises .NET or Java apps by containerizing them with Azure Kubernetes Service (AKS)](/azure/migrate/tutorial-app-containerization-aspnet-kubernetes)
- [Modernize dev/test environments to Azure DevTest Labs](../migrate/azure-best-practices/contoso-migration-devtest-to-labs.md).

## Next steps

The previously outlined steps can help you modernize at any stage of your cloud adoption journey. Modernizing apps and databases helps you get the most out of Azure capabilities including built-in security, patching, high availability, and auto-scaling. The modernization examples provide examples of common tools and approaches to modernization.

> [!div class="nextstepaction"]
> [Modernization examples](index.md)
