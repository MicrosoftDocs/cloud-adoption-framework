---
title: Governance disciplines for Azure Kubernetes Service (AKS)
description: Learn more about the cloud security control lifecycle, and how to set up AKS security controls, Azure Policy, and AKS cost management.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/30/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Governance disciplines for AKS

This article walks through aspects of Azure Kubernetes Service (AKS) security governance to think about before implementing any solution.

Most of this content is technology-agnostic, because implementation varies among customers. The article focuses on how to implement solutions using Azure and open-source software. The decisions made when you create an enterprise-scale landing zone can partially predefine your governance, as described in [Enterprise-scale security governance and compliance](../../ready/enterprise-scale/security-governance-and-compliance.md). It's important to understand governance principles because of the effect of the decisions made.

## Attack surfaces

Five attack surfaces should be considered when creating a security strategy for Kubernetes clusters: build, registry, cluster, node, and application. For each consideration, we discuss the major risks to consider and countermeasures for those risks.

### Build security

Build security is about the proper use of DevSecOps with container images.

**Major risks:**

Poor image configuration can lead to security vulnerabilities down the pipeline, for example having containers that are built running with greater privileges than needed. The containers might also be configured to allow certain network access, which might put the system at risk. Not limiting the allowed system calls to those required for the safe operation of containers can increase risk from a compromised container. Another vulnerability could be allowing the container get access to sensitive directory of the host or allowing the containers change the locations that control the basic function of the host.

Rogue containers, which are unplanned containers in an environment can be a result of developers testing their code in test environments. These containers might not have gone through vigorous scanning for vulnerabilities or be properly configured. These vulnerabilities might open up an entry point for attackers.

Using base images that aren't from trusted sources or aren't to date with security updates, can lead to vulnerabilities in the containers they use to build.

**Risk countermeasures:**

Build security is about the implementation of DevSecOps to shift security left and remediate most issues before they start moving down the pipeline. It's not about putting all the ownership on developers, but sharing the ownership with operations. Developers can then see and remediate vulnerabilities and compliance issues that they can actually address.

You can build a pipeline that scans and fails builds because it has one or 10 critical vulnerabilities. However, a better approach might be to look at the next layer down. You can start to segment the point of responsibility based on vendor status. By setting a threshold at the status layer of the vulnerability, anything with an *Open*, *Will not fix*, or *Deferred* status will continue to flow down the pipeline where SecOps can access the risk as they do today. If the vulnerability has a status of *Vendor fix available*, that is something the developer can address. Along with this, enterprises should use grace periods to allow time for the developers to remediate.

Along with the vulnerability assessment, is the compliance assessment. For example, allowing an image to *Run as root* or exposing SSH will break the compliance posture of most enterprises. This issue should be addressed during build instead of during deployment, typically by scanning your images against the Docker CIS benchmark. When you use these types of flows, you won't break development by introducing security remediation, but you can improve your enterprise's security posture overall inline.

Use of a tool that enables these capabilities is critical to effectively implement the right strategy for your enterprise. Traditional tools are often unable to detect vulnerabilities within containers, which lead to a false sense of security. Tools that take the pipeline-based build approach and the immutable and declarative nature of container technologies into consideration would be needed to properly secure your container ecosystem. These tools should have the following properties:

- Integrate with the entire lifetime of the images from the beginning of the build process to the registry to the runtime.
- Visibility into vulnerabilities at all layers of the image, including the base layer of the image, application frameworks, and custom software.
- Use policy-driven enforcement with the right level of granularity. It allows the organization to create quality gates at each stage of the build and deployment processes.

### Registry security

Registry security is about:

- Drift control from build
- Prevention of push/pull of contaminated images
- Image signing

**Major risks:**

Images often contain proprietary information including an organization's source code. If connections to registries aren't appropriately secure, the content of an image is subject to confidentiality risks as impactful as any other form of data being transmitted within the organization. Having stale images that might have vulnerable out-of-date versions in the registry can increase security risks in the cases where they might get accidentally deployed.

