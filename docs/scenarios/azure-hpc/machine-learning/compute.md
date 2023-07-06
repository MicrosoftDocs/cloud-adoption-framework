---
title: Introduction to the Azure high-performance computing (HPC) adoption scenario
description: As an IT Professional, I want to find guidance in the Cloud Adoption Framework covering the end-to-end scenario for using Azure High-performance computing (HPC) as part of my IT strategy.
author: Rajani-Janaki-Ram
ms.author: erd
ms.date: 09/15/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Compute for Machine Learning on HPC

Choosing the right SKU for Machine Learning model is important to performance and controlling costs. Microsoft offers many different SKUs that are optimized for workloads that benefit from more GPU power. There are several considerations when choosing the right SKU for machine learning workloads. Smaller workloads may only take advantage of a fraction of the CPU, GPU and bandwidth of more powerful SKus like NDv4. You may want to consider other compute SKUs such as NCv4 and NDv2 for smaller jobs. Here are some considerations when choosing the right SKU for machine learning workloads:

- Checkpointing. Consider factors such as the checkpoint interval when running you machine learning models. This can impact the GPU performance during the training phase. Strike a balance between storage efficiency and maintaining smooth GPU operations. Monitor your GPU usage.
- Inferencing. Inferencing requirements differ from training requirements, with a possible higher CPU load that can max out the CPU performance. Consider the inferencing requirements of your model when selecting a compute SKU. Monitor your CPU usage.
- Training. Consider the requirements of your model during training, monitoring the CPU GPU usage.
- Job Sizing. When considering the compute SKU for your machine learning models, consider the size of the job. Smaller jobs, such as those with OPT 1.3B may not take advantage larger SKU sizes and may leave CPU and GPU power idle depending on the stage of the job (inferencing, training).
- Bandwidth. Larger, lower latency bandwidth can be an expense when not utilized. Consider InfiniBand for only the largest models that will require the extra bandwidth.

View our GPU optimized SKUs [here](https://learn.microsoft.com/azure/virtual-machines/sizes-gpu)

- [Landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
