---
title: Optimize cost after migration
description: Use the Cloud Adoption Framework for Azure to learn how to properly decommission retired resources with minimal business interruptions.
author: Zimmergren
ms.author: pnp
ms.date: 04/10/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Optimize cost after migration

After you migrate your workloads to Azure, you should optimize costs to ensure that you don't overspend. This article provides guidance on how to optimize your costs after migration and how to decommission retired assets with minimal business interruptions.

## Optimize migrated workloads for cost

After you migrate your workloads and decommission unneeded resources, you can save on costs by optimizing your workload based on its live data.

You can resize workloads based on their performance during an assessment, but you might find while the workload is running in Azure that there are additional cost savings available.

### Tools for optimizing costs

After you migrate to Azure, you have new tools available to manage your resource costs. Use the following list to help manage your cloud spend.

|Tool|Description|Resource|
|---|---|---|
|Rightsize assets|Review the service usage metrics and rightsize them to match the workload requirements.|<li>[Azure Advisor cost recommendations](/azure/advisor/advisor-reference-cost-recommendations)|
|Azure Reserved Virtual Machine Instances|Reserved instances let you commit to resources in Azure that run frequently. Consider reserving instances for workloads that are always active.|<li>[Manage reservations for Azure resources](/azure/cost-management-billing/reservations/manage-reserved-vm-instance)<br><li>[Azure virtual machine (VM) sizing for maximum reservation usage](/partner-center/azure-usage)|
|Azure savings plans|Azure savings plans provide savings up to 65% compared to pay-as-you-go pricing when you commit to spending a fixed hourly amount on compute services for one or three years.|<li>[Azure savings plans recommendations](/azure/cost-management-billing/savings-plan/purchase-recommendations)|
|Cost management|You can use Microsoft Cost Management to monitor and manage the costs of the environment.|<li>[Cost Management](/azure/cost-management-billing/cost-management-billing-overview)<br><li>[Reservation recommendations in Advisor](/azure/cost-management-billing/reservations/reserved-instance-purchase-recommendations#recommendations-in-azure-advisor)|
|The FinOps framework|FinOps is a discipline that combines financial management principles with cloud engineering and operations to provide organizations with a better understanding of their cloud spending.|<br><li>[What is FinOps?](/azure/cost-management-billing/finops/overview-finops)|

## Decommission retired assets

After you promote a migrated workload to production, the assets that ran the workload are no longer required and are considered out of service. But these assets still consume electricity and other resources which increases costs. Therefore, it's a good idea to shut down and dispose of retired assets to reduce expenses.

Shutting down and disposing of old assets and equipment might seem straightforward but unexpected problems can occur. Here are some tips on how to safely shut down and dispose of old resources without causing any problems for your business.

### Continue monitoring

After you promote a migrated workload to production, you should continue to monitor the assets that are scheduled for retirement to ensure that production traffic is correctly routed.

While assets might be turned off, they might still utilize storage, network, and other infrastructure resources. If they're turned back on, they could cause unexpected problems unless they've been removed.

Monitor the following signals for the resources:

- **Compute**: Resource compute usage, like CPU and RAM.
- **Storage**: Resource storage usage, like disk input/output (I/O).
- **Network**: Resource network usage that includes inbound and outbound networking from appliances. For example, inspect assets that use firewalls and load balancers for communication.
- **Logs**: Windows and application logs.
- **Other signals**: Any other signals that you used to monitor the assets when they were hosted in their previous production environment.

In some migrations, assets aren't turned off. Instead, they're duplicated. Sudden spikes or even consistent moderate usage of infrastructure signals, along with network activity or new logs, can indicate that the asset is still in use.

### Testing windows and dependency validation

Even with the best planning, production workloads might still contain dependencies on assets that are presumed retired. In such cases, turning off a retired asset could cause unexpected system failure. As such, treat the termination of any assets with the same care as system maintenance activity.

Establish proper testing and outage windows to facilitate the termination of the resource. You need a maintenance window to successfully test your assets before termination. Choose a period of time when you can test the assets without causing any business interruptions.

#### Define a testing and maintenance window

- **Low-impact times**: Identify a low-impact time for your testing window. Choose a time when application use is at its lowest.
- **Clear test cases**: Identify clear test cases that you can perform during the testing window that match real activities performed by users of the application. These activities shouldn't be surface level but should instead map out every process used. You can reuse the test cases from your migration if you have them. If you have users or other team members who frequently work in the application, try having them perform the tests.
- **Schedule and communicate**: Schedule a maintenance window for as long as you have available. You should aim for a minimum of four hours.
  - **Schedule**: Plan the window so that application users can plan ahead. Two weeks is reasonable.
  - **Communicate**: Announce the change in advance. Set the expectation that there might be an outage during this maintenance window and that the system might not be responsive. Users shouldn't expect the application to be available during this time.

##### Before the maintenance window

- **Perform test cases**: Run through the test cases and monitor any usage of the resources.
  - **If you discover usage**, you shouldn't proceed with the maintenance window. Instead, you should investigate further to see if the assets are still in use.
  - **If you don't discover usage**, you can proceed with the maintenance window.

##### During the maintenance window

- **Disable assets**: Disable the assets flagged for decommission.
  - Power the assets off if they're still powered on.
  - Remove the assets from any load balancers and confirm they aren't capable of responding to incoming requests.
- **Perform tests**: Perform your test cases against the workload that runs in Azure.
  - **Tests succeeded without failure**: The assets aren't in use at this time.
    - Communicate an end to the change window so that users know that they can expect stability in the application again.
    - Proceed to the next section after the tests succeed.
  - **Tests failed**: The assets might be in use at this time and more testing is necessary.
    - Re-enable the assets flagged for decommission and repeat the failed test cases.
    - If the test cases continue to fail, then there might be an unrelated problem. You need to test more within the maintenance window and should also begin escalation to ensure that you have the right level of support.
    - If the test cases stop failing, then the problem is likely related. You should leave the assets enabled and close out the maintenance window after completing testing.
    - Investigate the problem outside of the scheduled maintenance window. Schedule another maintenance window for changes to the migrated workload, and schedule extra maintenance windows for testing.

### Holding period and data validation

After you complete your testing window, all assets flagged for decommission should be powered off and disconnected so you can operate the workload. You can proceed to the next phase of decommissioning, but don't immediately dispose of the assets.

#### Consider a holding period

It's not uncommon for migrations to miss data during replication processes. This is especially true for older data that isn't accessed regularly. Keep a retired asset for a while to serve as a temporary backup of the data. You should allow at least 30 days for holding and testing before disposing of retired assets.

#### Consider data governance requirements

Your organization's data governance team might have more requirements beyond a 30-day holding period.

- **Understand holding period obligations**: You should check with the necessary teams to understand the obligation for holding on to information and build a validation checklist for your specific legal requirements.
  - Having the asset operational isn't important at this time. Instead, the data on the information should be retrievable. Keep disks or backups to restore the data if necessary.
  - For example, if you have a SQL database server in your physical datacenter, you can back up its data and maintain it as a recoverable resource. Then you can decommission the virtual machine and set a holding time to retire the backup.

## Next step

The migration is complete after you decommission the retired assets. This creates a good opportunity to improve the migration process with a retrospective to learn and improve.

> [!div class="nextstepaction"]
> [Conduct retrospectives](./retrospective.md)
