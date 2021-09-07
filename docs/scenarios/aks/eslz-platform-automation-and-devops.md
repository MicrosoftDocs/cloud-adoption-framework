---
title: Deployment option considerations for Azure Kubernetes Service (AKS)
description: Learn more about design recommendations and considerations for Azure Kubernetes Service (AKS) platform automation and DevOps.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Deployment option considerations for AKS

As a cloud-native construct, Kubernetes requires a cloud-native approach to deployment and operations. Azure and Kubernetes are open and extensible platforms with rich and well-architected APIs, providing opportunity and ability to automate to the full extent. Plan for a DevOps and highly automated approach by relying on automation and general DevOps best practices.

## Design considerations

Here are some design considerations for AKS platform automation and DevOps:

- Consider the [Azure service limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits) and your continuous integration and continuous delivery (CI/CD) environment when determining your engineering and automation approach. For another example, see the [GitHub usage limitations](https://docs.github.com/actions/reference/usage-limits-billing-and-administration).

- When securing and protecting access to development, test, Q&A, and production environments, consider security options from a CI/CD perspective. Deployments happen automatically, so map access control accordingly.

- Consider using prefixes and suffixes with well-defined conventions to uniquely identify every deployed resource. These naming conventions avoid conflicts in deploying solutions next to each other, and improve overall team agility and throughput.

- Inventory the workflows to support in engineering, updating, and deploying your solution in normal and Digital Rebar Provision (DRP) regimes. Consider mapping pipelines according to those workflows, maximizing familiarity and productivity.

  Some example scenarios and pipelines to consider are:
  - Deploying, patching, and upgrading clusters
  - Deploying and upgrading applications
  - Deploying and maintaining add-ons
  - Failing over for disaster recovery
  - Blue-green deployments
  - Maintaining canary environments

- Consider using a [service mesh](/azure/aks/servicemesh-about) to add more security, encryption, and log capabilities to your workloads.

- Consider deploying other resources like subscriptions, tagging, and labels to support your DevOps experience by tracking and tracing deployments and related artifacts.

- Consider the impact of the *cattle versus pets* paradigm shift. Expect pods and other aspects of Kubernetes to be ephemeral, and align your automation and pipeline infrastructure accordingly. Don't rely on IP addresses or other resources to be fixed or permanent.

## Design recommendations

Here are some design recommendations for AKS platform automation and DevOps:

- Rely on pipelines or actions to:
  - Maximize applied practices across the team.
  - Remove much of the burden of reinventing the wheel.
  - Provide predictability and insights in overall quality and agility.

- Deploy early and often by using trigger-based and scheduled pipelines. Trigger-based pipelines ensure changes go through proper validation, while scheduled pipelines manage behavior in changing environments.

- Separate infrastructure deployment from application deployment. Core infrastructure changes less than applications. Treat each type of deployment as a separate flow and pipeline.

- Deploy using [cloud-native](/dotnet/architecture/cloud-native/introduction) options. Use [infrastructure as code](/devops/deliver/what-is-infrastructure-as-code) to deploy infrastructure including the control plane, and use [Helm](https://helm.sh/) and the [Operator pattern in Kubernetes](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) to deploy and maintain Kubernetes native components.

- Use [GitOps](/azure/azure-arc/kubernetes/tutorial-use-gitops-connected-cluster) to deploy and maintain applications. GitOps uses the Git repository as a single source of truth, avoiding configuration drift and increasing productivity and reliability during rollbacks and related procedures.

- Use [pod-managed identities](/azure/aks/operator-best-practices-identity#use-pod-managed-identities) and [Azure Key Vault provider for Secrets Store CSI Driver](/azure/aks/csi-secrets-store-driver) to protect secrets, certificates, and connection strings.

- Strive for maximized deployment concurrency by avoiding hardcoded configuration items and settings.

- Rely on well-known conventions across infrastructure and application-related deployments. Use [admission controllers](https://kubernetes.io/blog/2019/03/21/a-guide-to-kubernetes-admission-controllers/) combined with the [Azure Policy add-on for Kubernetes](/azure/aks/use-azure-policy) to validate and enforce conventions among the other defined policies.

- Embrace [shift left](/devops/develop/shift-left-make-testing-fast-reliable) consistently with:
  - Security, by adding vulnerability scanning tools like container scanning early in the pipeline.
  - Policy, by using policy as code and enforcing policies in a cloud-native manner through admission controllers.

- Treat every failure, error, or outage as an opportunity to automate and improve overall solution quality. Integrate this approach in your shift left and [site reliability engineering (SRE)](/azure/site-reliability-engineering/) framework.
