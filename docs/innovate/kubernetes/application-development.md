---
title: Application development and deployment
description: Learn about site reliability engineering (SRE) by using Kubernetes in the Cloud Adoption Framework for application development and deployment.
author: sabbour
ms.author: martinek
ms.date: 04/02/2021
ms.topic: conceptual
ms.custom: think-tank, seo-caf-innovate
keywords: application development, application deployment, site reliability engineering
---

# Application development and deployment

Examine patterns and practices of application development, configure Azure Pipelines, and implement site reliability engineering (SRE) best practices. SRE is a software engineering approach to application development and deployment, change management, monitoring, and emergency response.

## Plan, train, and proof

Use the following checklist and application development resources to plan your application development and deployment. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Have you prepared your application development environment and setup workflow?
> - How will you structure the project folder to support Kubernetes application development?
> - Have you identified the state, configuration, and storage requirements of your application?

<!-- docutune:casing "AAD Pod Identity" -->

### SRE checklist

- **Prepare your development environment.** Configure your environment with the tools to create containers and set up your development workflow.

  For more information, see:
  - [Working with Docker in Visual Studio Code](https://code.visualstudio.com/docs/containers/overview)
  - [Working with Kubernetes in Visual Studio Code](https://code.visualstudio.com/docs/azure/kubernetes)
  - [Bridge to Kubernetes overview](/visualstudio/bridge/overview-bridge-to-kubernetes)

- **Containerize your application.** Familiarize yourself with the end-to-end Kubernetes development experience, including application scaffolding, inner-loop workflows, application management frameworks, CI/CD pipelines, log aggregation, monitoring, and application metrics.

  To learn more, see:
  - [Get up and running with Kubernetes (e-book collection)](https://azure.microsoft.com/resources/kubernetes-ebook-collection/)
  - [Containerize Your Applications with Kubernetes on Azure (webinar)](https://info.microsoft.com/AU-AzureApp-WBNR-FY20-11Nov-12-ContainerizeYourApplicationswithKubernetesonAzure-SRDEM10557_LP02OnDemandRegistration-ForminBody.html)

- **Review common Kubernetes scenarios.** Kubernetes is often thought of as a platform for delivering microservices, but it's becoming a broader platform. For more information about common Kubernetes scenarios, such as batch analytics and workflow, see [Overview of common Kubernetes scenarios (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=zd8vYhrFXp4&index=7).

- **Prepare your application for Kubernetes.** Prepare your application file system layout for Kubernetes and organize for weekly or daily releases. Learn how the Kubernetes deployment process enables reliable, zero-downtime upgrades.

  For more information, see:
  - [How Kubernetes deployments work (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=mNK14yXIZF4&index=3)
  - [Develop and deploy applications on Kubernetes](/training/paths/develop-deploy-applications-kubernetes/)

- **Manage application storage.** Understand the performance needs and access methods for pods so that you can provide the appropriate storage options. Plan for ways to back up and test the restore process for attached storage.

  To learn more, see:

  - [Basics of stateful applications in Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=GieXzb91I40&index=9)
  - [State and data in Docker applications](/dotnet/architecture/microservices/architect-microservice-container-applications/docker-application-state-data)
  - [Storage options in Azure Kubernetes Service](/azure/aks/operator-best-practices-storage)

- **Manage application secrets.** Use a key vault to store and retrieve keys and credentials. Don't store credentials in your application code.

  For more information, see:
  - [How Kubernetes and configuration management works (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=vRcQOZLnKUk&index=11)
  - [Understand secrets management in Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=KmhM33j5WYk&index=10)
  - [Use Azure Key Vault with Kubernetes](https://github.com/Azure/secrets-store-csi-driver-provider-azure)
  - [Use Microsoft Entra Workload ID to authenticate and access Azure resources](https://azure.github.io/azure-workload-identity/docs)

## Deploy to production and apply best practices

As you prepare the application for production, use the following checklist. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Can you monitor all aspects of your application?
> - Have you defined resource requirements for your application? How about scaling requirements?
> - Can you deploy new versions of the application without affecting production systems?

<!-- -->

### SRE best practices checklist

- **Configure readiness and liveness health checks.** Kubernetes uses readiness and liveness checks to know when your application is ready to receive traffic and when it needs to be restarted. When you don't define checks, Kubernetes can't determine if your application is running. For more information, see [Liveness and readiness checks](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

- **Configure logging, application monitoring, and alerting.** Monitoring your containers is critical, especially when you run a production cluster, at scale, with multiple applications. The recommended logging method for containerized applications is to write to the standard output (`stdout`) and standard error (`stderr`) streams.

  For more information, see:
  - [Logging in Kubernetes](https://kubernetes.io/docs/concepts/cluster-administration/logging/)
  - [Get started with monitoring and alerting for Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=W7aN_z-cyUw&index=16)
  - [Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview)
  - [Enable and review Kubernetes control plane logs in Azure Kubernetes Service (AKS)](/azure/azure-monitor/containers/container-insights-log-query#resource-logs)
  - [View Kubernetes logs, events, and pod metrics in real time](/azure/azure-monitor/containers/container-insights-livedata-overview)

- **Define resource requirements for the application.** A primary way to manage the compute resources within a Kubernetes cluster is to use pod requests and limits. These requests and limits tell the Kubernetes scheduler what compute resources to assign to a pod. For more information, see [Define pod resource requests and limits](/azure/aks/developer-best-practices-resource-management#define-pod-resource-requests-and-limits).

- **Configure application scaling requirements.** Kubernetes supports horizontal pod autoscaling to adjust the number of pods in a deployment depending on CPU utilization or other select metrics. To use the autoscaler, all containers in your pods must have CPU requests and limits defined. To learn more, see [Configure horizontal pod autoscaling](/azure/aks/tutorial-kubernetes-scale#autoscale-pods).

- **Deploy applications by using an automated pipeline and DevOps.** The full automation of all steps between code commit to production deployment allows teams to focus on building code and removes the overhead and potential human error in manual steps. Deploying new code is quicker and less risky, which helps teams become more agile, more productive, and more confident about their running code.

  To learn more, see:
  - [Evolve your DevOps practices](/training/paths/evolve-your-devops-practices/)
  - [Setting up a Kubernetes build pipeline (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=5irsAdKoEBU&index=6)
  - [Deployment Center for Azure Kubernetes Service](/azure/aks/deployment-center-launcher)
  - [GitHub Actions for deploying to Azure Kubernetes Service](/azure/aks/kubernetes-action)
  - [Tutorial: Deploy from GitHub to Azure Kubernetes Service using Jenkins](/azure/developer/jenkins/deploy-from-github-to-aks)

## Optimize and scale

Now that the application is in production, use the application deployment checklist to optimize your workflow and prepare your application and team to scale. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Are cross-cutting application concerns abstracted from your application?
> - Are you able to maintain system and application reliability, while still iterating on new features and versions?

### Application deployment checklist

- **Deploy an API gateway.** An API gateway serves as an entry point to microservices, decouples clients from your microservices, adds another layer of security, and decreases the complexity of your microservices by removing the burden of handling cross-cutting concerns. For more information, see [Use Azure API Management with microservices deployed in Azure Kubernetes Service](/azure/api-management/api-management-kubernetes).

- **Deploy a service mesh.** A service mesh provides capabilities to your workloads, like traffic management, resiliency, policy, security, strong identity, and observability. Your application is decoupled from these operational capabilities, and the service mesh moves them out of the application layer and down to the infrastructure layer.

  For more information, see:
  - [How service meshes work in Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=izVWk7rYqWI&index=15) <br>
  - Learn about [service meshes](/azure/aks/servicemesh-about)
  - [Use Open Service Mesh with Azure Kubernetes Service](/azure/aks/open-service-mesh-about)
  - [Use Istio with Azure Kubernetes Service](/azure/aks/servicemesh-about)
  - [Use Linkerd with Azure Kubernetes Service](/azure/aks/servicemesh-about)
  - [Use Consul with Azure Kubernetes Service](/azure/aks/servicemesh-about)

- **Implement SRE practices.** SRE is a proven approach that maintains crucial system and application reliability and iterates at the speed that the marketplace demands.

  To learn more, see:
  - [Introduction to site reliability engineering (SRE)](/training/modules/intro-to-site-reliability-engineering/)
  
