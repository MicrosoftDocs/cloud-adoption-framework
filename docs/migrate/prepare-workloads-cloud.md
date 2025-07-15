---
title: Prepare workloads for cloud migration to Azure
description: Learn how to validate, secure, and automate workloads in Azure before production cutover to reduce migration risk and ensure compatibility with Azure services.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Prepare workloads for the cloud

A workload must be cloud-ready before migration to Azure. Cloud readiness reduces cutover risk and ensures compatibility with Azure services. You should validate, secure, and automate workloads in Azure before production cutover. Use need to use your [Azure architecture plan](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture) and your [workload assessment](../plan/assess-workloads-for-cloud-migration.md).

## Create separate subscriptions for each environment

Separate Azure subscriptions for each environment provide essential governance, cost control, and operational boundaries. Development, test, and production environments require distinct policies, access controls, and cost management approaches. This subscription separation prevents accidental cross-environment changes and enables environment-specific governance.

1. **Create a subscription for each environment.** Use separate subscriptions to establish clear boundaries between environments. Each subscription provides independent cost tracking, policy enforcement, and access control. This separation prevents resource quota conflicts and enables environment-specific governance policies. Apply consistent naming conventions across all environments to improve visibility and support automation workflows. For comprehensive naming guidance, see Naming convention. For naming guidance, see [Naming convention](../ready/azure-best-practices/resource-naming.md)

1. **Configure environment-specific policies and cost controls.** Use Azure Policy to enforce compliance standards and prevent configuration drift between environments. Apply different policy sets to each environment based on their requirements. Production environments need stricter controls while development environments require more flexibility. Configure Cost Management budgets and alerts to track spending per environment and prevent cost overruns. This approach ensures each environment meets its specific compliance and cost requirements.

1. **Assign access based on environment roles.** Use Azure RBAC to assign permissions based on environment roles and responsibilities. Grant users access only to the environments they need for their job functions. Enable multifactor authentication (MFA) and configure conditional access policies through Microsoft Entra ID to secure authentication. Restrict permissions to the minimum required for each role to reduce the risk of accidental changes or security breaches.

## Deploy resources in a test environment

Test environments validate workload behavior before production deployment. These environments mirror production configurations and enable comprehensive testing of compatibility fixes, security controls, and performance characteristics. You should deploy complete infrastructure to ensure accurate validation of your migration approach.

1. **Use the workload assessment and architecture plan from CAF Plan.** Use the [planned Azure architecture](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture) artifact from the CAF Plan phase as your deployment blueprint. This document defines the complete infrastructure requirements for your test environment. Verify that this documentation remains current and includes all necessary components before you begin resource deployment. Missing or outdated architecture details can lead to incomplete test environments that fail to identify critical issues.

1. **Deploy all workload resources in the test environment.** Create all required components including compute resources (virtual machines, web apps, container services), databases, storage accounts, virtual networks, and DNS zones in your test environment. Incomplete deployments prevent accurate validation and increase migration risk by hiding compatibility issues. Use Infrastructure as Code (IaC) templates or deployment scripts to maintain consistency between test and production environments. This approach ensures that your test environment accurately represents the production deployment.

1. **Configure security controls on Azure resources.** Apply Azure role-based access control (RBAC) to grant workload team members only the permissions necessary for their specific responsibilities. Configure Network Security Groups (NSGs) to control traffic flow between subnets and resources based on your security requirements. Consider private endpoints for Azure services to eliminate public internet exposure and maintain secure connectivity. Enable managed identities for service-to-service authentication to remove credential management overhead and improve security posture. For detailed security configuration guidance, see [Security design](/azure/well-architected/security/checklist).

## Fix compatibility issues in Azure

Compatibility issues prevent successful workload operation in Azure and must be resolved before production deployment. Azure environments require specific configurations, supported operating systems, and modern drivers to function correctly. You should identify and resolve these issues systematically to ensure smooth migration execution.

1. **Identify compatibility issues.** Reference the [workload assessment](../plan/assess-workloads-for-cloud-migration.md) completed during the CAF Plan phase to understand documented compatibility requirements. This assessment provides the foundation for understanding which components need modification for Azure compatibility. Each compatibility issue presents migration risks that can cause deployment failures or performance problems in production. Address these issues proactively to prevent cutover delays and ensure workload stability.

