---
title: Build a digital transformation timeline
description: Use the Cloud Adoption Framework to consider the impact of time on your digital transformation objectives.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Build a digital transformation timeline

Digital transformation and cloud adoption might seem like technical project. But at their core, both are complex change management efforts involving multiple stakeholders moving in alignment to accomplish business and technical change. When they move in unison, the impact on the business is apparent.

## Competing objectives

If you've been building out the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) for your organization, some trends have likely begun to emerge:

- Competing motivations: Your organization is likely motivated by needs that span several of the [motivation categories](./motivations.md): Migration motivations, innovation motivations, and critical business events. Each of these categories requires slightly different behaviors during technical implementation and business adoption.
- Competing business outcomes: Your organization is also likely to see competing [business outcomes](business-outcomes/index.md). It's possible to improve customer engagements in the cloud. You could also use the cloud to achieve cost reduction outcomes. But the behaviors required to do each are different, making it difficult to succeed at both in parallel.
- Aligning financial and technical considerations: If motivations and outcomes aren't aligned, it's easy to have misaligned conceptions when evaluating key considerations. This can lead to difficulty executing your strategy or at minimum communicating success.

It's possible to achieve conflicting motivations and competing outcomes. However, your successes will be greater if you prioritize your transformation and develop a timeline that focuses on the most important objectives first.

## Constrained staff

Change management of any type places a strain on existing staff. Cloud adoption is no different. Even if the financial and technical considerations look good on paper, competing or parallel outcomes will intensify the strains of change management.

Even with adequate staffing, or ample budget for implementation partners, staffing constraints are a notable risk when outcomes are expected in parallel. There's typically some overlooked shared dependency, which becomes a blocker for one or more projects. Usually, those overlooked dependencies follow Murphy's law and become an issue when they are on the critical path for multiple projects.

If you must deliver parallel outcomes, scrutinize your staffing plans and critical path for any potential shared dependencies before you commit to the strategy.

## De-risk with cloud adoption horizons

It's common for organizations to have competing motivations. But competing motivations create a divide in the financial investments that the company can make in any one objective. Such a divide leads to an overall reduction in the amount of change or transformation that any effort can deliver.

Stratification is a sound principle in macroeconomics. But with the limited budget of most technology-driven change management projects, a stratified approach leads to confusing and distracting signals within the program. More noticeably, multiple, simultaneous investments in competing strategies lead to misalignment of the people, processes, and projects that are required for overall program success. For digital transformation to succeed, organizations must prioritize motivations based on timeline expectations, organizational alignment, and capacity for investment.

To create clarity and alignment, it's suggested that complex digital transformation projects align to an organization's horizons or phased program delivery. In this type of approach, the company commits to a single motivation category for a time-bound period. All teams and organizations prioritize investments and collaborate to support the priority outcome, as needed, for the defined period of time. This approach creates unity, clarity, and drives a snowball effect, allowing the success of one horizon to accelerate the target outcomes of the next horizon.

In this model, the full program team can overcome skills gaps, together. Support one another in achieving small but critical milestones, together. Deliver on those outcomes more quickly, then move on to the next horizon together. In the end, a supportive team-based approach with loosely defined and agile horizons will progress faster than the same teams competing with one another for limited resources.

## Example of a cloud adoption plan with four horizons

In this example, a customer has a high number of motivations that appear in each category of the motivations table. Diverse motivations suggest that the organization has multiple critical business events to address, a need for operational improvements from a migration or modernization, and innovation opportunities:

- **Datacenter exit:** They're delivering on a datacenter exit requiring significant focus from the central IT and cloud adoption teams. The 12- to 18-month time frame to fully plan two datacenter replacements is aggressive but realistic, if there are few distractions.
- **Operational improvements:** Accelerating innovation requires modernizing existing operational systems. It also requires modernizing processes that are dedicated to current production environments.
- **Innovation expansion:** The long-term objective is to continue to grow and lead the market through innovation. The ultimate goal is to maximize the amount of effort IT invests in innovation overall and reduce existing operational investments.

This reference customer developed horizons aligned to the following target schedule, to be evaluated and updated as part of quarterly release plan:

|Horizon  |Objective  |Time frame  |Considerations  |
|---------|---------|---------|---------|
|1. Migration and modernization|Prioritize the datacenter exit with a focus on modern platform as a service (PaaS) solutions over a basic lift-and-shift migration.|Months 0 - 18|The migration as priority should minimize conflicts with existing innovation commitments.|
|2. Operation modernization|Prioritize operational improvements built on cloud-native governance, operations management, security, and compliance capabilities.|Months 6 - 18|This effort complements and supports the primary migration effort.|
|3. Advanced modernization|With post-migration and operational improvements, the team will have sufficient data and cloud skills to perform deeper modernization of complex architectures.|Months 18-24|         |
|4. Innovation and growth|Redirect capital reduction from datacenter exits and new skills in central IT to focus on accelerating continued innovation.|Month 24+|All prior horizons will produce a long list of new innovations as the central IT and cloud adoption teams create tighter collaborations and build out automation assets.|

## Next steps

Developing a similar set of cloud horizons can help refine your technical and financial considerations. This approach could also make it easier to share your priorities and objectives with stakeholders and technical staff to ensure their efforts align with the desired outcomes.
With defined cloud adoption horizons and updated considerations, you're now ready to [create a business case](./cloud-migration-business-case.md).

> [!div class="nextstepaction"]
> [Create a business case](./cloud-migration-business-case.md)