Another security vulnerability might include insufficient authentication and authorization restrictions to container registries, which might house sensitive proprietary assets in the images.

Additionally, as content is built and deployed, the distribution of this content is one of the many attack vectors. How do you assure the content that's staged for distribution, is the same content that's delivered to an intended endpoint?

**Risk countermeasures:**

Organizations should set up their deployment processes to ensure that their development tools, networks, and container runtimes are connected to registries only over encrypted channels. Also be sure the content is coming from a trusted source. Organizations can reduce risks from the use of stale images by:

- Removing unsafe, vulnerable images that should no longer be used from container registries
- Enforcing accessing images using immutable names that specify specific versions of images to be used. This configuration can be implemented by using a *latest* tag or a specific version of the images. A tag doesn't guarantee freshness. Because of this, a process should be put in place to ensure that the Kubernetes orchestrator is using the most recent unique numbers or that the *latest* tag represents the most up-to-date versions.

Organizations should require that all access to registries that contain sensitive images should require authentication and authorization. All write access should also require authentication. An example could be a policy whereby developers can only push images to the specific repositories they're responsible for. Access to these registries should be federated and take advantage of business line level access policies. For example, organizations can configure their CI/CD pipeline to push images to repositories only after they have passed vulnerability scanning compliance assessment and quality control tests.

Lastly, container registries now considered artifact registries are becoming a primary means to deploy any content type, not just container images. Every cloud provides a registry with open-source projects and vendor products available for on-premises or privately hosted within cloud providers. Content is promoted within and across registries from their initial build to their production deployment. The question users ask is how can they ensure the integrity of the content that went into the registry is the same content that comes out of the registry? Adopting an image signing solution will ensure deployments are only coming from trusted registries and are deploying trusted content.

### Cluster security

Cluster security is about:

- Authentication and authorization
- Network security
- Vulnerability and compliance management

**Major risks:**

Sometimes, a single Kubernetes cluster might be used to run different applications managed by different teams with different access level requirements. If access is provided to individuals without restrictions or only according to their needs, a malicious or careless user could compromise workloads they have access to and other assets on the cluster. Another security vulnerability might occur when authorization and authentication are managed by the cluster's own user directory as opposed to being managed directly by the often more rigorously controlled organizational authentication directory. Because these accounts are highly privileged, and more often orphaned, it increases the chances of a compromised account, leading to cluster or even system-wide vulnerabilities since data stored by container volumes are managed by orchestrators, which need to have access to the data no matter which node it's hosted on.

In addition to that, traditional network filters might have a security blindness because of a network overlay designed to encrypt data in transit. This makes it difficult to monitor traffic within the cluster so special provisions might be required to monitor Kubernetes clusters. Traffic from different applications that share the same cluster might have different sensitivity levels such as a public-facing website and an internal application running critical sensitive business processes. Sharing the same virtual network within the cluster can lead to compromised sensitive data. For example, when an attacker uses the shared network exposed to the internet to attack the internal applications.

Protect components running the cluster itself from vulnerabilities and compliance issues. Ensure you're running on the latest possible version of Kubernetes to take advantage of the remediation.

**Risk countermeasures:**

Kubernetes cluster user access should use a least privilege access model. Only grant users access to perform specific actions on specific hosts, containers, and images that are required for them to do their jobs. Testing team members should have limited or no access to containers in production. User accounts with cluster-wide access should be rightly controlled and should be used sparingly. Strong authentication methods should be used like multifactor authentication to secure access to these accounts. Organization user directory should be used to manage clusters via single sign-on as opposed to cluster-specific user accounts that might not have the same level of policies and controls.

Organizations should use encryption methods that allow containers to properly access data whatever host the containers are running on. These encryption tools should prevent unauthorized access to data by other containers even within the same node that shouldn't have access to them.

