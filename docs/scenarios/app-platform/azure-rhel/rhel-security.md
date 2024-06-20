---
title: Security for RHEL on Azure
description: Learn about key design considerations and recommendations for security in RHEL on Azure infrastructure.
author: 
ms.author: 
ms.date: 
ms.topic: 
ms.custom: 
---

# Overview

## Design Considerations

Providing security for your Red Hat Enterprise Linux (RHEL) systems requires a multi-pronged approach. Security requires that all teams work together to secure your workloads. Security for an environment can't be ensured solely by deployed products or platforms. It requires the implementation of and adherence to a rigorous process that encompasses behavioral, administrative, and engineering components. When you are deploying Red Hat Enterprise Linux in an Azure landing zone, many security factors need to be evaluated. Deploying Red Hat Enterprise Linux (RHEL) on Azure requires a strategic approach that applies both Azure and Red Hat security mechanisms to create a secure and resilient cloud environment. A list of the considerations to be evaluated are listed here, however, it isn't an exhaustive list. What follows are considerations and recommendations for implementing security in your RHEL environment.

Security for Red Hat Enterprise Linux systems, whether deployed in Azure or elsewhere, starts with ensuring verified and validated content. In modern cloud environments, binaries and code can originate from a wide variety of sources. Securing the software supply chain is the first consideration in any deployment. For images in the Azure Marketplace and “private product” offering sections where Red Hat Inc (or RedHat Limited in EMEA regions) is the publisher of record, Red Hat and Microsoft verify and validate these images to ensure source integrity and provide secure default configurations for RHEL operating system instances. It is critical that instances built from these images are configured properly to meet your organization’s runtime security requirements for the target workload. Use RedHat published images from the Azure Marketplace to deploy your RHEL systems to help streamline your security measures. Always be sure to follow RedHat guidance for system and image specifications for your workload. Importantly, start with a minimal and Azure-optimized RHEL image to reduce the attack surface. This doesn't mean all instances are created from this base image and then configured. It's typically more effective to build workload-specific images using composable components to meet varied hardening requirements.

A superior methodology would use GitOps practices to develop image pipelines. These pipelines layer the composable components, defined as configuration code, onto the initial image to produce the workload images. Consider the following list of considerations:

- A hardened base image adhering to the model of least privilege provides a solid foundation.
- Layering software and security configuration together promotes reuse and follows standard operating environment (SOE) and DevSecOps best practices
- Composition models for images can reduce testing and qualification effort
- Composition models increase flexibility and speed time to delivery for new workloads
- Composition models can decrease maintenance costs
- Automation of this build, testing, and delivery process of images is essential to the model

Beyond hardening your system images, it's important to also update your images regularly. While ephemeral instances will likely have a more up-to-date image, as they're likely deployed from a current image, longer standing instances should be updated regularly with a central patching system. This is important for surveying the condition of patched systems in your environment. By decreasing deployment variability, monitoring noise is reduced and anomalies can be identified more accurately and quickly. This increases the success rate of automated detection and remediation efforts.

Consider implementing a centralized system for the maintenance of strict access controls. Many open source projects and commercial off-the-shelf (COTS) applications provide simple deployment examples using local accounts or locally deployed public keys. Although these examples can provide a configuration that is secure, as cloud footprint expands, the effort to maintain localized configuration, even with automation, can become problematic. Automation load increases linearly with each additional instance, however, security logging and monitoring load can escalate at an exponential rate. This generates an excessive burden on compute, storage, and analysis resources. Centralized access control reduces configuration points and this has the effect of reducing automation and logging load, minimizing change, and simplifying auditability while maintaining strict controls on resource access.

Where compliance with cryptographic standards and compliance baselines are required, consider using integrated platform capabilities that support open standards to ensure compatibility with the cloud workloads. Both Red Hat and Microsoft adhere to and participate in global standards bodies and provide appropriate tooling. As an example, cryptographic cipher configuration for system services and applications exist in many configuration files across an individual instance. Variance can easily occur across systems within a target workload and across the fleet. Consider using open standards to define your compliance measurements. Both Red Hat and Microsoft tooling consume standardized file formats providing the latest vulnerability and configuration data. Red Hat provides up-to-date Open Vulnerability and Assessment Language (OVAL) feeds from the Red Hat Security Response Team for Red Hat platform components.

Azure presents unique opportunities for using cloud-specific features while maintaining best practices for security and compliance. Be cognizant of security considerations that have available services within Azure's infrastructure:

