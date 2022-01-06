---
title: CI/CD workflow using GitOps
description: Understand the design considerations and recommendations for CI/CD workflow using GitOps of Azure Arc-enabled Kubernetes.
author: jpocloud
ms.author: jpocloud
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid, think-tank
---

# CI/CD workflow using GitOps for Azure Arc-enabled Kubernetes

As a cloud-native construct, Kubernetes requires a cloud-native approach to deployment and operations. With GitOps, you declare the desired state of your container based deployments in files stored in Git repositories. Kubernetes operators run in the clusters and continually reconcile the cluster state with the desired state declared in the Git repository. These operators pull the files from the Git repositories and apply the desired state to the clusters. The operators also continuously assure that the cluster remains in the desired state.

By implementing GitOps, you can achieve some of the following benefits:

- Improve overall visibility into the Kubernetes cluster state and configuration.
- Have a simple audit and version history of changes to your cluster through Git change history which shows who made changes, when those changes were been made, and why.
- Automatic correction of drift that can occur to your cluster to match the desired cluster state defined in your Git repository.
- Ability to roll back the Kubernetes configuration to a previous version, using Git revert or Git rollback commands. Cluster deployments re-creation for disaster recovery scenarios also becomes a fast and straight forward process because your Kubernetes desired cluster configuration is stored in Git.
- Improve security by reducing the amount of service accounts that are required to have deployment permission to your cluster.
- Implement a CI/CD pipeline for deploying applications to your cluster.

## Architecture

The following image show a conceptual reference architecture that highlights the Flux cluster extension installation provisioning in your cluster and GitOps configuration process for an Azure Arc-enabled Kubernetes cluster.

![GitOps Flow](../../media/azure-arc-enabled-kubernetes-gitops-flow.png)

## Design considerations

The following are some design considerations before implementing the Flux extension and a GitOps Configuration to Azure Arc-enabled Kubernetes:

### Configuration Repository Structure

Before defining your cluster configuration repository, consider the different layers of configuration on your Kubernetes cluster and different responsibilities for provisioning these different layers of configurations.

#### Configuration layers

- Application configuration needed to deploy an application and its related Kubernetes objects to the cluster such as Deployment, Service, HPA, and ConfigMap resources.
- Cluster-wide components such as an Ingress Controller, Monitoring stack, and various agents that operate across the cluster.
- Cluster-wide configuration for creation of Kubernetes objects such as Namespaces, ServiceAccounts, Roles and RoleBindings, and other cluster wide policies.

#### Responsibilities

- Application Developers are responsible for pushing their source code, triggering builds, and creating container images.
- Application Operators are responsible for maintaining the application repositories, configurations, environment variables, app-specific helm charts, Kustomizations etc.
- Cluster Operators are responsible for setting up the cluster baseline. They would typically be concerned with setting up cluster wide components and policies. They maintain a directory or directories which contain common infrastructure tools such as namespaces, service accounts, role bindings, CRDs, cluster-wide policies, ingress components, etc.

#### Repository Structure

Consider different tradeoffs with how you choose a Git repository structure that will define your Kubernetes cluster state.  Depending on the responsibilities and personas identified, it is important to consider the necessary collaboration or desired team independence required for different repository structure options.

For your code repositories, you can use whatever branching strategy you like since it is only used for your CI. For your GitOps configuration repositories, you need to consider the following strategies based on your organization size and tooling:

