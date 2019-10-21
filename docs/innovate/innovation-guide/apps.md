---
title: "Azure innovation guide: Engage through apps" 
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn to innovate by engaging through apps using Azure.
author: billyclaymyersmsft
ms.author: wimyers
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

# Azure innovation guide: Engage through apps

Innovation with apps includes modernizing your existing apps that are hosted on-premises or building cloud-native apps using containers or serverless technologies. When it comes to app modernization, Azure provides PaaS services like App Services to easily modernize your existing Web and API apps written in .NET, .NET Core, Java, Node.js, Ruby, Python, or PHP for deployment in Azure. With an open-standard container model, building microservices or containerizing your existing applications and deploying them on Azure is simple with managed services like Azure Kubernetes Services, Azure Container Instance, and Azure Web App Container. Serverless technologies like Azure Functions and Logic Apps help you focus on building your application using a consumption model (pay for what you use) rather than deploying and managing infrastructure.

<!-- markdownlint-disable MD025 -->

# [Deliver value faster](#tab/DeliverValueFaster)

One of the advantages of cloud-based solutions is the ability to gather feedback faster and start delivering value to your end user. Whether that end user is an external customer or a user in your own company, the faster you can get feedback on your applications, the better.

## Azure App Service

Azure App Service provides a hosting environment for your applications that removes the burden of infrastructure management and OS patching. It provides for automation of scale to meet the demands of your users but bound by limits you define to keep costs in check.

Azure App Service provides first-class support for languages such as ASP.NET, ASP.NET Core, Java, Ruby, Node.js, PHP, or Python. If you have the need to host another runtime stack, Azure Web Apps for Containers offers the ability to quickly and easily host a Docker container within the App Service environment to allow you to host your custom code stack in an environment that gets you out of the server business.

### Action

To configure or monitor Azure App Service deployments:

1. Go to **App Services**.
2. Configure a new App Service: click the **Add +** link and follow the prompts.
3. Manage existing App Services: Select the desired App from the list of hosted applications.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2Fsites]" submitText="Go to App Services" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

## Cognitive Services

Azure Cognitive Services allow you to infuse advanced intelligence directly into your application through a set of APIs, which expose Microsoft supported AI and Machine Learning algorithms.

### Action

To configure or monitor Azure Cognitive Service deployments:

1. Go to **Cognitive Services**.
2. Configure a new Cognitive Service: click the **Add +** link and follow the prompts.
3. Manage existing Cognitive Services: Select the desired cognitive service from the list of hosted services.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2Faccounts]" submitText="Go to Cognitive Services" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

## Bot Services

Azure Bot Services can extend your standard application to include a natural, bot interface which uses AI and Machine Learning to create a new interaction for your customers.

### Action

To configure or monitor Bot Cognitive Service deployments:

1. Go to **Bot Services**.
2. Configure a new Bot Service: click the **Add +** link and follow the prompts.
3. Manage existing Bot Services: Select the desired Bot from the list of hosted services.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.BotService%2FbotServices]" submitText="Go to Bot Services" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end


## Azure DevOps

During your innovation journey, you will inevitably find yourself on the path to DevOps at some point. Microsoft has long had an on-premises product called Team Foundation Server (TFS). During our own innovation journey, Microsoft developed Azure DevOps to be a cloud-based SaaS solution that provides build and release tools that support a myriad of languages as well as destinations for your releases. [Azure DevOps](/services/devops)

## Visual Studio App Center

