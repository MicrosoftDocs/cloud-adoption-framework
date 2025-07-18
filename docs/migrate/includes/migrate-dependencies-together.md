1. **Map dependencies.** Dependencies between workloads can cause service disruptions if not migrated together. [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies) to discover these connections.

2. **Create dependency groups.** Group workloads that share databases, APIs, authentication services, or network connections. These groups form the foundation of your migration. Grouping by dependency ensures that all components required for functionality move together, reducing post-migration troubleshooting.

3. **Validate group completeness.** Confirm that each group includes all necessary components for the applications to operate. Include supporting infrastructure such as load balancers, DNS records, or caching layers. Incomplete groups can lead to service outages or degraded performance after migration.
