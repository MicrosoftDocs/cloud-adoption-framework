---
title: How does Azure work?
description: Learn the basics about the internal structure and functioning of the Azure cloud platform and cloud virtualization.
author: martinekuan
ms.author: martinek
ms.date: 01/20/2022
ms.topic: conceptual
ms.custom: internal, UpdateFrequency3
---

# How does Azure work?

Azure is Microsoft's public cloud platform. Azure offers a large collection of services, which includes platform as a service (PaaS), infrastructure as a service (IaaS), and managed database service capabilities. However, what exactly is Azure, and how does it work?

<!-- markdownlint-disable MD034 -->

<br/>

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=fe87c0af-e4b6-4138-96ee-22435d39b113]

<!-- markdownlint-enable MD034 -->

Azure, like other cloud platforms, relies on a technology known as *virtualization*. Most computer hardware can be emulated in software. Computer hardware is simply a set of instructions, which are permanently, or semi-permanently, encoded in silicon. Emulation layers are used to map software instructions to hardware instructions. Emulation layers allow virtualized hardware to execute in software like the actual hardware itself.

Essentially, the cloud is a set of physical servers in one or more datacenters. The datacenters execute virtualized hardware for customers. So how does the cloud create, start, stop, and delete millions of instances of virtualized hardware for millions of customers simultaneously?

To understand the servers, let's look at the architecture of hardware in the datacenter. Inside each datacenter, there's a collection of servers sitting in server racks. Each server rack contains many server blades, and a network switch. These provide network connectivity and a power distribution unit (PDU), which creates power. Racks are sometimes grouped together in larger units known as clusters.

The server racks, or clusters, are chosen to run virtualized hardware instances for the user. However, some servers run cloud management software, known as a fabric controller. The fabric controller is a distributed application with many responsibilities. It allocates services, monitors the health of the server and the services running on it, and heals servers when they fail.

Each instance of the fabric controller is connected to another set of servers running cloud orchestration software, typically known as the front end. The front end hosts the web services, RESTful APIs, and internal Azure databases, which are used for all functions in the cloud.

For example, the front end hosts the services that handle customer requests. The requests allocate Azure resources and services such as [Azure Virtual Machines](/azure/virtual-machines/), and [Azure Cosmos DB](/azure/cosmos-db/introduction). First, the front end validates and verifies if the user is authorized to allocate the requested resources. If so, the front end checks a database to locate a server rack with sufficient capacity, which instructs the fabric controller to allocate the resource.

Azure is a huge collection of servers and networking hardware, which runs a complex set of distributed applications. These applications orchestrate the configuration and operation of virtualized hardware and software on those servers. The orchestration of these servers is what makes Azure so powerful. With Azure, users don't have to maintain and upgrade their hardware as Azure does this behind the scenes.

## Next steps

Learn about how resources are deployed in Azure with the Azure Resource Manager.

> [!div class="nextstepaction"]
> [Microsoft Cloud Adoption Framework for Azure](how-azure-resource-manager-works.md)
