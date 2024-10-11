---
title: Networking for AI workloads on Azure infrastructure
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Networking for AI workloads on Azure infrastructure

Networking for AI workloads involves setting up Azure infrastructure to support efficient data flow, performance, and scalability across distributed AI systems. Designing a well-optimized network can enhance data processing speed, reduce latency, and ensure the network infrastructure scales alongside growing AI demands.

## Ensure sufficient bandwidth

Sufficient bandwidth refers to the capacity of a network to handle large volumes of data without delays or interruptions. High bandwidth ensures fast, uninterrupted data transfer between on-premises systems and Azure, supporting rapid AI model training and reducing downtime in the pipeline. For organizations transferring large datasets from on-premises to the cloud for AI model training, a high-bandwidth connection is essential. Use Azure ExpressRoute to establish a dedicated, secure, and reliable high-speed connection between your on-premises network and Azure. This ensures seamless data transfer, reducing bottlenecks in the model training pipeline.

## Minimize latency

Minimizing latency involves reducing delays in data transfer between networked resources. Lower latency provides quicker data processing, enabling real-time insights, and improving the performance of latency-sensitive applications.

- *Optimize resource placement.* To minimize latency for AI workloads, such as data preprocessing, model training, and inference, deploy Virtual Machines (VMs) within the same Azure region or availability zone. Co-locating resources reduces physical distance, thus improving network performance.
  
- *Use proximity placement groups (PPGs).* For latency-sensitive applications requiring real-time processing or fast inter-process communication, utilize PPGs to physically co-locate resources within an Azure datacenter. PPGs ensure that compute, storage, and networking resources remain close together, minimizing latency for demanding workloads.
  
- *Use pre-configured Linux OS images.* Simplify cluster deployment by selecting Linux OS images from the Azure Marketplace pre-packaged with InfiniBand drivers, NVIDIA drivers, communication libraries, and monitoring tools. These images are optimized for performance and can be deployed with Azure CycleCloud for fast, efficient cluster creation.

## Implement high-performance networking

High-performance networking utilizes advanced networking features to support large-scale, intensive AI computations, particularly for GPU-accelerated tasks. High-performance networks ensure rapid, efficient data exchanges between GPUs, which optimizes model training and accelerates AI development cycles.

- *Utilize InfiniBand for GPU workloads.* For applications dependent on GPU acceleration and distributed training across multiple GPUs, use Azure's InfiniBand network. InfiniBand’s GPUDirect RDMA capability supports direct GPU-to-GPU communication, improving data transfer speed and model training efficiency.
  
- *Choose Azure’s GPU-optimized VMs.* Select VMs that use InfiniBand, such as ND-series VMs, which are specifically designed for high-bandwidth, low-latency inter-GPU communication. This configuration is essential for scalable distributed training and inference, allowing faster data exchange between GPUs.

## Optimize for large-scale data processing

Optimizing for large-scale data processing involves strategies to manage extensive data transfers and high computational loads. By using data and model parallelism, you can scale their AI workloads effectively, enhancing processing speed and using Azure’s GPU-optimized virtual machines to handle complex, data-intensive AI applications.

- *Apply data or model parallelism techniques.* To manage extensive data transfers across multiple GPUs, implement data parallelism or model parallelism depending on your AI workload needs. Ensure the use of High Bandwidth Memory (HBM), which is ideal for high-performance applications due to its high bandwidth, low power consumption, and compact design. HBM supports fast data processing, essential for AI applications that require processing large datasets.

- *Use advanced GPU networking features.* For demanding AI scenarios, choose Azure VMs like NDH100v5 and NDMI300Xv5. These VMs come with dedicated 400 Gb/s NVIDIA Quantum-2 CX7 InfiniBand connections, which are automatically configured within virtual machine scale sets. These connections support GPUDirect RDMA, enabling direct GPU-to-GPU data transfers that reduce latency and enhance overall system performance.

## Next step

> [!div class="nextstepaction"]
> [IaaS AI security](./security.md)
