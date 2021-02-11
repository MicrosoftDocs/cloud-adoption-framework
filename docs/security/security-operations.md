---
title: Security Operations
description: Best practice guidance for establishing a Security Operations function
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

## Background

With any IT function, detecting and responding to security incidents is a mission-critical objective.
Cloud technologies make capabilities available to help organisations implement strong security operations process at scale.
However, security tools are only as good as the processes that surround them, so it is crucial that organisations design and run a well-structured security operations function to keep the business safe.
A great set of principles for a well-structured security operations function is: Detect. Respond. Recover.

## Operations within a security strategy

### Security strategy connections

The Security Operations function should deliver on the requirements set out in the organisation's security strategy.
Risk priorities and responsibilities articulated in the strategy should be reflected in the day-to-day operations of the security operations.

Guidance as part of the Cloud Adoption Framework's Strategy methodology outlines how to define the organisation security strategy:

[Define a security strategy - Cloud Adoption Framework | Microsoft Docs](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/define-security-strategy)

### Managing a security program

Delivering security controls inside an organisation without business stakeholder engagement runs the risk of being seen as a blocker by those outside of the team.
Work with the business to establish a basis of understanding that security can be an enabler for innovation and growth, as opposed to a group that always says 'no'. Engaging in discussion with the business to agree how the security strategy can be delivered without compromising technical delivery or creativity.
The resulting set of controls are often referred to as 'guard rails' which are technical boundaries, defined by policy, that enable flexibility to a point but stops inadvertent increase in security risk or deviation from company policy.

The boundaries defined in the guard rails become the baseline from which the security operations team can find and investigate deviations. This may result in a defect or issue being identified that requires resolution or - equally - it could find a use case where the boundary needs reviewing and potentially revising in order to maintain the balance between business function and security control.

### Building a modern SOC

In a world of hyper-scale distributed compute, the ability to collate, analyse and respond to events and telemetry at scale is crucially important.
It is not economically or practically viable to scale the number of people in a security operations function in direct correlation to the number of workloads being managed. Technology must be used to scale the management to meet the demand.
In practical terms, scale requires centralisation of telemetry - bring all of the organisations security signals into a consolidated data set which then can be filtered, modelled and have business logic applied to it in order to find the events and activities that require intervention - be it automated or human.

Security Information and Event Management (SIEM) tools can help address this goal, with many of them designed to ingest telemetry from a wide range of sources - identity platforms, network monitors, applications, device management tools.

## Migrating to an 'assume breach' mindset

### Holistic monitoring

Every data point related to an environment helps build a better picture of the activities and anomalies - either by confirming a common behaviour or being an antipattern to it.
As a result, security operations teams should seek to ingest as many relevant data feeds as possible in order to develop the most articulate view of activities as possible. This will prove incredibly useful not only in spotting an anomalous event but also in triaging the event and determining the full set of activities to determine potential impact and scale.

### Proactive testing and recovery

Assume breach. Assume that the environment is already compromised and approach testing as if you were looking for an attacker.

### Recovering and re-securing

Even with the best processes and technologies in place, there will be bugs or incidents that require resolution. The impact of the incident is influenced by how teams respond and rectify the issue - and learn from it to ensure it cannot happen again.
