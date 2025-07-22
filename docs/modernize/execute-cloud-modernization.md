# Develop and deploy modernizations in the cloud

After careful planning, the next step in cloud modernization is implementation: developing the changes and deploying them to production in a safe, controlled way. This phase involves building the modernized components (in dev/test environments), rigorously testing all changes (functional, performance, security), automating infrastructure, preparing deployment materials, scheduling the go-live, and executing the production cutover with minimal risk. By following a structured, prescriptive approach, organizations can ensure their modernization delivers value without disrupting the business.

## Prepare stakeholders for modernization

It’s vital to prepare everyone involved (and impacted) for the deployment event. Surprises or lack of communication can cause panic or disruptions. Key elements here include stakeholder communication, scheduling, and implementing a change freeze on source systems.

### Stakeholder Preparation

1. Announce the Deployment Schedule: Communicate to all relevant parties the when and what of the deployment:

2. Implement a Change Freeze on Source Systems: A change freeze means no further alterations to the system (other than the planned modernization deployment) for a defined period. The reason is to maintain a stable baseline and data consistency:
    - Freeze code changes to the old system typically a week or so before deployment (only critical fixes allowed). This prevents the scenario where the production system diverges after you’ve tested the modernization. 
    - Freeze data changes during cutover window: coordinate with any processes or people that might change data outside of user transactions. For instance, temporarily pause scheduled imports, turn off integrations that might write to the database, etc., during the cutover. The aim is to have a quiescent state to do final sync. This is especially crucial if you cannot fully pause user activity – at least freeze other automated changes.
    - In some cases, organizations implement a broad freeze on all dependent systems too, to ensure nothing in the ecosystem changes in parallel (so isolating variables).
    - Clearly define the freeze period "“From Friday 00:00 through Sunday 12:00, no changes in XYZ system except emergency fixes for severity-1 incidents.”
    
3. Final Data Checks and User Prep: If there are actions users need to take, communicate them. For example, “Please save your work and log off before 10 PM” or “After the upgrade, you will need to use the new URL https://app-new.company.com – we will redirect the old URL automatically, but update your bookmarks.” If you changed authentication (say now they login with Azure AD), ensure support articles or comms are ready so users aren’t confused on Monday.

4. Coordinate Support Staffing: Ensure your IT ops or dev team is monitoring after deployment (we cover that in next section), but also that support channels are ready. Perhaps have extra support hours or people on hand the day after, in case users have more questions or minor issues (often called a “hypercare” period). Inform the business that the team will be on standby to quickly address any issue.

5. Business Continuity Planning: If this system is critical, notify any dependent business units of fallback procedures during the cutover. For instance, “While the system is read-only, any urgent orders can be taken manually and entered after 11 PM,” or similar. Most of the time with short downtimes this isn’t needed, but it’s worth considering for mission-critical operations.

## Develop Modernizations in a Dev/Test Environment

Begin by implementing your modernization changes in a dedicated development/test environment before touching your production systems. This environment should mirror production as closely as possible – same configurations, similar data shapes (anonymized if needed), and equivalent Azure services tiers. This parity ensures that tests and observations in dev/test will reliably predict behavior in production.

1. Follow Well-Architected and Design Guidelines: As you implement the modernization (be it code refactoring, replatforming changes, or new architecture components), use the Well-Architected Framework as a guide.

2. Set Up Dev/Test Environments Resembling Prod: Provision Azure resources for development and testing that closely match the production topology (though perhaps smaller in scale). For example, if the production uses an Azure SQL Database and Azure App Service, use the same services in test (just lower pricing tiers if needed). The Azure Well-Architected Framework recommends testing in an environment that matches production to catch environment-specific issues.

3. Use Azure Dev/Test Services: Azure offers tools like Azure DevTest Labs for quickly provisioning consistent dev/test environments and controlling costs. Use these to automate environment setup for each test cycle. This ensures every iteration of testing starts in a clean, known state.

4. Implement Incrementally and Keep Source Control: If possible, develop the modernization in small increments and use source control (e.g., Git) to manage changes. This way you can integrate and test changes continuously. For instance, if refactoring code, merge into a dev branch and run automated tests on each commit.

## Validate all modernization changes (Testing)

