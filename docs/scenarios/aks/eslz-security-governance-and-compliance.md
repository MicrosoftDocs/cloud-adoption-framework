---
title: Enterprise-scale Azure Kubernetes Service (AKS) security, governance, and compliance
description: Learn about the cloud security control lifecycle, and how to set up AKS security controls, Azure Policy, and AKS cost management.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/30/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-aks
---

<!-- docutune:casing "Contoso Financials" -->

# AKS enterprise-scale platform security, governance, and compliance

This article walks through aspects of Azure Kubernetes Service (AKS) security governance to think about before implementing any solution.

Most of this content is technology-agnostic, because implementation varies among customers. The article focuses on how to implement solutions using Azure and some open-source software (OSS).

## The 5 Attack Surfaces 

We begin by discussing the 5 attack surfaces that can be used to create a security strategy for kubernetes clusters. These considerations are Build security, Registry security, Cluster security, Node security and Application security. For each consideration, we discuss the major risks to consider and some of the countermeasures for those risks. 

### Build Security

Build security is about:

1.  The proper utilization of DevSecOps with Container Images

#### Major Risks

Poor image configuration can lead to security vulnerabilities down the pipeline, for example having containers they build running at greater privileges than needed.  They may also be configured to allow certain network access which may put the system at risk. Not limiting the allowed system calls to those required for the safe operation of containers can increase risk from a compromised container. Another vulnerability could be allowing the container get access to sensitive directory of the host or allowing the containers change the locations that control the basic function of the host.

Rouge containers, which are unplanned containers in an environment can be a result of developers testing their code in test environments. These containers may not have gone through vigorous scanning for vulnerabilities or be properly configured and these may open up an entry point for attackers.

Using base images that are not from trusted sources or not up to date with security updates could also lead to vulnerabilities in the containers they use them to build.

#### Risk Countermeasures

Build security is about the implementation of DevSecOps to shift security left and remediate a majority of issues before they start moving down the pipeline. It is not about putting all the ownership on developers but sharing the ownership with Operations.  What does this really mean?  It is about allowing the developers to see and remediate vulnerabilities and compliance issues that they can actually address. So instead of building a pipeline that scans and fails builds because it has 1 or 10 Critical vulnerabilities, look at the next layer down and you can start to segment the point of responsibility based on "Vendor Status".  By setting a threshold at the status layer of the Vulnerability, anything with an "Open", "Will Not Fix, or "Deferred" status would continue to flow down the pipeline where SecOps can access the risk as they do today. If the vulnerability has a status of "vendor fix available", that is something the developer can address.  Along with this Enterprises should utilize grace periods to allow time for the developers to remediate.  

Along with Vulnerability Assessment is Compliance Assessment, allowing a image to "Run as Root" or expose SSH as example will break most Enterprises Compliance postures.  So why not deal with that on build instead of on deployment?  This is typically done by scanning your images against the Docker CIS Benchmark.  Utilizing these types of flows you wouldn't be breaking development by introducing security remediation, but you would actually be improving inline your Enterprises security posture overall.

Utilization of a tool that enables these capabilities is critical in order to effectively implement the right strategy for your Enterprise. Traditional tools are often unable to detect vulnerabilities within containers which leads to a false sense of security. Tools that take the pipeline based build approach and the immutable and declarative nature of container technologies into consideration would be needed to properly secure your Container Ecosystem. These tools should have the following properties:

1. They integrate with the entire lifetime of the images from the beginning of the build process to the registry to the runtime.
2. They need to have visibility into vulnerabilities at all layers of the image including the base layer of the image, application frameworks, and custom software.
3. They use policy-driven enforcement with the right level of granularity allowing the organization bo be able to create quality gates at each stage of the build and deployment processes.

### Registry Security

Registry security is about:

1. Drift Control from Build
2. Prevention of push/pull of contaminated images
3. Image Signing


#### Major Risks

Images often contain proprietary information including an organization's source code. If connections to registries are not appropriately secure, the content of the image are subject to confidentiality risks as impactful as any other form of data being transmitted within the organization. Having stale images that may have vulnerable out of date versions in registry can increase security risk in the cases where they may get accidentally deployed. 

Another security vulnerability might include insufficient authentication and authorization restrictions to container registries which may house sensitive proprietary assets in the images. 

Additionally, As content is built and deployed, the distribution of that content is one of the many attack vectors. How does one assure the content that was staged for distribution is the same content that was delivered to an intended endpoint? 

#### Risk Countermeasures

Organizations should setup their deployment processes to ensure that their development tools, networks and container runtimes are connected to registries only over encrypted channels, and that the content is coming from a trusted source. Organizations can reduce risks from the use of stale images by the following

