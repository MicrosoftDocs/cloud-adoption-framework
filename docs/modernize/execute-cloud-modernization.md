---
title: Execute modernizations in the cloud
description: Learn how to execute cloud modernization projects successfully. This article provides step-by-step guidance for preparing stakeholders, developing in nonproduction environments, conducting comprehensive testing, creating reusable infrastructure as code, and deploying to production with proper validation and stabilization support. Includes specific instructions for both in-place and parallel deployment strategies with Azure-native tools and services.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Execute modernizations in the cloud

Execution is where plans turn into reality. This step involves preparing everyone for the change, doing the development work in nonproduction environments. You test thoroughly and deploy to production in a controlled manner. The emphasis is on rigorous testing and safe deployment practices to minimize business disruption, given the changes can be significant.

## Prepare stakeholders for modernization

Before you hit the deploy button, it’s critical to prepare all stakeholders and users for what’s coming. Surprises can lead to confusion or even operational issues. Key preparation steps include communication, change freezes (mentioned earlier), and support plans:

1. **Announce the deployment schedule to all stakeholders.** Well in advance, communicate to all affected parties when the modernization deployment should happen and what to expect. Include key dates such as change freeze start and go-live window to help stakeholders prepare appropriately. By setting expectations, users can plan around the downtime, and internal teams can be ready.

2. **Implement a change freeze on source and dependent workloads.** As planned earlier in governance, now is the time to actually enforce the freeze. Ensure no code changes, config tweaks, or other deployments occur on the workload (and dependent workloads) for some period before and during the deployment. This keeps the environment stable. Make sure all team members and any integrated third parties are aware. Clearly define the freeze window with specific start and end times to avoid confusion.

3. **Communicate final user actions and post-deployment changes.** Users need advance notice of required actions before and after deployment to prevent workflow disruption. Instruct users to sign out or save work before the cutover begins. Share new access URLs, authentication changes such as Microsoft Entra ID sign-in requirements, and updated workflows that affect daily operations. Provide support documentation and quick-start guides to reduce confusion on the first day.

4. **Coordinate support staffing for deployment.** IT operations and development teams must be available to monitor and respond to issues during critical deployment phases. Schedule extended support hours and other staff for the first business day post-deployment when issues are most likely to surface. Inform business units of the post-deployment support plan and escalation procedures to ensure rapid issue resolution.

5. **Define fallback procedures for critical workloads.** Mission-critical workloads require manual workarounds and contingency plans to maintain business operations during deployment windows. Document specific procedures such as manual order processing during workload read-only periods. Share these procedures in advance and confirm readiness with affected teams to ensure seamless execution when needed.

## Develop modernizations in a nonproduction environment

All development and integration of the modernization changes should happen outside of production (in dev, test, staging environments). The guiding principle: build and test in prod-like environments first, so that when you deploy to prod, it’s already a known quantity.

1. **Follow Well-Architected Framework principles during implementation.** As you code and configure the new changes, continually apply the best practices from Azure’s [Well-Architected Framework (WAF)](/azure/well-architected/pillars). Use [Azure Advisor](/azure/advisor/advisor-overview) recommendations and architectural review processes to validate design decisions. This approach ensures that modernized components meet Azure best practices and operational standards.

2. **Create nonproduction environments that mirror production.** Spin up dev/test environments in Azure that are as close as possible to the production setup. If production uses certain Azure services, use the same in test, smaller scale or lower performance tier (SKU) to save cost. The closer your testing environment is to production, the more confident you can be that test results should carry over to production behavior.

3. **Implement changes incrementally with source control and CI/CD.** Treat the modernization effort like any other software project. Use Git or other source control for all code changes and infrastructure as code scripts. It provides history and ability to roll back code if needed. Break the work into small chunks (perhaps per feature or fix) and use feature branches. Merge changes frequently after code review. Set up continuous integration builds to run your test suites on each commit, so you catch issues early.

## Validate modernization changes with testing

Testing is critical. Since modernization doesn’t add new features, the focus is on regression testing (nothing broke) and performance/security testing (it works better than before, not worse). You want to verify every aspect of the workload in the test environment before touching production.

1. **Execute unit and integration tests on all modified components.** Developers should create or update unit tests for any code that was refactored. Even if its legacy code, writing unit tests for critical functions can help catch if refactoring changed behavior inadvertently. Run the unit tests in your CI pipeline continuously. Additionally, run integration tests to ensure that components talk to each other correctly. After any bug fix, rerun relevant tests to ensure the bug is indeed resolved and nothing else broke (avoid regressions).

