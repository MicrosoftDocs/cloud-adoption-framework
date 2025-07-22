# Develop and deploy modernizations in the cloud

After careful planning, the next step in cloud modernization is implementation: developing the changes and deploying them to production in a safe, controlled way. This phase involves building the modernized components (in dev/test environments), rigorously testing all changes (functional, performance, security), automating infrastructure, preparing deployment materials, scheduling the go-live, and executing the production cutover with minimal risk. By following a structured, prescriptive approach, organizations can ensure their modernization delivers value without disrupting the business.

## Prepare stakeholders for modernization

Stakeholder preparation reduces deployment risk and ensures smooth transition during cloud modernization. Clear communication, change control, and support readiness maintain business continuity.

1. **Announce the deployment schedule to all stakeholders.** Teams and users need clear communication about deployment timeline, scope, and expected impact. Use multiple communication channels such as email, Teams, and internal portals to ensure visibility. Include key dates such as change freeze start and go-live window to help stakeholders prepare appropriately.

2. **Implement a change freeze on source and dependent systems.** A change freeze establishes a stable baseline for deployment and testing by preventing configuration drift. Freeze code changes to legacy systems at least one week before deployment, allowing only critical severity-1 fixes. Pause automated data changes during the cutover window including scheduled imports, integrations, and background jobs. Extend the freeze to dependent systems when necessary to isolate variables and reduce risk. Clearly define the freeze window with specific start and end times to avoid confusion.

3. **Communicate final user actions and post-deployment changes.** Users need advance notice of required actions before and after deployment to prevent workflow disruption. Instruct users to log off or save work before the cutover begins. Share new access URLs, authentication changes such as Azure AD login requirements, and updated workflows that affect daily operations. Provide support documentation and quick-start guides to reduce confusion on the first day.

4. **Coordinate support staffing for deployment and hypercare periods.** IT operations and development teams must be available to monitor and respond to issues during critical deployment phases. Schedule extended support hours and additional staff for the first business day post-deployment when issues are most likely to surface. Inform business units of the hypercare plan and escalation procedures to ensure rapid issue resolution.

5. **Define fallback procedures for critical systems.** Mission-critical systems require manual workarounds and contingency plans to maintain business operations during deployment windows. Document specific procedures such as manual order processing during system read-only periods. Share these procedures in advance and confirm readiness with affected teams to ensure seamless execution when needed.

## Develop modernizations in a nonproduction environment

Development environments provide safe spaces to implement and validate modernization changes before production deployment. Proper environment setup and development practices reduce risk and accelerate delivery.

1. **Follow Well-Architected Framework principles during implementation.** Apply reliability, security, cost optimization, operational excellence, and performance efficiency guidance as you build modernization changes. Use Azure Advisor recommendations and architectural review processes to validate design decisions. This approach ensures that modernized components meet Azure best practices and operational standards.

2. **Create dev/test environments that mirror production configuration.** Provision Azure resources that match production topology using similar service types and configurations. Use Azure DevTest Labs to create consistent environments with cost controls and automated provisioning. For example, if production uses Azure SQL Database and App Service, use the same services in test environments with lower pricing tiers to maintain functional parity while controlling costs.

3. **Implement changes incrementally using source control practices.** Use Git repositories to manage code changes and enable continuous integration workflows. Break modernization work into small, testable increments that can be merged and validated frequently. For example, when refactoring code, create feature branches for individual components and run automated tests on each commit to catch issues early.

## Validate modernization changes with testing

Testing validates that modernized components function correctly and perform as expected before production deployment. Comprehensive testing across multiple layers reduces risk and ensures business continuity during cutover.

1. **Execute unit and integration tests on all modified components.** Run automated unit tests on refactored code modules to verify isolated functionality works as expected. Execute integration tests across dependent services to confirm APIs, databases, and external systems communicate correctly. Re-run tests after each bug fix to prevent regressions and maintain system stability.

2. **Conduct end-to-end functional testing to verify business processes.** Test all critical user workflows from login to transaction completion using realistic scenarios. Execute regression tests to confirm unchanged functionality remains intact after modernization. Validate new features and updated interfaces meet business requirements without breaking existing processes.

