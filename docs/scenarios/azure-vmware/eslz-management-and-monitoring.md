---
title: Management and monitoring for Azure VMware Solution
description: Learn how to improve management and monitoring of Azure VMware Solution with this enterprise-scale scenario.
author: Prasad3017
ms.author: pgandham
ms.date: 08/04/2022
ms.topic: conceptual
ms.custom: e2e-azure-vmware, think-tank
---

# Management and monitoring for Azure VMware Solution enterprise-scale scenario

Proper management and monitoring are critical to the success of [Azure VMware Solution](https://azure.microsoft.com/services/azure-vmware/). This enterprise-scale scenario outlines important recommendations for the design of your environment. More guidance is available in the Azure enterprise-scale [landing zone for management and monitoring](../../ready/landing-zone/design-area/management.md).

> [!IMPORTANT]
> Monitoring of the platform is part of the Azure VMware Service, monitoring workloads or applications, utilization of components such as hosts memory, compute or storage, vCenter, NSX-Manager, NSX edge VMs, and vSAN or other datastore utilization are part of customer responsibility. While Azure VMware does provide some out of the box insights and examples, given below, it is highly recommended customers keep leveraging existing monitoring or logging platforms in use on-premises and where possible extend to the cloud versions of such products to ensure uninterrupted operation of critical workloads.

As you plan your management and monitoring environment for Azure VMware Solution, it's critical to understand the [shared responsibility matrix](./manage.md). The matrix shows which components Microsoft is responsible for, and which ones that you're responsible for managing and monitoring. Microsoft takes care of the ongoing maintenance, security, and management of cloud resources, leaving your company in charge of the things that matter most, like guest OS provisioning, applications, and virtual machines.

> [!IMPORTANT]
> To support Azure VMware Solution, it's important to follow the recommendations below to configure service health alerts.

## Platform management and monitoring

Review the following *considerations* for platform management and monitoring of Azure VMware Solution. These considerations are included in the [Azure Monitor baseline alerts (AMBA)](https://azure.github.io/azure-monitor-baseline-alerts/welcome/). Azure Monitor baseline alerts (AMBA) are a structured approach across multiple Azure resources and patterns to create alerts for resolution of issue across health, performance, and security.

### Azure tooling considerations

- Create alerts and dashboards for the metrics that are most important to your operations teams. See [Configure alerts for Azure VMware Solution](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities) for available monitoring and alerting metrics. An example monitoring dashboard is [available on GitHub](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/BrownField/Monitoring/AVS-Dashboard).
- vSAN storage is a limited resource that needs to be managed to maintain availability and performance. Familiarize yourself with [Azure VMware Solution storage concepts](/azure/azure-vmware/concepts-storage). Use vSAN storage for guest virtual machine (VM) workloads only. Review the following design considerations to reduce unnecessary storage use on vSAN.
  - [Configure content libraries on Azure Blob Storage](https://vskeeball.com/2022/03/31/vsphere-content-library-on-azure-blob/) to move VM template storage off of vSAN.
  - Store backups on an Azure VM, either with [Microsoft tooling](/azure/azure-vmware/set-up-backup-server-for-azure-vmware-solution) or with a [partner vendor](/azure/azure-vmware/ecosystem-back-up-vms).
- The Activity Log provides a record of operations performed within Azure. These operations include creation, updates, deletion, and special operations like listing credentials or keys. For example, Azure VMware Solution will emit a `List PrivateClouds AdminCredentials` whenever someone visits the *Identity* tab within the Azure portal or programmatically requests `cloudadmin` credentials. Alert rules can be configured to send notifications when specific activities are logged.
- Azure VMware Solution uses a local identity provider. After deployment, use a single administrative user account for the initial Azure VMware Solution configurations. Integrating Azure VMware Solution with [Active Directory](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.psc.doc/GUID-B23B1360-8838-4FF2-B074-71643C4CB040.html) allows traceability of actions to users. Review guidance from the [identity portion of the landing zone](../../ready/landing-zone/design-area/identity-access.md).
- Use [Run command to take a snaphot of HCX Manager](/azure/azure-vmware/use-hcx-run-commands#take-a-snapshot-of-vmware-hcx-cloud-manager) before making any critical changes to HCX Manager. Additionally, capture snapshot for HCX Manager before you initiate a maintenance activity. Snapshots are retained for 72 hours for any backout plan as needed. Contact Microsoft Support team for restoring a snapshot.  

### VMware tooling considerations

- Consider VMware solutions like vRealize Operations Manager and vRealize Network Insights to provide a detailed understanding of the Azure VMware Solution platform. Customers can see monitoring data like vCenter Server events and flow logs for the NSX-T Data Center distributed firewall.
- Metrics available in vRealize Operations are documented in [VMware's vRealize Operations documentation](https://docs.vmware.com/en/vRealize-Operations/8.6/com.vmware.vcom.metrics.doc/GUID-C272EDE0-49E0-44D6-B47F-C32723AC9246.html).
- *Pull* logging is currently supported by vRealize Log Insight for Azure VMware Solution. Only events, tasks, and alarms can be captured. Syslog pushing of unstructured data from hosts to vRealize isn't currently supported. SNMP Traps aren't supported.
- While Microsoft monitors the health of vSAN, it's possible to utilize vCenter Server to query and monitor the performance of vSAN. Performance metrics can be viewed from a VM or backend perspective, showing average latency, IOPS, throughput, and outstanding IO through vCenter.
- vCenter Server logs can be sent to Storage Accounts or Event Hubs using the Diagnostic Settings within the Private Cloud resource in Azure. Log settings aren't directly configurable within vCenter Server, only via the Private Cloud resource in Azure. More information is available in the [configuring VMware syslog documentation](/azure/azure-vmware/configure-vmware-syslogs). The output is raw syslog, so consider retention and downstream processing before enabling.
- In-guest memory collection isn't supported by vRealize Operations using VMware tools. Active and consumed memory will continue to work.

### Guest workload management considerations

- Virtual machines within Azure VMware Solution are treated the same as on-premises VMware vSphere VMs by default. You can continue using existing VM-level monitoring within AVS via existing agents.
- Azure VMware Solution VMs won't show up in the Azure portal unless [Azure Arc for Servers](/azure/azure-vmware/integrate-azure-native-services#onboard-vms-to-azure-arc-enabled-servers) is deployed to them. Azure Arc for Servers allows for an agent-based approach to VM management & monitoring from the Azure control plane. You can apply Azure Policy machine configurations, protect servers with Microsoft Defender, and deploy the Azure Monitor agent to the guest VMs.

## Design recommendations

Review the following *recommendations* for platform management and monitoring of Azure VMware Solution.

### Azure tooling recommendations

- Configure [Azure Service Health to send alerts](/azure/service-health/resource-health-alert-monitor-guide) for service issues, planned maintenance, and other events that could impact Azure VMware Solution and other services. These notifications are sent to Action Groups, which can be used to send email, SMS, push notifications, and voice calls to addresses of your choice. Actions can also trigger Azure and third-party systems, including Azure Functions, Logic Apps, Automation Runbooks, Event Hubs, and Webhooks. 
- Monitor baseline performance of Azure VMware Solution infrastructure through [Azure Monitor Metrics](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities). These metrics can be queried and filtered from the Azure portal, queried via REST API, or directed to Log Analytics, Azure Storage, Event Hubs, or [Partner Integrations](/azure/azure-monitor/partners).
- Use the following [Azure Monitor baseline alerts](https://azure.github.io/azure-monitor-baseline-alerts/patterns/specialized/avs/) to provide warnings if the cluster nears dangerous values for disk, CPU, or RAM usage:

| Name                              | Threshold(s) (Severity) | Signal Type        | Frequency       | # Alert Rules |
| :--------------------------------- | ----------------------: | :----------------- | :--------------- | ------------: |
| CPU - Percentage CPU (%)             | 80 (2)                  | EffectiveCpuAverage| Every 5 minutes | 1             |
| CPU - Percentage CPU (%) (Critical)  | 95 (0)                  | EffectiveCpuAverage| Every 5 minutes | 1             |
| Memory - Average Memory Usage (%)          | 80 (2)                  | UsageAverage       | Every 5 minutes | 1             |
| Memory - Average Memory Usage (%) (Critical) | 95 (0)                  | UsageAverage       | Every 5 minutes | 1             |
| Disk - Percentage Datastore Disk Used (%)  | 70 (2)            | DiskUsedPercentage | Every 5 minutes | 1             |
| Disk - Percentage Datastore Disk Used (%) (Critical) | 75 (0)            | DiskUsedPercentage | Every 5 minutes | 1             |
| Service Health Alerts             | N/A                     | ServiceHealth      | N/A             | 1             |

- You can automate the creation of [Azure Monitor Alerts](https://github.com/Azure/Enterprise-Scale-for-AVS/blob/main/BrownField/Monitoring/AVS-Utilization-Alerts/readme.md) and [Azure Service Health alerts](https://github.com/Azure/Enterprise-Scale-for-AVS/blob/main/BrownField/Monitoring/AVS-Service-Health/readme.md).
- For service-level agreement (SLA) purposes, Azure VMware Solution requires slack space of 25 percent available on vSAN.
- For SLA purposes, Azure VMware Solution requires the number of failures to `tolerate = 1` for clusters that have between three and five hosts, and the number of failures to `tolerate = 2` for clusters with 6-to-16 hosts. The full SLA is documented in the following [service level agreement](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/).
- In a hybrid environment, you can use [Connection Monitor](/azure/network-watcher/connection-monitor-create-using-portal) to monitor communication between on-premises and Azure resources.
- Configure two connection monitors in [Azure Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) to monitor connectivity.
  - [Configure Connection Monitor](/azure/network-watcher/connection-monitor-create-using-portal) to view the availability and performance of the network connections within, from, and to the Azure VMware Solution, including ExpressRoute Direct and ExpressRoute Global Reach connections.
- Send your logs to Log Analytics. 
For more information, see [Send Logs to Log Analytics](/azure/azure-vmware/send-logs-to-log-analytics).

### VMware tooling recommendations

- During workload migration, use the "monitor-as-on-premises" model to minimize changes during migration and provide vSphere Administrators with the experience they're accustomed to.
- Monitor [vSphere Health Status](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.monitoring.doc/GUID-F957C1BB-A032-4648-9310-68A94733ABC8.html).
  - Create [vSphere events, alarms, and actions](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.monitoring.doc/GUID-9272E3B2-6A7F-427B-994C-B15FF8CADC25.html).
- Consider using vRealize Log Insight for [monitoring a NSX-T Data Center environment](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.2/administration/GUID-8E3CA63B-71F8-4F47-88A6-DC5FA714DE8B.html).

### Guest workload management recommendations

Review the following recommendations for guest management and for monitoring of workloads running in Azure VMware Solution.

- During workload migration, use the "monitor-as-on-premises" model to minimize changes during migration. After migration, consider using [Azure Arc for Servers](/azure/azure-arc/servers/overview) to enable management and monitoring of Azure VMware Solution-hosted workloads with Azure native solutions.
- The default storage policy uses thick provisioning. For efficient use of vSAN capacity, evaluate using thin provisioning for VMs. Each VM's disk configuration can vary. A VM can have thick or thin disks, or both, depending on the requirements for the workload.
- Configure guest monitoring for VMs by following the [hybrid guidance](/azure/azure-monitor/vm/monitor-virtual-machine) for Windows and Linux. Configure both Windows and Linux this way for the following Azure integrations:

    | Integration                                                                         | Description                                                                                                                                                                                                                                                                  |
    |-------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | [Log Analytics](/azure/azure-monitor/logs/log-analytics-overview)                   | Primary tool for aggregating, querying, and interactively analyzing logs generated by Azure resources.                            |
    | [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction) | Unified infrastructure security management system that strengthens security posture by providing advanced threat protection across hybrid and Azure resources.  |
    | [Microsoft Sentinel](/azure/sentinel/overview)                                      | Cloud-native security information and event management solution. This Azure resource provides security analytics, alert detection, and automated threat response across on-premises and cloud environments.                                                                   |
    | [Azure Update Management](/azure/automation/update-management/overview)             | Manages operating system updates for Windows and Linux machines on-premises and in cloud environments.                                 |
    | [Azure Monitor](/azure/azure-monitor/overview)                                      | Comprehensive monitoring solution for collecting, analyzing, and acting upon telemetry from cloud and on-premises environments.                                                                         |

## Storage considerations

To help with storage-heavy workloads that need more storage capacity than vSAN provides based on the CPU and memory requirements, consider using [Azure NetApp Files](/azure/azure-netapp-files/) to extend your storage footprint into Azure native storage services.

Azure VMware Solution supports attaching Network File System (NFS) datastores as a persistent storage option. You can create NFS datastores with Azure NetApp Files volumes and attach them to clusters of your choice. By using NFS datastores backed by Azure NetApp Files, you can extend your storage instead of scaling the clusters. You can also use Azure NetApp Files volumes to replicate data from on-premises or primary VMware environments to a secondary site.

For more information read [Azure NetApp Files datastores for Azure VMware Solution](/azure/azure-vmware/attach-azure-netapp-files-to-azure-vmware-solution-hosts).

## Other considerations

- If you use a network virtual appliance, consider monitoring trace logs between on-premises and Azure resources. Ensure monitoring is in place between Azure and Azure VMware Solution.

## Next steps

Learn about design considerations for Azure VMware Solution business continuity and disaster recovery in an enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md)
