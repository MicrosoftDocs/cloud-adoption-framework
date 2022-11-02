---
title: Building your DevOps practice
description: Use the Cloud Adoption Framework to understand the motivations behind cloud migration that can help produce more successful business outcomes.
author: wayneme
ms.author: brblanch
ms.date: 05/13/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Building your DevOps practice

This article guides you through various considerations as you plan to build out your DevOps practice. The following sections can help you answer critical questions such as:

- Should our organization invest in building a DevOps team?
- What makes infrastructure-as-code preferable?
- How can automated workload and application deployment benefit our organization?
- In what ways does our operating model need to evolve over time?

Cloud architectures offer a new way to do business, offering benefits that include:

- Giving IT teams the ability to scale and democratize services
- Enabling global expansion opportunities
- Providing increased consistency and velocity

As your customers evolve and look to deliver differentiated services to accelerate business, use a well-designed DevOps practice in your organization to ensure your teams can collaborate effectively and build software at a higher velocity while also maintaining necessary controls, security and governance.

To have a strong cloud business, you need a mature DevOps practice. Unifying people, process, and technology helps you transition your organization's cloud practice into an effective operating model.

## The cloud is an operating model, not a destination

Treating the cloud as a destination is typically an indicator that an organization hasn't yet transformed its practices and delivery of services. Organizations in this mode are often highly dependent on central IT teams for provisioning. The central IT teams then hand off the system to application teams or developers. This type of workflow can slow progress and drive up costs.

When they adopt a cloud strategy, organizations:

- Democratize IT resources
- Use more cloud native services
- Enable self-service
- Use repeatable builds
- Rely on skills both in IT teams and across the entire organization

It's not wrong to use VMs and infrastructure as a service. However, you can reduce costs and overhead and improve your service delivery if you transition to using microservices and platform services and shift the role of your central IT team to governance and empowerment.

## Evolve traditional functions to make them cloud aligned

The Organize methodology of the Cloud Adoption Framework describes the functions necessary for your cloud practice. It also offers guidance on data silo avoidance and how you can empower users and tap into resources across your entire organization. Even small IT teams can accomplish a lot by removing barriers and enabling self-service for others within your organization. As you build your cloud capabilities, you'll see operations teams embracing infrastructure-as-code and traditional network, security, and system admins writing scripts to drive greater consistency.

As an example, imagine that the fictional organization Contoso Corporation acquires a new company. They need to incorporate this company, and all its applications and data, into Contoso's Azure environment. Contoso has fully scripted a new landing zone deployment. In it, they provision a subscription with appropriate permissions, network peering that connects it back to their hub network, and policies that comply with Contoso's corporate governance. The entire process takes no longer than 10 minutes before the new company can begin to migrate their applications into the new landing zone Contoso created.

In more traditional environments, the process involves a much longer waterfall approach:

- The organization acquires the hardware or service
- IT team deploys the infrastructure
- Networking configures the routing
- Security validates and applies security policies
- Governance checks compliance and applies missing policies

Each of these phases in a traditional environment can take weeks or months to complete, in contrast to the mere minutes required in a modern cloud approach.

## Repeatability drives velocity

Your move to a code-based infrastructure doesn't need to be complicated. Some simple changes can carry you a long way.

Create repeatable templates to automate your workload deployments. Build golden image VMs that have your desired security parameters, storage accounts for your long term and short term storage needs, and templates for Linux-based web applications that enable SSL only.

You can house the code for these templates in various storage options, including a git repository (like Azure DevOps or GitHub) or something like version-controlled Template Specs in Azure. The particular system your organization chooses doesn't matter so much as the adoption of the process as a whole: build, code, deploy, reuse, learn.

## Should I build all workloads through code?

Even if DevOps is critical for your strategy, not every workload is a good candidate. It's important that you identify early on which applications might benefit from an investment in DevOps and which applications won't offer much return on that investment. Consider the best way to manage these workloads and who you should make responsible for their management. Some examples of these applications include commercial off-the-shelf (COTS) applications, applications slated for sunsetting, and some legacy applications.

## Customers are key

Listening and learning from your customers is a key to your DevOps practice. As you build and maintain your organization's DevOps practice, get feedback from your users, incorporate it into your backlog, and use it as a source for continuous improvement.

As an example, one area in our own DevOps process where customers can provide direct feedback is in our technical documentation. Each published article has an edit button at the top. Readers can edit the article, initiating a pull request that goes to a specific document's owner. The owner can then review and incorporate suggestions directly from a reader. Through this process, Microsoft is able to apply skills and expertise from our entire user base in addition to the expertise within our organization.

DevOps is more than just developers building a specific product. It's an approach involving multiple key elements of the product lifecycle–a practice known as *everything as code*.

## Takeaway

As you read through the Cloud Adoption Framework documentation, notice how DevOps is present in all phases. Consider using the following process as you begin your own implementation.

1. Design your strategy with DevOps in mind.
2. Reimagine your organization as a cloud based organization.
3. Operationalize your plan using repeatable agile principles.
4. Enable CI/CD in your landing zone for consistent code based management
5. Evaluate DevSecOps to understand how security fits within your DevOps cycles.
6. Deploy your workloads through pipelines and/or actions.
7. Establish a management baseline to provide each DevOps team with consistent tools and foundations for operations.
8. Integrate insights and management into your DevOps tooling so that you can appropriately respond to changing conditions and demands.
9. Create governance guardrails so your DevOps team(s) can be confident in their ability to deploy to production without violating corporate policies.
10. Finally, consider gathering user feedback, incorporating it into your backlog, and iterating rapidly to keep your users engaged.

## Next steps

> [!div class="nextstepaction"]
> [Business outcomes overview](./business-outcomes/index.md)
