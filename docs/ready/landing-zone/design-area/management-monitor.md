---
title: Baseline monitoring considerations
description: Learn how to deploy baseline monitoring for your Azure platform services.
author: Jfaurskov
ms.author: janfaurs
ms.date: 07/13/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, UpdateFrequency.5
---

# Monitor your Azure platform landing zone components

Monitor your Azure platform landing zone components to ensure availability, reliability, security, and scalability of the platform services. It enables your organization to:

- Promptly detect and resolve issues, optimize resource utilization, and proactively address security threats.
- Continuously monitor performance and health, which helps your organizations minimize downtime, optimize costs, and ensure efficient operation.
- Facilitate capacity planning, which allows your organization to anticipate resource needs and scale the platform accordingly.

Monitor the platform landing zone services to maintain a stable and secure environment, maximize performance, and effectively meet the evolving needs of your business.

## Monitoring guidance for Azure landing zone

To ensure consistent alerting and monitoring for Azure landing zone, there are a set of baseline alerts for the landing zone platform components and some landing zone components. The alerts are a combination of metric, activity log, and log query alerts based on Microsoft recommended practices for proactive monitoring, including setting up alerts, thresholds, and notifications for timely issue detection and response. With the guidance and tooling provided, your organization can achieve real-time visibility into the performance, utilization, and security of your platform landing zone implementation. You will be able to proactively address issues, optimize resource allocation, and ensure a reliable and secure environment.

A subset of the Azure components for which one or more alerts are defined includes:

- Azure ExpressRoute
- Azure Firewall
- Azure Virtual Network
- Azure Virtual WAN
- Azure Monitor Log Analytics workspace
- Azure Private DNS zone
- Azure Key Vault
- Azure Virtual Machine
- Azure Storage account

For more information, see [here](https://aka.ms/alz/monitor/alertdetails).

To ensure that your organization's resources are properly monitored and secured, you also need to ensure that you properly configure alerts and that you have appropriate processes in place to respond to alerts. Configure action groups with the appropriate notification channels and test the alerts to ensure that they work as expected. In line with the Cloud Adoption Framework principle of subscription democratization. Configure at least one action group for each subscription so subscription owners are notified of alerts. As a minimum, the action group should include an email notification channel as the most primitive form of notification. If you use Azure Monitor alert processing rules to route alerts to one or more action groups, note that service health alerts don't support alert processing rules. Configure service health alerts directly with the action group.

There's a framework solution that provides an easy way to scale alerting by using Azure Policy, in accordance with [Azure landing zone principles for policy driven governance](/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance#why-use-dine-and-modify-policies). These policies use the *DeployIfNotExists* effect to deploy relevant alert rules, alert processing rules, and action groups, when you create a resource in your Azure landing zone environment, in both platform services or landing zones.  

Azure Policy provides a default baseline configuration, but you can configure the policies to suit your needs. If you require alerting on different metrics than what the repository provides, the solution provides a framework for you to develop your own policies for deploying alert rules. For more information, see the [Azure Monitor Baseline Alerts contributor guide](https://aka.ms/amba/contributing). For more details on how to deploy and customize policies please refer to [here](https://aka.ms/amba/alz/deploy). The solution is integrated into the Azure landing zone installation experience, so new implementations of Azure landing zone offer you the opportunity to set up baseline alerting at installation time. In a brownfield scenario, your organization has an existing Azure landing zone implementation, or your organization implemented Azure before Azure landing zone architecture was available. The following section describes how to implement baseline alerting for a brownfield deployment.

Deploy alerts via policies to provide flexibility and scalability, and to ensure that alerts are deployed inside and outside the Azure landing zone scope. Alerts are only deployed when the corresponding resources are created, which avoids unnecessary cost and ensures updated alerts configurations at deployment time. This coincides very well with the Azure landing zone principle of policy-driven governance.

## Brownfield guidance

This section describes the high-level steps for Azure landing zone baseline monitoring if you have an existing Azure footprint, whether aligned to Azure landing zones or not.

### Azure landing zone aligned

Use this process if you have an existing Azure landing zone implementation and you want to use the policy-driven approach.

1. Import relevant policies and initiatives from the Azure Monitor Baseline Alerts (AMBA) repository as described
2. Assign the required policies.
3. Remediate non-compliant policies.

For more information about which policies are relevant and required for you and the specific steps to take to apply them, see [here](https://aka.ms/amba/alz/brownfield).

### Non-Azure landing zone aligned

Use this process If you have a non-Azure landing zone aligned implementation and you want to use the policy-driven approach.

1. Import relevant policies and initiatives from the AMBA repository to the top-most management group from which you wish to assign the policies.
2. Assign the required policies in your environment.
3. Remediate non-compliant policies.

For more information about which policies are relevant and required for you and the specific steps to take to apply them, see [here](https://aka.ms/amba/alz/brownfield).

## Test the framework

Test policies and alerting before a deployment to production to:

- Ensure that your organization's resources are properly monitored and secured.
- Identify issues early to ensure proper functionality, reduce risk, and improve performance.
- Detect and fix problems before they become larger. Avoid false positives or negatives and reduce the risk of costly mistakes.
- Optimize configurations for better performance and avoid performance-related issues in production.

Testing helps you ensure that your alerting and policy configurations meet your organization's requirements and comply with regulations and standards. This can help you avoid security breaches, compliance violations, and other risks that can have consequences for your organization.

Testing is an essential step in the development and deployment of alerting and policy configurations, and can help you ensure the security, reliability, and performance of your organization's resources.

For more information on recommended test process and procedures, see [Testing approach for Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach).
>[!NOTE]
>If you implement alerting by using a different approach, like infrastructure as code (IaC) (ARM, Bicep, Terraform) or via the portal, the guidance about alerts, severity, and thresholds in the repo still applies for determining which alert rules to configure, notifications.

## Next steps

Learn more about how to deploy baseline alerting for Azure landing zone [here](https://aka.ms/amba/alz/deploy).

Learn about Business Continuity and Disaster recovery for Azure landing zone [here](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-business-continuity-disaster-recovery).
