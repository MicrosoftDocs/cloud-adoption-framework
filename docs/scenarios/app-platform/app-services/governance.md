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

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:
- Security: The security of the Azure App Service landing zone is of utmost importance, as it will be hosting sensitive business-critical applications. Ensure that the landing zone is configured with the appropriate security controls and access policies to protect against unauthorized access.
- Compliance: Depending on the industry and regulatory requirements, the Azure App Service landing zone may need to be configured to meet certain compliance standards. This could include implementing specific security controls, as well as regularly monitoring and auditing the environment to ensure compliance.
- Resource management: Proper resource management is essential for ensuring the efficient and cost-effective operation of the Azure App Service landing zone. This includes monitoring and controlling the allocation of resources such as storage, network bandwidth, and compute capacity.
- Monitoring and logging: To ensure the availability and performance of the Azure App Service landing zone, it is important to implement monitoring and logging solutions. This will enable the team to quickly identify and address any issues that may arise, as well as to track the performance and usage of the environment over time.
- Change management: To maintain the stability and integrity of the Azure App Service landing zone, it is important to implement a robust change management process. This should include controls for planning, testing, and implementing changes to the environment, as well as mechanisms for tracking and documenting changes.
- Monitoring and Alerting: The Azure App Service landing zone accelerator should be monitored and alerted on in order to ensure that it is operating efficiently and effectively. This can be achieved through the use of Azure Monitor for performance monitoring and alerts, as well as implementing custom monitoring and alerting solutions as needed.

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
