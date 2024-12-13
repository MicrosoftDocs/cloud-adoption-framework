---
title: Management baseline for Citrix on Azure
description: Learn how the management baseline can improve management and monitoring of Citrix on Azure.
author: BenMartinBaur
ms.author: bebaur
ms.date: 01/06/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Management baseline considerations for Citrix on Azure

Management and monitoring are critical to any deployment of Citrix DaaS (desktop as a service) on Azure. To achieve operational excellence and success you should properly design your Citrix DaaS environment with management and monitoring in mind.

## Citrix design considerations

Both Microsoft and Citrix provide a set of core tools and services for monitoring the environment. This article lists some tools and recommends what to monitor.

The Microsoft tools and services include Azure Monitor, Azure Advisor, Azure Service Health, Microsoft Sentinel, and Azure Network Watcher. The Citrix tools and services include Citrix Monitor, Citrix Analytics, and Citrix Managed Services. Most of these services are included with your subscriptions, but some cost extra.

For information about Microsoft tools to use with Citrix DaaS, visit the [Citrix Tech Zone](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/daas-for-azure.html#microsoft). For more information about Citrix tools, see [Citrix DaaS for Azure](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/daas-for-azure.html#microsoft) and [Citrix application delivery management](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/daas-for-azure.html#citrix-application-delivery-management-adm-service).

## Citrix design recommendations

### Metrics and alert Thresholds

For a Citrix deployment, focus on the Guest OS metrics of Citrix virtual machines. Poor server performance metrics typically indicate that the users are about to experience performance issues, or that they already have. For instance, when the Max Input Delay for a user session reaches a predefined value, we know that users are experiencing latency. You can configure the Action group to send an email to the Citrix administrators that alerts them to the issue so that they can intervene proactively.

This article tells you what performance counters to monitor and suggests alerting thresholds that are appropriate for a Citrix deployment. The suggested alert thresholds are likely to provide advance notice of performance issues. Adjust the values and time periods to meet your needs.

### All Citrix Servers

Here is the list of perfmon counters to monitor for all Citrix servers in the deployment:

- Processor\%Processor time
  - This counter is the amount of time a processor is active.
  - Alert when the average is greater than 80% for 15 minutes.
  - Use Task Manager or Citrix Monitor to determine which processes are consuming the most CPU. Identify the cause of the high CPU usage.
  - If all processes are consuming an expected level of CPU time, then it's time to increase the capacity of the server or the delivery group.
- System\Processor queue length
  - This counter is the number of threads in a processor queue that are waiting to be processed.
  - Alert when the counter is greater than 5 times the number of cores for a 5-minute interval.
  - Use Task Manager or Citrix Monitor to determine which processes are consuming the most CPU.
  - If all processes are consuming an expected level of CPU, then it's time to increase the capacity of the server or the delivery group.
- Memory\Available Bytes
  - This counter is the amount of memory that's not allocated to processes or cache.
  - Alert when the available amount of RAM is under 20% of the total RAM for a 5-minute interval.
  - Use Task Manager or Citrix Monitor to determine which processes are consuming the most RAM. Identify any configuration changes that could reduce that level of RAM consumption. Use this metric with the Memory Pages/sec and Paging File %usage counters.
  - If all processes are consuming the expected amount of memory, then it's time to increase the capacity of the server or the delivery group.
- Memory\Pages/sec
  - This counter is the number of pages per second that are swapped from disk to RAM.
  - Alert when the pages per second are consistently over 10.
  - Use Task Manager to look for applications that are causing the page swaps. Investigate possible alternative configurations. Use this metric with the Memory Available Bytes and Paging Files\%usage counters.
  - If possible, increase the amount of RAM that's available to the host. If that's not an option, attempt to isolate the application to a set of dedicated servers.
- Paging File\%usage
  - This counter is the percentage of the current page file that's in use.
  - Alert when the page file usage is greater than 80% for 60 minutes.
  - Use Task Manager to look for applications that are causing the page file usage. Investigate possible alternative configurations. Use this metric with the Memory Available Bytes and Memory Pages/sec counters.
  - If possible, increase the amount of RAM available to the host.
- LogicalDisk\%Disk Time (_total)
  - This counter represents the amount of time that the logical disk is active.
  - Alert when the % disk time is greater than 90% for 15 minutes.
  - Use Task Manager or Citrix Monitor to look for applications that are causing the high disk usage. Investigate what might be causing the high disk usage. Use this metric with other logical and physical disk metrics.
  - If all activity looks normal, look for a way to move the applications to disks that have higher performing disk subsystems.
- LogicalDisk\Current disk queue length
  - This counter represents the number of transactions that are waiting for the logical disk to process requests.
  - Alert when the current disk queue is greater than 3 for 15 minutes.
  - Use Task Manager or Citrix Monitor to look for applications that are causing the high disk usage. Investigate what might be causing the high disk usage. Use this metric with other logical and physical disk metrics.
  - If all activity looks normal, look for a way to move the applications to disks that have higher performing disk subsystems.
- PhysicalDisk\%Disk Time (_total)
  - This counter represents the amount of time that the physical disk is active.
  - Alert when the % disk time is greater than 90% for 15 minutes.
  - Use Task Manager or Citrix Monitor to look for applications that are causing the high disk usage. Investigate what might be causing the high disk usage. Use this metric with other logical and physical disk metrics.
  - If all activity looks normal, look for a way to move the applications to disks that have higher performing disk subsystems.
- PhysicalDisk\Current disk queue length
  - This counter represents the number of transactions that are waiting for the physical disk to process their disk requests.
  - Alert when the current disk queue is greater than 3 for 15 minutes.
  - Use Task Manager or Citrix Monitor to look for applications that are causing the high disk usage. Investigate what might be causing the high disk usage. Use this metric with other logical and physical disk metrics.
  - If all activity looks normal, look for a way to move the applications to disks that have higher performing disk subsystems.
- Network Interface\Bytes Total/sec
  - This counter shows the rate at which the network adaptor is processing data packets for the network.
  - Alert when Bytes Total per second is greater than 80% of the NIC capacity for 5 minutes.
  - Use Task Manager to look for applications that are causing the high network usage. Try to determine what might be causing the high network utilization. Use this metric with other logical and physical network metrics.
  - If all activity looks normal, look for a way to increase the network bandwidth or increase the capacity to the delivery group.
- User Input Delay per Session\Max Input Delay
  - This metric provides the maximum input delay for the session in milliseconds. The metric measures the time from when the user provides mouse or keyboard input until the input is processed by the system.
  - Alert when a session’s input delay is greater than 1000ms for 2 minutes.
  - Use Task Manager or Citrix Monitor to look for applications that are causing high CPU, disk, or network usage.
  - If activity looks normal, the best approach is to increase the capacity to the delivery group.

For more recommendations for using Citrix components, see: [Baseline Metrics and Alerts for Azure](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/daas-for-azure.html#microsoft).

## General recommendations

Here are some general recommendations and practices to consider as you use these tools.

- Tracking performance monitor metrics for virtual machines and the network is easier to do from Azure Monitor. The Azure Monitor metrics are more granular than what is available from Citrix Monitor. Use Azure Monitor for the performance metrics to have more control over the metrics that are collected.
- Set your monitoring data retention to as short a period as possible for your business requirements. Most monitoring data is only useful for a short period of time. Save costs by not storing monitoring data long-term. Create an automation job to clean up stale data in your storage accounts.
- Azure includes alerts for metrics, logs, service outages, planned maintenance, monthly cost, and security. Using alerts can be a life saver. This article provides many recommendations about alerts to create for your Citrix deployment. Implement the ones that make the most sense in your environment. Send critical alerts via SMS and email to ensure that they're acted upon quickly. Set a reminder on your calendar each quarter to update the alert notification lists.
- Monitoring and alerting on a metric comes with a monthly cost. Choose wisely which metrics to track. If you don't plan on taking action when an alert fires, then consider whether the metric has value.
- Set up a custom dashboard for your Citrix resource groups and enable links to key services such as Microsoft Sentinel, Service Health, Traffic Analytics, and Advisor. On the dashboard, include  charts that show the performance of your ExpressRoute or VPN connections, your Cloud Connectors, and Citrix VDA hosts. To protect sensitive information, restrict dashboard access to only those individuals who need it.
- When troubleshooting an issue, look at multiple data sources to help correlate the symptoms to the root cause. For instance, if the average logon duration is high, you can view the metrics in Azure to determine where resource constraints exist.
- Enabling Traffic Analytics and NSG logs is the best way to see if traffic is originating from unexpected locations. You can use this information to streamline your network communications. Use the information to create Azure policies that block inbound traffic from those unexpected locations.

## Next steps

Review the critical design considerations and recommendations for security and compliance specific to the deployment of Citrix on Azure.

- [Security and compliance](citrix-security-governance-compliance.md)
