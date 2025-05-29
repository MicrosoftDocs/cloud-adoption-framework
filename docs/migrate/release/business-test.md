---
title: Perform business testing during a migration
description: Learn how business testing, or user acceptance testing (UAT), is used to validate that solution performance is in line with expectations.
author: Zimmergren
ms.author: pnp
ms.date: 04/10/2024
ms.topic: conceptual
---

# Perform business testing during a migration

While the migration team facilitates the migration of a workload to Azure, testing of a workload is best performed by the business users of that workload. The migration team supports this business activity by facilitating workload testing, developing testing plans, and automating tests when possible.

During business testing, or user acceptance testing (UAT), you observe real users attempting to use the new solution in the context of a real or replicated business process.

> [!NOTE]
> **Automated testing isn't always available**.
>
> Automated testing is an efficient way to test any system. However, cloud migrations often focus on legacy systems or stable production systems. These systems are seldom managed by thorough and well-maintained automated tests.
>
> This article assumes that automated tests are available at the time of migration.

The goal of business testing is to obtain validation from power users to certify that the new solution performs in line with expectations and doesn't impede business processes. If that goal isn't met, the business testing serves as a feedback loop that can help you define how and why the workload isn't meeting expectations.

## Business activities during business testing

During business testing, the first iteration is manually driven directly with customers. This is the purest and most time-consuming form of feedback loop.

- **Identify power users**: The business generally has a better understanding of the power users who are most affected by a technical change. Power users are the people who frequently perform a real-world process that requires interactions with a technology tool or set of tools, such as a call center that services customers.
- **Align and prepare power users**: Ensure that power users understand the business objectives, desired outcomes, and expected changes to business processes. Prepare power users and their management structure for the testing process.
- **Engage in feedback loop interpretation**: Help the IT staff understand the effects of various points of feedback from power users.
- **Clarify process change**: Communicate the process change and any downstream effects when transformation could trigger a change to business processes.
- **Prioritize feedback**: Help the IT team prioritize feedback based on the business impact.

## Migration team activities during business testing

The migration team is one of the recipients of the business testing output. The feedback loops exposed during business testing eventually become work items that define technical change or process change. As a recipient of the business testing output, the migration team is expected to aid in facilitation, feedback collection, and management of resultant technical actions.

Typical activities that the migration team performs during business testing include:

- **Provide structure and logistics**: After working with power users, you can create a spreadsheet with places for testers to add their notes that define the tests that need to be run.
- **Facilitation**: Aid in facilitation during testing.
- **Record feedback**: Provide a means and process for recording feedback. You can use Azure DevOps or an Excel spreadsheet to effectively capture information and record action items.
- **Prioritize feedback**: Help the business prioritize and validate feedback.
- **Plan for changes**: Develop plans for acting on technical changes.
- **Identify automated tests**: Identify existing automated tests that might streamline the testing by power users.
- **Process improvement**: Study testing processes, define benchmarks, and create automation to further streamline power user testing for changes that might require repeated deployment or testing.

### Example testing plan

You can use the following as a reference to build your testing plan:

|Test|Steps|Successful/unsuccessful|Tester notes|
|---|---|---|---|
|Sign in|Sign in using your normal credentials. Confirm that you see the same information as the production system.|&#x2705;|No remarks|
|Create new record|Create a new record in the system and confirm that all workflow jobs run appropriately.|&#x2705;|No remarks|
|Read created record|Reopen the record you created and confirm that all materials are filled in.|&#x2705;|No remarks|
|Update created record|Make changes to the record you created and confirm that the update proceeds accurately.|&#x2705;|No remarks|
|Delete created record|Delete the record you created and confirm that the record is removed from the system.|&#x2705;|No remarks|
|Read existing record|Open one of the existing test records that start with "Test-Record-Azure-Test" and confirm you can read all materials.|&#x2705;|No remarks|
|Update existing record|Update the test record that you used in the previous step and confirm that the update proceeds accurately.|&#x274C;|Update failed with error message: "Unable to access transaction database." |
|Delete existing record|Delete the test record that you used in the previous step.|&#x274C;|Update failed with error message: "Unable to access transaction database." |

## Next step

> [!div class="nextstepaction"]
> [Complete migration](./complete-migration.md)
