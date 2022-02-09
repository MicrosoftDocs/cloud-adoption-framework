---
title: What is data domains?
description: Learn about data domains
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 02/09/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# What are data domains?

Data mesh, at core, is founded in decentralization and distribution of responsibility to domains. The people who truly understand that part of the business are best positioned to manage the associated data, and to ensure it's accurate. This is the principle of domain-oriented data ownership.

To promote domain-oriented data ownership, you first need to make a decomposition of your data architecture. Zhamak Dehghani, data mesh founder, promotes Domain-Driven Design (DDD), an approach to software development, as a method for identifying your data domains.
The difficulty with DDD for data management is that the original use case for DDD was modeling of complex systems in the context of software development. Originally, it was never coined for modeling enterprise data, which makes the method for data management practitioners abstract and technical. Additionally, there’s often a lack of understanding of (DDD): practitioners find the conceptual notions too difficult to grasp or project examples that come from software architecture or object-oriented programming on their data landscape. This article tries to take away complicated vocabulary and provides you with pragmatic guidance.
Domain-Driven-Design

Let’s start with the theoretical part: Domain-Driven-Design (DDD) is a method for supporting software development that helps describe complex systems for larger organizations, originally described by Eric Evans. DDD is popular because many of its high-level practices had an impact on modern software and application development approaches, such as microservices.

DDD differentiates between bounded contexts, domains, and subdomains. Domains are the problem spaces you’re trying to address. They're the areas where knowledge, behavior, laws, and activities come together. They're the areas where you see semantic coupling: behavioral dependencies between components or services. Part of an area is also communication: team members using a language the team shares, so everybody can work efficiently. This language is also called the ubiquitous language or domain language.

Domains are usually decomposed into subdomains to better manage the complexity. A common example is decomposing a domain in such a way that each subdomain corresponds to a specific business problem. Not all subdomains are the same. You could, for example, classify domains to be either core, generic, or supporting. Core subdomains are the most important. They're the secret sauce, the ingredients, that make the business unique. Generic subdomains are nonspecific and typically easy to solve with off-the-shelf products. Supporting subdomains don’t offer competitive advantage but are necessary to keep the organization running. Usually, they aren’t that complex.
Bounded contexts are the logical (context) boundaries. They focus on the solution space: the design of systems and applications. It's an area where the alignment of focus on the solution space makes sense. Within DDD, this can be code, database designs, and so on. Between the domains and bounded contexts, there can be alignment, but binding them together is no hard rule. Bounded contexts are in general technical by nature and can span across multiple domains and subdomains.

## Recommendations for domain modeling

If you take data mesh as a concept for democratizing data, and implement the principle of domain-oriented data ownership for greater flexibility, how would this work in practice? What could a transition from enterprise data modeling to domain-driven design modeling look like? What learnings can you take from DDD for data management?

### Make a functional business decomposition of your problem spaces

The first recommendation, before allowing teams to operate their data end to end, is to look at the scope and understand the problem spaces you're trying to address. It’s important to do this exercise first, before jumping into the details of a technical implementation. As DDD advocates, it helps to set logical boundaries between these problem spaces, because responsibilities are clearer and will be better managed.
For grouping your problem spaces, it's encouraged to look at your business architecture. Within business architecture, there are business capabilities: abilities or capacities that a business possess or exchange to achieve a specific purpose or outcome. Such an abstraction packs data, processes, organization, and technology within a particular context, aligned to the strategic business goals and objectives of your organization. A business capability map shows which functional areas are assumed to be necessary to fulfill your mission and vision.

:::image type="content" source="../images/data-domains-01.png" alt-text="Business Capability Decomposition" lightbox="../images/data-domains-01.png":::
 
In the model above, you see a decomposition of a fictional company: Tailwind Traders. This company needs to master all functional areas listed in the Business Capability Map to be successful. For example, Tailwind Traders must be able to sell tickets as part of Online or Offline Tickets Management Systems or have Pilots available to fly planes thanks to a Pilot Management Program. The company can outsource some activities, whilst keeping others as the core of its business.
What you will observe in practice is that most of your people are organized around these capabilities. People working on the same business capability share the same vocabulary. The same holds for your applications and processes, which are typically well aligned and tightly connected based on the cohesion of the activities they need to support. Therefore, business capability mapping is a great starting point, but the story doesn’t end here.