1. Remove unsafe, vulnerable images that should no longer be used from container registries
2. Enforce accessing images using immutable names that specify specific versions of images to be used. This could be implemented by using a "latest" tag or a specific version of the images. However since a tag does not guarantee freshness, a process should be put in place to ensure that the Kubernetes orchestrator is using the most recent unique numbers or that the "latest" tag represents the most up-to-date versions.

Organizations should also ensure that all access to registries that contain sensitive images should require authentication and authorization. All write access should also require authentication. An example could be a policy whereby developers can only push images to the specific repositories they are responsible for. Access to these registries should be federated and take advantage of business line level access policies. For example, organizations can configure their CI/CD pipeline so that images are pushed to repositories only after they have passed vulnerability scanning compliance assessment and quality control tests.

Lastly, Container Registries now considered Artifact Registries are becoming a primary means to deploy any content type, not just container images. Every cloud provides a registry, with OSS Projects, and vendor products available for on-prem or privately hosted within cloud providers. Content is promoted within and across registries from their initial build to their production deployment. The question users ask is how can they ensure the integrity of the content that went into the registry is the same content that comes out of the registry? 
Adopting an Image Signing solution will ensure that deployments are only coming from trusted registries and are deploying trusted content.

### Cluster Security

Cluster security is about:
1. Authentication\authorization
2. Network Security
3. Vulnerability and Compliance Management

#### Major Risks

Sometimes, a single Kubernetes cluster may be used to run different applications managed by completely different teams with different access level requirements. If access is provided to individuals without restrictions or only according to their needs, a malicious or careless user could compromise not just the workloads they should have access to but other assets on the cluster as well. Another security vulnerability may occur when authorization and authentication is managed by the cluster's own user directory as opposed to being managed directly by the often more rigorously controlled organizational authentication directory. Because these accounts are usually highly privileged, and more often orphaned, this increases the chances of a compromised account, leading to cluster or even system wide vulnerabilities since data stored by container volumes are managed by orchestrators which need to have access to the data no matter which node it is hosted on. 

In addition to that, traditional network filters may have a security blindness because of a network overlay designed to encrypt data in transit making it difficult to monitor traffic within the cluster so special provisions might be required to monitor Kubernetes clusters. Traffic from different apps sharing the same cluster may have different sensitivity levels such as a public facing website and an internal application running critical sensitive business processes. Sharing the same virtual network within the cluster can lead to sensitive data getting compromised for example when an attacker uses the shared network exposed to the internet to attack the internal applications. 

The components running the cluster itself need to be protected from Vulnerabilities and Compliance issues. Ensure you are running on the latest possible version of Kubernetes to take advantage of the remediation. 

#### Risk Countermeasures

Kubernetes cluster user access should use a least privilege access model. Users should only be granted access to perform specific actions on specific hosts, containers and images that are required for them to do their jobs. Testing team members should have limited or no access to containers in production. User accounts with cluster-wide access should be rightly controlled and should be used sparingly. Strong authentication methods should be used like multifactor authentication to secure access to these accounts. Organization user directory should be used to manage clusters via single sign-on as opposed to cluster specific user accounts that may not have the same level of policies and controls. 

Organizations should use encryption methods that allow containers properly access data regardless of the host those containers are running on. These encryption tools should also prevent unauthorized access to data by other containers even within the same node that should not have access to them. 

Kubernetes clusters should be configured to separate network traffic into discrete virtual networks or subnets by sensitivity level. Per app segmentation may also be possible but at minimum, simply defining networks by sensitivity levels may be sufficient. For example, having virtual networks for customer facing applications separate from those serving internal applications with sensitive traffic should be implemented at a minimum. 

Taints and tolerations can be used to isolate deployments to specific sets of nodes by sensitivity levels. Organizations should avoid hosting highly sensitive workloads within the same node as those with lower sensitivities. Using separate managed clusters would be an even safer option. Segmenting containers by purpose, sensitivity and thread posture provides additional protection for sensitive workloads. By segmenting containers this way, it would be much more difficult for an attacker who has gain access to one segment to gain access to other segments. This also has the added advantage of ensuring residual data such as caches or volume mounts are isolated by sensitivity level. 

Kubernetes cluster should be configured to provide a secure environment for apps that run on them, ensure nodes are securely added to the cluster, have persistent identities to help ensure security throughout their lifecycle and provide live accurate information on the state of the cluster including networking and the nodes within it. It must be easy for a compromised node to be isolated and removed from the cluster without impacting the performance of the cluster and AKS makes doing that easy. 

