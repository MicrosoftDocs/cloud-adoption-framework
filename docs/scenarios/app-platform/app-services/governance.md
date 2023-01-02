---
title: Governance considerations for the Azure App Service landing zone accelerator
description: Learn about design considerations and recommendations for governance in the Azure App Service landing zone accelerator
author: martinekuan
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Governance considerations the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for governance when using the Azure App Service landing zone accelerator. Azure governance establishes the tooling needed to support cloud governance, compliance auditing, and automated guardrails.

Learn more about the [Azure governance](../../../ready/landing-zone/design-area/governance.md) design area.

## Design considerations

Governance is an important aspect to consider when using Azure App Service. It involves establishing policies and procedures to ensure that the platform is used in a consistent, secure, and compliant manner.

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:
- Security and Access control: Azure App Service supports secure connections using SSL/TLS, as well as Azure Active Directory integration for authentication and authorization. It is important to ensure that all communication between the app and the client is encrypted and secure, especially if the app handles sensitive data. Additionally, it is important to properly configure access control to ensure that only authorized users are able to access the app and its resources. This can be done through the use of role-based access control, which allows you to specify the permissions and access levels for different users and groups. It is also a good idea to regularly review and update the access control settings to ensure that they are still appropriate for the current needs of the app and its users.
- Compliance: Depending on the industry and regulatory requirements, the Azure App Service landing zone may need to be configured to meet certain compliance standards. This could include implementing specific security controls, as well as regularly monitoring and auditing the environment to ensure compliance.
- Resource management: Proper resource management is essential for ensuring the efficient and cost-effective operation of the Azure App Service landing zone. This includes monitoring and controlling the allocation of resources such as storage, network bandwidth, and compute capacity.
- Cost management: Azure App Service is a pay-as-you-go service, which means that you are charged based on your usage. It is important to establish policies and procedures for cost management to ensure that you are only paying for the resources you actually need and to avoid overspending.
- Monitoring and logging: To ensure the availability and performance of the Azure App Service landing zone, it is important to implement monitoring and logging solutions. This will enable the team to quickly identify and address any issues that may arise, as well as to track the performance and usage of the environment over time.
- Monitoring and Alerting: The Azure App Service landing zone accelerator should be monitored and alerted on in order to ensure that it is operating efficiently and effectively. This can be achieved through the use of Azure Monitor for performance monitoring and alerts, as well as implementing custom monitoring and alerting solutions as needed.
- Data management: Azure App Service supports various options for storing and managing data, including Azure SQL Database, Azure Cosmos DB, and Azure Blob Storage. It is important to carefully consider your data management strategy to ensure that your data is stored in a secure and scalable manner.
- Deployment strategy: Azure App Service supports various deployment options, including continuous deployment from source control and deployment slots for staging and testing. It is important to establish a deployment strategy that ensures that your app is deployed in a consistent and reliable manner.


Overall, effective governance of the Azure App Service landing zone is crucial for ensuring the security, compliance, and performance of the environment. This will enable the team to deliver high-quality services to end users, while also mitigating risk and reducing costs.

## Design recommendations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:

- Use [Azure Policy](/azure/app-service/policy-reference) to assess and enforce Regulatory Compliance controls
- Resource tags are a useful tool for managing and organizing resources within Azure. They allow you to assign metadata to resources, which can then be used for a variety of purposes, such as categorizing resources by application or business unit, tracking the cost of resources, or identifying resources for compliance purposes.
- Establish clear roles and responsibilities for the team managing the your app service resources. This should include who is responsible for managing access to the resource, as well as who has the authority to deploy resources within it.
- Monitor the usage of your App Service Resources and its dependencies to identify any potential security risks or unauthorized access. This can be done using Azure Monitor to collect logs and metrics from the landing zone, and using Azure Sentinel to analyze the data and identify any potential issues.
- Regularly review and update the access controls and policies in place for the landing zone to ensure they remain effective. This should include periodic audits of the access controls and policies, as well as the review of any changes to the landing zone to ensure they are in compliance with the established governance guidelines.

In order to effectively manage and maintain the Azure App Service landing zone accelerator, it is important to implement a robust governance framework. This can include the use of Azure Resource Manager templates for deployment and management, as well as implementing policies and standards for naming conventions, resource tagging, and resource lifecycle management.

By following these guidelines, you can ensure that Azure App Service is properly governed and secure, and that only authorized users have access to it and the apps within it.
