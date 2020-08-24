---
title: "How does Azure work?"
description: Learn the basics about the internal structure and functioning of the Azure cloud platform and cloud virtualization.
author: alexbuckgit
ms.author: abuck
ms.date: 04/04/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.custom: governance
---

<!-- cSpell:ignore PDU -->

# How does Azure work?

Azure is Microsoft's public cloud platform. Azure offers a large collection of services including platform as a service (PaaS), infrastructure as a service (IaaS), and managed database service capabilities. But what exactly is Azure, and how does it work?

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2ixGo]

<!-- markdownlint-enable MD034 -->

Azure, like other cloud platforms, relies on a technology known as _virtualization_. Most computer hardware can be emulated in software, because most computer hardware is simply a set of instructions permanently or semi-permanently encoded in silicon. Using an emulation layer that maps software instructions to hardware instructions, virtualized hardware can execute in software as if it were the actual hardware itself.

Essentially, the cloud is a set of physical servers in one or more datacenters that execute virtualized hardware on behalf of customers. So how does the cloud create, start, stop, and delete millions of instances of virtualized hardware for millions of customers simultaneously?

To understand this, let's look at the architecture of the hardware in the datacenter. Inside each datacenter is a collection of servers sitting in server racks. Each server rack contains many server _blades_ as well as a network switch providing network connectivity and a power distribution unit (PDU) providing power. Racks are sometimes grouped together in larger units known as _clusters_.

Within each rack or cluster, most of the servers are designated to run these virtualized hardware instances on behalf of the user. But some of the servers run cloud management software known as a fabric controller. The _fabric controller_ is a distributed application with many responsibilities. It allocates services, monitors the health of the server and the services running on it, and heals servers when they fail.

Each instance of the fabric controller is connected to another set of servers running cloud orchestration software, typically known as a _front end_. The front end hosts the web services, RESTful APIs, and internal Azure databases used for all functions the cloud performs.

For example, the front end hosts the services that handle customer requests to allocate Azure resources such as [virtual machines](/azure/virtual-machines), and services like [Azure Cosmos DB](/azure/cosmos-db/introduction). First, the front end validates the user and verifies the user is authorized to allocate the requested resources. If so, the front end checks a database to locate a server rack with sufficient capacity and then instructs the fabric controller on that rack to allocate the resource.

So fundamentally, Azure is a huge collection of servers and networking hardware running a complex set of distributed applications to orchestrate the configuration and operation of the virtualized hardware and software on those servers. It is this orchestration that makes Azure so powerful, because users are no longer responsible for maintaining and upgrading hardware because Azure does all this behind the scenes.

## Next steps

Learn more about cloud adoption with the Microsoft Cloud Adoption Framework for Azure.

> [!div class="nextstepaction"]
> [Learn about the Microsoft Cloud Adoption Framework for Azure](../index.yml)