### Map business capabilities to applications and data

For better managing your enterprise architecture, business capabilities, bounded contexts, and applications should be aligned. When doing so, it's important to follow some ground rules. It's vital that the business capabilities stay on the business level and remain abstract. They represent what an organization does and target the problem space. When a business capability is implemented, a realization—capability instance—for a specific context is created. Within such boundaries in the solution space, multiple applications and components work together to deliver specific business value.

Applications and components that are aligned with a specific business capability stay decoupled from applications aligned with other business capabilities, because these are different business concerns. You can set clear principles: Bounded contexts are derived from and exclusively mapped to business capabilities. They represent the boundary of a business capability implementation and behave like a domain. If business capabilities change, bounded contexts change. Preferably you expect full alignment between domains and corresponding bounded contexts, but reality -as you'll learn in next sections- can be different. If you project the capability mapping to Tailwind Traders, your bounded context boundaries and domain implementations could look like below.

:::image type="content" source="../images/data-domains-02.png" alt-text="Diagram showing bounded contexts" lightbox="../images/data-domains-02.png":::
 
In the example from above, Customer management is founded on subject matter expertise and therefore knows best what data to serve to other domains. The Customer management’s inner architecture is decoupled, so all application components within these boundaries can directly communicate using application-specific interfaces and data models. However, data distribution to other domains is formalized using [data products](../data-landing-zone-data-products.md) and clear interoperability standards. In this approach, all [data products](../data-landing-zone-data-products.md) are also aligned with the domain and inherit the ubiquitous language: a constructed, formalized language, agreed upon by stakeholders and designers from the same domain, to serve the needs of that domain.

Multiple capability realizations result in additional domains
When working with business capability maps, it's important to acknowledge that some business capabilities can be instantiated several times. For instance, Tailwind Traders, the example you used so far, can have multiple localized realizations, or implementations, of “baggage handling and lost items”. For example, one line of business operates only in Asia. In that context, “baggage handling and lost items” is a capability that is fulfilled for Asia-related airplanes. A different line of business could target the European market, so in this context another “baggage handling and lost items” capability is used. This scenario of multiple instances could lead to multiple localized implementations using different technology services and disjoined teams operating those services. To conclude: the relationship of business capability and capability instance (realization) is one-to-many, which also means that you end up with additional (sub-)domains.

### Find shared capabilities and watch out for shared data

More important is how you should handle shared business capabilities. Such a capability is typically implemented centrally -as a service model- and provided to different lines of business. “Customer management”, for example, could be such a capability. In the context of Tailwind Traders, both the Asia and European lines of business use the same administration for their clients. The question is: how to project domain data ownership on a shared capability? It’s likely that multiple business representatives take accountability for customers that sit in the same shared administration. To conclude, there's an application domain and a data domain! From a data product viewpoint, your domain and bounded context don’t perfectly align. Conversely, you could argue that from a business capability’s viewpoint, there’s still a single data concern.

For your shared capabilities, such as complex vendor packages, SaaS solutions and legacy systems, it's recommended to be consistent on your domain data ownership approach. One technique could be to segregate data ownership via [data products](../data-landing-zone-data-products.md), which also might require application improvements. In the example of “customer management” different pipelines from the application domain could generate multiple [data products](../data-landing-zone-data-products.md): one data product for all Asia-related customers and one for all European-related customers. This means multiple data domains originate from the same application domain.
A different technique for handling shared data is to ask your application domains to design a single data product that encapsulates metadata for distinguishing data ownership inside the data product. You could, for example, use a reserved column name for ownership, mapping each row to a single specific data domain.

### Identify monoliths that offer multiple business capabilities

