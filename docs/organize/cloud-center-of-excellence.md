---
title: Cloud center of excellence (CCoE) functions
description: Understand the functions of a cloud center of excellence (CCoE), including the source, scope, and deliverables.
author: Zimmergren
ms.author: pnp
ms.date: 09/19/2022
ms.topic: conceptual
ms.custom: internal, UpdateFrequency3
---

# Cloud center of excellence (CCoE) functions

Many IT organizations share the core objective of achieving business and technical agility. A cloud center of excellence (CCoE) is a function that helps organizations balance speed and stability while they pursue this objective.

## Function structure

A CCoE model requires collaboration between each of the following resources:

- Cloud adoption (solution architects)
- Cloud strategy (the program and project managers)
- Cloud governance
- Cloud platform
- Cloud automation

## Effects

When this function is properly structured and supported, the participants can accelerate innovation and migration efforts while reducing the overall cost of change and increasing business agility. When successfully implemented, this function can produce noticeable reductions in time to market. As team practices mature, quality indicators improve, including reliability, performance efficiency, security, maintainability, and customer satisfaction. These gains in efficiency, agility, and quality are especially vital if the company plans to implement large-scale cloud migration efforts or wants to use the cloud to drive innovations that are associated with market differentiation.

When successful, a CCoE model creates a significant shift in IT. In a CCoE approach, IT serves as a broker, partner, or representative to the business. This model is a paradigm shift away from the traditional view of IT as an operations unit or abstraction layer between the business and IT assets.

The following image provides an analogy for this change. Without a CCoE approach, IT tends to focus on providing control and central responsibility, acting like the stoplights at an intersection. When the CCoE is successful, IT's role resembles a roundabout at an intersection where the focus is on freedom and delegated responsibility.

![Diagram that shows an analogy for a C C o E paradigm shift.](../_images/ready/ccoe-paradigm-shift.png)

Both approaches are valid; they're alternative views of responsibility and management. A CCoE model can fit within the technology strategy if you want to establish a self-service model that allows business units to make their own decisions while adhering to a set of guidelines and established, repeatable controls.

## Key responsibilities

The primary duty of the CCoE team is to accelerate cloud adoption through cloud-native or hybrid solutions.

The objective of the CCoE is to:

- Help build a modern IT organization by using agile approaches to capture and implement business requirements.
- Use reusable deployment packages that align with security, compliance, and management policies.
- Maintain a functional Azure platform in alignment with operational procedures.
- Review and approve the use of cloud-native tools.
- Standardize and automate commonly needed platform components and solutions over time.

## Meeting cadence

It's important to allow for organic collaboration and to track growth through a common repository or solution catalog. Maximize natural interactions, but minimize meetings. Recurring meetings, such as release meetings that are hosted by the cloud adoption team, can provide data inputs. However, after this function matures, try to limit dedicated meetings. Hosting a meeting after each release plan is shared can provide a minimum touch point for this team.

## Solutions and controls

Each member of the CCoE needs to understand the necessary constraints, risks, and protections that led to the current set of IT controls. The CCoE turns that understanding into cloud-native (or hybrid) solutions or controls, which enable self-service business outcomes. As solutions are created, they're shared with other teams in the form of controls or automated processes that serve as guardrails for various efforts. Those guardrails help to guide team activities and to delegate responsibilities to the participants in migration or innovation efforts.

The following table describes some examples of this transition.

| Scenario | Pre-CCoE solution | Post-CCoE solution |
|---------|---------|---------|
| Provision a SQL Server instance in production | Network, IT, and data platform teams provision components over the course of days or weeks. | The team that requires the server deploys a platform as a service (PaaS) instance of Azure SQL Database. Alternatively, deployment can use a preapproved template for all of the infrastructure as a service (IaaS) assets to the cloud in hours. |
| Provision a development environment | Network, IT, development, and DevOps teams agree on specifications and deploy an environment. | The development team defines their own specifications and deploys an environment based on allocated budget. |
| Update security requirements to improve data protection | Networking, IT, and security teams update networking devices and virtual machines (VMs) across several environments to add protections. | Cloud governance tools are used to update policies that can be applied immediately to all assets in all cloud environments. |

## Negotiations

An ongoing negotiation process is at the root of CCoE efforts. A CCoE team negotiates with existing IT functions to reduce central control. The trade-offs for the business in this negotiation are freedom, agility, and speed, and the value of the trade-off for existing IT teams is delivered as new solutions. New solutions provide the existing IT team with one or more of the following benefits:

- Ability to automate common issues
- Improvements in consistency with a reduction in day-to-day frustrations
- Opportunity to learn and deploy new technical solutions
- Reductions in high-severity incidents (requiring fewer quick fixes or late-night pager-duty responses)
- Ability to broaden their technical scope and address broader topics
- Participation in higher-level business solutions, addressing the effects of technology
- Reduction in menial maintenance tasks
- Increase in technology strategy and automation

