---
title: Operations management considerations for the App Service landing zone accelerator
description: Learn about design considerations and recommendations for operations management in the Azure App Service landing zone accelerator.
author: martinekuan
ms.author: martinek
ms.date: 01/09/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Operations management considerations for the App Service landing zone accelerator

This article provides design considerations and recommendations for operations management that you can apply when you use the Azure App Service landing zone accelerator. Operations management is a critical aspect of any cloud-based application, and the App Service landing zone accelerator is no exception. This accelerator provides a set of pre-configured Azure resources and guidance for setting up a scalable environment for hosting web, mobile, and API applications on Azure.

Learn more about the [management](../../../ready/landing-zone/design-area/management.md) design area.

## Design considerations

Keep these considerations for operations management in mind when you use the App Service landing zone accelerator:

- **Management and troubleshooting.** App Service includes a rich set of management and troubleshooting tools, like the Azure portal, Azure PowerShell, and the Azure CLI. You can use these tools to manage your app's settings, view its performance data, and diagnose and fix problems that arise.
- **Security and compliance.** App Service provides an enhanced-security environment for your app, with features like built-in authentication and authorization, SSL/TLS certificates, and network isolation. It also meets a wide range of compliance standards, including HIPAA, PCI DSS, and ISO 27001.
- **Monitoring, alerting, and diagnostics.** App Service provides built-in monitoring, alerting, and diagnostic tools to help you track performance and set up alerts for key performance indicators like response time and error rates. These tools provide metrics and logs, and you can also stream logs in real time and run custom queries on the data.
- **Deployment and scaling.** You can use App Service to deploy your app quickly and easily. You can use a variety of deployment methods, like continuous deployment from popular source code repositories like GitHub and Azure DevOps. You can also scale your app up or down based on utilization by using built-in autoscaling capabilities or by manually adjusting the number of instances.
- **Cost management.** You need to carefully manage costs in the cloud. You can easily accumulate significant expenses if you're not cautious. Be sure to consider cost management best practices like using reserved instances and properly sizing your resources.

By keeping these considerations in mind and following the guidance provided by the App Service landing zone accelerator, you can set up a scalable environment for hosting your applications on Azure.

## Design recommendations

You should implement these best practices for any App Service deployment:

- Implement monitoring and diagnostics. For example, you can stream live logs to see incoming requests to your app and run custom queries on log data to diagnose problems or identify trends. You can also set up alerts that notify you of potential problems or performance degradation so that you can take appropriate actions.

- Take advantage of deployment and scaling features. Use autoscaling to ensure that your app can handle varying levels of traffic and workload without compromised performance or availability.

- Take advantage of App Service security and compliance capabilities. These features, including built-in authentication and authorization, SSL/TLS certificates, and network isolation, can help protect your app and its data from unauthorized access or attack. App Service compliance standards, including HIPAA, PCI DSS, and ISO 27001, can help you ensure that your app is compliant with relevant regulations and industry standards.
- Use the App Service management and troubleshooting tools, like Azure PowerShell, the Azure CLI, and metrics and problem solving in the Azure portal. Maintain and troubleshoot your app in the cloud so that you can keep it running smoothly and reliably.

Whether you use multi-tenant App Service or a single-tenant App Service Environment, operations management is a crucial consideration. Both options offer a range of benefits. The right choice for your organization depends on your needs and priorities.

### Multi-tenant App Service

If you use multi-tenant App Service, keep these considerations in mind:

- **Cost.** Multi-tenant App Service is generally more cost-effective than an App Service Environment because it's shared among multiple tenants and doesn't require dedicated resources. It can be a good choice for organizations that have tight budgets.
- **Security and networking.** Multi-tenant App Service provides a secured hosting environment, but it might not offer the same level of security as App Service Environment. If security is a priority, consider using an App Service Environment, which provides network-isolated application hosting.

### App Service Environment (single-tenant)

If you use an App Service Environment, keep these considerations in mind:

- **Cost.** App Service Environments are generally more expensive than multi-tenant App Service solutions because they offer a dedicated, single-tenant environment. You need to carefully consider your budget and make sure that an App Service Environment is the right choice for your organization.
- **Security and networking.** App Service Environments offer additional security features, like the ability to configure custom firewall rules. These features make them a good choice for organizations that have stringent security requirements.

App Service provides a comprehensive set of operations management capabilities, enabling you to monitor, deploy, and manage your app effectively in the cloud.