Another attention point is applications that cater for multiple business capabilities, as often seen in large and traditional enterprises. For example, Tailwind Traders use a complex software package to facilitate both “cost management” and “assets and financing”. Such shared applications are generally large and complex: monoliths that provide as many features as possible. The application domain in such a situation is expected to be larger. Same applies for shared ownership, which means several data domains reside in an application domain.
Design patterns for source-aligned, redelivery and consumer-aligned domains
When mapping your domains, you'll learn there are different patterns, based on the creation, consumption, or redelivery of data. The recommendation for your architecture is to design blueprints for supporting your domains, based on the characteristics they have.

#### Source system-aligned domains

:::image type="content" source="../images/data-domains-03.png" alt-text="Source system-aligned domains" lightbox="../images/data-domains-03.png":::

* Source system-aligned domains are aligned with source systems, where the data originates. These are typically transactional or operational systems. The goal must be to capture data directly from these golden source systems. [data products](../data-landing-zone-data-products.md) that originate from the providing domains should be read-optimized for intensive data consumption, so you want to facilitate your domains using standardized services for data transformation and sharing. These services, including pre-configured container structures, enable your source-oriented domain teams to publish data more easily; it’s the path of least resistance to do the right thing with the benefit of minimal disruption and costs.

#### Consumer-aligned domains

:::image type="content" source="../images/data-domains-04.png" alt-text="Consumer-aligned domains" lightbox="../images/data-domains-04.png":::

* Consumer-aligned domains are the opposite of source-aligned domains because they are aligned with specific end-user use cases that require data from other domains. They consume and transform data to fit their use cases of the business. To cater for these consuming needs, you should consider offering shared data services for data transformation and consumption, e.g., domain-agnostic data infrastructure capabilities to handle data pipelines, storage infrastructure, streaming services, analytical processing, and so on.

#### Redelivery domains

:::image type="content" source="../images/data-domains-05.png" alt-text="Re-delivery domains" lightbox="../images/data-domains-05.png":::

* Redelivery domains: A different and more difficult scenario is the reusability of data. For example, multiple downstream consumers might be interested in a combination of data from different domains. You can create [data products](../data-landing-zone-data-products.md), which aggregate data or combine high-level data required by many domains. This takes away the repetitive work.

For your architecture, it's recommended to loosely couple the creation of [data products](../data-landing-zone-data-products.md) and analytical use cases. In the model below, a domain takes both the ownership for aggregated data reusable data and an analytical use case. However, the two concerns are decoupled. With this approach, data consumers can safely consume new [data products](../data-landing-zone-data-products.md), while not being tightly connected to analytical use cases of the same domain. The aggregated data in this situation is input for the analytical use case.

### Define patterns for overlapping domains

Domain modeling often gets complicated when data or business logic is shared across domains. In large-scale organizations, domains often rely on data from other domains. In such situations it could help to have generic domains that provide integration logic in a way that allows other subdomains to standardize and benefit from it. A ground rule is to keep the shared model between subdomains small and always aligned with the ubiquitous language.

For overlapping data requirements, you can use different patterns from domain-driven design. Here's a short summary of the patterns you could choose from:

:::image type="content" source="../images/data-domains-06.png" alt-text="DDD patterns for overlapping domains" lightbox="../images/data-domains-06.png":::
 
* Separate ways, as a design pattern, can be used if the associated cost of duplication is preferred over reusability. This pattern is typically a choice when reusability is sacrificed for higher flexibility and agility.
* A customer-supplier pattern can be used if one domain is strong and willing to take ownership of the data and needs of downstream consumers. The drawbacks of this pattern can be conflicting concerns, forcing downstream teams to negotiate deliverables and schedule priorities.
* In the partnership model, the integration logic is coordinated in an unplanned manner within a newly created domain. All teams cooperate with and regard each other’s needs. A significant commitment is needed from everybody because each can’t change the shared logic freely.
* A conformist pattern can be used to conform all domains to all requirements. This pattern can be a choice 1) when the integration work is complex 2) no other parties are allowed to have control 3) or when vendor packages are used.

In all cases, it's recommended for your domains to adhere to your interoperability standards. Thus, a partnership domain that produces new data for other domains must expose their [data products](../data-landing-zone-data-products.md) like any other domain, including the part of taking ownership.

## Domain Responsibilities

