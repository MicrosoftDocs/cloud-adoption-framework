---
title: Change communication
description: Use the Cloud Adoption Framework for Azure to learn how a change communication plan can help you communicate cloud migration outcomes.
author: Zimmergren
ms.author: tozimmergren
ms.date: 04/10/2024
ms.topic: conceptual
---

# Change communication

Change communication means communicating your upcoming changes to the business. This communication ensures that the activities during the cloud migration are well understood by everyone affected by the transition.

You can have a consistent _change communication plan_, but each workload should undergo its own _change communication_ because it has its own users and operators.

The change communication is in addition to any change requests that need to be captured by your change management team. You should work with your change management team to ensure the change is properly managed from their side; that team might also be able to help with the change communication.

## Audience for change communication

Your change communication needs to target various individuals in your organization. You should have a clear plan for each of the following roles:

- **Business users** who use the workload in question to complete activities.
- **Change managers** who need to plan for risk management and who must ensure that the cutover follows all necessary requirements.
- **Owners and operators** of the assets moving to Azure.
- **Developers** who deploy to the assets moving to Azure.
- **Migration engineers** who are executing the migration itself.

> [!NOTE]
> Your organization might also have other necessary roles that are necessary to include.

## Change communication content

In your change communication, you want to make it clear to each role what the change means to them, and what do they need to do to be ready to it. Even if no action is required from a specific group, you should call that out so that they aren't left wondering.

To do this, answer the following in your change communication:

- **Critical dates**: What are the critical dates for the migration?
- **Impact**: Whose work is disrupted, when, and for how long?
- **Steps to completion**: What work is expected to be completed by each role to be ready?
- **Post-change steps**: What work will be needed to be completed after the change in order to confirm functionality?
- **Get support or learn more**: Who should individuals reach out to if they have questions or challenges?

Due to the number of roles involved, you might need to send out different change notifications to different audiences. There might be a broad communication that targets a general audience that explains the time frame and expected outages a more specific communication for IT resources to plan for operational actions.

## Example change communication content

You can use the below template to draft your change communication:

|What to communicate|Details|
|---|---|
|**What is changing?**|Application X is migrating to Azure!|
|**When is this change happening?**|February 29, 2024, at 10 PM PST|
|**Who will this change impact?**|Business users of Application X, and those who use systems that pull information from Application X.|
|**How will they be impacted?**|Application X won't be available for new work until systems are restored on March 1, 2024, at 2 AM PST.|
|**What do I need to do?**|Make sure your work in application X is saved prior to the change. On March 1, resume normal functions and reach out if you encounter problems.|
|**Who should I reach out to?**|Contact {email} for more information or for questions. If you have problems after the change, contact Contoso Helpdesk for assistance. Mention Application X in the subject line.|

## Next steps

After business change is documented and planned, business testing, also known as User Acceptance Testing (UAT), can begin.

> [!div class="nextstepaction"]
> [Business testing](./business-test.md)
