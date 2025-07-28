A rollback plan helps teams quickly undo changes when a deployment fails or creates risks. A clear rollback plan minimizes downtime, reduces business effects, and ensures systems remain reliable. You should prepare rollback criteria and steps before starting any migration or deployment.

### Set rollback criteria

1. **Work with stakeholders to define failure conditions.** Collaborate with business stakeholders, workload owners, and operations teams to decide what counts as a failed deployment. Examples include failed health checks, poor performance, security issues, or unmet success metrics. This definition ensures rollback decisions align with your organization's risk tolerance.

2. **Add rollback triggers to the deployment plan.** Include specific conditions that trigger a rollback in your deployment plan, such as CPU usage limits, response time thresholds, or error rates. This evaluation makes rollback decisions clear and consistent during incidents.

3. **Automate rollback steps in CI/CD pipelines.** Use tools like [Azure Pipelines](/azure/devops/pipelines/process/stages) or [GitHub Actions](https://docs.github.com/actions/deployment/targeting-different-environments/using-environments-for-deployment) to automate rollback processes. For example, configure pipelines to redeploy a previous version if health checks fail.

### Document rollback procedures

1. **Create workload-specific rollback instructions.** Develop rollback steps that match your workload type, environment, and deployment method. For example, infrastructure-as-code deployments require reapplying previous templates, while application rollbacks involve redeploying a prior container image.

2. **Include rollback assets in documentation.** Attach rollback scripts, configuration snapshots, and infrastructure-as-code templates to your rollback plan. These assets enable rapid execution and reduce dependence on manual intervention.

### Test rollback procedures in a preproduction environment

1. **Simulate failure scenarios in staging.** Use a preproduction environment to simulate deployment failures and validate rollback effectiveness. This testing helps identify gaps in automation, permissions, or dependencies.

2. **Verify system recovery to a known-good state.** Confirm that rollback restores the system to a stable and functional configuration. This verification builds confidence in your rollback plan and supports operational readiness.

### Review and update rollback strategies after each deployment

1. **Conduct post-incident reviews.** After each deployment or rollback event, assess what worked and what didn't. Identify gaps in criteria, procedures, or automation.

2. **Update rollback documentation based on lessons learned.** Revise rollback plans to reflect new insights, changes in architecture, or updated tooling. This practice keeps rollback strategies current and effective.