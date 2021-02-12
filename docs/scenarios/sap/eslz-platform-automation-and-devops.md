---
title: "Enterprise-scale platform automation and devops for SAP on Azure"
description: Understand the dependencies between SAP systems, environments, and landscapes to automate application deployments and management.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/11/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# SAP enterprise-scale platform automation and devops

This article describes how to approach System Identifier (SID) Automation on SAP by using an AppOps approach.

## Architecture

A SAP application consists of systems, environments, and landscapes. Platform automation and devops target these components.

The following diagram illustrates the dependencies between SAP systems, environments, and landscapes. Each landscape has three environment tiers: development, quality assurance, and production. Each environment contains one or more systems.

![Diagram showing architectural dependencies between SAP systems, environments, and landscapes.](media\SGC_Architectural_Principles.png)

### System

A SAP system is an instance of a SAP application that has the resources the application needs to run, like virtual machines (VMs), disks, load balancers, proximity placement groups, availability sets, subnets, and network security groups. Each system deploys into a separate Azure resource group with a unique SID.

### Environment

An environment is also called a development tier, and partitions the SAP application into tiers like development, quality assurance, and production. An environment deployment provides shared resources like virtual networks and key vaults to all the systems in the environment.

Environments provide the following services to SAP systems:

- Key vaults for credentials management. By default, all systems in the same environment share the credentials.
- Virtual network
- Storage accounts for:
  - Terraform remote storage
  - SAP installation media
  - Boot diagnostics for the VMs

### Landscape

A landscape is a collection of systems in different environments in a SAP application. The example diagram shows three SAP landscapes: SAP ERP Central Component (ECC), SAP Customer Relationship Management (CRM), and SAP Business Warehouse (BW).

## Design considerations

- To determine the number of environments you need, define how to partition environments, such as by subscription, virtual network, subnet, or deployment stage.

- Define service principal name (SPN) strategy for automation. Will each environment have a unique SPN?

- Define secrets or credentials management. Azure Key Vault is the recommended solution for key management and key storage. SAP Automation uses SPN credentials from Azure Key Vault. By default, all systems in an environment use the same credentials from the environment key vault. Determine whether any systems need unique credentials.

- Decide whether to use an Azure Marketplace image or a custom-built image. Custom-built images have several advantages, like customer-specific OS configuration, security hardening, or compliance tooling. Custom-built images can also potentially streamline image lifecycle management.

## Design recommendations

- Back up state file copies to safeguard against file corruption. For example, you can store Terraform state files on RA-GRS based HOT storage accounts.

- Store archival copies of automation tool binaries. Keep copies of Terraform/Ansible binary libraries of the specific version applicable to code.

- Use default SAP Automation standard naming conventions. SAP Automation publishes a set of naming convention guidelines.

- Provide a managed SAP Automation environment. Three methods to orchestrate automation are:
  
  - Begin by deploying Deployment Infrastructure as a central Automation Controller VM per SAP env NP and Prod.
    
  - Use Azure DevOps for automation runs, bypassing a controller VM. You can begin from SAP library and SAP IaaS builds.
    
  - Resource Provider (RP)-based automation. You can make script run calls from the Snow portal.

