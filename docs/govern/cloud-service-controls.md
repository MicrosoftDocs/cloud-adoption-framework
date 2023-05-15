---
title: Cloud service review process
description: Learn about the process for implementing governing rules and standards into the cloud on individual services.
author: phduf
ms.author: martinek
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: think-tank, UpdateFrequency2
---

# Implement cloud service controls

Your organization might find it difficult to implement cloud governance at a pace that sustains a high level of innovation and achieves the right level of control for the environment.

The following process outlines a possible governance implementation, which allows for a controlled and measured implementation. This process is non-disruptive no matter where your organization is in their cloud journey.

## Layers of governance

Determine the controls and measures that you want to implement as part of your organization's governance process as outlined in [Define corporate cloud policy](./policy-compliance/policy-definition.md).

![Diagram that shows the service review process.](../_images/govern/cloud-policy-breakdown.png)

When you implement an organizational cloud policy, it stretches across many layers of the implementation process. These layers include platform-wide controls, individual service controls, and application controls. The higher the level of control, the more coverage it gets. The more complex the implementation is, the easier it is to ensure that the cloud policy covers all of the cloud adoption team's needs.

| Control level | Suitability                                  | Considerations                                                                                                                                                               | Examples                            |
| ------------- | -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| Platform      | Broad coverage             | Hard to implement service-specific management or remediation. Ensure that the application implementation doesn't negate the desired outcome.                               | Resource tagging or allowed regions |
| Cloud service | Tailored for individual services             | Control must be implemented individually for each service. Ensure that the application implementation doesn't negate the desired outcome.                               | Data encryption or monitoring       |
| Adoption team | Tailored for each application implementation | Control must be implemented for each new application. Hard to standardize implementation. Multiple teams have to implement different controls for the desired outcome. | Application failover logic          |

Cloud services have the strongest and most complex level of control. They provide technical implementation with fine control of each service and allow multiple adoption teams to use single implementations. The process of implementing controls at the cloud service layer requires a level of scale to ensure all services that your organization needs are covered.

## Levels of service governance

This level of implementation can be delivered in several layers. The governance team can assess the level of implementation they want based on the risk profile, compliance requirements, security posture, and other factors.

| Service governance      | Outline                                                                    | Adoption team responsibilities                                                                                                   | Governance team responsibilities                                    |
| ----------------------- | -------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| None                    | Services aren't centrally governed.                                           | The cloud adoption teams must build corporate policy into the end solution.                                                             | Identify and implement platform-wide controls.                       |
| Basic (allowlist and blocklist) | Services are allowed or blocked with no other controls.                 | The application teams build corporate policy into the end solution. Only services that the governance team approves are used. | Review and approve the use of services.         |
| Service review process  | Services are individually reviewed and controls are placed around each service. | The application teams should build with confidence. Only the services that have been through a service review are available.                    | Complete service governance and implement controls for each service. |

These different approaches are the extreme ends of the spectrum. Many organizations choose an approach between these models. For example, most organizations allow some cloud services with a few controls, some are allowed without controls, and access to others are denied.

Whatever the approach to service governance, the key input is the governance team's [corporate cloud policy statements](./policy-compliance/policy-definition.md#create-cloud-policy-statements).

## Basic governance

The most basic implementation of service governance is a permitted services list that lists the permitted or disallowed services in Azure.

In this form, the governance team publishes a list of the allowed and blocked services for the adoption teams.

### Create and review allowed services

To create an allowlist and blocklist of cloud services, review each cloud service against previously defined criteria, such as:

- Organization risk tolerance.
- Corporate policy.
- Capabilities of adoption, security, and operational teams.

### Implement blocklists

Services that are explicitly denied use in your organization should utilize [Azure Policy](/azure/governance/policy/tutorials/create-and-manage) to block the use of the service. Azure Policy is a platform level of control that a management group implements to ensure control over subordinate subscriptions.

The number of policies that are used to implement the block service is a balanced decision that must take into account the process for a policy exception.

There are often exceptions for the use of a service. After the exception is approved through the organizational process, [Azure Policy exemptions](/azure/governance/policy/concepts/exemption-structure) allow the implementation of the service in a targeted area.

If a single policy is implemented with all the denied services listed, then granting an exception for the single service also grants an exception to the denied services. Upfront implementation is simpler but releases more control with exceptions.

If policies are implemented to block each service individually, exceptions only release control of that one policy. This implementation allows for more control in the exception process but creates greater work in the implementation of the initial block policy set.

Your organization should balance the outcome of these two processes when you decide on your approach.

## Service review process

When you implement cloud policy at the service level, it allows for greater control and granular solutions but requires more effort. This type of implementation requires a strong process to get the best result.

