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

### Apply Well-Architected Framework principles during development

Continue to use the [Well-Architected Framework (WAF)](/azure/well-architected/pillars) guidance for reliability, security, cost optimization, operational excellence, and performance efficiency as you implement the solution. For example, ensure you're writing secure code (security), handling failures gracefully (reliability), keeping an eye on spending (cost), automating processes (operational excellence), and designing for scale (performance efficiency). Making these considerations an integral part of development results in a more robust application.

### Develop in a nonproduction environment

Set up nonproduction environments (development, test, QA) that closely mirror the production configuration. This is especially important when adding new features to an existing workload. your test environment should have similar Azure resources, configurations, and dataset sizes as production to reveal any integration issues. Use Azure DevTest Labs or infrastructure-as-code scripts can help quickly create consistent environments with controlled cost and governance. The closer your test environments are to prod, the more confidence you have that things work upon release. For more information, see [Configure test environment](/azure/well-architected/performance-efficiency/performance-test#configure-the-test-environment) in WAF.

### Implement changes using source control and CI/CD

Manage all code in a Git repository and integrate changes continuously. Break down development tasks into small, manageable increments and merge code frequently to avoid integration headaches. Each change should trigger automated builds and tests (continuous integration), ensuring that new code doesn’t break existing functionality. This approach enables fast feedback and makes it easier to isolate and fix issues when they arise.

### Implement monitoring during development

Application observability requires monitoring, logging, and alerting capabilities. Integrate Azure Monitor and Application Insights into your code to track system health and performance metrics from the start. Configure alerts for key metrics and failure conditions that align with your business requirements. Add structured logging throughout your application to capture meaningful events and errors. These observability features ensure you can detect and diagnose issues quickly when they occur in production. For more information, see [Design a monitoring system](/azure/well-architected/operational-excellence/observability) and [Instrument an application](/azure/well-architected/operational-excellence/instrument-application) in WAF.

### Validate cloud-native solutions with testing

Testing is critical. Verify every aspect of the workload in the test environment before touching production.

1. **Conduct end-to-end functional testing.** Test all critical user workflows from sign-in to transaction completion using realistic scenarios. For new features, execute regression tests to confirm unchanged functionality remains intact after modernization. Validate new features and updated interfaces meet business requirements without breaking existing processes. For more information, see [Prioritize critical flows](/azure/well-architected/performance-efficiency/prioritize-critical-flows) and [Reliability testing](/azure/well-architected/reliability/testing-strategy) in WAF.

2. **Perform user acceptance testing (UAT) with stakeholders.** Engage actual users or business stakeholders to run key scenarios in a UAT environment. Have them verify that the new workloads or features meet their needs and are user-friendly. Gather feedback on any issues or UX improvements. Resolve any critical issues found in UAT before going live, and obtain formal approval from these stakeholders indicating that the solution is ready from a business perspective.

3. **Validate performance using load testing under realistic conditions.** Use load testing (for example, [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing)) to simulate high user volumes and data throughput that you expect in production. Measure response times, throughput, and resource utilization under load. Ensure the workload can handle at least the expected peak load, and consider testing beyond the expected peak load (1.5x peak load) to see how it behaves under stress. Identify any bottlenecks and optimize as needed before release. For more information, see [Performance testing](/azure/well-architected/performance-efficiency/performance-test) in WAF.

4. **Execute security and compliance tests.** Run security scans and vulnerability assessments on your application code and any container images or infrastructure components. Use tools like Microsoft Defender for Cloud to check for misconfigurations in Azure resources and ensure compliance with security benchmarks. If the workload is subject to regulatory requirements, perform compliance checks or audits in the test environment. It’s easier to fix security issues before deployment than to react to incidents later. For more information, see [Security testing](/azure/well-architected/security/test) in WAF.

### Fix critical issues and verify all tests pass

Treat testing phases as gates: don't proceed to go-live until all critical defects uncovered in testing are resolved. If performance testing shows the workload missing a service-level agreement (SLA), address it by tuning or scaling resources. If security scans show high-risk vulnerabilities, remediate them or implement compensating controls. Only when the solution passes functional, UAT, performance, and security criteria should you consider it ready for production. Document any low-priority known issues along with plans to address them in future updates so they aren't forgotten.

### Repeat unit and integration tests after changes

For any new features or modifications, ensure you have adequate unit tests (covering individual components) and integration tests (covering interactions between components and external workload). Run these tests as part of your pipeline. After fixing any bug, rerun the relevant tests to confirm the issue is truly resolved and no new regressions were introduced. A solid automated test suite is crucial for maintaining quality in cloud-native continuous delivery environments.

## Create reusable infrastructure

[!INCLUDE [Steps to create reusable infrastructure](../migrate/includes/create-reusable-infrastructure.md)]

## Create deployment documentation

[!INCLUDE [Steps to create deployment documentation](../migrate/includes/create-deployment-documentation.md)]

## Next step

[Deploy your new solution](./deploy-cloud-native-solutions.md)