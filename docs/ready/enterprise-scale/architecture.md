---
title: Cloud Adoption Framework enterprise-scale landing zone architecture
description: Learn about enterprise-scale landing zone architecture in the Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# Cloud Adoption Framework enterprise-scale landing zone architecture

Enterprise-scale is an architectural approach and a reference implementation that enables effective construction and operationalization of landing zones on Azure, at scale. This approach aligns with the Azure roadmap and the Cloud Adoption Framework for Azure.

## Architecture overview

The Cloud Adoption Framework enterprise-scale landing zone architecture represents the strategic design path and target technical state for an organization's Azure environment. It will continue to evolve alongside the Azure platform and is defined by the various design decisions that your organization must make to map your Azure journey.

Not all enterprises adopt Azure the same way, so the Cloud Adoption Framework enterprise-scale landing zone architecture varies between customers. The technical considerations and design recommendations in this guide might yield different trade-offs based on your organization's scenario. Some variation is expected, but if you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale.

## Landing zone: Expanded definition

[Landing zone considerations](../../ready/considerations/index.md) provides a detailed definition of the term _landing zone_. The audience of the Cloud Adoption Framework enterprise-scale landing zone needs an even more specific definition.

- **Scope:** Within the Cloud Adoption Framework enterprise-scale landing zone, the scope of a landing zone grows considerably to support application migrations and green-field development at an enterprise scale in Azure. This expansion allows for design that can scale across the customer's full IT portfolio, which looks well beyond a short-term cloud adoption plan.

- **Refactoring:** The number of subscriptions required to support a full enterprise-scale IT portfolio can be large. At first, the Cloud Adoption Framework encourages a high frequency of refactoring, which should stabilize before the tenth production workload is deployed to the cloud. When you work across an enterprise portfolio, 10 applications can be deployed quickly and make refactoring impractical. Instead, a central IT team or a cloud center of excellence should deliver a more complete landing zone during the first release.

- **Goal:** Provide consistent landing zones based on an application archetype subscription strategy to minimize subscription sprawl. Expand the definition of requisite components to better fit the governance and compliance needs of a cloud-mature enterprise. For an overview, see Figure 1.

- **Principal purpose:** Limited refactoring opportunities and a defined subscription strategy create an opportunity to mature the customer's landing zones faster. The Cloud Adoption Framework enterprise-scale landing zone broadens the principle purpose of the landing zone to focus on aspects of governance, compliance, security, and operational management. Each of these areas is addressed in the first release of the landing zone and supporting shared services.

An example is how city utilities such as water, gas, and electricity are accessible before new homes are constructed. In this context, the network, identity and access management, policies, management, and monitoring are shared utility services that must be readily available to help streamline the application migration process before it begins.

![Diagram that shows a landing zone design.](./media/lz-design.png)

_Figure 1: Landing zone design._

## Expanded list of requisite components

The following list expands on the landing zone illustration. It outlines the core technical constructs that must be designed and developed within the context of customer requirements to create compliant technical landing zone environments and the conditions for successful Azure adoption.

- **Identity and access management:** Azure Active Directory design and integration must be built to ensure both server and user authentication. Resource-based access control (RBAC) must be modeled and deployed to enforce separation of duties and the required entitlements for platform operation and management. Key management must be designed and deployed to ensure secure access to resources and support operations such as rotation and recovery. Ultimately, access roles are assigned to application owners at the control and data planes to create and manage resources autonomously.

- **Policy management:** Holistic and landing-zone-specific policies must be identified, described, built, and deployed onto the target Azure platform to ensure corporate, regulatory, and line-of-business controls are in place. Ultimately, policies should be used to guarantee the compliance of applications and underlying resources without any abstraction provisioning or administration capability.

- **Management and monitoring:** Platform-level holistic (horizontal) resource monitoring and alerting must be designed, deployed, and integrated. Operational tasks such as patching and backup must also be defined and streamlined. Security operations, monitoring, and logging must be designed and integrated with both resources on Azure and existing on-premises systems. All subscription activity logs that capture control plane operations across resources should be streamed into Log Analytics to make them available for query and analysis, subject to RBAC permissions.

- **Network topology and connectivity:** The end-to-end network topology must be built and deployed across Azure regions and on-premises environments to ensure north-south and east-west connectivity between platform deployments. Required services and resources such as firewalls and network virtual appliances must be identified, deployed, and configured throughout network security design to ensure that security requirements are fully met.

- **Shared services infrastructure:** Centrally controlled but broadly deployed services such as domain controllers must be designed, configured, and built to help application teams consume and integrate with necessary and common services and resources. Not all traditional and shared on-premises services should be provided in the cloud. For example, file shares and hardware security modules should be considered as application-level resources that use native Azure services.

- **DevOps:** An end-to-end DevOps experience with robust software development lifecycle practices must be designed, built, and deployed to ensure a safe, repeatable, and consistent delivery of infrastructure-as-code artifacts. Such artifacts are to be developed, tested, and deployed by using dedicated integration, release, and deployment pipelines with strong source control and traceability.

In addition to the key aspects denoted here, the design, configuration, deployment, and integration of each landing zone should meet your organization's critical requirements relating to:

- Business continuity and disaster recovery at platform and application levels.
- Service management, such as incident response and support.
- A service catalog (for example, a configuration management database).

## High-level architecture

[![Diagram that shows Cloud Adoption Framework enterprise-scale landing zone architecture.](./media/ns-arch-inline.png)](./media/ns-arch-expanded.png#lightbox)

The above diagram is an example of the enterprise-scale design principles and guidelines for an organizations Azure landing zone. Below is a key that further illustrates a compliant Azure architecure anding zone environment.

A. Enterprise enrollment alignement of all your subscriptions and affects administration of your digital estate.

B. Identity and access management enables access based on identity authentication and authorization controls in cloud services to protect data and resources and to decide which requests should be permitted.

C. Management group and subscription organization mapping that must be considered thoroughly when an organization plans Azure adoption at scale.

D. Management Subscription operationalizes the Azure enterprise estate with centralized management and monitoring at a platform level. 

E. Connectivity Subscription operationalizes the supporting networking and connectivity to, from, and within Microsoft Azure.

F. Landing zone subscription enable application migrations and greenfield development at an enterprise scale in Azure.

G. Sandbox subscription operationalize Azure learning and expermentation this allows users to immediately experiment with Azure.

H. Devops proven approach for both application and central teams to create pipelines continuous integration and continuous deployment.


_Figure 2: Cloud Adoption Framework enterprise-scale landing zone architecture._

Download the [PDF file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/enterprise-scale-architecture.pdf) that contains this architecture diagram.

## Next steps

Customize implementation of this architecture by using the Cloud Adoption Framework enterprise-scale design guidelines.

> [!div class="nextstepaction"]
> [Design guidelines](./design-guidelines.md)
