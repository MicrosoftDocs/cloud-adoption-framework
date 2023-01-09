---
title: Platform automation and DevOps for the App Service landing zone accelerator
description: Learn about design considerations and recommendations for platform automation and DevOps in the Azure App Service landing zone accelerator.
author: martinekuan
ms.author: martinek
ms.date: 01/09/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Platform automation and DevOps for the App Service landing zone accelerator

This article provides design considerations and recommendations for platform automation and DevOps that you can apply when you use the Azure App Service landing zone accelerator. Platform automation and DevOps provide opportunities to modernize your approach to deployment by using infrastructure-as-code.

Learn more about the [platform automation and DevOps](../../../ready/landing-zone/design-area/platform-automation-devops.md) design area.

## Design considerations

Automation and DevOps are important practices in modern software development, and App Service is a powerful platform for building and deploying web applications. By using automation and DevOps techniques, you can streamline your workflow and improve the quality and reliability of your applications.

Take the following considerations into account when you prepare for any deployment of App Service.

- Understand the requirements and goals of the project so you can determine the most appropriate tools and approaches for automation. This step involves identifying the tasks that you want to automate, like infrastructure provisioning, code deployment, and testing. It also involves identifying the tools and technologies that you'll use to implement the automation.
- Make security a top priority when you design an automation and CI/CD pipeline in App Service. Security tasks can include implementing authentication and authorization measures to help protect access to the pipeline and its components. They can also include implementing encryption and other security measures to help protect sensitive data.
- Consider continuous integration and deployment. App Service supports continuous integration and deployment from various source control systems, including Azure Repos, GitHub, and Bitbucket. You can use these tools to automate the build and deployment process, ensuring that your app is always up to date and available.
- Consider automation scripts. App Service provides a number of automation scripts, including PowerShell, Azure CLI, Bicep, and Azure Resource Manager (ARM) templates. You can use these scripts to automate common tasks like provisioning and scaling resources.
- Evaluate whether you need to use self-hosted agents. Depending on your network configuration, App Services might not be available from the public internet. If they're not, public hosted agents won't work for deployments. Plan to use [self-hosted agents](https://azure.github.io/AppService/2021/01/04/deploying-to-network-secured-sites.html) in these scenarios.
- Adopt a branching strategy that will help you collaborate while also providing flexibility. Keep your strategy simple, use short-lived feature isolation, and allow modifications back to your main branch through pull requests with manual and automated code analysis.
- Make sure that your business logic is checked by unit tests in the build pipeline. Use integration tests in the release pipeline to check that all services and resources work together after a new release. Check the most critical UI elements by using automated UI tests. Check non-functional performance requirements by using load testing via tools like k6 and JMeter in your staging environment.

- Monitor and maintain the automation and CI/CD pipeline. This process can involve implementing logging and monitoring tools to track the performance and health of your pipeline. It can also involve implementing a process for regularly reviewing and updating the pipeline to ensure that it remains effective and efficient.

The key to successful platform automation and CI/CD pipeline implementation in App Service is to carefully plan and design the solution, taking into account the specific needs and requirements of the applications that you're deploying. By using the right approach, you can create a scalable, secure, and efficient platform for deploying and managing your applications in the cloud.

## Design recommendations

Keep the following best practices in mind when you deploy App Service.

- Use Azure DevOps for your CI/CD pipeline. Azure DevOps provides a complete solution for automating the build, testing, and deployment of your applications.

- Use pipelines or actions to:
    - Maximize the benefits of applied practices across the team.
    - Remove much of the burden of reinventing processes.
    - Get predictability in and insights on overall quality and agility.
- Deploy early and often by using trigger-based and scheduled pipelines. Trigger-based pipelines ensure that changes go through proper validation. Scheduled pipelines manage behavior in changing environments.
- Separate infrastructure deployment from application deployment. Core infrastructure changes less frequently than applications. Treat each type of deployment as a separate flow and pipeline.
- Use infrastructure as code tools like ARM or Bicep templates to automate the provisioning and management of your Azure resources. You can use ARM and Bicep templates to define your infrastructure as code, making it easy to version control, collaborate on, and automate the deployment of your resources.

- Store secrets and other sensitive artifacts in the relevant secret store (like Azure Key Vault or GitHub secrets). Allow actions and other workflow parts to read them as needed.
-  Strive for maximized deployment concurrency by avoiding hardcoded configuration and settings.
-  Implement [shift-left](/azure/devops/learn/devops-at-microsoft/shift-left-make-testing-fast-reliable) security by including vulnerability and secret scanning tools, like container scanners, early in the pipeline.
-  Set up a deployment strategy that implements the principles of blue/green or canary deployments to minimize downtime and reduce the risk of deployment failures. Doing so enables you to gradually roll out new versions of your application to a small subset of users before rolling it out to the entire user base.
-  Use App Service deployment slots to implement a blue/green deployment strategy. Doing so enables you to validate and test your deployments in a staging environment before you deploy them to production. This strategy helps you ensure a smooth and successful deployment, validate application changes, and minimize downtime.
- Monitor and track the performance and availability of your applications by using Application Insights. Application Insights provides real-time insights into the health and usage of your applications. It can also help you quickly diagnose and resolve problems that arise.

- Implement tools and processes that facilitate communication and collaboration, like Agile development methodologies and tools for tracking and managing tasks and dependencies. Successful platform automation, DevOps, and CI/CD processes rely on effective collaboration and communication among team members.

The key to successful platform automation, DevOps, and CI/CD with App Service is to design and implement processes and systems that are scalable, secure, well-monitored, and collaborative. These recommendations can help IT and cloud engineers ensure that their apps and APIs deliver the best possible performance and user experience.