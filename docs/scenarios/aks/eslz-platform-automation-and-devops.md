---
title: "Enterprise-Scale platform automation and devops for <Insert narrative Name>"
description: Describe how this enterprise-scale scenario can improve platform automation and devops of <Insert Scenario Name>
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform automation and devops for <Insert narrative Name> Enterprise-Scale scenario

## Planning for a DevOps and highly automated approach

Kubernetes is a cloud native construct from the get-go and as such requires a different more cloud native approach in deploying and operating it, by heavily relying on automation and general DevOps best practices. 

### Design recommendations

- Strive for nonhuman intervention where possible. While some tasks might seem daunting to overcome through automation at first, it is always worth the investment further down the road. Automation always gives you a predictable way of testing and validating the expected outcomes , improving overall quality and agility of the team. It's is recommended to rely on pipelines or actions infrastructure, maximizing applied practices across the team, removing much of the burden of setting up and engineering the automation plumbing code and providing tremendous insights in overall build and deployment quality and agility.

- Deploy early and often through usage of pipelines executing a deployment through triggers and on a scheduled basis. The first will assure any change goes through the proper testing and validation while the second will tell you more about its behaviour on a changing environment independent of actual code and configuration changes. Azure and Kubernetes are always an evolving platform and subject to changes and updates .

- Separate the infrastructure deployment from the actual application deployment. Think about this as two separate lifecycles. The core infrastructure including the control plane is expected to change less compared to the actual application on top. It is also not uncommon to host multiple applications on the same cluster. Lastly from a development productivity angle it is more beneficial and agile having an existing cluster while developing new features or fixing bugs. As such it is recommended to treat each type of deployment as a separate flow and pipeline, potentially linked in case a single application belongs to a single cluster.

- It is recommended to deploy using the most native approach possible for the platform. While many tools are available supporting cloud deployments in a more abstract and agnostic way, there is always a trade-off to be made when it comes to performance and compatibility in those case. In that context it is recommended to use ARM for deploying any infrastructure including the control plane and use Helm for deploying any Kubernetes native components.

- It is recommended to use GitOps for anything touching the Kubernetes cluster. With GitOps, the git repository is used as a single source of truth, avoiding configuration drift, increasing productivity and reliability in case of rollbacks and related procedures.

- Strive for maximized deployment concurrency by avoiding hardcoded configuration items and settings. Instead rely on conventions and derivatives to assure deployments are never blocked. Every deployment blocked due to resource conflict or other reasons is a wasted opportunity to meet the customer needs in an agile manner.

- Treat every failure, error, or outage as an opportunity to automate and improve the overall quality of the solution, independent if happening in development, testing or production environments. Azure and Kubernetes are both an open and extensible platform with a rich, well documented, and well architected API, providing all means to automate it to the full extent. 

### Design considerations

- Consider usage of prefixes and post fixes together with well defined conventions to identify uniquely every deployed resource. Doing so will avoid conflicts in deploying solutions next to each other. 

- Consider additional resources to be deployed in a separate subscription to support your devops experience across environments. Tagging, labels, and other concepts can be used to track and trace deployments and related artefacts.

- Get familiar with pods and other aspects of Kubernetes to be ephemeral and align your automation and pipeline infrastructure accordingly. Don't rely on IP addresses or other concepts to be fixed and always to be there.
