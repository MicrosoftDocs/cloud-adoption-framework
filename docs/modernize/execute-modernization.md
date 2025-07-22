# Execute modernization

Once your plan is in place, begin implementing changes in a controlled, iterative manner. This reduces risk and allows for continuous learning and adjustment.

## Finalize the modernization changes

### Test modernization changes. you need to test the modernization changes. Modernization can introduce regressions or integration issues. Testing is critical. Use the following testing approaches:
    - Unit tests for any code changes.
    - Integration tests to ensure different services work with the unchanged ones.
    - Performance tests to ensure the new approach doesn’t degrade system performance.
    - Fix any issues and promote to staging environment if you have one
Ensure all your modernizations work in your non-production environment. If you're deploying in-place, then

### 
If you're using a separate (green) environment, You should create all production resources in the other production environment using infrastructure-as-code templates and apply production-grade configurations. Treat the green environment as if it were production. Run smoke tests to verify basic functionality, execute full integration and regression test suites, and perform performance and security testing. If compliance or regulatory approval is required (for example, in healthcare or finance industries), conduct those audits in the new environment as well. The goal is to vet the new setup thoroughly while it’s not serving live users so that you can be confident in its reliability.

## Deploy modernizations

Steps to deploy in the same environment

Steps to deploy in a new environment

Once the modernizations pass all tests and checks, deploy the modernization. If you have a new environment, plan the cutover to switch users and data to this environment. This could involve synchronizing data one final time (ensure the new databases have all necessary data from the old), then redirecting traffic. Techniques include updating DNS entries, switching load balancer targets, or using feature flags to swap connections to the new environment. Monitor the system closely during and after cutover for any unexpected issues. Have the team on standby to respond quickly. If serious problems are detected (for example, error rates spike or critical transactions fail), roll back by redirecting traffic to the old (blue) environment, which has remained unchanged. This back-out plan ensures that even high-risk deployments can be reversed to avoid extended outages.
Using a separate environment adds upfront effort and cost, but it provides the highest confidence for complex changes and is a vital safety net for mission-critical systems.

## Prepare stakeholders for modernization

1. **Execute cutover.**


Final Data Synchronization: In the lead-up to cutover, ensure that the latest data is in Azure. If you had a continuous replication going (for near-zero downtime move), make sure it’s up to date. If it was a one-time migration, you likely put the source in a read-only or offline mode and took a final backup. Perform that final delta migration to capture any changes since the initial data load. For example, you might freeze the on-prem database (prevent new writes), then apply the last transaction log backups to the Azure database. This step ensures the Azure environment’s data is current so users won’t lose work when they switch over. 

Plan Data Handling and Synchronization: One of the hardest things to undo is data changes. If modernization includes data migrations or transformations Consider running old and new in parallel for a time. For example, write data to both old and new databases during a transition period (dual-write), and only switch reads to the new when confirmed. That way, if the new fails, the old still has all the data. If dual-write isn’t possible, take a snapshot/backup before migration. Then, if the new data store has a problem, you could theoretically restore the old and point the app back to it. This often means downtime to restore, but having the backup is a lifesaver if things really go south.

Notify Stakeholders: Schedule the cutover at a low-usage period (perhaps a weekend or late night, depending on your business). Communicate the timeline to users and IT staff. If there will be any expected downtime or maintenance window, let users know in advance (“The system will be in read-only mode from 10 PM to midnight while we upgrade our systems”). Often, with a blue-green deployment, downtime can be near zero, but it’s still wise to have a maintenance window declared in case of unforeseen hiccups.

Execute the Cutover Plan: Depending on your strategy:

DNS and Endpoint Changes: Many cutovers involve DNS changes because users connect via a hostname (like app.company.com). DNS changes can take time to propagate (TTL considerations), but you can mitigate this by lowering the TTL value ahead of cutover (e.g., to 5 minutes) so that the flip happens quickly for most users. Alternatively, if using an application gateway or reverse proxy, you might simply reconfigure backend targets. Whichever method, ensure that connection strings, URLs, and any client configurations are updated to point to Azure. Sometimes, desktop applications or integrators have config files that need updating to the new server name – don’t overlook those.

Monitor During Cutover: The moment you start redirecting production traffic, closely monitor system metrics and logs. Use Azure Monitor, Application Insights, or custom dashboards that watch error rates, response times, CPU/memory, etc., on the new environment. Also monitor business transactions (e.g., are orders being placed successfully?). Have the team on standby to quickly address any unexpected behavior. This is often called a “war room” scenario – everyone eyes on glass as the switch occurs.

Immediate Validation: Right after cutover, perform a smoke test in production. This might mean having a few users or testers run through critical functions on the live system in Azure: create a sample transaction, retrieve some data, etc., just to confirm it’s functional for real users. Check that ancillary processes are working – for instance, scheduled jobs are running in Azure at their times, emails are sending out via the new system, etc.

Rollback Plan: Despite best efforts, sometimes you need to back out. Ensure that during the cutover window, the old environment is kept intact and running (but ideally isolated from updates) so that you can switch back if a severe issue occurs. Clearly define what conditions would trigger a rollback (e.g., error rate above X%, or a critical feature not working). Because you synchronized data up to the point of cutover, any transactions that occurred on the new system might need to be merged back if you rollback – this is tricky, so judge carefully. In many blue-green setups, if a failure is detected quickly, few new transactions have occurred and some organizations choose to accept losing that tiny set to regain stability. In phased cutovers, you can roll back just the affected phase relatively easily by moving that group back to the old system.
If the cutover is executed successfully, users will largely be unaware except noticing improvements (if any) or a brief outage if one was scheduled. They will now be using the workload in Azure. Keep the old environment running (but quiesced) for a short period until you are certain of stability on Azure. This is your safety net. For example, maybe keep the database in read-only on the old server and archive it after a week of smooth operations.

1. **Ensure data consistency.** Validate data flow when switching to a modernized component. For example, if switching databases, migrate data and consider running dual writes for a transition period.


1. **Monitor closely.** Once the modern component is live, monitor it closely. If any issues arise, roll back or fix forward quickly. Ensure Azure Monitor is capturing the correct metrics and alerts are configured appropriately. Confirm that Azure Monitor is capturing the right metrics and alerts are configured appropriately. AMBA or sign posting it for BAseline alerting, and maybe some literature around Azure Monitor and App Insights. For more information, For more information, see [Monitor your Azure cloud estate](/azure/azure-monitor/overview).

Keep Source environments Systems Until Confidence is High: During modernization, it can be tempting to quickly decommission the old infrastructure to save costs. Resist doing that immediately. It’s wise to run the new and old in parallel for some time (if possible), or at least keep the old one on standby. If you turned off an old feature flag, be ready to turn it on again if the new feature fails. Only retire the legacy when you’re fully confident the modernized version is stable and meeting SLAs.

Documentation and Knowledge Management: Ensure that changes are well-documented. As you modernize, update system documentation, runbooks, architecture diagrams, etc. Having up-to-date documentation is part of governance – it helps onboard team members, aids in troubleshooting, and is often needed for compliance. Make it part of the “definition of done” for a change that relevant docs are updated.