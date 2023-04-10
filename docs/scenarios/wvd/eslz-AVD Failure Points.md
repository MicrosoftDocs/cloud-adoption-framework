---
title: Azure Virtual Desktop Failure Points
description: Explore the dependencies of AVD and explain what happens when these dependencies fail
author: herms14
ms.author: hemirafl
ms.date: 04/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---


# Azure Virtual Desktop Failure Points


Azure Virtual Desktop (AVD) is a powerful solution that allows users to deploy and manage virtual desktops in the cloud. While AVD is undoubtedly robust and reliable, it's essential to understand the potential failure points in the system to ensure smooth operation and minimize downtime. In this article, we'll delve into various AVD dependencies and outline what happens when each of these dependencies fails. For more information on high availability  and BCDR for your Azure Virtual Desktop resources, see [Business continuity and disaster recovery for Azure Virtual Desktop - Cloud Adoption Framework | Microsoft Learn](eslz-business-continuity-and-disaster-recovery.md)

## Identity 

Identity is a critical component of any VDI solution, and Azure Virtual Desktop is no exception. Azure Virtual Desktop relies on Active Directory Domain Services to serve as its primary identity provider responsible for verifying the identity of users and providing them with the appropriate access to virtual desktops and applications based on their role and permissions. For more information on supported authentication methods and design considerations for AVD, see [Identity and access management considerations for Azure Virtual Desktop](eslz-identity-and-access-management.md)

If the identity system for Azure Virtual Desktop goes down, users won't be able to authenticate and access their virtual desktops and applications. This can result in a significant loss of productivity. Additionally, if unauthorized users are granted access to virtual desktops and applications due to a failure in the identity system, it can lead to data breaches and security risks for the organization.

In addition to the risk of downtime, delays in the synchronization of Active Directory can also result in signin failures or issues with accessing applications. This is because Azure Virtual Desktop uses Active Directory to store user profiles and application data, which is critical for providing a seamless virtual desktop experience. If there's a delay in syncing user profiles or application data, it can lead to slow login times, user frustration, and a loss of productivity.

## Storage 

Storage is another critical aspect of Azure Virtual Desktop. It's responsible for storing user profiles, virtual machine disks, and application data. If the storage system fails, users won't be unable to access their data, and virtual machines will be unavailable. This can cause significant disruption to an organization's operations. 

To mitigate the risk of storage failure, organizations should implement redundant storage and backup solutions. Redundant storage ensures that if one storage system fails, there's a backup system to take its place. Backup solutions provide another layer of protection by creating copies of data that can be restored if there was a failure. For best practices, see [Storage FSLogix profile container Azure Virtual Desktop - Azure | Microsoft Learn](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-desktop/store-fslogix-profile.md)

## Networking 
Networking is a crucial component of Azure Virtual Desktop. It is responsible for connecting users to virtual desktops and applications. If the networking system fails, users will be unable to access their virtual desktops and applications, and the organization's operations will be significantly impacted. For Azure Virtual Desktop Networking Concepts and Recommendations, see [Networking for Azure Virtual Desktop - Cloud Adoption Framework | Microsoft Learn](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/scenarios/wvd/eslz-network-topology-and-connectivity.md)

To mitigate the risk of networking failure, organizations should implement redundant networking solutions. Redundant networking ensures that if one network fails, there's a backup network to take its place. Additionally, organizations should implement load balancing solutions to distribute network traffic across multiple networks, reducing the risk of network congestion and failure.

## Compute 
The compute system is responsible for running virtual machines and applications for Azure Virtual Desktop. If the compute system fails, users are unable to access their virtual desktops and applications, and the organization's operations may be impacted.

To mitigate the risk of compute failure, organizations should implement either an Active-Active or Active-Passive BCDR Approach, see [Business continuity and disaster recovery for Azure Virtual Desktop - Cloud Adoption Framework | Microsoft Learn](eslz-business-continuity-and-disaster-recovery.md) . Availability options should be considered when creating Azure Virtual Desktop host pools [Availability options for Azure Virtual Machines - Azure Virtual Machines | Microsoft Learn](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-machines/availability.md) and consider separating critical applications from noncritical apps so that you can provision host pools with different disaster recovery approaches and capabilities. 

Azure Virtual Desktop provides a scalable, secure, and reliable virtual desktop experience for organizations. However, like any technology, it isn't without its failure points. Identity, storage, networking, and compute are the four main categories of failure points for Azure Virtual Desktop. To mitigate the risks of failure, organizations should implement redundant solutions and backup solutions. Additionally, organizations should implement load balancing solutions to distribute resources and reduce the risk of congestion and failure. By taking these steps, organizations can ensure that their virtual desktop infrastructure remains available and operational, even in the face of failure.