Kubernetes clusters should be configured to separate network traffic into discrete virtual networks or subnets by sensitivity level. Per-application segmentation might also be possible but at minimum, simply defining networks by sensitivity levels might be sufficient. For example, having virtual networks for customer facing applications separate from those serving internal applications with sensitive traffic should be implemented at a minimum.

Taints and tolerances can be used to isolate deployments to specific sets of nodes by sensitivity levels. Organizations should avoid hosting highly sensitive workloads within the same node as those workloads with lower sensitivities. Using separate managed clusters is a safer option. Segmenting containers by purpose, sensitivity and thread posture provides extra protection for sensitive workloads. By segmenting containers this way, it's more difficult for an attacker who has gained access to one segment, to gain access to other segments. This configuration has the added advantage of ensuring residual data such as caches or volume mounts are isolated by sensitivity level.

Kubernetes clusters should be configured to:

- Provide a secure environment for applications that run on them
- Ensure nodes are securely added to the cluster
- Have persistent identities to help ensure security throughout their lifecycle
- Provide live, accurate information on the state of the cluster, including networking and the nodes within it.

It must be easy for a compromised node to be isolated and removed from the cluster without affecting the performance of the cluster. AKS makes that simple.

Organizations should automatically ensure compliance with container runtime configuration standards defined. There are many policies within Azure that makes this process easy and users can create their own policies as well. Use Azure security features to continuously assess configuration settings across the environment and actively enforce them.

Organizations should automatically ensure vulnerabilities of the Kubernetes components are being addressed. Separate environments should be used for development, test, and production, each with their own controls and RBAC for container management. All container creation should be associated with individual user identities and logged for auditing. This configuration will help reduce risk of rogue containers.

### Node security

Node security is about:

- Runtime protection
- Vulnerability and compliance management

**Major risks:**

A worker node has privileged access to all components on the node. Any network accessible service can be used as an entry point for attackers so providing access to the host from multiple points can seriously increase its attack surface. The larger the attack surface the more chances for an attacker to gaining access to the node and its operating system. Also, container-specific operating systems like those used in AKS nodes have a smaller attack surface because they don't contain libraries that enable regular operating systems to directly run databases and web servers. However, the use of a shared kernel results in a larger attack surface for containers running in the same environment than containers in separate virtual machines, even when container-specific operating systems running on AKS nodes are in use.

Host operating systems provide foundational system components that can have vulnerabilities and compliance risk. Since they're low-level components, their vulnerabilities and configuration can affect all containers being hosted. AKS protects users by ensuring these vulnerabilities are taken care of via regular operating system updates on nodes running on AKS, and the compliance posture of the worker node is maintained.

Improper user access rights might also lead to security risks when users log directly into the nodes to manage the containers as opposed to through the AKS control plane. Signing in directly can allow the user to make changes to applications beyond the ones they should have access to. Also, malicious containers might lead to host OS file system tampering. For example, if a container is allowed to mount a sensitive directory in the host OS, that container might make changes to the files, which can affect the security of other containers running on the host.

**Risk countermeasures:**

Restrict node access by limiting SSH access.

Using the container-specific OS in AKS nodes typically reduces their attack surfaces since other services and functionalities are disabled. They also have read-only file systems and employ other cluster hardening practices by default. The Azure platform automatically applies OS security patches to Linux and Windows nodes on a nightly basis. If a Linux OS security update requires a host reboot, it won't automatically reboot. AKS provides mechanisms to reboot to apply those specific patches.

Azure Defender for Servers isn't applicable for AKS Linux and Windows nodes, since their Operating System is managed by Microsoft. If there are no other virtual machines in the subscription where AKS is deployed, Azure Defender for Servers can be safely disabled. If the environment has been deployed including the [ESLZ recommended Azure policies](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md), an exclusion can be configured to the policy assignment in the management group that automatically enables Azure Defender for Servers, to avoid unnecessary costs.

