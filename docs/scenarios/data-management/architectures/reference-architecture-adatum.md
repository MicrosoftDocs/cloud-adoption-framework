# Enterprise-scale for analytics and AI scenario with one landing zone
The enterprise-scale for analytics and AI architecture is modular by design and allows organizations to start with foundational landing zones that support their data and analytics workloads, regardless of whether the projects are being migrated or are newly developed and deployed to Azure. The architecture enables organizations to start as small as needed and scale alongside their business requirements regardless of scale point.

## Customer profile
This reference architecture is ideal for customers that have identified a unit of their business that is ready to deploy analytics workloads to Azure.  This architecture deploys a single landing zone that can be used by the business unit to manage their data estate.  It provides the flexibility to add more landing zones for other business units when they are ready to move to Azure.

### Example customer
**Adatum Corporation** is a large, multinational enterprise. In addition to the centralized business units at their headquarters, they also have subsidiaries across the globe, each with its own business units such as accounting, marketing, sales, support, and operations.

All of these disparate groups are producing their own data.  Many of the business units have embedded analytics teams. The central IT organization has provided most of the data platform that is in use, but a few business units have gone rogue and implemented their own solutions.  The data platform is comprised of a variety of cloud services and on-premises solutions.

The company's vision is to have a centralized analytics platform, a single source of truth for all data. However, it has proven impossible to get so many different stakeholders to buy into one single technology. Given the rate at which new data is being created and new options become available, even early drafts of plans for centralization quickly become out-dated. Meanwhile, the corporate sales team has out-grown their current solution, and the company urgently needs to leverage new analytics to pursue a new market segment.

Adatum has decided to implement the enterprise-scale for analytics and AI architecture pattern in Azure to solve this problem.  The enterprise is confident that the ESA pattern will allow the corporate sales team to migrate their data platform today but still provide enough flexibility to accommodate other business units when they are ready to join the data mesh.

### Current situation
Adatum's corporate sales group uses traditional ERP and CRM systems to process its sales transactions.  Data from these systems needs to be exported to a separate analytics platform so that stakeholders across the organization can access the data and enrich it for their various projects.

## Architectural solution

In this reference architecture, we will deploy a Data Management Zone, which is needed for all ESA implementations, and a single Data Landing Zone, which can be used by the corporate sales department.

#### Data Management Zone
A critical concept for every enterprise-scale for analytics and AI implementation is having one Data Management Zone. This subscription contains resources that will be shared across all of the landing zones.  This includes shared networking components, like a firewall and private DNS zones.  It also includes resources for data and cloud governance, such as Azure Policies and Azure Purview.

#### Data Integrations
The landing zone will have two data integrations.  The first integration will ingest data related to customers.  This includes the customer records and their related records (like addresses, contacts, territory assignments, and contact history). This data will be imported from a Adatum's CRM system.

The second data integration will ingest sales transactions. This includes transaction headers, line item details, shipping records, and payments.  All of these records will be ingested from Adatum's ERP system.

Note that these integrations will not transform or enrich the data.  They only copy the data from the source systems and land it in the analytics platform.  This allows many data products to consume the data in a scalable manner without putting an additional burden on the source system.

#### Data Products
In this example, Adatum has one data product.  This product combines raw data from the two data integrations and transforms them into a new dataset. From there, it can be picked up by business users for additional analysis and reporting with tools like Power BI.

![Architectural Diagram](images/adatum.svg)
<!-- TODO: indicate subscriptions in the diagram-->
<br />
<sub>**Figure 1: Architectural Diagram**  Note that not all Azure services are represented in the diagram.  It has been simplified to accentuate the core concepts of how resources are organized within the architecture.</sub>

## Rationale
#### Why not put "Sales Transactions" and "Customers" in their own data landing zones?
One of the first decisions enterprises must make about their enterprise-scale for analytics and AI implementation is how to divide the entire data estate into landing zones.  Data solutions that will frequently communicate with one another are strong candidates for inclusion in the same landing zone.  This allows enterprises to reduce the costs associated with moving data across peered Vnets.  In this example, sales transaction data will very frequently be linked to customer data.  Therefore, it makes sense to store these related data integrations in the same data landing zone.

An additional consideration for landing zones is how the teams responsible for the data are aligned within the organization.  In this case, the two data integrations are owned by different teams, but those teams are both part of Adatum's sales and marketing division.

#### Why not let "Sales Transactions" and "Customers" share a single data integration?
By separating the customer data and the sales transaction data in their own data integrations, we allow the subject matter experts for those domains to make the best decisions for their particular data sets.  They can choose the access patterns, ingestion engines, and storage options that best meet their needs without conflicting with one another.

For example, the team that has expertise with the CRM system will be responsible for the "Customers" data integration.  Based on the team's skillset and the technologies used by the CRM system, they will decide which tools best suit their needs.  They will not have to worry if these decisions will also work for the "Sales Transactions" team.  That team will be using their own toolset and will not have to compromise to meet the requirements of the "Customers" team.

#### Why move only the sales team to the new data platform?
In this example, the corporate sales team is the first to move to the new enterprise-scale for analytics and AI platform.  The solution is designed to be scalable above all else.  As other business units are ready to migrate, additional landing zones can be added to accommodate their workloads.

## How to evolve later
Scaling is accomplished by adding more landing zones to the architecture.  These landing zones will use VNet peering to connect to the Data Management Zone and all of the other landing zones.  This mesh pattern allows datasets and resources to be shared across zones.  By splitting into different zones, the workloads are spread across Azure subscriptions and resources.  This allows enterprises to avoid reaching the limits of the Azure services and continuing to grow their data estates.

## Deployment guidelines

The customer scenario outlined above can be deployed by referencing the architectures below for Adatum Corporation's data management landing zone and data landing zone.

### Data Management Landing Zone

![Adatum Corporation Data Management Landing Zone](images/adatum-data-management-landing-zone.png)

### Sales Data Landing Zone

![Adatum Corporation Sales Data Landing Zone](images/adatum-sales-data-landing-zone.png)

### Deployment templates

The **reference implementation** templates in the following GitHub repositories should be used to deploy the above architectures:

- [Data Management Landing Zone template](https://github.com/Azure/data-management-zone)
- [Data Landing Zone template](https://github.com/Azure/data-landing-zone)

Additionally, Adatum Corporation's "Sales Transactions" and "Customers" data integrations and "Summary" data products should be deployed in the "Sales" Data Landing Zone using the following template:

- [Data Product Batch template](https://github.com/Azure/data-product-batch)

> [!IMPORTANT]
> Please keep in mind that not everything in the above reference implementation templates will need to be deployed to meet the needs of Adatum Corporation therefore some level of customization of these templates will be required. Hence, those services which are not required should be removed from the deployment templates prior to deployment.

## Next steps
 - [Learn about the data management zone](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/data-management/architectures/data-management-landing-zone)
 - [Learn about data landing zones](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/data-management/architectures/data-landing-zone)
 - Learn about [data integrations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/data-management/architectures/data-landing-zone-data-integration) and [data products](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/data-management/architectures/data-landing-zone-data-products)