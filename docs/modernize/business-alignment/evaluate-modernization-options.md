---
title: Evaluate modernization options
description: Learn how to evaluate your technical and financial indicators to determine which workloads you want to modernize during cloud adoption.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal, seo-caf-modernize
keywords: evaluate, technical, financial indicators, workloads, modernize, cloud adoption framework
---
<!--Primary Deliverable: CAF/Modernize/Evaluate-Modernization-Options.md​-->
# Evaluate modernization options

We previously discussed [modernization motivations](envision-cloud-modernization.md) and mapping different workload categories to those motivations. To establish realistic expectations for modernizing your workloads during cloud adoption, evaluate the resources and dependencies of your current state. Based on your evaluations, we provide an appropriate path toward modernization.

## 1. Identify your motivations

Some top motivators for modernization include generating new income (operating income and margin), getting more usage of new technology, and creating market differentiators. See the following motivations for modernization in your operating margin, infrastructure, applications, and data.

- **Operating margin:** Automate ongoing administrative work, like patching, networking, and firewall configuration with the SaaS or PaaS services. With today's technology and market differentiators and to justify any kind of modernization effort, you want to see some operating income rather than just operating margin.
- **Infrastructure:** Focus on making innovative services and applications available to the company and spend less time managing core infrastructure like server patching, networking setup, firewall configuration, and many other server-related tasks now included with Azure PaaS.
- **Applications:** Get your websites up and running within minutes. You can improved app delivery time by 50% and there's no waiting for servers.
- **Data:** Advance your data analysis in the cloud. You can get away from managing core infrastructure and instead focus on making innovative services available to the company. By using sophisticated data analysis, you can make a personal connection with your customers that stands out in the vast sea of information that washes over us daily.

## 2. Evaluate existing resources

Explore the following questions with your organization to discover the **technical indicators** and resulting paths toward a modernization effort.

- **Can you modernize the workload?** What if you have a workload with commercial off-the-shelf solutions (COTS), where you buy a product and run it on servers that can't be modernized, unless the vendor who sold you that product has already done that modernization? These indicators are easy to weed out.
- **Is the business actively investing in maturing these workloads?** Are you investing in workloads that don't create a competitive advantage? Are your workloads built with the support of a consulting firm that's no longer making changes and is running through its life cycle? If your business isn't actively investing in it, should you put in more investment?
- **Will these modernized workloads need to operate in hybrid or multi-cloud environment?** What percentage of your internal and external apps are currently on-premises? Do you want to manage, govern, and secure apps seamlessly across on-premises infrastructure with public, private, and hybrid cloud capabilities?
- **Are your workloads hybrid and portable? Is your workforce hybrid?** If:
  - **Hybrid workers:** We recommend [Migration only](../../get-started/migrate.md)
  - **Hybrid or portable workloads:** We recommend [Modernizing your application platforms](../modernize-disciplines/application-platform-modernization.md)

## 3. Evaluate financial indicators

Explore the following questions with your organization, to discover and weigh the **financial indicators** and resulting path toward a modernization effort.

- **Can you quantify the business value of modernizing these workloads?** Consider whether the business values will lead to revenue and whether you've forecasted that revenue. If the values lead to cost savings, have you forecasted that cost savings? For instance, if you save a little bit of administrative time, unfortunately, you can only often times realize that revenue savings if you let go of some of your people. So that's a little bit of a soft cost that's hard to quantify.
- **Have you compared the hosting costs of these workloads in a migrated versus modernized approach?** Often, people don't think about hosting costs and some modernization efforts can actually increase your cost.
- **Are these workloads considered business-critical?** If outages of a workload truly are critical and downtime costs you money in the $1,000,000 per hour, the cost of runtime doesn't matter as much. If it's truly business-critical, then it's probably a good candidate for modernization.
- **Doest the cost of modernization exceed your desired cost savings? Do you know what your break even point would be?** If:
  - **Yes:** We recommend [migration only](../../get-started/migrate.md)
  - **No:** We recommend [aligning your developers](../modernize-disciplines/developer-alignment-modernization.md)

## Complex evaluations

If you notice that your modernization efforts require some significant shifts in your data layer, application platform, and so on, it's a sign of a complex change, which needs further analysis. If you're unsure of what your financial break even point would be, or whether your workloads could be hybrid and portable, we can help. To assess your workloads using the tenets found in the Microsoft Azure Well-Architected Framework, do the [Microsoft Azure Well-Architected Review](/assessments/?mode=pre-assessment&session=local).

## Next steps

> [!div class="nextstepaction"]
> [Commit to a modernization plan](commit-to-modernization-plan.md)
