---
title: Build cloud-native solutions
description: Build cloud-native solutions
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Build cloud-native solutions

With the planning complete, the next phase is to build and configure the solution in a development environment, adhering to best practices and ensuring quality through testing. A cloud-native solution uses scalable, resilient, and observable architecture patterns to maximize the benefits of Azure services. Building in a nonproduction environment with strong testing and automation practices ensures quality and readiness for production deployment.

## Develop new cloud-native solutions

Cloud-native development requires a structured approach that integrates quality practices from the start. This guidance helps you build reliable, secure, and scalable solutions through proven development practices.

### Apply Well-Architected Framework principles during development

A cloud-native solution benefits from consistent application of the Well-Architected Framework (WAF) principles [Well-Architected Framework (WAF)](/azure/well-architected/pillars) provides essential principles that guide effective cloud-native development. Integrate these five pillars into your development process to create robust applications that perform well in production.

### Develop in a nonproduction environment

1. **Create development environments that mirror production configurations.** Set up nonproduction environments (development, test, QA) that closely mirror the production configuration. The closer your test environments are to prod, the more confidence you have that things work upon release. This approach is especially important when adding new features to an existing workload.

2. **Use realistic datasets that represent production data volumes.** Test with data that matches the size and complexity of production workloads. Large datasets expose performance bottlenecks and scaling issues that small test datasets miss. Anonymize production data or generate synthetic data that preserves the statistical properties of real data.

3. **Implement cost controls for nonproduction environments.** Use Azure DevTest Labs or resource scheduling to automatically start and stop resources when not in use. Apply appropriate service tiers for development workloads and implement spending limits to prevent unexpected costs while maintaining testing effectiveness.

For more information, see [Configure test environment](/azure/well-architected/performance-efficiency/performance-test#configure-the-test-environment) in WAF.

### Implement changes using source control and CI/CD

1. **Store all code and configuration in a Git repository.** Track application code, infrastructure templates, deployment scripts, and configuration files in version control. This practice provides a complete history of changes and enables collaboration among team members.

2. **Break development work into small, frequent commits.** Complete feature development in small increments that can be merged and tested independently. This approach reduces integration conflicts and makes it easier to identify the source of issues when they occur.

3. **Automate builds and tests on every code change.** Configure CI/CD pipelines that automatically compile code, run tests, and deploy to nonproduction environments when changes are committed. Fast feedback loops help developers catch and fix issues quickly.

4. **Use feature flags to control the release of new functionality.** Implement feature toggles that allow you to deploy code to production while keeping new features disabled until they're ready for users. This strategy separates deployment from release and enables safer, more controlled rollouts.

### Implement monitoring during development

1. **Integrate Azure Monitor and Application Insights into your application code.** Add monitoring data collection to track key performance metrics, user interactions, and system health indicators. Configure these tools during development to ensure they work correctly before production deployment.

2. **Implement structured logging throughout your application.** Use consistent log formats and include contextual information like user IDs, request IDs, and business process identifiers. Structure your logs as JSON objects to enable powerful querying and analysis capabilities.

3. **Configure alerts for key metrics and failure conditions.** Set up proactive monitoring that notifies you when error rates increase, response times degrade, or business metrics fall outside expected ranges. Define alert thresholds based on your service level objectives and business requirements.

4. **Create dashboards that provide visibility into system performance.** Build monitoring dashboards that show the health of your application, infrastructure, and business processes. Include metrics that matter to both technical teams and business stakeholders to enable data-driven decisions.

For more information, see [Design a monitoring system](/azure/well-architected/operational-excellence/observability) and [Instrument an application](/azure/well-architected/operational-excellence/instrument-application) in WAF.

### Validate cloud-native solutions with testing

Comprehensive testing validates that your solution meets business requirements and performs reliably under real-world conditions. Each type of testing serves a specific purpose in ensuring solution quality.

1. **Execute end-to-end functional testing to verify business workflows.** Test complete user scenarios from authentication through transaction completion using realistic data and interactions. Validate that new features work correctly and that existing functionality remains intact after changes. Run regression tests to catch unintended side effects of new development.

2. **Conduct user acceptance testing with business stakeholders.** Engage actual users or business representatives to validate that the solution meets their needs and expectations. Have them test key scenarios in a UAT environment and provide feedback on usability and functionality. Obtain formal approval from stakeholders before proceeding to production deployment.

3. **Perform load testing under realistic conditions to validate performance.** Use [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) to simulate expected user volumes and data throughput. Test at peak load levels and beyond to identify performance bottlenecks and scaling limits. Measure response times, throughput, and resource utilization to ensure your solution meets performance requirements.

4. **Execute security and compliance testing to identify vulnerabilities.** Run automated security scans on application code, container images, and infrastructure configurations. Use Microsoft Defender for Cloud to check for security misconfigurations and compliance violations. Address high-risk vulnerabilities before deployment and implement compensating controls for accepted risks.

5. **Resolve critical issues before production deployment.** Treat testing phases as quality gates that must be passed before proceeding. Fix performance issues that prevent meeting service level agreements, resolve security vulnerabilities that pose significant risk. Address functional defects that affect core business processes. Document known low-priority issues with plans for future resolution.

6. **Maintain automated unit and integration test suites.** Create comprehensive automated tests that validate individual components and their interactions with external dependencies. Run these tests as part of your CI/CD pipeline and after every bug fix to prevent regressions. A robust automated test suite enables confident continuous delivery in cloud-native environments.

## Create reusable infrastructure

[!INCLUDE [Steps to create reusable infrastructure](../migrate/includes/create-reusable-infrastructure.md)]

## Create deployment documentation

[!INCLUDE [Steps to create deployment documentation](../migrate/includes/create-deployment-documentation.md)]

## Next step

> [!div class="nextstepaction]
[Deploy cloud-native solutions](./deploy-cloud-native-solutions.md)