3. **Perform user acceptance testing with business stakeholders.** Engage business users to execute key workflows in the test environment and compare results with legacy system behavior. Capture feedback on usability, performance, and functionality gaps. Resolve critical UAT issues before deployment and obtain formal sign-off from stakeholders to confirm business readiness.

4. **Validate performance using load testing under realistic conditions.** Use Azure Load Testing to simulate expected production traffic patterns and measure response times, throughput, and resource utilization. Compare results against performance baselines from the source environment to identify any degradation. Conduct stress tests at 150% of expected load to determine system limits and validate resilience under pressure.

5. **Execute security validation and compliance checks.** Run vulnerability scans on new code and container images to detect security risks. Perform compliance validation for regulated workloads using industry-specific tools. Use Azure Defender for Cloud to scan for infrastructure misconfigurations and validate security controls meet requirements.

6. **Resolve all critical issues before production deployment.** Fix functional, performance, and security issues identified during testing phases. Confirm all tests pass and performance meets SLA requirements. Document any remaining low-priority issues and create remediation plans for post-deployment resolution.

## Create reusable infrastructure

[!INCLUDE [Steps to create reusable infrastructure](./includes/create-reusable-infrastructure.md)]

## Create deployment documentation

[!INCLUDE [Steps to create deployment documentation](./includes/create-reusable-infrastructure.md)]

## Deploy modernization

### Deploy modernization in-place

1. **Use a staging slot or temporary environment.** If using Azure App Service, deploy the new version to a staging slot first. This allows you to warm it up and perform a final smoke test before swapping the staging slot with the production slot for minimal downtime deployment. For AKS or VM-based systems, spin up new instances with the new code behind the scenes, gradually add them to the load balancer (canary release), and remove old ones. This approach avoids replacing everything at once blindly.

2. **Plan a maintenance window if needed.** For changes like database schema updates, schedule a short read-only period or downtime during off-hours. Communicate the maintenance window clearly to users (“The system will undergo maintenance from 10:00 PM to 11:00 PM UTC. During this time, it may be unavailable or read-only.”)

3. **Follow deployment best practices.** Use your CI/CD pipeline to deploy to production as you did in the test environment. Ensure backups are taken for any data changes, such as schema migrations. Enable diagnostics to catch errors early and facilitate troubleshooting.

4. **Perform a canary or incremental release.** Route a small percentage of traffic to the new version first and monitor it for a few minutes while most users remain on the old version. If no error spikes occur, gradually increase the percentage until 100% of traffic is routed to the new version. Use an Azure load balancer to manage traffic routing, or swap instances incrementally. This approach minimizes risk by limiting the impact of potential issues to a subset of users.

5. **Ensure no cutover of data endpoints.** For in-place deployments, the data remains the same, though it may be modified. If modernization involves data schema changes, ensure the deployment process applies those changes carefully, ideally in a backward-compatible way to accommodate any old components running during the canary release.

### Deploy modernization to a parallel environment

Parallel environment deployment creates a complete replica of production in Azure while maintaining the original system for near-zero downtime cutover and rollback capabilities.

1. **Create a production-ready parallel environment using infrastructure as code.** Deploy Azure resources that match production specifications including compute, storage, networking, and security configurations. Use Azure Resource Manager templates or Terraform to ensure consistent provisioning. Validate all services reach healthy status and configure load balancers to initially route zero traffic to the new environment.

2. **Establish database replication.** Configure your database platform's native replication feature to establish continuous data replication between your source and Azure target system. Verify that initial data synchronization completes successfully and that replication is healthy.

3. **Copy unstructured data and files.** Copy unstructured data and files to Azure before the final cutover. Use [Tools for object and file migration](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison) with features to transfer files to the appropriate Azure storage services. This preparation reduces the amount of data that needs to be copied during the final cutover.

4. **Execute final microsecond data synchronization without service interruption.** Configure database transaction log shipping or Azure SQL Data Sync to achieve near-real-time replication with seconds of lag. Pause write-heavy batch processes temporarily while maintaining user-facing operations. Use database triggers or change data capture to track and replicate final transactions during the cutover window.

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