Data mesh decentralizes data ownership by distributing it among domain teams. For many organizations, this means a shift from a centralized model around governance to a federated model. This means that domain teams are assigned with tasks, such as:

- Domains taking ownership of data pipelines, such as ingestion, cleaning and transforming data to serve as many data customer's needs as possible
- Improving [Data Quality](../data-quality.md) for data, including adherence to SLAs and quality measures set by data consumers
- Encapsulating metadata or using reserved column names for fine-grained row- and column-level filtering
- Adhering to metadata management standards, such as:
    - Application and source system schema registration
    - Metadata for improved discoverability
    - Versioning information
    - Linkage of data attributes and business terms
    - Integrity [metadata](../metadata-standards.md) information for allowing domains to better integrate with other domains
- Adhering to data interoperability standards, including protocols, data formats and data types
- Providing lineage by either linking source systems and integration services to scanners or manually providing lineage
- Adhering to tasks related to data sharing, including IAM access review and creating data contracts

## Level of granularity for decoupling

Now you know how to recognize and facilitate data domains, you come to your next point: designing the right level of domain granularity and rules for decoupling. There are two important dimensions that come into play when decomposing your architecture:

First, there's granularity for functional domains and setting bounded contexts: domains conforming to the way of working, ensuring data becomes available to all domains and enjoy using shared services, taking ownership, adhering to metadata standards, and so on. A recommendation for data distribution is to set the boundaries, where possible, fine-grained because becoming data-driven is all about making data available for intensively reusing data. If you define your domain boundaries too coarse-grained, you'll force undesired couplings between many applications and data reusability gets lost. Thus, each time data crosses boundaries of business capabilities, strive for decoupling. This means that within a domain, tight coupling within the inner architecture of the domain is allowed. However, when crossing the boundaries, domains must stay decoupled and distribute read-optimized [data products](../data-landing-zone-data-products.md) for sharing data to other domains.

Second, there's granularity for technical domains and infrastructure utilization. These are your [data landing zones](../data-landing-zone.md) for enabling agility to service data integrations and [data products](../data-landing-zone-data-products.md) within it. Such a landing zone, with shared infrastructure and services underneath, how would you offer this to your different domain teams? The experiences are that many different aspects trigger functional domains will be logically grouped together and become candidates for sharing platform infrastructure. Here are some considerations:

* Cohesion and efficiency in the way of working and sharing data is a strong driver of aligning functional domains to a data landing zone. This strongly relates to data gravity: tendency of constantly sharing large datasets between domains.
* Regional boundaries could result in implementing additional data landing zones.
* Ownership, security, or legal boundaries might force domains to be segregated. For example, some data cannot be allowed to be seen by other domains.
* Flexibility and pace of change are important drivers. There can be the velocity of innovation within several domains, while other domains strongly value stability.
* Functional boundaries can drive teams apart, for example source-/consumer-oriented. Maybe half of your domain teams value particular services over other sets of services.
* A reason might be that you want to potentially sell or separate off your capability, so integrating tightly with shared services from other domains wouldn’t be wise to do.
* Team size, skills and maturity can be a factor. Highly skilled and mature teams desire to operate their own services and infrastructure, while less mature teams don’t value the additional overhead of platform maintenance.

It's recommended before provisioning many data landing zones to look at your domain decomposition and determine what functional domains become candidates for sharing the underlying infrastructure.

## Summary

The benefit of business capability modeling is that it helps you to better recognize and organize your domains in a data mesh architecture. It provides a holistic view of how data and applications deliver value to your business. At the same time, you prioritize and focus on your data strategy and real business needs. You can also use this model beyond the need for only data. If, for example, scalability is a concern, you can identify your most critical core capabilities and develop a strategy for those.
Some practitioners raise concerns that building such a target-state architecture by mapping out everything upfront is an intensive exercise. The proposed alternative is identifying your domains organically while onboarding them into your new data mesh architecture. Thus, instead of top-down defining your target state, you work bottom-up: explore, experiment, and transition your current state towards a target state. This approach might be potentially quicker but exposes a risk of getting into complex move or remodel operations when things start to break. A more nuanced approach could be working in both directions and meeting in the middle over time.

