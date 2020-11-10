---
title: "Enterprise-Scale platform automation and devops for AKS"
description: Describe how this enterprise-scale scenario can improve platform automation and devops of AKS
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform automation and devops for AKS Enterprise-Scale scenario

## Planning for a DevOps and highly automated approach

Kubernetes is a cloud native construct from the get-go and as such requires a different more [cloud native](https://azure.microsoft.com/overview/cloudnative/) approach in deploying and operating it, by heavily relying on automation and general DevOps best practices. 

Keep in mind that a typical Azure Kubernetes workflow consists out of two different lifecycles, one more geared to the actual operating infrastructure and a second about managening the actual applications. Some teams are doing both while other have dedicated teams for each. The following sections keep those diffrent approaches into account.

### Design considerations

- Consider the [Azure service limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits) and your CI/CD environment, which will determine the approach to take for engineering and automating your solution. For another example, see the [GitHub usage limitations](https://docs.github.com/free-pro-team@latest/actions/reference/usage-limits-billing-and-administration). 

- Consider applying the same security options in securing your CI/CD environment according to the principles provided in the [identity and access managent](/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management) section.

- Consider the various options in storing secrets and other sensitive artifacts. Consider storing those close to your pipeline or storing them in a dedicated secure vault.

- Consider the various workflows to support in engineering and deploying your solution and map your pipelines accordingly. Some example scenarios and pipelines to consider are:
  - Deploying, patching and upgrading clusters
  - Deploying and upgrading applications
  - Deploying and maintaining addons
  - Failing over in case of Disaster Recovery
  - Deploying in Blue/Green fashion
  - Maintaining canary environments 
  
- Consider additional resources to be deployed to support your devops experience. Subscriptions, tagging, labels etc. should be considered to track and trace deployments and related artefacts.  

- Consider the impact of the [cattle versus pets](/dotnet/architecture/cloud-native/definition) paradigm shift and align your automation and pipelines accordingly. As an example, don't rely on IP addresses or other concepts to be fixed and always to be there.

### Design recommendations

- It is recommended to rely on pipelines or actions, maximizing applied practices across the team, removing much of the burden of reinventing the wheel while providing predictability and insights in overall quality and agility.

- Deploy early and often through usage of pipelines based on triggers and on a scheduled basis. The first will assure any change goes through proper validation while the second will tell you more about its behaviour on a changing environment.

- Separate the infrastructure deployment from the actual application deployment. The core infrastructure is expected to change less compared to the applications. It is recommended to treat each type of deployment as a separate flow and pipeline.

- It is recommended to deploy using [cloud native](/dotnet/architecture/cloud-native/introduction) concepts. It is recommended to use [infrastructure as code](/azure/devops/learn/what-is-infrastructure-as-code) for deploying any infrastructure including the control plane and use [Helm](https://helm.sh/) and [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) for deploying and maintaining Kubernetes native components.

- It is recommended to use [GitOps](/azure/azure-arc/kubernetes/use-gitops-connected-cluster) for deploying and maintaining applications. With GitOps, the git repository is used as a single source of truth, avoiding configuration drift, increasing productivity and reliability in case of rollbacks and related procedures.

- It is recommended to store secrets and other sensitive artifacts needed to deploy the solution in GitHub secrets allowing actions and other workflow parts to read them if needed while executing.

- Strive for maximized deployment concurrency by avoiding hardcoded configuration items and settings, instead rely on well known conventions across infrastructure and application related deployments. It is recommended to use [admission controllers](https://kubernetes.io/blog/2019/03/21/a-guide-to-kubernetes-admission-controllers/) to validate and enforce those conventions.

- Treat every failure, error, or outage as an opportunity to automate and improve the overall quality of the solution. It is recommended to integrate this approach in your [Shift Left](/azure/devops/learn/devops-at-microsoft/shift-left-make-testing-fast-reliable) and [Site Reliability Engineering (SRE)](/azure/site-reliability-engineering/) framework. Azure and Kubernetes are both an open and extensible platform with a rich, and well architected API, providing an opportunity and means to automate it to the full extent. 