2. **Conduct end-to-end functional testing.**  In a staging or test environment, perform full workflow tests as if you're an end-user. This testing can be manual testing by QA or automated UI tests. Sign-in to the application, perform major tasks. Ensure that unchanged functionality remains unchanged. Basically, simulate real usage to catch anything unit tests might miss.

3. **Perform user acceptance testing (UAT) with stakeholders.** It’s wise to involve some actual end-users or business stakeholders in testing the modernized workload before go-live. They might catch nuances that developers overlook. Capture feedback on usability, performance, and functionality gaps. Resolve critical user acceptance testing (UAT) issues before deployment and obtain formal approval from stakeholders to confirm business readiness.

4. **Validate performance using load testing under realistic conditions.** Modernization should ideally improve or maintain performance. Use load testing tools (such as Azure Load Testing) to simulate realistic usage patterns. Compare results against performance baselines from the source environment to identify any degradation. Conduct stress tests at 150% of expected load to determine workload limits and validate resilience under pressure.

5. **Execute security validation and compliance checks.** Run vulnerability scans on new code and container images to detect security risks. Perform compliance validation for regulated workloads using industry-specific tools. Use Azure Defender for Cloud to scan for infrastructure misconfigurations and validate security controls meet requirements.

6. **Resolve all critical issues before production deployment.** Fix functional, performance, and security issues identified during testing phases. Confirm all tests pass and performance meets service level agreements (SLAs). Document any remaining low-priority issues and create remediation plans for post-deployment resolution.

## Create reusable infrastructure

Once your modernized solution passes all tests in the nonproduction environment, you should capture the infrastructure setup and configurations as code, so it can be easily replicated in production and future environments. Reusable infrastructure means using infrastructure-as-code (IaC) templates and automation for consistency and speed.

[!INCLUDE [Steps to create reusable infrastructure](../migrate/includes/create-reusable-infrastructure.md)]

## Create deployment documentation

[!INCLUDE [Steps to create deployment documentation](../migrate/includes/create-deployment-documentation.md)]

## Deploy modernization

Production deployment is the climax of the modernization effort. Depending on your chosen strategy (in-place vs parallel), the steps differ. Before executing, double-check that all preparation steps are done: stakeholders informed, freeze in effect, backups taken, monitoring on standby.

### Deploy the modernization in-place

1. **Schedule a maintenance window.** If the changes require any downtime or running scripts that lock resources, like a database schema migration, do it in a preannounced maintenance window. Ensure all users are off the workload at that time. Having a clear window also gives you a target to finish the deployment or to decide on rollback if you run out of time.

2. **Use your CI/CD pipeline for deployment.** A production deployment should use the same automated pipeline you used for test but pointed at the production environment. This setup ensures consistency, so infrastructure and code deploys the same way. Before running it, take final backups of any critical data (databases). Even if you can rollback, having a backup is an extra safety net in case something goes awry. Run the pipeline to deploy the new code and infrastructure changes. Have logs and monitoring visible in real time. If any step fails, pause and evaluate whether you can fix forward or need to roll back.

3. **Implement progressive traffic routing (canary) if possible.** Many Azure services allow slot swaps or gradual traffic shift, even in an in-place scenario. Azure supports canary deployments through [Azure App Service deployment slots](/azure/app-service/deploy-staging-slots), [Azure Container Apps traffic splitting](/azure/container-apps/traffic-splitting), and [Azure Kubernetes Service with Azure Pipelines](/azure/devops/pipelines/ecosystems/kubernetes/canary-demo). If you have multiple virtual machines behind a load balancer, update one instance at a time (a rolling upgrade) so that others carry traffic, then rotate.

4. **Gradually increase to full traffic while monitoring.** Once the new version is live, monitor it closely. Check application logs, performance metrics, error rates. Start with a small portion of users (or start with the workload in a validation mode if possible). If all looks good after a few minutes, increase to say 25% of traffic. Check metrics again (no spike in 500 errors, response times normal). Increase to 50%, then 100% over whatever timeframe you planned. It could be over an hour or more if you want to be cautious. If any serious issue is observed at any step, initiate rollback before it affects all users.

5. **Maintain data consistency during deployment.** In-place deployments preserve existing data endpoints while potentially modifying data schemas. Apply database schema changes in backward-compatible ways to support both old and new application versions during canary releases. Use database migration scripts that add new columns or tables without removing existing structures until deployment completes successfully.