As mobile apps continue to grow in popularity, the need for a platform that can provide automated testing on real devices of various configurations grows. App Center not only provides a place that you can test your applications across iOS, Android, Windows, and macOS, but it provides a monitoring platform with the ability to leverage Azure Application Insights to reason over your telemetry quickly and easily. For more information, see the [App Center overview](https://docs.microsoft.com/appcenter).

App Service also provides a notification service that lets a single call to send notifications to your application across platforms without having to contact each notification service individually. For more information, see [App Center Push](https://docs.microsoft.com/appcenter/push).

### Read more

- [App Service overview](https://docs.microsoft.com/azure/app-service/overview)
- [Web Apps for Containers: Run a custom container](https://docs.microsoft.com/azure/app-service/containers/quickstart-docker)
- [An introduction to Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-overview)
- [Azure for .NET and .NET Core developers](https://docs.microsoft.com/dotnet/azure/?view=azure-dotnet)
- [Azure SDK for Python documentation](https://docs.microsoft.com/azure/python)
- [Azure for Java cloud developers](https://docs.microsoft.com/azure/java/?view=azure-java-stable)
- [Create a PHP web app in Azure](https://docs.microsoft.com/azure/app-service/app-service-web-get-started-php)
- [Azure SDK for JavaScript documentation](https://docs.microsoft.com/azure/javascript)
- [Azure SDK for Go documentation](https://docs.microsoft.com/azure/go)
- [DevOps Solutions](https://azure.microsoft.com/solutions/devops)

# [Cloud native apps](#tab/CloudNative)

## What are cloud-native applications?

Cloud-native applications are built from the ground up, optimized for cloud scale and performance. They're based on microservices architectures, use managed services, and take advantage of continuous delivery to achieve reliability and faster time to market. Cloud-native applications are typically built using a microservices, serverless, or container-based approach.


## Microservices

Microservices are a software architecture style in which applications are composed of small independent modules that communicate with each other using well-defined API contracts. These service modules are highly decoupled building blocks that are small enough to implement a single functionality. Microservices helps you:

- Build services independently.
- Scale services autonomously.
- Use the most suitable approaches for deployment and programming language.
- Isolate points of failure.
- Deliver value faster.

### Azure Kubernetes Service (AKS)

Use a fully managed Kubernetes service to handle provisioning, upgrading, and scaling cluster resources on demand. AKS makes deploying and managing containerized applications easy. It offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience, and enterprise-grade security and governance. Unite your development and operations teams on a single platform to rapidly build, deliver, and scale applications with confidence.

#### Action

To configure or monitor Azure Kubernetes Services:

1. Go to **Kubernetes Services**.
2. Configure a new Kubernetes Services: click the **Add +** link and follow the prompts.
3. Manage existing Kubernetes Services: Select the desired Kubernetes service from the list.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.ContainerService%2FmanagedClusters]" submitText="Go to Kubernetes Services" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

## Event-based solutions

### Azure Functions

Azure Functions provides a platform for running small pieces of code or functions within the cloud. Functions can be a way to start refactoring your code base into a microservices architecture.

The Azure Functions runtime supports many languages including C#, Java, JavaScript, and Python. For a complete listing, see [Supported languages in Azure Functions](https://docs.microsoft.com/azure/azure-functions/supported-languages).

Another benefit of functions is the ability to be triggered by different actions and events such as HTTPTrigger, TimerTriggers, as well as triggers from other Azure services such as Blob Storage, EventGrid, ServiceBus, and more. For more information on triggers and bindings, see [Azure Functions triggers and bindings concepts](https://docs.microsoft.com/azure/azure-functions/functions-triggers-bindings).

#### Action

To configure or monitor Azure Function deployments:

1. Go to **Function App**.
2. Configure a new Function App: click the **Add +** link and follow the prompts.
3. Manage existing Function Apps: Select the desired Function App from the list of Function Apps.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2Fsites/kind/functionapp]" submitText="Go to Azure Functions" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

## Serverless solutions

Build cloud-native apps without provisioning and managing infrastructure using a fully managed platform where scaling, availability, and performance are handled for you. Benefits of Azure serverless solutions include:

- Increasing developer velocity
- Boosting team performance
- Improving organizational impact

### Azure Logic Apps

Integrate data and apps instead of writing complex glue code between disparate systems. Visually create serverless workflows with Azure Logic Apps and use your own APIs, serverless functions, or out-of-the-box software as a service (SaaS) connectors, including Salesforce, Microsoft Office 365, and Dropbox.

#### Action

To configure or monitor Azure Logic Apps:

1. Go to **Logic Apps**.
2. Configure a new Logic App: click the **Add +** link and follow the prompts.
3. Manage existing Logic Apps: Select the desired Logic App from the list.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Logic%2Fworkflows]" submitText="Go to Azure Logic Apps" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

### Serverless API management

Publish, secure, transform, maintain, and monitor APIs with Azure API Management, a fully managed service that offers a usage model designed and implemented to be an organic fit for serverless applications.

#### Action

To configure or monitor API Management services:

1. Go to **API Management services**.
2. Configure a new service: click the **Add +** link and follow the prompts.
3. Manage existing service: Select the desired Service from the list.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.ApiManagement%2Fservice]" submitText="Go to API Management Services" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

## Containers

When it comes to modernizing your application portfolio, Azure provides various container services to lift and shift your existing applications to containers and build cloud native microservices applications to deliver value to your users faster. Use end-to-end developer and CI/CD tools to develop, update, and deploy your containerized applications. Manage containers at scale with a fully managed Kubernetes container orchestration service that integrates with Azure Active Directory. Wherever you are in your app modernization journey, accelerate your containerized application development while meeting your security requirements.

### Azure Container Instances

Run Docker containers on-demand in a managed serverless Azure environment. Azure Container Instances (ACI) is a solution for any scenario that can operate in isolated containers without orchestration. By running your workloads in ACI, you can focus on designing and building your applications instead of managing the infrastructure that runs them.

### Action

To configure or monitor Container instances:

1. Go to **Container instances**.
2. Configure a new Container instance: click the **Add +** link and follow the prompts.
3. Manage existing Container instances: Select the desired container service from the list.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.ContainerInstance%2FcontainerGroups]" submitText="Go to Container instances" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

### Azure Red Hat OpenShift

Azure Red Hat OpenShift provides flexible self-service deployment of fully managed OpenShift clusters. Maintain regulatory compliance and focus on your application development, while your master, infrastructure, and application nodes are patched, updated, and monitored by both Microsoft and Red Hat. Choose your own registry, networking, storage, or CI/CD solutions. Or begin quickly using built-in solutions with automated source code management, container and application builds, deployments, scaling, health management, and more.

**Go to [Azure Red Hat OpenShift](https://docs.microsoft.com/azure/openshift/intro-openshift)**

# [Isolate points of failure](#tab/IsolatePointsOfFailure)

As you begin transitioning from your initial testing phase, you will want to evaluate ways to isolate and remove points of failure. Due to the distributed nature of the Azure cloud, you are able to design your application to minimize failure while at the same time improving performance.

## Azure Front Door

Azure Front Door provides a scalable, secure entry point that can help deliver your application around the globe. Azure Front Door combines optimization of traffic for best performance and instant global failover. Azure Front Door should be considered over Traffic Manager if you have a need for Transport Layer Security (TLS) protocol termination (SSL offload) or per-HTTP/HTTPS request, application-layer processing.

### Action

To configure or monitor Front Doors:

1. Go to **Front Doors**.
2. Configure a new Front Door: click the **Add +** link and follow the prompts.
3. Manage existing Front Doors: Select the desired front door from the list.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Network%2Ffrontdoors]" submitText="Go to Front Doors" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

## Traffic Manager

Traffic Manager provides DNS-based load balancing that can be routed based on different rules. This helps you ensure that you have resiliency if one or more deployed services fails. You can also stack Traffic Manager to have both failure as well as performance-based routing to provide the best experience possible based on geography.

### Action

To configure or monitor Traffic Manager profiles:

1. Go to **Traffic Manager profiles**.
2. Configure a new Traffic Manager profile: click the **Add +** link and follow the prompts.
3. Manage existing Traffic Manager profiles: Select the desired profile from the list.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Network%2Ftrafficmanagerprofiles]" submitText="Go to Traffic Manager profiles" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

## Azure Content Delivery Network

Azure offers a distributed content delivery network (CDN) that allows you to ensure timely delivery of assets by caching them close to your end users. This caching helps to improve the experience of your customers and prevents issues downloading content that might be caused by network issues between the CDN endpoint and the datacenter that hosts your application. This CDN can also be used by applications not hosted in Azure.

### Action

To configure or monitor CDN profiles:

1. Go to **CDN profiles**.
2. Configure a new CDN profile: click the **Add +** link and follow the prompts.
3. Manage existing CDN profiles: Select the desired profile from the list.

::: zone target="chromeless"
<!-- markdownlint-disable DOCSMD001 -->
::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/microsoft.cdn%2Fprofiles]" submitText="Go to CDN profiles" :::
<!-- markdownlint-enable DOCSMD001 -->
::: zone-end

### Read more

- [Azure Front Door](https://docs.microsoft.com/azure/frontdoor/front-door-overview)
- [Traffic Manager](https://docs.microsoft.com/azure/traffic-manager)
- [Content Delivery Network](https://docs.microsoft.com/azure/cdn)
