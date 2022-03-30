---
title: Building your devops practice
description: Use the Cloud Adoption Framework for Azure to understand the motivations behind cloud migration that can help produce more successful business outcomes.
author: wayneme
ms.author: brblanch
ms.date: 03/30/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Building your devops practice

This article is intended to help you think through the various aspects of building out your devops practice, we will help you answer some critical questions such:
- Why would I invest in building a devops team?
- Why would I want to consider infrastructure-as-code?
- Why would I want to  favor automated deployment of workloads and applications?
- How will my operating model evolve?

The cloud offers new ways of doing business, it gives IT teams the ability to scale and democratize services, it offers opportunities for global expansion, and assists in driving consistency and velocity when done right. As customers evolve and look to deliver differentiated services to accelerate business, having a devops practice will enable teams to collaborate effectively, and build software at a much higher velocity all whilst maintaining controls, security and governance.
The underpinning of a strong cloud business is a mature devops practice, when we can unify people, process and technology we can begin to transition our cloud practice from being a destination to a model. 

## What does it mean when you talk about cloud being a model vs a place?

Using cloud as a destination typically means that we have not transformed practices and delivery of services. We build in the same way, usually having a high dependency on central IT teams to provision and then hand off to developers or application teams. This model can slow us down as well as drive up costs. When customers transform to the model of cloud, they tend to democratize IT resources, use more cloud native services, they enable self-service, use repeatable builds and rely on skills not only in the immediate IT teams but empowering others across the business. By no means are we indicating that VMs and infrastructure as a service are bad, many customers start here, this is just the start we need to transition to microservices and platform services that can reduce overhead, costs and improve service delivery. The role of IT evolves to one of governance and empowerment.

## Evolving traditional functions to meet to be cloud aligned 

In the Organize section of the adoption framework we cover the functions needed for a cloud practice, breaking down silos and looking across the organization to get the best skills. We attempt to show that small IT teams can accomplish a lot when removing barriers and enabling others to self-serve in a compliant way. As we build these capabilities we begin to see operations teams embracing infrastructure as code, traditional network, security and system admins writing scripts to drive greater consistency. 

To put this into a practical example, Contoso acquires a new company and needs to incorporate them into their Azure environment, the new company has their own applications and data. Contoso has a new landing zone deployment fully scripted. In the landing zone they will provision a subscription, with network peering to connect back to the hub network, policies to comply with Contoso’s corporate governance, and appropriate permissions have been set. This onboarding process takes no more than 10min to execute. The new company can now begin the process of migrating their applications into their newly created landing zone. 

In more traditional environments, you would have had a waterfall approach to these projects, you would have had to acquire hardware or the service, once the acquisition had been made IT would then deploy the infrastructure, then networking would need to configure the routing, then security would have had to validate and apply security policies, governance teams would then need to check compliance and apply missing policies. Each of the phases can take weeks or months to complete. 

## Repeatability driving velocity 

Moving to a code-based infrastructure does not need to be overly complex, there are simple things which can be done initially to help you move in the right direction. You can start by simply creating repeatable templates to automate your workload deployments. Think about golden images for VMs with the right security parameters, storage accounts for long term and short-term storage needs, templates for web apps based on Linux and which enable ssl only. The possibilities are endless. Storing the code for these templates can be done in numerous ways as well, whether they reside in a git repository (Azure DevOps or GitHub) or using something like Template Specs in Azure which can be version controlled. It doesn’t matter which system an organization choses its about the muscle that we start to flex and develop. Build, code, deploy, reuse, learn.

## Should I build all workloads through code?

Even if devops is critical to your strategy, not all workloads are great candidates for devops. Identify early where you are making investments in apps & understand the value you’ll get from devops. Likewise identify apps that may not produce a return from similar investments. Consider how those workloads will be managed & by who. Examples include: commercial off the shelf (COTS), apps slated for sunset, & some legacy apps.


## Customers are key 

Listening and learning from customers is a key part of the devops practice. As you develop and enhance your practice take feedback from your users, incorporate into your backlog, triage and use this as a source of continuous improvement. Here is a Microsoft example of where we have given customers the option to give direct feedback. In our documentation on docs.microsoft.com each article has an edit button at the top, as a reader you can edit the documentation, this will kick off a pull request which goes directly to the document owner so that they can review and incorporate – for Microsoft no longer are we bound by our own employees creating documentation, but we can leverage on the broad set of skills and expertise in the market to contribute. As you can see from this devops does not only touch on developers building product, but other key elements of the product lifecycle – everything as code.

## Next steps

As you read through the cloud adoption framework content, you will notice that devops is present across all phases. Here are some points to follow as you begin:

1.	Build your strategy with devops in mind
2.	Take the opportunity to reimagine your organization as a cloud based organization
3.	Operationalize your plan using repeatable agile principles
4.	In your landing zone enable CI/CD for consistent code based management
5.	Evaluate devsecops to understand his security fits into your devops cycles
6.	Start to deploy your workloads through pipelines and/or actions
7.	Establish a management baseline to provide each DevOps team with consistent tools & foundations for operations
8.	Integrate insights and management into your devops tooling so that you can respond appropriately to changing conditions and demands.
9.	Create governance guardrails so devops teams can deploy with confidence that they will be able to deploy to production without violating corporate policies
10.	Lastly, think about taking customer feedback, incorporating into your backlog and iterating rapidly for an experience that will keep them engaged



> [!div class="nextstepaction"]
> [Overview of business outcomes](./business-outcomes/index.md)