- Single repository (Branch per environment):
  - This allows the most flexibility to control Git policies and permissions for each branch that represents an environment.
  - The drawback is that there will be no sharing of the common config among environments since tooling such as [Kustomize](https://kubernetes-sigs.github.io/kustomize/) does not work with Git branches.
- Single repository (Directory per environment):
  - As an example, this approach can be implemented using Kustomize which allows you to define a base configuration for Kubernetes objects and a set of overlays for an environment that override configurations in the base.
  - This can reduce duplicating YAML files for each environment but reduces the configuration separation between environments. Making a single change to the repository has the potential to impact all environments at once, so understanding the impact of changes to base folders must be fully understood and taken with care.
- Multiple repositories (each serving a specific purpose):
  - This could be used for separating configuration repositories for each application, team, layer, or tenant.
  - This allows teams to have more independent control but moves away from the principle of defining your system state in a single repository to improve the central configuration, visibility and control of deployments to a cluster.
  - Setting up multiple repositories should be considered for multi-tenancy needs. There is RBAC and security built-in to limit what configuration a team/tenant assigned to a specific repository can apply, such as only allowing deployment to certain namespaces.

### Application & Platform Configuration

Platform Operators and Application Operators have several options for managing Kubernetes configuration, the following are choices:

- Raw Kubernetes YAML files that represent YAML specs for each Kubernetes API object you are deploying, this approach works well for single environments. The drawbacks to using raw YAML files is that customizing becomes difficult when you begin to incorporate multiple environments as you need to then duplicate YAML files, and there is not a good method of re-use.
- (Helm)[https://helm.sh/] is a package management tool for Kubernetes objects. It’s a great option for Cluster Operators to install third-party off-the-shelf applications. Be aware of using its templating too heavily as a configuration management tool for internal applications as it can become complex to manage as the templates grow.
  - If using Helm Flux has the Helm Controller, allowing one to declaratively manage Helm Chart releases with Kubernetes manifests. You can create a HelmRelease object to manage that process.
- Kustomize is a Kubernetes native configuration management tool and introduces a template-free way to customize application configuration.
  - If using Kustomize, flux has a kustomize-controller which specialized in running continuous delivery pipelines for infrastructure and workloads defined with Kubernetes manifests and assembled with Kustomize. You can create a Kustomization object to manage that process.
- With Azure Arc-enabled Kubernetes, there is a list of available extensions which become managed and supported by Microsoft instead of requiring you to manage the lifecycle and support of the component. Some of these have Open-Source alternative options, an example of this is the Azure Key Vault Secrets Provider. Managing it outside of the extension process allows you more control of these components but adds additional overhead of support and lifecycle management.

### CI/CD Flow

#### Application pipeline

- Consider the necessary application build, testing, and validations that you want to include in your Continuous Integration process. This can include linting and testing related to security, integration and performance which are required to create a release candidate for environment deployments.
- For bridging the gap between a built container image in a CI pipeline to being deployed on a cluster, a traditional push deployment method would be done by calling the Kubernetes API directly from the deployment pipeline.
- With a GitOps process, to avoid manual configuration modifications to your GitOps repository, the CD pipeline can have permission or run as a service account which then has permission to open a Pull Request or commit directly to an configuration repository with the new container image change. These changes from your CD pipeline can also provision all YAML objects required for your application.

![GitOps CI](../../_images/gitops_ci.png)

#### Cluster-wide component update process

- As Cluster Operators need to manage cluster-wide components, this likely will not originate from a CD pipeline. Consider defining a promotion process for Cluster Operators to ensure changes can smoothly transition from one environment to another.
- In scenarios where you need to apply identical GitOps configuration at scale to your Arc-enabled Kubernetes clusters, you can consider applying an Azure Policy which can automatically install the Flux extension and apply the GitOps configuration to existing Arc-enabled Kubernetes clusters or new clusters as they get onboarded to Azure Arc.

For all updates to your configuration, to verify changes have been successfully applied to your desired environment, consider defining notifications in Flux to integrate to your CI/CD tools, email, or ChatOps tools to alert on successful changes as well as deployment failures.

### Security

#### Repository Auth

- A Public or private repository can be used with GitOps, but due to the sensitive nature of Kubernetes configuration, a private repository that requires Authentication by SSH key or API key should be considered. GitOps will also work with a Git repository that is only accessible within an internal network as long as the Kubernetes cluster can access it, but this will limit your ability to use cloud based Git providers such as Azure DevOps Repos or GitHub.
- HTTPS or SSH: when choosing between HTTPS or SSH for connecting to your source control tool, both protocols offer a reliable and secure connection. However, HTTPS is often times easier to set up and uses a port that usually does not require additional open ports in your firewalls.

#### Repo and Branch security

- Set branch permissions and policies on your configuration repository. As your Git repo becomes the central piece of your Kubernetes deployments, it is key to set up permissions to control who can read and update the code in a branch as well as implement policies to enforce your team's code quality and change management, otherwise the GitOps workflow can ship code that is not up to your organizations standards.
- PR Pipelines can work with your branch policies to validate YAML configuration and/or deploy test environments as required. These gates will help eliminate configuration errors and increase deployment security and confidence.
- For access permission, consider which users in your organization should have repository read access, PR creation access, and PR Approval access.

#### Secret Management

- Avoid storing plain text or base64 encoded secrets in your Git repository, instead consider integrating to an external secrets provider such as Azure Key Vault. The [Azure Key Vault Provider for Secrets Store CSI Driver](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider) allows for the integration of an Azure key vault as a secrets store with an Azure Kubernetes Service (AKS) cluster via a CSI volume. This is available through Azure Arc-enabled Kubernetes extension.
- Another alternative to manage secrets, is to use [Bitnami's Sealed Secrets](https://Github.com/bitnami-labs/sealed-secrets/releases), which works on the concept of public and private keys. This allows operators to store the one-way encrypted secret using a public key in Git, which can only be decrypted by the private key which is used by a SealedSecrets controller running in your cluster.

## Design Recommendations

The following image is a reference architecture that shows the responsibilities, repositories, and pipelines to implement a GitOps process using the Azure Arc-enabled Kubernetes Flux Extension(/azure/azure-arc/kubernetes/tutorial-use-Gitops-flux2).

![GitOps CI](../../_images/eslz-cicd-flow.png)

### Repositories

The following three Git repositories are included in the design:

- Application code repository:
  - This repository stores application code and any pipeline definition and configuration scripts.
  - Use a development branching strategy that is easy to understand and limits the amount of undesired long running branches.
- Application configuration repository:
  - This repository is used to store application configuration including Kubernetes objects such as ConfigMaps, Deployments, Services, and HPA objects. Structure the repository with different folders for each application. Flux will synchronize changes from this repository and target branch, to the cluster.
  - Incorporate tools that make it easier for application developers and operators to build initial configuration per environment. Application Operators should define Kubernetes specific application configuration that take advantage of package managers such as Helm or configuration tools like Kustomize overlays to make configuration simpler.
  - Create a branch that represents each environment type. This will allow fine grain control of changes into each specific environment such as non-prod and production environments.
- Cluster-wide configuration repository:
  - Define cluster-wide components that a Cluster Operator will manage such as ingress controller, namespaces, RBAC, and a monitoring stack. Flux will synchronize changes from this repository and target branch, to the cluster.
  - Structure the repository with different folders representing different components.
  - Create a branch that represents each environment type. This will allow fine grain control of changes into each specific environment such as non-prod and production environments.

###	CI/CD and Configuration Update Process

#### CI/CD, Container Image Update

- CI Pipeline
  - Development teams should define a CI pipeline with a process that includes building, linting, testing, and pushing an application to a container registry.
- CD Pipeline
  - Create a CD pipeline that runs a script which targets  changes against your application configuration repository. This script creates a temporary branch sourced from your target environment, makes a change to the image tag version, commits the change, and opens a pull request against the target environment branch. This CD pipeline can have environment stages with appropriate environment variables that target the correct GitOps Configuration repository and branch.
  - Define manual approval steps on environment stages to limit unwanted pull requests to all environments.
- Branch policies can be enabled on the application configuration repository to enforce peer review or approvals for environments. This can be a minimum number of required reviews or auto-approval for lower environments. Additionally consider 3rd party integrations and approvals as necessary to meet any organization standards.

#### Cluster-wide and Application Configuration updates

- Cluster Operators and Application Operators will each be defining configuration in their respective configuration repository. These users will not require pipeline tooling to push configurations, and instead can use the native Git commit and PR processes to define configuration and push the changes to a branch that represents an environment.
- For new configuration definitions, start with defining configuration in lower environments, such as Dev and promote to higher environments by merge and pull request. Cherry-pick configuration updates that are only specific to certain environments as needed.
- For implementing at-scale GitOps Configurations which require a Kubernetes configuration to be applied to all Arc-enabled Kubernetes clusters, create an Azure Policy to automatically apply this configuration at scale.

### Feedback and alerting

- Configure Azure Monitor alerts to alert on GitOps configurations that are unable to synchronize or are erroring.
- Implement [GitOps Connector](https://Github.com/microsoft/Gitops-connector) to integrated feedback from the Flux agent to your CI/CD tooling.
  
### Security

- Review (recommendations for security and governanvce)[./governance-diciplines.md] of your Azure Arc-enabled Kubernetes clusters.
- It is recommended to use a private Git repository that has authentication and authorization required for defining any configuration repository, this will ensure unwanted access to any cluster configuration.
- Access the Git repository through SSH protocol and an SSH key if your Git provider supports it. In scenarios where SSH is unusable due to outbound connectivity restrictions or your Git provider does not support the required SSH libraries, it is recommended to use a dedicated service account and associate an API key with the account for Flux to use.
- Configure branch policies and permissions that match the responsibilities of the cluster, with a minimum amount of reviewers to approve changes.
- Configure a PR pipeline to validate YAML configurations, syntax, and optionally deploy a test cluster. Setup a branch policy to require this pipeline to run successful before any merge can be accepted.
- Implement secrets using the [Azure Key Vault Provider for Secrets Store CSI Driver](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider), this will allow for the integration of an Azure Key Vault as a secrets store with an Arc-enabled Kubernetes cluster via a CSI volume.
- The Flux extension supports namespace and cluster scoped configurations, choose the namespace scope when a configuration should not have access beyond a single namespace.

## Next steps

For more guidance for your hybrid cloud adoption journey,  review the following:

- To learn more about GitOps with Azure Arc on Kubernetes, check out the [Conceptual GitOps with Fluxv2](/azure/azure-arc/kubernetes/conceptual-Gitops-flux2)
- To learn more about GitOps with Azure Arc on Kubernetes, check out the [Use GitOps with Fluxv2](/azure/azure-arc/kubernetes/tutorial-use-Gitops-flux2)
- To learn more about GitOps with Azure Arc on Kubernetes, check out the [Conceptual GitOps Fluxv2 CI/CD Process](/azure/azure-arc/kubernetes/conceptual-Gitops-flux2-ci-cd)
- To learn more about GitOps with Azure Arc on Kubernetes, check out the [Tutorial to implement Fluxv2 CI/CD](/azure/azure-arc/kubernetes/tutorial-Gitops-flux2-ci-cd)
