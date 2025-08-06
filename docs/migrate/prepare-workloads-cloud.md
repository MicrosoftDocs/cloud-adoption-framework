---
title: Prepare workloads for cloud migration to Azure
description: Comprehensive guidance for validating, securing, and automating workloads before migrating to Azure, including steps to resolve compatibility issues, test performance, and create reusable infrastructure for reliable cloud adoption and operational maturity.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Prepare workloads for the cloud

A workload must be cloud-ready before migration to Azure. Cloud readiness reduces cutover risk and ensures compatibility with Azure services. You should validate, secure, and automate workloads in Azure before production cutover. Use your [Azure architecture plan](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture) and your [workload assessment](../plan/assess-workloads-for-cloud-migration.md).

## Fix compatibility issues in Azure

Azure compatibility issues block workload migration and must be resolved before production deployment. Azure environments require specific configurations, supported operating systems, and current drivers to function correctly. You should address these issues systematically to ensure successful execution of your migration.

### Deploy all workload resources

1. **Create Azure subscriptions for workload environments.** Create separate subscriptions for development, test, and production environments to ensure proper isolation, cost tracking, and governance. Place subscriptions in the appropriate management group and apply environment-specific governance policies, role-based access control assignments, and cost management budgets. For more information, see [Create your subscriptions](/azure/cloud-adoption-framework/ready/azure-best-practices/initial-subscriptions).

2. **Use your architecture plan.** Use the architecture plan you created during cloud adoption planning to deploy the right Azure architecture. Ensure that the architecture aligns with any updated workload requirements. For architecture planning, see [Azure architecture planning](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture).

3. **Deploy all workload components.** In a test subscription, create compute (virtual machines, web apps, containers) datastores (databases, storage accounts), load balancers, managed identities, virtual networks, and DNS resources.

4. **Validate the completeness of the test environment.** Confirm that all dependencies, configurations, and integrations are present. Missing components can lead to false positives or undetected issues during testing.

### Resolve compatibility issues

1. **Review the documented compatibility requirements and known issues.** Use the [workload assessment](../plan/assess-workloads-for-cloud-migration.md) from the CAF Plan phase. This assessment identifies unsupported configurations and dependencies that must be remediated.

1. **Resolve each compatibility issue using Azure solutions.** Apply the following remediations in the test environment:  completed during the CAF Plan phase to understand documented compatibility requirements Address compatibility issues within your Azure test environment rather than modifying your source environment. See the following common compatibility problems:

| Compatibility issue | Solution | Why it matters |
|---------------------|----------------|------------------|
| Unsupported OS versions | Upgrade to supported operating systems | Azure requires supported OS versions for security updates and platform compatibility |
| Legacy NIC drivers and BIOS | Update drivers and BIOS firmware | Modern drivers ensure network performance and security in Azure VMs |
| Local file I/O dependencies | Replace with [Azure Blob Storage](/azure/storage/blobs/storage-blobs-introduction) or [Azure Files](/azure/storage/files/storage-files-introduction) | Cloud-native storage provides better scalability and integration |
| Hardcoded IP addresses | Replace with service discovery mechanisms like DNS or app configurations | Dynamic addressing supports Azure networking and resilience |
| Host-based antivirus software | Integrate with [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Cloud-native security provides better threat detection and management |
| Hardcoded user accounts | Replace with [managed identities](/entra/identity/managed-identities-azure-resources/overview) | Managed identities eliminate credential management and improve security |

## Validate workloads

After resolving compatibility issues, ensure your workloads function correctly in the Azure environment. Comprehensive testing is essential to confirm that all components, configurations, and integrations meet business and technical requirements. This validation process reduces risks and ensures a smooth transition to production deployment.

### Validate network connectivity

1. **Test connectivity between all components.** Use [Azure Network Watcher connection troubleshoot](/azure/network-watcher/connection-troubleshoot-manage?tabs=portal) to verify that application tiers can communicate with each other and with external services. This validation confirms that network security groups, routing tables, and DNS configurations allow required traffic flow. This tool provides detailed insights into connectivity issues and identifies specific configuration problems that prevent communication.

1. **Verify external service connectivity.** Test connections to external APIs, databases, and external services that your workload depends on. Use Network Watcher to validate that outbound connectivity works correctly and that firewall rules allow required traffic. Document any connectivity requirements for production deployment.

### Validate authentication flows

1. **Test user authentication flows.** Use test user accounts to verify that identity providers like Microsoft Entra ID are accessible and that authentication works correctly. Test different authentication scenarios including single sign-on, multifactor authentication, and password reset flows to ensure complete functionality.

2. **Validate service-to-service authentication.** Test authentication between application components using service principals and managed identities. Confirm that Azure role-based access control (RBAC) permissions are correctly configured and that services can authenticate to required resources like databases and storage accounts.

### Conduct functional and performance testing

1. **Execute comprehensive functional testing.** Conduct user acceptance testing (UAT), integration testing, and regression testing to confirm that the application meets business and technical requirements. Test all critical user workflows and business processes to ensure they work correctly in the Azure environment. Document any functional issues and resolve them before production deployment.

2. **Measure performance under realistic load conditions.** Use [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) to simulate realistic user traffic and measure response times, throughput, and resource utilization. Configure load tests to reflect expected production usage patterns and peak load scenarios. Load Testing provides detailed performance metrics and identifies bottlenecks that could affect user experience.

3. **Validate performance against baseline.** Reference the performance baseline metrics documented during the [CAF Plan workload assessment](../plan/assess-workloads-for-cloud-migration.md). Compare test results to established performance baselines from your source environment. Identify any performance degradation and optimize configurations, scale resources, or modify code to meet performance targets.

4. **Include stakeholders in acceptance testing.** Conduct acceptance testing with business users to confirm that the workload meets business expectations and user experience requirements. Business validation ensures that the workload delivers expected value and functionality before production deployment.

## Create reusable infrastructure

[!INCLUDE [Steps to create reusable infrastructure](./includes/create-reusable-infrastructure.md)]

## Create deployment documentation

[!INCLUDE [Steps to create deployment documentation](./includes/create-deployment-documentation.md)]

## Next step

> [!div class="nextstepaction"]
> [Execute migration](./execute-migration.md)