---
title: Enterprise-scale management and monitoring - Azure VMware Solution
description: Learn how this enterprise-scale scenario can improve management and monitoring of Azure VMware Solution.
author: pgandham
ms.author: janet
ms.date: 09/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank
---

# Management and monitoring for an Azure VMware Solution enterprise-scale scenario

You can achieve operational excellence when you design Azure VMware Solution with management and monitoring in mind. VMware is a critical platform. As a result, you should also include guidance in the enterprise-scale design areas in your planning phase. Guidance is available in the Azure enterprise-scale landing zone for management and monitoring [documentation](../../ready/landing-zone/design-area/management.md).

As you plan out your management and monitoring environment for Azure VMware Solution, it's critical to understand the [Azure VMware Solution shared responsiblity matrix](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/azure-vmware/manage), which shows what components Microsoft is responsible for and what components you are responsible for managing and monitoring.  Microsoft abstracts much of the ongoing maintenance, security, and management, leaving your company in charge of the things that matter most, like guest OS provisioning, applications, and virtual machines.

## Platform management and monitoring

Review the following considerations for platform management and monitoring of Azure VMware Solution.

### Azure tooling considerations

- Create alerts and dashboards on the metrics that are most important to your operations teams. See [Configure alerts for Azure VMware Solution](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities) for available monitoring and alerting metrics.  An example monitoring dashboard is [available on GitHub](https://github.com/Azure/Enterprise-Scale-for-AVS/tree/main/BrownField/Monitoring/AVS-Dashboard).
- vSAN storage is a finite resource that needs to be managed to maintain availability and performance. Familiarize yourself with the Azure VMware Solution storage concepts documented [here](https://docs.microsoft.com/en-us/azure/azure-vmware/concepts-storage). Use vSAN storage for guest virtual machine (VM) workloads only. Review the following design considerations to reduce unnecessary storage use on vSAN.
  - [Configure content libraries on Azure Blob Storage](https://vskeeball.com/2022/03/31/vsphere-content-library-on-azure-blob/) to move VM template storage off of vSAN.
  - Store backups on an Azure virtual machine, either with [Microsoft tooling](/azure/azure-vmware/set-up-backup-server-for-azure-vmware-solution) or choose a [partner vendor](/azure/azure-vmware/ecosystem-back-up-vms).
- The Activity Log provides an immutable reference of operations performed within Azure.  These operations inlcude creation, updates, deletion, and special operations like listing credentials or keys.  As an example, Azure VMware Solution will emit a 'List PrivateClouds AdminCredentials' whenever someone visits the 'Identity' tab within the Azure portal or programmatically requiests CloudAdmin credentials.  Alert rules can be configured to send notifications when specific activities are logged.
- Azure VMware Solution uses a local identity provider. After deployment, use a single administrative user account for the initial Azure VMware Solution configurations. Integrating Azure VMware Solution with [Active Directory](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.psc.doc/GUID-B23B1360-8838-4FF2-B074-71643C4CB040.html) enables traceability of actions to users. Review guidance from the identity portion <!-- link to CDA for identity after finalized --> of the enterprise-scale landing zone documentation.

### VMware tooling considerations

- Consider continuing to use VMware solutions like vRealize Operations Manager and vRealize Network Insights to provide a detailed understanding of the Azure VMware Solution platform. Customers can see monitoring data like vCenter events and flow logs for the NSX-T distributed firewall. 
- *Pull* logging is currently supported by vRealize Log Insight for Azure VMware Solution . Only events, tasks, and alarms can be captured. Syslog pushing of unstructured data from hosts to vRealize isn't currently supported.  SNMP Traps are not supported.
- While Microsoft monitors the health of vSAN, it is possible to utilize vCenter to query and monitor the performance of vSAN.  Performance metrics can be viewed from a VM or backend perspective, showing average latency, IOPS, throughput, and outstanding IO through vCenter.
- vCenter logs can be sent to a Storage Account or Event Hub using the Diagnostic Settings within the Private Cloud resource in Azure.  This is not directly configurable within vCenter, only via the Private Cloud resource in Azure - this is documented [here](https://docs.microsoft.com/en-us/azure/azure-vmware/configure-vmware-syslogs).  This is raw syslog, so consider retention and downstream processing before enabling.
- In-guest memory collection isn't supported by vRealize Operations using VMware tools. Active and consumed memory use will continue to work.

### Guest workload management considerations

- Virtual Machines within Azure VMware Solution are treated the same as on-premises VMware virtual machines by default.  This allows you to continue using existing VM-level monitoring within AVS via existing agents
- Azure VMware Solution Virtual Machines won't show up in the Azure Portal unless Azure Arc for Servers is deployed to them.  [Azure Arc for Servers](https://docs.microsoft.com/en-us/azure/azure-vmware/integrate-azure-native-services#onboard-vms-to-azure-arc-enabled-servers) allows for an agent-based approach to VM management & monitoring from the Azure control plane.  This allows you to apply Azure Policy guest configurations, protect servers with Microsoft Defender, and deploy the Azure Monitor agent to the guest Virtual Machines.

## Design recommendations

Review the following recommendations for platform management and monitoring of Azure VMware Solution.

### Azure tooling recommendations

- Configure Azure Service Health to send alerts for service issues, planned maintenance, and other events that may impact Azure VMware Solution and other services.  These notifications are sent to Action Groups, which can be used to send email, SMS, push notifications, and voice calls to addresses of your choice.  Actions can also trigger Azure and 3rd party systems, including Azure Functions, Logic Apps, Automation Runbooks, Event Hubs, and Webhooks.  Configuring Azure Service Health Alerts is documented [here](https://docs.microsoft.com/en-us/azure/service-health/resource-health-alert-monitor-guide). 
- Conduct baseline performance monitoring of Azure VMware Solution infrastructure through [Azure Monitor - Metrics](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities).  These metrics can be queried and filtered from the Azure Portal, queried via REST API, or directed to Log Analytics, Azure Storage, Event Hubs, or [Partner Integrations](https://docs.microsoft.com/en-us/azure/azure-monitor/partners).
- [Configure the following alerts in Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-overview) for when the Azure VMware Solution cluster is nearing key threshholds for disk, CPU, or RAM:

    | Metric                                    | Alert         |
    |-------------------------------------------|---------------|
    | Disk - Percentage Datastore Disk Used (%) | >70% warning  |
    | Disk - Percentage Datastore Disk Used (%) | >75% critical |
    | CPU - Percentage CPU (%)                  | >80% warning  |
    | Memory - Average Memory Usage (%)         | >80% warning  |

- For service-level agreement (SLA) purposes, Azure VMware Solution requires that the cluster keep slack space of 25 percent available on vSAN.
- For service-level agreement (SLA) purposes, Azure VMware Solution requires the number of failures to tolerate = 1 for clusters that have between three and five and the number of failures to tolerate = 2 for clusters that have between six and sixteen hosts.  The full SLA is documented [here](https://azure.microsoft.com/en-us/support/legal/sla/azure-vmware/v1_1/).
- Integrate the Azure VMware Solution vCenter with an existing identity provider<!-- link to identity CDA after completed -->.
- In a hybrid environment, [monitor the ExpressRoute circuit from on-premises into Azure](https://docs.microsoft.com/en-us/azure/network-watcher/connection-monitor-create-using-portal).
- Configure two connection monitors in [Azure Network Watcher](https://docs.microsoft.com/en-us/azure/network-watcher/network-watcher-monitoring-overview) to monitor connectivity.
  - [Configure the first Connection Monitor](https://docs.microsoft.com/en-us/azure/network-watcher/connection-monitor-create-using-portal) between an Azure-based resource and an Azure VMware Solution-based VM. This monitor lets you see the availability and performance of the network connection between Azure and Azure VMware Solution over ExpressRoute.
  - [Configure the second Connection Monitor](https://docs.microsoft.com/en-us/azure/network-watcher/connection-monitor-create-using-portal) between an on-premises-based VM and an Azure VMware Solution-based VM. This monitor lets you see the availability and performance of network connections between on-premises and Azure VMware Solution over ExpressRoute Global Reach.

### VMware tooling recommendations

- During workload migration, use the model of "monitor-as-on-premises" to minimize the change during migration and provide the vSphere Administrators the experience they're accustomed to.
  -  Monitor vSphere Health Status as documented [here](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.monitoring.doc/GUID-F957C1BB-A032-4648-9310-68A94733ABC8.html).
  - Create vSphere events, alarms, and actions as documented [here](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.monitoring.doc/GUID-9272E3B2-6A7F-427B-994C-B15FF8CADC25.html).
- Consider using vRealize Log Insight for [monitoring the NSX-T environment](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.2/administration/GUID-8E3CA63B-71F8-4F47-88A6-DC5FA714DE8B.html).

### Guest workload management recommendations

Review the following recommendations for guest management and monitoring of workloads running in Azure VMware Solution.

- During workload migration, use the model of "monitor-as-on-premises" to minimize change during migration. After migration, consider using a [Azure Arc for Servers](/azure/azure-arc/servers/overview) to enable management and monitoring of Azure VMware Solution hosted workloads with Azure native solutions.
- Azure VMware Solution implements a default storage policy with thick provisioning enabled. For efficient use of vSAN capacity, evaluate using thin provisioning for VMs. Each VM's disk configuration  can vary. A VM can have thick or thin disks, or both, dependent on the requirements for the workload.
- Configure guest monitoring for VMs running in Azure VMware Solution by following the [hybrid guidance](/azure/azure-monitor/vm/monitor-virtual-machine) for Windows and Linux. Configure both Windows and Linux this way for the following Azure integrations:

    | Integration                                                                         | Description                                                                                                                                                                                                                                                                  |
    |-------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | [Log Analytics](/azure/azure-monitor/logs/log-analytics-overview)                   | Primary tool for aggregating, querying, and interactively analyzing logs generated by Azure resources.                                                                                                                                                                       |
    | [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction) | Unified infrastructure security management system that strengthens security posture by providing advanced threat protection across hybrid and Azure resources. Assessments continually run and vulnerabilities of the Azure VMware Solution VMs report to the Azure service. |
    | [Microsoft Sentinel](/azure/sentinel/overview)                                      | Cloud-native security information and event management solution. This Azure resource provides security analytics, alert detection, and automated threat response across on-premises and cloud environments.                                                                  |
    | [Azure Update Management](/azure/automation/update-management/overview)             | Manages operating system updates for Windows and Linux machines on-premises and in cloud environments.                                                                                                                                                                       |
    | [Azure Monitor](/azure/azure-monitor/overview)                                      | Comprehensive monitoring solution for collecting, analyzing, and acting upon telemetry from cloud and on-premises environments.                                                                                                                                              |

## Other considerations

- If you're using a network virtual appliance, consider monitoring trace logs between both on-premises and Azure. Ensure monitoring is in place between Azure and Azure VMware Solution.

- To help with storage concerns on the vSAN, consider using [Azure disk pools (preview)](/azure/virtual-machines/disks-pools-deploy) or [Azure NetApp Files](/azure/azure-netapp-files/) to extend your storage footprint into Azure native storage services.

## Next steps

Learn about design considerations for Azure VMware Solution business continuity and disaster recovery in an enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md)