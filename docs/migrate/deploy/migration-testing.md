---
title: Migration testing in Azure
description: Learn how to perform migration testing in Azure to ensure that your architecture works with the replicated or staged resources.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/01/2024
ms.topic: conceptual
---

## Migration testing in Azure

Once you have your workloads replicated or staged and the supporting services available, you can begin your migration testing. This is focused primarily on two areas:

- Testing that your architecture works with the replicated or staged resources.
- Testing that your plan to manage the migrated resources are functional.

Unlike [business testing](/azure/cloud-adoption-framework/migrate/release/business-test), migration testing will e focused on IT activities.

As you identify issues, you can add them to your [remediation plan](/azure/cloud-adoption-framework/migrate/deploy/remediate). Once you addressed all issues, you're ready to proceed to release.

## Performing test migrations

Once you have replicated resources, you can perform test migrations in isolated environments to do testing without impacting production workloads. Test migrations vary by tooling, but generally create a replica of your source systems that can run in parallel to the live systems. These secondary systems can then be tested, and when testing is complete can be cleaned up without any permanent changes to the replicating resources. 

To do this, you need:

- An isolated virtual network to test failover inside, configured as close as possible to the intended migration network.
- A way to authenticate to the test environment. Because the environment is isolated, it isn't able to use your landing zone’s identity provider.
  - You might use a test-migrated domain controller that is deployed to the environment with the test migration resources. This would be cleaned up with the resources.
  - Alternatively, your isolated network may have a test domain controller in it. This network is then peered to allow for replication of Active Directory traffic. You can take a snapshot of the domain controller in Azure, and then delete the peer for testing purposes to isolate the network. You can seize any necessary roles, and then restore state when testing is done to avoid making changes to the live identity provider.
- A way to access the isolated network, like a point-to-site VPN, a jump box, or Azure Bastion.

Your migration tool should have instructions for executing a test migration and cleaning it up after you execute your testing plan.

You can also use this environment for [business testing](/azure/cloud-adoption-framework/migrate/release/business-test).

## Remediating testing issues

After testing, any issues should be recorded into the remediation plan. They should be triaged based on severity, and any workarounds should be identified.

If the workaround can be used as part of the migration, you might not need to remediate the issue.  Consider remediating items without workarounds first.

## Example testing plan

Here's an example of a testing plan for a migration:

|Test|Succeeded|Notes|
|---|---|---|
|Virtual Machines Deploy|Yes||
|Administrators can sign in to virtual machines|Yes||
|Internet Information Services (IIS) Web Services starts|Yes||
|"Service 1" starts|Yes||
|"Service 2" start|NO|Service had to be manually started|
|Web site is accessible|Yes||
|SQL services start|Yes||
|Database accessible|Yes||
|Load balancing between web sites works|Yes||
|Ingress from Application Gateway Works|NO|Application gateway have a certificate issue|
|Total time for test transaction was below 5 ms.|Yes||

## Next steps

> [!div class="nextstepaction"]
> [Release migrated workloads](../release/index.md)