- Securing instance BIOS and configuration - Azure Trusted Launch is able to secure the boot process, ensuring that VMs boot with verified code.
- Encrypt data at rest - Azure Disk Encryption using Azure Key Vault is able to manage encryption keys and secrets for securing data at rest. Key Vault service supports two types of containers: vaults and managed hardware security module(HSM) pools. Vaults support storing software and HSM-backed keys, secrets, and certificates.
- Ensure centralized system auditing - Azure Security Center can provide a centralized viewport for unified security management and threat protection.

## Design Recommendations

Designing RHEL environments on Azure should strive to take advantage of Red Hat's native security capabilities alongside Azure's cloud security features to ensure a robust, secure, and efficient deployment. Always start with an image you know to be hardened and built with known validated binaries. RHEL images provided through the Azure Marketplace are streamlined for cloud performance and security. If you have specific security requirements for your business, you should start with your own customized, hardened image built from Red Hat-sourced binaries. Red Hat Satellite can maintain and manage Red Hat, Microsoft, and third Party code along with your custom application code and validate that code using managed content credentials and signatures. Red Hat Enterprise Linux verifies the consistency and authenticity of software from source to disk.

Red Hat recommends using certified [Ansible Automation Platform collections](https://www.redhat.com/technologies/management/ansible/content-collections) to develop automated workflows using Azure and Red Hat management tools.  Workflows should address:

- the generation, maintenance, and testing of baseline and workload images
- testing and deployment of ephemeral instance
- and patch cycle testing and delivery for persistent VM instances
- using automation pipelines. Doing so will significantly reduce management effort, ensure consistent policy enforcement, improve anomaly detection and speed remediation throughout RHEL landing zones.

In addition to the recommendations listed, we recommend using the [Azure Shared Image Gallery](https://learn.microsoft.com/azure/virtual-machines/azure-compute-gallery). You can build your RedHat image with all of the required security mechanisms that you use in your organization and create an image of that VM. This allows you to share security, compliant images across subscriptions and regions in your Azure environment. It also allows versioning for greater granular control over VM images. This ensures more homogeneity of compute instance security patches and tooling used in your environment.

Consider [Azure Update Manager](https://learn.microsoft.com/azure/update-manager/overview?tabs=azure-vms) as part of your update management scheme. Azure Update Manager is a unified service that can monitor updates across your deployments. It has the feature of being able to survey your entire fleet of machines in Azure, on-premises and in other clouds.

### Identity

Red Hat recommends integrating Red Hat Identity Management (IdM) to centralize enforcement of strict access policies. By using trusts and OpenID Connect integrations, IdM consolidates native Linux implementation of role-based access control, host-based access control, privilege escalation policy, SELinux user mapping policy, and other critical Linux services into an enterprise security model without credential synchronization. This generates great benefits when compared to traditional Linux deployments:

- Streamline change control through reduced automation touch points
- Decrease logging and analysis-related load
- Ensure compliance with authentication auditing requirements
- Ensure policy consistency

The advantage of IdM in managing centralized Linux security policy can't be overstated.

Red Hat strongly recommends ensuring that SELinux is enabled and running on all Red Hat Enterprise Linux-based instances - development, test, and production. All Red Hat-produced images and installations are configured to run SELinux in enforcing mode by default. It's useful when designing workload deployments to run SELinux in permissive mode for the entire instance or for individual services within the instance. This allows DevSecOps teams to determine access characteristics of applications and use audit log data with SELinux tooling to generate appropriate SELinux policy for the target workload. It's important to note that SELinux policy generation tools can generate RPM-based policy files to include in content repositories for standardized image deployment. This enables DevSecOps teams to deliver artifacts upstream in an iterative manner within the pipeline. Once testing determines no SELinux violations are generated, the SELinux configuration can be set to Enforcing mode. SELinux violations generated during production would denote a significant deviation from acceptable application behavior that should be flagged and investigated. SELinux enables comprehensive visibility and proactive threat management.

Understanding roles and responsibilities on your team will define the RBAC roles that are assigned to RHEL machines. Relevant teams can require elevated access to virtual machines. Consider **Virtual Machine Contributor**, **Virtual Machine Reader**, and similar roles in order access virtual machines. Consider Just-It-Time access in the case where no standing access is required. Consider managed Identities where the RHEL system must authenticate with Azure. System-assigned managed identities provide more security than Service Principals and are associated with the VM resource. In addition to RBAC roles, consider conditional access for those needing access to your Azure environment. This can restrict user access to your Azure environment based on location, IP Address, and other criteria.

### Antivirus

Ensure that you are equipped with appropriate anti-virus software on your RHEL machine. Consider onboarding [Microsoft Defender for Cloud Endpoint Protection](https://learn.microsoft.com/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint-linux?view=o365-worldwide) on Linux for protection against the latest vulnerabilities. Keep in mind that Microsoft Defender for Cloud Standard should not be enabled on RHEL machines used to host SAP databases. Ensure that each RHEL machine and workload is compatible with running any endpoint protection software.

### Managing Secrets

Red Hat strongly recommends setting a system-wide cryptographic policy on all instances where possible. Cloud deployments are characterized primarily by diversity. Workload teams choose their own libraries, languages, utilities, and cryptographic providers to meet the needs of their particular solutions. While standards implementation, application component factoring, composability, and other techniques can reduce variability, cryptographic settings for applications and services are configured in multiple places within a given instance. It requires significant effort and often deep cryptographic knowledge to sensibly configure new components. The risk of outdated or improperly configured cryptographic policies is significant. The system-wide cryptographic policy aligns the configuration of the core cryptographic subsystems, covering TLS, IPSec, DNSSec, and Kerberos protocols. RHEL system-wide cryptographic DEFAULT policy implements a conservative configuration that eliminates a whole class of threats by disabling legacy communications protocols, like TLS v1.1 and earlier versions. FUTURE and FIPS policies provide stricter configurations. Custom policy creation is supported.

Red Hat recommends incorporating RHEL system auditing and security compliance tools, with a focus on automated scanning and remediation aligned with industry standards:

- auditd is the RHEL audit daemon and journald is the central logging daemon - Azure Monitor can ingest data from auditd and journald to monitor RHEL system security events and feed Sentinel or other SIEM services.
- aide is the Advanced Intrusion Detection Environment and is a required service on Red Hat Enterprise Linux systems that need to meet DISA-STIG compliance. aide output should be logged to Azure.

Monitor and integrated with Ansible Automation Platform to identify, alert and remediate critical system files.

Red Hat recommends using complimentary operating system-level components on all Azure-based RHEL instances:

- Enforce code execution policy - Use the fapolicyd daemon to limit which applications are able to run in the RHEL instance.
- Manage instance ingress and egress - Use firewalld in conjunction with Azure Network Security Groups (NSGs) to manage north-and-southbound traffic to VMs effectively.
- Centrally manage configuration through automation - using GitOps methodology to ensure consistent configuration management during deployment and continuously through day 2 operations of RHEL workloads.
- Government workloads should implement FIPS Compliance mode - Ensure designated RHEL instances are running in FIPS mode to comply with cryptographic standards and using Azure's compliance offerings for a comprehensive compliance posture.
- Always run SELinux - Using SELinux in permissive mode to identify workload access profiles and ensure proper policy to run SELinux in enforcing mode on RHEL VMs. SELinux significantly reduces the attack surface on applications and services running in Azure.

Red Hat recommends registering Red Hat Enterprise Linux servers to Red Hat Insights through Red Hat Satellite. Red Hat Insights leverages analysis of Red Hat’s issue resolution database to proactively identify and generate remediations for deployment and configuration issues before they impact operations, enhancing security posture and operational efficiency. Red Hat Insights is included with every Red Hat Enterprise Linux subscription. A Red Hat Satellite subscription is included as part of any RHEL cloud-based subscription, or purchased as an addon to your Cloud Access RHEL subscriptions. NOTE: enabling insights will send telemetry system information outside of Azure.

### Networking

Networking Security Groups can be applied to the Network Interface or subnet level. We recommend using the subnet level unless specific requirements require a Network Security Group at the Network Interface level. This simplifies management of network communication. Application Security Groups can be used to segment communication between subnets more holistically by allowing application communication. Determine which best fits your scenario and ensure that RHEL machines have appropriate access to the internet for required repositories. This can require allowlisting URLs for these repositories in the most locked down environments. Private endpoints ensure that the only traffic that an Azure resource can receive by default is traffic originating from the Azure network, including connections from on-premises if there's an Azure gateway.

### SIEM/SOAR

Consider [Microsoft Sentinel](https://learn.microsoft.com/azure/sentinel/overview) for SIEM/SOAR tooling for your RHEL systems. Microsoft Sentinel uses artificial intelligence to adapt how it detects threats to the system and you can automate responses to attacks via runbooks. You can use Microsoft Sentinel for proactive threat detection, threat hunting, and threat response.

### Confidential Computing

RedHat Enterprise Linux features a confidential image for [certain RHEL OS options](https://learn.microsoft.com/azure/confidential-computing/confidential-vm-overview#os-support). Consider confidential computing [use cases](https://learn.microsoft.com/azure/confidential-computing/use-cases-scenarios).
