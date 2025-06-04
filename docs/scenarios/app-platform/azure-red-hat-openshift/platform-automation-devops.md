---
title: Plan platform automation and DevOps for Azure Red Hat OpenShift
description: Design recommendations and considerations for Azure Red Hat OpenShift platform automation and DevOps.
author: Zimmergren
ms.author: pnp
ms.date: 08/16/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-aks, linux-related-content
---

# Plan platform automation and DevOps for Azure Red Hat OpenShift

Get design considerations and recommendations for platform automation and DevOps for the Azure Red Hat OpenShift landing zone accelerator. Rely on automation and general DevOps best practices to plan your highly automated, DevOps platform for Azure Red Hat OpenShift.

## Design considerations

As you plan platform automation and DevOps for your Azure Red Hat OpenShift landing zone accelerator, include these design considerations:

- Consider the [Azure service limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits) and your continuous integration and continuous delivery (CI/CD) environment when you choose an engineering and automation approach. For an example, see the [GitHub usage limitations](https://docs.github.com/actions/reference/usage-limits-billing-and-administration).

- When you secure and protect access to development, test, Q&A, and production environments, evaluate security options from a CI/CD perspective. Deployments happen automatically, so map access control accordingly.

- Consider using prefixes and suffixes that follow well-defined conventions to uniquely identify each deployed resource. Naming conventions avoid conflicts when you deploy adjacent solutions, and they help improve overall team agility and throughput.

- Inventory your workflows to help you engineer, update, and deploy your solution both in normal and in Digital Rebar Provision scenarios. To maximize familiarity and productivity, consider mapping pipelines to workflows.

  Examples include:

  - Cluster deployment and upgrades
  - Application deployment and upgrades
  - Disaster recovery failover
  - Blue-green deployments
  - Canary environment maintenance

- Consider deploying [Azure Arc-enabled Open Service Mesh](/azure/azure-arc/kubernetes/tutorial-arc-enabled-open-service-mesh) to add more security, encryption, and log capabilities to your workloads.

- Consider deploying other resources, like subscriptions, tagging, and labels to support your DevOps experience. Use these resources to track and trace deployments and related artifacts.

- Consider the effect of the *cattle versus pets* DevOps paradigm shift. Expect pods and other aspects of Kubernetes to be ephemeral, and align your automation and pipeline infrastructure accordingly. Don't rely on IP addresses or other resources to be fixed or permanent.

## Design recommendations

Use these design recommendations to plan your platform automation and DevOps for Azure RedHat OpenShift:

- Use pipelines or actions to:

  - Maximize applied practices across the team.
  - Remove much of the burden of new development.
  - Provide predictability and insight in overall quality and agility.

- Deploy early and often by using trigger-based and scheduled pipelines. Trigger-based pipelines ensure that changes go through proper validation. Scheduled pipelines manage behavior in changing environments.

- Separate infrastructure deployments from application deployments. Core infrastructure changes less frequently than applications. Treat each type of deployment as a separate workflow and pipeline.

- Deploy by using [cloud-native](/dotnet/architecture/cloud-native/introduction) options. Use [infrastructure as code](/devops/deliver/what-is-infrastructure-as-code) to deploy infrastructure. Use [Helm](https://helm.sh/) and the [Operator pattern in Kubernetes](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) to deploy and maintain Kubernetes-native components.

- Use [GitOps](/azure/azure-arc/kubernetes/conceptual-gitops-flux2-ci-cd) to deploy and maintain applications. GitOps uses the Git repository as a single source of truth. You can avoid configuration drift and increase productivity and reliability during rollbacks and related procedures.

  Also consider using [Red Hat OpenShift GitOps](https://docs.openshift.com/container-platform/4.10/cicd/gitops/understanding-openshift-gitops.html). Red Hat OpenShift GitOps uses Argo CD to maintain cluster resources and support application CI/CD.

- Use [Azure Key Vault Provider for Secrets Store CSI Driver](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider) to protect secrets, certificates, and connection strings.

- Maximize deployment concurrency by avoiding hard-coded configuration items and settings.

- Rely on well-known conventions across infrastructure deployments and application-related deployments. Use [admission controllers](https://kubernetes.io/blog/2019/03/21/a-guide-to-kubernetes-admission-controllers/) with [Azure Policy extension for Azure Arc-enabled Kubernetes (preview)](/azure/governance/policy/concepts/policy-for-kubernetes) to validate and enforce conventions and other defined policies.

- Embrace a [shift-left](/devops/develop/shift-left-make-testing-fast-reliable) DevOps approach consistently through security and policy:

  - **Security:** Add vulnerability-scanning tools like container scanning early in the pipeline.
  - **Policy:** Use policy as code and enforce policies as cloud-native by using admission controllers.

- Treat every failure, error, or outage as an opportunity to automate and improve overall solution quality. Integrate this approach in your shift left and [site reliability engineering](/azure/site-reliability-engineering/) framework.

## Next steps

- [Review your environment or Azure landing zones](../ready.md)
- [Plan for modern application platform](../plan.md)
