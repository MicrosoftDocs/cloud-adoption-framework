---
title: Platform automation considerations for Red Hat Enterprise Linux on Azure
description: Learn about the tools, features, and services to automate various tasks and manage the Red Hat Enterprise Linux lifecycle within your Azure environment.
author: heisthesisko
ms.author: joelsisk
ms.date: 07/24/2024
ms.topic: concept-article
---

# Platform automation considerations for Red Hat Enterprise Linux on Azure

This article describes how to manage automation for Red Hat Enterprise Linux (RHEL) on Azure. It describes design considerations, design recommendations, and options for various tooling within the Azure ecosystem that you can use to achieve a consistent and stable environment. This article provides guidance that aligns with various customer scenarios, business requirements, operational practices, and technical maturity.     

## Overview

When you automate RHEL for Azure landing zones, you use the Red Hat Infrastructure Standard (RH-IS) and the associated Red Hat Infrastructure Standard Adoption Model (RH-ISAM) to align Azure landing zone lifecycle management. Standardize systems to provide a reliable foundation for the solution. The RH-IS defines the standard operating environment that comprises the default set of software components and configurations. You can apply these components and configurations to systems via the RH-ISAM, a set of DevOps or Git operation principles, Azure Resource Manager templates (ARM templates), Terraform, Azure CLI, and Azure PowerShell.

You can automate various operations. For example, you can use automation to:
- Provision components. 
- Manage systems.
- Perform platform evolution.
- Incorporate infrastructure operations.
- Configure application and workload lifecycles.

You can implement these operations through infrastructure as code (IaC) and configuration as code. To reduce errors and increase reliability, define and test configurations. To speed up mass migrations, automate provisioning. Automated configurations reduce configuration drifts and ensure that systems function correctly. 

## Design considerations

Red Hat Identity Management (IdM) provides a centralized and unified platform that you can use to manage identity stores, authentication policies, and authorization policies for RHEL systems. In a hybrid scenario, you can extend your existing Red Hat IdM infrastructure across a virtual private network or Azure ExpressRoute. This configuration connects on-premises environments with the RHEL landing zone within Azure. To support hybrid cloud identity scenarios, extend your on-premises environment into Azure so that you can integrate your workloads with Microsoft Entra. For more information, see [Microsoft Entra authentication](/entra/identity/authentication/).

