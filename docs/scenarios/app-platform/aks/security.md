---
title: Security for Azure Kubernetes Service (AKS)
description: Learn more about the cloud security control lifecycle and how to set up AKS security controls, Azure Policy, and AKS cost management.
author: Zimmergren
ms.author: pnp
ms.date: 03/24/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# Security for AKS

This article walks you through aspects of Azure Kubernetes Service (AKS) security governance to consider before you implement any solution.

The article focuses on how to implement solutions by using Azure and open-source software. The decisions you make when you create an enterprise-scale landing zone can partially predefine your governance. To understand governance principles, see [Enterprise-scale security governance and compliance](../../../ready/landing-zone/design-area/governance.md).

## Attack surfaces

Consider the following five attack surfaces when you create a security strategy for Kubernetes clusters:

- Build
- Registry
- Cluster
- Node
- Application

For each category, we discuss the major risks to consider and countermeasures for those risks.

### Build security

Build security is about the proper use of DevSecOps with container images.

#### Major risks

Poor image configuration can lead to security vulnerabilities down the pipeline. For example, you might have containers running with greater privileges than they need. The containers might also be configured to allow certain network access, which might put the system at risk. Not limiting the allowed system calls to those calls required for the safe operation of containers can increase risk from a compromised container.

Another vulnerability could be allowing the container to get access to a sensitive directory of the host or allowing the containers to change the locations that control the basic function of the host.

Rogue containers are unplanned containers in an environment. They can be the result of developers testing their code in test environments. These containers might not have gone through rigorous scanning for vulnerabilities or be properly configured. These vulnerabilities might open up an entry point for attackers.

Using base images that aren't from trusted sources or aren't up to date with security updates can also lead to vulnerabilities in the containers they use to build.

#### Risk countermeasures

Build security is about the implementation of DevSecOps to shift security left and remediate most issues before they start moving down the pipeline. It's not about putting all the ownership on developers, but sharing the ownership with operations. Developers can then see and remediate vulnerabilities and compliance issues that they can actually address.

You can build a pipeline that scans and fails builds because it has one or 10 critical vulnerabilities. A better approach might be to look at the next layer down. You can start to segment the point of responsibility based on vendor status.

Set a threshold at the status layer of the vulnerability. Anything with a status of *Open*, *Will not fix*, or *Deferred* continues to flow down the pipeline where SecOps can access the risk, as they do today. A vulnerability with the status of *Vendor fixes available* is something a developer can address. Use of grace periods allows time for developers to remediate vulnerabilities.

Along with the vulnerability assessment is the compliance assessment. For example, allowing an image to *Run as root* or exposing SSH breaks the compliance posture of most enterprises. Address this issue during build instead of during deployment.

Typically, you scan your images against the Docker CIS benchmark. When you use these types of flows, you won't break development by introducing security remediation, but you can improve your enterprise's security posture overall inline.

Use of a tool that enables these capabilities is critical to effectively implement the right strategy for your enterprise. Traditional tools are often unable to detect vulnerabilities within containers, which can lead to a false sense of security. Tools that take the pipeline-based build approach and the immutable and declarative nature of container technologies into consideration are needed to properly secure your container ecosystem.

These tools should have the following properties:

- Integration with the entire lifetime of the images, from the beginning of the build process to the registry to the runtime.
- Visibility into vulnerabilities at all layers of the image, including the base layer of the image, application frameworks, and custom software.
- Policy-driven enforcement with the right level of granularity, which allows your organization to create quality gates at each stage of the build and deployment processes.

### Registry security

Registry security is about:

- Drift control from build.
- Prevention of push/pull of contaminated images.
- Image signing.

#### Major risks

Images often contain proprietary information, including an organization's source code. If connections to registries aren't appropriately secure, the content of an image could pose confidentiality risks as severe as any other form of data transmitted within your organization. Stale images with vulnerable out-of-date versions in the registry can increase security risks if they're accidentally deployed.

Another security vulnerability might include insufficient authentication and authorization restrictions to container registries. These registries might house sensitive proprietary assets in the images.

As content is built and deployed, the distribution of this content is one of many attack vectors. How do you make sure that the content staged for distribution is the same content that's delivered to an intended endpoint?

#### Risk countermeasures

Set up deployment processes to ensure that development tools, networks, and container runtimes are connected to registries only over encrypted channels. Also, be sure that the content comes from a trusted source. To reduce risks from the use of stale images:

- Remove unsafe, vulnerable images that should no longer be used from container registries.
- Enforce accessing images by using immutable names that specify particular versions of images to be used. You can implement this configuration by using a *latest* tag or a specific version of the images. A tag doesn't guarantee freshness. For this reason, put a process in place to ensure that the Kubernetes orchestrator is using the most recent unique numbers or that the *latest* tag represents the most up-to-date versions.

