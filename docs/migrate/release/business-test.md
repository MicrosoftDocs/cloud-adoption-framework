---
title: Business testing guidance during migration
description: Learn how business testing, or User Acceptance Testing (UAT) is used to solicit validation that solution performance is in line with expectations and doesn't impede business processes.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/21/2024
ms.topic: conceptual
---

# Guidance for business testing (UAT) during migration

While the migration team facilitates the migration of a workload to Azure, testing of a workload is best executed by the business users of that workload. The migration team supports this business activity by facilitating the testing, developing testing plans, and automating tests when possible. There's no replacement for firsthand observation of real users attempting to take advantage of a new solution in the context of a real or replicated business process.

> [!NOTE]
> When available, automated testing is a much more effective and efficient means of testing any system. However, cloud migrations often focus most heavily on legacy systems or at least stable production systems. Often, those systems aren't managed by thorough and well-maintained automated tests. This article assumes that no such tests are available at the time of migration.

Second to automated testing is testing of the process and technology changes by power users. Power users are the people that commonly execute a real-world process that requires interactions with a technology tool or set of tools. They could be represented by an external customer using an e-commerce site to acquire goods or services. Power users could also be represented by a group of employees executing a business process, such as a call center servicing customers and recording their experiences.

The goal of business testing is to solicit validation from power users to certify that the new solution performs in line with expectations and doesn't impede business processes. If that goal isn't met, the business testing serves as a feedback loop that can help define why and how the workload isn't meeting expectations.

## Business activities during business testing

During business testing, the first iteration is manually driven directly with customers. This is the purest but most time-consuming form of feedback loop.

- **Identify power users**: The business generally has a better understanding of the power users who are most affected by a technical change.
- **Align and prepare power users**: Ensure that power users understand the business objectives, desired outcomes, and expected changes to business processes. Prepare them and their management structure for the testing process.
- **Engage in feedback loop interpretation**: Help the IT staff understand the impact of various points of feedback from power users.
- **Clarify process change**: When transformation could trigger a change to business processes, communicate the change and any downstream impacts.
- **Prioritize feedback**: Help the IT team prioritize feedback based on the business impact.

At times, IT might employ analysts or product owners who can serve as proxies for the itemized business testing activities. However, business participation is highly encouraged and is likely to produce favorable business outcomes.

## Migration team activities during business testing

The migration team serves as one of the recipients of the business testing output. The feedback loops exposed during business testing eventually become work items that define technical change or process change. As a recipient, the migration team is expected to aid in facilitation, collection of feedback, and management of resultant technical actions. The typical activities the migration team performs during business testing include:

- Provide structure and logistics for business testing. After working with power users, you can create a spreadsheet defining the tests needed to be run with places for testers to add their notes.
- Aid in facilitation during testing.
- Provide a means and process for recording feedback. Using Azure DevOps or an Excel spreadsheet to capture information is an effective way to record items to address.
- Help the business prioritize and validate feedback.
- Develop plans for acting on technical changes.
- Identify existing automated tests that could streamline the testing by power users.
- For changes that could require repeated deployment or testing, study testing processes, define benchmarks, and create automation to further streamline power user testing.

### Example testing plan

You can use the following as a reference to build your testing plan:

|Test|Steps|Succeeded?|Tester notes|
|---|---|---|---|
|Sign in|Sign in using your normal credentials. Confirm that you see the same information as the production system.|Yes|No remarks|
|Create new record|Create a new record in the system, and confirm that all workflow jobs run appropriately.|Yes|No remarks|
|Read created record|Reopen the record you created, and confirm that all materials are filled in.|Yes|No remarks|
|Update created record|Make changes to the record you created, and confirm that the update proceeds accurately.|Yes|No remarks|
|Delete created record|Delete the record you created, and confirm that the record is removed from the system.|Yes|No remarks|
|Read existing record|Open one of the existing test records, that start with "Test-Record-Azure-Test" and confirm you can read all materials.|Yes|No remarks|
|Update existing record|Update the test record you used in the previous step, and confirm that the update proceeds accurately.|No|Update failed with error message: "Unable to access transaction database." |
|Delete existing record|Delete the test record that you used in the previous step.|No|Update failed with error message: "Unable to access transaction database." |

## Next steps

> [!div class="nextstepaction"]
> [Promotion models](./promotion-models.md)
