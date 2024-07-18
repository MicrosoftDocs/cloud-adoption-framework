---
title: Management and monitoring for Red Hat Enterprise Linux on Azure
description: Learn about key design considerations and recommendations for management and monitoring in RHEL on Azure infrastructure.
author: heisthesisko, Paul Armstrong, and Mike Savage
ms.author: joel.sisko
ms.topic: conceptual
md.date: 07/24/2024
---

# Management and monitoring for Red Hat Enterprise Linux on Azure

For greenfield deployment scenarios of Red Hat Enterprise Linux (RHEL) on Azure, you can use Azure [change tracking](/azure/automation/change-tracking/overview) to easily identify changes. You can also use [update management](/azure/automation/update-management/overview) to manage operating system updates for your RHEL virtual machines (VMs).

For existing brownfield deployments, you can use [Red Hat Satellite](https://access.redhat.com/documentation/red_hat_satellite/6.15) and extend the service into Azure from on-premises to take advantage of existing skillsets.

With Red Hat Satellite, you can provide content and apply patches to hosts systematically in all lifecycle stages. Content flow in Red Hat Satellite involves management and distribution of content from external sources to hosts.

Content in Satellite flows from external content sources to Satellite Server. Capsule Servers mirror the content from Satellite Server to the hosts. The content flow consists of the following steps:

1. **Configure external content sources**: You can configure many content sources with Satellite. The supported content sources include the Red Hat Customer Portal, Git repositories, Ansible collections, Docker Hub, Security Content Automation Protocol (SCAP) repositories, or internal data stores in your organization.

1. **Manage the content lifecycle**: On your Satellite Server, you plan and manage the content lifecycle.

1. **Establish content sources**: Create Capsule Servers to establish content sources in various locations based on your needs. For example, you can establish a content source for each geographical location or establish multiple content sources for a datacenter with separate networks.

1. **Assign a host system**: When you assign a host system to a Capsule Server or directly to your Satellite Server, you ensure that the host receives the content that they provide. You can have physical or virtual hosts.

:::image type="content" source="images/system-architecture-satellite.png " alt-text="Diagram that shows the Red Hat Satellite architecture." border="false":::

## Deployment strategy

We recommend that you use automated software update management solutions instead of manual update installation processes. Consider the integration with on-premises solutions when you work with brownfield installations. When you deploy net-new workloads on Azure, use cloud-native tooling, such as [update management](/azure/automation/update-management/overview) or [Ansible on Azure](/azure/developer/ansible/overview), to significantly reduce time to value compared to using other partner open-source software.

### Considerations

When you deploy any automated update management solution, consider the location of Linux software package repositories.

Microsoft offers a [public repository](https://packages.microsoft.com/) to programmatically update packages for supported Linux distributions.

Red Hat offers its own repositories for software packages for registered systems. Red Hat uses the Red Hat Content Delivery Network (CDN) and Red Hat Subscription Manager for RHEL 9.

**Content Delivery Network (CDN) structure**

The Red Hat Content Delivery Network is a geographically distributed series of static webservers that contain content and errata for systems to consume. Systems can consume this content directly, such as via a system that you register with Red Hat Subscription Management, or mirrored via an on-premises solution, such as Red Hat Satellite 6. You can access the Red Hat Content Delivery Network via `cdn.redhat.com`. The x.509 certificate authentication protects Red Hat Content Delivery Network to ensure that only valid users can access it.

If you register a system to Red Hat Subscription Management, the attached subscriptions govern which subset of the CDN the system can access. For Satellite 6, the subscriptions that are attached to the subscription manifest govern which subset of the CDN the system can access.

### Recommendations

Implement the following recommendations to help manage and monitor your environment.

#### Use custom images instead of Azure Marketplace images

You can use predefined Azure Marketplace images to build Azure VMs. Or you can use [custom Linux images](/azure/virtual-machines/linux/create-upload-generic) to build and control your specific compliance and security needs. If you use supported Linux distributions such as RHEL, follow the specific guidance for building your customer image, such as [RHEL 8 guidance](/azure/virtual-machines/linux/redhat-create-upload-vhd#rhel-8-using-hyper-v-manager). If you use custom Linux images, follow the [update manager best practice guidance](/azure/update-manager/manage-updates-customized-images).

#### Perform test updates in a nonproduction environment

Separate test environments from production environments to help minimize potential negative effects on production workloads. Use [Azure DevTest Labs](/azure/devtest-labs/devtest-lab-overview) to provide isolation and reduce cloud subscription costs while accelerating the testing of new updates. Use Azure DevOps or a similar tool to implement continuous integration and continuous delivery (CI/CD) pipelines.

Have a clear and tested rollback strategy if a new update introduces critical problems. These strategies should include database backups, snapshotting, and quick deployment reversal mechanisms.

#### Consider scheduling and maintenance windows

You can use [Azure Automation](/azure/automation/overview) accounts to help orchestrate software update schedules within your cloud environment. 

Use a blue-green deployment model or Azure App deployment slot to help minimize the overall time that you need during a maintenance window for any given software update. Remember that Azure services update the underlying infrastructure and might affect your active VMs. For more information, see [service health](https://azure.microsoft.com/get-started/azure-portal/service-health/#overview) in your Azure portal.

#### Configure security and compliance

Use Azure Policy to ensure that your environment meets your organization's security and compliance standards. For more information, [Azure Policy overview](/azure/governance/policy/overview).

You can use Azure Policy to:

- Enforce compliance and governance standards, such as audit and compliance reporting.

- Provide resource management and cost control, such as resource consistency and cost management.
- Provide security and access control, such as security baselines and role-based access control (RBAC).
  
#### Manage dependencies and compatibility

Properly document libraries, frameworks, and any partner services that your application relies on. Use infrastructure as code, such as Azure Resource Manager templates (ARM templates) or Terraform, to define and manage cloud resources with consistent configurations. Use this approach to reduce the risk of environment drift.

Use [Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts) for private package repositories to help ensure that you have the correct software installed consistently within your environment. Use tools, such as GitHub [Dependabot](https://docs.github.com/code-security/getting-started/dependabot-quickstart-guide), to help find software dependencies within your repositories.

#### Configure backup and recovery

For critical applications, consider using application-consistent snapshots. For less-complex scenarios, use file-consistent snapshots.

Types of snapshots that [Azure Backup](/azure/backup/) provides include:

- VM snapshots.
- Disk snapshots for disks that are attached to a given VM.

To manage snapshots, use:

- **Automated backup scheduling**: You can take snapshots at regular intervals to ensure that you have consistent data backup without manual intervention.

- **Retention policies**: Use Backup to set retention policies for how long you keep snapshots. Use this approach to comply with data-retention requirements and manage storage costs effectively.

Use point-in-time restores to revert a VM or disk to the state that the snapshot captures. Ensure that your environment quickly recovers from data corruption, accidental deletions, or similar incidents.

## Change (configuration) management

For Red Hat infrastructure, the term [configuration management](https://www.redhat.com/topics/automation/what-is-configuration-management) refers to the [Ansible Automation platform](https://access.redhat.com/documentation/red_hat_ansible_automation_platform/2.4).

### Overview of Red Hat Ansible Automation Platform

Red Hat Ansible Automation Platform simplifies the development and operation of automation workloads for managing enterprise application infrastructure lifecycles. Ansible Automation Platform works across multiple IT domains, including operations, networking, security, and development, and across diverse hybrid environments. Ansible Automation Platform is simple to adopt, use, and understand and provides the tools that you need to rapidly implement enterprise-wide automation, no matter where you are in your automation journey.

You can use Azure Automation update management and Azure Update Manager to track and implement change management within your Azure environment. Azure Automation update management retires on August 31, 2024. We recommend that you use Update Manager going forward.

For information, see

- [What is included in Ansible Automation Platform](https://access.redhat.com/documentation/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_release_notes/platform-introduction#whats-included).

- [Red Hat Ansible Automation Platform upgrade and migration guide](https://access.redhat.com/documentation/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_upgrade_and_migration_guide/index).

- [Ansible Automation Platform installation guide](https://access.redhat.com/documentation/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_installation_guide/index).

### Azure-native tooling for update management

Unlike Azure Automation update management, Update Manager doesn't depend on Azure Automation or Azure Monitor Logs. Update Manager offers [many features](/azure/update-manager/overview#key-benefits) and provides enhanced functionality compared to the original version in Azure Automation.

The following diagram shows an Update Manager hybrid connectivity configuration.

:::image type="content" source="images/rhelmanmon003.png" alt-text="Diagram that shows Update Manager hybrid connectivity." border="false" lightbox="images/rhelmanmon003.png":::

For more information, see:

- [Update Manager overview](/azure/update-manager/overview)
- [View updates for a single machine](/azure/update-manager/view-updates)
- [Deploy updates now (on-demand) for a single machine](/azure/update-manager/deploy-updates)
- [Schedule recurring updates](/azure/update-manager/scheduled-patching)
- [Manage update settings in the portal](/azure/update-manager/manage-update-settings)
- [Manage multiple machines using Update Manager](/azure/update-manager/manage-multiple-machines)

## VM monitoring and reporting

RHEL provides a robust set of command line tools that provide deep-level performance and tuning of the operating system, running processes, and infrastructure components on an individual VM. The tools include:

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

For more information, see [Overview of performance monitoring options](https://access.redhat.com/documentation/red_hat_enterprise_linux/8/html/monitoring_and_managing_system_status_and_performance/overview-of-performance-monitoring-options_monitoring-and-managing-system-status-and-performance).

You can use [Azure Monitor](/azure/azure-monitor/overview) to collect data, analyze data, and create reports for both your cloud and on-premises environments. The following diagram shows the tools that you can use.

:::image type="content" source="images/rhelmanmon001.png" alt-text="Diagram that shows Azure Monitor tools." border="false" lightbox="images/rhelmanmon001.png":::

Azure monitoring has the capabilities to incorporate customer data sources as demonstrated in the following diagram.

:::image type="content" source="images/rhelmanmon002.png" alt-text="Diagram that shows Azure Monitor data sources." border="false" lightbox="images/rhelmanmon002.png":::

### Azure Linux VM monitoring

Azure Monitor uses agents to collect boot data and performance data from Azure VMs. It stores this data in Azure storage, and makes it accessible through the Azure portal, the Azure PowerShell module, and Azure CLI. To provide advanced monitoring for VMs, Azure Monitor collects performance metrics and discovers application components that are installed on the VMs. You can also use performance charts and dependency maps.

### Recommendations

Native Azure VMs support boot diagnostics. For on-premises Linux VMs, we recommend [Azure Arc](/azure/azure-arc/overview) for a comprehensive hybrid solution. Follow the steps to [enable Azure Arc on a Linux VM](/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/onboard-server-linux).

### Enable boot diagnostics on Azure Linux VMs

As Linux VMs boot, the boot diagnostic extension captures boot output and stores it in Azure storage. You can use this data to troubleshoot VM boot problems. Boot diagnostics aren't automatically enabled when you use Azure CLI to create a Linux VM.

Before you enable boot diagnostics, create a storage account for storing boot logs. Create a storage account with the [az storage account create](/cli/azure/storage/account#az_storage_account_create) command. The following example uses a random string to create a unique storage account name.

#### View boot diagnostics

After you enable boot diagnostics, each time you stop and start the VM, information about the boot process is written to a log file.

#### View host metrics

A Linux VM has a dedicated host in Azure that it interacts with. Metrics are automatically collected for the host, and you can view the metrics in the Azure portal.

1. In the Azure portal, select **Resource Groups**, choose **myResourceGroupMonitor**, and then select **myVM** in the resource list.
1. To see how the host VM is performing, select **Metrics** on the VM window, then choose any of the *[Host]* metrics under **Available metrics**.

  :::image type="content" source="images/rhelmanmon004.png" alt-text="Screenshot that shows the Metrics page in the Azure portal." lightbox="images/rhelmanmon004.png":::
  
#### Enable advanced monitoring
  
To enable monitoring of your Azure VM with Azure Monitor for VMs:

1. In the Azure portal, select **Resource groups**, select **myResourceGroupMonitor**, and then select **myVM** in the resource list.

1. In the **Monitoring** section, select **Insights**.
1. Select **Try now**.

   :::image type="content" source="images/rhelmanmon005.png" alt-text="Screenshot that shows the Insights page." lightbox="images/rhelmanmon005.png":::

1. On the **Azure Monitor Insights onboarding** page, if you have an existing Log Analytics workspace in the same subscription, select it in the drop-down list.

   The list preselects the default workspace and location where the VM is deployed in the subscription.
  
   > [!Note]
   >
   > To create a new Log Analytics workspace to store the monitoring data from the VM, see [Create a Log Analytics workspace](/azure/azure-monitor/learn/quick-create-workspace). The workspace must belong to one of the [supported regions](/azure/azure-monitor/insights/vminsights-configure-workspace#supported-regions).
  
   After you enable monitoring, you might need to wait several minutes before you can view the performance metrics for the VM.

   :::image type="content" source="images/rhelmanmon006.png" alt-text="Screenshot that shows the wait page." lightbox="images/rhelmanmon006.png":::
  
#### View VM performance metrics
  
Azure Monitor for VMs includes a set of performance charts that target several key performance indicators (KPIs) to help you determine how well a VM performs. To access the charts from your VM, do the following steps.

1. In the Azure portal, select **Resource groups**, select **myResourceGroupMonitor**, and then select **myVM** in the resource list.
1. In the **Monitoring** section, select **Insights**.
1. Select the **Performance** tab.

   This page includes performance usage charts and also provides a table for each discovered logical disk, its capacity, usage, and the total average of each measurement.
  
#### Create alerts
  
You can create alerts based on specific performance metrics. Use alerts to get notifications when the average CPU usage exceeds a certain threshold or the available free disk space goes below a certain amount. You can view alerts in the Azure portal or receive them via email. You can also trigger Azure Automation runbooks or Azure Logic Apps in response to alerts being generated.
  
The following example creates an alert for average CPU usage.

1. In the Azure portal, select **Resource groups**, select **myResourceGroupMonitor**, and then select **myVM** in the resource list.

1. Select **Alert rules** on the VM pane, then select **Add metric alert** at the top of the Alerts pane.
1. Provide a **Name** for your alert, such as *myAlertRule*.
1. To trigger an alert when CPU percentage exceeds 1.0 for five minutes, leave all the other defaults selected.
1. Optionally, select *Email owners, contributors, and readers* to send email notifications. The default action presents a notification in the portal.
1. Select **OK**.

## Next step

[Creating a customer dashboard in Azure](/azure/azure-portal/azure-portal-dashboards)

