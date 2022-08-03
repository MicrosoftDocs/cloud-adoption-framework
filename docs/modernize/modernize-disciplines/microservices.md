### Use microservices

Microservices architecture means breaking large software projects into smaller, independent, and loosely coupled modules. The range of Azure offerings gives you the flexibility to implement independent services with a framework designed for distributed systems, using containers, or with a serverless approach.

:::image type="content" source="../../_images/modernize/rearchitect-with-microservices.png" alt-text="Graphic showing monolithic versus microservices.":::

Benefits of using microservices:

- Each service is independent, so you can develop a new project on its own schedule.
- You can use any language or stack that best fits current requirements.
- Scaling up is easier than with VMs or containers, as it only requires deploying more services as needed.
- Application maintenance is easier. Developers work on individual services, so the code base the developer works with is smaller, easier to manage, and easier to understand.
- Microservices-based applications are more resilient and stable. If one or more services fail, the application continues to work.
- Individual service instances can be upgraded, changed, or taken down without negative results to the entire application.

Potential drawbacks of using microservices:

- Increased complexity.
- Need for good dependency management to keep track of independent services that work together as a product.
- Need for dependency/API testing to ensure compatibility with other services (where required).
- When services interact with each other, it's important to use [cloud architecture best practices](/azure/architecture/best-practices/index-best-practices) to avoid creating a distributed monolith.