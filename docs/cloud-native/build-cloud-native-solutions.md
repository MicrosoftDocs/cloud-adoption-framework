---
title: Build cloud-native solutions
description: Build cloud-native solutions
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Build cloud-native solutions

With the planning complete, the next phase is to build and configure the solution in a development environment, adhering to best practices and ensuring quality through testing.

## Develop new cloud-native solutions in a nonproduction environment

1. **Apply Well-Architected Framework principles during development.** Continue to use the Azure Well-Architected Framework guidance for reliability, security, cost optimization, operational excellence, and performance efficiency as you implement the solution. For example, ensure you are writing secure code (security), handling failures gracefully (reliability), keeping an eye on spending (cost), automating processes (operational excellence), and designing for scale (performance efficiency). Making these considerations an integral part of development will result in a more robust application.

1. **Use a production-like environment for development and testing.** Set up non-production environments (development, test, QA) that closely mirror the production configuration. This is especially important when adding new features to an existing system – your test environment should have similar Azure resources, configurations, and dataset sizes as production to reveal any integration issues. Azure DevTest Labs or infrastructure-as-code scripts can help quickly create consistent environments with controlled cost and governance. The closer your test environments are to prod, the more confidence you’ll have that things will work upon release.

1. **Implement changes incrementally using source control and CI/CD.** Manage all code in a Git repository (or other source control) and integrate changes continuously. Break down development tasks into small, manageable increments and merge code frequently to avoid integration headaches. Each change should trigger automated builds and tests (continuous integration), ensuring that new code doesn’t break existing functionality. This incremental approach enables fast feedback and makes it easier to isolate and fix issues when they arise.

### Validate cloud-native solutions with testing

1. **Conduct end-to-end functional testing to verify business processes.** Test all critical user workflows from sign-in to transaction completion using realistic scenarios. Execute regression tests to confirm unchanged functionality remains intact after modernization. Validate new features and updated interfaces meet business requirements without breaking existing processes.

1. **Perform user acceptance testing (UAT) with stakeholders.** Engage actual users or business stakeholders to run key scenarios in a UAT environment. Have them verify that the new application or features meet their needs and are user-friendly. Gather feedback on any issues or UX improvements. Resolve any critical issues found in UAT before going live, and obtain formal sign-off from these stakeholders indicating that the solution is ready from a business perspective.

1. **Validate performance using load testing under realistic conditions.** Use load testing (for example, Azure Load Testing) to simulate high user volumes and data throughput that you expect in production. Measure response times, throughput, and resource utilization under load. Ensure the system can handle at least the expected peak load, and consider testing beyond that (1.5x peak load) to see how it behaves under stress. Compare performance against your targets and against the legacy system (if applicable) to confirm there’s no degradation. Identify any bottlenecks and optimize as needed before release.

1. **Execute security and compliance tests.** Run security scans and vulnerability assessments on your application code and any container images or infrastructure components. Use tools like Microsoft Defender for Cloud to check for misconfigurations in Azure resources and ensure compliance with security benchmarks. If the workload is subject to regulatory requirements, perform compliance checks or audits in the test environment. It’s easier to fix security issues prior to deployment than to react to incidents later.

1. **Fix critical issues and verify all tests pass.** Treat testing phases as gates: do not proceed to go-live until all critical defects uncovered in testing are resolved. If performance testing shows the system missing an SLA, address it (by tuning or scaling resources). If security scans show high-risk vulnerabilities, remediate them or implement compensating controls. Only when the solution passes functional, UAT, performance, and security criteria should you consider it ready for production. Document any low-priority known issues along with plans to address them in future updates so they are not forgotten.

1. **Repeat unit and integration tests after changes.** For any new features or modifications, ensure you have adequate unit tests (covering individual components) and integration tests (covering interactions between components and external systems). Run these tests as part of your pipeline. After fixing any bug, rerun the relevant tests to confirm the issue is truly resolved and no new regressions were introduced. A solid automated test suite is crucial for maintaining quality in cloud-native continuous delivery environments.

## Create reusable infrastructure

As part of development, set up your infrastructure as code so that it can be easily reused and maintained. Define all Azure resources using infrastructure-as-code templates (Azure Resource Manager, Bicep, Terraform). Parameterize these templates to accommodate different environments (dev, test, prod) from the same code. By coding the infrastructure, you ensure consistency across deployments and make it simple to spin up additional environments or replicate the setup for future projects. Reusable modules and templates also speed up provisioning and help enforce best practices organization-wide.

## Create deployment documentation

Document the deployment process clearly. This documentation should include step-by-step instructions for deploying the solution (even if automated, describe the pipeline process), configuration settings for different environments, and any prerequisite setup (for example, feature flags to enable, domain name or DNS changes, scaling configurations). Include rollback instructions in the documentation as well, so it’s clear how to undo a deployment if needed. A thorough deployment guide is valuable for training the operations team and serves as a reference during the go-live event. It ensures that if the primary deployer is unavailable, someone else could successfully deploy or roll back the solution using the document.

## Next step

[Deploy your new solution](./deploy-cloud-native-solutions.md)