Before deploying to production, test everything, test early, and test often. Remember, the goal is zero surprises in production. It is far cheaper and easier to fix problems now than to do emergency fixes later. Addressing bugs in production can cost an order of magnitude more effort than during dev/test. This testing phase is where you pay that cost upfront to avoid chaos later. Modernization changes, no matter how well engineered, can inadvertently introduce bugs or performance issues. A comprehensive testing phase acts as a quality gate to catch these. You should perform multiple layers of testing in your dev/test (and staging) environments By the end of this step, you should have high confidence that the modernized system is functional, meets requirements, and is performant and secure. It’s essentially a rehearsal of the production system, just not serving real users yet.

### Peer Review and Static Analysis

Have your team review the code and infrastructure changes. Utilize static code analysis or Azure Advisor for infrastructure recommendations during development. It’s easier to fix design issues now than after deployment.

### Validate code changes with unit and integration tests

Run unit tests on all modified modules to validate isolated functionality. Unit tests verify that each updated module (e.g., refactored API endpoints, new services) performs as expected without dependencies. Use automated test frameworks to ensure repeatability and coverage.
Execute integration tests across dependent modules to confirm interactions remain intact. Integration tests validate that modules such as APIs and databases communicate correctly. For example, test end-to-end data retrieval and updates through the API to ensure internal interfaces and logic are not broken.
Repeat tests after each bug fix or code change to maintain confidence in system stability. Re-run unit and integration tests after resolving issues to confirm fixes and prevent regressions.

### Confirm workload functionality with end-to-end functional tests

Run regression tests to verify unchanged functionality remains intact. Use existing test suites to confirm that legacy features behave exactly as before. Focus on areas not intended to change during modernization.
Test new functionality introduced during modernization to validate expected behavior. This includes changes such as updated login flows, new URLs, or modified user interfaces. Ensure all new features meet business and user expectations.
Conduct integration tests with external systems to confirm interoperability. Validate that upstream and downstream systems (e.g., queues, APIs, third-party services) still process data correctly. Use staging environments to simulate real-world interactions.
Document and resolve any issues discovered during testing before proceeding. Track defects, apply fixes, and re-test until all functional tests pass without errors.

Validate business readiness with user acceptance testing (UAT)

Engage business users to execute realistic scenarios in a test environment. Ask users to perform key workflows such as creating orders or generating reports to validate usability and correctness.
Capture and prioritize feedback from UAT participants to identify gaps. Encourage users to compare the new system with the legacy version and report any regressions or unexpected behavior.
Resolve critical UAT issues before production deployment to ensure business continuity. For example, if a report format change breaks Excel macros, restore compatibility before go-live.
Record formal sign-off from stakeholders to confirm readiness. Document UAT outcomes and approvals to support deployment decisions.

Validate performance with load and stress testing

Establish a performance baseline using production metrics to define expectations. Identify key indicators such as concurrent users, response times, and resource usage.
Simulate realistic load using Azure Load Testing to evaluate system behavior. Gradually increase traffic to peak levels and monitor throughput, latency, and error rates.
Identify and resolve performance bottlenecks using telemetry tools. Use Azure Monitor and Application Insights to pinpoint slow components or resource constraints. Apply optimizations such as indexing, scaling, or caching.
Conduct stress tests to determine system limits and validate resilience. Push beyond expected load (e.g., 150% of peak) to identify failure points and ensure stability under pressure.
Compare test results to baseline and SLA targets to confirm performance goals. Address any regressions before deployment and validate improvements where applicable.
Optimize resource allocation based on test data to balance cost and performance. Right-size services and plan for scaling based on observed usage patterns.

### Validate security posture with targeted testing

Perform vulnerability scans on new code and containers to detect risks. Use static code analysis and container image scanning tools to identify common vulnerabilities.
Run compliance checks for regulated workloads to confirm adherence. Use industry-specific validation tools to ensure the environment meets required standards.
Scan the environment for misconfigurations using Azure Defender for Cloud to identify exposure. Validate storage access, certificate handling, and network security settings.
Engage security specialists for major changes to review identity, data flow, and access controls. Conduct penetration testing if modernization introduces significant architectural changes.
Enforce iteration and bug resolution before deployment
Final validation ensures the system is ready for production.
Fix all critical issues discovered during testing to meet acceptance criteria. Do not proceed until functional, performance, and security tests pass.
Confirm performance meets thresholds and SLAs to ensure operational readiness. Validate that no severe regressions exist and that improvements are realized.
Obtain UAT sign-off from business stakeholders to confirm business alignment. Ensure users are satisfied with the system’s behavior and performance.
Remediate or formally accept any remaining security vulnerabilities with a mitigation plan. Document risks and ensure they are addressed or approved.

