---
title: Migration testing in Azure
description: Learn how to perform migration testing in Azure to ensure that your architecture works with the replicated or staged resources.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/20/2024
ms.topic: conceptual
---

# Migration testing in Azure

Once you have your workloads replicated or staged and the supporting services available, you can begin your migration testing. This is focused primarily on two areas:

- **Architecture:** Testing that your architecture works with the replicated or staged resources.
- **Management routines:** Testing that your plan to manage the migrated resources are functional.

Unlike [business testing](../release/business-test.md), migration testing is focused on IT activities.

As you identify issues, you can add them to your [remediation plan](../deploy/remediate.md). Once you addressed all issues, you're ready to proceed to release.

## Performing test migrations

Once you have replicated resources, you can perform test migrations in isolated environments to do testing without impacting production workloads.

Test migrations vary by tooling but generally create a replica of your source systems that can run in parallel to the live systems. Perform tests on these secondary systems, and when testing is complete, clean them up without any permanent changes to the replicating resources.

To do this, you need:

- **An isolated network:** An isolated virtual network to test failover inside, configured as close as possible to the intended migration network.
- **Isolated network access:** A way to access the isolated network, like a point-to-site VPN, a jump box, or Azure Bastion.
- **Authentication mechanism:** A way to authenticate to the test environment. Because the environment is isolated, it isn't able to use your landing zone’s identity provider.
  - You might use a test-migrated domain controller that is deployed to the environment with the test migration resources. This would be cleaned up with the resources.
  - Alternatively, your isolated network might have a test domain controller in it. This network is then peered to allow for replication of Active Directory traffic. You can take a snapshot of the domain controller in Azure, and then delete the peer for testing purposes to isolate the network. You can seize any necessary roles, and then restore state when testing is done to avoid making changes to the live identity provider.

Your migration tool should have instructions for executing a test migration and cleaning it up after you execute your testing plan.

> [!TIP]
> You can use the same environment for [business testing](../release/business-test.md).

## Remediating testing issues

After testing, ensure you check these things:

- **Discovered issues:** Any discovered issues should be recorded into the remediation plan.
- **Remediation plan triaging:** Issues should be triaged based on severity, and any workarounds should be identified as part of triaging.
- **Document workarounds:** If the workaround can be used as part of the migration, you might not need to remediate the issue.
- **Start with non-workaround items:** Consider remediating items without workarounds first.

## Example testing plan

Here's a basic example of a testing plan output for a migration project:

|Test|Succeeded|Notes|
|---|---|---|
|Virtual Machines Deploy|&#x2705;||
|Administrators can sign in to virtual machines|&#x2705;||
|Internet Information Services (IIS) Web Services starts|&#x2705;||
|"Service 1" starts|&#x2705;||
|"Service 2" start|&#x274C;|Service had to be manually started|
|Web site is accessible|&#x2705;||
|SQL services start|&#x2705;||
|Database accessible|&#x2705;||
|Load balancing between web sites works|&#x2705;||
|Ingress from Application Gateway Works|&#x274C;|Application gateway have a certificate issue|
|Total time for test transaction was below 5 ms.|&#x2705;||

## Next steps

> [!div class="nextstepaction"]
> [Release migrated workloads](../release/index.md)
