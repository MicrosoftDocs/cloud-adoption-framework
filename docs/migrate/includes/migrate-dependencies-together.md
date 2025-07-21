1. **Map dependencies.** Dependencies between workloads cause service disruptions if not migrated together. [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies) to discover these connections.

    **Identify tightly coupled components.** Components that require low-latency, high-frequency interactions must function together. Application servers that constantly query database servers with strict performance requirements must exist in the same migration group. Separating these components between cloud and on-premises environments creates performance issues that break applications or degrade user experience.

    **Identify business dependencies.** Technical connections are not the only important relationships between workloads. Business requirements often dictate that certain systems migrate together. Applications and their reporting subsystems typically share management teams and should move within the same timeframe. Applications used exclusively by specific business units benefit from grouping all components together into one migration wave.

2. **Create dependency groups.** Group workloads that share databases, APIs, authentication services, or network connections. These groups form the foundation of your migration and ensure all components required for functionality move together,. Distinguish between dependency types:

    - **Direct dependencies** require immediate communication with minimal latency. These components must move together.

    - **Indirect dependencies** involve occasional interactions. These systems can exist in separate migration waves if the connection tolerates latency or cross-premises configuration.

    When uncertainty exists about dependency criticality, group the components together. This conservative approach provides flexibility for future separation.

3. **Document dependency groups.** Tag assets based on their dependency groups using consistent naming conventions. Document each group with:

    - **Group name and ID** - Unique identifier and descriptive name
    - **Component inventory** - All infrastructure elements, applications, and services
    - **Critical dependencies** - Essential connections requiring special handling
    - **Migration constraints** - Business, technical, or timing requirements

4. **Validate group completeness.** Confirm each group includes all necessary components for applications to operate, including supporting infrastructure such as load balancers, DNS records, or caching layers.