## Validate the modernization changes

When ready, conduct functional and performance testing for anything you modernized. Test early and often.

Execute comprehensive functional testing. Conduct user acceptance testing (UAT), integration testing, and regression testing to confirm that the application meets business and technical requirements. Test all critical user workflows and business processes to ensure they work correctly in the Azure environment. Document any functional issues and resolve them before production deployment.

Measure performance under realistic load conditions. Use Azure Load Testing to simulate realistic user traffic and measure response times, throughput, and resource utilization. Configure load tests to reflect expected production usage patterns and peak load scenarios. Load Testing provides detailed performance metrics and identifies bottlenecks that could affect user experience.

Validate performance against baseline. Reference the performance baseline metrics documented during the CAF Plan workload assessment. Compare test results to established performance baselines from your source environment. Identify any performance degradation and optimize configurations, scale resources, or modify code to meet performance targets.

Include stakeholders in acceptance testing. Conduct acceptance testing with business users to confirm that the workload meets business expectations and user experience requirements. Business validation ensures that the workload delivers expected value and functionality before production deployment.

Test modernization changes. you need to test the modernization changes. Modernization can introduce regressions or integration issues. Testing is critical. Use the following testing approaches:
    - Unit tests for any code changes.
    - Integration tests to ensure different services work with the unchanged ones.
    - Performance tests to ensure the new approach doesn’t degrade system performance.
    - Fix any issues and promote to staging environment if you have one

Ensure all your modernizations work in your non-production environment.

## Choose deployment strategy and prepare environments

With a validated solution in hand, decide how you will deploy the modernization to production. There are two primary strategies:
In-Place Deployment (Direct Update): You deploy changes into the existing production environment/components (for example, deploy new code to the existing app service, or alter the existing database schema in place). This is simpler but may incur some downtime or risk since you’re modifying live systems. It’s generally suitable when modernization is mainly internal code changes or minor infra tweaks that can be done rapidly and rolled back easily.
Blue-Green Deployment (New Environment Cutover): You set up a parallel production environment (green) that is a clone of the modernized system, get it fully ready and synced with data, then switch user traffic to it (cutover), leaving the old environment (blue) intact as a fallback. This method requires more work and resources (two of everything temporarily) but offers the safest path for significant changes, because you can test the new environment in production-like conditions without impacting users, and rollback is just a matter of switching back to the old environment.

By the end of this step, you should have:
Decided which deployment approach to use.
Prepared either the existing environment or built a parallel environment accordingly.
All systems (either staging slot or new environment) should be in a ready state, awaiting final cutover.


The blue-green approach is highly recommended for high-stakes systems because it provides a reliable back-out plan: if the new environment has issues, you can quickly revert traffic to the unchanged old environment with minimal downtime. The trade-off is the extra cost and work of doubling the infrastructure temporarily. Evaluate that cost against the risk of in-place deployment for your specific case.

### In-place deployment validation

You deploy changes into the existing production environment/components (for example, deploy new code to the existing app service, or alter the existing database schema in place). This is simpler but may incur some downtime or risk since you’re modifying live systems. It’s generally suitable when modernization is mainly internal code changes or minor infra tweaks that can be done rapidly and rolled back easily.

1. **Use a staging slot or temporary environment.** If using Azure App Service, deploy the new version to a staging slot first. This allows you to warm it up and perform a final smoke test before swapping the staging slot with the production slot for minimal downtime deployment. For AKS or VM-based systems, spin up new instances with the new code behind the scenes, gradually add them to the load balancer (canary release), and remove old ones. This approach avoids replacing everything at once blindly.

2. **Plan a maintenance window if needed.** For changes like database schema updates, schedule a short read-only period or downtime during off-hours. Communicate the maintenance window clearly to users (“The system will undergo maintenance from 10:00 PM to 11:00 PM UTC. During this time, it may be unavailable or read-only.”)

