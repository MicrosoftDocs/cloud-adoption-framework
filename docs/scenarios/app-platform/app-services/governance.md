---
title: Governance considerations for the App Service landing zone accelerator
description: Learn about design considerations and recommendations for governance in the Azure App Service landing zone accelerator.
author: martinekuan
ms.author: martinek
ms.date: 01/09/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Governance considerations for the App Service landing zone accelerator

This article provides design considerations and recommendations for governance that you can apply when you use the Azure App Service landing zone accelerator. Azure governance is the process of implementing support for cloud governance, compliance auditing, and automated guardrails.

Learn more about the [Azure governance](../../../ready/landing-zone/design-area/governance.md) design area.

## Design considerations

When you use App Service, you need to take governance into account. Governance involves establishing policies and procedures to ensure that you use the platform in a consistent, secure, and compliant way.

You should take the following considerations into account when you prepare for any deployment of App Service.

- **Security and access control:** App Service supports connections via SSL/TLS and Azure Active Directory (Azure AD) integration for authentication and authorization. You need to ensure that all communication between your app and the client is encrypted and secure, especially if the app handles sensitive data. You also need to properly configure access control to ensure that only authorized users can access the app and its resources. You can use role-based access control to specify the permissions and access levels for various users and groups. It's also a good idea to regularly review and update your access control settings to ensure that they're still appropriate for the needs of the app and its users.
- **Compliance:** Depending on your industry and regulatory requirements, you might need to configure the App Service landing zone to meet your compliance standards. This could include implementing specific security controls and regularly monitoring and auditing your environment to ensure compliance.
- **Resource management:** Proper resource management is essential to ensure the efficient and cost-effective operation of the App Service landing zone. This management includes monitoring and controlling the allocation of resources like storage, network bandwidth, and compute capacity.
- **Cost management:** App Service is a pay-as-you-go service, so you're charged based on your usage. You need to establish policies and procedures for cost management to ensure that you pay only for the resources you actually need and to avoid overspending.
- **Monitoring and logging:** To ensure the availability and performance of the App Service landing zone, you need to implement monitoring and logging. Doing so can enable your team to quickly identify and address any problems that arise and to track the performance and usage of the environment over time.
- **Monitoring and alerts:** You should monitor the App Service landing zone accelerator to ensure that it's operating efficiently and effectively. You should also implement alerts. You can use Azure Monitor for performance monitoring and alerts. You can also implement custom monitoring and alerting solutions as needed.
- **Data management:** App Service supports various options for storing and managing data, including Azure SQL Database, Azure Cosmos DB, and Azure Blob Storage. You need to carefully consider your data management strategy to ensure that your data is stored in a secure and scalable way.
- **Deployment strategy:** App Service supports various deployment options, including continuous deployment from source control and deployment slots for staging and testing. You need to establish a deployment strategy that ensures that your app is deployed in a consistent and reliable way.


Effective governance of the App Service landing zone is crucial to help ensure the security, compliance, and performance of your environment. Effective governance can enable your team to deliver high-quality services, mitigate risk, and reduce costs.

## Design recommendations

Take the following recommendations into account when you prepare for any deployment of App Service:

- Use [Azure Policy](/azure/app-service/policy-reference) to assess and enforce regulatory compliance controls.
- Consider using resource tags. Resource tags can help you manage and organize resources on Azure. You can use them to assign metadata to resources. You can use this metadata for various purposes, like categorizing resources by application or business unit, tracking the cost of resources, and identifying resources for compliance.
- Establish clear roles and responsibilities for the team that manages your App Service resources. Establish who's responsible for managing access to the resource and who has the authority to deploy resources in it.
- Monitor the use of your App Service resources and their dependencies to identify any potential security risks or unauthorized access. You can use Azure Monitor to collect logs and metrics from the landing zone. You can use Microsoft Sentinel to analyze data and identify any potential problems.
- Regularly review and update the access controls and policies for the landing zone to ensure that they remain effective. You should periodically audit access controls and policies and review any changes to the landing zone to ensure that they comply with established governance guidelines.

To effectively manage and maintain the App Service landing zone accelerator, you need to implement a robust governance framework. This framework can include Azure Resource Manager templates for deployment and management and the implementation of policies and standards for naming conventions, resource tagging, and resource lifecycle management.

These guidelines can help you ensure that App Service is properly governed and secure, and that only authorized users have access to it and the apps in it.