### Deploy the modernization to a parallel environment

1. **Create the parallel production environment.** Using the IaC templates, create the new production environment in Azure that mirrors what you tested. This environment includes all compute, networking, storage. It should be up and running but currently with no user traffic. Ensure things like network security groups, firewalls, identity (managed identities or service principals), and monitoring are all configured as needed (basically repeat the test env setup in prod subscription).

2. **Establish database replication.** Configure your database platform's native replication feature to establish continuous data replication between your source and Azure target workload. Verify that initial data synchronization completes successfully and that replication is healthy. You might do an initial bulk copy of the database from backup or snapshot then enable replication for new transactions. Monitor the lag in replication using your database platform's monitoring tools. Higher latency increases cutover risk and duration. Don't proceed to the next step until replication lag is zero.

3. **Copy unstructured data and files.** Copy unstructured data and files to Azure before the final cutover. Use [Tools for object and file migration](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison) with features to transfer files to the appropriate Azure storage services. This preparation reduces the amount of data that needs to be copied during the final cutover.

4. **Complete final data synchronization.** At cutover moment, you want zero or minimal data loss. For databases, verify no pending transactions remain on the source workloads and database replication is caught up. In some cases, you might need to briefly pause writes on the source database to flush final changes (especially for things like transactional consistency). You could use techniques like transaction log shipping or a short downtime to do a last incremental backup restore. Copy any modified unstructured data using AzCopy or similar tool.

5. **Gradually cut over user traffic to the new environment.** Update DNS records and load balancer configurations to direct user traffic to the Azure environment. Monitor workload health and performance. Begin with 1% of live traffic directed to the modernized workload using weighted routing with your Azure load balancer. Monitor real-time metrics including response times, error rates, and database connection health. Increase traffic in rapid increments (5%, 15%, 50%) over minutes rather than hours, with automated rollback triggers if thresholds are exceeded.

6. **Perform the final switch to 100%.** Once you’re confident, route all users to the new environment. This switch might be a DNS cutover, which can take seconds to minutes if the time-to-live (TTL) value was low, or flipping a load balancer configuration. At this point, users are live on the modernized workload.

7. **Immediately verify and monitor post-cutover.** Run through your post-cutover validation checks. Perform end-to-end functional testing of all critical business processes using automated test suites. Validate data accuracy using checksum verification and hash function comparisons between source and target workloads. Have workload owners confirm that all major functions operate correctly. Monitor workload performance, error rates, and user access patterns for the first 24-48 hours after cutover to identify any performance degradation or functionality issues.

8. **Keep the old environment running (hot standby) for a while.** Don’t tear anything down yet. It’s wise to keep the old workload as a hot standby for at least 24-72 hours, with ongoing data sync if possible (or ready to sync quickly). If an unexpected severe problem emerges in production, you can still decide to roll back by directing traffic back. You should lose minimal data, since you can catch up from logs or other means.

## Validate modernization success

Now that the new workload is live, you need to validate in production that everything is working as intended and meeting the acceptance criteria.

1. **Confirm successful user access and workload performance.** User access validation ensures that the modernization is transparent and that performance meets expectations. This confirmation validates that users can access the workload without disruption. Monitor user access patterns, workload performance metrics, and error rates during the initial post-migration period.

1. **Announce migration success only after thorough validation.** Complete validation ensures that all stakeholders confirm the workload is stable and functional. This confirmation prevents premature declarations of success that could lead to issues later. Obtain confirmation from workload owners, testers, and business stakeholders that the workload meets all requirements and operates correctly.

## Support workload during stabilization

Even after a successful launch, plan for a stabilization period where you give the workload extra attention. Newly modernized workloads might have unknown issues that only appear under real-world usage patterns after some time.

1. **Establish enhanced support coverage during the stabilization period.** For the first few days or weeks (depending on complexity) after go-live, have a heightened support protocol. Assign experienced IT staff or migration partners to monitor the workload closely and provide shorter SLAs than normal operations.

2. **Update your operational documentation and tools.** Ensure all runbooks, support docs, and monitoring configurations are updated to reflect the new reality. Train the operations team on any new procedures like new backup processes, new restart procedures for microservices. Hand over the modernized workload to the ops/support teams with full knowledge transfer. Ensure your asset inventory/CMDB records the new servers, IPs, services, and removes or marks legacy ones.

## Next step

> [!div class="nextstepaction"]
> [Optimize after cloud modernization](./optimize-after-cloud-modernization.md)
