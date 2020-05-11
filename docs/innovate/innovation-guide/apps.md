---
title: "Azure innovation: Engage via apps"
description: Learn about Azure services that help you easily modernize your existing web and API apps and build cloud-native apps.
author: billyclaymyersmsft
ms.author: wimyers
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

<!-- cSpell:ignore billyclaymyersmsft wimyers functionapp -->

::: zone target="docs"

# Azure innovation guide: Engage customers through apps

::: zone-end

::: zone target="chromeless"

# Engage customers through apps

::: zone-end

Innovation with apps includes both modernizing your existing apps that are hosted on-premises and building cloud-native apps by using containers or serverless technologies. Azure provides PaaS services like Azure App Service to help you easily modernize your existing web and API apps written in .NET, .NET Core, Java, Node.js, Ruby, Python, or PHP for deployment in Azure.

With an open-standard container model, building microservices or containerizing your existing apps and deploying them on Azure is simple when you use managed services like Azure Kubernetes Service, Azure Container Instances, and Web App for Containers. Serverless technologies like Azure Functions and Azure Logic Apps use a consumption model (pay for what you use) and help you focus on building your application rather than deploying and managing infrastructure.

<!-- markdownlint-disable MD025 -->

# [Deliver value faster](#tab/DeliverValueFaster)

One of the advantages of cloud-based solutions is the ability to gather feedback faster and start delivering value to your user. Whether that user is an external customer or a user in your own company, the faster you can get feedback on your applications, the better.

## Azure App Service

Azure App Service provides a hosting environment for your applications that removes the burden of infrastructure management and OS patching. It provides automation of scale to meet the demands of your users while bound by limits that you define to keep costs in check.

Azure App Service provides first-class support for languages like ASP.NET, ASP.NET Core, Java, Ruby, Node.js, PHP, and Python. If you need to host another runtime stack, Web App for Containers lets you quickly and easily host a Docker container within App Service, so you can host your custom code stack in an environment that gets you out of the server business.

### Action

To configure or monitor Azure App Service deployments:

1. Go to **App Services**.
2. Configure a new service: Select **Add** and follow the prompts.
3. Manage existing services: Select the desired app from the list of hosted applications.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2FSites]" submitText="Go to App Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## Azure Cognitive Services

With Azure Cognitive Services, you can infuse advanced intelligence directly into your app through a set of APIs that let you take advantage of Microsoft-supported AI and machine learning algorithms.

<!-- markdownlint-disable MD024 -->

### Action

To configure or monitor Azure Cognitive Services deployments:

1. Go to **Cognitive Services**.
2. Configure a new service: Select **Add** and follow the prompts.
3. Manage existing services: Select the desired service from the list of hosted services.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2FAccounts]" submitText="Go to Cognitive Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## Azure Bot Service

Azure Bot Service extends your standard application by adding a natural bot interface that uses AI and machine learning to create a new way to interact with your customers.

### Action

To configure or monitor Azure Bot Services deployments:

1. Go to **Bot Services**.
2. Configure a new service: Select **Add** and follow the prompts.
3. Manage existing services: Select the desired bot from the list of hosted services.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.BotService%2FBotServices]" submitText="Go to Bot Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## Azure DevOps

During your innovation journey, you'll eventually find yourself on the path to DevOps. Microsoft has long had an on-premises product known as Team Foundation Server (TFS). During our own innovation journey, Microsoft developed Azure DevOps, a cloud-based service that provides build and release tools supporting many languages and destinations for your releases. For more information, see [Azure DevOps](https://docs.microsoft.com/azure/devops).

## Visual Studio App Center

As mobile apps continue to grow in popularity, the need for a platform that can provide automated testing on real devices of various configurations grows. Visual Studio App Center doesn't just provide a place where you can test your applications across iOS, Android, Windows, and macOS. It also provides a monitoring platform that can use Azure Application Insights to analyze your telemetry quickly and easily. For more information, see [Visual Studio App Center overview](https://docs.microsoft.com/appcenter).