Access to registries that contain sensitive images should require authentication and authorization. All write access should also require authentication. For example, your policy could allow developers to only push images to the specific repositories for which they're responsible.

Access to these registries should be federated and take advantage of business-line-level access policies. For example, you can configure your CI/CD pipeline to push images to repositories only after they've passed vulnerability scanning compliance assessment and quality control tests.

Container registries now considered artifact registries are becoming a primary means to deploy any content type, not just container images. Every cloud provides a registry with open-source projects and vendor products that are available for on-premises or private hosting within cloud providers. Content is promoted within and across registries from their initial build to their production deployment.

How can you ensure the integrity of the content that went into the registry is the same content that comes out of the registry? Adopting an image signing solution makes sure that deployments are only coming from trusted registries and are deploying trusted content.

### Cluster security

Cluster security is about:

- Authentication and authorization.
- Network security.
- Vulnerability and compliance management.

#### Major risks

Sometimes a single Kubernetes cluster might be used to run different applications managed by different teams with different access-level requirements. If access is provided to individuals without restrictions or only according to their needs, a malicious or careless user could compromise workloads they have access to and other assets on the cluster.

Another security vulnerability might occur when the cluster's own user directory manages authorization and authentication. An organizational authentication directory is often more rigorously controlled. Because these accounts are highly privileged, and more often orphaned, the chances of a compromised account increase.

This scenario could lead to cluster or even systemwide vulnerabilities. Data stored by container volumes is managed by orchestrators, which must have access to the data no matter which node it's hosted on.

Traditional network filters might have a security blindness because of a network overlay designed to encrypt data in transit. This design makes it difficult to monitor traffic within the cluster, so special provisions might be required to monitor Kubernetes clusters.

Traffic from different applications that share the same cluster might have different sensitivity levels, such as a public-facing website and an internal application running critical sensitive business processes. Sharing the same virtual network within the cluster can lead to compromised sensitive data. For example, an attacker might use the shared network exposed to the internet to attack the internal applications.

Protect components running the cluster itself from vulnerabilities and compliance issues. Make sure that you're running on the latest possible version of Kubernetes to take advantage of the remediation.

#### Risk countermeasures

Kubernetes cluster user access should use a least-privilege access model. Only grant users access to perform specific actions on specific hosts, containers, and images that are required for them to do their jobs. Testing team members should have limited or no access to containers in production. User accounts with cluster-wide access should be tightly controlled and used sparingly.

Use strong authentication methods like multifactor authentication to secure access to these accounts. An organization user directory should be used to manage clusters via single sign-on as opposed to cluster-specific user accounts that might not have the same level of policies and controls.

Use encryption methods that allow containers to properly access data whatever host the containers are running on. These encryption tools should prevent unauthorized access to data by other containers even within the same node that shouldn't have access to them.

Configure Kubernetes clusters to separate network traffic into discrete virtual networks or subnets by sensitivity level. Per-application segmentation might also be possible, but defining networks by sensitivity levels might be sufficient. For example, virtual networks for customer-facing applications separated from those serving internal applications with sensitive traffic should be implemented at a minimum.

You can use taints and tolerances to isolate deployments to specific sets of nodes by sensitivity levels. Avoid hosting highly sensitive workloads within the same node as those workloads with lower sensitivities. Using separate managed clusters is a safer option.

Segment containers by purpose, sensitivity, and thread posture to provide extra protection for sensitive workloads. By segmenting containers this way, it's more difficult for an attacker who has gained access to one segment to gain access to other segments. This configuration has the added advantage of ensuring residual data, such as caches or volume mounts, are isolated by sensitivity level.

Kubernetes clusters should be configured to:

- Provide a secure environment for applications that run on them.
- Ensure nodes are securely added to the cluster.
- Have persistent identities to help ensure security throughout their lifecycle.
- Provide live, accurate information on the state of the cluster, including networking and the nodes within it.

It must be easy for a compromised node to be isolated and removed from the cluster without affecting the performance of the cluster. AKS makes that simple.

Define container runtime configuration standards to automatically ensure compliance. There are many policies within Azure that makes this process easy, and users can create their own policies too. Use Azure security features to continuously assess configuration settings across the environment and actively enforce them.

Automatically ensure that vulnerabilities of the Kubernetes components are being addressed. Use separate environments for development, test, and production, each with their own controls and role-based access control (RBAC) for container management. Associate all container creation with individual user identities and it should be logged for auditing. This configuration helps to reduce the risk of rogue containers.

### Node security

Node security is about:

- Runtime protection.
- Vulnerability and compliance management.

#### Major risks

A worker node has privileged access to all components on the node. Attackers can use any network-accessible service as an entry point, so providing access to the host from multiple points can seriously increase its attack surface. The larger the attack surface, the more chances for an attacker to gain access to the node and its operating system.

