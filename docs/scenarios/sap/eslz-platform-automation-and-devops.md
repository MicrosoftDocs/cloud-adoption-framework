---
title: Enterprise-scale platform automation and DevOps for SAP on Azure
description: Understand the dependencies between SAP systems, environments, and landscapes to automate application deployments and management.
author: JefferyMitchell
ms.author: brblanch
ms.date: 02/11/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing Snow -->

# SAP enterprise-scale platform automation and DevOps

All of the principles laid out in the Cloud Adoption Framework are applicable to SAP Automation, this section will explain how to start addressing SAP Automation.

When deciding on an automation approach it is important to look at an SAP Application landscape to identify the key components and based on those define the automation strategy.

SAP applications are mission-critical and form the technology backbone for enterprises around the world. Due to SAP systems' significance to an enterprise, guidelines are provided by SAP and Microsoft Azure to ensure the solutions are certified, supported, and successfully implemented. SAP deployments and system configurations are complex tasks. By harnessing Azure cloud's agility, organizations seek to automate SAP deployment activities for operational efficiency, controlled, and malleable-by-code infrastructure deployments.

Microsoft's SAP Automation repo is designed such that Azure-SAP customers have the freedom to incorporate the scripts in existing DevOps practices or use the code as-is, directly from a repo clone.

## SAP architecture

An SAP application estate consists of systems, workload zones, and landscapes.

### System

An SAP system is an instance of an SAP application that has the resources the application needs to run, like virtual machines (VMs), disks, load balancers, proximity placement groups, availability sets, subnets, and network security groups. The application is identified by a unique 3 letter identifier SID.

For lifecycle purposes, each system should deploys into a separate Azure resource group.

### Workload zone

A workload zone is also called a deployment environment, and partitions the SAP application into environments like non-prod and prod or can further segment a landscape into tiers like development, quality assurance, and production. A deployment environment provides shared resources like virtual networks and key vaults to all the systems in the workload zone.

### Landscape

A landscape is a collection of systems in different environments in an SAP application. The example diagram shows three SAP landscapes: SAP ERP Central Component (ECC), SAP customer relationship management (CRM), and SAP Business Warehouse (BW).

The following diagram illustrates the dependencies between SAP systems, workload zones, and landscapes. In the following illustration the customer has three landscapes: SAP ERP Central Component (ECC), SAP customer relationship management (CRM), and SAP Business Warehouse (BW). Each landscape has four workload zones: sandbox, development, quality assurance, and production. Each workload zone may contain one or more systems.

![SAP application estate.](./media/SAP_estate.png)
*Figure 1. SAP application estate.*

### Additional components

In addition to the SAP components the automation solution will need:

- An execution environment from where the deployment activities can be performed.
- Persistent storage for installation media and if Terraform is used storage for the Terraform state files.

**Design recommendations:**

- Use a virtual machine that has network connectivity to the target virtual networks in order to enable application configuration and installation.
- Use Azure Storage accounts for state file management and as installation source for SAP installation media.

## Preparation activities

### Deciding on a DevOps strategy

The SAP deployment automation is implemented as a workflow starting with infrastructure deployment and followed by operating system configuration and application installation.

**Design considerations:**

- Define the scope of automation
  - Infrastructure
  - Operating system configuration
  - Application installation
  - Ongoing operations (run-state operations)
- Define strategy for storage of parameter files

**Design recommendations:**

- Store all parameter files in a source control repository
- Back up state and parameter files to safeguard against file corruption. For example, you can store Terraform state files on read-access geo-redundant storage (RA-GRS) based hot storage accounts.

### Region planning

The SAP deployment automation framework supports deployments in multiple Azure regions. Each region will host:

- Deployment infrastructure
- SAP library for state and SAP installation media
- 1-n workload zones
- 1-n SAP systems deployed in the workload zones.

The following illustration shows the deployment strategy for two Azure regions.

![SAP DevOps strategy.](./media/SAP_DevOps_strategy.png)

*Figure 2. SAP Automation across regions.*

**Design considerations:**

- Which Azure regions are in scope?
- Disaster recovery considerations

### Workload zone planning

A workload zone combines the workload virtual network and the set of credentials to be used in the systems in that workload as well as the service principal that is used for deploying systems. The workload zones are regional because they depend on the Azure virtual network. The naming convention of the automation supports having workload zones in multiple Azure regions each with their own virtual network.

A workload zone is also called a deployment environment, and partitions the SAP application into environments like non-prod and prod or can further segment a landscape into tiers like development, quality assurance, and production. A deployment environment provides shared resources like virtual networks and key vaults to all the systems in the workload zone.

Some common patterns for workload zones are:

#### Production and non-production

In this model the SAP environments are partitioned into two zones, production and non production.

#### Sandbox, development, quality assurance, production

In this model the SAP environments are partitioned into four zones: sandbox, development, quality assurance, production

**Design considerations:**

- How many workload zones are required?
- Subscription design
  - Does a subscription contain multiple workload zones