Visual Studio App Center also provides a notification service that lets you use a single call to send notifications to your app across platforms without having to contact each notification service individually. For more information, see [Visual Studio App Center Push (ACP)](https://docs.microsoft.com/appcenter/push).

### Learn more

- [App Service overview](https://docs.microsoft.com/azure/app-service/overview)
- [Web App for Containers: Run a custom container](https://docs.microsoft.com/azure/app-service/containers/quickstart-docker)
- [An introduction to Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-overview)
- [Azure for .NET and .NET Core developers](https://docs.microsoft.com/dotnet/azure/?view=azure-dotnet)
- [Azure SDK for Python documentation](https://docs.microsoft.com/azure/python)
- [Azure for Java cloud developers](https://docs.microsoft.com/azure/java/?view=azure-java-stable)
- [Create a PHP web app in Azure](https://docs.microsoft.com/azure/app-service/app-service-web-get-started-php)
- [Azure SDK for JavaScript documentation](https://docs.microsoft.com/azure/javascript)
- [Azure SDK for Go documentation](https://docs.microsoft.com/azure/go)
- [DevOps solutions](https://azure.microsoft.com/solutions/devops)

# [Create cloud-native apps](#tab/CloudNative)

<!-- markdownlint-disable MD026 -->

## What are cloud-native applications?

Cloud-native applications are built from the ground up, optimized for cloud scale and performance. They're loosely coupled based on microservices architecture, use managed services, can be observable, and take advantage of continuous delivery to achieve reliability and faster time to market. Typically, they're portable and can run on dynamic environments like public, private, and hybrid clouds. Cloud-native applications are usually built with one or more of the following approaches:

- Microservices
- Serverless
- Containers

## Microservices

Microservices is a software architecture style in which apps are composed of small independent modules that communicate with each other via well-defined API contracts. These service modules are highly decoupled building blocks that are small enough to implement a single functionality. Microservices helps you:

- Build services independently.
- Scale services autonomously.
- Use the most suitable approaches for deployment and programming languages.
- Isolate points of failure.
- Deliver value faster.

### Azure Kubernetes Service (AKS)

Use a fully managed Kubernetes service to handle provisioning, upgrading, and scaling of cluster resources on demand. AKS makes deploying and managing containerized applications easy. It offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience, and enterprise-grade security and governance. Unite your development and operations teams on a single platform to rapidly build, deliver, and scale applications with confidence.

#### Action

To configure or monitor an AKS service:

1. Go to **Azure Kubernetes Services**.
2. Configure a new service: Select **Add** and follow the prompts.
3. Manage existing services: Select the desired Kubernetes service from the list.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.ContainerService%2FManagedClusters]" submitText="Go to Azure Kubernetes Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## Event-based solutions

### Azure Functions

Azure Functions provides a platform for running small units of code or functions in the cloud. Functions can be a way to start refactoring your code into a microservices architecture.

The Azure Functions runtime supports many languages, including C#, Java, JavaScript, and Python. For a complete list, see [Supported languages in Azure Functions](https://docs.microsoft.com/azure/azure-functions/supported-languages).

Another benefit of functions is that they can be triggered by different actions and events, like HTTPTriggers, TimerTriggers, and triggers from other Azure services like Blob storage, Event Grid, and Service Bus. For more information about triggers and bindings, see [Azure Functions triggers and bindings concepts](https://docs.microsoft.com/azure/azure-functions/functions-triggers-bindings).

#### Action

To configure or monitor Azure Functions deployments:

1. Go to **Function App**.
2. Configure a new app: Select **Add** and follow the prompts.
3. Manage existing apps: Select the desired app from the list of function apps.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2FSites/kind/functionapp]" submitText="Go to Azure Functions" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## Serverless solutions

Build cloud-native apps without provisioning and managing infrastructure by using a fully managed platform that handles scaling, availability, and performance for you. Benefits of Azure serverless solutions include:

- Increasing developer velocity.
- Boosting team performance.
- Improving organizational impact.

### Azure Logic Apps

Integrate data and apps instead of writing complex integration code between disparate systems. Visually create serverless workflows with Azure Logic Apps and use your own APIs, serverless functions, or out-of-the-box software as a service (SaaS) connectors, including Salesforce, Microsoft Office 365, and Dropbox.

#### Action

To configure or monitor Azure logic apps:

1. Go to **Logic Apps**.
2. Configure a new app: Select **Add** and follow the prompts.
3. Manage existing apps: Select the desired logic app from the list.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Logic%2FWorkflows]" submitText="Go to Azure Logic Apps" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

### Serverless API management

Publish, secure, transform, maintain, and monitor APIs by using Azure API Management, a fully managed service that offers a usage model designed and implemented to be natural fit for serverless applications.

#### Action

To configure or monitor API Management services:

1. Go to **API Management services**.
2. Configure a new service: Select **Add** and follow the prompts.
3. Manage existing services: Select the desired service from the list.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.ApiManagement%2FService]" submitText="Go to API Management services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## Containers

For modernizing your application portfolio, Azure provides various container services to migrate your existing apps to containers and build cloud-native microservices apps so you can deliver value to your users faster. Use end-to-end developer and CI/CD tools to develop, update, and deploy your containerized applications. Manage containers at scale with a fully managed Kubernetes container orchestration service that integrates with Azure Active Directory. Wherever you are in your app modernization journey, accelerate your containerized application development while meeting your security requirements.

### Azure Container Instances

Run Docker containers on-demand in a managed serverless Azure environment. Azure Container Instances is a solution for any scenario that can operate in isolated containers without orchestration. When you run your workloads in Container Instances, you can focus on designing and building your applications instead of managing the infrastructure that runs them.

### Action

To configure or monitor container instances:

1. Go to **Container instances**.
2. Configure a new container instance: Select **Add** and follow the prompts.
3. Manage existing container instances: Select the desired container instance from the list.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.ContainerInstance%2FContainerGroups]" submitText="Go to Container instances" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

### Azure Red Hat OpenShift

Azure Red Hat OpenShift provides flexible self-service deployment of fully managed OpenShift clusters. Maintain regulatory compliance and focus on your application development while your master, infrastructure, and application nodes are patched, updated, and monitored by both Microsoft and Red Hat. Choose your own registry, networking, storage, or CI/CD solutions. Or start quickly by using built-in solutions with automated source code management, container and application builds, deployments, scaling, health management, and more.

**Go to [Azure Red Hat OpenShift](https://docs.microsoft.com/azure/openshift/intro-openshift)**

# [Isolate points of failure](#tab/IsolatePointsOfFailure)

As you start to transition from your initial testing phase, evaluate ways to isolate and remove points of failure. Because of the distributed nature of the Azure cloud platform, you can design your application to minimize failures while also improving performance.

## Azure Front Door Service

Azure Front Door Service provides a scalable, secure entry point that you can use to deliver your application around the globe. Azure Front Door Service combines optimization of traffic for best performance and instant global failover. You should use Azure Front Door Service rather than Azure Traffic Manager if you need Transport Layer Security (TLS) protocol termination (SSL offload) or per-HTTP/HTTPS request application-layer processing.

### Action

To configure or monitor Front Doors:

1. Go to **Front Doors**.
2. Configure a new Front Door: Select **Add** and follow the prompts.
3. Manage existing Front Doors: Select the desired Front Door from the list.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Network%2FFrontDoors]" submitText="Go to Front Doors" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## Traffic Manager

Traffic Manager provides DNS-based load balancing that can be routed based on various rules. This capability helps ensure resiliency if any deployed services fail. You can also stack Traffic Manager to use both failure-based routing and performance-based routing to provide the best experience possible, based on geography.

### Action

To configure or monitor Traffic Manager profiles:

1. Go to **Traffic Manager profiles**.
2. Configure a new profile: Select **Add** and follow the prompts.
3. Manage existing profiles: Select the desired profile from the list.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Network%2FTrafficManagerProfiles]" submitText="Go to Traffic Manager profiles" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## Azure Content Delivery Network

Azure offers a distributed content delivery network (CDN) that allows you to ensure timely delivery of assets by caching them close to your users. This caching helps to improve your customers' experiences. During content download, it also prevents issues that are caused by network problems that occur between the CDN endpoint and the datacenter that hosts your application. Content Delivery Network can also be used by applications that aren't hosted in Azure.

### Action

To configure or monitor Content Delivery Network profiles:

1. Go to **CDN profiles**.
2. Configure a new profile: Select **Add** and follow the prompts.
3. Manage existing profiles: Select the desired profile from the list.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Cdn%2FProfiles]" submitText="Go to CDN profiles" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

### Learn more

- [Azure Front Door](https://docs.microsoft.com/azure/frontdoor/front-door-overview)
- [Traffic Manager](https://docs.microsoft.com/azure/traffic-manager)
- [Content Delivery Network](https://docs.microsoft.com/azure/cdn)