### Application security

Application security is about:

- Runtime protection
- Vulnerability and compliance management

**Major risks:**

Images are files that include all the components required to run an application. When the latest versions of these components are used to create the images, they might be free of known vulnerabilities at the time, but can change quickly. These files must be kept up to date with the latest versions, because package developers identify the security vulnerabilities. Make container updates further upstream by updating the images used to create the containers, unlike traditional applications, which are typically updated at the host.

Malicious files can also be embedded in the image, which can then be used to attack other containers or components of the system as well. A possible attack vector is in the use of third-party containers, for which specific details might be unknown, could leak data or which haven't been kept up to date with required security updates themselves. Another attack vector is the use embedding secrets like passwords and connection strings directly within image file system. This can cause a security risk, since anyone with access to the image can get access to the secrets.

There might be flaws in the applications themselves, such as applications that are vulnerable to cross-site scripting or SQL injection. When flaws exist, the vulnerability might be used to enable unauthorized access to sensitive information within other containers or even the host OS.

The AKS container runtime makes it easy to monitor for vulnerabilities using the various security tools available on Azure. Review the [introduction to Azure Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction) for more details. Organizations should also control egress network traffic sent to containers, to ensure that containers are not able to send traffic across networks of different sensitivity levels like environments hosting secure data, or to the internet. Azure makes this control easy with its various network and AKS security features.

By default, Kubernetes schedulers focus on driving scale and maximizing density of workloads running on nodes. This means they might place pods of different sensitivity levels in the same node just because that host has the most available resources. This can potentially lead to security incidents when attackers use access to public-facing workloads to attack containers running more sensitive processes on the same host. A compromised container might also be used to scan the network to find other vulnerabilities that the attacker can exploit.

**Risk countermeasures:**

Never store secrets in application code or file systems. Secrets should be stored in key stores and provided to containers at runtime as needed. AKS can ensure that only containers that need access to certain keys have access to them and that these secrets aren't persisted on disk. For example, Azure Key Vault can securely store these secrets and provide them to the AKS cluster as needed. It's also simple to ensure that these secrets are encrypted both in storage and in transit.

Organizations should avoid the use of untrusted images and registries, and ensure that only images from trusted sets are allowed to run in their clusters. A multilayered approach should be used that includes:

- Centrally control exactly what images and registries are trusted.
- Discretely identify each image by cryptographic signature.
- Put policies in place that ensure all hosts only run images that are from the approved set.
- Validate these signatures before execution.
- Monitor and update these images and registries as vulnerabilities and configuration requirements change.

Secure computing profiles should be used to constrain containers and should be allocated at runtime. Custom profiles can be created and passed to container runtimes to further limit their capabilities. At minimum, ensure that containers are run with the default profiles and should consider using custom, more restricted profiles for containers running high-risk applications.

Tools that can automatically profile applications using behavioral learning and detect anomalies. Third-party solutions can be used to detect anomalies at runtime. This includes events like invalid or unexpected process execution or system calls, changes to protected configuration files and binaries, writes to unexpected locations and file types, creation of unexpected network listeners, traffic sent to unexpected network destinations and malware storage and execution. Azure Defender for Kubernetes is currently investing in this area.

Containers should run with their root filesystem in read-only mode to isolate writes to defined directories, which can easily be monitored by those tools. This configuration makes containers more resilient to compromise since you isolate tampering to these specific locations and can easily be separated from the rest of the application.

## Design considerations

AKS has several interfaces to other Azure services like Azure Active Directory, Azure Storage, and Azure Virtual Network, which requires special attention during the planning phase. AKS also adds extra complexity that requires you to consider applying the same security governance and compliance mechanisms and controls as in the rest of your infrastructure landscape.

Here are some other design considerations for AKS security governance and compliance:

