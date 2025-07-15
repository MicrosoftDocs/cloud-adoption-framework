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

1. **Create a subscription for each environment.** Use distinct subscriptions for development, test, and production environments. This separation enables clearer cost management, policy enforcement, and access control. Use consistent naming conventions to improve visibility and simplify automation. For naming guidance, see [Naming convention](../ready/azure-best-practices/resource-naming.md)

1. **Apply environment-specific policies and budgets.** Use Azure Policy and Cost Management to enforce compliance and track spending. This helps prevent configuration drift and cost overruns.

1. **Assign access based on environment roles.** Use Azure role-based access control (RBAC) to restrict access to each subscription. Enable multifactor authentication (MFA) and configure conditional access policies through Microsoft Entra ID. Use Azure Bastion for secure administrative access to virtual machines. Over-permissioned roles increase the risk of misconfiguration or data exposure. This reduces the risk of accidental changes across environments.

## Deploy resources in a test environment

1. **Use the workload assessment and architecture plan from CAF Plan.** Use the [planned Azure architecture](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture) completed during the Plan phase. This artifact provides the blueprint for creating the test environment. Validate that this document is current and complete before deploying test resources.

1. **Deploy all workload components in the test environment.** Include compute resources (virtual machines, web apps, container hosting), databases, storage accounts, virtual networks, and DNS zones. Incomplete test environments delay validation and increase migration risk. Use your IaC templates or deployment scripts to ensure consistency between test and production environments.

1. **Configure security controls.** Apply (RBAC) to grant workload teams only the permissions required to the Azure resources for their responsibilities. Configure NSGs to limit traffic between subnets and resources. Use private endpoints for Azure services to avoid exposing them to the public internet. Enable managed identities for service-to-service authentication. For a comprehensive checklist, see [Security design](/azure/well-architected/security/checklist).

## Fix compatibility issues in Azure

1. **Identify compatibility issues.** Reference the [workload assessment](../plan/assess-workloads-for-cloud-migration.md) that you completed during the CAF Plan phase.  Azure environments require specific configurations and supported technologies to function correctly. You should identify and fix these issues in the test environment to ensure a smooth production migration.

2. **Resolve compatibility issues in the test environment.** Compatibility issues prevent successful migration and must be resolved before production cutover. fix all identified issues in Azure rather than in the source environment. This approach ensures that your test environment mirrors the production Azure environment as closely as possible. Use the following table to guide your remediation efforts:

| Compatibility issue | Solution | Why this matters |
|---------------------|----------------|------------------|
| Unsupported OS versions | Upgrade to supported operating systems | Azure requires supported OS versions for security updates and platform compatibility |
| Legacy NIC drivers and BIOS | Update drivers and BIOS firmware | Modern drivers ensure network performance and security in Azure VMs |
| Local file I/O dependencies | Replace with Azure Blob Storage or Azure Files | Cloud-native storage provides better scalability and integration |
| Hardcoded IP addresses | Swap hardcoded IP calls with service discovery mechanisms like DNS or app configurations | Dynamic addressing supports Azure networking and resilience |
| Host-based antivirus software | Integrate with Microsoft Defender for Cloud | Cloud-native security provides better threat detection and management |
| Hardcoded user accounts | Replace with managed identities | Managed identities eliminate credential management and improve security |

## Test workload in the Azure environment

1. **Validate network connectivity and identity integration.** Network connectivity and identity integration form the foundation of successful workload operation in Azure. You must verify that applications connect to dependencies and users authenticate correctly to prevent service disruption during production cutover. Use Azure Network Watcher to test all network routes and firewall rules in your Azure test environment. Test authentication mechanisms through user login scenarios and service-to-service authentication. Validate traffic flows between application tiers and external services using network monitoring tools.

2. **Conduct comprehensive functional and performance testing.** Functional and performance testing validates that your workload operates correctly and meets performance requirements in Azure. You should complete user acceptance testing, load testing, and integration testing to confirm workload behavior matches expectations. Use Azure Load Testing to simulate user traffic and measure response times, throughput, and resource utilization. Document performance metrics and compare results to baseline measurements from your source environment. Involve business stakeholders in acceptance testing to confirm applications meet business requirements and user expectations.

3. **Verify all compatibility fixes in the test environment.** Compatibility fixes ensure that your workload functions correctly in Azure without unexpected behavior. You must test each compatibility fix through functional, performance, and integration testing in the Azure environment. Execute test scenarios that exercise all modified components and validate that fixes resolve identified issues without introducing new problems. Document test results and any additional fixes required based on testing outcomes. Use Azure Monitor and Application Insights to track application behavior and identify potential issues during testing.

4. **Create detailed deployment documentation.** Deployment documentation provides the blueprint for consistent production implementation and reduces deployment risk. You should document all configuration changes, compatibility fixes, and deployment steps validated during testing. Include environment-specific settings, connection strings, service endpoints, and security configurations in your documentation. Add configurations to your infrastructure as code templates and deployment scripts to automate production deployment. Store documentation in version-controlled repositories to ensure team access and maintain change history.

5. **Establish performance baseline comparisons with the source environment.** Performance baseline comparisons validate that your workload maintains or improves performance after migration to Azure. You should have captured comprehensive performance metrics during your workload assessment. Use these baseline measurements to identify performance improvements or degradation during testing and to validate that Azure configurations meet your performance requirements.

## Create reusable infrastructure and automation assets

Reusable infrastructure and automation assets accelerate migration and improve consistency. These assets reduce manual effort, support repeatable deployments, and ensure that tested configurations are preserved. You should create infrastructure as code (IaC) assets only after the workload passes all tests in the test environment.

1. **Create IaC templates after validating workload behavior in the test environment.** Use the test environment to confirm that the workload functions correctly in Azure. This validation ensures that IaC templates reflect tested and production-ready configurations. Use Bicep or Terraform. Bicep provides native integration with Azure Resource Manager, while Terraform supports multi-cloud scenarios and a broader ecosystem.

2. **Automate deployment of third-party tools and workload dependencies.** Include installation and configuration steps for databases, monitoring agents, backup solutions, or other required tools. Use scripts or deployment pipelines to automate these steps. Automation reduces deployment time, eliminates manual errors, and improves reliability across environments.

3. **Store all templates and scripts in version-controlled repositories.** Use GitHub or Azure DevOps to manage IaC assets. Version control enables peer reviews, supports collaboration, and encourages reuse across teams. It also provides traceability and rollback capabilities for infrastructure changes.

4. **Test the infrastructure provisioning process.** Validate that your IaC templates, pipelines, and scripts can create the entire infrastructure stack from scratch. Test different deployment scenarios including initial deployment, updates, and rollbacks to ensure the automation works correctly. Use separate Azure subscriptions or resource groups for testing to avoid conflicts with production resources. This testing validates that your templates work consistently and can be used confidently for production deployments.
