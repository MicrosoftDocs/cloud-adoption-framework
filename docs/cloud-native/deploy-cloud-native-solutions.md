---
title: Deploy cloud-native solutions
description: Deploy cloud-native solutions
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Deploy cloud-native solutions

Now, deploy the solution to the live Azure environment following the planned strategy. This phase includes final preparations, the deployment execution, and post-deployment verification and support.

## Prepare stakeholders for cloud-native deployment

1. **Announce the deployment schedule and expected impact.** Before you begin the production deployment, communicate the plan and value to all relevant stakeholders. Announce the deployment schedule and expected user effects. For example, for new features, note any downtime or user-visible changes well in advance. Stakeholders might identify conflicts with business events or raise concerns about timing. Provide a channel for feedback and confirm that the deployment window aligns with operational priorities. Adjust the schedule if necessary to avoid disruption.

1. **Notify support teams and affected groups.** Ensure support teams are on standby and aware of what is being released so they can handle any user issues or inquiries. If the deployment might affect end-users or other systems, notify those groups too.

1. **Set expectations for functionality during the deployment window.** A deployment window might involve reduced functionality or temporary delays. Inform stakeholders of these conditions to prevent confusion and ensure business continuity. Include fallback procedures or workarounds if applicable.

1. **Conduct a predeployment readiness review.** A readiness review confirms that all teams understand their roles and have necessary access. Hold a meeting with representatives from each support team to review the deployment plan, success criteria, and rollback criteria. Verify that support teams have appropriate system access and monitoring tools configured. This preparation ensures coordinated response to any issues that arise during migration.

## Execute the cloud-native deployment

The deployment steps differ slightly based on whether it’s a new standalone workload or a feature update to an existing system:

### Deploy new cloud-native workloads

1. **Create production environment.** Use your CI/CD pipeline to deploy the production deployment pipeline using the same configuration tested in staging. Use the same build artifacts, IaC templates, and deployment scripts that passed validation in staging. Because you are deploying to a separate environment, create all necessary Azure resources via your IaC templates and then deploy the application code or artifacts.

1. **Smoke test.** Once deployed, perform smoke tests in production (basic checks) to ensure all services are up and the core functionality works in the live environment. Verify that key services are running, databases are accessible, and the application responds (hit a health check endpoint or a couple of key pages). Check [Azure Service Health](/azure/service-health/overview) for any platform issues in your region that could affect your components. This is a sanity check before any users are directed to the system.

1. **Rollout to a small group of users.** Implement the progressive rollout by exposing the new system to a small set of users. This could be done by releasing a feature to only internal users, or routing a small percentage of live to the new deployment. Monitor closely for any errors or performance issues. Use Application Insights and custom dashboards to watch error rates, response times, and resource utilization in real time. Also gather qualitative feedback from any pilot users on the canary version.

1. **Monitor and gradually expand.** Gradual rollout reduces risk and allows for real-world validation before full release. Release the application to a small group of canary users. Use a load balancer, such as Azure Front Door or Traffic Manager, to route a subset of traffic to the new deployment. Collect feedback and monitor performance. Scale up or open access to all users after successful validation.

### Deploy new cloud-native features to an existing workload

For introducing a new feature, follow the approach you decided in the planning phase:

#### Use in-place deployment for gradual rollout within the same environment

An in-place deployment updates the existing environment incrementally. The approach reduces risk by limiting exposure during early rollout stages.

1. **Rollout to a small group of users.** Update the existing environment gradually, or use feature flags. For example, enable the new feature only for a beta group of users initially. This allows verifying the feature in production on a limited scale and provides the option to disable it quickly if something goes wrong (just turn off the feature flag). This approach is usually sufficient for minor enhancements or additive features that are low risk. It has minimal overhead (no duplicate environment). Ensure you monitor the behavior of instances with the new feature versus those without it – tag their telemetry so you can compare.

1. **Smoke test.** Once deployed, perform smoke tests in production (basic checks) to ensure all services are up and the core functionality works in the live environment. Verify that key services are running, databases are accessible, and the application responds (hit a health check endpoint or a couple of key pages).

1. **Monitor and gradually expand.** If no issues are detected, continue rolling out the feature to more servers or increase the feature flag percentage. Repeat monitoring after each increment. Once the feature is deployed to 100% of the environment, perform a final validation to ensure consistent behavior across all instances.

#### Deploy new features in a parallel environment