This example is a four step process.

[![Infographic of the service review process.](../_images/govern/service-review-process.png)](../_images/govern/service-review-process.png#lightbox)

Triggers for a service review process are:

- A project need for a new service.
- The scheduled review of an existing service.
- A major cloud release of features in a service.
- A change in imperatives, which triggers all services that are in need of review.

The need for a service review puts the service in the backlog for the review process.

The schedule for the service review backlog is published for the adoption and operations teams. This schedule allows them to plan for their use of the service or any possible remediation work required because of changes.

The next part of the process contains steps that are iterative for each of the cloud services that are used. This part is continual for much of the cloud governance team. The core of this process takes the imperatives that have been defined and interprets them into controls for each service.

To select a service for review, base your decision on components such as:

- The internal demand for the service complexity of the implementation.
- The review timing of the last review of the service.
- The high-level risk value of the service.

This process publishes a backlog of items and a schedule of new reviews. Outside cloud adoption teams can then understand when services are going to be selected for review and how long they might wait for a new service. Cloud adoption teams can select services that are already under the controls of the environment.

### Define service use and controls

Review the capabilities of an individual cloud service and then determine what service-specific controls and guidance should be applied.

The primary inputs are the technical documentation of the cloud service and the service control requirements.

Through this process, the team reviews the intended use of the service within the organization and documents any implementation-specific designs that are required. The designs might include different controls for different classifications of data or simple guidance for general use.

The core artifact delivered from this stage is the service guidance. This document outlines the envisioned usage of the service, the guiding design principles, and the audited and enforced controls on the service. It acts as a reference for cloud adoption teams when they choose to implement a service as part of their design. The documents are necessary for the governance team to communicate their intent to adoption teams at scale.

### Implement and test technical controls

The controls defined in the previous section are now implemented in cloud controls. The technical implementation must provide the right level of enforcement and reporting.

The controls of the service are interpreted into their technical implementation on the service. The controls are identified in their implementation of the Azure environment. For example, when you require encryption on a storage account, it requires that you set a property on the storage account, which becomes the technical requirement of that control.

There are many offerings in the market that provide this capability. Azure Policy is recommended because it's native to Azure. Azure Policy reports the current state versus the desired outcome and enforces the controls.

### Approve service controls

The governance team must approve the work that's done in the last two stages.

Because the governance team approves this stage, other teams can complete the previous two stages. This process is outlined in [Scale the review process within an organization](#scale-the-review-process-within-an-organization).

### Release service controls

The process for releasing changed controls for services that have an existing service guidance is different than releasing new service guidance.

When you modify existing service guidance, remember that there are adoption teams that use the current service guidance in their work. Large changes might break their current projects.

When you do incremental reviews of service guidance, you can look at how a service is being used to determine what effect new controls might create.

Release new controls in an audit mode. This type of release triggers the policy alerting engine to send notifications to the application owners about remediation that they must implement.

#### Service governance, release, and version control

The design imperatives must have a version and release cycle, and they must tie back to the service guidance. The service guidance must have a version and release cycle, and it must tie back to the policy controls. The policy controls must have versions and must be released in manageable waves by using the following guidelines:

- All of these steps should happen with release cycles.
- Services must be available on a set date.
- Policy controls must be advertised on a release cycle.

## Artifacts generated

[![Diagram that shows the artifacts generated.](../_images/govern/artifacts-process.png)](../_images/govern/artifacts-process.png#lightbox)

There are four key artifacts developed throughout this process.

- The **service control requirements** are the outline of the key controls that are required across all services. This document is published before the reference documentation for cloud adoption teams. This positioning ensures that they review and understand the controls that are being built into the systems. This document must be available so that others can help the development of a service review. This process is outlined in [Scale the review process within an organization](#scale-the-review-process-within-an-organization).

- The **service review schedule** is a document that outlines when the services are reviewed, how long the expected wait for a review is, and when a new service becomes available for adoption teams. It also notifies the adoption team when existing services might change and therefore need more implementation of controls.

- **Service guidance** is a per service document that outlines the key components around a service, such as:

  - When the service is used.
  - Restrictions on what the service is used for.
  - A list of controls that the platform enforces.
  - A list of controls that the developer implements.

  Cloud adoption teams refer to these documents for services that they can pick up and use. They plan the implementation of their project around the controls and components. The service guidance also lists Azure policies and supporting functions that are implemented. This guidance ensures that a reference is enforced between the policy and service controls.

- **Azure policies and supporting functions** are the components or technical implementation of the controls that go into the platform. This code is version-controlled and deployed. These code items must act in enforcing the policy and include the code for reporting compliance of the policy.

### Start with a baseline

When organizations start this process, they usually have an existing Azure footprint. To ensure the least disruptive implementation of service governance, it's best to baseline off the current implementation and then start service reviews. This method avoids stifling innovation or blocking new projects while the governance team is starting.

1. Create a service guidance for every service that's used in your organization with the current service controls.

   For example, if key vaults are used and there are no controls enforced on them, create a service guidance for `A key vault with no controls`. If storage accounts are in use and a policy enforces encryption, create the storage account guidance with the control that encryption will be enforced.

2. Trigger a service review for all services that are in use, which adds them to the service review schedule.

3. Start a rollout of the new or changed controls in line with the service review policy, which gives product teams time to remediate their services.

In this stage, as the baseline, all services in production use are approved with their current policy controls.

The process is ready to start working with the service guidance as if it were going through a normal review.

For example, if your organization deploys virtual machines (VM) to production today, and the only policy governing that is tagging, then the MVP for the VM service guidance only documents the control around tagging.

If more controls need to be enforced for virtual machines, a new version of the service guidance is written. The new controls are implemented and go through the release cycle for the new service guidance version.

### Differences from the initial review

A main component of the service review process is to prevent services that don't have a current published service guidance from being deployed into the environment. It prevents the deployment of services that haven't had a risk assessment performed against the current cloud policy.

A staged approach that allows service use in different environments gives adoption teams earlier access to controls and reduces the exposure of services without controls.

There are several stages that ensure adoption teams aren't blocked during the creation of new service guidance. The process accelerates their ability to start using services. The first stage (`Sandbox`) is for the adoption team to nominate the new service that they need for a service review.

![Diagram that shows a new service control lifecycle.](../_images/govern/new-service-control-lifecycle.png)

Adoption teams can use the service in a disconnected [sandbox environment](/azure/cloud-adoption-framework/ready/considerations/sandbox-environments.md). The sandbox lets the adoption team start working with the service and prototype solutions. The sandbox environment doesn't have any policy controls for the service. A review hasn't been done, so generic compensating controls should be enforced on the environment. These compensating controls might include:

- Agreement from the adoption team to try to work within the cloud policy.
- Agreement to not store any company data in the sandbox environment.
- Limited network connectivity to the corporate environment.
- Limited connectivity to outside services.

After a draft version of the service review is done, the service is provisionally approved for use in a development and test environment. At this point, the code for the controls might not be complete, but basic guidance about how the service is deployed has been written. The developers can start to work in the dev/test environment with the understanding that the service might require reworking later. For example, if new controls are added as part of the final implementation of the production controls, some rework might be needed.

To release service controls, and to authorize application teams to deploy the service into the production environment, complete the following tasks:

- Service guidance is completed.
- Policy controls are code complete and tested.
- Approval of service controls is complete.
- Policy controls are released to production.

Now the adoption team can deploy the final production controls with confidence.

After deployment, migrate the production controls back to the development and test environment. This migration might cause rework for the development environment but ensures that the full controls are in place.

### Scale the review process within an organization

The combination of the scale of the cloud services and the depth of the service review process often creates a large work effort. To avoid this backlog of work being the sole responsibility of the governance team, you can scale through the adoption teams to complete the work. The governance team retains control and approval in this process. **Final approval of content stays with the governance team**.

Changes often happen with the cloud, or your organization, that make it difficult to keep controls current. To help with this issue, enable people outside the cloud governance team to implement parts of the work.

When you implement a clear set of service control requirements, it allows other teams to work on the first two stages of the process for a service. They can contribute a large amount of content.

The cloud has many services. The cloud governance team can prepare a backlog for all of these services to go through a service review, but they can't keep pace with the demands of a large organization. Services in the cloud change at a continuing rate, which places more demand on the need for a service review of the previously defined services. Projects might require new types of services quickly that they were unable to predict the demand for. Their immediate demand shouldn't become a problem for the cloud governance team. The cloud adoption team that needs the service must address that demand.

If the service control requirements are written clearly, teams outside the governance team can complete the first two steps of the service review process.

With the approval and release steps still controlled by the governance team, organizations can scale the service review process and keep centralized control.

For example, a cloud adoption team might need a new service that hasn't been through a review. To get the service review completed more quickly, they can use the documentation in the imperatives to identify and produce the controls. This method moves them all the way through the technical implementation and policy code for the cloud governance team. The cloud adoption team then gets quicker access to the service and can be interpreted as a *first user pays* scenario for the implementation of new services.

## Next steps

Learn more about regulatory compliance in the cloud.

> [!div class="nextstepaction"]
> [Regulatory compliance](./policy-compliance/regulatory-compliance.md)