2. **Resolve compatibility issues in the test environment.** Address compatibility issues within your Azure test environment rather than modifying your source environment. This approach validates that solutions work correctly in the target Azure environment and prevents changes that might disrupt your existing production systems. Use the following guidance to address common compatibility issues systematically:

| Compatibility issue | Solution | Why this matters |
|---------------------|----------------|------------------|
| Unsupported OS versions | Upgrade to supported operating systems | Azure requires supported OS versions for security updates and platform compatibility |
| Legacy NIC drivers and BIOS | Update drivers and BIOS firmware | Modern drivers ensure network performance and security in Azure VMs |
| Local file I/O dependencies | Replace with [Azure Blob Storage](/azure/storage/blobs/storage-blobs-introduction) or [Azure Files](/azure/storage/files/storage-files-introduction) | Cloud-native storage provides better scalability and integration |
| Hardcoded IP addresses | Replace with service discovery mechanisms like DNS or app configurations | Dynamic addressing supports Azure networking and resilience |
| Host-based antivirus software | Integrate with [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Cloud-native security provides better threat detection and management |
| Hardcoded user accounts | Replace with [managed identities](/entra/identity/managed-identities-azure-resources/overview) | Managed identities eliminate credential management and improve security |

## Test workload in the Azure environment

Test environments validate that your workload operates reliably and meets performance expectations before production deployment. Testing in Azure ensures that network, identity, performance, and compatibility requirements are met and documented. You should conduct comprehensive testing to confirm that your workload functions correctly in the target Azure environment.

### Validate network connectivity

Network connectivity validation confirms that application components can communicate with each other and external dependencies. Communication failures represent critical risks that can prevent successful workload operation in Azure.

1. **Test connectivity between all application components.** Use [Azure Network Watcher connection troubleshoot](/azure/network-watcher/connection-troubleshoot-manage?tabs=portal) to verify that application tiers can communicate with each other and with external services. This validation confirms that network security groups, routing tables, and DNS configurations allow required traffic flow. Connection troubleshoot provides detailed insights into connectivity issues and identifies specific configuration problems that prevent communication.

1. **Verify external service connectivity.** Test connections to external APIs, databases, and third-party services that your workload depends on. Use Network Watcher to validate that outbound connectivity works correctly and that firewall rules allow required traffic. Document any connectivity requirements for production deployment.

### Validate identity integration and authentication flows

Identity validation confirms that authentication and authorization work correctly in the Azure environment. Authentication failures can prevent users from accessing your workload and cause service disruptions.

1. **Test user authentication flows.** Use test user accounts to verify that identity providers like Microsoft Entra ID are accessible and that authentication works correctly. Test different authentication scenarios including single sign-on, multi-factor authentication, and password reset flows to ensure complete functionality.

2. **Validate service-to-service authentication.** Test authentication between application components using service principals and managed identities. Confirm that Azure role-based access control (RBAC) permissions are correctly configured and that services can authenticate to required resources like databases and storage accounts.

### Conduct functional and performance testing

Functional and performance testing validates that your workload meets business requirements and performs acceptably under expected load conditions. These tests identify issues that could cause failures or poor user experience in production.

1. **Execute comprehensive functional testing.** Conduct user acceptance testing (UAT), integration testing, and regression testing to confirm that the application meets business and technical requirements. Test all critical user workflows and business processes to ensure they work correctly in the Azure environment. Document any functional issues and resolve them before production deployment.

2. **Measure performance under realistic load conditions.** Use [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) to simulate realistic user traffic and measure response times, throughput, and resource utilization. Configure load tests to reflect expected production usage patterns and peak load scenarios. Load Testing provides detailed performance metrics and identifies bottlenecks that could affect user experience.

3. **Validate performance against baseline requirements.** Compare test results to established performance baselines from your source environment. Identify any performance degradation and optimize configurations, scale resources, or modify code to meet performance targets. Performance validation ensures that your workload maintains acceptable user experience in Azure.

4. **Include business stakeholders in acceptance testing.** Conduct acceptance testing with business users to confirm that the workload meets business expectations and user experience requirements. Business validation ensures that the workload delivers expected value and functionality before production deployment.

### Verify compatibility fixes in the test environment

Compatibility testing validates that modifications made for Azure compatibility function correctly and do not introduce new issues. Each compatibility fix must be thoroughly tested to ensure it resolves the original problem without creating additional problems.

1. **Test modified components in isolation and integration.** Execute comprehensive test scenarios that exercise all modified components and validate that compatibility fixes resolve identified issues. Test components individually to confirm that changes work correctly, then test integrated scenarios to ensure that modifications do not disrupt other functionality. Focus testing on areas affected by updated libraries, configurations, or platform dependencies.

2. **Monitor application behavior during compatibility testing.** Use [Azure Monitor](/azure/azure-monitor/fundamentals/overview) and [Application Insights](/azure/azure-monitor/app/app-insights-overview) to track application behavior and identify anomalies during testing. Monitor key metrics like response times, error rates, and resource utilization to detect issues that might not be apparent through functional testing alone. Application Insights provides detailed telemetry that helps identify performance regressions or stability issues.

3. **Document compatibility test results and update remediation plans.** Record detailed outcomes of compatibility testing and document any additional issues discovered during testing. Update your remediation plan to address newly identified problems and ensure that all compatibility issues are resolved before production deployment. This documentation supports troubleshooting and helps identify patterns in compatibility issues.

### Compare performance baseline with the source environment

Performance baseline comparison ensures that your workload maintains acceptable performance levels in Azure. Performance validation identifies optimization opportunities and confirms that Azure configurations meet performance requirements.

Performance baseline comparison ensures that your workload maintains acceptable performance levels in Azure. Performance validation identifies optimization opportunities and confirms that Azure configurations meet performance requirements.

1. **Use the performance baseline from your workload assessment.** Reference the performance baseline metrics documented during the [CAF Plan workload assessment](../plan/assess-workloads-for-cloud-migration.md). This baseline includes key performance indicators such as response times, CPU usage, memory consumption, disk I/O, and network throughput under various load conditions. The baseline measurements for both average and peak usage scenarios provide the foundation for performance validation in Azure.

1. **Measure Azure environment performance under comparable conditions.** Use Azure Monitor and Azure Load Testing to evaluate workload performance under similar load conditions as your baseline measurements. Configure monitoring to capture the same metrics collected in your source environment. Ensure that test conditions match baseline scenarios to enable accurate performance comparison.

1. **Identify and address performance gaps before production deployment.** Compare Azure performance metrics to source environment baselines and identify any performance degradation. Optimize Azure configurations, adjust resource scaling, or modify application code to meet performance targets. Performance optimization ensures that your workload delivers acceptable user experience in the production Azure environment.

### Create deployment documentation

1. **Document all configuration changes and deployment steps.** Include environment-specific settings, connection strings, service endpoints, and security configurations.

1. **Store deployment artifacts in version-controlled repositories.** Use infrastructure as code (IaC) templates and deployment scripts to automate production deployment and maintain change history.

1. **Include rollback and recovery procedures.** Define steps to revert changes if deployment issues occur.

## Create reusable infrastructure and automation assets

Reusable infrastructure and automation assets accelerate migration and improve consistency. These assets reduce manual effort, support repeatable deployments, and ensure that tested configurations are preserved. You should create infrastructure as code (IaC) assets only after the workload passes all tests in the test environment.

1. **Create IaC templates after validating workload behavior in the test environment.** Use the test environment to confirm that the workload functions correctly in Azure. This validation ensures that IaC templates reflect tested and production-ready configurations. Use Bicep or Terraform. Bicep provides native integration with Azure Resource Manager, while Terraform supports multi-cloud scenarios and a broader ecosystem.

2. **Automate deployment of third-party tools and workload dependencies.** Include installation and configuration steps for databases, monitoring agents, backup solutions, or other required tools. Use scripts or deployment pipelines to automate these steps. Automation reduces deployment time, eliminates manual errors, and improves reliability across environments.

3. **Store all templates and scripts in version-controlled repositories.** Use GitHub or Azure DevOps to manage IaC assets. Version control enables peer reviews, supports collaboration, and encourages reuse across teams. It also provides traceability and rollback capabilities for infrastructure changes.

4. **Test the infrastructure provisioning process.** Validate that your IaC templates, pipelines, and scripts can create the entire infrastructure stack from scratch. Test different deployment scenarios including initial deployment, updates, and rollbacks to ensure the automation works correctly. Use separate Azure subscriptions or resource groups for testing to avoid conflicts with production resources. This testing validates that your templates work consistently and can be used confidently for production deployments.

## Next step

> [!div class="nextstepaction"]
> [Execute migration cutover](./execute-migration-cutover.md)