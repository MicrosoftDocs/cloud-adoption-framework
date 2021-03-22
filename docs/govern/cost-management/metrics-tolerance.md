---
title: Risk tolerance metrics and indicators in the Cost Management discipline
description: Use the Cloud Adoption Framework for Azure to quantify risk tolerance metrics and indicators for cost management in cloud governance.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Risk tolerance metrics and indicators in the Cost Management discipline

Learn to quantify business risk tolerance associated with the Cost Management discipline. Defining metrics and indicators helps to create a business case for investing in the maturity of this discipline.

## Metrics

Cost management generally focuses on metrics related to costs. As part of your risk analysis, you'll want to gather data related to your current and planned spending on cloud-based workloads to determine how much risk you face, and how important investment in your Cost Management discipline is for your planned cloud deployments.

The following are examples of useful metrics that you should gather to help evaluate risk tolerance within the Cost Management discipline:

- **Annual spending:** The total annual cost for services provided by a cloud provider.
- **Monthly spending:** The total monthly cost for services provided by a cloud provider.
- **Forecasted versus actual ratio:** The ratio comparing forecasted and actual spending (monthly or annual).
- **Pace of adoption (month-over-month) ratio:** The percentage of the delta in cloud costs from month to month.
- **Accumulated cost:** Total accrued daily spending, starting from the beginning of the month.
- **Spending trends:** Spending trend against the budget.

## Risk tolerance indicators

During early small-scale deployments, such as dev/test or experimental first workloads, cost management is likely to be of relatively low risk. As more assets are deployed, the risk grows and the business's tolerance for risk is likely to decline. Additionally, as more cloud adoption teams are given the ability to configure or deploy assets to the cloud, the risk grows and tolerance decreases. Conversely, developing a Cost Management discipline will take people from the cloud adoption phase to deploying more innovative technologies.

In the early stages of cloud adoption, you will work with your business to determine a risk tolerance baseline. Once you have a baseline, you will need to determine the criteria that would trigger an investment in the Cost Management discipline. These criteria will likely be different for every organization.

Once you have identified [business risks](./business-risks.md), you will work with your business to identify benchmarks that you can use to identify triggers that could potentially increase those risks. The following are a few examples of how metrics, such as those mentioned above, can be compared against your risk baseline tolerance to indicate your business's need to further invest in cost management.

- **Commitment-driven (most common):** A company that is committed to spending *$x,000,000* this year on a cloud vendor. They need a Cost Management discipline to ensure that the business doesn't exceed its spending targets by more than 20%, and that they will use at least 90% of their commitment.
- **Percentage trigger:** A company with cloud spending that is stable for their production systems. If that changes by more than *x%*, then a Cost Management discipline is a wise investment.
- **Overprovisioned trigger:** A company who believes their deployed solutions are overprovisioned. Cost management is a priority investment until they demonstrate proper alignment of provisioning and asset utilization.
- **Monthly spending trigger:** A company that spends over *$x,000* per month is considered a sizable cost. If spending exceeds that amount in a given month, they will need to invest in cost management.
- **Annual spending trigger:** A company with an IT R&D budget that allows for spending *$x,000* per year on cloud experimentation. They may run production workloads in the cloud, but they're still considered experimental solutions if the budget doesn't exceed that amount. If the budget is exceeded, they will need to treat the budget like a production investment and manage spending closely.
- **Operating expense-adverse (uncommon):** As a company, they're averse to operating expenses and will need cost management controls in place before deploying a dev/test workload.

## Next steps

Use the [Cost Management discipline template](./template.md) to document metrics and tolerance indicators that align to the current cloud adoption plan.

Review sample Cost Management policies as a starting point to develop your own policies to address specific business risks aligned with your cloud adoption plans.

> [!div class="nextstepaction"]
> [Review sample policies](./policy-statements.md)
