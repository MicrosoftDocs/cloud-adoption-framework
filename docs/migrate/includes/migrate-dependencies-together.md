1. **Discover all dependencies first.** Dependencies between workloads cause service disruptions if not migrated together. [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies) to discover these connections before creating migration groups.

2. **Analyze dependency types and criticality.** Different dependency types require different migration approaches. Distinguish between these categories:

    | Dependency type   | Description  | Migration approach     |
    |------|-------|-------|
    | Direct dependencies  | Require immediate communication and low latency between components. | Move all directly connected components together to maintain performance and avoid disruptions.        |
    | Indirect dependencies| Involve occasional or non-critical interactions between systems.   | Migrate together or in separate waves if the connection tolerates latency or supports hybrid use.    |
    | Business dependencies| Depend on organizational or management relationships.              | Group and migrate related workloads and reporting systems together to align with business priorities. |

3. **Group workloads by dependency relationships.** Create groups based on shared databases, APIs, authentication services, or network connections. These groups form the foundation of your migration waves and ensure all components required for functionality move together. When uncertainty exists about dependency criticality, group the components together. This conservative approach provides flexibility for future separation.

4. **Document each dependency group systematically.** Tag assets based on their dependency groups using consistent naming conventions. Document each group with:

    - **Group name and ID** - Unique identifier and descriptive name
    - **Component inventory** - All infrastructure elements, applications, and services
    - **Critical dependencies** - Essential connections requiring special handling
    - **Migration constraints** - Business, technical, or timing requirements

5. **Validate group completeness.** Confirm each group includes all necessary components for applications to operate, including supporting infrastructure such as load balancers, DNS records, or caching layers.