3. **Follow deployment best practices.** Use your CI/CD pipeline to deploy to production as you did in the test environment. Ensure backups are taken for any data changes, such as schema migrations. Enable diagnostics to catch errors early and facilitate troubleshooting.

4. **Perform a canary or incremental release.** Route a small percentage of traffic to the new version first and monitor it for a few minutes while most users remain on the old version. If no error spikes occur, gradually increase the percentage until 100% of traffic is routed to the new version. Use an Azure load balancer to manage traffic routing, or swap instances incrementally. This approach minimizes risk by limiting the impact of potential issues to a subset of users.

5. **Ensure no cutover of data endpoints.** For in-place deployments, the data remains the same, though it may be modified. If modernization involves data schema changes, ensure the deployment process applies those changes carefully, ideally in a backward-compatible way to accommodate any old components running during the canary release.

### New environment deployment validation

Provision the New (Green) Environment: In Azure, create all the production parallel resources ahead of time using your Infrastructure as Code templates (we discuss IaC in the next step). This green environment should be configured with production settings (scaling, connection strings pointing to production data sources, etc.), but initially isolated from users. For instance, you might deploy a duplicate set of web apps, a new database instance, etc., in a staging resource group or with a different URL.
Data Synchronization Strategy: The hardest part of cutover is often data. Plan how to get the current production data into the new environment:
If using a new database: set up continuous replication from the old database to the new one (if homogeneous, use SQL replication or Azure Data Sync; if heterogeneous, perhaps use Azure Data Factory or change capture processes). Ensure replication lag is minimal (ideally zero) before cutover. Monitor the replication for latency or errors.
If data volumes are small or medium, you could also do an initial bulk copy (backup/restore or dump/import) and then incremental updates. For example, take a full backup of the prod DB at T-1 day, restore it to new DB, then apply transaction log backups or delta scripts at cutover.
For file storage or unstructured data (blobs, files, etc.): pre-copy all blobs to the new storage account beforehand. Azure Storage replication tools or AzCopy can help. Validate that files in new storage match the old (consider spot-checking file counts and maybe checksums).
The goal is to minimize the data to transfer during the final switch. Ideally, at cutover, you only have a small delta (e.g., last few minutes of transactions) to sync.
Plan for a short read-only period on the old system if needed. For example, you might put the old system into maintenance mode for 15 minutes during cutover so no new transactions are created, ensuring final sync catches everything and then you redirect users. Communicate this as part of the maintenance window.
Final Validation in Green Environment: Treat the new environment like production and run final tests:
Conduct a full smoke test in the green environment with production configuration. For example, hit the new web endpoint (maybe via a test URL or internal IP) to ensure it returns the expected results, run a test transaction that goes through the new database (possibly using a sandbox account so as not to interfere with real data), etc.
If possible, do a limited trial: perhaps have an internal user or test user point to the new environment and verify everything works with live data.
Verify all monitoring and logging is working on the green environment as well. You want to be sure you’ll see any issues once it’s live.

### Compliance and approval checks

If your org requires any audits or approvals (security scans, architecture review sign-offs) before a system goes live, perform them now on the green setup. For instance, run a security vulnerability scan on the new environment, get sign-off from a compliance team if this is a regulated system (demonstrating that the new environment meets requirements), etc.

## Create reusable infrastructure

***SAME AS MIGRATION**

## Create deployment documentation

Deployment documentation ensures that teams can consistently deploy and maintain workloads across environments. It also supports troubleshooting and compliance.

1. Document configuration changes and deployment procedures. Record all environment-specific settings, connection strings, service endpoints, and security configurations in accessible documentation. Include step-by-step deployment instructions, prerequisite requirements, and post-deployment validation steps. This documentation enables consistent deployments and supports troubleshooting when issues occur.

2. Update rollback and recovery procedures. Create detailed steps to revert changes when deployment issues occur. Include rollback triggers, data backup and restoration procedures, and recovery validation steps. Test rollback procedures regularly to ensure they work correctly when needed. This preparation reduces downtime and provides. For more information, see Define rollback plan.

Contact and Escalation List: List who needs to be present (on-call) during the deployment and how to reach them. E.g., one person each from Dev, Ops, DBA, Networking, plus a business stakeholder if needed. Also, have escalation contacts (if the deployment team hits a snag they can’t solve, who can they call? e.g., an architect or vendor support). If involving outside support (Microsoft support, etc.), have those numbers ready.


