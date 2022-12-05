---
title: 'Why update Azure Landing Zone environments'
description: Use the Cloud Adoption Framework for Azure to determine when to update your Azure Landing Zone implementation.
author: Jfaurskov
ms.author: Janfaurs
ms.date: 12/05/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---




# Why update Azure Landing Zone environments

Over time it will be necessary to update your Azure Landing Zone (ALZ) implementation in one way or another. Maybe there is new guidance regarding management group structure, maybe new technologies are included in Platform that you want to leverage or maybe ALZ custom policies and policy initiatives are superseded by Azure built-in policies or replaced by updated ALZ custom policies and policy initiatives.

Any of the following reasons could be relevant to your decision to update your ALZ implementation. 
1. Features may change so that a particular setting is no longer required or configurable.
2. Security issues with current settings has been identified and fixed
3. Policy does not function as intended
4. New features are added requiring new settings
5. Services become obsolete and are thus no longer required.

To determine if there are changes to ALZ that require you to take action, you should follow [What's New](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) on the ALZ repo on a regular basis. In addition to the information posted there, a list of deprecated services is posted [here](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Deprecated-Services) as well for historical purposes.

# Next steps
For details on how to update your ALZ implementation, please refer to the following sections.

- [Migrate ALZ custom policies to Azure built-in policies](./update-alz-policies.md)
- [Updating Azure Landing Zone custom policies to new versions](./update-alz-custom-policies.md)