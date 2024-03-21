---
title: Identity and Access Management for the Oracle@Azure landing zone accelerator
description: Identity and Access Management for the Oracle@Azure landing zone accelerator.
---
#
# **Identity and Access Management for the Oracle@Azure landing zone accelerator**
## **In this article**
1. [Design Considerations](#design-considerations)
2. [Design Recommendations](#design-recommendations)
This article builds on some of the considerations and recommendations that are defined in the [Azure landing zone design](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/). The design Area Identity and Access Management (IAM) is part of a collection describing Oracle Database@Azure landing zone accelerator.
The goal of this document is to define the customer experience for interacting with IAM resources when deploying Oracle Database@Azure.
Following the guidance, the article provides you with the design guidelines, architecture, and recommendations to deploy Oracle Database@Azure.
## **Design Considerations**
- Before deploying Oracle Database@Azure you have to configure federation between Microsoft Entra ID and Oracle Cloud Infrastructure (OCI)
- Oracle Database@Azure will be available as a private offer in Azure Portal, so you will need to agree and buy it as part of the get the private offer. This process needs specific permissions based on the agreement type. To see the specific permissions needed for this procurement process look at this [guide](https://learn.microsoft.com/en-us/marketplace/private-offers-in-azure-marketplace)
- When you deploy Oracle Database@Azure, you must be a Contributor for some of the resources that this service relies on.
- Deployment process of Oracle Database@Azure will create some groups within Microsoft Entra ID, you do not require specific permissions on Microsoft Entra ID.

## **Design Recommendations**
- Microsoft Entra ID is a central tool for managing identities and access to the resources created by the Oracle Database@Azure. After finishing the onboarding steps, you should have 
  1. Federated access between Azure and OCI. 
  2. Preconfigured groups with permissions for different operations.
- An Admin user is created in OCI when a new account and tenancy is provisioned, avoid using this identity for day-to-day operations and instead manage the infrastructure administrator group to provide the relevant individuals elevated access. This account will be the administrator, serving as the account owner for a new account being created.
- During deployment process some EntraID groups are created and synchronized with OCI. Users in these groups, with federation enabled, can log in to OCI using EntraID credentials and gain necessary permissions for CDB/PDB creation and management.
- For the limited group of individuals that will require OCI access – to create Pluggable Databases (PDB) for instance – make sure they are added to the proper group in OCI identity, with the proper permissions to access only certain resources. ![image](https://github.com/sihbher/cloud-adoption-framework-pr/assets/59939147/63f59ddb-e159-489b-b635-4f7bbd56e941)
