---
title: Application development and deployment
description: Learn about using Kubernetes in the Cloud Adoption Framework for application development and architecture.
author: sabbour
ms.author: brblanch
ms.date: 03/20/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank
---

<!-- cSpell:ignore autoscaler Istio Linkerd -->

# Application development and deployment

Examine patterns and practices of application development, configure Azure Pipelines, and implement site reliability engineering (SRE) best practices.

## Plan, train, and proof

As you get started, the checklist and resources below will help you plan your application development and deployment. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Have you prepared your development environment and setup workflow?
> - How will you structure the project folder to support Kubernetes application development?
> - Have you identified state, configuration, and storage requirements of your application?

<!-- docutune:casing "AAD Pod Identity" -->

**Checklist:**

- **Prepare your development environment.** Configure your environment with the tools you need to create containers and set up your development workflow.

  For more information, see:
  - [Working with Docker in Visual Studio Code](https://code.visualstudio.com/docs/containers/overview) <br>
  - [Working with Kubernetes in Visual Studio Code](https://code.visualstudio.com/docs/azure/kubernetes) <br>
  - [Introduction to Azure Dev Spaces](/azure/dev-spaces/about)

- **Containerize your application.** Familiarize yourself with the end-to-end Kubernetes development experience, including application scaffolding, inner-loop workflows, application-management frameworks, CI/CD pipelines, log aggregation, monitoring, and application metrics.

  To learn more, see:
  - [Containerize your applications with Docker and Kubernetes (e-book)](https://azure.microsoft.com/resources/containerize-your-apps-with-docker-and-kubernetes/) <br>
  - [End-to-end Kubernetes development experience on Azure (webinar)](https://info.microsoft.com/AU-AzureApp-WBNR-FY20-11Nov-12-ContainerizeYourApplicationswithKubernetesonAzure-SRDEM10557_LP02OnDemandRegistration-ForminBody.html)

- **Review common Kubernetes scenarios.** Kubernetes is often thought of as a platform for delivering microservices, but it's becoming a much broader platform. Watch this video to learn about common Kubernetes scenarios such as batch analytics and workflow [Common&nbsp;scenarios&nbsp;to&nbsp;use&nbsp;Kubernetes&nbsp;(video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=zd8vYhrFXp4&index=7).

- **Prepare your application for Kubernetes.** Prepare your application file system layout for Kubernetes and organize for weekly or daily releases. Learn how the Kubernetes deployment process enables reliable, zero-downtime upgrades.

  For more information, see:
  - [Project design and layout for successful Kubernetes applications (webinar)](https://info.microsoft.com/ww-OnDemandRegistration-successful-kubernetes-applications-webinar.html) <br>
  - [How Kubernetes deployments work (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=mNK14yXIZF4&index=3) <br>
  - [Go through an AKS workshop](/learn/modules/aks-workshop/)

- **Manage application storage.** Understand the performance needs and access methods for pods so that you can provide the appropriate storage options. You should also plan for ways to back up and test the restore process for attached storage.

  To learn more, see:

  - [The basics of stateful applications in Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=GieXzb91I40&index=9) <br>
  - [State and data in Docker applications](/dotnet/architecture/microservices/architect-microservice-container-applications/docker-application-state-data) <br>
  - [Storage options in Azure Kubernetes Service](/azure/aks/operator-best-practices-storage)

- **Manage application secrets.** Don't store credentials in your application code. A key vault should be used to store and retrieve keys and credentials.

  For more information, see:
  - [How Kubernetes and configuration management work (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=vRcQOZLnKUk&index=11) <br>
  - [Understand secrets management in Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=KmhM33j5WYk&index=10) <br>
  - [Using Azure Key Vault with Kubernetes](https://github.com/azure/kubernetes-keyvault-flexvol) <br>
  - [Use Azure AD pod identity to authenticate and access Azure resources](https://github.com/azure/aad-pod-identity)

## Deploy to production and apply best practices

As you prepare the application for production, you should implement a minimum set of best practices. Use the following checklist at this stage. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Can you monitor all aspects of your application?
> - Have you defined resource requirements for your application? How about scaling requirements?
> - Can you deploy new versions of the application without affecting production systems?

<!-- -->

**Checklist:**

- **Configure readiness and liveness health checks.** Kubernetes uses readiness and liveness checks to know when to your application is ready to receive traffic and when it needs to be restarted. Without defining such checks, Kubernetes will not be able to determine whether your application is up and running. To learn more, see [Liveness and readiness checks](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

- **Configure logging, application monitoring, and alerting.** Monitoring your containers is critical, especially when you're running a production cluster, at scale, with multiple applications. The recommended logging method for containerized applications is writing to the standard output (`stdout`) and standard error (`stderr`) streams.

  For more information, see:
  - [Logging in Kubernetes](https://kubernetes.io/docs/concepts/cluster-administration/logging/) <br>
  - [Get started with monitoring and alerting for Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=W7aN_z-cyUw&index=16) <br> [Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview) <br>
  - [Enable and review Kubernetes master node logs in Azure Kubernetes Service (AKS)](/azure/aks/view-control-plane-logs) <br>
  - [View Kubernetes logs, events, and pod metrics in real time](/azure/azure-monitor/containers/container-insights-livedata-overview)

- **Define resource requirements for the application.** A primary way to manage the compute resources within a Kubernetes cluster is using pod requests and limits. These requests and limits tell the Kubernetes scheduler what compute resources a pod should be assigned. For more information, see [Define&nbsp;pod&nbsp;resource&nbsp;requests&nbsp;and&nbsp;limits](/azure/aks/developer-best-practices-resource-management).

- **Configure application scaling requirements.** Kubernetes supports horizontal pod autoscaling to adjust the number of pods in a deployment depending on CPU utilization or other select metrics. To use the autoscaler, all containers in your pods must have CPU requests and limits defined. To learn more, see [Configure horizontal pod autoscaling](/azure/aks/tutorial-kubernetes-scale#autoscale-pods).

- **Deploy applications using an automated pipeline and DevOps.** The full automation of all steps between code commit to production deployment allows teams to focus on building code and removes the overhead and potential human error in manual mundane steps. Deploying new code is quicker and less risky, helping teams become more agile, more productive, and more confident about their running code.

  To learn more, see:
  - [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices/) <br>
  - [Setting up a Kubernetes build pipeline (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=5irsAdKoEBU&index=6) <br>
  - [Deployment Center for Azure Kubernetes Service](/azure/aks/deployment-center-launcher) <br>
  - [GitHub Actions for deploying to Azure Kubernetes Service](/azure/aks/kubernetes-action) <br>
  - [CI/CD to Azure Kubernetes Service with Jenkins](/azure/developer/jenkins/deploy-from-github-to-aks)

## Optimize and scale

Now that the application is in production, how can you optimize your workflow and prepare your application and team to scale? Use the optimization and scaling checklist to prepare. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Are cross-cutting application concerns abstracted from your application?
> - Are you able to maintain system and application reliability, while still iterating on new features and versions?

<!-- docutune:casing Consul -->

**Checklist:**

- **Deploy an API gateway.** An API gateway serves as an entry point to microservices, decouples clients from your microservices, adds another layer of security, and decreases the complexity of your microservices by removing the burden of handling cross-cutting concerns. For more information, see [Use Azure API Management with microservices deployed in Azure Kubernetes Service](/azure/api-management/api-management-kubernetes).

- **Deploy a service mesh.** A service mesh provides capabilities like traffic management, resiliency, policy, security, strong identity, and observability to your workloads. Your application is decoupled from these operational capabilities and the service mesh moves them out of the application layer and down to the infrastructure layer.

  For more information, see:
  - [How&nbsp;service&nbsp;meshes&nbsp;work&nbsp;in&nbsp;Kubernetes&nbsp;(video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=izVWk7rYqWI&index=15) <br>
  - [Learn about service meshes](/azure/aks/servicemesh-about) <br>
  - [Use Istio with Azure Kubernetes Service](/azure/aks/servicemesh-istio-about) <br>
  - [Use Linkerd with Azure Kubernetes Service](/azure/aks/servicemesh-linkerd-about) <br>
  - [Use Consul with Azure Kubernetes Service](/azure/aks/servicemesh-consul-about)

- **Implement site reliability engineering (SRE) practices.** Site reliability engineering (SRE) is a proven approach to maintain crucial system and application reliability while iterating at the speed demanded by the marketplace.

  To learn more, see:
  - [Introduction to site reliability engineering (SRE)](/learn/modules/intro-to-site-reliability-engineering/) <br>
  - [DevOps at Microsoft: game streaming SRE](https://azure.microsoft.com/resources/devops-at-microsoft-game-streaming-sre/)
