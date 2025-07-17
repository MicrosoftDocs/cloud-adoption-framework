3. Rearchitecting

**Rearchitecting involves fundamental changes to application architecture and infrastructure topology.** This modernization technique redesigns how components interact, communicate, and deploy to improve scalability, reliability, and maintainability. You should consider rearchitecting when current architecture limits growth or creates operational challenges.

Examples of rearchitecting include:

- **Decouple tightly coupled components.** Transform direct component dependencies into loosely coupled services. For example, replace a web application where the frontend directly calls the backend and database with an API gateway that abstracts backend services behind interfaces.

- **Redesign deployment topology.** Change how and where services deploy to improve availability and performance. For example, move from single-region deployment to multi-region deployment across multiple availability zones.

- **Consolidate or split services.** Reorganize service boundaries to improve cohesion and reduce complexity. For example, consolidate multiple microservices with overlapping responsibilities into fewer, more cohesive services.

- **Replace synchronous communication with asynchronous messaging.** Change how services communicate to improve resilience and scalability. For example, replace direct method calls or REST APIs with message brokers like Azure Service Bus for asynchronous communication.

- **Transform monolithic applications into microservices.** Break large, monolithic applications into smaller, independently deployable services that can scale and evolve separately.
    - WAF
        - [Design infrastructure to scale](/azure/well-architected/performance-efficiency/scale-partition#design-infrastructure-to-scale)
    - AAC
        - [Microservices architecture](/azure/architecture/guide/architecture-styles/microservices)
        - [Reliable web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance)

- **Add caching layers.** Introduce caching between application components and data stores to improve performance. For example, add Azure Cache for Redis between applications and databases to reduce direct database hits.

- **Transition from batch to stream processing.** Change data processing patterns to reduce latency and improve real-time capabilities. For example, replace batch processing with long latency with stream processing using Azure Stream Analytics for near real-time insights.

- **Adopt event-driven architecture.** Replace polling-based integrations with event-driven patterns that respond to changes as they occur.

- **Implement purpose-built databases.** Replace single databases handling multiple workload types with specialized databases optimized for specific use cases. For example, use Azure SQL Database for transactional data and Azure Cosmos DB for high-throughput reads.

- **Replace synchronous API calls with asynchronous messaging.** Change inter-service communication from blocking synchronous calls to non-blocking asynchronous messaging using Azure Service Bus queues or Azure Event Grid.