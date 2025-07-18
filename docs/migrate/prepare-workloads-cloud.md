---
title: Prepare workloads for cloud migration to Azure
description: Comprehensive guidance for validating, securing, and automating workloads before migrating to Azure, including steps to resolve compatibility issues, test performance, and create reusable infrastructure for reliable cloud adoption and operational maturity.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Prepare workloads for the cloud

A workload must be cloud-ready before migration to Azure. Cloud readiness reduces cutover risk and ensures compatibility with Azure services. You should validate, secure, and automate workloads in Azure before production cutover. Use need to use your [Azure architecture plan](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture) and your [workload assessment](../plan/assess-workloads-for-cloud-migration.md).

## Fix compatibility issues in Azure

Azure compatibility issues block workload migration and must be resolved before production deployment. Azure environments require specific configurations, supported operating systems, and current drivers to function correctly. You should address these issues systematically to ensure successful execution of your migration.

### Create Azure subscriptions

1. **Create three separate Azure subscriptions for development, test, and production.** Use the Azure portal or Azure CLI to create each subscription. Assign clear [naming conventions and tags](/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources#establish-a-consistent-naming-convention) to distinguish them. This separation ensures that testing activities don't affect production quotas or security boundaries. For governance and security guidance, see [Govern your subscriptions](/azure/cloud-adoption-framework/ready/azure-best-practices/initial-subscriptions#govern-your-subscriptions).

1. **Apply governance policies to each subscription.** Use Azure Policy to enforce environment-specific controls. For example, restrict compute sizes in development, enforce tagging in test, and apply security baselines in production.

1. **Assign role-based access control (RBAC) per subscription.** Grant least-privilege access to users and service principals based on their roles in each environment. It reduces the risk of unauthorized changes and supports compliance.

### Deploy all workload resources in the test environment

1. **Use the planned Azure architecture from the CAF Plan phase.** Reference the architecture artifact created during planning to define the infrastructure blueprint. Ensure that the architecture aligns with workload requirements and supports scalability, security, and performance. For architecture planning, see [Azure architecture planning](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture).

2. **Deploy all workload components in the test subscription.** Create compute (virtual machines, web apps, containers) datastores (databases, storage accounts), load balancers, managed identities, virtual networks, and DNS resources.

3. **Validate the completeness of the test environment.** Confirm that all dependencies, configurations, and integrations are present. Missing components can lead to false positives or undetected issues during testing.

### Resolve compatibility issues

1. **Review the documented compatibility requirements and known issues.** Use the [workload assessment](../plan/assess-workloads-for-cloud-migration.md) from the CAF Plan phase. This assessment identifies unsupported configurations and dependencies that must be remediated.

1. **Resolve each compatibility issue using Azure solutions.** Apply the following remediations in the test environment:  completed during the CAF Plan phase to understand documented compatibility requirements Address compatibility issues within your Azure test environment rather than modifying your source environment. Use the following guidance to resolve common compatibility problems:

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

Reusable infrastructure automates deployments and standardizes configurations across environments. Infrastructure as code (IaC) reduces manual errors, supports repeatable deployments, and preserves tested configurations for consistent use. You should create IaC assets only after your workload successfully passes all functional, performance, and security tests in the test environment.

1. **Create IaC templates for proven configurations.** Use [Bicep](/azure/azure-resource-manager/bicep/overview), [Terraform](/azure/developer/terraform/overview), or [Azure Resource Manager templates](/azure/azure-resource-manager/templates/overview) to define your infrastructure. For more information, see [CAF Manage - Manage code-based deployments](/azure/cloud-adoption-framework/manage/administer#manage-code-deployments).

2. **Store templates in version-controlled repositories.** Use [GitHub](https://docs.github.com/repositories) or [Azure DevOps](/azure/devops/repos/get-started/) to manage IaC assets with proper version control. Version control enables code reviews, supports team collaboration, and encourages template reuse across projects. This approach provides complete traceability for infrastructure changes and supports rollback capabilities when issues occur.

3. **Automate dependency installation and configuration.** Create deployment pipelines or scripts that automatically install and configure application dependencies. Use [Azure Pipelines](/azure/devops/pipelines/), [GitHub Actions](https://docs.github.com/actions), or Azure CLI scripts to automate these steps. Include configuration files, environment variables, and [secrets management](/azure/key-vault/general/basic-concepts) in your automation process. This automation eliminates manual configuration errors and ensures consistent behavior across all environments.

4. **Validate infrastructure provisioning end-to-end.** Test that your IaC templates, pipelines, and scripts can create the complete infrastructure stack from nothing. Test different deployment scenarios including initial deployment, configuration updates, and rollback procedures to confirm the automation works correctly. Use separate Azure subscriptions or resource groups for testing to prevent conflicts with production resources and maintain environment isolation.

## Create deployment documentation

Deployment documentation ensures that teams can consistently deploy and maintain workloads across environments. It also supports troubleshooting and compliance.

1. **Document configuration changes and deployment procedures.** Record all environment-specific settings, connection strings, service endpoints, and security configurations in accessible documentation. Include step-by-step deployment instructions, prerequisite requirements, and post-deployment validation steps. This documentation enables consistent deployments and supports troubleshooting when issues occur.

2. **Update rollback and recovery procedures.** Create detailed steps to revert changes when deployment issues occur. Include rollback triggers, data backup and restoration procedures, and recovery validation steps. Test rollback procedures regularly to ensure they work correctly when needed. This preparation reduces downtime and provides. For more information, see [Define rollback plan](./plan-migration.md#define-rollback-plan).

## Next step

> [!div class="nextstepaction"]
> [Execute migration](./execute-migration.md)