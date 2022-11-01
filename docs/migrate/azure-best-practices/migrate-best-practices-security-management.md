---
title: Best practices to secure and manage Azure workloads
description: Learn about best practices to operate, manage, and secure workloads migrated to Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 08/30/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

<!-- docutune:casing "Update Management" -->

# Best practices to secure and manage Azure workloads

As you plan your migration to the cloud, in addition to thinking about the migration itself, you need to consider your security and management model in Azure. This article describes best practices for securing your Azure deployment after migration. It also covers ongoing tasks to keep your deployment running at an optimal level.

> [!IMPORTANT]
> The best practices and opinions described in this article are based on the Azure platform and service features available at the time of writing. Features and capabilities might change over time.

## Secure migrated workloads

After migration, the most critical task is to secure migrated workloads from internal and external threats. These best practices help you to:

- Learn how to work with the monitoring, assessments, and recommendations provided by [Microsoft Defender for Cloud](https://azure.microsoft.com/services/defender-for-cloud/).
- Get best practices for encrypting your data in Azure.
- Protect your VMs from malware and malicious attacks.
- Keep sensitive information secure in migrated web apps.
- Verify who can access your Azure subscriptions and resources after migration.
- Review your Azure auditing and security logs regularly.
- Understand and evaluate advanced security features that Azure offers.

### Best practice: Follow Microsoft Defender for Cloud recommendations

Defender for Cloud provides unified security management for Azure tenant admins to protect workloads from attacks. You can apply security policies across workloads, limit threat exposure, and detect and respond to attacks. Defender for Cloud analyzes resources and configurations across Azure tenants, and makes security recommendations, including:

- **Centralized policy management:** Ensure compliance with company or regulatory security requirements by centrally managing security policies across all your hybrid cloud workloads.
- **Continuous security assessment:** Monitor the security posture of machines, networks, storage and data services, and applications to discover potential security issues.
- **Actionable recommendations:** Remediate security vulnerabilities before they can be exploited by attackers, with prioritized and actionable security recommendations.
- **Prioritized alerts and incidents:** Focus on the most critical threats first, with prioritized security alerts and incidents.

In addition to assessments and recommendations, Defender for Cloud provides other security features that you can enable for specific resources.

- **Just-in-time (JIT) access.** Reduce your network attack surface with JIT-controlled access to management ports on Azure VMs.
  - Having VM RDP port 3389 open on the internet exposes VMs to continual activity from bad actors. Azure IP addresses are well-known, and hackers continually probe them for attacks on open 3389 ports.
  - JIT uses network security groups (NSGs) and incoming rules that limit the amount of time that a specific port is open.
  - With JIT access enabled, Defender for Cloud checks that a user has Azure role-based access control (Azure RBAC) *write* permissions for a VM. In addition, you can specify rules for how users can connect to VMs. If permissions are OK, an access request is approved, and Defender for Cloud configures NSGs to allow inbound traffic to the selected ports for the amount of time you specify. NSGs return to their previous state when the time expires.
- **Adaptive application controls.** Keep software and malware off VMs by controlling which applications run on them, by using dynamic allowlists.
  - Adaptive application controls allow you to approve applications, and prevent rogue users or administrators from installing unapproved or vetting software applications on your VMs.
    - You can block or alert attempts to run malicious applications, avoid unwanted or malicious applications, and ensure compliance with your organization's application security policy.
- **File Integrity Monitoring.** Ensure the integrity of files running on VMs.
  - Installing software isn't the only way to cause VM issues. Changing a system file can also cause VM failure or performance degradation. File Integrity Monitoring examines system files and registry settings for changes, and notifies you if something is updated.
  - Defender for Cloud recommends which files you should monitor.

**Learn more:**

- Learn more about [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction).
- Learn more about [just-in-time VM access](/azure/security-center/security-center-just-in-time).
- Learn about [applying adaptive application controls](/azure/security-center/security-center-adaptive-application).
- Get started with [File Integrity Monitoring](/azure/security-center/security-center-file-integrity-monitoring).

### Best practice: Encrypt data

Encryption is an important part of Azure security practices. Enable encryption at all levels to help prevent unauthorized parties from gaining access to sensitive data, including data in transit and at rest.

#### Encryption for infrastructure as a service

- **Virtual machines:** For VMs, you can use Azure Disk Encryption to encrypt your Windows and Linux infrastructure as a service (IaaS) VM disks.
  - Azure Disk Encryption uses BitLocker for Windows, and dm-crypt for Linux, to provide volume encryption for the operating system and data disks.
  - You can use an encryption key created by Azure, or you can supply your own encryption keys, safeguarded in Azure Key Vault.
  - With Azure Disk Encryption, IaaS VM data is secured at rest (on the disk) and during VM boot.
    - Defender for Cloud alerts you if you have VMs that aren't encrypted.
- **Storage:** Protect at-rest data stored in Azure Storage.
  - Data stored in Azure Storage accounts can be encrypted by using Microsoft-generated AES keys that are FIPS 140-2 compliant, or you can use your own keys.
  - Azure Storage encryption is enabled for all new and existing storage accounts, and it can't be disabled.

#### Encryption for platform as a service

Unlike IaaS, in which you manage your own VMs and infrastructure, the platform and infrastructure are managed by the provider in a platform as a service (PaaS) model. You can focus on core application logic and capabilities. With so many different types of PaaS services, each service is evaluated individually for security purposes. As an example, let's see how you might enable encryption for Azure SQL Database.

- **Always Encrypted:** Use the Always Encrypted wizard in SQL Server Management Studio to protect data at rest.
  - You create an Always Encrypted key to encrypt individual column data.
  - Always Encrypted keys can be stored as encrypted in database metadata, or stored in trusted key stores such as Azure Key Vault.
  - Most likely, you'll need to make application changes to use this feature.
- **Transparent data encryption (TDE):** Protect the Azure SQL Database with real-time encryption and decryption of the database, associated backups, and transaction log files at rest.
  - TDE allows encryption activities to take place without changes at the application layer.
  - TDE can use encryption keys provided by Microsoft, or you can bring your own key.

**Learn more:**

- Learn about [Azure Disk Encryption for virtual machines and virtual machine scale sets](/azure/security/fundamentals/azure-disk-encryption-vms-vmss).
- Enable [Azure Disk Encryption for Windows VMs](/azure/virtual-machines/windows/disk-encryption-overview).
- Learn about [Azure Storage encryption for data at rest](/azure/storage/common/storage-service-encryption).
- Read the [Always Encrypted overview](/azure/azure-sql/database/always-encrypted-azure-key-vault-configure).
- Read about [TDE for SQL Database and Azure Synapse](/azure/azure-sql/database/transparent-data-encryption-tde-overview).
- Learn about [Azure SQL Database TDE with customer-managed key](/azure/azure-sql/database/transparent-data-encryption-byok-overview).

### Best practice: Protect VMs with antimalware

Older Azure-migrated VMs might not have the appropriate level of antimalware installed. Azure provides a free endpoint solution that helps protect VMs from viruses, spyware, and other malware.

- Microsoft Antimalware for Azure Cloud Services and Virtual Machines generates alerts when known malicious or unwanted software tries to install itself.
- It's a single agent solution that runs in the background without human intervention.
- Defender for Cloud can identify VMs that don't have endpoint protection running, so you can install Microsoft Antimalware as needed.

  [ ![Screenshot of Microsoft Antimalware for VMs.](./media/migrate-best-practices-security-management/antimalware.png) ](./media/migrate-best-practices-security-management/antimalware.png#lightbox)

  *Figure 1: Microsoft Antimalware for Azure.*

**Learn more:**

- Learn about [Microsoft Antimalware for Azure](/azure/security/fundamentals/antimalware).

### Best practice: Secure web apps

Migrated web apps face a couple of issues:

- Most legacy web applications tend to have sensitive information inside configuration files. Files containing such information can present security issues when applications are backed up, or when application code is checked into or out of source control.
- When you migrate web apps residing in a VM, you're likely moving that machine from an on-premises network and firewall-protected environment, to an environment facing the internet. Make sure that you set up a solution that does the same work as your on-premises protection resources.

Azure provides the following solutions:

- **Azure Key Vault:** Today, web app developers are taking steps to ensure that sensitive information isn't leaked from these files. One method to secure information is to extract it from files and put it into an Azure Key Vault.
  - You can use Key Vault to centralize storage of application secrets, and control their distribution. It avoids the need to store security information in application files.
  - Applications can securely access information in the vault by using URIs, without needing custom code.
  - Azure Key Vault allows you to lock down access via Azure security controls, and to seamlessly implement rolling keys. Microsoft doesn't see or extract your data.
- **App Service Environment for Power Apps:** If an application that you migrate needs extra protection, consider adding App Service Environment and Web Application Firewall to protect the application resources.
  - App Service Environment provides a fully isolated and dedicated environment for running applications, such as Windows and Linux web apps, Docker containers, mobile apps, and function apps.
  - It's useful for applications that are high scale, require isolation and secure network access, or have high memory utilization.
- **Web Application Firewall:** This feature of Azure Application Gateway provides centralized protection for web apps.
  - It protects web apps without requiring backend code modifications.
  - It protects multiple web apps at the same time, behind Application Gateway.
  - You can monitor Web Application Firewall by using Azure Monitor. Web Application Firewall is integrated into Defender for Cloud.

  ![Diagram of Azure Key Vault and secure web apps.](./media/migrate-best-practices-security-management/web-apps.png)

  *Figure 2: Azure Key Vault.*

**Learn more:**

- Read the [Azure Key Vault overview](/azure/key-vault/general/overview).
- Learn about [Web Application Firewall](/azure/web-application-firewall/ag/ag-overview).
- Read an [introduction to App Service environments](/azure/app-service/environment/intro).
- Learn how to [configure a web app to read secrets from Key Vault](/azure/key-vault/general/tutorial-net-create-vault-azure-web-app).

### Best practice: Review subscriptions and resource permissions

As you migrate your workloads and run them in Azure, staff with workload access might move around. Your security team should review who has access to your Azure tenant and resource groups regularly. Azure has offerings for identity management and access control security, including Azure role-based access control (Azure RBAC) to authorize permissions to access Azure resources.

- Azure RBAC assigns access permissions for security principals. Security principals represent users, groups (a set of users), service principals (identity used by applications and services), and managed identities (an Azure Active Directory identity automatically managed by Azure).
- Azure RBAC can assign roles to security principals (such as Owner, Contributor, and Reader) and role definitions (a collection of permissions) that define the operations that the roles can perform.
- Azure RBAC can also set scopes that set the boundary for a role. The scope can be set at several levels, including a management group, subscription, resource group, or resource.

Ensure that admins with Azure access can access only resources that you want to allow. If the predefined roles in Azure aren't granular enough, you can create custom roles to separate and limit access permissions.

  [ ![Screenshot of role-based access control**.](./media/migrate-best-practices-security-management/subscription.png) ](./media/migrate-best-practices-security-management/subscription.png#lightbox)

  *Figure 3: Role-based access control.*

**Learn more:**

- Learn about [Azure RBAC](/azure/role-based-access-control/overview).
- Learn to manage access via [Azure RBAC and the Azure portal](/azure/role-based-access-control/role-assignments-portal).
- Learn about [custom roles](/azure/role-based-access-control/custom-roles).

### Best practice: Review audit and security logs

Azure Active Directory (Azure AD) provides activity logs that appear in Azure Monitor. The logs capture the operations performed in Azure tenancy, when they occurred, and who performed them.

- Audit logs show the history of tasks in the tenant. Sign-in activity logs show who carried out the tasks.
- Access to security reports depends on your Azure AD license. With the free and basic licenses, you get a list of risky users and sign-ins. With the premium licenses, you get underlying event information.
- You can route activity logs to various endpoints for long-term retention and data insights.
- Make it a common practice to review the logs, or integrate your security incident and event management (SIEM) tools to automatically review abnormalities. If you're not using a premium license, you'll need to do a lot of analysis yourself, or by using your SIEM system. Analysis includes looking for risky sign-ins and events, and other user attack patterns.

  ![Screenshot of Azure AD users and groups.](./media/migrate-best-practices-security-management/azure-ad.png)

  *Figure 4: Azure AD users and groups.*

**Learn more:**

- Learn about [Azure AD activity logs in Azure Monitor](/azure/active-directory/reports-monitoring/concept-activity-logs-azure-monitor).
- Learn how to [audit activity reports in the Azure AD portal](/azure/active-directory/reports-monitoring/concept-audit-logs).

### Best practice: Evaluate other security features

Azure provides other security features that provide advanced security options. Some of the following best practices require add-on licenses and premium options.

- **Implement Azure AD administrative units.** Delegating administrative duties to support staff can be tricky with just basic Azure access control. Giving support staff access to administer all the groups in Azure AD might not be the ideal approach for organizational security. You can use administrative units to segregate Azure resources into containers in a similar way to on-premises organizational units (OUs). To use administrative units, the administrative units admin must have a premium Azure AD license. For more information, see [administrative units management in Azure AD](/azure/active-directory/roles/administrative-units).
- **Use multifactor authentication.** If you have a premium Azure AD license, you can enable and enforce multifactor authentication on your admin accounts. Phishing is the most common way that accounts credentials are compromised. When a bad actor has admin account credentials, there's no stopping them from far-reaching actions, such as deleting all of your resource groups. You can establish multifactor authentication in several ways, including with email, an authenticator app, and phone text messages. As an administrator, you can select the least intrusive option. Multifactor authentication integrates with threat analytics and conditional access policies to randomly require a multifactor authentication challenge response. Learn more about [Azure identity management and access control security best practices](/azure/security/fundamentals/identity-management-best-practices), and [how to set up multifactor authentication](/azure/active-directory/authentication/howto-mfa-getstarted).
- **Implement conditional access.** In most small and midsize organizations, Azure admins and the support team are probably located in a single geography. In this case, most sign-ins come from the same areas. If the IP addresses of these locations are fairly static, it makes sense that you shouldn't see administrator sign-ins from outside these areas. Even if a remote bad actor compromises an administrator's credentials, you can implement security features like conditional access, combined with multifactor authentication, to prevent signing in from remote locations. It can also prevent spoofed locations from random IP addresses. Learn more about [conditional access](/azure/active-directory/conditional-access/overview) and [review best practices](/azure/active-directory/conditional-access/plan-conditional-access) for conditional access in Azure AD.
- **Review enterprise application permissions.** Over time, admins select Microsoft and third-party links without knowing their effect on the organization. Links can present consent screens that assign permissions to Azure apps, which might allow access to read Azure AD data, or even full access to manage your entire Azure subscription. You should regularly review the applications to which your admins and users have allowed access to Azure resources. Ensure that these applications have only the permissions that are necessary. Additionally, you can email users quarterly or semi-annually with a link to application pages, so that they're aware of the applications to which they've allowed access to their organizational data. For more information, see [unexpected application in my applications list](/azure/active-directory/manage-apps/application-types), and [how to control](/azure/active-directory/manage-apps/assign-user-or-group-access-portal) application assignments in Azure AD.

## Manage migrated workloads

The following sections recommend some best practices for Azure management, including:

- Best practices for Azure resource groups and resources, including smart naming, preventing accidental deletion, managing resource permissions, and effective resource tagging.
- An overview of using blueprints for building and managing your deployment environments.
- Review sample Azure architectures as you build your post-migration deployments.
- If you have multiple subscriptions, you can gather them into management groups, and apply governance settings to those groups.
- Apply compliance policies to your Azure resources.
- Put together a business continuity and disaster recovery (BCDR) strategy to keep data safe, your environment resilient, and resources up and running when outages occur.
- Group VMs into availability groups for resilience and high availability. Use managed disks for ease of VM disk and storage management.
- Enable diagnostic logging for Azure resources, build alerts and playbooks for proactive troubleshooting, and use the Azure dashboard for a unified view of your deployment health and status.
- Understand your Azure Support plan and how to implement it, get best practices for keeping VMs up-to-date, and put processes in place for change management.

### Best practice: Name resource groups

Your resource groups should have meaningful names that admins and support team members can easily recognize and scan. Descriptive names can drastically improve productivity and efficiency.

If you're synchronizing your on-premises Active Directory to Azure AD by using Azure AD Connect, consider matching the names of security groups on-premises to the names of resource groups in Azure.

  ![Screenshot of resource group naming.](./media/migrate-best-practices-security-management/naming.png)

  *Figure 5: Resource group naming.*

**Learn more:**

- Learn about [recommended naming conventions](../../ready/azure-best-practices/naming-and-tagging.md).

### Best practice: Implement delete locks for resource groups

The last thing you need is for a resource group to disappear because it was deleted accidentally. We recommend that you lock the resources to prevent accidental deletion.

  ![Screenshot of delete locks.](./media/migrate-best-practices-security-management/locks.png)

  *Figure 6: Delete locks.*

**Learn more:**

- Learn about [locking resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

### Best practice: Understand resource access permissions

A subscription owner has access to all the resource groups and resources in the subscription.

- Add people sparingly to this valuable assignment. Understanding the ramifications of these types of permissions is important in keeping your environment secure and stable.
- Make sure you place resources in appropriate resource groups:
  - Match resources with a similar lifecycle together. Ideally, you shouldn't need to move a resource when you need to delete an entire resource group.
  - Resources that support a function or workload should be placed together for simplified management.

**Learn more:**

- Learn about [organizing subscriptions and resource groups](https://azure.microsoft.com/blog/organizing-subscriptions-and-resource-groups-within-the-enterprise/).

### Best practice: Tag resources effectively

Often, using only a resource group name related to resources won't provide enough metadata for effective implementation of mechanisms, such as internal billing or management within a subscription.

- As a best practice, use Azure tags to add useful metadata that can be queried and reported on.
- Tags provide a way to logically organize resources with properties that you define. Tags can be applied to resource groups or resources directly.
- Tags can be applied on a resource group or on individual resources. Resource group tags aren't inherited by the resources in the group.
- You can automate tagging by using PowerShell or Azure Automation, or tag individual groups and resources.
- If you have a request and change management system in place, then you can easily use the information in the request to populate your company-specific resource tags.

  ![Screenshot of tagging.](./media/migrate-best-practices-security-management/tagging.png)

  *Figure 7: Tagging.*

**Learn more:**

- Learn about [tagging and tag limitations](/azure/azure-resource-manager/management/tag-resources).
- Review [PowerShell and CLI examples to set up tagging, and to apply tags from a resource group to its resources](/azure/azure-resource-manager/management/tag-resources#powershell).
- Read about [Azure tagging best practices](https://www.azurefieldnotes.com/2016/07/18/azure-resource-tagging-best-practices).

### Best practice: Implement blueprints

Just as a blueprint allows engineers and architects to sketch a project's design parameters, the Azure Blueprints service lets cloud architects and central IT groups define a repeatable set of Azure resources. Blueprints help them to implement and adhere to an organization's standards, patterns, and requirements. Development teams can rapidly build and create new environments that meet organizational compliance requirements. These new environments have a set of built-in components, such as networking, to speed up development and delivery.

- Use blueprints to orchestrate the deployment of resource groups, Azure Resource Manager templates, and policy and role assignments.
- Store blueprints in a globally distributed service, Azure Cosmos DB. Blueprint objects are replicated to multiple Azure regions. Replication provides low latency, high availability, and consistent access to a blueprint, regardless of the region to which a blueprint deploys resources.

**Learn more:**

- Read [about blueprints](/azure/governance/blueprints/overview).
- Review an [example blueprint for accelerating AI in healthcare](https://azure.microsoft.com/blog/customizing-azure-blueprints-to-accelerate-ai-in-healthcare/).

### Best practice: Review Azure reference architectures

It can be daunting to build secure, scalable, and manageable workloads in Azure, and to keep up with different features for an optimal environment. Having a reference to learn from can be helpful when designing and migrating your workloads. Azure and Azure partners have built several sample reference architectures for various types of environments. These samples are designed to provide ideas that you can learn from and build on.

Reference architectures are arranged by scenario. They contain best practices and advice on management, availability, scalability, and security. App Service Environment provides a fully isolated and dedicated environment for running applications, such as Windows and Linux web apps, Docker containers, mobile apps, and functions. App Service adds the power of Azure to your application, with security, load balancing, autoscaling, and automated management. You can also take advantage of its DevOps capabilities, such as continuous deployment from Azure DevOps and GitHub, package management, staging environments, custom domain, and SSL certificates. App Service is useful for applications that need isolation and secure network access, and ones that use high amounts of memory and other resources that need to scale.

**Learn more:**

- Review [Azure reference architectures and example scenarios](/azure/architecture/browse/).

### Best practice: Manage resources with Azure management groups

If your organization has multiple subscriptions, you need to manage access, policies, and compliance for them. Azure management groups provide a level of scope above subscriptions. Here are some tips:

- You organize subscriptions into containers called management groups, and apply governance conditions to them.
- All subscriptions in a management group automatically inherit the management group conditions.
- Management groups provide large-scale, enterprise-grade management, no matter what type of subscriptions you have.
- For example, you can apply a management group policy that limits the regions in which VMs can be created. This policy is then applied to all management groups, subscriptions, and resources under that management group.
- You can build a flexible structure of management groups and subscriptions, to organize your resources into a hierarchy for unified policy and access management.

The following diagram shows an example of creating a hierarchy for governance by using management groups.

  [ ![Diagram of management groups.](./media/migrate-best-practices-security-management/management-groups.png) ](./media/migrate-best-practices-security-management/management-groups.png#lightbox)

  *Figure 8: Management groups.*

**Learn more:**

- Learn more about [organizing resources into management groups](/azure/governance/management-groups/).

### Best practice: Deploy Azure Policy

Azure Policy is a service that you use to create, assign, and manage policies. Policies enforce different rules and effects over your resources, so those resources stay compliant with your corporate standards and service-level agreements.

Azure Policy evaluates your resources, scanning for noncompliance with your policies. For example, you can create a policy that allows only a specific SKU size for VMs in your environment. Azure Policy will evaluate this setting when you create and update resources, and when scanning existing resources. Note that Azure provides some built-in policies that you can assign, or you can create your own.

  [ ![Screenshot of Azure Policy.](./media/migrate-best-practices-security-management/policy.png) ](./media/migrate-best-practices-security-management/policy.png#lightbox)

  *Figure 9: Azure Policy.*

**Learn more:**

- Read the [Azure Policy overview](/azure/governance/policy/overview).
- Learn about [creating and managing policies to enforce compliance](/azure/governance/policy/tutorials/create-and-manage).

### Best practice: Implement a BCDR strategy

Planning for business continuity and disaster recovery (BCDR) is a critical exercise that you should complete as part of your Azure migration planning process. In legal terms, your contracts might include a *force majeure* clause that excuses obligations due to a greater force, such as hurricanes or earthquakes. But you must ensure that essential services continue to run and recover when disaster strikes. It can make or break your company's future.

Broadly, your BCDR strategy must consider:

- **Data backup:** How to keep your data safe so that you can recover it easily if outages occur.
- **Disaster recovery:** How to keep your applications resilient and available if outages occur.

#### Set up BCDR

Although the Azure platform provides some built-in resiliency capabilities, you need to design your Azure deployment to take advantage of them.

- Your BCDR solution will depend on your company objectives, and is influenced by your Azure deployment strategy. Infrastructure as a service (IaaS) and platform as a service (PaaS) deployments present different challenges for BCDR.
- After they are in place, your BCDR solutions should be tested regularly to check that your strategy remains viable.

#### Back up an IaaS deployment

In most cases, an on-premises workload is retired after migration, and your on-premises strategy for backing up data must be extended or replaced. If you migrate your entire datacenter to Azure, you'll need to design and implement a full backup solution by using Azure technologies, or third-party integrated solutions.

For workloads running on Azure IaaS VMs, consider these backup solutions:

- **Azure Backup:** Provides application-consistent backups for Azure Windows and Linux VMs.
- **Storage snapshots:** Takes snapshots of Blob Storage.

##### Azure Backup

Azure Backup creates data recovery points that are stored in Azure Storage. Azure Backup can back up Azure VM disks, and Azure Files (preview). Azure Files provide file shares in the cloud, accessible via Server Message Block (SMB).

You can use Azure Backup to back up VMs in the following ways:

- **Direct backup from VM settings.** You can back up VMs with Azure Backup directly from the VM options in the Azure portal. You can back up the VM once per day, and you can restore the VM disk as needed. Azure Backup takes application-aware data snapshots, and no agent is installed on the VM.
- **Direct backup in a Recovery Services vault.** You can back up your IaaS VMs by deploying an Azure Backup Recovery Services vault. It provides a single location to track and manage backups, as well as granular backup and restore options. Backup is up to three times a day, at the file and folder levels. It isn't application-aware, and Linux isn't supported. Install the Microsoft Azure recovery services (MARS) agent on each VM that you want to back up by using this method.
- **Protect the VM to Azure Backup Server.** Azure Backup Server is provided free with Azure Backup. The VM is backed up to local Azure Backup Server storage. You then back up the Azure Backup Server to Azure in a vault. Backup is application-aware, with full granularity over backup frequency and retention. You can back up at the application level, for example by backing up SQL Server or SharePoint.

For security, Azure Backup encrypts data in-flight by using AES-256. It sends it over HTTPS to Azure. Backed-up data at rest in Azure is encrypted by using [Azure Storage encryption](/azure/storage/common/storage-service-encryption).

  [ ![Screenshot of Azure Backup.](./media/migrate-best-practices-security-management/iaas-backup.png) ](./media/migrate-best-practices-security-management/iaas-backup.png#lightbox)

  *Figure 10: Azure Backup.*

**Learn more:**

- Learn about [Azure Backup](/azure/backup/backup-overview).
- Plan a [backup infrastructure for Azure VMs](/azure/backup/backup-azure-vms-introduction).

##### Storage snapshots

Azure VMs are stored as page blobs in Azure Storage. Snapshots capture the blob state at a specific point in time. As an alternative backup method for Azure VM disks, you can take a snapshot of storage blobs and copy them to another storage account.

You can copy an entire blob, or use an incremental snapshot copy to copy only delta changes and reduce storage space. As an extra precaution, you can enable soft delete for Blob Storage accounts. With this feature enabled, a blob that's deleted is marked for deletion, but not immediately purged. During the interim period, you can restore the blob.

**Learn more:**

- Learn about [Azure Blob Storage](/azure/storage/blobs/storage-blobs-introduction).
- Learn how to [create a blob snapshot](/azure/storage/blobs/snapshots-overview).
- [Review a sample scenario](https://azure.microsoft.com/blog/microsoft-azure-block-blob-storage-backup/) for Blob Storage backup.
- Read about [soft delete for blobs](/azure/storage/blobs/soft-delete-blob-overview).
- [Disaster recovery and forced failover in Azure Storage](/azure/storage/common/storage-disaster-recovery-guidance).

##### Third-party backup

In addition, you can use third-party solutions to back up Azure VMs and storage containers to local storage or other cloud providers. For more information, see [backup solutions in Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps?search=backup&page=1).

#### Set up disaster recovery for IaaS applications

In addition to protecting data, BCDR planning must consider how to keep applications and workloads available if a disaster occurs. For workloads that run on Azure IaaS VMs and Azure Storage, consider the solutions in the following sections.

##### Azure Site Recovery

Azure Site Recovery is the primary Azure service for ensuring that Azure VMs can be brought online, and VM applications made available, when outages occur.

Site Recovery replicates VMs from a primary to a secondary Azure region. If disaster strikes, you initiate a failover from the primary region, and continue accessing them as normal in the secondary region. When operations return to normal, you can fail back VMs to the primary region.

  [ ![Diagram of Azure Site Recovery.](./media/migrate-best-practices-security-management/site-recovery.png) ](./media/migrate-best-practices-security-management/site-recovery.png#lightbox)

  *Figure 11: Site Recovery.*

**Learn more:**

- Review [disaster recovery scenarios for Azure VMs](/azure/virtual-machines/virtual-machines-disaster-recovery-guidance).
- Learn how to [set up disaster recovery for an Azure VM after migration](/azure/site-recovery/azure-to-azure-replicate-after-migration).

### Best practice: Use managed disks and availability sets

Azure uses availability sets to logically group VMs together, and to isolate VMs in a set from other resources. VMs in an availability set are spread across multiple fault domains with separate subsystems, which protect against local failures. The VMs are also spread across multiple update domains, preventing a simultaneous reboot of all VMs in the set.

Azure managed disks simplify disk management for Azure Virtual Machines by managing the storage accounts associated with the VM disks.

- Use managed disks wherever possible. You only have to specify the type of storage you want to use and the size of disk you need, and Azure creates and manages the disk for you.
- You can convert existing disks to managed disks.
- You should create VMs in availability sets for high resilience and availability. When planned or unplanned outages occur, availability sets ensure that at least one VM in the set remains available.

  ![Diagram of managed disks.](./media/migrate-best-practices-security-management/managed-disks.png)

  *Figure 12: Managed disks.*

**Learn more:**

- Read the [managed disks overview](/azure/virtual-machines/managed-disks-overview).
- Learn about [converting to managed disks](/azure/virtual-machines/windows/convert-unmanaged-to-managed-disks).
- Learn how to [manage the availability of Windows VMs in Azure](/azure/virtual-machines/availability).

### Best practice: Monitor resource usage and performance

You might have moved your workloads to Azure for its immense scaling capabilities. But moving your workload doesn't mean that Azure will automatically implement scaling without your input. Here are two examples:

- If your marketing organization pushes a new television advertisement that drives 300 percent more traffic, your site might experience availability issues. Your newly migrated workload might hit assigned limits, and crash.
- If there's a distributed denial-of-service (DDoS) attack on your migrated workload, in this case you don't want to scale. You want to prevent the source of the attacks from reaching your resources.

These two cases have different resolutions, but for both you need insight into what's happening with usage and performance monitoring.

- Azure Monitor can help surface these metrics, and provide response with alerts, autoscaling, Event Hubs, and Logic Apps.
- You can also integrate your third-party SIEM application to monitor the Azure logs for auditing and performance events.

  [ ![Screenshot of Azure Monitor.](./media/migrate-best-practices-security-management/monitor.png) ](./media/migrate-best-practices-security-management/monitor.png#lightbox)

  *Figure 13: Azure Monitor.*

**Learn more:**

- Learn about [Azure Monitor](/azure/azure-monitor/overview).
- Get best practices for [monitoring and diagnostics](/azure/architecture/best-practices/monitoring).
- Learn about [autoscaling](/azure/architecture/best-practices/auto-scaling).
- Learn how to [route Azure data to a SIEM tool](/azure/security-center/security-center-partner-integration).

### Best practice: Enable diagnostic logging

Azure resources generate a fair number of logging metrics and telemetry data. By default, most resource types don't have diagnostic logging enabled. By enabling diagnostic logging across your resources, you can query logging data, and build alerts and playbooks based on it.

When you enable diagnostic logging, each resource will have a specific set of categories. You select one or more logging categories, and a location for the log data. Logs can be sent to a storage account, event hub, or to Azure Monitor Logs.

![Screenshot of diagnostic logging.](./media/migrate-best-practices-security-management/diagnostics.png)

*Figure 14: Diagnostic logging.*

**Learn more:**

- Learn about [collecting and consuming log data](/azure/azure-monitor/essentials/platform-logs-overview).
- Learn what's supported for [diagnostic logging](/azure/azure-monitor/essentials/resource-logs-schema).

### Best practice: Set up alerts and playbooks

With diagnostic logging enabled for Azure resources, you can use logging data to create custom alerts.

- Alerts proactively notify you when conditions are found in your monitoring data. You can then address issues before system users notice them. You can set alerts for metric values, log search queries, activity log events, platform health, and website availability.
- When alerts are triggered, you can run a logic app playbook. A playbook helps you to automate and orchestrate a response to a specific alert. Playbooks are based on Azure Logic Apps. You can use logic app templates to create playbooks, or create your own.
- As an example, you can create an alert that triggers when a port scan happens against an NSG. You can set up a playbook that runs and locks down the IP address of the scan origin.
- Another example is an application with a memory leak. When the memory usage gets to a certain point, a playbook can recycle the process.

  ![Screenshot of alerts.](./media/migrate-best-practices-security-management/alerts.png)

  *Figure 15: Alerts.*

**Learn more:**

- Learn about [alerts](/azure/azure-monitor/alerts/alerts-overview).
- Learn about [security playbooks that respond to Defender for Cloud alerts](/azure/security-center/workflow-automation).

### Best practice: Use the Azure dashboard

The Azure portal is a web-based unified console that allows you to build, manage, and monitor everything from simple web apps to complex cloud applications. It includes a customizable dashboard and accessibility options.

- You can create multiple dashboards and share them with others who have access to your Azure subscriptions.
- With this shared model, your team has visibility into the Azure environment, which helps them be proactive when managing systems in the cloud.

  ![Screenshot of an Azure dashboard.](./media/migrate-best-practices-security-management/dashboard.png)

  *Figure 16: Azure dashboard.*

**Learn more:**

- Learn how to [create a dashboard](/azure/azure-portal/azure-portal-dashboards).
- Learn about [dashboard structure](/azure/azure-portal/azure-portal-dashboards-structure).

### Best practice: Understand support plans

At some point, you'll need to collaborate with your support staff or Microsoft support staff. Having a set of policies and procedures for support during scenarios such as disaster recovery is vital. In addition, your admins and support staff should be trained on implementing those policies.

- In the unlikely event that an Azure service issue affects your workload, admins should know how to submit a support ticket to Microsoft in the most appropriate and efficient way.
- Familiarize yourself with the various support plans offered for Azure. They range from response times dedicated to developer instances, to premier support with a response time of less than 15 minutes.

  [ ![Screenshot of support plans.](./media/migrate-best-practices-security-management/support.png) ](./media/migrate-best-practices-security-management/support.png#lightbox)

  *Figure 17: Support plans.*

**Learn more:**

- Read an [overview of Azure Support plans](https://azure.microsoft.com/support/options/).
- Learn about [service-level agreements (SLAs)](https://azure.microsoft.com/support/legal/sla/).

### Best practice: Manage updates

Keeping Azure VMs updated with the latest operating system and software updates is a massive chore. The ability to surface all VMs, determine which updates they need, and automatically push those updates is valuable.

- You can use Update Management in Azure Automation to manage operating system updates. This practice applies to machines that run Windows and Linux computers that are deployed in Azure, on-premises, and in other cloud providers.
- Use Update Management to quickly assess the status of available updates on all agent computers, and manage update installation.
- You can enable Update Management for VMs directly from an Azure Automation account. You can also update a single VM from the VM page in the Azure portal.
- In addition, you can register Azure VMs with System Center Configuration Manager. You can then migrate the Configuration Manager workload to Azure and do reporting and software updates from a single web interface.

  [ ![Diagram of VM updates.](./media/migrate-best-practices-security-management/updates.png) ](./media/migrate-best-practices-security-management/updates.png#lightbox)

  *Figure 18: VM updates.*

**Learn more:**

- Learn about [Update Management in Azure](/azure/automation/update-management/overview).
- Learn how to [integrate Configuration Manager with Update Management](/azure/automation/update-management/mecmintegration).
- Frequently asked questions about [Configuration Manager in Azure](/mem/configmgr/core/understand/configuration-manager-on-azure).

## Implement a change management process

As with any production system, making any type of change can affect your environment. You can use a change management process that requires requests to be submitted in order to make changes to production systems in your migrated environment.

- You can build best-practice frameworks for change management to raise awareness among administrators and support staff.
- You can use Azure Automation to help with configuration management and change tracking for your migrated workflows.
- When enforcing change management process, you can use audit logs to link Azure change logs to existing change requests. If you see a change made without a corresponding change request, you can investigate what went wrong in the process.

Azure has a change-tracking solution in Azure Automation:

- The solution tracks changes to Windows and Linux software and files, Windows registry keys, Windows services, and Linux daemons.
- Changes on monitored servers are sent to Azure Monitor for processing.
- Logic is applied to the received data, and the cloud service records the data.
- On the change tracking dashboard, you can easily see the changes that were made in your server infrastructure.

  ![Screenshot of a change management chart.](./media/migrate-best-practices-security-management/change.png)

  *Figure 19: A change management chart.*

**Learn more:**

- Learn about [change tracking](/azure/automation/change-tracking/overview).
- Learn about [Azure Automation capabilities](/azure/automation/automation-intro).

## Next steps

Review other best practices:

- Best practices for [networking after migration](./migrate-best-practices-networking.md).
- Best practices for [cost management after migration](./migrate-best-practices-costs.md).
