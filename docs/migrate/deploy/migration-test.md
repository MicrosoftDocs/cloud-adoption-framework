---
title: Test your migration deployment in Azure
description: Learn how to perform migration testing in Azure to ensure that your architecture works with the replicated or staged resources.
author: Zimmergren
ms.author: pnp
ms.date: 04/05/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Test your migration deployment in Azure

After you replicate or stage your workloads and ensure that supporting services are available, you can begin your migration testing. Migration testing primarily focuses on two areas:

- **Architecture**: Test your architecture to ensure that it works with the replicated or staged resources.
- **Management routines**: Test your management plan for the migrated resources to ensure that it's functional.

Unlike [business testing](../release/business-test.md), migration testing focuses on IT activities. 

As you identify problems, you can add them to your [remediation plan](../deploy/remediate.md). After you address all the problems, you can proceed to the workload release.

## Perform test migrations

After you replicate resources, you can perform test migrations in isolated environments to ensure that you don't affect production workloads.

Test migrations vary depending on the tooling, but generally you create a replica of your source systems that runs in parallel to the live systems. Perform tests on these secondary systems. When you complete testing, you can clean up the replicated resources without introducing any permanent changes.

To do tests, you need:

- **An isolated network** where you test failover. Match the network configuration to the intended migration network configuration as much as possible.

- **Isolated network access** from a source, like a point-to-site VPN, a jump box, or Azure Bastion.
- **An authentication mechanism** to authenticate to the test environment. The test environment is isolated, so it can't use your landing zone’s identity provider.
  
  You might use a test-migrated domain controller that you deploy to the test environment with the test migration resources. After testing, clean up the domain controller with the resources.
  
  Alternatively, your isolated network might have a test domain controller in it. Peer the network to allow for replication of Active Directory traffic. You can take a snapshot of the domain controller in Azure, and then delete the peer for testing purposes to isolate the network. You can seize any necessary roles, and then restore the state when you complete testing to avoid making changes to the live identity provider.

Your migration tool should be able to perform a test migration, and clean up the test materials. For an example of such a test migration process that would work in Azure Migrate, see the [Test migrations for VMware agentless migrations](/azure/migrate/vmware/how-to-test-replicating-virtual-machines#changing-test-migration-virtual-network-and-subnet-of-a-replicating-machine-agentless-vmware-migration). This gives a starting point for understanding how the tools can help you with test migrations.

> [!TIP]
> You can also use this testing environment for [business testing](../release/business-test.md).

## Remediate testing problems

After you do testing, make sure that you:

- **Record any discovered problems** in the remediation plan.
- **Triage problems** based on their severity, and identify any workarounds as part of the triaging.
- **Document workarounds**. If you can incorporate the workaround as part of the migration, you might not need to remediate the problem.
- **Start with non-workaround items**. Consider remediating items without workarounds first.

## Example testing plan

Here's a basic example of a testing plan output for a migration project:

|Test|Successful/unsuccessful|Note|
|---|---|---|
|Virtual machines deploy|&#x2705;||
|Administrators can sign in to virtual machines|&#x2705;||
|Internet Information Services (IIS) web services start|&#x2705;||
|*Service 1* starts|&#x2705;||
|*Service 2* starts|&#x274C;|Service had to be manually started|
|Website access|&#x2705;||
|SQL services start|&#x2705;||
|Database access|&#x2705;||
|Load balancing between websites works|&#x2705;||
|Ingress from Azure Application Gateway works|&#x274C;|Application Gateway has a certificate problem|
|Total time for the test transaction was less than 5 ms|&#x2705;||

## Next step

> [!div class="nextstepaction"]
> [Release migrated workloads](../release/index.md)