Also, container-specific operating systems like those used in AKS nodes have a smaller attack surface because they don't contain libraries that enable regular operating systems to directly run databases and web servers. The use of a shared kernel results in a larger attack surface for containers running in the same environment than containers in separate virtual machines. This is the case even when container-specific operating systems running on AKS nodes are in use.

Host operating systems provide foundational system components that can have vulnerabilities and compliance risk. Because they're low-level components, their vulnerabilities and configuration can affect all containers being hosted. AKS protects users by ensuring these vulnerabilities are taken care of via regular OS updates on nodes running on AKS, and the compliance posture of the worker node is maintained.

Improper user access rights might also lead to security risks when users sign in directly to the nodes to manage the containers as opposed to through the AKS control plane. Signing in directly can allow the user to make changes to applications beyond the ones they should have access to.

Also, malicious containers might lead to host OS file system tampering. For example, if a container is allowed to mount a sensitive directory in the host OS, that container might make changes to the files. The changes could affect the security of other containers running on the host.

#### Risk countermeasures

Restrict node access by limiting SSH access.

Using the container-specific OS in AKS nodes typically reduces attack surfaces because other services and functionalities are disabled. They also have read-only file systems and employ other cluster-hardening practices by default.

The Azure platform automatically applies OS security patches to Linux and Windows nodes on a nightly basis. If a Linux OS security update requires a host reboot, it won't automatically reboot. AKS provides mechanisms to reboot to apply those specific patches.

Microsoft Defender for Servers isn't applicable for AKS Linux and Windows nodes because Microsoft manages their OS. If no other virtual machines are in the subscription where AKS is deployed, you can safely disable Microsoft Defender for Servers.

If the environment has been deployed, including the [enterprise-scale landing zone recommended Azure policies](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md), you can configure an exclusion to the policy assignment in the management group that automatically enables Microsoft Defender for Servers to avoid unnecessary costs.

### Application security

Application security is about:

- Runtime protection.
- Vulnerability and compliance management.

#### Major risks

Images are files that include all the components required to run an application. When the latest versions of these components are used to create images, they might be free of known vulnerabilities at the time, but they can change quickly.

You must keep these files up to date with the latest versions because package developers regularly identify security vulnerabilities. Make container updates further upstream by updating the images used to create the containers, unlike traditional applications, which are typically updated at the host.

Malicious files can also be embedded in an image, which can then be used to attack other containers or components of the system. Third-party containers can be a possible attack vector. Specific details might be unknown about them and they could leak data. Maybe the containers haven't been kept up to date with required security updates.

Another attack vector is the use of embedding secrets like passwords and connection strings directly within an image file system. This practice can cause a security risk because anyone with access to the image can get access to the secrets.

There might be flaws in the applications themselves, such as applications that are vulnerable to cross-site scripting or SQL injection. When flaws exist, the vulnerability might be used to enable unauthorized access to sensitive information within other containers or even the host OS.

The AKS container runtime makes it easy to monitor for vulnerabilities by using the various security tools available on Azure. For more information, see [Introduction to Microsoft Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction).

You should also control egress network traffic sent to containers to ensure that containers aren't able to send traffic across networks of different sensitivity levels like environments hosting secure data or to the internet. Azure makes this control easy with its various network and AKS security features.

By default, Kubernetes schedulers focus on driving scale and maximizing density of workloads running on nodes. They might place pods of different sensitivity levels in the same node just because that host has the most available resources. This scenario can potentially lead to security incidents when attackers use access to public-facing workloads to attack containers running more sensitive processes on the same host. A compromised container might also be used to scan the network to find other vulnerabilities that the attacker can exploit.

#### Risk countermeasures

Never store secrets in application code or file systems. Secrets should be stored in key stores and provided to containers at runtime as needed. AKS can ensure that only containers that need access to certain keys have access to them and that these secrets aren't persisted on disk. For example, Azure Key Vault can securely store these secrets and provide them to the AKS cluster as needed. It's also simple to ensure that these secrets are encrypted both in storage and in transit.

Avoid the use of untrusted images and registries and ensure that only images from trusted sets are allowed to run in their clusters. For a multilayered approach:

- Centrally control exactly what images and registries are trusted.
- Discretely identify each image by cryptographic signature.
- Put policies in place that ensure all hosts only run images that are from the approved set.
- Validate these signatures before execution.
- Monitor and update these images and registries as vulnerabilities and configuration requirements change.

Secure computing profiles should be used to constrain containers and be allocated at runtime. Custom profiles can be created and passed to container runtimes to further limit their capabilities. At minimum, ensure that containers are run with the default profiles. Consider using custom, more restricted profiles for containers running high-risk applications.

