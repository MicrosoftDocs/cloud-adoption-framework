---
title: Execute modernizations in the cloud
description: Execute modernizations in the cloud
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Execute modernizations in the cloud

Execution is where plans turn into reality. This involves preparing everyone for the change, doing the development work in non-production environments, testing thoroughly, and finally deploying to production in a controlled manner. The emphasis is on rigorous testing and safe deployment practices to minimize business disruption, given the changes can be significant.

## Prepare stakeholders for modernization

Before you hit the deploy button, it’s critical to prepare all stakeholders and users for what’s coming. Surprises can lead to confusion or even operational issues. Key preparation steps include communication, change freezes (mentioned earlier), and support plans:

1. **Announce the deployment schedule to all stakeholders.** Well in advance, communicate to all affected parties when the modernization deployment will happen and what to expect. Include key dates such as change freeze start and go-live window to help stakeholders prepare appropriately. By setting expectations, users can plan around the downtime, and internal teams can be ready.

2. **Implement a change freeze on source and dependent systems.** As planned earlier in governance, now is the time to actually enforce the freeze. Ensure no code changes, config tweaks, or other deployments occur on the system (and dependent systems) for some period before and during the deployment. This keeps the environment stable. Make sure all team members and any integrated third parties are aware. Clearly define the freeze window with specific start and end times to avoid confusion.

3. **Communicate final user actions and post-deployment changes.** Users need advance notice of required actions before and after deployment to prevent workflow disruption. Instruct users to log off or save work before the cutover begins. Share new access URLs, authentication changes such as Microsoft Entra ID sign-in requirements, and updated workflows that affect daily operations. Provide support documentation and quick-start guides to reduce confusion on the first day.

4. **Coordinate support staffing for deployment.** IT operations and development teams must be available to monitor and respond to issues during critical deployment phases. Schedule extended support hours and other staff for the first business day post-deployment when issues are most likely to surface. Inform business units of the post-deployment support plan and escalation procedures to ensure rapid issue resolution.

5. **Define fallback procedures for critical systems.** Mission-critical systems require manual workarounds and contingency plans to maintain business operations during deployment windows. Document specific procedures such as manual order processing during system read-only periods. Share these procedures in advance and confirm readiness with affected teams to ensure seamless execution when needed.

## Develop modernizations in a nonproduction environment

All development and integration of the modernization changes should happen outside of production (in dev, test, staging environments). The guiding principle: build and test in prod-like environments first, so that when you deploy to prod, it’s already a known quantity.

1. **Follow Well-Architected Framework principles during implementation.** As you code and configure the new changes, continually apply the best practices from Azure’s Well-Architected Framework (WAF). Use [Azure Advisor](azure/advisor/advisor-overview) recommendations and architectural review processes to validate design decisions. This approach ensures that modernized components meet Azure best practices and operational standards.

2. **Create nonproduction environments that mirror production.** Spin up dev/test environments in Azure that are as close as possible to the prod setup. If prod will use certain Azure services, use the same in test (just perhaps smaller scale or lower SKU to save cost). The closer your testing env is to prod, the more confident you can be that test results will carry over to prod behavior.

3. **Implement changes incrementally with source control and CI/CD.** Treat the modernization effort like any other software project. Use Git or other source control for all code changes and infrastructure as code scripts. This provides history and ability to roll back code if needed. Break the work into small chunks (perhaps per feature or fix) and use feature branches. Merge changes frequently after code review. Set up continuous integration builds to run your test suites on each commit, so you catch issues early.

## Validate modernization changes with testing

Testing is absolutely critical. Since modernization doesn’t add new features, the focus is on regression testing (nothing broke) and performance/security testing (it works better than before, not worse). You want to verify every aspect of the system in the test environment before touching production.

1. **Execute unit and integration tests on all modified components.** Developers should create or update unit tests for any code that was refactored. Even if it’s legacy code, writing unit tests for critical functions can help catch if refactoring changed behavior inadvertently. Run the unit tests in your CI pipeline continuously. Additionally, run integration tests to ensure that components talk to each other correctly. After any bug fix, re-run relevant tests to ensure the bug is indeed resolved and nothing else broke (avoid regressions).