1. **Create production environment.** Use your CI/CD pipeline to deploy the production deployment pipeline using the same configuration tested in staging. Use the same build artifacts, IaC templates, and deployment scripts that passed validation in staging. Because you are deploying to a separate environment, create all necessary Azure resources via your IaC templates and then deploy the application code or artifacts.

1. **Smoke test.** Once deployed, perform smoke tests in production (basic checks) to ensure all services are up and the core functionality works in the live environment. Verify that key services are running, databases are accessible, and the application responds (hit a health check endpoint or a couple of key pages). Check [Azure Service Health](/azure/service-health/overview) for any platform issues in your region that could affect your components. This is a sanity check before any users are directed to the system.

1. **Rollout to a small group of users.** Gradual rollout reduces risk and allows for real-world validation before full release. Release the application to a small group of canary users. Use a load balancer, such as Azure Front Door or Traffic Manager, to route a subset of traffic to the new deployment. Collect feedback and monitor performance. Scale up or open access to all users after successful validation.

1. **Monitor and gradually expand.** If the new version performs well, incrementally increase traffic routing until it handles 100% of the load. Promote the "green" deployment to be the primary. The old "blue" deployment is kept intact during this process, which makes rollback easier. If any serious problem is detected, you can instantly switch all traffic back to the stable version.

1. **Finalize cutover.** After successful validation, route all users to the new system or formally announce it live if it was hidden. The old environment, if there was one for an updated feature, can now be considered for decommissioning after a safe validation period.

## Validate deployment success

1. **Run comprehensive validation of critical user journeys.** After deploying, take time to confirm that the deployment was truly successful and the application is healthy in production. This involves more thorough checks beyond the initial smoke tests. Verify again all critical user journeys on the live system (often done by the QA team or automated test scripts against production if possible).

1. **Verify background processes and integrations.** Check that background processes, integrations, and scheduled jobs are running correctly. Check logs, job statuses, and integration endpoints to ensure they're functioning as expected. This step prevents silent failures that might not be immediately visible to users.

1. **Review monitoring dashboards for system health.** Use Azure Monitor and Application Insights to inspect logs and metrics. Confirm that there are no spikes in error rates, CPU/memory is within expected ranges, and no missing or misrouted monitoring data.

1. **Inspect alerting for unexpected triggers.** Review configured alerts for failure rates, latency, or resource usage. Confirm that no alerts are firing unexpectedly. If alerts are triggered, investigate root causes and assess whether they indicate a deployment-related issue.

1. **Conduct stakeholder and user check-ins.** It’s also wise to have a quick check-in with a few end users or stakeholders after deployment to get human confirmation that things are working from the user perspective.

1. **Declare deployment complete only after full validation.** Only once you’re satisfied that the deployment is stable and meets the acceptance criteria should you declare the deployment complete. If issues are found, fix critical ones immediately. Log minor issues for resolution in future updates.

## Support workload during stabilization

1. **Establish a heightened monitoring and support posture.** Deploying to production isn't the end of the journey. In the hours and days immediately following a go-live, increase your monitoring and support vigilance while the system "ramps up" under real-world load. It’s advisable to have the development team on call alongside the operations team to quickly investigate and resolve any problems, since they know the new changes best.

1. **Track system metrics and user feedback continuously.** Treat the first week or two as a stabilization period. Monitor metrics such as CPU, memory, error rates, and response times using Azure Monitor and Application Insights. Collect user feedback through support channels or direct outreach. This helps detect issues that automated systems might miss.

1. **Adjust configurations based on observed behavior.** Tweak configurations if needed. For example, scale out more if usage is higher than anticipated. If logs are too verbose or too sparse, modify logging levels. These changes help maintain performance and observability during peak usage. Ensure that any issues discovered in this phase are addressed or entered into your tracking system for future improvement.

1. **Log and triage all issues discovered during stabilization.** This active support phase catches issues that only reveal under production conditions and ensure the workload truly meets its goals. After this stabilization period, and once you're confident in the system’s performance, you can transition to normal operations and monitoring procedures.

1. **Define the exit criteria for stabilization.** Set clear thresholds for system performance, error rates, and user satisfaction. Once the system meets these criteria consistently, transition to standard operations and monitoring procedures. This ensures a smooth handoff and avoids premature closure of the support phase.

## Next step

> [!div class="nextstepaction"]
> [Optimize solutions after deployment](./optimize-cloud-native-solutions.md)