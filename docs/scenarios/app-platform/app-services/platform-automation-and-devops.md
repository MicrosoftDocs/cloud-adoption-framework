---
title: Platform automation and DevOps for Azure App Service
description: Learn about design considerations and recommendations for platform automation and DevOps in the Azure App Service landing zone accelerator
author: martinekuan
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Platform automation and DevOps for the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for platform automation and DevOps when using the Azure App Service landing zone accelerator. Platform automation and DevOps provide opportunities to modernize your approach to environmental deployment with infrastructure-as-code options.

Learn more about the [platform automation and DevOps](../../../ready/landing-zone/design-area/platform-automation-devops.md) design area.

## Design considerations

Automation and DevOps are important practices in modern software development, and Azure App Service is a powerful platform for building and deploying web applications. By using automation and DevOps techniques, you can streamline your workflow and improve the quality and reliability of your applications.

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service.
- It's important to understand the requirements and goals of the project in order to determine the most appropriate tools and approaches for automation. This may involve identifying the specific tasks that need to be automated, such as infrastructure provisioning, code deployment and testing, as well as the tools and technologies that will be used to achieve this automation.
- Security: should be a top priority when designing an automation and CI/CD pipeline in Azure App Service. This may involve implementing authentication and authorization measures to protect access to the pipeline and its components, as well as implementing encryption and other security measures to protect sensitive data
- Continuous integration and deployment: Azure App Service supports continuous integration and deployment from a variety of source control systems, including Azure Repos, GitHub, and Bitbucket. This allows you to automate the build and deployment process, ensuring that your app is always up-to-date and available.
- Automation scripts: Azure App Service provides a number of automation scripts, including PowerShell, Azure CLI, Azure Bicep and Azure Resource Manager templates, which allow you to automate common tasks, such as provisioning and scaling resources.
- Depending on the network configuration, App Services might not be reachable from the public internet and the use of public hosted agents will not work for deployments. Plan to use [self-hosted agents](https://azure.github.io/AppService/2021/01/04/deploying-to-network-secured-sites.html) in that scenario.
- Adopt a branching strategy which will help you collaborate while providing flexibility as well. Keep your strategy simple, use short-living feature isolation and allow modifications back to your main branch through pull requests with manual and automated code analysis.
- Make sure that your business logic is checked by unit tests in the build pipeline. Use integration tests in the release pipeline to check that every service and resource work together after a new release and check the most critical UI elements with automated UI tests. Cover non-functional performance requirements with load tests (eg k6, JMeter) in your staging environment.

- Monitor and maintain the automation and CI/CD pipeline. This may involve implementing logging and monitoring tools to track the performance and health of the pipeline, as well as implementing processes for regularly reviewing and updating the pipeline to ensure that it remains effective and efficient.

Overall, the key to successful platform automation and a CI/CD pipeline in Azure App Service is to carefully plan and design the solution, taking into account the specific needs and requirements of the applications being deployed. With the right approach, you can create a scalable, secure, and efficient platform for deploying and managing your applications in the cloud.


## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of App Service.

- Leverage Azure DevOps for your CI/CD pipeline. Azure DevOps provides a complete end-to-end solution for automating the build, testing, and deployment of your applications, making it easy to implement a robust CI/CD pipeline.

- Rely on pipelines or actions to:
    - Maximize applied practices across the team.
    - Remove much of the burden of reinventing the wheel.
    - Provide predictability and insights in overall quality and agility.
- Deploy early and often by using trigger-based and scheduled pipelines. Trigger-based pipelines ensure changes go through proper validation, while scheduled pipelines manage behavior in changing environments.
- Separate infrastructure deployment from application deployment. Core infrastructure changes less than applications. Treat each type of deployment as a separate flow and pipeline.
- Use Infrastructure as Code tools such Azure Resource Manager (ARM) or Bicep templates to automate the provisioning and management of your Azure resources. ARM and Bicep templates allows you to define your infrastructure as code, making it easy to version control, collaborate on, and automate the deployment of your resources.

- Store secrets and other sensitive artifacts in the relevant secret store (eg Azure Key Vault or GitHub secrets), allowing actions and other workflow parts to read them if needed while executing.
-  Strive for maximized deployment concurrency by avoiding hardcoded configuration items and settings.
-  Embrace [shift left](/azure/devops/learn/devops-at-microsoft/shift-left-make-testing-fast-reliable) security by adding vulnerability and secret scanning tools like container scanning early in the pipeline.
-  Set up a deployment strategy that follows the principles of blue-green or canary deployments, to minimize downtime and reduce the risk of deployment failures. This will enable you to gradually roll out new versions of your application to a small subset of users, before rolling it out to the entire user base.
-  Use Azure App Service Deployment Slots to implement a blue/green deployment strategy. This allows you to validate and test your deployments in a staging environment before swapping them into production, ensuring a smooth and successful deployment process, validate application changes and minimize downtime.
- Monitor and track the performance and availability of your applications using Azure Application Insights. This will provide you with real-time insights into the health and usage of your applications, and help you quickly diagnose and resolve any issues that may arise.

- Collaboration and communication: Successful platform automation, DevOps, and CI/CD processes rely on effective collaboration and communication among team members. This means implementing tools and processes that facilitate communication and collaboration, such as agile development methodologies and tools for tracking and managing tasks and dependencies.

Overall, the key to successful platform automation, DevOps, and CI/CD with the Azure App Service is to design and implement processes and systems that are scalable, secure, well-monitored, and collaborative. By keeping these considerations in mind, IT and cloud engineers can ensure that their apps and APIs are able to deliver the best possible performance and user experience.
