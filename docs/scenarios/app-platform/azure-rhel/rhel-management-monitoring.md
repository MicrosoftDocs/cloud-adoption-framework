---
title: Management and monitoring for Red Hat Enterprise Linux on Azure
description: Learn about key design considerations and recommendations for management and monitoring in RHEL on Azure infrastructure.
author: heisthesisko, Paul Armstrong, and Mike Savage
ms.author: joel.sisko
ms.topic: conceptual
---

# Azure Linux Virtual Machine Management

For greenfield deployment scenarios of Red Hat Enterprise Linux (RHEL) in Azure, Azure [Change Tracking](/azure/automation/change-tracking/overview) allows you to easily identify changes and [Update Management](/azure/automation/update-management/overview) allows you to manage operating system updates for your RHEL Virtual Machines (VMs).

For existing brownfield deployments, using [Red Hat Satellite](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.15) and extending the service into Azure from on-premises might be the best approach to leverage existing skillsets.

With Red Hat Satellite, you can provide content and apply patches to hosts systematically in all lifecycle stages. Content flow in Red Hat Satellite involves management and distribution of content from external sources to hosts.

Content in Satellite flows from external content sources to Satellite Server. Capsule Servers mirror the content from Satellite Server to hosts.

**External content sources**

You can configure many content sources with Satellite. The supported content sources include the Red Hat Customer Portal, Git repositories, Ansible collections, Docker Hub, Security Content Automation Protocol (SCAP) repositories, or internal data stores of your organization.

**Satellite Server**

On your Satellite Server, you plan and manage the content lifecycle.

**Capsule Servers**

By creating Capsule Servers, you can establish content sources in various locations based on your needs. For example, you can establish a content source for each geographical location or multiple content sources for a data center with separate networks.

**Hosts**

By assigning a host system to a Capsule Server or directly to your Satellite Server, you ensure the host receives the content they provide. Hosts can be physical or virtual.

![Red Hat Satellite Architecture](images/system-architecture-satellite.png "Red Hat Satellite")

## Deployment Strategy

Automated software update management solutions are preferred over manual update installation process. Integration with on-premises solutions should be accounted for when working with brownfield installations. When deploying net new workloads into Azure, using cloud native tooling such as  [Update Management](/azure/automation/update-management/overview) or [Ansible on Azure](/azure/developer/ansible/overview) can significantly reduce time to value versus using other third party open source software.

### Considerations

When deploying any automated update management solution consideration to the location of Linux software package repositories should be kept in mind.