## 7. Deploy Modernizations to Production (Execution of Cutover)

Now comes the moment of truth: deploying the modernization in production. This step should follow the plan and scripts you’ve prepared. Here we will outline the process for both in-place and blue-green scenarios:

### In-Place Deployment Execution

1. Pre-deployment Backup and Checks: Just before starting, ensure backups are taken:
Database: Take a fresh backup or snapshot of the production database. Verify it’s stored safely (in Azure Blob or on a secondary server).
grahambinks
Configurations: Export current configuration settings (app settings, connection strings). This helps in rollback if needed to know what the originals were.
Any content or files: if users upload files, ensure those are backed up or the storage account has recovery.
Quick health check: verify the system is currently running fine (no existing issues). It’s good to start from a clean state.
Notify Start of Maintenance: If you promised a maintenance window to users, announce (via banner or email) that it’s starting. Put system in read-only or maintenance mode if possible (some apps have a switch for this). For example, maybe disable write access or put up a “down for maintenance” page if downtime is expected.
Execute Deployment Automation: Run your pipeline to create/update infrastructure and deploy code:
If using deployment slots, deploy to the staging slot of the App Service while users continue on production slot.
If not, deploy directly but keep monitoring. This could involve running az cli or Terraform scripts for infra changes and then az webapp deployment or similar for code.
Apply database schema migrations. Important: Database changes should be applied in a way that doesn’t break the app in the middle of the deployment. In some cases, you might apply a backward-compatible change a bit earlier (e.g., add new columns that code will use, which doesn’t affect old code, then later remove old columns in a second deployment after code has switched). If not possible, ensure the app is quiescent when migration runs.
The automation should configure everything (maybe your pipeline already integrates IaC as mentioned and deploys code). Watch the output of scripts for any errors. If anything fails at this stage and cannot be quickly fixed, consider aborting and rolling back before users are impacted.
Swap Slots / Activate New Code: If you deployed to a staging slot and all looks good (the app is warmed up there), swap the staging slot with production slot. This makes the new code live almost instantly, and the old code moves to staging (as a backup).
If not using slots, you’ve effectively already deployed the new code. To minimize impact, some use strategies like taking one instance out of a load balancer at a time, updating it, then moving to the next, etc. Assuming you did that, at this point new code is running everywhere.
Post-Deployment Smoke Test: With the new version live (perhaps still within the maintenance window), do a quick smoke test in production:
Try a simple transaction or use a read-only account to hit a few GET endpoints.
Ensure the home page loads, login works, basic queries run. This is to catch any immediate showstopper (like “the app pool didn’t start” or “connection string is wrong so nothing works”).
If any critical issue is found, you can rollback quickly (swap slots back, or redeploy old code).
If things look okay, you can end the maintenance mode (unlock the system for users).
Gradually Ramp Up Usage (if applicable): If you had all users off, now let them in. If you had some canary mechanism, you might gradually increase traffic. For example, if you launched with only 1 of 4 instances on new code, now bring the other 3 up to date one by one, watching metrics as each goes live.
Announce Completion: Communicate to users (and internally to stakeholders) that the system is back online with the modernization complete. Encourage them to report any issues through support channels.

### Blue-Green Deployment Execution (Switch to New Environment)