2. **Conduct end-to-end functional testing.**  In a staging or test environment, perform full workflow tests as if you are an end-user. This can be manual testing by QA or automated UI tests. Log into the application, perform major tasks. Ensure that unchanged functionality remains unchanged. Basically, simulate real usage to catch anything unit tests might miss.

3. **Perform user acceptance testing (UAT) with stakeholders.** It’s wise to involve some actual end-users or business stakeholders in testing the modernized system before go-live. They might catch nuances that developers overlook. Capture feedback on usability, performance, and functionality gaps. Resolve critical user acceptance testing (UAT) issues before deployment and obtain formal sign-off from stakeholders to confirm business readiness.

4. **Validate performance using load testing under realistic conditions.** Modernization should ideally improve or maintain performance. Use load testing tools (such as Azure Load Testing) to simulate realistic usage patterns. Compare results against performance baselines from the source environment to identify any degradation. Conduct stress tests at 150% of expected load to determine system limits and validate resilience under pressure.

5. **Execute security validation and compliance checks.** Run vulnerability scans on new code and container images to detect security risks. Perform compliance validation for regulated workloads using industry-specific tools. Use Azure Defender for Cloud to scan for infrastructure misconfigurations and validate security controls meet requirements.

6. **Resolve all critical issues before production deployment.** Fix functional, performance, and security issues identified during testing phases. Confirm all tests pass and performance meets SLA requirements. Document any remaining low-priority issues and create remediation plans for post-deployment resolution.

## Create reusable infrastructure

Once your modernized solution has passed all tests in the non-prod environment, you should capture the infrastructure setup and configurations as code, so it can be easily replicated in production and future environments. Reusable infrastructure means using infrastructure-as-code (IaC) templates and automation for consistency and speed.

[!INCLUDE [Steps to create reusable infrastructure](../migrate/includes/create-reusable-infrastructure.md)]

## Create deployment documentation

[!INCLUDE [Steps to create deployment documentation](../migrate/includes/create-deployment-documentation.md)]

## Deploy modernization

Production deployment requires careful execution to minimize risk and ensure business continuity. Organizations must choose between in-place deployment (updating existing systems) or parallel environment deployment (migrating to new infrastructure) based on their risk tolerance and technical requirements.

### Execute modernization in-place

1. **Schedule a maintenance window for database changes.** Database schema updates require a planned maintenance window with clear communication to users. Schedule read-only periods or brief downtime during off-peak hours. Communicate the maintenance window clearly: "The system undergoes maintenance from 10:00 PM to 11:00 PM UTC. The system will be unavailable or read-only during this time."

2. **Execute deployment through your CI/CD pipeline.** Use your established CI/CD pipeline to deploy to production with the same process used in test environments. Take backups before any data changes such as schema migrations. Enable comprehensive logging and monitoring to detect errors quickly and support troubleshooting efforts.

3. **Implement progressive traffic routing to minimize deployment risk.** Platform-specific staging capabilities enable you to deploy the new version to a staging environment first. Staging environments allow you to warm up the application and perform final smoke tests before swapping with production for minimal downtime. For container orchestration or VM-based systems, create new instances with updated code and gradually add them to the load balancer while removing old instances. This approach prevents simultaneous replacement of all components. Azure supports canary deployments through [Azure App Service deployment slots](/azure/app-service/deploy-staging-slots), [Azure Container Apps traffic splitting](/azure/container-apps/traffic-splitting?pivots=azure-cli), and [Azure Kubernetes Service with Azure Pipelines](/azure/devops/pipelines/ecosystems/kubernetes/canary-demo?view=azure-devops&tabs=yaml).

4. **Route traffic incrementally to validate system stability.** Route a small percentage of traffic (5-10%) to the new version while monitoring error rates and performance metrics for several minutes. Most users remain on the stable version during initial validation. Gradually increase traffic percentages (25%, 50%, 100%) if no error spikes occur. Use application gateways or load balancers to manage traffic distribution and enable rapid rollback if issues arise.

5. **Maintain data consistency during deployment.** In-place deployments preserve existing data endpoints while potentially modifying data schemas. Apply database schema changes in backward-compatible ways to support both old and new application versions during canary releases. Use database migration scripts that add new columns or tables without removing existing structures until deployment completes successfully.

### Deploy modernization to a parallel environment

