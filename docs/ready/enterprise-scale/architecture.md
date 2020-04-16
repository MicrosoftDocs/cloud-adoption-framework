---
title: "CAF enterprise-scale landing zone architecture"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone architecture
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# CAF enterprise-scale landing zone architecture

The principal challenges facing enterprise customers adopting Azure are 1) how to allow applications (legacy or modern) to seamlessly move at their own pace, and 2) how to provide secure and streamlined operations, management, and governance across the entire platform and all encompassed applications. To address these challenges, customers require a forward looking and Azure-native design approach, which in the context of the CAF enterprise-scale landing zone architecture.

## What is the CAF enterprise-scale landing zone architecture?

The CAF enterprise-scale landing zone architecture represents the strategic design path and target technical state for the customer’s Azure environment. It will continue to evolve in lockstep with the Azure platform and is ultimately defined by the various design decisions the customer organization must make to define their Azure journey.

It is important to highlight that not all enterprises adopt Azure in the same way, and as a result the CAF enterprise-scale landing zone architecture may vary between customers. Ultimately, the technical considerations and design recommendations presented within this guide may yield different trade-offs based on the customer scenario. Some variation is therefore expected, but provided core recommendations are followed, the resultant target architecture will position the customer on a path to sustainable scale.

## Landing zone - expanded definition

In the [landing zone considerations article](../../ready/considerations/index.md), the term landing zone is defined in detail. However, the specific needs of the CAF enterprise-scale landing zone's audience requires an expansion of that definition.

**Scope:** Within the CAF enterprise-scale landing zone, the scope of a landing zone grows considerably to to enable application migrations and greenfield development at an enterprise scale in Azure. This expansion allows for a design that can scale across the customer's full IT portfolio, which looks well beyond a short-term cloud adoption plan.

**Refactoring:** The number of subscriptions required to support a full enterprise scale IT portfolio can be quite large. The cloud adoption framework encourages an initially high-frequency of refactoring, but that should be stablized before the 10th production workload is deployed to the cloud. When working across an enterprise portfolio, 10 applications could be deployed rather quickly, making refactoring impractical. Instead it is suggested that Central IT or the Cloud Center of Excellence deliver a more complete landing zone during the first release.

**Goal:** Provide consistent landing zones based on **application archetype** subscription strategy to minimize subscription sprawl. Expand the definition of requisite components to better fit the governance and compliance needs of a cloud-mature enterprise, see image below.

**Principle purpose:** Limited refactoring opportunities and a defined subscription strategy create an opportunity to more quickly mature the customer's landing zones. CAF enterprise-scale landing zone expands the principle purpose of the landing zones to pull forward aspects of governance, compliance, security and operational management. Each of these is addressed in the first release of the landing zone(s) and supporting shared services.


---
_Using an analogy, this is similar to how city utilities such as water, gas, and electricity are accessible before new houses are constructed. In this context, the network, IAM, policies, management, and monitoring are shared 'utility' services that must be readily available to help streamline the application migration process._
***

![landing zone](./media/lz-design.png "landing zone")

Figure 1 – “landing zone” Design

## Expanded list of requisite components

The following list expands on the “landing zone” illustration by iterating through the core technical constructs which must be designed and developed within the context of customer requirements to create compliant technical “landing zone” environments and the conditions for successful Azure adoption.

- ***Identity and Access Management***: Azure AD design and integration must be built to ensure both server and user authentication. RBAC must be modelled and deployed to enforce separation of duties and the required entitlements for platform operation and management. Key management must be designed and deployed to ensure secure access to resources and support operations such as rotation and recovery. Ultimately, access roles are assigned to application owners at the control and data planes to create and manage resources autonomously.

- ***Policy Management*** Holistic and “landing zone” specific policies must be identified, described, built and deployed onto the target Azure platform to ensure corporate, regulatory and line of business controls are in place. Ultimately, policies should be used to guarantee the compliance of applications and underlying resources without any abstraction provisioning/administration capability.

- ***Management and Monitoring***: Platform level holistic (horizontal) resource monitoring and alerting must be designed, deployed, and integrated. Operational tasks such as patching and backup must also be defined and streamlined. Security operations, monitoring, and logging must be designed and integrated with both resources on Azure as well as existing on-premises systems. All Subscription activity logs , which capture control plane operations across resources, should be streamed into Log Analytics to make them available for query and analysis, subject to RBAC permissions.

- ***Network Topology and Connectivity***: The end-to-end network topology must be built and deployed across Azure regions and on-premises customer environments to ensure North-South and East-West connectivity between platform deployments. Network security must also be designed with the required services and resources identified, deployed and configured, such as Firewalls and NVAs to ensure security requirements are fully met.

- ***Shared Services Infrastructure***: Centrally controlled but de-centrally deployed services, such as Domain Controllers, must be designed, configured, and built to make requisite common services and resources available for application teams to consume and integrate with. It is important to note that not all “traditional” on premise shared services should be provided in the cloud. For example, file shares and HSMs should be considered as application level resources using native-Azure services.

- ***DevOps***: An end-to-end DevOps experience with robust SDLC practices must be designed, built and deployed to ensure the safe, repeatable and consistent delivery of Infrastructure as Code artefacts. Such artefacts are to be developed, tested and deployed using dedicated integration, release and deployment pipelines with strong source control and traceability.

In addition to the key aspects denoted above, the design, configuration, deployment, and integration of each “landing zone” should meet critical customer requirements relating to:

- Business Continuity and Disaster Recovery, both at the platform and application level.
- Service Management, such as incident response and support.
- Service Catalogue, such as CMDB.

## High Level Architecture

![CAF enterprise-scale landing zone Architecture](./media/ns-arch.png "CAF enterprise-scale landing zone Architecture")
Figure 2 – CAF enterprise-scale landing zone Architecture

## Next steps

Customize implementation of this architecture using the [Design Guidelines](./design-guidelines.md)

> [!div class="nextstepaction"]
> [Design Guidelines](./design-guidelines.md)