- If you create an AKS cluster in a subscription deployed according to enterprise-scale landing zone best practices, get familiar with the Azure Policies that will be inherited by the clusters, as described in [Policies included in Enterprise-Scale Landing Zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).
- Decide if the cluster's control plane should be accessible via the internet (in which case IP restrictions are recommended), which is the default, or only from within your private network in Azure or on-premises as a private cluster. Note as described in [Policies included in Enterprise-Scale Landing Zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md), if your organization is following enterprise-scale landing zone best practices, the "Corp" management group will have an Azure Policy associated that forces clusters to be private.
- Evaluate using the built-in [AppArmor](/azure/aks/operator-best-practices-cluster-security#app-armor) Linux security module to limit actions that containers can perform, like read, write, execute, or system functions like mounting file systems. For example, as described in [Policies included in Enterprise-Scale Landing Zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md), all subscriptions will have Azure Policies that prevent pods in all AKS clusters from creating privileged containers.
- Evaluate using [secure computing (seccomp)](/azure/aks/operator-best-practices-cluster-security#secure-computing) at the process level to limit the process calls that containers can perform. For example, the Azure Policy applied as part of the generic enterprise-scale landing zone implementation in the landing zones management group to prevent container privilege escalation to root uses seccomp through Azure Policies for Kubernetes.
- Decide if your Azure Container Registry is accessible via the Internet, or only within a specific virtual network. Disabling Internet access in an Azure Container Registry can have negative effects on other systems that rely on public connectivity to access it, such as Continuous Integration pipelines or Azure Defender for image scanning. For more information, see [Connect privately to an Azure container registry using Azure Private Link](/azure/container-registry/container-registry-private-link).
- Decide if your private Container Registry instance will be shared across multiple landing zones or if you'll deploy a dedicated container registry to each landing zone subscription.
- Consider using a security solution like [Azure Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction) for threat detection.
- Consider scanning your container images for vulnerabilities.
- Consider disabling Azure Defender for Servers in the AKS subscription if there are no non-AKS virtual machines, to avoid unnecessary costs.

## Design recommendations

- Limit access to the [Kubernetes cluster configuration](/azure/aks/control-kubeconfig-access) file by using Azure role-based access control.
- [Secure pod access to resources](/azure/aks/developer-best-practices-pod-security#secure-pod-access-to-resources). Provide the least number of permissions, and avoid using root or privileged escalation.
- Use [pod-managed identities](/azure/aks/operator-best-practices-identity#use-pod-managed-identities) and [Azure Key Vault provider for Secrets Store CSI Driver](/azure/aks/csi-secrets-store-driver) to protect secrets, certificates, and connection strings.
- Use [AKS node image upgrade](/azure/aks/node-image-upgrade) to update AKS cluster node images if possible, or [kured](/azure/aks/node-updates-kured) to automate node reboots after applying updates.
- Monitor and enforce configuration by using the [Azure Policy add-on for Kubernetes](/azure/aks/use-azure-policy). In subscriptions deployed according to enterprise-scale landing zones best practices, this configuration will happen automatically through an Azure Policy deployed at the management group level.
- View AKS recommendations in [Azure Security Center](/azure/security-center/security-center-introduction).
- Use [Azure Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction). Azure Defender for Kubernetes is configured automatically in AKS clusters created in subscriptions deployed according to enterprise-scale landing zones best practices, which include an Azure Policy to automatically onboard AKS clusters to Azure Defender at the management group level.
- Deploy a dedicated and private instance of [Azure Container Registry](/azure/container-registry/) to each landing zone subscription.
- Use [Private Link for Azure Container Registry](/azure/container-registry/container-registry-private-link) to connect it to AKS.
- Scan your images for vulnerabilities with [Azure Defender for container registries](/azure/security-center/defender-for-container-registries-introduction), or any other image scanning solution.

> [!IMPORTANT]
> Azure Defender image scanning is not compatible with Container Registry endpoints. For more information, see [Connect privately to an Azure Container Registry using Private Link](/azure/container-registry/container-registry-private-link).
