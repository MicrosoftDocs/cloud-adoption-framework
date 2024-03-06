---
title: Post-migration cost optimization
description: Use the Cloud Adoption Framework for Azure to learn how to properly decommission retired resources with minimal business interruptions.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/14/2024
ms.topic: conceptual
---

# Post-migration cost optimization

> TBD

## Optimize migrated workloads for cost

After workloads are migrated and unneeded resources are decommissioned, you might still be able to save on your costs by optimizing your workload based on its live data.

While you likely resize workloads based on their performance during the assessment, you might find while running in Azure that there are additional cost savings available.

You should do this as part of implementing the [Cost management discipline](/azure/cloud-adoption-framework/govern/cost-management/). You can use FinOps practices to help you better manage your costs in the cloud. For more information, see [What is FinOps?](/azure/cost-management-billing/finops/overview-finops).

### Tools for optimizing costs

Now that you have migrated to Azure, you have new tools available for how you can manage your resource costs. Use the list below to help manage your cloud spend.

|Tool|Description|Resource|
|---|---|---|
|Right-size assets|Review the usage metrics for the services and right-size them to match the workload requirements.|[Azure Advisor cost recommendations](/azure/advisor/advisor-reference-cost-recommendations).|
|Reserved Instances.|Reserved instances let you commit to resources in Azure that will be running frequently.  Consider reserving instances for always on workloads.|<li>[Manage reservations for Azure resources](/azure/cost-management-billing/reservations/manage-reserved-vm-instance)<br><li>[Azure VM sizing for maximum reservation usage](/partner-center/azure-usage).|
|Azure savings plans|Azure savings plans provides savings up to 65% off pay-as-you-go pricing when you commit to spend a fixed hourly amount on compute services for one or three years.|[Azure savings plans recommendations](/azure/cost-management-billing/savings-plan/purchase-recommendations)|
|Cost management|Implement cost management and billing to monitor and manage the costs of the environment.|<li>[Microsoft Cost Management and Billing](/azure/cost-management-billing/cost-management-billing-overview)<br><li>[Reservation recommendations in Azure Advisor](/azure/cost-management-billing/reservations/reserved-instance-purchase-recommendations#recommendations-in-azure-advisor)|

## Decommission retired assets

Once a workload is promoted to production, the assets that used to run it isn't needed anymore and is seen as out of service. However, these assets still use electricity and consume other resources, which add to costs. Therefore, it's a good idea to turn these off and get rid of them the right way to cut down on expenses.

Turning off and getting rid of old assets and equipment might sound straightforward, but sometimes it can cause problems you didn't expect. Here are some tips on how to safely shut down and dispose of these old resources without causing any issues for your business.

### Continued monitoring

After a migrated workload is promoted to production, the assets to be retired should continue to be monitored to validate that no more production traffic is being routed to the wrong assets.

Monitor the following signals for the resources:

- **Compute**: Resource compute utilization (CPU and RAM).
- **Storage**: Resource storage utilization (disk I/O).
- **Network**: Resource network utilization including **inbound** and **outbound** networking from appliances.
  - For example firewalls and load balancers that are used by these assets should be inspected for communication.
- **Logs**: Windows and application logs.
- **Other signals**: Any other signals that you used to monitor the assets when they were hosted in their previous production environment.

Sudden spikes or even consistent moderate utilization of infrastructure signals, along with network activity or new logs, can indicate that the asset is still in use.

### Testing windows and dependency validation

Even with the best planning, production workloads might still contain dependencies on assets that are presumed retired. In such cases, turning off a retired asset could cause unexpected system failures. As such, the termination of any assets should be treated with the same level of rigor as a system maintenance activity. Proper testing and outage windows should be established to facilitate the termination of the resource.

To successfully test your assets prior to termination, you need a maintenance window. This is a period of time when you can test the assets without causing any business interruptions.

#### Define a testing and maintenance window

- **Low-impact times**: Identify a low-impact time that you can use for your testing window. This should be a time when use of the application is at its lowest.
- **Clear test cases**: Identify clear test cases that you can perform during the testing window, that match real activities performed by users of the application. These shouldn't be surface level, but should instead map out every process used. If you already have these tests cases from your migration, you can reuse them. If you have users or other team members who work in the application frequently, try to use them to perform the tests.
- **Schedule and communicate**: Schedule a maintenance window for as long as you have available; you should aim for at least 4 hours.
  - **Schedule**: Plan the window so that application users can plan ahead. Two weeks is reasonable.
  - **Communicate**: Announce the change in advance. Set the expectation that during this maintenance window, there might be an outage and the system might not be responsive. Users shouldn't expect the application to be available.

##### Before the maintenance window

- **Execute test cases**: Run through the test cases and monitor any utilization of the resources.
  - **Utilization discovered**: You shouldn't proceed with the maintenance window. Instead, you should investigate the utilization and determine if the assets are still in use.
  - **No utilization discovered**: You can proceed with the maintenance window.

##### During the maintenance window

- **Disable assets**: Disable the assets flagged for decommission.
  - If they're still powered on, power them off.
  - Remove them from any load balancers, and make sure they aren't able to respond to any incoming requests.
- **Execute tests**: Execute your test cases against the workload that is running in Azure.
  - **Tests succeeded without failure**: The assets aren't in use at this time.
    - Communicate an end to the change window so that users know they can expect stability in the application again.
    - When tests succeed, see how to proceed in the next section.
  - **Tests failed**: The assets might be in use at this time and more testing is necessary.
    - Re-enable the assets flagged for decommission, and repeat the failed test cases.
    - If they continue to fail, it might be an unrelated issue. You need to test more within the maintenance window, and you should begin escalation to make sure you have the right level of support.
    - If they stop failing, they're likely related. You should leave the assets enabled, and close out the maintenance window after completing testing.
    - You'll then, outside of the maintenance window, need to investigate what is occurring. This involves creating another maintenance window for changes to the migrated workload, and extra maintenance windows for testing.

### Holding period and data validation

After you complete your testing window and are able to operate the workload with all assets flagged for decommission powered off and disconnected, you're good to proceed to the next phase of decommissioning. However, it shouldn't be destroyed right away.

#### Consider a holding period

It's not uncommon for migrations to miss data during replication processes. This is especially true for older data that isn't used regularly. After a retired asset has been turned off, it's still wise to maintain the asset for a while to serve as a temporary backup of the data.

- You should allow at least 30 days for holding and testing before destroying retired assets.

#### Consider data governance requirements

Your organization's data governance team might have more requirements beyond a 30 day holding period.

- **Understand holding obligations**: You should check with the necessary teams to understand the obligation for holding on for information, and build a validation checklist for your specific legal requirements.
  - During this time, it isn't important to have the asset operational. Instead, the data on the information should be retrievable. This can be addressed by keeping disks or backups able to be restored, to address the issues.
  - **An example**: If you have a SQL database server still in your physical data center, backing up its data and maintaining it as a recoverable resource might allow you to decommission the Virtual Machine, and set a holding time for the backup to be retired.

## Next steps

After retired assets are decommissioned, the migration is completed. This creates a good opportunity to improve the migration process with a retrospective to learn and improve.

> [!div class="nextstepaction"]
> [Conduct retrospectives](./retrospective.md)