Final Data Synchronization: Enter the planned maintenance window and perform the final incremental data sync:
If using replication, ideally you planned to stop writes and wait until replication lag is zero. Once reached, you might lock the old database (to ensure no new writes) and then break replication (the new DB now has all data up to the second of cutover).
If using backup/restore, take the final incremental backup from old DB and restore/apply it to the new DB.
Migrate any final file changes (maybe there were a few files added on the old system that day; copy them to new storage).
Double-check critical data tables counts on old vs new for sanity (e.g., “users” table has 1,002,530 rows on both sides).
Take Old System Offline (if not already): You want users out of the old system now to avoid confusion or further changes. Display a maintenance page or otherwise make it inaccessible.
Bring Up New Environment: All the new infrastructure should already be running (you did that in step 3). Now:
Ensure configuration on new environment is pointing to the new database/storage (which has latest data).
If any services were stopped, start them. For example, start the background processes or enable the function triggers in the new environment.
Essentially get the new environment into the state “ready to serve production”.
DNS / Traffic Cutover: Flip the switch to route users to the new environment:
DNS change: If the app is accessed via a domain name, update the DNS record to point to the new environment’s IP or URL. This could be switching an A record to a new IP (like new Azure Front Door or load balancer IP), or a CNAME to a new App Service URL. Lower the DNS TTL beforehand (to, say, 5 minutes) so that caches update quickly.
Load Balancer swap: If both envs are behind a traffic manager or LB, change the weighting to 100% new, 0% old.
Many Azure services allow seamless swap: e.g., Azure Front Door could have both old and new backends; you disable old, enable new.
This step effectively makes all new app endpoints live to users. Some users might get on it immediately, others as DNS propagates over a few minutes.
Monitor and Verify Immediately: As soon as the new environment is live:
Monitor primary metrics (CPU, memory, instance counts, queue depths, etc.) to see if anything is abnormal.
Look at the application logs or Application Insights live metrics for errors. A spike of exceptions right after going live is a red flag.
Run smoke tests (like log in as a test user, perform a key transaction) on the actual production URL hitting the new environment.
If any test fails or you see critical errors (like users unable to perform a basic action), you have your criteria for rollback. For example, say the new environment cannot connect to a third-party API due to a firewall issue – this should trigger rollback if it’s essential.
Resolve or Rollback: If issues found are minor configuration tweaks (and users aren’t heavily impacted yet), you can try to fix forward quickly (for example, open a firewall rule for that API if that was missed). But set a strict time limit for fixes. If a fix will take too long or the issue impact is severe, initiate rollback:
To rollback in blue-green, simply revert the DNS or traffic manager settings to send users back to the old (blue) environment. Because the old environment was untouched and still running the pre-modernization system, it should be fully functional.
Users might see a brief outage during the switch-back, but they’ll be back on the familiar system soon.
After rollback, communicate accordingly (e.g., “We encountered an issue and have reverted to the old system. We’ll reschedule the upgrade once resolved.”) and then debug the new environment offline.
Full Go-Live Confirmation: Assuming things look good and no rollback:
Consider the system officially live on the new environment. Remove or update any banners that said “upgrade in progress.”
Continue to monitor closely (we detail that in the next section).
Enable Post-Cutover Processes: Turn on any integrations or jobs that were paused for cutover. For example, resume data feeds, enable the nightly jobs in the new environment’s scheduler, etc. Ensure the new environment takes over all responsibilities.
Keep Old Environment on Standby: Don’t tear anything down yet. Keep the old environment running (perhaps in a locked state so no one accidentally uses it, if possible) for at least a day or two as a fallback. It’s your insurance if something subtle was missed and you decide to revert later. Yes, it incurs extra cost for a short while, but it’s worth the safety.

## Monitor closely

If the cutover is executed successfully, users will largely be unaware except noticing improvements (if any) or a brief outage if one was scheduled. They will now be using the workload in Azure. Keep the old environment running (but quiesced) for a short period until you are certain of stability on Azure. This is your safety net. For example, maybe keep the database in read-only on the old server and archive it after a week of smooth operations.

 Once the modern component is live, monitor it closely. If any issues arise, roll back or fix forward quickly. Ensure Azure Monitor is capturing the correct metrics and alerts are configured appropriately. Confirm that Azure Monitor is capturing the right metrics and alerts are configured appropriately. AMBA or sign posting it for BAseline alerting, and maybe some literature around Azure Monitor and App Insights. For more information, For more information, see [Monitor your Azure cloud estate](/azure/azure-monitor/overview).

## Keep Source environments Systems Until Confidence is High

During modernization, it can be tempting to quickly decommission the old infrastructure to save costs. Resist doing that immediately. It’s wise to run the new and old in parallel for some time (if possible), or at least keep the old one on standby. If you turned off an old feature flag, be ready to turn it on again if the new feature fails. Only retire the legacy when you’re fully confident the modernized version is stable and meeting SLAs.

## Documentation and Knowledge Management

Ensure that changes are well-documented. As you modernize, update system documentation, runbooks, architecture diagrams, etc. Having up-to-date documentation is part of governance – it helps onboard team members, aids in troubleshooting, and is often needed for compliance. Make it part of the “definition of done” for a change that relevant docs are updated.