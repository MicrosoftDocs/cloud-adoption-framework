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

## Prepare stakeholders

1. **Announce the deployment schedule and expected impact.** Before you begin the production deployment, communicate the plan and value to all relevant stakeholders. Announce the deployment schedule and expected user effects. For example, for new features, note any downtime or user-visible changes well in advance. Stakeholders might identify conflicts with business events or raise concerns about timing. Provide a channel for feedback and confirm that the deployment window aligns with operational priorities. Adjust the schedule if necessary to avoid disruption.

1. **Notify support teams and affected groups.** Ensure support teams are on standby and aware of what is being released so they can handle any user issues or inquiries. If the deployment might affect end-users or other systems, notify those groups too.

1. **Set expectations for functionality during the deployment window.** A deployment window might involve reduced functionality or temporary delays. Inform stakeholders of these conditions to prevent confusion and ensure business continuity. Include fallback procedures or workarounds if applicable.

1. **Conduct a pre-migration readiness review.** A readiness review confirms that all teams understand their roles and have necessary access. Hold a meeting with representatives from each support team to review the deployment plan, success criteria, and rollback criteria. Verify that support teams have appropriate system access and monitoring tools configured. This preparation ensures coordinated response to any issues that arise during migration.

## Execute the deployment

The deployment steps differ slightly based on whether it’s a new standalone workload or a feature update to an existing system, but in either case use automation and best practices:

### Deploying new workload

1. **Create production environment** Use your CI/CD pipeline to deploy the production deployment pipeline using the same configuration tested in staging. Use the same build artifacts, IaC templates, and deployment scripts that passed validation in staging. Because you are deploying a fresh workload, create all necessary Azure resources via your IaC templates and then deploy the application code or artifacts.

1. **Monitor the deployment process closely.** Make sure that logging and monitoring are enabled from the start so you can catch any errors immediately. Configure Azure Monitor, Application Insights, and Log Analytics to capture logs and metrics. Ensure logs are collected for both infrastructure and application components.

1. **Validate production readiness** Once deployed, perform smoke tests in production (basic checks) to ensure all services are up and the core functionality works in the live environment. Validate core functionality such as API availability, database connectivity, and UI responsiveness. Verify that all services are running and dependencies are healthy. Check service health in Azure Service Health and validate that all endpoints respond as expected.

1. **Prepare for rollback in case of critical issues.** Rollback readiness ensures that you can quickly recover from failed deployments. Define and test rollback procedures before production deployment. Include teardown scripts for IaC and backup/restore procedures for data. Store rollback artifacts in a secure location. Monitor for showstopper issues and initiate rollback if needed. If critical errors are detected or core functionality fails, execute rollback steps immediately to restore the previous stable state.

1. **Gradually scale up based on user feedback** Gradual rollout reduces risk and allows for real-world validation before full release.
Release the application to a small group of canary users. Use a load balancer, such as Azure Front Door or Traffic Manager, to route a subset of traffic to the new deployment. Collect feedback and monitor performance. Scale up or open access to all users after successful validation.

### Deploying new features to an existing system

For introducing a new feature, follow the approach you decided in the planning phase:

#### Use in-place deployment for gradual rollout within the same environment

An in-place deployment updates the existing environment incrementally. The approach reduces risk by limiting exposure during early rollout stages.

1. **Deploy the feature to a small subset of instances or users.** Start by updating a single server, pod, or instance, or enable the feature for a small user segment using a feature flag. This limits the blast radius if issues arise.

1. **Monitor system health and logs after partial rollout.** Use tools like Azure Monitor and Application Insights to track performance metrics, error rates, and user behavior. Validate that the new feature behaves as expected.

1. **Gradually expand the rollout to more instances or users.** If no issues are detected, continue rolling out the feature to more servers or increase the feature flag percentage. Repeat monitoring after each increment.

1. **Complete the rollout and confirm full system stability.** Once the feature is deployed to 100% of the environment, perform a final validation to ensure consistent behavior across all instances.

#### Deploy feature in parallel environment

A parallel deployment runs the new version alongside the current version. This approach enables easy rollback and minimizes downtime.

1. **Create production environment** Use your CI/CD pipeline to deploy the production deployment pipeline using the same configuration tested in staging. Use the same build artifacts, IaC templates, and deployment scripts that passed validation in staging. Because you are deploying to a separate environment, create all necessary Azure resources (via your IaC templates) and then deploy the application code or artifacts.

1. **Monitor the deployment process closely.** Make sure that logging and monitoring are enabled from the start so you can catch any errors immediately. Configure Azure Monitor, Application Insights, and Log Analytics to capture logs and metrics. Ensure logs are collected for both infrastructure and application components.

1. **Validate production readiness** Once deployed, perform smoke tests in production (basic checks) to ensure all services are up and the core functionality works in the live environment. Validate core functionality such as API availability, database connectivity, and UI responsiveness. Verify that all services are running and dependencies are healthy. Check service health in Azure Service Health and validate that all endpoints respond as expected.

1. **Prepare for rollback in case of critical issues.** Rollback readiness ensures that you can quickly recover from failed deployments.
Define and test rollback procedures before production deployment. Include teardown scripts for IaC and backup/restore procedures for data. Store rollback artifacts in a secure location. Monitor for showstopper issues and initiate rollback if needed. If critical errors are detected or core functionality fails, execute rollback steps immediately to restore the previous stable state.

1. **Gradually scale up based on user feedback** Gradual rollout reduces risk and allows for real-world validation before full release.
Release the application to a small group of canary users. Use a load balancer, such as Azure Front Door or Traffic Manager, to route a subset of traffic to the new deployment. Collect feedback and monitor performance. Scale up or open access to all users after successful validation.

1. **Compare performance and error rates between versions.** Monitor both environments using Azure Monitor and Application Insights. Closely monitor the new version’s performance and error rates compared to the old version.

1. **Gradually shift all traffic to the new version.** If the new version performs well, incrementally increase traffic routing until it handles 100% of the load. Promote the "green" deployment to be the primary. The old "blue" deployment is kept intact during this process, which makes rollback trivial. If any serious problem is detected, you can instantly switch all traffic back to the stable version.

1. **Decommission or repurpose the old environment.** After full validation, shut down or reuse the old environment to optimize resource usage and cost.

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