As an alternative identity management solution, you can join RHEL to create an external trust with Windows Server Active Directory or join directly into an existing Windows Server Active Directory forest. For more information, see [Integrate RHEL systems directly with Windows Server Active Directory](https://access.redhat.com/documentation/red_hat_enterprise_linux/8/html-single/integrating_rhel_systems_directly_with_windows_active_directory/index).   

[Red Hat Satellite](https://www.redhat.com/technologies/management/satellite) is the single source of content that's delivered to managed RHEL systems. Satellite includes Red Hat packages and patches and also non-Microsoft packages and custom packages that application development teams develop. Satellite acts as the gateway to Red Hat Insights, which offers predictive analysis of configurations to recognize security or performance risks. If you deploy preconfigured RHEL pay-as-you-go images, you can take advantage of [Red Hat Update Infrastructure for Azure](/azure/virtual-machines/workloads/redhat/redhat-rhui), which is an update tool that's built into the pay-as-you-go images.


### Red Hat Ansible Automation Platform design considerations

Red Hat Ansible Automation Platform (AAP) helps standardize technical workflows and recurring tasks. You can use AAP to orchestrate workflows, provision processes for new systems, and create recurring operational tasks. To reduce complexity, use one common automation platform and language. Fully automated workflows accelerate application innovation and simplify mass workload migrations across on-premises environments and cloud environments.

Benefits of RHEL as a platform automation strategy include:

- New systems have fully automated provisioning at scale, which improves mass migration speed. 

- Increased uniformity of tested systems' configuration and application installations across physical systems and virtual systems. 
- Continuous updates because patch management is immediately available.
- A standardized and simplified platform to deliver new applications and workloads. Staff has extra time to deliver increased innovation. 

You can implement: 

- A self-managed AAP instance via on-premises infrastructure, cloud infrastructure, or both. You can use a RHEL deployment or a Red Hat OpenShift Container Platform deployment.

- A self-managed AAP instance in a public cloud.
- A managed AAP instance in a public cloud.

### Self-managed Red Hat AAP on-premises or in the cloud

Deploy [Red Hat AAP on Microsoft Azure](https://www.redhat.com/en/technologies/management/ansible/azure) in self-managed mode in an on-premises, cloud, or hybrid infrastructure to get the following benefits: 

- **Architecture and scale**: Determine your ideal architecture to support the automation platform. You can base the architecture on RHEL infrastructure or an OpenShift operator deployment. Based on your fleet size and requirements, choose the number and the instance sizing of controllers, execution nodes, and private automation hub instances. For more information about architecture, design, configuration, and scale, see the [Red Hat AAP planning guide](https://access.redhat.com/documentation/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_planning_guide/index). 

- **Azure configuration**:  Optimize the automation architecture for your organization's Azure design and configuration.
- **Automation mesh support**: Use the AAP automation mesh feature to distribute automation workloads across hybrid cloud nodes that establish peer-to-peer connections by using existing networks. Place hop nodes in a location based on your security design criteria and network topology.
- **Automation hub architecture**: Optimize an automation hub architecture for scale and placement of private automation hub instances. Optimize configurations to enhance secure automation content delivery and access to execution environment sources that are in close proximity to automation execution resources. You can choose which Ansible content collections and versions that automation consumers can access.

### Managed or self-managed Red Hat AAP on Azure 

[Red Hat AAP on Microsoft Azure](https://www.redhat.com/technologies/management/ansible/azure) is available via a managed application or self-managed application, which provides the following benefits:

- **A rapid return on investment (ROI) due to ease of use**: You can deploy AAP on Azure directly from Microsoft Marketplace. This managed solution is active immediately after deployment, and you can start automating the management of your Azure resources in minutes. Red Hat manages the infrastructure, so you're free to think about other systems that are critical to your enterprise.

- **Streamlined integration**: AAP on Azure is integrated with Azure services. Microsoft and Red Hat developed and security tested the Ansible collection for Azure, so you need minimal setup, and you get maximum support. Use AAP on Azure as part of your hybrid cloud automation strategy to unify management and automation across hybrid cloud, Internet of Things, and edge deployments.
- **Existing committed Azure spend**: You can use existing committed spending with Microsoft to purchase Red Hat AAP on Azure. Use committed spending so that teams across your entire organization can deploy, configure, and automate components seamlessly. Integrated billing means you get one bill and full visibility into the cost. 
- **Automation beyond the cloud**: With AAP on Azure, you can deploy applications in your Microsoft Azure cloud and then extend them across your infrastructure. Deploy, run, and scale applications across Azure and hybrid cloud environments.
- **Support**: Red Hat and Microsoft partnered to build AAP on Azure to ensure consistent, security-focused operations. Red Hat manages, services, and supports the application so that your IT team can focus on delivering automation strategies. 

#### Other considerations for managed mode

You can install AAP on Azure in managed mode so that it's a managed application. Red Hat manages both the underlying Azure resources and the software that runs on it. That infrastructure runs in your Azure tenant.

The managed application resource group is separate from other resource groups in your tenant. Red Hat has access to the managed application resource group only, with no visibility into other tenant resources.

For more information, see [Azure managed applications overview](/azure/azure-resource-manager/managed-applications/overview). 	

AAP on Azure in managed mode uses the following resource groups:

- **A new or existing resource group in your tenant**. This resource group includes a single resource that refers to the AAP on Azure managed application deployment. Red Hat has access to the managed app to perform support, maintenance, and upgrades. But Red Hat doesn't manage the resource group.
	
- **A multitenant managed resource group (MRG)** that contains most of the required infrastructure to operate AAP on Azure. The Red Hat tenant and your tenant share this multitenant resource group. Red Hat has full administrative control. You have read-only access to the resource group. 
- **An Azure Kubernetes Service (AKS) node pool resource group (NPRG)**. Microsoft requires an NPRG for AKS deployments. An NPRG contains resources that AKS uses to function. This resource group is created on deployment. Red Hat doesn't manage this resource group. For more information, see [Microsoft AKS documentation](/azure/aks/faq#why-are-two-resource-groups-created-with-aks).

For AAP on Azure in managed mode, also consider the following factors: 

- When you install AAP on Azure, you choose whether the deployment is public or private, which affects how users can access the AAP user interfaces.
 
- Regardless of whether you choose a public or private deployment, you must configure network peering for outbound communication from AAP to the private networks that contain resources that you want to automate against. You can configure network peering from AAP on Azure to your private Azure virtual network and to on-premises networks or multicloud networks where transit routing with Azure exists. 

#### Other considerations for self-managed mode 

AAP on Azure in self-managed mode provides many of the same benefits of managed AAP. But where managed mode runs within an AKS cluster, self-managed mode automation platform resources are virtual machine (VM)-based.

For AAP on Azure in self-managed mode, consider the following factors: 

- Event-Driven Ansible is included in the self-managed offering on Azure. Event-driven automation helps you reduce manual tasks and deliver an efficient IT environment that focuses on innovation. Event-Driven Ansible processes events, determines the appropriate responses, and then runs automated actions to remediate the event.

- Subscriptions are available in 100 active managed node increments. They're available in public offers or private offers. 
- VM resources that underpin AAP on Azure in self-managed mode can consist entirely of Microsoft Marketplace images or a mix of [Microsoft Marketplace](https://marketplace.microsoft.com) images and customer-managed images. 

## Design recommendations

When you operate the RHEL platform for Azure landing zones, use Red Hat-certified content and validated content collections from Red Hat automation hub. The following collections have prominent roles in the automation framework:

- **redhat.rhel_idm**
  - Configure IdM primary VMs.
  - Configure IdM replicas.
  - Integrate and configure RHEL clients with IdM.

- **redhat.satellite**, **redhat.satellite_operations**, and **redhat.rhel_system_roles** 
  - Deploy Satellite and Capsule.
  - Create and configure Satellite objects and settings.
  - Provision and configure RHEL systems.

- **ansible.\***, **ansible.controller**, and **infra.controller_configuration** 
  - Configure AAP.
  - Create and configure AAP job templates and settings.

[The Ansible collection for Azure](https://catalog.redhat.com/software/collection/azure/azcollection?tab=documentation) includes over 250 modules that you can use to interrogate, manage, and automate Azure resource types, such as:

- AKS.
- Application security groups.
- Azure Container Registry.
- Azure database services.
- Azure Key Vault.
- Azure SQL Database.
- Azure Virtual Machines.
- Microsoft Entra ID.
- Networking.
- Storage.

### Core platform infrastructure deployment

Establish concepts and processes to effectively deploy core platform infrastructure and support an RHEL platform on Azure landing zones model.

For more information, see:

- [Azure landing zone design guidance for platform automation considerations](/azure/cloud-adoption-framework/ready/considerations/automation).

- [Development lifecycle](/azure/cloud-adoption-framework/ready/considerations/development-strategy-development-lifecycle). Explore key design considerations and recommendations about using automation to create a landing zone. This guidance discusses the repository, branch, automated builds, deployment, and rollback strategy.

- [IaC](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options). Explore the benefits of implementing Azure landing zones via IaC. Learn about considerations related to code structure, tools, and technology. 
- [Environments](/azure/cloud-adoption-framework/ready/considerations/environments). Learn how to use multiple environments to build, test, and release code with greater speed and frequency. This approach makes deployment as straightforward as possible.
- [Test-driven development](/azure/cloud-adoption-framework/ready/considerations/development-strategy-test-driven-development). Learn how to use unit testing to improve the quality of new features and make improvements in the Azure landing zone code base. 

When you have the requisite source code management tooling in place and the source code management processes established from the previous sections, you can implement automation. Develop Ansible automation code with accompanying IaC or configuration as code to deploy core infrastructure and support the RHEL platform for Azure landing zones model. For greenfield deployments, you can automate the following tasks for a full environmental implementation. For brownfield deployments, you can automate only the tasks that your use case requires.

- Create Azure resource groups.
- Create virtual networks.
- Create subnets. 
- Create network security groups.
- Create RHEL 8.x and 9.x golden images for Azure via automated Red Hat Image Builder.
- Create an IdM primary VM (pre-Satellite provisioning). Configure the IdM primary VM via configuration as code.
- Create a Satellite VM (pre-Satellite provisioning). Configure Satellite via configuration as code.
- Create Capsule VMs (Satellite provisioning). Configure Capsule via configuration as code.
- Create IdM replica VMs (Satellite provisioning). Configure IdM replicas via configuration as code.
- Create AAP infrastructure (Satellite provisioning), including:
    - Automation controller VMs.
    - Execution node VMs.
    - Hop node VMs (optional).
    - Automation hub VMs.
    - Event-Driven Ansible VMs (if enabled).
    - Azure Database for PostgreSQL server and the necessary databases for the controller, hub, and Event-Driven Ansible components. High availability or disaster recovery Azure Database for PostgreSQL configurations require extra automation via replication shipping, log shipping, or [Crunchy Postgres](https://www.crunchydata.com/solutions/ansible).
- Create load balancers (application gateways).
    - Front end for Capsule VMs 
    - Front end for AAP controller VMs 
    - Front end for Automation hub VMs 
- Create application security groups.
    - IdM infrastructure
    - AAP infrastructure
    - Satellite or Capsule infrastructure 

### RHEL system lifecycle management  

After core platform infrastructure is in place, you can implement automation for RHEL applications and workload lifecycles. The following workflow describes an example automation implementation for a development lifecycle pipeline:

1. Update the errata filter end date, and publish content in Satellite.

1. Promote content views (CV) and composite content views (CCV) to development.
1. Deploy RHEL development test systems from Satellite host groups. RHEL 8.x and 9.x golden images for Azure via automated Red Hat Image Builder are defined as Azure compute resources in Satellite. 
1. Update or create Azure network security groups based on application communication paths.
1. Update or create Azure application security groups to provide extra layered security for multiple-tier application stacks.
1. Update RHEL development systems, and deploy and configure desired applications from Satellite development CV or CCV.
   - Deploy to a single RHEL instance for a simple application stack.
   - Deploy to several RHEL instances for multiple-tier application stacks.
   - Configure an application stack.
1. Run an application testing framework.
   - If the test fails, notify OnCall automation administration to help with troubleshooting and analysis. Exit the automation workflow. RHEL test systems remain deployed for post-mortem failure analysis.
   - If the test succeeds, continue the steps.
1. Promote CVs and CCVs to quality assurance (QA).
1. Destroy RHEL development test systems.

Subsequent stages in the lifecycle pipeline are slightly different from the development lifecycle stage. Only the development stage uses the initial content publishing and initial CV and CCV promotion to development. The following example describes an automation workflow for nondevelopment lifecycle pipelines, for example QA, preproduction, and  production pipelines.

1. Deploy RHEL QA test systems from Satellite host groups. RHEL 8.x and 9.x golden images for Azure via automated Red Hat Image Builder are defined as Azure compute resources in Satellite.
       
1. Update or create Azure network security groups based on application communication paths.
1. Update or create Azure application security groups to provide extra layered security for multiple-tier application stacks. 
1. Update RHEL QA systems, and deploy and configure desired applications from CV or CCV in Satellite QA.
   - Deploy to a single RHEL instance for a simple application stack.
   - Deploy to several RHEL instances for multiple-tier application stacks. 
   - Configure an application stack.
1. Run an application testing framework.
   - If the test fails, notify OnCall automation administration to help with troubleshooting and analysis. Exit the automation workflow. RHEL test systems remain deployed for post-mortem failure analysis.
   - If the test succeeds, continue the steps.
1. Promote CVs and CCVs to production.
1. Destroy RHEL QA test systems.

## Other design considerations for Azure-native tooling           

### Azure Automation

To automate frequent, time-consuming, and error-prone management tasks, you can use the process automation feature in Azure Automation. This feature helps you focus on work that adds business value. Process automation reduces errors and boosts efficiency, which helps lower your operational costs. For more information, see [Automation overview](/azure/automation/overview). 

Process automation supports the integration of Azure services and other partner systems, such as Red Hat, that you need to deploy, configure, and manage your end-to-end processes. You can also use this feature to author graphical PowerShell and Python [runbooks](/azure/automation/automation-runbook-types).  

You can use runbooks for a wide range of automation tasks, like managing resources, starting and stopping VMs, and handling maintenance tasks both within Azure and outside Azure. For more information, see [Azure Automation account authentication overview](/azure/automation/automation-security-overview) and [Runbooks in Azure Automation](/azure/automation/automation-runbook-execution). 

The following table describes the supported runbook types. 

| Runbook type | Description |
|---|---|
| [PowerShell](/azure/automation/automation-runbook-types#powershell-runbooks) | A textual runbook that's based on Windows PowerShell scripting. The versions that are supported are PowerShell 7.2 (GA) and PowerShell 5.1 (GA). The PowerShell parent product no longer supports PowerShell 7.1. We recommend that you create runbooks in the long-term supported version PowerShell 7.2. |
[PowerShell Workflow](/azure/automation/automation-runbook-types#powershell-workflow-runbooks) | A textual runbook that's based on Windows PowerShell Workflow scripting. |
[Python](/azure/automation/automation-runbook-types#python-runbooks) | A textual runbook that's based on Python scripting. The versions that are supported are Python 3.8 (GA) and Python 3.10 (preview). The Python parent product no longer supports Python 2.7. We recommend that you create runbooks in long-term supported versions. |
[Graphical](/azure/automation/automation-runbook-types#graphical-runbooks) | A graphical runbook that's based on Windows PowerShell and created and edited completely in the graphical editor in the Azure portal. |
[Graphical PowerShell Workflow](/azure/automation/automation-runbook-types#graphical-runbooks) | A graphical runbook that's based on Windows PowerShell Workflow and created and edited completely in the graphical editor in the Azure portal. |

Use [webhooks](/azure/automation/automation-webhooks) to fulfill requests and to ensure continuous delivery and operations by triggering automation via Azure Logic Apps, Azure Functions, IT service management products or services, DevOps, or monitoring systems.

Azure Arc represents a significant advancement in cloud computing and offers a unified management platform that extends Azure capabilities to on-premises, multicloud, and edge environments. Azure Arc integrates with the Azure Automation service via the VM extension framework to deploy the hybrid runbook worker role and simplify onboarding to the update management, change tracking, and inventory features.

:::image type="content" source="images/platform-automation-devops/arc-ecosystem.png" alt-text="Diagram that shows the Azure Arc ecosystem." border="false" lightbox="images/platform-automation-devops/arc-ecosystem.png":::

For more information about hybrid and multicloud strategy with Azure Arc, see the [Cloud Adoption Framework hybrid and multicloud with Azure Arc guidance](/azure/cloud-adoption-framework/scenarios/hybrid/strategy).

### ARM templates

IaC via ARM templates provides a consistent declarative method to deploy and manage Azure resources. Use ARM templates to define the required infrastructure for your applications in a JSON format. ARM templates are idempotent, which means that you can deploy the same template many times and get the same resource types in the same state. 

For more information, see [ARM template documentation](/azure/azure-resource-manager/templates/).

#### JSON example

```json
{ 

  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#", 
  "contentVersion": "1.0.0.0", 
  "parameters": { 
    "location": { 
      "type": "string", 
      "defaultValue": "[resourceGroup().location]" 
    }, 
    "storageAccountName": { 
      "type": "string", 
      "defaultValue": "[format('toylaunch{0}', uniqueString(resourceGroup().id))]" 
    } 
  }, 
  "resources": [ 
    { 
      "type": "Microsoft.Storage/storageAccounts", 
      "apiVersion": "2021-06-01", 
      "name": "[parameters('storageAccountName')]", 
      "location": "[parameters('location')]", 
      "sku": { 
        "name": "Standard_LRS" 
      }, 
      "kind": "StorageV2", 
      "properties": { 
        "accessTier": "Hot" 
      } 
    } 
  ] 
}  
```
You can use Bicep domain-specific language to reduce the complexity of the JSON syntax and minimize the learning curve for people who are new to Azure. Bicep is a transparent abstraction compared to an ARM template that uses JSON, and Bicep preserves the JSON template capabilities. During deployment, the Bicep command-line interface converts a Bicep file into an ARM template that uses JSON. 

The examples in this section show the difference between a Bicep file and the equivalent JSON template. Both examples deploy a storage account. 

#### Bicep example

```bicep
param location string = resourceGroup().location 
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}' 
 

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = { 
  name: storageAccountName 
  location: location 
  sku: { 
    name: 'Standard_LRS' 
  } 
  kind: 'StorageV2' 
  properties: { 
    accessTier: 'Hot' 
  } 
} 
```

### Azure DevOps

Azure DevOps is a comprehensive set of development tools that provide project management, continuous integration and continuous delivery (CI/CD) services, and source code repositories for both cloud and on-premises environments. You can combine these features with Azure Test Plans, Azure Artifacts, Logic Apps, and Azure Functions to facilitate seamless collaboration, development, and delivery of modern software projects.

### Azure Boards

Azure Boards supports Agile methodologies for cloud software development and project management. For more information, see [Azure Boards documentation](/azure/devops/boards/) and [Configure and customize Azure Boards](/azure/devops/boards/configure-customize).

To make the most of Azure Boards, understand how your teams use their tools and functions, for example Scrum, Kanban, and Scrumban, and their dependencies on configurations and customizations.

The following table summarizes the primary items that you should consider when you structure your project. 

| Project level                        |    Team level                                                     |
|---|---|
| The number of teams that you want to define | How to use your product backlog to plan and prioritize your work |   
| How to structure area paths to support portfolio management views  | Whether you track bugs as requirements, track bugs as tasks, or don't use bugs at all         |
| Field customization                  | Whether or not you use tasks to track time and capacity           |
| Custom work item types        | How to use portfolio backlog levels                              |   
| Portfolio backlog customizations     | How to use portfolio backlog levels                              |
| Workflow customization               | How to inform upper management of progress, status, and risks    |   

### Azure Pipelines

Azure Pipelines provides a quick, easy, and safe way to automate your project builds with consistent and quality code that's readily available. 

Azure Pipelines:

- Works with any language or platform.
- Deploys to different types of targets at the same time.
- Integrates with Azure deployments.
- Builds on Windows, Linux, or Mac machines.
- Integrates with GitHub.
- Works with open-source projects.

For more information, see [Azure Pipelines documentation](/azure/devops/pipelines/).

Depending on your organizational needs, you can choose one of the four core architectures for Azure Pipelines:

- [Azure Pipelines baseline architecture](/azure/devops/pipelines/architectures/devops-pipelines-baseline-architecture)
- [Azure Pipelines architecture for the Web Apps feature of Azure App Service](/azure/devops/pipelines/architectures/devops-pipelines-azure-web-apps-architecture)
- [Azure Pipelines architecture with Azure DevTest Labs](/azure/devops/pipelines/architectures/devops-pipelines-devtest-iaas-architecture)
- [Azure Pipelines architecture for infrastructure as a service](/azure/devops/pipelines/architectures/devops-pipelines-iaas-vms-architecture)

### Azure Repos

Azure Repos provides two types of version control, [Git version control](/azure/devops/repos/get-started/what-is-repos#git) and [centralized version control](/azure/devops/repos/get-started/what-is-repos#tfvc).

To access your code, connect your development environment to Azure Repos. Share your code via: 
- The [command line](/azure/devops/repos/git/share-your-code-in-git-cmdline).
- [Visual Studio Code](/azure/devops/repos/git/share-your-code-in-git-cmdline).
- [Xcode](/azure/devops/repos/git/share-your-code-in-git-xcode).
- [Eclipse](/previous-versions/azure/devops/all/java/download-eclipse-plug-in).
- [IntelliJ](/previous-versions/azure/devops/all/java/download-intellij-plug-in).

For more information, see [Azure Repos Git documentation](/azure/devops/repos/git/) and [Team Foundation Version Control documentation](/azure/devops/repos/tfvc/).

### Use release pipelines and Azure Artifacts sources 

Developers can use Azure Artifacts to publish and consume various types of packages from feeds and public registries, like PyPI, Maven Central, and NuGet.org. You can use Azure Artifacts with Azure Pipelines to publish build and pipeline artifacts, deploy packages, or integrate files across various stages of your pipeline to build, test, or deploy your application. 

For more information, see: 

- [Azure Artifacts in Azure Pipelines](/azure/devops/pipelines/artifacts/artifacts-overview).
- [Release pipelines and Azure Artifact sources](/azure/devops/pipelines/release/artifacts).
- [Get started with permissions and access](/azure/devops/organizations/security/about-permissions).

### Integrate Azure Policy with Azure DevOps

Azure Policy directly applies to resources within Azure environments, but its principles and governance can indirectly influence Azure DevOps practices. For example, Azure Policy can affect: 

- **Compliance in CI/CD pipelines**: You can integrate compliance checks into your pipelines. For example, ensure that any infrastructure that you deploy through Azure DevOps complies with the policies that you define in Azure Policy.

- **Environment consistency**: Use Azure Policy to enforce specific configurations or resource types to ensure that the environments that you deploy to through Azure DevOps are consistent and compliant. 
- **Security and governance**: Policies can enforce security standards and governance practices on the resources that Azure DevOps Projects manages. This regulation ensures that the development lifecycle includes compliance with organizational and regulatory standards. 

To effectively integrate Azure Policy with Azure DevOps, you can use Azure Policy compliance data and audit capabilities to inform your DevOps practices. Make adjustments to your pipelines or IaC definitions to align with organizational policies that you enforce through Azure Policy. 

This integration ensures that resources that you deploy and manage through Azure DevOps are always compliant with your company's governance standards. Use this approach to enhance security, consistency, and cost management across Azure environments. 

## Next steps

- [Install Azure PowerShell on Linux](/powershell/azure/install-azps-linux)
- [Use Azure PowerShell in a Docker container](/powershell/azure/azureps-in-docker)
- [Azure PowerShell documentation](/powershell/azure)
- [Install Azure CLI on Linux](/cli/azure/install-azure-cli-linux)
- [Run Azure CLI in a Docker container](/cli/azure/run-azure-cli-docker)
- [Azure CLI documentation](/cli/azure)