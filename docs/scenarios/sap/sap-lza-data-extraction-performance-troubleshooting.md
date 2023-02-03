---
title: SAP Data Extraction - Performance and Troubleshooting
description: Learn more about the best practices on Performance & Troubleshooting for SAP Data Extraction with Azure connectors 
author: pankajmeshramCSA
ms.author: pankajmeshramCSA
ms.date: 16/01/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# SAP Data Integration- Performance and Troubleshooting on Azure

There are different ways to connect to SAP system for Data Integration. It is important to configure optimal settings on source and target side to achieve best performance during data extraction and processing. Following are generic and connector specific considerations and recommendations.

## Performance

### Generic Considerations

- Ensure right SAP parameters are set for Max concurrent connection.
- Consider using SAP logon group for better performance and load distribution.
- Ensure the SHIR virtual machine is sized adequately and is highly available
- When dealing with very large datasets, check if the connector you are using provide partitioning capability. Many of our SAP connectors support partitioning and parallelising capabilities to speed up data loads. This allow data to be packaged into many smaller chunks which may be loaded using several parallel processes. Check connector specific documentation for more details. ( TBD – high level guidance here )

### Generic Recommendations

- Use the transaction RZ12 to modify values for Max concurrent connections

   SAP Parameters for RFC - RZ12 **-** The following parameter can restrict the number of RFC calls allowed for one user / one application, so ensure this isn't causing a bottleneck.

   ![RZ12 transaction ](./media/sap-rfc.png)

   ![RZ12 transaction ](./media/sap-rfc-quotas.png)

- **Connection to SAP using Logon Group -** SHIR should connect SAP using an SAP Logon Group (via message server) and not to a specific application server to ensure workload distribution across all available application servers.

      > [!NOTE]
      > Even dataflow spark cluster and SHIR are very powerful, multiple internal SAP copy activities (for example, 16) can be triggered and executed. But if   SAP server's concurrent connection number is small (for example, 8), it will also impact the perf to read data from SAP side.

- The recommendation is to start with 4vCPUs and 16 GB VMs for SHIR. Here is the correction of Dialog work process in SAP with SHIR.

  1. Check whether customer is using poor physical machine to setup and online the SHIR to run internal SAP copy.
  2. Go to Azure Data Factory portal and find related SAP CDC linked service used in dataflow, then check referenced SHIR name.
  3. Check the CPU, Memory, Network, Disk settings of the physical machine where SHIR is installed.
  4. Check how many "diawp.exe" is running on the SHIR machine. Theoretically, one "diawp.exe" can run one copy activity. The number of "diawp.exe" is based on machine's CPU, Memory, Network and Disk settings.

   ![Task Manager showing Dialog work processes ](./media/dialogwp.png)

