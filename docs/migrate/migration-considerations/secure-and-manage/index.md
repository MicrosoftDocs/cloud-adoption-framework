---
title: "Secure, monitor, and manage assets"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Secure monitoring and management tools
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Secure monitoring and management tools

After a migration is complete, migrated assets should be managed by controlled IT operations. This article does not represent a deviation from operational best practices. Instead, the following should be considered a minimum viable product for securing and managing migrated assets, either from IT operations or independently as IT operations come online.

## Monitoring

*Monitoring* is the act of collecting and analyzing data to determine the performance, health, and availability of your business workload and the resources that it depends on. Azure includes multiple services that individually perform a specific role or task in the monitoring space. Together, these services deliver a comprehensive solution for collecting, analyzing, and acting on telemetry from your workload applications and the Azure resources that support them. Gain visibility into the health and performance of your apps, infrastructure, and data in Azure with cloud monitoring tools, such as Azure Monitor, Log Analytics, and Application Insights. Use these cloud monitoring tools to take action and integrate with your service management solutions:

- **Core monitoring.** Core monitoring provides fundamental, required monitoring across Azure resources. These services require minimal configuration and collect core telemetry that the premium monitoring services use.
- **Deep application and infrastructure monitoring.** Azure services provide rich capabilities for collecting and analyzing monitoring data at a deeper level. These services build on core monitoring and take advantage of common functionality in Azure. They provide powerful analytics with collected data to give you unique insights into your applications and infrastructure.

Learn more about [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/overview) for monitoring migrated assets.

## Security monitoring

Rely on the Azure Security Center for unified security monitoring and advanced threat notification across your hybrid cloud workloads. The Security Center gives full visibility into and control over the security of cloud applications in Azure. Quickly detect and take action to respond to threats and reduce exposure by enabling adaptive threat protection. The built-in dashboard provides instant insights into security alerts and vulnerabilities that require attention. Azure Security Center can help with many functions, including:

- **Centralized policy monitoring.** Ensure compliance with company or regulatory security requirements by centrally managing security policies across hybrid cloud workloads.
- **Continuous security assessment.** Monitor the security of machines, networks, storage and data services, and applications to discover potential security issues.
- **Actionable recommendations.** Remediate security vulnerabilities before they can be exploited by attackers. Include prioritized and actionable security recommendations.
- **Advanced cloud defenses.** Reduce threats with just-in-time access to management ports and safe lists to control applications running on your VMs.
- **Prioritized alerts and incidents.** Focus on the most critical threats first, with prioritized security alerts and incidents.
- **Integrated security solutions.** Collect, search, and analyze security data from a variety of sources, including connected partner solutions.

Learn more about [Azure Security Center](https://docs.microsoft.com/azure/security-center) for securing migrated assets.

## Service health monitoring

Azure Service Health provides personalized alerts and guidance when Azure service issues affect you. It can notify you, help you understand the impact of issues, and keep you updated as the issue is resolved. It can also help you prepare for planned maintenance and changes that could affect the availability of your resources.

- **Service health dashboard.** Check the overall health of your Azure services and regions, with detailed updates on any current service issues, upcoming planned maintenance, and service transitions.
- **Service health alerts.** Configure alerts that will notify you and your teams in the event of a service issue like an outage or upcoming planned maintenance.
- **Service health history.** Review past service issues and download official summaries and reports from Microsoft.

Learn more about [Azure Service Health](https://docs.microsoft.com/azure/service-health) for staying informed about the health of your migrated resources.

## Protect assets and data

Azure Backup provides a means of protecting VMs, files, and data. Azure Backup can help with many functions, including:

- Backing up VMs.
- Backing up files.
- Backing up SQL Server databases.
- Recovering protected assets.

Learn more about [Azure Backup](https://docs.microsoft.com/azure/backup) for protecting migrated assets.

## Optimize resources

Azure Advisor is your personalized guide to Azure best practices. It analyzes your configuration and usage telemetry and offers recommendations to help you optimize your Azure resources for high availability, security, performance, and cost. Advisor’s inline actions help you quickly and easily remediate your recommendations and optimize your deployments.

- **Azure best practices.** Optimize migrated resources for high availability, security, performance, and cost.
- **Step-by-step guidance.** Remediate recommendations efficiently with guided quick links.
- **New recommendations alerts.** Stay informed about new recommendations, such as additional opportunities to rightsize VMs and save money.

Learn more about [Azure Advisor](https://docs.microsoft.com/azure/advisor/advisor-overview) for optimizing your migrated resources.

## Suggested skills

Microsoft Learn is a new approach to learning. Readiness for the new skills and responsibilities that come with cloud adoption doesn't come easily. Microsoft Learn provides a more rewarding approach to hands-on learning that helps you achieve your goals faster. Earn points and levels, and achieve more!

Here is an example of a tailored learning path on Microsoft Learn that's aligned with the Secure and Manage portion of the Cloud Adoption Framework: 

[Secure your cloud data](https://docs.microsoft.com/learn/paths/secure-your-cloud-data/): Azure was designed for security and compliance. Learn how to leverage the built-in services to store your app data securely to ensure that only authorized services and clients have access to it.
