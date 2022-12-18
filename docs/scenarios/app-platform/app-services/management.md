---
title: Operations management considerations for Azure App Service
description: Learn about design considerations and recommendations for operations management in the Azure App Service landing zone accelerator
author: martinekuan
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Operations management considerations for the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for operations management when using the Azure App Service landing zone accelerator. Operations management is a critical aspect of any cloud-based application, and the Azure App Service landing zone accelerator is no exception. This accelerator provides a set of pre-configured Azure resources and guidance for setting up a secure and scalable environment for hosting web, mobile, and API applications on Azure.

Learn more about the [management](../../../ready/landing-zone/design-area/management.md) design area.

## Design considerations

There are several key considerations for operations management when using the Azure App Service landing zone accelerator:

- Management and troubleshooting: Azure App Service includes a rich set of management and troubleshooting tools, such as the Azure portal, Azure PowerShell, and the Azure CLI. These tools allow you to manage your app's settings, view its performance data, and diagnose and fix any issues that may arise.
- Security and compliance: Azure App Service provides a secure environment for your app, with features such as built-in authentication and authorization, SSL/TLS certificates, and network isolation. It also meets a wide range of compliance standards, including HIPAA, PCI DSS, and ISO 27001.
- Monitoring, Alerting and Diagnostics: Azure App Service provides built-in monitoring, Alerting and diagnostic tools to help you track the performance and setting up alerts for key performance indicators such as response time and error rates. availability of your app. This includes metrics, logs, and alerts, as well as the ability to view live stream logs and run custom queries on the data.
- Deployment and scaling: Azure App Service enables you to deploy your app quickly and easily, using a variety of methods such as continuous deployment from popular source code repositories like GitHub and Azure DevOps. You can also scale your app up or down based on its current usage, using built-in auto-scaling capabilities or by manually adjusting the number of instances.
- Cost management: It's important to carefully manage costs in the Azure cloud, as it can be easy to rack up significant expenses if you're not careful. Make sure to consider cost management best practices, such as using reserved instances and properly sizing your resources.

By considering these operations management considerations and following the guidance provided by the Azure App Service landing zone accelerator, you can set up a secure and scalable environment for hosting your applications on Azure.

### Multi-Tenanted

- If your application needs to be redundant across regions, deploy the solution in more than one region and use Traffic Manager or Azure Front Door to balance load between these deployments.
- If your application spans geographies, consider deploying to a single region in each applicable geography and use Traffic Manager or Azure Front Door to provide geography-based routing.  This will provide enhanced performance and increased redundancy.
- If you need to recover from a disaster, consider if redeploying the application from a CI/CD process would be adequate.  Also consider that a web app is a component in a larger solution, and you will need to consider the DR processes for the other components in the solution.

### App Service Environment

- Guidance on designing an [ASE-based solution for high availability within a region](/azure/architecture/reference-architectures/enterprise-integration/ase-high-availability-deployment)
- Guidance on [geographic redundancy](/azure/app-service/environment/app-service-app-service-environment-geo-distributed-scale)

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of App Service.

- One key aspect of operations management in Azure App Service is monitoring and diagnostics. This allows you to track the performance and availability of your app in real time, using a variety of built-in metrics, logs, and alerts. For example, you can view live stream logs to see incoming requests to your app, and run custom queries on log data to diagnose issues or identify trends. You can also set up alerts to notify you of any potential issues or performance degradation, so that you can take action to resolve them quickly.

- Another important aspect of operations management in Azure App Service is deployment and scaling. Azure App Service makes it easy to deploy your app, using a variety of methods such as continuous deployment from popular source code repositories like GitHub and Azure DevOps. You can also scale your app up or down based on its current usage, using built-in auto-scaling capabilities or by manually adjusting the number of instances. This ensures that your app can handle varying levels of traffic and workload, without compromising performance or availability.

- In addition to monitoring, deployment, and scaling, Azure App Service also provides robust security and compliance capabilities. This includes features such as built-in authentication and authorization, SSL/TLS certificates, and network isolation, to help protect your app and its data from unauthorized access or attack. Azure App Service also meets a wide range of compliance standards, including HIPAA, PCI DSS, and ISO 27001, so you can trust that your app is compliant with relevant regulations and industry standards.
-  Azure App Service includes a rich set of management and troubleshooting tools, such as the Azure portal Metrics and Diagnoase and Solve Problem blade, Azure PowerShell, and the Azure CLI. These tools allow you to manage your app's settings, view its performance data, and diagnose and fix any issues that may arise. This makes it easy to maintain and troubleshoot your app in the cloud, so that you can keep it running smoothly and reliably.


Operations management is a crucial consideration when working with Azure App Service, whether you choose a multi-tenant App Service or a single tenant App Service Environment (ASE). Both options offer a range of benefits, and the right choice for your organization will depend on your specific needs and priorities.

### Multi-tenant App Service 

When designing and managing a multi-tenant App Service, there are several key considerations to keep in mind:

- Cost: Multi-tenant App Service is generally more cost-effective than ASE, as it is shared among multiple tenants and does not require dedicated resources. This can make it a good choice for organizations on a tight budget.
- Security and Networking: Multi-tenant App Service offers a secure hosting environment, but it may not offer the same level of security as an ASE. If security is a top priority, you may want to consider using an ASE instead, as it provies Network-isolated application hosting.


### App Service Environment (Single-tenant)
- Cost: ASEs are generally more expensive than multi-tenant App Service, as they offer a dedicated, single-tenant environment. It's important to carefully consider your budget and ensure that an ASE is the right choice for your organization.
- Security and Networking: ASEs offer additional security features such as the ability to configure custom firewall rules, making them a good choice for organizations with stringent security requirements.

Overall, Azure App Service provides a comprehensive set of operations management capabilities, enabling you to monitor, deploy, secure, and manage your app effectively in the cloud.
