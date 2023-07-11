---
title: Data application reference patterns
description: Learn about Data Application Reference Patterns for cloud-scale analytics
author: mboswell
ms.author: mboswell
ms.date: 02/28/2022
ms.topic: conceptual
s.custom: e2e-data-management, think-tank
---

# Data application reference patterns

When onboarding a data application onto a Data Landing Zone, the team will be granted access to their dedicated resource group, subnet and the shared resources. From this point in time, the ownership of the environment is handed over to the data application team respectively. These teams have to take over responsibility from an end-to-end implementation and cost ownership perspective.

To simplify the way to get started and reduce the lead time to create an environment for a specific use-case, organizations can provide reference patterns internally. These reference implementations consist of the Infrastructure as Code (IaC) definitions to successfully create a set of services for a specific use case such as batch data processing, streaming data processing or data science and demonstrate a path to success. Potentially, these patterns also include generic application code that can be used as a baseline when implementing data solutions. Data application reference patterns could vary between organizations and highly depend on the utilized tools and common and repeatedly used data implementation patterns across data landing Zones. Cloud-scale analytics also provides a set of curated data application reference designs that can be used as baseline and that can be further enhanced by enterprises depending on their requirements. These can be found here:

- [Data Application Batch](https://github.com/Azure/data-product-batch)
- [Data Application Streaming](https://github.com/Azure/data-product-streaming)
- [Data Application Analytics](https://github.com/Azure/data-product-analytics)

Other automation can be used to further reduce any potential friction points and automate even the initial deployment of the pattern for data application teams. For more details, please take a look at [Platform automation and DevOps for a cloud-scale analytics](../manage-platform-automation-devops.md).

Ultimately, the goal should be to hand over these reference implementations to the data application teams, as they should own the overall codebase of their solution. Extra abstraction layers such as Azure template specs are also an option, but just increase the number of friction points as required changes again need to be requested from a central team that owns and maintains these resources. The central team then needs to take an action to get the changes tested and released. Additionally, a more complex release management process could be required to not impact other consumers of the Template Spec. Lastly, the templates will become more complex over time as each team could require different parameters to be exposed to apply certain changes within the template. Hence, handing over the reference patterns is the easiest and most effective solution, since this allows the Data applications teams to make the necessary changes, if they need to. Exposing these teams to the concept of IaC is a good approach that could take some time but ultimately will result in better engineering practices across the data platform.

For more information, see [Scaling Cloud-scale analytics](scale-architectures.md).
