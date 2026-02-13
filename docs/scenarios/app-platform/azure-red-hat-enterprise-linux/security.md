---
title: Security considerations for Red Hat Enterprise Linux on Azure
description: Learn about key design considerations and recommendations for security in Red Hat Enterprise Linux on Azure infrastructure.
author: jhajduk-microsoft
ms.author: temandin
ms.date: 7/24/2024
ms.topic: concept-article
---

# Security considerations for Red Hat Enterprise Linux on Azure

This article describes considerations and recommendations to implement security in your Red Hat Enterprise Linux (RHEL) environment. To provide security for your RHEL systems, use an approach that targets multiple areas. Security requires that all teams work together to secure your workloads. Products or platforms that you deploy can't solely ensure security for your environment.

Implement and adhere to a rigorous process that encompasses behavioral, administrative, and engineering components. When you deploy RHEL in an Azure landing zone, you need to evaluate several security factors. To create a secure and resilient cloud environment, implement a strategic approach that applies both Azure and Red Hat security mechanisms. 

## Design considerations

To provide security for RHEL systems, in Azure or elsewhere, ensure that you start with verified and validated content. In modern cloud environments, binaries and code can originate from a wide variety of sources. As your first consideration for your deployment, secure your software supply chain.

### Harden images

You can find images in [Microsoft Marketplace](https://marketplace.microsoft.com) and *private product* offering sections in which Red Hat, or Red Hat Limited in Europe, Middle East, and Africa (EMEA) regions, publishes the record. Red Hat and Microsoft verify and validate these images to ensure source integrity and provide secure default configurations for RHEL operating system instances.

To meet your organization's runtime security requirements for the target workload, properly configure instances that you build from these images. To help streamline your security measures, use Red Hat published images from Microsoft Marketplace to deploy your RHEL systems. Follow Red Hat guidance for system and image specifications for your workload. To reduce the attack surface, start with a minimal, Azure-optimized RHEL image. You don't have to create and configure all instances from this base image. To meet various hardening requirements, we recommend that you use composable components to build workload-specific images.

You can also use GitOps practices to develop image pipelines. This approach is a superior methodology. These pipelines layer the composable components, defined as configuration code, onto the initial image to produce the workload images.

To effectively use images, implement the following considerations:

- Create a hardened base image that adheres to the model of [least privilege](https://www.redhat.com/topics/security/what-identity-and-access-management-iam#:~:text=Least%20privilege%20only%20gives%20a%20user%20access%20to,to%20take%20the%20actions%20%28permissions%29%20they%20are%20required) to provide a solid foundation.

- Layer software and security configuration together to promote reuse and follow standard operating environment and [DevSecOps best practices](https://www.redhat.com/topics/security/devsecops/approach).
- Use composition models for images to reduce testing and qualification effort and decrease maintenance costs.
- Use composition models to increase flexibility and accelerate the time to delivery for new workloads.
- Automate the build, testing, and delivery process of images for the model.

### Update images

You should also update your images regularly. Ephemeral instances likely have a more up-to-date image because you typically deploy them from a current image. But you should regularly update longer-standing instances by using a central patching system. This step helps you survey the condition of patched systems in your environment. When you minimize deployment variability, monitoring noise is reduced, and you can identify anomalies more accurately and quickly. This approach increases the success rate of automated detection and remediation efforts.

To maintain strict access controls, consider implementing a centralized system. Many open-source projects and commercial off-the-shelf applications provide simple deployment examples that use local accounts or locally deployed public keys. These examples can provide a secure configuration, but as the cloud footprint expands, the effort to maintain localized configuration, even with automation, can become problematic. Automation load increases linearly with each instance, but security logging and monitoring load can escalate at an exponential rate. These changes generate an excessive burden on compute, storage, and analysis resources. Centralized access control reduces configuration points, which reduces automation and logging load, minimizes change, and simplifies auditability while maintaining strict controls on resource access.

In areas where your workload requires compliance with cryptographic standards and compliance baselines, consider using integrated platform capabilities that support open standards to ensure compatibility with the cloud workloads. Red Hat and Microsoft adhere to and participate in global standards bodies and provide appropriate tooling. For example, many configuration files across an individual instance have cryptographic cipher configuration for system services and applications. Variance can easily occur across systems within a target workload and across a fleet. To define your compliance measurements, consider using open standards. Both Red Hat and Microsoft tools consume standardized file formats to provide the latest vulnerability and configuration data. Red Hat provides up-to-date [Open Vulnerability and Assessment Language (OVAL)](https://access.redhat.com/solutions/4161) feeds from the Red Hat Product Security team for Red Hat platform components.

Azure presents unique opportunities to use cloud-specific features and maintain best practices for security and compliance. Security features and services within the Azure infrastructure include:

- [Trusted launch for VMs](/azure/virtual-machines/trusted-launch): Secure instance BIOS and configuration. You can use trusted launch for VMs to secure the start-up process, which ensures that VMs start up with verified code.

- [Azure disk encryption in Azure Key Vault](/azure/virtual-machines/linux/disk-encryption-key-vault): Encrypt data at rest. To secure data at rest, use Azure disk encryption in Key Vault to manage encryption keys and secrets. Key Vault supports two types of containers: vaults and managed hardware security module (HSM) pools. You can store software, HSM-backed keys, secrets, and certificates in vaults.
- [Microsoft Defender for Cloud](/azure/defender-for-cloud/): Ensure centralized system auditing. Defender for Cloud can provide a centralized viewport for unified security management and threat protection.

## Design recommendations

When you design RHEL environments on Azure, take advantage of Red Hat-native security capabilities and Azure cloud security features to ensure a robust, secure, and efficient deployment. Start with an image that you harden and build with known validated binaries. RHEL images in Microsoft Marketplace are streamlined for cloud performance and security. If you have specific security requirements for your business, you should start with your own customized, hardened image that you build from Red Hat-sourced binaries. Red Hat Satellite can maintain and manage Red Hat, Microsoft, and partner code or your custom application code. Satellite can validate the code via managed content credentials and signatures. RHEL verifies the consistency and authenticity of software from the source to the disk.

When you use Azure and Red Hat management tools to develop automated workflows, Red Hat recommends that you use certified [Ansible Automation Platform collections](https://www.redhat.com/technologies/management/ansible/content-collections).

Ensure that your workflows:

- Generate, maintain, and test baseline and workload images.
- Test and deploy ephemeral instances.
- Patch cycle test and deliver persistent VM instances.
- Use automation pipelines. Automation pipelines significantly reduce management effort, ensure consistent policy enforcement, improve anomaly detection, and accelerate remediation throughout RHEL landing zones.

Also consider using [Azure Compute Gallery](/azure/virtual-machines/azure-compute-gallery). You can build your Red Hat image with all of the required security mechanisms that you use in your organization and create an image of that VM. Then you can share security-compliant images across subscriptions and regions in your Azure environment. You can also use versioning for greater granular control over VM images. This approach helps you unify compute instance security patches and tooling that you use in your environment.

Consider implementing [Azure Update Manager](/azure/update-manager/overview) as part of your update management process. Update Manager is a unified service that you can use to monitor updates across your deployments. Use Update Manager to survey your entire fleet of machines in Azure, on-premises, and in other clouds.

### Manage identity and access

To centrally enforce strict access policies, integrate [Red Hat Identity Management (IdM)](https://docs.redhat.com/documentation/red_hat_enterprise_linux/7/html/linux_domain_identity_authentication_and_policy_guide/introduction). IdM uses trusts and OpenID Connect integrations to consolidate the native-Linux implementation of the following features into an enterprise security model without credential synchronization.

- Role-based access control (RBAC)
- Host-based access control
- Privilege escalation policy 
- SELinux user mapping policy
- Other critical Linux services

Compared to traditional Linux deployments, this approach generates benefits, such as:

- Streamlined change control through reduced automation touch points.
- Decreased logging and analysis-related load.
- Compliance with authentication auditing requirements.
- Policy consistency.

IdM provides advantages for managing centralized Linux security policy.

Red Hat recommends that you enable and run SELinux on all RHEL-based instances, including development, test, and production environments. All Red Hat-produced images and installations can run SELinux in enforcing mode by default. When you design workload deployments, you can run SELinux in permissive mode for the entire instance or for individual services within the instance. Then development, security, and operations teams can determine access characteristics of applications and use audit log data with SELinux tooling to generate appropriate SELinux policy for the target workload.

SELinux policy generation tools can generate RPM-based policy files to include in content repositories for standardized image deployment. Development, security, and operations teams can deliver artifacts upstream in an iterative manner within the pipeline. After testing determines that no SELinux violations are generated, you can set the SELinux configuration to enforcing mode. SELinux violations that are generated during production denote a significant deviation from acceptable application behavior. You should flag and investigate these violations. Use SELinux to provide comprehensive visibility and proactive threat management.

To define the RBAC roles that you assign to RHEL machines, understand the roles and responsibilities on your team. Relevant teams might require elevated access to virtual machines (VMs). Consider Virtual Machine Contributor, Virtual Machine Reader, and similar roles to access VMs. Consider just-in-time access if you don't require standing access. Consider managed identities if the RHEL system must authenticate with Azure. System-assigned managed identities provide more security than service principals and are associated with the VM resource. In addition to RBAC roles, consider Conditional Access for people who need access to your Azure environment. Use Conditional Access to restrict user access to your Azure environment based on the location, IP address, and other criteria.

### Use antivirus software

Ensure that you have the appropriate antivirus software on your RHEL machine. Consider onboarding [Microsoft Defender for Endpoint](/defender-endpoint/microsoft-defender-endpoint-linux) on Linux for protection against the latest vulnerabilities. Keep in mind that you shouldn't enable Defender for Cloud Standard on RHEL machines that you use to host SAP databases. Ensure that each RHEL machine and workload can run your endpoint-protection software.

### Manage secrets

Red Hat recommends that you set a system-wide cryptographic policy on all instances where possible. You can characterize cloud deployments by diversity. Workload teams choose their own libraries, languages, utilities, and cryptographic providers to meet the needs of their particular solutions. Standards implementation, application component factoring, composability, and other techniques can reduce variability, but you configure cryptographic settings for applications and services in multiple places within a given instance.

To sensibly configure new components requires significant effort and often deep cryptographic knowledge. Outdated or improperly configured cryptographic policies create risk. A system-wide cryptographic policy aligns the configuration of the core cryptographic subsystems, which covers the Transport Layer Security (TLS), Internet Protocol Security (IPSec), Domain Name System Security Extensions (DNSSEC), and Kerberos protocols. A RHEL system-wide cryptographic DEFAULT policy implements a conservative configuration that eliminates a whole class of threats by disabling legacy communications protocols, like TLS v1.1 and earlier versions. FUTURE and FIPS policies provide stricter configurations. You can also create custom policies.

You can incorporate RHEL system auditing and security compliance tools. Focus on automated scanning and remediation that aligns with industry standards.

- The RHEL audit daemon is *auditd*, and the central logging daemon is *journald*. Azure Monitor can ingest data from *auditd* and *journald* to monitor RHEL system security events and feed Microsoft Sentinel or other security information and event management (SIEM) services.

- RHEL systems that need to meet Defense Information Systems Agency Security Technical Implementation Guide (DISA-STIG) compliance require the Advanced Intrusion Detection Environment (AIDE) utility. You should log AIDE output to Azure.

Monitor and integrate with Ansible Automation Platform to identify, alert on, and remediate critical system files.

Use complementary operating system-level components on all Azure-based RHEL instances.

- **Enforce the code execution policy**: Use the *fapolicyd* daemon to limit the applications that can run in the RHEL instance.

- **Manage instance ingress and egress traffic**: Use *firewalld* with Azure network security groups (NSGs) to effectively manage northbound and southbound traffic to VMs.
- **Centrally manage configuration through automation**: Use the GitOps methodology to ensure consistent configuration management during deployment and continuously through day-2 operations of RHEL workloads.
- **Implement FIPS compliance mode for government workloads**: Ensure that designated RHEL instances run in FIPS mode to comply with cryptographic standards. Use Azure compliance offerings for a comprehensive compliance posture.
- **Always run SELinux**: Use SELinux in permissive mode to identify workload access profiles and ensure proper policy to run SELinux in enforcing mode on RHEL VMs. SELinux significantly reduces the attack surface on applications and services that run in Azure.

Register RHEL servers to Red Hat Insights through Red Hat Satellite. Red Hat Insights takes advantage of the analysis of Red Hat's problem resolution database. Insights uses this analysis to proactively identify and generate remediations for deployment and configuration problems before they affect operations. This strategy enhances security posture and operational efficiency. Every RHEL subscription includes Insights. All RHEL cloud-based subscriptions include a Red Hat Satellite subscription. Or you can purchase a Red Hat Satellite subscription with your Cloud Access RHEL subscriptions.

> [!NOTE]
>Insights sends telemetry system information outside of Azure.

### Configure networking

You can apply NSGs to the network-interface level or subnet level. We recommend the subnet level unless specific requirements require an NSG at the network-interface level. This approach simplifies network communication management. You can use application security groups to allow application communication, which holistically segments communication between subnets. Determine which approach best fits your scenario, and ensure that RHEL machines have appropriate access to the internet for required repositories. You might need to allowlist URLs for these repositories in the most locked-down environments. Private endpoints ensure that the only traffic that an Azure resource can receive by default is traffic that originates from the Azure network, including connections from on-premises if you have an Azure gateway.

### Implement SIEM or SOAR tools

Consider [Microsoft Sentinel](/azure/sentinel/overview) for security orchestration, automation, and response (SOAR) tooling or SIEM tooling for your RHEL systems. Microsoft Sentinel uses AI to adapt how it detects threats to the system. You can automate responses to attacks via runbooks. Use Microsoft Sentinel for proactive threat detection, threat hunting, and threat response.

### Consider confidential computing

RHEL features a confidential image for [certain RHEL operating system options](/azure/confidential-computing/confidential-vm-overview#os-support). Consider confidential computing [use cases](/azure/confidential-computing/use-cases-scenarios).

## Next steps

- [Management and monitoring for RHEL on Azure](./management-monitoring.md)