Microsoft offers a public repository that can be found [here](https://packages.microsoft.com/) to programmatically update packages for various supported Linux distro’s.

Red Hat offers its own repositories for software packages for registered systems and uses the Red Hat Content Delivery Network (CDN) and Red Hat Subscription Manager for RHEL 9.

**Content Delivery Network (CDN) Structure**

The Red Hat Content Delivery Network, nominally accessed via cdn.redhat.com is a geographically distributed series of static webservers, which contain content and errata that are designed to be consumed by systems. This content can be consumed directly (such as via a system registered via Red Hat Subscription Management) or mirrored via on premise solution, such as Red Hat Satellite 6. The Red Hat Content Delivery network is protected by x.509 certificate authentication, to ensure that only valid users can access it.

In the case of a system registered to Red Hat Subscription Management, the attached subscriptions govern which subset of the CDN the system can access. In the case of Satellite 6, the subscriptions that are attached to the subscription manifest govern which subset of the CDN the system can access.

Other points that should be considered:

- Use of custom images versus Azure Marketplace images
- Testing of updates in nonproduction environment such as [Azure DevTest Labs](/azure/devtest-labs/devtest-lab-overview).
- Scheduling and maintenance windows
- Security and compliance
- Dependencies and compatibility
- Backup and recovery

### Recommendations

#### Use of custom images versus Azure Marketplace images

Azure VMs can be built using predefined Marketplace images and supports the use of [custom Linux images,](/azure/virtual-machines/linux/create-upload-generic) which you build and control to your specific compliance and security needs. When using supported Linux distro’s such as Red Hat Enterprise Linux, you can follow the specific guidance for building your customer image such as [RHEL 8](/azure/virtual-machines/linux/redhat-create-upload-vhd#rhel-8-using-hyper-v-manager). When using custom Linux images ensure to follow the best practice guidance that is detailed in the Update Manager documentation, which can be found [here](/azure/update-manager/manage-updates-customized-images).

#### Testing of updates in nonproduction environment

Separation of test environments from production environments helps to minimize potential impact to production workloads. Use of [Azure DevTest Labs](/azure/devtest-labs/devtest-lab-overview) can provide isolation and reduce cloud subscription costs while accelerating the testing of new updates. Implement continuous integration (CI) and continuous deployment (CD) pipelines using Azure DevOps or similar tools.

Have a clear and tested rollback strategy in case the new update introduces critical issues. These strategies should include database backups, snapshotting, and quick deployment reversal mechanisms.

#### *Scheduling and Maintenance Windows*

[Azure Automation](/azure/automation/overview) accounts can help orchestrate the scheduling of software updates within your cloud environment. 

Blue-Green deployment model or Azure App deployment slots can help minimize the overall time needed during a maintenance window for any given software update. Keep in mind Azure services  update the underlying infrastructure that might impact your running virtual machines and should be accounted for. Information regarding planned updates within Azure can be found in the [Service Health](https://azure.microsoft.com/get-started/azure-portal/service-health/#overview) section of your Azure portal.

#### Security and compliance

Azure Policy is the primary Azure service to ensure your environment meets your organization's security and compliance standards, Detailed information can be found [here](/azure/governance/policy/overview).

Azure Policy provides the following capabilities:

- Enforcing compliance and governance standards
  - Standardization
  - Audit and compliance reporting
- Resource management and cost control
  - Resource consistency
  - Cost management
- Security and access control
  - Security baselines
  - Role-Based Access Control (RBAC) integration
  
#### Dependencies and compatibility
Proper documentation of libraries, frameworks, and any third-party services your application relies on is critical. Using Infrastructure as Code (IaC) such as Azure Resource Manager (ARM) templates or Terraform can define and manage cloud resources with consistent configurations, reducing the risk of environment drift.

The use of [Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts) for private package repositories can help ensure that correct software is installed consistently within your environment. Tools such as GitHub [Dependabot](https://docs.github.com/en/code-security/getting-started/dependabot-quickstart-guide) can help with software dependencies within your repositories.

#### Backup and recovery

For critical applications, consider using application-consistent snapshots, and for less complex scenarios the use of file-consistent snapshots may be a better choice.

Types of snapshots that [Azure Backup](/azure/backup/) provides include:

- VM snapshots
- Disk Snapshots for disks attached to a given VM.

Snapshot management:

- Automated backup scheduling: snapshots can be taken at regular intervals, ensuring consistent data backup without manual intervention.
- Retention policies: Azure Backup allows you to set retention policies for how long snapshots are kept, enabling you to comply with data retention requirements and manage storage costs effectively.

Point-in-time restores allow you to revert a VM or disk to the state captured in the snapshot. This is critical for quick recovery from data corruption, accidental deletions, or similar incidents.

## Change (configuration) management

For Red Hat infrastructure, the term [configuration management](https://www.redhat.com/en/topics/automation/what-is-configuration-management) is the focus of the [Ansible Automation platform](https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.4).

**Overview of Red Hat Ansible Automation Platform**

Red Hat Ansible Automation Platform simplifies the development and operation of automation workloads for managing enterprise application infrastructure lifecycles. Ansible Automation Platform works across multiple IT domains including operations, networking, security, and development, and across diverse hybrid environments. Simple to adopt, use, and understand, Ansible Automation Platform provides the tools needed to rapidly implement enterprise-wide automation, no matter where you are in your automation journey.
Azure Automation Update Management and Azure Update Manager are a comprehensive set of tools that helps to track and implement change management within your Azure environment. Azure Automation Update Management will retire on 31 August 2024. It's recommended to use Azure Update Manager going forward.

*Other resources*

For information about the components included in Ansible Automation Platform, see the table in [What is included in Ansible Automation Platform](https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_release_notes/platform-introduction#whats-included).

For more information about upgrading Ansible Automation Platform, see the [Red Hat Ansible Automation Platform Upgrade and Migration Guide](https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_upgrade_and_migration_guide/index).

For procedures related to using the Ansible Automation Platform installer, see the [Ansible Automation Platform Installation Guide](https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_installation_guide/index).

**Azure native tooling for update management**

Azure Update Manger has been redesigned and, unlike Azure Automation Manager, doesn't depend on Azure Automation or Azure Monitor Logs. Update Manager offers many new features and provides enhanced functionality over the original version available with Azure Automation. Some of those benefits can be found [here](/azure/update-manager/overview?tabs=azure-vms#key-benefits).

![Azure Update Manager hybrid connectivity](images/rhelmanmon003.png "Azure Update Manager hybrid connectivity")

**Steps to enabling and using Update Manager**

- [Update Manager Overview](/azure/update-manager/overview?tabs=azure-vms)
- [View updates for a single machine](/azure/update-manager/view-updates)
- [Deploy updates now (on-demand) for a single machine](/azure/update-manager/deploy-updates)
- [Schedule recurring updates](/azure/update-manager/scheduled-patching)
- [Manage update settings in the portal](/azure/update-manager/manage-update-settings)
- [Manage multiple machines using Update Manager](/azure/update-manager/manage-multiple-machines)

## VM Monitoring and Reporting

Red Hat Enterprise Linux provides a robust set of command line tools that provide deep level performance and tuning of the operating system, running processes, and infrastructure components on an individual VM. The list of tools include:

- pcp
- top
- ps
- vmstat
- sar
- perf
- iostat
- irqbalance
- ss
- numastat
- numad
- valgrind
- pqos

You can find more documentation [here](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/monitoring_and_managing_system_status_and_performance/overview-of-performance-monitoring-options_monitoring-and-managing-system-status-and-performance) further review.

[Azure Monitor](/azure/azure-monitor/overview) provides a comprehensive set of tools that allows the collection, analyzing, and reporting of both your cloud and on-premises environments. The diagram below shows the extensive tools to help collect, visualize, and report in your resources such as Azure Dashboards, Power BI or Grafana dashboards. 

![Azure Monitor overview](images/rhelmanmon001.png "Azure Monitor overview")

Azure monitoring has the capabilities to incorporate customer data sources as demonstrated in the diagram below:

![Azure Monitor data sources](images/rhelmanmon002.png "Azure Monitor data sources")

### Azure Linux VM Monitoring
Azure Monitor uses agents to collect boot and performance data from Azure VMs. It stores this data in Azure storage, and makes it accessible through the Azure portal, the Azure PowerShell module, and Azure CLI. Advanced monitoring is delivered with Azure Monitor for VMs by collecting performance metrics and discovering application components installed on the VMs. You can also make use of performance charts and dependency maps.
### Recommendations
For native Azure VMs the use of boot diagnostics is supported, and for on-premises Linux VMs the use of [Azure Arc](/azure/azure-arc/overview) is recommended for a comprehensive hybrid solution. Steps to enable Azure Arc on a Linux VM can be found here:

[Connect an existing Linux server to Azure Arc](/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/onboard-server-linux)

### Enable boot diagnostics on Azure Linux VMs

As Linux VMs boot, the boot diagnostic extension captures boot output and stores it in Azure storage. This data can be used to troubleshoot VM boot issues. Boot diagnostics aren't automatically enabled when you create a Linux VM using the Azure CLI.

Before enabling boot diagnostics, a storage account needs to be created for storing boot logs. Storage accounts must have a globally unique name, be between 3 and 24 characters, and must contain only numbers and lowercase letters. Create a storage account with the [az storage account create](/cli/azure/storage/account#az_storage_account_create) command. In this example, a random string is used to create a unique storage account name.

**View boot diagnostics**

When boot diagnostics are enabled, each time you stop and start the VM, information about the boot process is written to a log file.

**View host metrics**

A Linux VM has a dedicated host in Azure that it interacts with. Metrics are automatically collected for the host and can be viewed in the Azure portal as follows:

1. In the Azure portal, select **Resource Groups**, choose **myResourceGroupMonitor**, and then select **myVM** in the resource list.
1. To see how the host VM is performing, select **Metrics** on the VM window, then choose any of the *[Host]* metrics under **Available metrics**.

  ![View host metrics](images/rhelmanmon004.png "View host metrics")
  
  **Enable advanced monitoring**
  
  To enable monitoring of your Azure VM with Azure Monitor for VMs:

1. In the Azure portal, select **Resource Groups**, select **myResourceGroupMonitor**, and then select **myVM** in the resource list.
1. On the VM page, in the **Monitoring** section, select **Insights (preview)**.
1. On the **Insights (preview)** page, select **Try now**.

  ![Enable Azure Monitor for VMs for a VM](images/rhelmanmon005.png "Enable Azure Monitor for VMs for a VM")

1. On the **Azure Monitor Insights Onboarding** page, if you have an existing Log Analytics workspace in the same subscription, select it in the drop-down list.

  The list preselects the default workspace and location where the VM is deployed in the subscription.
  
  > [!Note]
  >
  > To create a new Log Analytics workspace to store the monitoring data from the VM, see [**Create a Log Analytics workspace**](/azure/azure-monitor/learn/quick-create-workspace). The workspace must belong to one of the [**supported regions**](/azure/azure-monitor/insights/vminsights-configure-workspace#supported-regions).
  
  After you've enabled monitoring, you might need to wait several minutes before you can view the performance metrics for the VM.
  
  ![Enable Azure Monitor for VMs monitoring deployment processing](images/rhelmanmon006.png "Enable Azure Monitor for VMs monitoring deployment processing")
  
  **View VM performance metrics**
  
  Azure Monitor for VMs includes a set of performance charts that target several key performance indicators (KPIs) to help you determine how well a virtual machine is performing. To access from your VM, perform the following steps.

1. In the Azure portal, select **Resource Groups**, select **myResourceGroupMonitor**, and then select **myVM** in the resource list.
1. On the VM page, in the **Monitoring** section, select **Insights (preview)**.
1. Select the **Performance** tab.

  This page not only includes performance utilization charts, but also a table showing for each logical disk discovered, its capacity, utilization, and total average by each measure.
  
  **Create alerts**
  
  You can create alerts based on specific performance metrics. Alerts can be used to notify you when average CPU usage exceeds a certain threshold or available free disk space drops below a certain amount, for example. Alerts are displayed in the Azure portal or can be sent via email. You can also trigger Azure Automation runbooks or Azure Logic Apps in response to alerts being generated.
  
  The following example creates an alert for average CPU usage.

1. In the Azure portal, select **Resource Groups**, select **myResourceGroupMonitor**, and then select **myVM** in the resource list.
1. Select **Alert rules** on the VM blade, then select **Add metric alert** across the top of the alerts blade.
1. Provide a **Name** for your alert, such as *myAlertRule*
1. To trigger an alert when CPU percentage exceeds 1.0 for five minutes, leave all the other defaults selected.
1. Optionally, check the box for *Email owners, contributors, and readers* to send email notification. The default action is to present a notification in the portal.
1. Select the **OK** button.

## Next steps

[Creating a customer dashboard in Azure](/azure/azure-portal/azure-portal-dashboards)