In exchange for these benefits, the existing IT function might trade the following values:

- Sense of control from manual approval processes
- Sense of stability from change control
- Sense of job security from completion of necessary, repetitive tasks
- Sense of consistency from adherence to existing IT solution vendors

In healthy cloud-forward companies, this negotiation process is a dynamic conversation between peers and partnering IT teams. The technical details can be complex, but they're manageable when IT understands the objective and is supportive of the CCoE efforts. When IT is less than supportive, the following section on enabling CCoE success can help overcome frictions.

## Enable CCoE success

Before you proceed with this model, consider the company's tolerance for a growth mindset and IT's comfort level with releasing central responsibilities. As mentioned earlier, a CCoE exchanges control for agility and speed.

This type of change takes time, experimentation, and negotiation. There will be bumps and set backs during the process, but if the team stays diligent and isn't discouraged from experimentation, there's a high probability of success in improving agility, speed, and reliability. One of the biggest success factors is support from leadership and key stakeholders.

### Key stakeholders

IT leadership is the first and most obvious stakeholder. IT managers play an important part, but implementing this model requires the support of the CIO and other executive-level IT leaders.

Less obvious is the need for business stakeholders. Business agility and time to market are primary motivations for forming a CCoE. As such, the key stakeholders have a vested interest in these areas. Examples of business stakeholders include line-of-business leaders, finance executives, operations executives, and business product owners.

### Support from business stakeholders

Support from the business stakeholders can accelerate CCoE efforts. Much of the focus of CCoE efforts is centered around making long-term improvements to business agility and speed. Defining the effects of current operating models and the value of improvements is valuable as a guide and negotiation tool for the CCoE. We suggest establishing or clearly defining in documentation the following items for raising support for a CCoE:

- Expected business outcomes and goals.

- Current IT process pain points, such as speed, agility, stability, and cost challenges.

- Historical effects of those pain points, such as lost market share, competitor gains in features and functions, poor customer experiences, and budget increases.

- Business improvement opportunities that are blocked by the current pain points and operating models.

- Timelines and metrics that are related to those opportunities.

These data points aren't an attack on IT. Instead, they help the CCoE team to learn from the past, establish a realistic backlog, and plan for improvement.

### Ongoing support and engagement from stakeholders

CCoE teams can demonstrate quick returns in some areas, but the higher-level goals, like business agility and time to market, can take much longer. During maturation, there's a high risk of the CCoE team becoming discouraged or for members to be pulled to focus on other IT efforts.

During the first six to nine months of CCoE efforts, we recommend that business stakeholders meet monthly with IT leadership and the CCoE. There's little need for formal ceremony to these meetings. Simply reminding the CCoE members and their leadership of the importance of this program can go a long way toward CCoE success.

We also recommend that the business stakeholders stay informed of the progress and the blocking issues that the CCoE team  experiences. Their efforts might seem like technical minutiae, but business stakeholders need to understand the progress of the plan so that they can engage when the team loses steam or becomes distracted by other priorities.

### Support from IT stakeholders

Support from IT stakeholders should include the following activities:

- **Support the vision:** A successful CCoE effort requires a great deal of negotiation with existing IT team members.

  When done well, all of IT contributes to the solution and feels comfortable with the change. Occasionally, some members of the existing IT team might want to hold on to control mechanisms. When such situations occur, support for the CCoE by IT stakeholders is vital to the success of the CCoE. IT stakeholders need to encourage and reinforce the overall goals of the CCoE to resolve blocks to proper negotiation. On rare occasions, IT stakeholders might even need to step in and break up a deadlock or a tied vote to maintain the progress of the CCoE.

- **Maintain focus:** A CCoE can be a significant commitment for any resource-constrained IT team.

  Removing strong architects from short-term projects to focus on long-term gains can create difficulty for team members who aren't part of the CCoE. IT leadership and IT stakeholders need to stay focused on the goal of the CCoE. The support of IT leaders and IT stakeholders can deprioritize the disruptions of day-to-day operations in favor of CCoE duties.

- **Create a buffer:** The CCoE team experiments with new approaches.

  Some new approaches won't align well with existing operations or technical constraints. The CCoE team might experience pressure or recourse from other teams when experiments fail. It's important to encourage and buffer the CCoE team from the consequences of "fast fail" learning opportunities. It's equally important to hold the team accountable to a growth mindset to ensure that they learn from those experiments and find better solutions.

## Next steps

A CCoE model requires cloud platform functions and cloud automation functions. The next step is to align cloud platform functions.

> [!div class="nextstepaction"]
> [Cloud platform functions](./cloud-platform.md)
