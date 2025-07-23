1. **Review workload details.** Work with stakeholders to review business and technical details for each workload. Ensure that downtime or failure impacts are well understood and align with current business priorities. Use the [migration adoption plan](/azure/cloud-adoption-framework/plan/migration-adoption-plan#details-on-each-workload) to verify details like business unit, workload owner, technical dependencies, and criticality classification. These details help prioritize and sequence workloads effectively.

    | Priority | Business value | Effort | Description |
    |----------|----------------|--------|-------------|
    | High | High | Low | Quick wins - migrate first for immediate impact |
    | Medium-High | High | High | Strategic investments - plan carefully with adequate resources |
    | Medium-Low | Low | Low | Easy candidates - fill gaps between major migrations |
    | Low | Low | High | Avoid or defer - focus resources on higher-value opportunities |

2. **Start with simpler workloads to reduce risk.** Begin migrating workloads that are less complex and have lower risk. This approach helps your team gain confidence and refine migration processes before tackling more challenging workloads. Target internal tools, development environments, or low-usage applications with standalone architectures and minimal integration points.

3. **Move non-production environments before production.** Nonproduction environments provide a safe space to test the full migration process. Migrate development, staging, and QA environments before production to validate readiness. This order allows teams to test configurations, performance, and recovery procedures without affecting users. Use nonproduction migrations to train operations teams.

4. **Schedule critical systems after you demonstrate initial success.** Critical applications require proven migration capabilities before you move them to Azure. Plan these migrations for later waves when your team demonstrates competency with Azure services. Business deadlines such as hardware refresh cycles might require you to prioritize critical applications earlier with more safeguards and extended testing periods.

5. **Include representative complex workloads to test scenarios.** Add one or two complex workloads to each early wave to expose challenges you face with mission-critical applications. Choose workloads that represent common patterns such as multi-tier applications or database-dependent systems.
