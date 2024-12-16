---
title: Monitor Azure platform landing zone components
description: Learn how to deploy baseline monitoring for your Azure platform services to ensure availability, reliability, security, and scalability.
author: Jfaurskov
ms.author: janfaurs
ms.date: 09/11/2023
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Monitor Azure platform landing zone components

Monitor your Azure platform landing zone components to ensure availability, reliability, security, and scalability. Monitoring your components enables your organization to:

- Promptly detect and resolve issues, optimize resource utilization, and proactively address security threats.
- Continuously monitor performance and health, which helps your organization minimize downtime, optimize costs, and ensure efficient operation.
- Facilitate capacity planning, which allows your organization to anticipate resource needs and scale the platform accordingly.

Monitor the platform landing zone services to maintain a stable and secure environment, maximize performance, and effectively meet the evolving needs of your business.

The following video discusses the solution that's described in this article and demonstrates how to deploy Azure Monitor.

> [!VIDEO https://www.youtube.com/embed/xeuxetAfHRg?si=1dmmOyIAkdf8nMgV]

## Azure landing zone monitoring guidance

Baseline metric, activity log, and log query alerts are available for landing zone platform components and other selected landing zone components. These alerts ensure consistent alerting and monitoring for your Azure landing zone. They're based on Microsoft-recommended practices for proactive monitoring, such as setting up alerts, thresholds, and notifications for timely problem detection and response. Use the following guidance to achieve real-time visibility into the performance, utilization, and security of your platform landing zone implementation. Proactively address issues, optimize resource allocation, and ensure a reliable and secure environment.

:::image type="complex" source="media/azure-monitor-baseline-alerts-policy-initiative-flow.svg" alt-text="Diagram that shows Azure Monitor baseline alert topology." lightbox="media/azure-monitor-baseline-alerts-policy-initiative-flow.svg":::
   Diagram that shows the initiatives are applied at the platform management groups, connectivity, identity and management while the landing zone initiative is applied to the landing zones management group. The service health initiative and notifications assets initiative is applied at the intermediate root management group so that it is applied to all subscriptions.
:::image-end:::
*Download a [Visio file](https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz/media/AMBA-Diagrams.vsdx) of this architecture.*

The following subsets of Azure components have one or more alerts defined:

- Azure ExpressRoute
- Azure Firewall
- Azure Virtual Network
- Azure Virtual WAN
- Azure Monitor Log Analytics workspace
- Azure Private DNS zone
- Azure Key Vault
- Azure Virtual Machine
- Azure Storage account

For more information, see [Alert details](https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz/Getting-started/Alerts-Details/).

To ensure that your organization's resources are properly monitored and secured, you also need to properly configure alerts and implement appropriate processes to respond to alerts. Configure action groups with the appropriate notification channels and test the alerts to ensure that they work as expected. In accordance with the Cloud Adoption Framework principle of subscription democratization, configure at least one action group for each subscription so that relevant staff is notified of alerts. As a minimum form of notification, the action group should include an email notification channel. If you use Azure Monitor alert processing rules to route alerts to one or more action groups, note that service health alerts don't support alert processing rules. Configure service health alerts directly with the action group.

In accordance with [Azure landing zone principles for policy-driven governance](/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance#why-use-dine-and-modify-policies), a framework solution is available that provides an easy way to scale alerting by using Azure Policy. These policies use the *DeployIfNotExists* effect to deploy relevant alert rules, alert processing rules, and action groups when you create a resource in your Azure landing zone environment, in both platform services and landing zones.

Azure Policy provides a default baseline configuration, but you can configure the policies to suit your needs. If you require alerting on different metrics than what the repository provides, the solution provides a framework for you to develop your own policies for deploying alert rules. For more information, see the [Azure Monitor baseline alerts (AMBA) contributor guide](https://aka.ms/amba/contributing) and [Introduction to an Azure Monitor deployment](https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz/HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern/). The solution is integrated into the Azure landing zone installation experience, so new implementations of Azure landing zone offer you the opportunity to set up baseline alerting at installation time.

Deploy alerts via policies to provide flexibility and scalability, and to ensure that alerts are deployed inside and outside the Azure landing zone scope. Alerts are only deployed when the corresponding resources are created, which avoids unnecessary cost and ensures updated alerts configurations at deployment time. This function coincides with the Azure landing zone principle of policy-driven governance.

## Brownfield guidance

In a brownfield scenario, your organization has an existing Azure landing zone implementation, or your organization implemented Azure before an Azure landing zone architecture was available.

This section describes the high-level steps for Azure landing zone baseline monitoring if you have an existing Azure footprint, whether aligned to Azure landing zones or not.

### Aligned to an Azure landing zone

Use this process if you have an existing Azure landing zone implementation and you want to use the policy-driven approach.

1. Import relevant policies and initiatives from the AMBA repository.
2. Assign the required policies in your environment.
3. Remediate noncompliant policies.

For more information about policies relevant to your environment and the steps to apply them, see [Determine your management group hierarchy](https://aka.ms/amba/alz/brownfield).

### Not aligned to an Azure landing zone

Use this process if you have a non-Azure landing zone aligned implementation and you want to use the policy-driven approach.

1. Import relevant policies and initiatives from the AMBA repository to the top-most management group from which you wish to assign the policies.
2. Assign the required policies in your environment.
3. Remediate noncompliant policies.

For more information about policies relevant to your environment and the steps to apply them, see [Determine your management group hierarchy](https://aka.ms/amba/alz/brownfield).

## Test the framework

Test policies and alerting before a deployment to production so you can:

- Ensure that your organization's resources are properly monitored and secured.
- Identify issues early to ensure proper functionality, reduce risk, and improve performance.
- Detect and fix problems before they become larger. Avoid false positives or negatives and reduce the risk of costly mistakes.
- Optimize configurations for better performance and avoid performance-related issues in production.

Testing helps you ensure that your alerting and policy configurations meet your organization's requirements and comply with regulations and standards. With regulations in place, you can avoid security breaches, compliance violations, and other risks that can have consequences for your organization.

Testing is an essential step in the development and deployment of alerting and policy configurations, and can help you ensure the security, reliability, and performance of your organization's resources.

For more information, see [Testing approach for Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach).

>[!NOTE]
>If you implement alerting by using a different approach, like infrastructure as code (IaC), for example Azure Resource Manager, Bicep, or Terraform, or via the portal, the guidance for alerts, severity, and thresholds that's in the repository still applies for determining which alert rules to configure and for notifications.

## Next steps

- [Introduction to deploying Azure Monitor](https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz/HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern/)

- [Business continuity and disaster recovery](management-business-continuity-disaster-recovery.md)