1. **Create a parallel production environment using infrastructure as code.** Deploy Azure resources that match production specifications including compute, storage, networking, and security configurations. Use IaC templates to ensure consistent provisioning. Validate all services reach healthy status and configure load balancers to initially route zero traffic to the new environment.

2. **Establish database replication.** Configure your database platform's native replication feature to establish continuous data replication between your source and Azure target system. Verify that initial data synchronization completes successfully and that replication is healthy.

3. **Copy unstructured data and files.** Copy unstructured data and files to Azure before the final cutover. Use [Tools for object and file migration](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison) with features to transfer files to the appropriate Azure storage services. This preparation reduces the amount of data that needs to be copied during the final cutover.

4. **Execute final microsecond data synchronization without service interruption.** Configure database transaction log shipping to achieve near-real-time replication with seconds of lag. Pause write-heavy batch processes temporarily while maintaining user-facing operations. Use database triggers or change data capture to track and replicate final transactions during the cutover window.

5. **Warm up the parallel environment with shadow traffic.** Route a copy of production traffic to the Azure environment without impacting user responses using traffic mirroring or shadow deployments. Validate that the parallel system handles realistic load patterns and responses match production behavior. Monitor performance metrics and resolve any issues before live traffic routing.

6. **Direct traffic to the new Azure workload.** Update DNS records and load balancer configurations to direct user traffic to the Azure environment. Monitor workload health and performance. Begin with 1% of live traffic directed to the modernized system using weighted routing with your Azure load balancer. Monitor real-time metrics including response times, error rates, and database connection health. Increase traffic in rapid increments (5%, 15%, 50%, 100%) over minutes rather than hours, with automated rollback triggers if thresholds are exceeded.

7. **Complete near-instantaneous cutover with zero data loss.** Use DNS failover or load balancer configuration changes to redirect 100% of traffic to the Azure environment within seconds. Execute automated health checks immediately after cutover to validate all services respond correctly. Keep database replication active until confirming the parallel environment handles full production load successfully.

8. **Conduct comprehensive post-cutover validation and monitoring.** Perform end-to-end functional testing of all critical business processes using automated test suites. Validate data accuracy using checksum verification and hash function comparisons between source and target systems. Have workload owners confirm that all major functions operate correctly. Monitor system performance, error rates, and user access patterns for the first 24-48 hours after cutover to identify any performance degradation or functionality issues.

9. **Maintain source environment as hot standby for immediate rollback.** Keep the original system running in active standby mode with ongoing data replication for at least 72 hours after cutover. Configure one-click rollback procedures using DNS changes or load balancer failback that restore service within 30 seconds. Define automated rollback triggers based on error rates, response times, or business-critical transaction failures to minimize manual intervention requirements.

## Validate modernization success

Modernization validation ensures that the workload operates correctly and meets all requirements in production. This validation confirms that data integrity is maintained and that the modernization deployment was successful. You should conduct comprehensive validation before declaring the modernization complete.

1. **Confirm successful user access and system performance.** User access validation ensures that the modernization is transparent and that performance meets expectations. This confirmation validates that users can access the workload without disruption. Monitor user access patterns, system performance metrics, and error rates during the initial post-migration period.

1. **Announce migration success only after thorough validation.** Complete validation ensures that all stakeholders confirm the workload is stable and functional. This confirmation prevents premature declarations of success that could lead to issues later. Obtain confirmation from workload owners, testers, and business stakeholders that the workload meets all requirements and operates correctly.

## Support workload during stabilization

Enhanced support coverage ensures rapid response to post-migration issues during the critical stabilization period. This support provides faster resolution of issues that commonly occur after migration. You should establish dedicated support models and update operational documentation.

1. **Establish enhanced support coverage during the stabilization period.** Dedicated support models ensure rapid response to post-migration issues during the critical stabilization period. This support provides faster resolution of issues that commonly occur after migration. Assign experienced IT staff or migration partners to monitor the workload closely and provide shorter SLAs than normal operations.

2. **Update configuration management and inventory systems.** Configuration management updates ensure that operational tools and processes reflect the new Azure environment. This maintenance keeps operational documentation current and supports ongoing management activities. Update configuration management databases (CMDB) for the new hosting environment, assuming that existing inventory tools update IP addresses, CPU, memory, and other infrastructure details automatically.

## Next step

> [!div class="nextstepaction"]
> [Optimize after cloud modernization](./optimize-after-cloud-modernization.md)