Organizations should automatically ensure compliance with container runtime configuration standards defined. There are many policies within Azure that makes this process easy and users can create their own policies as well. Use Azure security features to continuously assess configuration settings across the environment and actively enforce them. 

Organizations should automatically ensure vulnerabilities of the Kubernetes components are being addressed.  Separate environments should be used for development, test and production each with their own controls and RBAC for container management. All container creation should be associated with individual user identities and logged for auditing. This would help reduce risk of rouge containers.

### Node Security

Node security is about:
1. Runtime protection
2. Vulnerability and Compliance Management

#### Major Risks

A worker node has privileged access to all components on the node.  Any network accessible service can be used as an entry point for attackers so providing access to the host from multiple points can seriously increase its attack surface. The larger the attack surface the more chances for an attacker to gaining access to the node and its OS. In addition to that, Container-specific OSs like those used in AKS nodes have a smaller attack surface because they do not contain libraries that enable regular OS directly run databases and web servers. However the use of a shared kernel results in a larger attack surface for containers running in the same environment than those in separate virtual machines even when container-specific OSs like does running on AKS nodes are in use. 

Host OSs provide foundational system components that can have vulnerabilities and compliance risk.  Since these components sit at a very low level, their vulnerabilities and configuration can affect all containers being hosted. AKS protects users by ensuring these vulnerabilities are taken care of via regular OS updates on nodes running on AKS, and the compliance posture of the worker node is maintained. 

Improper user access rights may also lead to security risks when users log directly into the nodes to manage the containers as opposed to through the AKS control plane. Logging in directly can enable the user make changes that could impact applications beyond those they should have access to. Finally, malicious containers may lead to host OS file system tampering for example if a container is allowed to mount sensitive directory in the host OS, that container may make changes to the files which can affect the security of other containers running on the host.


#### Risk Countermeasures

Restrict node access, by limiting ssh access.

Using the container-specific OS in AKS nodes typically reduces their attack surfaces since other services and functionalities are disabled. They also have read-only file systems and employ other cluster hardening practices by default. The Azure platform automatically applies OS security patches to Linux and Windows nodes on a nightly basis. If a Linux OS security update requires a host reboot, it won't automatically reboot. AKS provides mechanisms to reboot to apply those specific patches. 

### Application Security

Application security is about:
1. Runtime Protection 
2. Vulnerability and Compliance Management

#### Major Risks

Images are basically files that include all the components required to run an application. When the latest version of these components are used to create the images, they may be free of known vulnerabilities at the time but this can change quite quickly, \so these files need to be kept up to date with the latest versions as security vulnerabilities are identified by the package developers. Container updates need to be made further upstream by updating the images used to create the containers unlike traditional applications which are typically updated at the host. 

It is also possible for malicious files to be embedded in the image which can then be used to attack other containers or components of the system as well. A possible attack vector is in the use of third party containers of which specific details might be unknown, leak data or which have not been kept up to date with required security updates themselves. Another attack vector is the use embedding secrets like passwords and connection strings directly within image file system. This can cause a security risks because anyone with access to the image can get access to the secrets.

There may be flaws in the apps themselves, for example applications that are vulnerable to cross-site scripting  or SQL injection. When this happens, the vulnerability may be used to enable unauthorized access to sensitive information within other containers or even the host OS. 

