---
title: Change communication
description: Use the Cloud Adoption Framework for Azure to learn how change communication can help you communicate cloud migration outcomes.
author: Zimmergren
ms.author: pnp
ms.date: 04/10/2024
ms.topic: conceptual
---

# Change communication

Change communication means informing the business about your upcoming changes to ensure that everyone affected by the transition understands the cloud migration process.

Your communication plan can remain consistent, but each workload should undergo its own change communication because of its individual users and operators.

The change communication is in addition to any change requests captured by your change management team. You should work with your change management team to ensure that they properly manage the change. That team might also be able to help with the change communication.

## Audience for change communication

Your change communication needs to target various groups in your organization. You should have a clear plan for each of the following roles:

- **Business users** who use the workload in question to complete activities
- **Change managers** who need to plan for risk management and must ensure that the cutover follows all necessary requirements
- **Owners and operators** of the assets moving to Azure
- **Developers** who deploy to the assets moving to Azure
- **Migration engineers** who perform the migration

> [!NOTE]
> Your organization might also have other necessary roles to include.

## Change communication content

In your change communication, you should make it clear to each role how the upcoming change specifically affects them and what they must do to prepare. Your change communication should also include groups that work with related systems or in related business areas. Even if they don't have preparation steps and won't be directly affected by the change, they should be aware in case there are any indirect impacts to their work.

You should answer the following questions in your change communication:

- **Critical dates**: What are the critical dates for the migration?
- **Impact**: Whose work is disrupted, when, and for how long?
- **Steps to completion**: What work should each role complete before the change in order to be ready?
- **Post-change steps**: What work should each role complete after the change to confirm functionality?
- **Get support or learn more**: Who should individuals reach out to if they have questions or challenges?

Due to the number of roles involved, you might need to send out different change notifications to different audiences. There might be a broad communication for a general audience that explains the time frame and expected outages, and then a more specific communication for IT resources to plan for operational actions.

## Example change communication content

You can use the following template to draft your change communication:

|What to communicate|Details|
|---|---|
|**What is changing?**|Application X is migrating to Azure!|
|**When is this change happening?**|February 29, 2024, at 10 PM PST|
|**Who will this change affect?**|Business users of Application X and anyone who uses systems that pull information from Application X.|
|**How will they be affected?**|Application X won't be available for new work until systems are restored on March 1, 2024, at 2 AM PST.|
|**What do I need to do?**|Make sure your work in Application X is saved before the change. You can resume normal functions on March 1. Reach out if you encounter any problems.|
|**Who should I reach out to?**|Contact \<*email*\> for questions or more information before the change. If you encounter problems after the change, contact Contoso Helpdesk for assistance. Mention Application X in the subject line.|

## Next step

Business testing, or user acceptance testing (UAT), can begin after you document and plan the business change.
> [!div class="nextstepaction"]
> [Business testing](./business-test.md)
