---
title: Deploy Azure Landing Zones with terraform
description: Learn which of the two Terraform approaches is most suited to your scenario when deploying Azure landing zones.
author: mawhi
ms.author: mawhi
ms.date: 02/07/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Use Terraform to deploy Azure Landing Zones

Azure provides native services for building your enterprise-scale landing zones.
Other third-party tools can also help with this effort.
One such tool that customers and partners often use to deploy landing zones is [Terraform by HashiCorp][terraform].

The [Azure landing zones (ALZ) terraform module][alz-tf-mod] is a terraform module that provides a efficient way to deploy the platform resources from the [Azure landing zones conceptual architecture][alz-conceptual-arch].
The module deploys the management group hierarchy, policies and the resources in the connectivity and management subscriptions.
Deployment of resources to application landing zones in outside the scope of the accelerator, leaving decisions over the deployment toolchain to the team responsible for the application.

Optionally, customers can choose to deploy Azure landing zones using the CAF terraform landingzones framework.
This is a prescriptive implementation of terraform on Azure that makes use of the ALZ terraform module for management groups and policies, but goes further.
In addition to platform services it allows customers to deploy resources into application landing zones using terraform, as well as providing a mechanism to deploy subscriptions.

## Capabilities provided by the two approaches

The table below compares the two approaches for landing zones on Azure:

| Capability | ALZ terraform module | CAF terraform landingzones |
| - | - | - |
| Management groups and policies | ✅ | ✅ (using the module) |
| Platform connectivity resources | ✅ | ✅ |
| Platform management resources | ✅ | ✅ |
| Landing zone resources | ❌ | ✅ |
| Landing zone subscription vending machine | ❌ | ✅ |

## Selecting the right approach for terraform

If your organization has no current investment in terraform, the [CAF terraform landingzones][caf-terraform-landingzones] framework provides a prescriptive implementation of terraform on Azure that is open source and community driven.
If after consideration this approach is not to your liking, then the [ALZ terraform module][alz-tf-mod] should be used.

If your organization has an existing investment in terraform or would like to implement terraform in a way that does not follow that prescribed by [CAF terraform landingzones][caf-terraform-landingzones], then the [ALZ terraform module][alz-tf-mod] is the best option.

<!-- Common links -->

[terraform]: https://www.terraform.io/ "Terraform by HashiCorp"
[alz-tf-mod]: alz-terraform-module.md "Azure landing zones terraform module"
[alz-conceptual-arch]: ../landing-zone/index.md
[caf-terraform-landingzones]: ../landing-zone/caf-terraform-landingzones.md "CAF terraform landingzones"
