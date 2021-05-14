# Managing budgets, costs, and quota for Azure ML at organizational scale

When managing compute cost incurring from Azure Machine Learning on an organization scale with many workloads, many teams, and users, there are numerous management and optimization challenges to work through.

In this article we present best practices in optimizing costs, managing budgets, and sharing quota with Azure Machine Learning reflecting on the experience and lessons learnt from running machine learning teams internally at Microsoft and while partnering with our customers. You'll learn how to:

- [Optimize compute resources to meet workload requirements.](#_Optimizing_compute_to)
- [Drive the best utilization of a team's budget.](#_Drive_best_utilization)
- [Plan, manage and share budgets, cost, and quota at an Enterprise-scale](#_Plan,_manage_and).

## Optimizing compute to meet workload requirements

When starting a new machine learning project, explorative work might be needed to get a good picture of compute requirements. This section provides recommendations on what you as an individual ML practicioner can do to determine the right VM SKU choice for training, for inferencing, or as a workstation to work from.

### Determining the compute size for training

Hardware requirements for your training workload might vary from project to project. To meet these varying requirements, Azure Machine Learning Compute [offers various types](https://docs.microsoft.com/azure/machine-learning/concept-compute-target#supported-vm-series-and-sizes) of VMs:

- General purpose- balanced CPU to memory ratio.
- Memory optimized- high memory to CPU ratio.
- Compute optimized- high CPU to memory ratio.
- High performance compute- deliver leadership-class performance, scalability, and cost efficiency for various real-world HPC workloads.
- Instances with GPUs.

When you do not have a good idea yet about what your compute requirements are, we recommend to start with either of the two default options below which are cost effective options for light weight testing and for training workloads.

| **Type** | **Virtual machine size** | **Specs** |
| --- | --- | --- |
| CPU | Standard\_DS3\_v2 | 4 cores, 14GB RAM, 28GB storage |
| GPU | Standard\_NC6 | 6 cores, 56GB RAM, 380GB storage, NVIDIA Tesla K80 GPU |

Getting the best VM size for your scenario may consist of trial and error. Here are several aspects to consider.

- If you need a CPU:
  - Use a [memory optimized](https://docs.microsoft.com/azure/virtual-machines/sizes-memory) VM if you are training on very large datasets.
  - Use a [compute optimized](https://docs.microsoft.com/azure/virtual-machines/sizes-compute) VM if you are doing real-time inferencing or other latency sensitive tasks.
  - Use a VM with additional cores and/or RAM in order to speed up training times.
- If you need a GPU:
  - Use a VM with a faster GPU in order to speed up training times. Here is the list of GPU-enabled VM families in order of speed:
    1. [NC-series](https://docs.microsoft.com/azure/virtual-machines/nc-series) (Nvidia Tesla K80)
    2. [NV-series](https://docs.microsoft.com/azure/virtual-machines/nv-series) (Nvidia Tesla M80)
    3. [ND-series](https://docs.microsoft.com/azure/virtual-machines/nd-series) (Nvidia Tesla P40)
    4. [NCv2-series](https://docs.microsoft.com/azure/virtual-machines/ncv2-series) (Nvidia Tesla P100)
    5. [NCv3-series](https://docs.microsoft.com/azure/virtual-machines/ncv3-series) (Nvidia Tesla V100)
    6. [NDv2-series](https://docs.microsoft.com/azure/virtual-machines/ndv2-series) (Nvidia Tesla V100 with NVLink connections)
    7. [NCasT4\_v3-series](https://docs.microsoft.com/azure/virtual-machines/nct4-v3-series) (Nvidia Tesla T4)
  - If you are doing distributed training, use VM sizes that have multiple GPUs.
  - If you are doing distributed training on multiple nodes, use GPUs that have NVLink connections.

While selecting the VM type and SKU that best fits your workload, evaluate comparable VM SKUs as a trade off between CPU and GPU performance and pricing. From a cost management perspective, a job might run reasonably well on several SKUs.

Certain GPUs such as NC family, particularly NC\_Promo SKUs have similar abilities to other GPUs such as low latency and ability to manage multiple computing workloads in parallel, however they are offered at discounted prices compared to some of the other GPUs. Considerately selecting VM SKUs to the workload might save cost significantly in the long run.

A reminder on the importance for utilization – signing up for a greater number of GPUs does not necessarily runs faster results. Instead, make sure the GPUs are fully utilized. For example, double check the need for NVIDIA CUDA. While it might be required for high-performance GPU execution, your job might not take a dependency on it.

### Determining the compute size for inference

Compute requirements for inference scenarios differ from training scenarios. Available options differ based on whether your scenario demands offline inference in batch or requires online inference in real-time.

For real-time inference scenarios consider the following:

- Make use of [profiling capabilities](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-profile-model?pivots=py-sdk) on your model with Azure Machine Learning to determine how much CPU and memory you will need to allocate for the model when deploying it as a web service.
- If you are doing real-time inference but don't need high availability, deploy to [Azure Container Instances](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-azure-container-instance) (no SKU selection)
- If you are doing real-time inference but need high availability, deploy to [Azure Kubernetes Service](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-azure-kubernetes-service?tabs=python)
  - If you are using traditional ML models and receve \&lt; 10 queries/second, start with a CPU SKU. F-series SKUs often work well.
  - If you are using deep learning models and receive \&gt; 10 queries/second, try an NVIDIA GPU SKU (NCasT4\_v3 often works well) [with Triton](https://aka.ms/triton-aml-docs)

For batch inference scenarios consider the following:

- When using Azure Machine Learning pipelines for batch inferencing, follow the guidance under 'Determining the compute size for training' to choose your initial VM size.
- Optimize cost and performance by scaling horizontally. One of the key methods of optimizing cost and performance is by parallelizing the workload with the help of [Parallel Run Step](https://docs.microsoft.com/python/api/azureml-pipeline-steps/azureml.pipeline.steps.parallelrunstep?view=azure-ml-py) in Azure Machine Learning. This pipeline step allows you to use many smaller nodes to execute the task in parallel, hence allowing you to scale horizontally. There is an overhead for parallelization though, so depending on the workload and the degree of parallelism that can be achieved, this may or may not be an option.

### Determining the compute type and size for data preparation [TODO]

If you are leveraging attached Synapse Apache Spark pools to do data preparation, it will use memory optimized Spark pools. Usage of Spark pools is billed by rounding up to the nearest minute.

| **Type** | **Price** | **Free Quantity** |
| --- | --- | --- |
| Memory Optimized | $0.143 per vCore-hour | 120 free vCore-hours per month until July31, 2021\* |

\*Free quantities apply only to the follow subscription types: Pay-As-You-Go, Microsoft Azure Enterprise, Microsoft Azure Plan, Azure in CSP, Enterprise Dev/Test. These included free quantities aggregate at the enrollment level for enterprise agreements and at the subscription level for pay-as-you-go subscriptions.

### Determine the size for Compute Instance compute

For interactive development, Azure Machine Learning's Compute Instance (CI) compute type is recommended to use. The CI offering brings single node compute that is bound to a single user and can hence be used as a workstation replacement.

Some organizations disallow the use of production data on local workstations, have enforced restrictions to the workstation environment, or restrict the installation of packages and dependencies in the Corporate IT environment. Compute Instance can be used as a workstation to overcome the limitation, offering a secure environment with production data access, and running on images that come with popular packages and tools for data science pre-installed.

Compute Instances are only billed when running. To save on cost, users are recommended to:

- Start and stop the Compute Instance when not used.
- Work with a sample of your data on compute instance and scale out to compute clusters to work with your full set of data.
- Submit experimentation jobs in 'local' compute target mode on the Compute Instance while developing or testing, while switching to shared compute cluster capacity when submitting jobs at full scale (many epochs, full set of data, hyperparameter search, etc.)

_Note that stopping the CI stops billing for compute hours, but not billing for disk and load balancer._

### Tune the chosen VM size by monitoring compute utilization

You can view information on your Azure Machine Learning compute usage and utilization via Azure Monitor. You can view details on model deployment and registration, quota details such as active and idle nodes, run details such as cancelled and completed runs, as well as compute utilization for GPU and CPU utilization.

Based on the insights from the monitoring details, you can better plan or adjust your resource usage across the team. For example, if you notice a lot of idle nodes over the past week, you can work with the corresponding workspace owners to update the compute cluster configuration to prevent this additional cost. Benefits of analyzing the utilization patterns can help with forecasting costs and budget improvements.

You can access these metrics directly from the Azure Portal. Simply go to your Machine Learning Workspace, and select 'Metrics' under the monitoring section on the left panel. Then, you can select details on what you would like to view, such as metrics, aggregation, and time period. For more information, you can refer to the [Monitor Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/monitor-azure-machine-learning) documentation page.

![Azure Monitor metrics for Azure Machine Learning](media/ai-machine-learning-azuremonitor-metrics.png)

### Switch between local, single-node and multi-node cloud compute while developing

To meet the varying compute, and tooling requirements throughout the machine learning lifecycle, Azure Machine Learning can be interfaced with through an SDK and CLI interface from practically any preferred workstation configuration.

To save cost and work productively, it is recommended to:

- Clone your experimentation code base locally by using Git and submit jobs to cloud compute using the Azure Machine Learning SDK or CLI.
- If your dataset is large, consider managing a sample of your data on your local workstation, while keeping the full dataset on cloud storage.
- Parameterize your experimentation code base so that you can configure your jobs to run with a varying number of epochs or on datasets of different size.
- Do not hard code the folder path of your dataset, so that you can easily reuse the same code base with different datasets, and under local and cloud execution context.
- Bootstrap your experimentation jobs in 'local' compute target mode while developing or testing, while switching to shared compute cluster capacity when submitting jobs at full scale.
- If your dataset is large, work with a sample of data on your local or Compute Instance workstation, while scaling to cloud compute in Azure Machine Learning to work with your full set of data.
- When your jobs take long to execute, consider optimizing your code base for distributed training to allow for scaling out horizontally.
- Design your distributed training workloads for node elasticity, to allow flexible use of single-node and multi-node compute, and ease usage of preemptible compute.

### Combine compute types using Azure Machine Learning Pipelines

When orchestrating your machine learning workflows, you can define a pipeline with multiple steps. Each step in the pipeline can run on its own compute type, so you can optimize performance and cost to meet varying compute requirements across the machine learning lifecycle.

## Driving best utilization of a team's budget

While budget allocation decisions might be out of the span of control of an individual team, a team is typically empowered to utilize their allocated budget to their best needs. By trading off job priority versus performance and cost wisely, a team can achieve higher cluster utilization, lower overall cost, and utilize a larger number of compute hours from the same budget, resulting in enhanced team productivity.

### Optimizing costs of shared compute resources

The key to optimizing costs of shared compute resources is to ensure that these are being used to their full capacity. Here are some tips to do this:

1. When using compute instances, only turn them on when you have code to execute (i.e. shut them down when they are not being used).
1. When using compute clusters, set the minimum node count to 0 and the maximum node count to a number that is evaluated based on your budget constraints. Use [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to calculate the cost of full utilization of one VM node of your chosen VM SKU. Auto-scaling will scale down all the compute nodes when there is no one using it and only scale up to the number of nodes you have budget for.
[azureml.core.compute.amlcompute.ScaleSettings class - Azure Machine Learning Python | Microsoft Docs](https://docs.microsoft.com/python/api/azureml-core/azureml.core.compute.amlcompute.scalesettings?view=azure-ml-py)
1. Monitor your resource utilizations (CPU utilization, GPU utilization, etc) when training models. If the resources aren't being fully utilized, modify your code to better utilize resources or scale down to smaller/cheaper VM sizes.
1. Evaluate whether you can create shared compute resources for your team to avoid compute inefficiencies caused by cluster scaling operations.
1. Optimize compute cluster auto-scaling timeout policies based on usage telemetry.
1. Use workspace quotas to control the amount of compute resources that individual workspaces have access to.

### Introduce scheduling priority by creating clusters for multiple VM SKUs

Acting under quota and budget constraints, a team must trade off timely execution of jobs versus cost, to ensure important jobs run timely and a budget is best utilized.

To support best compute utilization, teams are recommended to create clusters of various sizes and with 'low priority' and 'dedicated' VM priorities. Low-priority compute make use of surplus capacity in Azure and hence come with discounted rates. On the downside, these machines can be preempted any time a higher priority ask comes in.

Using the clusters of varying size and priority, a notion of scheduling priority can be introduced. For instance, when experimental and production jobs compete for the same 'NC' GPU-quota, a production job might have preference to run over the experimental job. In that case, run the production job on the dedicated compute cluster, and the experimental job on the low priority compute cluster. When quota fall short, the experimental job will be preempted in favor of the production job.

Next to VM priority, consider running jobs on various VM SKUs. It might be that a job takes longer to execute on a VM instance with a P40 GPU than on a V100 GPU. However, since V100 VM instances might be occupied or quota fully utilized, the time to completion on the P40 might still be faster from a job throughput perspective. One could also consider running jobs with lower priority on less performant and cheaper VM instances from a cost management perspective.

### Early-terminate a run when training does not converge

When continuously experimenting to improve a model against its baseline, you might be executing various experiment runs, each with slightly different configurations. For one run, you might tweak the input datasets. For another run this might be a hyperparameter change. Not all changes, might be as effective as the other, and possibly it can be detected early that a change did not have the intended impact on the quality of your model training. In order to detect whether training does not converge, monitor training progress during a run. For instance, by logging performance metrics after each training epoch. Consider early terminating the job to free up resources and budget for another trial.

## Plan, manage and share budgets, cost, and quota at an Enterprise-scale

As an organization grows its number of machine learning use cases and teams, it requires an increased operating maturity from IT and Finance and coordination between individual machine learning teams to ensure efficient operations. Company-scale capacity and quota management becomes important to address scarceness of compute resources and overcome management overhead.

This section discusses best practices for planning, managing, and sharing budgets, cost, and quota at enterprise scale, based on learnings from managing a large number of GPU training resources for machine learning internally at Microsoft.

### Understanding resource spend with Azure Machine Learning

One of the biggest challenges as an administrator for planning compute needs is starting new with no historical information as a baseline estimate. On a practical sense, most projects will start from a small budget as a first step.

To understand where the budget is going, it is critical to know where the costs come from in Azure Machine Learning:

- Azure Machine Learning only charges for compute infrastructure used and does not add a surcharge on compute costs.
- When an Azure Machine Learning Workspace is created, there are also a few other resources created to enable Azure Machine Learning – Key Vault, Application Insights, Storage, and Azure Container Registry. These are used in Azure Machine Learning and you will pay for these resources.
- There are costs associated with managed compute – training clusters, compute instances, and managed inferencing endpoints. With these managed compute resources, there are the following infrastructure costs to account for – virtual machines, virtual network, load balancer, bandwidth, and storage.

### Govern and restrict compute usage by policy

When managing an Azure Environment with many workloads, it can be challenging to keep the overview on resource spend. [Azure Policies] can help control and govern resource spend, by restricting particular usage patterns across the Azure environment.

In specific for Azure Machine Leanring, we recommend setting up policies to allow only for usage of specific VM SKUs. This can help prevent and control selection of expensive VMs. Policies can also be used to enforce usage of low-priority VM SKUs.

### Allocate and manage quota based on business priority

Azure allows to set limits for quota allocation on a subscription and Azure Machine Learning workspace level. Restricting who can manage quota through [Azure RBAC](https://docs.microsoft.com/azure/role-based-access-control/overview) can help ensure resource utilization and cost predictability.

Availability of GPU-quota can be scarce across your subscriptions, or in some cases, at Azure Data Center level. To ensure high quota utilization across workloads, we recommend to monitor whether quota are best utilized and assigned across workloads.

At Microsoft, it is determined periodically whether GPU quotas are best utilized and allocated across machine learning teams by evaluating capacity needs against business priority.

### Commit capacity ahead of time

If you have a good estimate of how much compute will be used in the next year, or next few years, you can purchase Azure Reserved Instances at a discounted cost. There are one year or three-year purchase terms. Since Azure Reserved Instances are discounted, there can be significant cost savings compared to pay-as-you go prices.

Azure Machine Learning Compute supports reserved instances. Discounts are automatically applied against Azure Machine Learning managed compute.

### Manage data retention

Every time a pipeline is executed, intermediate datasets can be generated at each step for data caching and reuse. This could form a pain point for big organization with group of data scientists, running pipelines heavily.

Normally DS don't spend time cleaning up these intermediate datasets. Overtime it will pipeline up, makes it even more difficult to clean up without deleting useful data.

Storage team released one very relevant feature compared with Cosmos stream expiration in 2020: [Setting rules for Blob data retention](https://docs.microsoft.com/azure/storage/blobs/storage-lifecycle-management-concepts?tabs=azure-portal) Customers can set up general rules/policies to move data to cool/archive/delete categories to leverage Blob storage data deletion mechanisms there.

### Infrastructure cost optimization considerations

#### Networking

Azure networking cost is incurred from outbound bandwidth from Azure datacenter. All inbound data to Azure datacenter is free. Pricing can be found on this [page](https://azure.microsoft.com/pricing/details/bandwidth/). The key to reduce network cost is to deploy all your resources in the same datacenter region whenever possible. If you can deploy Azure Machine Learning workspace and compute in the same region that has your data, you can enjoy lower cost and higher performance.

You might want to have private connection between your on-premises network and your Azure network to have hybrid cloud environment. ExpressRoute enables you to do that but considering the high cost of ExpressRoute, it may be more cost effective to move away from a hybrid-cloud setup and move all resources to Azure cloud.

#### Azure Container Registry

For Azure Container Registry, the determining factors for cost optimization include:

- Required throughput for Docker image downloads from the Container registry to Azure ML.
- Requirements for enterprise security features such as Private link.

For production scenarios where high throughput or enterprise security is required, the Premium SKU of Azure Container Registry is recommended.

For dev/test scenarios where throughput and security are less critical, either Standard or Premium SKU is recommended.

The `Basic` SKU of Azure Container Registry is not recommended for Azure ML, because of its low throughput and low included storage, which can be quickly exceeded by Azure ML's relatively large sized (1+ GB) Docker images.

#### Consider compute type availability when choosing Azure regions

When picking a region for your compute, keep compute quota availability in mind. Popular and larger regions such as East US, West US and West Europe tend to have higher default quota values and greater availability of most CPUs and GPUs compared to some other regions with stricter capacity restrictions in place.

# Learn more

### Provide the right level of cost access

[Track costs across business units, environments, or projects - Cloud Adoption Framework | Microsoft Docs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/track-costs?branch=pr-en-us-1254#provide-the-right-level-of-cost-access)

### Additional cost management resources on Azure

[Track costs across business units, environments, or projects - Cloud Adoption Framework | Microsoft Docs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/track-costs?branch=pr-en-us-1254#additional-cost-management-resources)