AKS Container runtime makes it easy to monitor for vulnerabilities using the various security tools available on Azure. Check [Introduction to Azure Defender for Kubernetes](https://docs.microsoft.com/en-us/azure/security-center/defender-for-kubernetes-introduction) for mode details. Organizations should also control egress network traffic sent to containers ensuring containers are not able to send traffic across networks of different sensitivity levels, such as environments hosting secure data, to the internet which Azure makes easy with its various network and AKS security features.

Kubernetes schedulers by default is focused on driving scale and maximizing density of workloads running on nodes. This means they may place pods of different sensitivity levels in the same node just because that host has the most available resources. This can potentially lead to security incidents when attackers use access to public facing workloads to attack containers running more sensitive processes on the same host. A compromised container may also be used to scan the network to find other vulnerabilities that the attacker can exploit.

#### Risk Countermeasures

Secrets should never be embedded in application code or file system but should be stored in key stores and provided to containers at runtime as needed. AKS can ensure that only containers that need access to certain keys have access to them and that these secrets are not persisted on disk. Azure key vault for example can securely store these secrets and provide them to the AKS cluster as needed. It is also easy to ensure that these secrets are encrypted both in storage and in transit. 

Organizations should also avoid the use of untrusted images and registries and ensure that only images from these sets are allowed to run in their clusters. A multi-layered approach should be used that includes the following:

1. Centrally control exactly what images and registries are trusted
2. Discretely identify each image by cryptographic signature
3. Policies in place that ensure all hosts only run images that are from the approved set
4. Validation of these signatures before execution 
5. Ongoing monitoring and updates for these images and registries as vulnerabilities and configuration requirements change

Secure computing profiles should be used to constrain containers and should be allocated at runtime. Custom profiles can be created and passed to container runtimes to further limit their capabilities. At minimum, ensure that containers are run with the default profiles and should consider using custom, more restricted profiles for containers running high-risk apps.

Tools that can automatically profile applications using behavioural learning and detect anomalies. Currently 3rd party solutions can be used to detect anomalies at runtime, including events like invalid or unexpected process execution or system calls, changes to protected configuration files and binaries, writes to unexpected locations and file types, creation of unexpected network listeners, traffic sent to unexpected network destinations and malware storage and execution. Azure Defender for Kubernetes is currently investing in this area. 

Containers should run with their root filesystem in read-only mode to isolate writes to specifically defined directories which can easily be monitored by those tools. This also makes containers more resilient to compromise since tampering is isolated to these specific locations and can easily be separated from the rest of the app. 

## Azure security control architecture

All Azure security controls start with, and build on top of, the Azure Resource Manager API. The following diagram shows how the Azure Policy engine helps enforce policies regardless of their origin. This ability is important because it means organizations don't have to define policies in multiple places.

:::image type="content" source="./media/enterprise-control-plane-architecture.png" alt-text="Diagram showing Azure security control architecture." border="false":::

### Security control governance

One of the key benefits of a security control framework is its incorporation of governance and controls auditing. In addition to Azure Policy, Azure security control governance includes [Azure Security Center](/azure/security-center/security-center-introduction), with its [secure score](/azure/security-center/secure-score-security-controls) and compliance dashboard features. Compliance, at its core, is all about governance observability. The following image shows a sample compliance dashboard:

:::image type="content" source="./media/enterprise-control-plane-governance.png" alt-text="Diagram showing Azure security control governance." border="false":::

## Azure security controls setup

This section walks through setting up an overarching Azure-specific security control framework. This section assumes organizational security controls are already established. Defining these security controls is out of scope for this article.

The following sections describe implementing the following controls to meet security requirements for a fictitious Contoso Financials scenario:

- Log all cloud API requests for audit reporting purposes.
- Enable authorized IP ranges to secure access to the API server.
- Use allowed locations to create AKS clusters only in certain regions.

These controls are just a subset of the security controls and Azure policies that a full Azure deployment includes. Once you understand the process, you can repeat it to implement any other security controls your organization requires.

### Log all cloud API requests for audit reporting purposes

[Azure activity logs](/azure/azure-monitor/essentials/platform-logs-overview) capture all Azure Resource Manager interactions, including audit logs. The challenge is that activity logs only have a certain retention lifecycle. To retain logs for audit reporting, you must export the data out of the activity logs into a more persistent storage location, such as Azure Monitor Logs.

For a tutorial on how to set up activity log collection for an Azure subscription, see [Send to a Log Analytics workspace](/azure/azure-monitor/essentials/activity-log#send-to-log-analytics-workspace).

The following screenshot shows an Azure activity log capture in an Azure Log Analytics workspace:

:::image type="content" source="./media/activity-log-capture.png" alt-text="Screenshot showing an Activity Log capture." border="false":::

### Enable Azure security monitoring to check for authorized IP ranges

Before you create anything, look to your cloud provider for security monitoring best practices and recommendations. The cloud provider doesn't implement all the security controls an organization needs, but the key is to use the provided controls to avoid reinventing the wheel, and to create custom controls only when necessary.

In Azure, you can enable Azure Security Center to see security monitoring recommendations. You can also use Azure Security Center to determine whether an AKS cluster has authorized IP ranges enabled.

To enable Azure Security Center Standard for an Azure subscription, see [Quickstart: set up Azure Security Center](/azure/security-center/security-center-get-started).

The following screenshot shows Azure Security Center Standard monitoring:

:::image type="content" source="./media/security-center-standard.png" alt-text="Screenshot showing Azure Security Center Standard monitoring.":::

### Enforce an Azure Policy to create AKS clusters only in certain regions

Also look to the cloud provider for policy enforcement. In Azure, evaluate Azure Policy, which is a key part of the enterprise control plane. You can't do everything with Azure Policy, but the key is to use what's provided to avoid reinventing the wheel, and to create custom controls only when necessary.

You can use Azure Policy to implement allowed locations for creating Azure resources like AKS clusters. For more information and instructions, see [Tutorial: create and manage policies to enforce compliance](/azure/governance/policy/tutorials/create-and-manage).

The following screenshots show the steps of using Azure Policy to implement allowed region locations.

1. Select the built-in **Allowed locations** policy in Azure Policy.

   :::image type="content" source="./media/policy-definitions.png" alt-text="Screenshot showing the built-in Azure policies.":::

1. View the policy definition and assign the policy.

   :::image type="content" source="./media/assign-policy.png" alt-text="Screenshot showing the Allowed locations policy definition.":::

1. Configure the policy.

   :::image type="content" source="./media/configure-policy.png" alt-text="Screenshot showing the Allowed locations configuration screen.":::

1. Configure the policy parameters.

   :::image type="content" source="./media/configure-parameters.png" alt-text="Screenshot showing the Allowed locations parameters screen.":::

1. View policy assignments.

   :::image type="content" source="./media/policy-assignments.png" alt-text="Screenshot showing Azure Policy assignments.":::

The ability to restrict resource creation to a specific region is just one of many available Azure policies.

- For samples of what you can do with Azure Policy, see [Azure Policy samples](/azure/governance/policy/samples/).
- For more information about Azure Policy for Azure Security Center, see [Azure Policy built-in definitions for Azure Security Center](/azure/security-center/policy-reference).

## Cost governance

Cost governance is the continuous process of implementing policies to control costs. In the Kubernetes context, there are several ways organizations can control and optimize costs. These include native Kubernetes tooling to manage and govern resource usage and consumption and proactively monitor and optimize the underlying infrastructure.

[Kubecost](https://kubecost.com/) is an example of a tool that can help govern AKS cluster cost. You can scope cost allocation to a deployment, service, label, pod, or namespace, which provides flexibility in charging back or showing cluster users. You can find further details at the [Cost Governance with Kubecost](./eslz-cost-governance-with-kubecost.md) page



## Design considerations

AKS has several interfaces to other Azure services like Azure Active Directory, Azure Storage, and Azure Virtual Network, which require special attention during the planning phase. AKS also adds extra complexity that requires you to consider applying the same security, governance, and compliance mechanisms and controls as in the rest of your infrastructure landscape.

Here are some other design considerations for AKS security, governance, and compliance:
- Decide whether the cluster's control plane is accessible via the internet, which is the default, or only within a specific virtual network as a private cluster.
- Evaluate using the built-in [AppArmor](/azure/aks/operator-best-practices-cluster-security#app-armor) Linux security module to limit actions that containers can perform, like read, write, execute, or system functions like mounting file systems.
- Evaluate using [secure computing (seccomp)](/azure/aks/operator-best-practices-cluster-security#secure-computing) at the process level to limit the process calls that containers can perform.
- Decide whether your private container registry is accessible via the internet, or only within a specific virtual network.
- Decide whether your private container registry instance is being shared across multiple landing zones or if you deploy a dedicated Azure container registry to each landing zone subscription.
- Consider using a security solution like [Azure Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction) for threat detection.
- Consider scanning your container images for vulnerabilities. 

## Design recommendations
- Limit access to the [Kubernetes cluster configuration](/azure/aks/control-kubeconfig-access) file by using Azure role-based access control.
- [Secure pod access to resources](/azure/aks/developer-best-practices-pod-security#secure-pod-access-to-resources). Provide the least number of permissions, and avoid using root or privileged escalation.
- Use [Pod-managed identities](/azure/aks/operator-best-practices-identity#use-pod-managed-identities) and [Azure Key Vault provider for Secrets Store CSI Driver](/azure/aks/csi-secrets-store-driver) to protect secrets, certificates, and connection strings.
- Use [AKS node image upgrade](/azure/aks/node-image-upgrade) to update AKS cluster node images if possible, or [kured](/azure/aks/node-updates-kured) to automate node reboots after applying updates.
- Monitor and enforce configuration by using the [Azure Policy add-on for Kubernetes](/azure/aks/use-pod-security-on-azure-policy).
- View AKS recommendations in [Azure Security Center](/azure/security-center/security-center-introduction).
- Use  [Azure Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction) 
- Deploy a dedicated and private instance of [Azure Container registry](/azure/container-registry/) to each landing zone subscription.
- [Use Private Link for Azure Container registry](/azure/container-registry/container-registry-private-link) to connect it to AKS.
- Use [Azure Defender for container registries](/azure/security-center/defender-for-container-registries-introduction) to scan your images for vulnerabilities.


