---
title: Management baseline for Citrix on Azure
description: Learn how the management baseline can improve the management and monitoring of Citrix on Azure.
author: bebaur
ms.author: martinek
ms.date: 01/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

## Citrix: Management Baseline Considerations for Citrix on Azure

Management and monitoring are critical to any customer deploying Citrix DaaS on Azure. To achieve operational excellence and success you should properly design your Citrix DaaS environment with management and monitoring in mind.

**Citrix design considerations**
	
Both Microsoft and Citrix provide a set of core tools and services to assist with monitoring the environment. We will touch upon the available tools along with recommendations for areas to monitor targeted for Citrix deployments in Azure.
The Microsoft tools and services include the following: Azure Monitor, Azure Advisor, Azure Service Health, Microsoft Sentinel, Azure Network Watcher, and Azure Spend. The Citrix tools and services include the following: Citrix Monitor, Citrix Analytics, and Citrix Managed Services. Some of these services do incur extra charges, but most of them are included with your subscription.
	
For further details on Microsoft tooling with Citrix DaaS visit the [Citrix Tech Zone](https://docs.citrix.com/en-us/tech-zone/toc/by-solution/daas-for-azure/monitoring.html#microsoft) 
and for further details on Citrix tooling visit [Citrix DaaS for Azure](https://docs.citrix.com/en-us/tech-zone/toc/by-solution/daas-for-azure/monitoring.html#citrix) or [Citrix application delivery management](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/azure-network-scalability-considerations.html#citrix-application-delivery-management-adm-service).

**Citrix design recommendations**

**Metrics and Alert Thresholds**
	
For a Citrix deployment, we are going to focus primarily on the Guest OS metrics of Citrix virtual machines. Poor server performance metrics typically indicate that the users are about to experience unpleasant issues, if they are not already. For instance, when the Max Input Delay for a user’s session reaches a predefined delay we know users are experiencing latency. You can configure the Action group to send an email to the Citrix administrators alerting them to the server’s issues. By setting the notification alert to fire off when the Max Input Delay approaches a value known to be unacceptable, admins can intervene proactively.
We have provided the performance counters to monitor along with suggested thresholds for alerting on those counters when used in a Citrix deployment. The suggested alert thresholds are likely to provide advanced notice of user dissatisfaction. Adjust the values and time periods to meet your business needs:

All Citrix Servers

Here is the list of perfmon counters to monitor for all Citrix servers in the deployment:
-	Processor\%Processor time
	-	This counter is the amount of time a processor is not idle.
		Alert when the average is greater than 80% for a sustained 15 minutes.
	-	Determine the processes that are consuming the most CPU and identify the cause of the high CPU usage using Task Manager or Citrix Monitor.
	-	If all processes are consuming an expected level of CPU time, then it is time to increase capacity for the server or the Delivery Group.
-	System\Processor queue length
	-	This counter is the number of threads in a processor queue waiting to be processed.
	-	Alert when greater than 5* [number of cores] over a 5-minute interval.
	-	Determine which processes are consuming the most CPU and identify the cause of the CPU usage using Task Manager or Citrix Monitor.
	-	If all processes are consuming an expected level of CPU time, then it is time to increase capacity for the server or the Delivery Group.
-	Memory\Available Bytes
	-	This counter is the amount of memory not allocated to processes or cache.
	-	Alert when the available amount of RAM is under 20% of the total RAM over a 5-minute interval.
	-	Determine which processes are consuming the memory using Task Manager or Citrix Monitor. Identify any configuration changes that could reduce that level of RAM consumption. Use this metric with the Memory Pages/sec and Paging File %usage counters.
	-	If all processes are consuming the expected amount of memory, then it is time to increase capacity for the server or the Delivery Group.
-	Memory\Pages/sec
	-	This counter is the number of pages per second that are swapped from disk to running memory.
	-	Alert when the pages per second are consistently over 10.
	-	Look for applications that are causing the page swaps using Task Manager. Investigate possible alternative configurations. Use this metric with the Memory Available Bytes and Paging Files\%usage counters.
	-	If possible, increase the amount of RAM available to the host. If that is not an option, attempt to isolate the application to a set of dedicated servers.
-	Paging File\%usage
	-	This counter is the percentage of the current page file that is in use.
	-	Alert when the page file usage is greater than 80% for 60 minutes.
	-	Look for applications that are causing the page file usage using Task Manager. Investigate possible alternative configurations. Use this metric with the Memory Available Bytes and Memory Pages/sec counters.
	-	If possible, increase the amount of RAM available to the host.
-	LogicalDisk\%Disk Time (_total)
	-	This counter represents the amount of time the Logical disk is not idle.
	-	Alert when the % disk time is greater than 90% for 15 minutes.
	-	Look for applications that are causing the high disk usage using Task Manager or Citrix Monitor. Investigate what might be causing the high disk utilization. Use this metric with other logical and physical disk metrics.
	-	If all activity looks normal, look for a way to move the applications to disks with higher performing disk subsystems.
-	LogicalDisk\Current disk queue length
	-	This counter represents the number transactions waiting for the logical disk to process them.
	-	Alert when the current disk queue is greater than 3 for 15 minutes.
	-	Look for applications that are causing the high disk usage using Task Manager or Citrix Monitor. Investigate what might be causing the high disk utilization. Use this metric with other logical and physical disk metrics.
	-	If all activity looks normal, look for a way to move the applications to disks with higher performing disk subsystems.
-	PhysicalDisk\%Disk Time (_total)
	-	This counter represents the amount of time the Physical disk is not idle.
	-	Alert when the % disk time is greater than 90% for 15 minutes.
	-	Look for applications that are causing the high disk usage using Task Manager or Citrix Monitor. Investigate what might be causing the high disk utilization. Use this metric with other logical and physical disk metrics.
	-	If all activity looks normal, look for a way to move the applications to disks with higher performing disk subsystems.
-	PhysicalDisk\Current disk queue length
	-	This counter represents the number transactions waiting for the physical disk to process them.
	-	Alert when the current disk queue is greater than 3 for 15 minutes.
	-	Look for applications that are causing the high disk usage using Task Manager or Citrix Monitor. Investigate what might be causing the high disk utilization. Use this metric with other logical and physical disk metrics.
	-	If all activity looks normal, look for a way to move the applications to disks with higher performing disk subsystems.
-	Network Interface\Bytes Total/sec
	-	This counter shows the rate at which the network adaptor is processing data packets for the network.
	-	Alert when Bytes Total per second are greater than 80% of the NIC’s speed for 5 minutes.
	-	Look for applications that are causing the high network usage using Task Manager to investigate what might be causing the high disk utilization. Use this metric with other logical and physical disk metrics.
	-	If all activity looks normal, look for a way to increase the network bandwidth or increase capacity to the Delivery Group.
-	User Input Delay per Session\Max Input Delay
	-	This metric provides the maximum input delay for the session in milliseconds. The metric measures the time between when the user provides mouse or keyboard input and their input is processed by the system.
	-	Alert when a session’s input delay is greater than 1000ms for 2 minutes.
	-	Look for applications that are causing high CPU, disk, or network utilization using the Task Manager or Citrix Monitor.
	-	If activity looks normal, the best approach is to increase capacity to the Delivery Group.

For more specific Citrix component recommendation check: https://docs.citrix.com/en-us/tech-zone/toc/by-solution/daas-for-azure/monitoring.html#baseline-metrics-and-alerts-for-azure 

**General recommendations**
Here are some general recommendations and practices to consider as you use these tools.
-	Tracking performance monitor metrics for virtual machines and the network is easier to do from the Azure Monitor. The Azure Monitor metrics are more granular than what is available within Citrix Monitor. Use Azure Monitor for the performance metrics because you have more control over the metrics collected.
-	Set your monitoring data retention to as short a period as possible for your business requirements. Most monitoring data is only useful for a short period of time. Save costs by not storing monitoring data long-term. Create an automation job to go out and clean up stale data in your storage accounts.
-	Azure includes alerts for metrics, logs, service outages, planned maintenance, monthly cost, and security. Using alerts can be a life saver. We have made a significant number of recommendations around alerts to create for your Citrix deployment. You only need to implement the ones that make the most sense in your environment. Send critical alerts via SMS and email to ensure they are acted upon quickly. Set a reminder on your calendar each quarter to go in and update the alert notification lists.
-	Monitoring and alerting on a metric comes with a monthly cost. Choose wisely which metrics to track. If you do not plan on taking action when an alert fires, then consider if the metric is still necessary to keep around.
-	Setup a custom dashboard for your Citrix resource groups and enable links to key services such as Sentinel, Service Health, Traffic Analytics, Advisor. Include on the dashboard charts that show the performance of your ExpressRoute or VPN connections, your Cloud Connectors and Citrix VDA hosts. Restrict dashboard access to only those individuals who need that information to prevent any sensitive information from inadvertently reaching unintended audiences.
-	When troubleshooting an issue, look at multiple data sources to help correlate the symptoms to the root cause. For instance, if the average logon duration is high, you can view the metrics in Azure to determine where the resources constraints exist.
-	Enabling Traffic Analytics and NSG logs is the best way to see if traffic is originating from unexpected locations. Using this information you can streamline your network communications. Use the information to create Azure policies that block inbound traffic from those unexpected locations.
	
## Next steps

Review the critical design considerations and recommendations for security and compliance specific to the deployment of Citrix on Azure.

- [Secuirty and compliance](./ctx-security-governance-and-compliance.md)