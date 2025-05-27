---
title: Data application reference patterns
description: Learn about Data application reference patterns for cloud-scale analytics
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data application reference patterns

When onboarding a data application onto a Data Landing Zone, the team will be granted access to their dedicated resource group, subnet, and shared resources. From this point, the ownership of the environment is handed over to the data application team. These teams have to take responsibility from an end-to-end implementation and cost ownership perspective.

To simplify the process of getting started and reduce the lead time to create an environment for a specific use case, organizations can provide internal reference patterns. These reference implementations consist of the Infrastructure as Code (IaC) definitions to successfully create a set of services for a specific use case, such as batch data processing, streaming data processing, or data science, and demonstrate a path to success. Potentially, these patterns also include generic application code that can be used as a baseline when implementing data solutions. Data application reference patterns could vary between organizations and highly depend on the utilized tools and commonly and repeatedly used data implementation patterns across Data Landing Zones.

Other automation can be used to further reduce any potential friction points and automate even the initial deployment of the pattern for data application teams. For more details, please take a look at [Platform automation and DevOps for a cloud-scale analytics](../manage-platform-automation-devops.md).

Ultimately, the goal should be to hand over these reference implementations to the data application teams, as they should own the overall codebase of their solution. Extra abstraction layers, such as Azure template specs, are also an option but just increase the number of friction points as required changes again need to be requested from a central team that owns and maintains these resources. The central team then needs to take action to get the changes tested and released. Additionally, a more complex release management process could be required to not impact other consumers of the Template Spec. Lastly, the templates will become more complex over time as each team could require different parameters to be exposed to apply certain changes within the template. Hence, handing over the reference patterns is the easiest and most effective solution, as this allows the data application teams to make the necessary changes if they need to. Exposing these teams to the concept of IaC is a good approach that could take some time but ultimately will result in better engineering practices across the data platform.

For more information, see [Scaling Cloud-scale analytics](scale-architectures.md).