**Suggestion -** If you want to run multiple partitions in parallel on SHIR at the same time, please use powerful Virtual Machine to setup SHIR or use scale out using SHIR High Availability and Scalability feature to have multiple nodes. Please see the details here. [https://learn.microsoft.com/en-us/azure/data-factory/create-self-hosted-integration-runtime?tabs=data-factory#high-availability-and-scalability](https://learn.microsoft.com/en-us/azure/data-factory/create-self-hosted-integration-runtime?tabs=data-factory#high-availability-and-scalability)

## Partitioning

The partitioning process for SAP CDC connector is explained below and it works the same for SAP Table and SAP BW OpenHub connector as well.

![Data extraction resources  ](./media/sap-partition1.png)

There are two places where one can scale which is at Self Hosted IR & Azure IR. Customer should look at the CPU consumption of SHIR. They have the option of scale up and scale out for SHIR. Scaling out increase availability and resiliency. Should not start with huge IRs and scale up to a decent performance

> [!NOTE]
> If you are reaching up to 70% capacity, scale up or scale out for SHIR

![how the partitioning process works in SAP CDC connector ](./media/sap-partition2.png)

Partition is mostly useful for initial or large full loads and typically not required for Delta Loads. If you do not specify partition then by default 1 "producer" in the SAP system( typically one batch process) fetches the source data into ODQ queue and SHIR fetches the data from ODQ. By default SHIR uses 4 threads to fetch the data from ODQ which means that potentially four dialog processes would be occupied in SAP at a certain point of time.

The idea of partitioning is to split this large initial dataset into multiple smaller disjoint subsets of equal size (ideally) which can be processed in parallel thereby reducing the time to produce the data from the source table into ODQ in a linear way. ( provided that there are sufficient resources on the SAP side to handle the load)

> [!NOTE]
>- Number of partitions executed in parallel are limited by number of driver cores in the Azure IR. This is a current limitation and work is under progress to resolve it.
>- Each unit/package in ODQMON is a single file in staging folder.

### SAP Change Data Capture Connector

#### Design considerations when running the pipelines using CDC

- Consider checking SAP to Stage duration.
- Consider checking the runtime performance in the Sink.
- Consider performance optimization for better throughput using partitioning feature.
- If the SAP to stage duration is slow, consider resizing SHIR to higher specifications.

    ![SAP to Stage duration ](./media/sap-to-stage.png)

- Check the Sink Processing time and see if the runtime in the sink is too slow

    ![ Sink Processing ](./media/sink-processing.png)

    If a very small cluster is being used to run the Mapping Data Flow, this could affect the performance at sink. Please use big size cluster (for example, 16 + 256 cores) which will impact the perf of reading data from stage and writing into sink.

- For large data volumes we recommend partitioning the load into multiple partitions to run parallel jobs however keep the partition number less than or equal to Azure Integration runtime core ( aka Spark Cluster core).

    ![ Partitioning ](./media/sap-partition-azureir.png)

Use the Optimize tab to define the partitions. The option that one can use in the CDC connector for is source partitioning.

> [!NOTE]
>- There is a direct relation between the number of partitions with SHIR cores and Azure Integration runtime nodes.
>- SAP CDC connector listed as Odata subscriber type "Odata access for Operational Data Provisioning" under ODQMON in the SAP system,  because it is using  existing subscriber type Odata, instead of creating dedicated subscriber type for ADF/Synapse.

### SAP Table Connector

#### Design considerations when using Table connector

- Consider Optimizing The partitioning for better Performance
- Consider the degree of parallelism from SAP table.
- Consider Single file design for target Sink.
- Benchmarking the throughput when using large data volumes.

#### Design recommendations when using Table connector

- **Partitioning:** Partitioning in SAP table connector effectively splits one underlying select statement into several using where clauses on a suitable field (for example, a field with high cardinality). If your SAP table has a large volume of data, enable partitioning to split the data into smaller partitions. Try to optimize the number of partitions (parameter _maxPartitionsNumber_) such that the partitions are small enough to avoid memory dumps in SAP, but large enough to speed up extraction.

- **Parallelism:** Degree of copy parallelism (parameter _parallelCopies_) works in tandem with partitioning and instructs the SHIR to make multiple parallel    RFC calls to the SAP system. For example, if you set this parameter to four, the service concurrently generates and runs four queries based on your specified partition option and settings, and each query retrieves a portion of data from your SAP table.

     For optimum results, the number of partitions should be a multiple of number of the degree of copy parallelism.

     When copying data from SAP table to binary sinks, the actual parallel count is adjusted automatically based on the amount of memory available in SHIR. Therefore, it is recommended to record the SHIR VM size for each test cycle in addition to the degree of copy parallelism and the number of partitions. Observe the performance of SHIR VM, performance of source SAP system, desired vs actual degree of parallelism and use an iterative process to identify the optimum settings and the ideal size for SHIR VM considering all ingestion pipelines that will simultaneously load data from one or multiple SAP systems.

     Note the observed number of RFC calls to SAP against the configured degree of parallelism. If you observe that the number of RFC calls to SAP is less than the degree of parallism, verify that the SHIR virtual machine has enough memory and CPU resources available and choose a larger virtual machine if necessary. Another reason for this is that the source SAP system is configured to limit the number of parallel connections, this is explained in generic recommendations in this article.

- **Number of files:** When copying data into a file-based data store and the targeted sink is configured to be a folder, then multiple files are generated by default, but if you set the "fileName" property in the sink, the data will be written to a single file. It's recommended to write to a folder as multiple files to obtain a much higher write throughput compared to writing to a single file.

- **Performance benchmarking:** When it comes to ingesting large amounts of data, we recommend performance benchmarking exercise by varying different parameters such as partitioning, degree of parallelism, number of files to determine the optimum setting for the given architecture, volume and type of data. Gather data from various tests in following format.

     ![ Performance Benchmark ](./media/performance-benchmark.png)

## Troubleshooting

#### Considerations & Recommendations

- Design consideration for Troubleshooting when Extraction from the SAP system is slow or failing – Troubleshoot using SAP logs from SM37 & matching with telemetry in data factory.

Recommendations –

  - If only one Batch job is triggered, please set SAP source partitions to have performance improvement in the Mapping Data flow in the data factory. Please refer to point 6 in [Transform data from an SAP ODP source with the SAP CDC connector in Azure Data Factory or Azure Synapse Analytics - Azure Data Factory & Azure Synapse | Microsoft Learn](https://learn.microsoft.com/en-us/azure/data-factory/connector-sap-change-data-capture#mapping-data-flow-properties)

  - If multiple batch jobs are triggered in the SAP system and each batch job's start-time has big difference, please change the size of Azure Integration Runtime (IR). Increasing the number of driver nodes in Azure Integration Runtime will increase the parallelism of batch jobs in the SAP side.

      > [!NOTE]
      > Please note that the maximum number of driver nodes for Azure IR is 16 and one cannot go beyond that. Currently each driver node can only trigger one batch processes but this limitation might change in the future. This is a current limitation.

- Check the logs in SHIR - **Self-hosted Integration Runtime Virtual Machine.**

- **Viewing logs:** Go to SHIR Virtual machine and open Event viewer -\> Applications and service logs -\> Connectors -Integration runtime

- **Sending logs to support:** Go to SHIR vm -\> Integration Runtime configuration manager -\> Diagnostic -\> Send Logs. This will send the logs from last 7 days and provide you a "report ID". You will need this report ID and RunId of your run. DONT FORGET to copy the "Report ID" shown to you when you have sent it as you only see it once.

- When using SAP CDC connector with SLT Scenario

    - Ensure that all pre-requisites are met.
       SLT scenario - Roles required for the SLT user (eg ADFSLTUSER) in OLTP systems (eg ECC) for SLT replication to work. --\> [2658517 - What authorizations and roles are needed? - SLT](https://launchpad.support.sap.com/#/notes/2658517)

    - If you face errors using SLT scenario, please see the recommendations for analysis. 
       Isolate and test the scenario within SAP solution first, i.e. test it outside of ADF by running the test program provided by SAP **RODPS\_REPL\_TEST** in **SE38.** If the issue is on the SAP side, you will get the same error when using this report. You can further analyse the data extraction in SAP using transaction code **ODQMON**.

       If the replication works using this test report, but not with ADF, then contact the Azure / ADF support.

       Here is an example screenshot

       **SE38 --\> RODPS\_REPL\_TEST**

       ![ SAP Report RODPS_REPL_TEST  ](./media/rodps-repl-test.png)

       ![ SAP Report RODPS_REPL_TEST  ](./media/rodps-repl-test-1.png)

       ![ SAP Report RODPS_REPL_TEST  ](./media/rodps-repl-test-2.png)

       **Transaction code: ODQMON**

       ![ SAP transaction ODQMON  ](./media/odqmon.png)

    - ADF Linked Service connecting to SLT system doesn't show SLT Mass Transfer IDs when you refresh "Context"

       ![ ADF Linked Service  ](./media/adf-linked-service.png)

       In order to run the ODP/ODQ replication scenario for SAP LT Replication Server, activate the following BAdI (Business Add-In) implementation.

       BAdi : BADI\_ODQ\_QUEUE\_MODEL

       Enhancement Implementation : ODQ\_ENH\_SLT\_REPLICATION

       Activate it using the expert function "Activate / Deactivate BAdI Implementation" in transaction LTRC.

       ![ SAP transaction LTRC  ](./media/ltrc-1.png)

       ![ SAP transaction LTRC  ](./media/ltrc-2.png)

       ![ SAP transaction LTRC  ](./media/ltrc-3.png)

       ![ SAP transaction LTRC  ](./media/ltrc-4.png)