- Which regions are the workloads deployed to?
- Outbound internet connectivity
- Network connectivity to On-Premises network
- Is the deployment a greenfield deployment (no Azure infrastructure for the workload exists) or a brownfield deployment (some or all of the artifacts supporting the workload zone already exists)?
- Deployment credentials, does each workload zone need unique deployment credentials?

**Design recommendations:**

- Outbound internet connectivity should be provided by the networking team
- Network connectivity to On-Premises network should be provided by the networking team
- Use unique deployment credentials per workload zone. **Note** if a workload zone exists in multiple regions they should use the same deployment credentials.
- Try to minimize the number of workload zones to simplify network planning

### SAP application planning

The SAP system is the actual SAP application, it contains all the Azure Artifacts required to host the SAP application. Refer to [SAP on Azure](/azure/virtual-machines/workloads/sap/get-started) to get started, plan, and consider deployment factors in detail.

**Design considerations:**

- Which database backend to use?
- The number of database servers?
- Is high availability required?
- The number of application servers?
- The number of web dispatchers (if any)?
- The number of central services instances?
- The sizes of the virtual machines?
- Decide whether to use an Azure Marketplace image or a custom-built image. Custom-built images have several advantages, like customer-specific OS configuration, security hardening, and compliance tooling. Custom-built images can also potentially streamline image lifecycle management.
- Is the deployment a greenfield deployment (no Azure infrastructure for the subnets created) or a brownfield deployment (some or all of the artifacts for the subnets already exists)?
- IP allocation strategy (Azure or customer provided)
- Naming convention for Azure resources
- Define credentials management requirements, can all the systems in a workload zone use the same credentials to access the virtual machines?

**Design recommendations:**

- Use default SAP Automation standard naming conventions. SAP Automation publishes a set of naming convention guideline [naming convention](https://github.com/Azure/sap-hana/blob/master/documentation/SAP_Automation_on_Azure/Software_Documentation/standards-naming.md).
- Use the same set of credentials for each system deployed into a workload zone. Azure Key Vault is the recommended solution for key management and key storage.

## The SAP deployment automation framework

The SAP deployment automation framework provides both Terraform templates and Ansible playbooks which can be used to build and configure the environments to run SAP on Azure. The artifacts are hosted in the [sap-hana](https://github.com/Azure/sap-hana) repository. The SAP on Azure deployment scripts are open-source and supported by Azure (non-customized code).

### Automation capabilities

#### Supported platforms

The SAP deployment automation supports deployment on both Linux and Windows

#### Supported topologies

The default deployment model using the SAP deployment automation is the distributed model with a database tier and an application tier. The application tier can be further split into three tiers: the application servers, the central services servers and the web dispatchers.

The automation can also be deployed to a standalone server by specifying an configuration without an application tier.

#### Included capabilities

The SAP deployment automation framework capabilities matrix

| Feature | Included | Notes |
|:-|:-|:-|
| Accelerated networking | Y | Accelerated networking is enabled on VMs |
| Application security groups | N | In roadmap |
| Anchor VM | Y | A virtual machine which is uses to anchor the proximity placement group in the Availability Zone |
| Application configuration | N | Ansible-based configuration to be released shortly |
| Application installation | N | Ansible-based installation to be released shortly |
| Authentication | Y | The authentication supports both SSH-based authentication as well as username/password-based authentication |
| Availability Zones | Y | The automation can deploy virtual machines zonal or across Availability Zones |
| Azure Files for NFS | N | In roadmap |
| Azure Firewall | Y | The automation can deploy an Azure Firewall in the deployer network |
| Azure Load Balancer | Y | The automation uses standard Azure load balancers |
| Azure NetApp Files | N | In roadmap |
| Boot diagnostics storage account | Y | The boot diagnostics storage account is shared across all systems in a workload zone |
| Azure key vaults | Y | New Azure key vaults or existing |
| Customer images | Y | The custom images need to be replicated to the region |
| Customer managed disk encryption keys | Y | The keys need to be pre-created and stored in an Azure Key Vault |
| Deployment environment | Y | A virtual machine in a network peered to the SAP network(s) |
| Disk sizing | Y | Default disk sizing specified, can be configured |
| IP addressing | Y | Both customer specified IP addresses and Azure provided |
| Naming convention | Y | Default naming convention, can be customized |
| Network security groups | Y | New network security groups or existing |
| Operating system configuration | N | Ansible-based configuration to be released shortly |
| Proximity placement groups | Y | New proximity placement groups or existing |
| Resource group | Y | New resource group or existing |
| Subnets | Y | New subnets or existing |
| Storage for SAP installation media | Y | New storage account or existing |
| Storage for Terraform state | Y | New storage account or existing |
| Virtual machine SKU | Y | All virtual machine SKUs are configurable |
| Virtual networks | Y | New virtual network or existing |
| Witness storage account | Y | The witness storage account is shared across all systems in a workload zone. Used for Windows high availability scenarios |

### Planning for the parameter files

The SAP Deployment Automation leverages json parameter files to configure the Azure environment with different parameter files for the different artifacts.

The development environment should clone both the `SAP HANA` repository and the customer repository into the same root folder.

Having the parameter files in a predefined folder structure will simplify automated deployment operations.

**Design recommendations:**

All parameter files should be stored in a source control environment.
