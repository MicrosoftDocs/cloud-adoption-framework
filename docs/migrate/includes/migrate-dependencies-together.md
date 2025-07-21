1. **Discover all dependencies first.** Dependencies between workloads cause service disruptions if not migrated together. [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies) to discover these connections before creating migration groups.

2. **Analyze dependency types and criticality.** Different dependency types require different migration approaches. Distinguish between these categories:

    - **Direct dependencies** require immediate communication with minimal latency. Application servers that constantly query database servers with strict performance requirements must exist in the same migration group. These components must move together to prevent performance issues that break applications or degrade user experience.

    - **Indirect dependencies** involve occasional interactions. These systems can exist in separate migration waves if the connection tolerates latency or cross-premises configuration.

    - **Business dependencies** extend beyond technical connections. Applications and their reporting subsystems typically share management teams and should move within the same timeframe. Applications used exclusively by specific business units benefit from grouping all components together into one migration wave.

3. **Group workloads by dependency relationships.** Create groups based on shared databases, APIs, authentication services, or network connections. These groups form the foundation of your migration waves and ensure all components required for functionality move together. When uncertainty exists about dependency criticality, group the components together. This conservative approach provides flexibility for future separation.

4. **Document each dependency group systematically.** Tag assets based on their dependency groups using consistent naming conventions. Document each group with:

    - **Group name and ID** - Unique identifier and descriptive name
    - **Component inventory** - All infrastructure elements, applications, and services
    - **Critical dependencies** - Essential connections requiring special handling
    - **Migration constraints** - Business, technical, or timing requirements

5. **Validate group completeness.** Confirm each group includes all necessary components for applications to operate, including supporting infrastructure such as load balancers, DNS records, or caching layers.
