---
title: Change communication
description: Use the Cloud Adoption Framework for Azure how a change communication plan can help you communicate cloud migration outcomes.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/15/2024
ms.topic: conceptual
---

# Change communication

This section provides instructions for how to communicate your change to the business, so that the activities during the migration are well understood by all who will be impacted by the transition.

While you can have a consistent change communication plan for each workload you're migrating, each workload should undergo its own change communication due to having its own users and operators.

This is in addition to completing any change requests that need to be captured by your change management team. You should work with them to make sure the change is properly managed from their side; that team might also be able to help with the change communication.

## Audience for change communication

Your change communication needs to target various individuals in your organization. You should plan to make sure to have a clear plan for each of the following roles:

- Business users who use the workload in question to complete activities.
- Change managers who need to plan for risk management and who must make sure that the cutover follows all necessary requirements.
- Owners and operators of the assets moving to Azure.
- Developers who deploy to the assets moving to Azure.
- Migration engineers who are executing the migration itself.

Your organization might also have other roles that are necessary to include.

## Change communication content

In your change communication, you want to make it clear to each role what the change means to them, and what do they need to do to be ready to it. Even if no action is required from a specific group, call that out so that they aren't left wondering.

To do this, answer the following in your change communication:

- **Critical dates**: What are the critical dates for the migration?
- **Impact**: Whose work is disrupted, when, and for how long?
- **Steps to completion**: What work is expected to be completed by each role to be ready?
- **Post-change steps**: What work will be needed to be completed after the change, to confirm functionality?
- **Get support or learn more**: Who should individuals reach out to if they have questions or challenges?

Due to the number of roles involved, you might send out different change notifications to different audiences. There might be a broad communication targeting a general audience explaining the time frame and expected outages, and then a more specific communication for IT resources to plan for operational actions.

## Example change communication content

You can use the below template to draft your change communication:

|What to communicate|Details|
|---|---|
|**What is changing?**|Application X is migrating to Azure!|
|**When is this change happening?**|February 29, 2024, at 10 PM PST|
|**Who will this change impact?**|Business users of Application X, and those who use systems that pull information from Application X.|
|**How will they be impacted?**|Application X won't be available for new work until systems are restored on March 1, 2024, at 2 AM PST.|
|**What do I need to do?**|Make sure your work in application X is saved prior to the change. On March 1, resume normal functions and reach out if you encounter issues.|
|**Who should I reach out to?**|Contact {email} for more information or for questions. If you have issues after the change, contact Contoso Helpdesk for assistance. Mention Application X in the subject line.|

## Next steps

After business change is documented and planned, business testing, also known as User Acceptance Testing (UAT), can begin.

> [!div class="nextstepaction"]
> [Business testing](./business-test.md)