Tools can automatically profile applications by using behavioral learning and detect anomalies. You can use third-party solutions to detect anomalies at runtime. Anomalies can include events like:

- Invalid or unexpected process execution or system calls.
- Changes to protected configuration files and binaries.
- Writes to unexpected locations and file types.
- Creation of unexpected network listeners.
- Traffic sent to unexpected network destinations.
- Malware storage and execution.

Microsoft Defender for Kubernetes is currently investing in this area.

Containers should run with their root filesystem in read-only mode to isolate writes to defined directories, which those tools can easily monitor. This configuration makes containers more resilient to compromise because you isolate tampering to these specific locations. They can easily be separated from the rest of the application.

## Design considerations

AKS has several interfaces to other Azure services like Microsoft Entra ID, Azure Storage, and Azure Virtual Network. Using these services requires special attention during the planning phase. AKS also adds extra complexity that requires you to consider applying the same security governance and compliance mechanisms and controls as in the rest of your infrastructure landscape.

Here are some other design considerations for AKS security governance and compliance:

- If you create an AKS cluster in a subscription deployed according to enterprise-scale landing-zone best practices, get familiar with the Azure policies that the clusters will inherit. For more information, see [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).
- Decide whether the cluster's control plane should be accessible via the internet (we recommend IP restrictions), which is the default, or only from within your private network in Azure or on-premises as a private cluster. If your organization is following enterprise-scale landing-zone best practices, the `Corp` management group has an Azure Policy associated that forces clusters to be private. For more information, see [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).
- Evaluate using the built-in [AppArmor](/azure/aks/operator-best-practices-cluster-security#app-armor) Linux security module to limit actions that containers can perform, like read, write, execute, or system functions like mounting file systems. For example, all subscriptions have Azure policies that prevent pods in all AKS clusters from creating privileged containers. For more information, see [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).
- Evaluate using [`seccomp` (secure computing)](/azure/aks/operator-best-practices-cluster-security#secure-computing) at the process level to limit the process calls that containers can perform. For example, the Azure Policy applied as part of the generic enterprise-scale landing zone implementation in the landing zones management group to prevent container privilege escalation to root uses `seccomp` through Azure policies for Kubernetes.
- Decide whether your container registry is accessible via the internet or only within a specific virtual network. Disabling internet access in a container registry can have negative effects on other systems that rely on public connectivity to access it. Examples include continuous integration pipelines or Microsoft Defender for image scanning. For more information, see [Connect privately to a container registry by using Azure Private Link](/azure/container-registry/container-registry-private-link).
- Decide whether your private container registry is shared across multiple landing zones or if you deploy a dedicated container registry to each landing zone subscription.
- Consider using a security solution like [Microsoft Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction) for threat detection.
- Consider scanning your container images for vulnerabilities.
- Consider disabling Microsoft Defender for Servers in the AKS subscription if there are no non-AKS virtual machines, to avoid unnecessary costs.

## Design recommendations

- Limit access to the [Kubernetes cluster configuration](/azure/aks/control-kubeconfig-access) file by using Azure RBAC.
- [Secure pod access to resources](/azure/aks/developer-best-practices-pod-security#secure-pod-access-to-resources). Provide the least number of permissions, and avoid using root or privileged escalation.
- Use [Entra Workload ID with AKS](/azure/aks/workload-identity-overview) and the [Azure Key Vault provider for Secrets Store CSI Driver](/azure/aks/csi-secrets-store-driver) to protect secrets, certificates, and connection strings.
- Use [AKS node image upgrade](/azure/aks/node-image-upgrade) to update AKS cluster node images if possible, or [kured](/azure/aks/node-updates-kured) to automate node reboots after you apply updates.
- Monitor and enforce configuration by using the [Azure Policy add-on for Kubernetes](/azure/aks/use-azure-policy). In subscriptions deployed according to enterprise-scale landing-zones best practices, this configuration happens automatically through an Azure Policy deployed at the management group level.
- View AKS recommendations in [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction).
- Use [Microsoft Defender for Containers](/azure/defender-for-cloud/defender-for-containers-introduction), the cloud-native solution to improve, monitor, and maintain the security of your clusters, containers, and their applications.
- Deploy a dedicated and private instance of [Azure Container Registry](/azure/container-registry/) to each landing zone subscription.
- Use [Private Link for Container Registry](/azure/container-registry/container-registry-private-link) to connect it to AKS.
- Scan your images for vulnerabilities with [Microsoft Defender Vulnerability Management](/azure/defender-for-cloud/agentless-vulnerability-assessment-azure) or any other image-scanning solution.

> [!IMPORTANT]
> Microsoft Defender for Cloud image scanning isn't compatible with Container Registry endpoints. For more information, see [Connect privately to a container registry by using Private Link](/azure/container-registry/container-registry-private-link).
