---
title: Monitor cloud compliance
description: Learn to monitor compliance to measure governance over time. Automate monitoring and alerting for rapid remediation of noncompliance.
author: larzstridh
ms.author: pnp
ms.date: 05/22/2025
ms.topic: concept-article
ms.custom: internal, UpdateFrequency2
---
# Monitor cloud compliance

Monitoring is about continuously measuring how well the cloud environment complies with your governance policies and detecting when it drifts out of compliance. Effective monitoring lets you verify the impact of your governance efforts, provides visibility into risk levels, and triggers remediation processes promptly when needed. This stage involves configuring the right telemetry, alerts, and review processes to keep governance on track.

:::image type="content" source="./images/monitor.png" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document your cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up and to continuously maintain cloud governance." lightbox="./images/monitor.png" border="false":::

After you enforce cloud governance, perform an initial baseline assessment of compliance. See which policies are being met and where there are gaps. Then track these metrics over time. The ultimate goal is to drive non-compliance to zero or as close as practical by iteratively improving policies and enforcement where monitoring shows issues.

## 1. Configure cloud governance monitoring

Implement monitoring solutions to track compliance with your cloud governance policies. The goal is to have visibility on the teams responsible for enforcing compliance so you can remediate noncompliance quickly. To configure governance monitoring, follow these recommendations:

1. **Use monitoring tools.** Choose compliance monitoring tools that offer real-time monitoring capabilities. Ensure they can monitor compliance with your specific governance policies. Collect the metrics and logs as required for governance monitoring. Review the [visibility](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-platform) and [monitoring](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor) recommendations in the Azure landing zone management design area.

2. **Manually monitor where necessary.** Review compliance manually where automated monitoring mechanisms aren’t available.

3. **Document monitoring solution.** Track how you're monitoring each cloud governance policy so you know where to gather compliance data. In the cloud governance policy, list the monitoring tool, such as Azure Policy or Microsoft Purview. If there's a manual approach, list the audit frequency.

4. **Centralize governance monitoring.** Use or build a solution that allows you to view the status of cloud governance compliance in one place. For example, the [Azure governance workbook](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.costmanagement/governance-workbook) centralizes many Azure governance monitoring services.

5. **Establish a compliance baseline.** Evaluate how compliant your cloud environment is to your cloud governance policies. Make that your baseline. Track progress against the baseline over time.

6. **Provide access to governance monitoring.** Configure the appropriate level of access to governance monitoring results so the teams responsible for governance can evaluate the effectiveness of enforcement controls.

7. **Audit monitoring effectiveness.** Manually review compliance reports and resources to validate monitoring effectiveness. For example, ensure tags are receiving the right values and not an undesired value, such as *NA*.

### Azure facilitation: Configuring cloud governance monitoring

The following guidance is meant to help you configure cloud governance monitoring in Azure. It provides a sample starting point for major categories of cloud governance. Consider aggregating these signals in the [Azure governance workbook](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.costmanagement/governance-workbook). To configure cloud governance monitoring, you need an Azure identity that has permissions to gather monitoring data from your subscriptions.

#### Configure monitoring for regulatory compliance governance

- **Use compliance dashboards.** [Get policy compliance data](/azure/governance/policy/how-to/get-compliance-data) on the policies you assigned.

- **Determine compliance.** Use the compliance data to [determine causes of noncompliance](/azure/governance/policy/how-to/determine-non-compliance).

#### Configure monitoring for security governance

- **Use security governance monitoring.** [Review security recommendations](/azure/defender-for-cloud/review-security-recommendations) and monitor security governance over time with your [secure score.](/azure/defender-for-cloud/secure-score-security-controls) The feature provides a dashboard to monitor [regulatory compliance](/azure/defender-for-cloud/regulatory-compliance-dashboard) against common security frameworks.

- **Configure identity governance monitoring.** [Configure identity monitoring](/entra/identity/monitoring-health/overview-monitoring-health) to collect audit, sign-in, and provisioning logs. Also review your [identity secure score](/entra/identity/monitoring-health/concept-identity-secure-score), and use [the identity governance dashboard](/entra/id-governance/governance-dashboard) to get a single view of identities across your tenant.

#### Configure monitoring for cost management governance

- **Analyze cloud costs.** Conduct a [cost analysis](/azure/cost-management-billing/costs/quick-acm-cost-analysis) in Azure to gain full visibility into your cloud costs.

- **Create budgets.** [Create a budget](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) that aligns with your desired investment in the cloud.

- **Gather cost data.** Use [cost optimization recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) and the [cost optimization workbook](/azure/advisor/advisor-workbook-cost-optimization) to guide cost management efforts, such as detection of idle resources. [Identify anomalies and unexpected changes in cost](/azure/cost-management-billing/understand/analyze-unexpected-charges).

#### Configure monitoring for operations governance

- **Monitor policies on cloud operations.** Use Azure Policy to track compliance with governance policies that apply to operations.

- **Monitor logs and metrics.** To track [availability](/azure/azure-monitor/app/availability) and [performance](/azure/azure-monitor/app/failures-performance-transactions), analyze [logs](/azure/azure-monitor/logs/log-analytics-overview) and [metrics](/azure/azure-monitor/metrics/analyze-metrics) across cloud environments.

- **Monitor resource optimization.** [Use Azure Advisor](/azure/advisor/advisor-overview#what-is-advisor) to monitor Azure resources for reliability, security, operational excellence, performance, and cost. [Set alerts](/azure/advisor/advisor-alerts-portal) for any new Advisor recommendations.

- **Monitor resource health.** [Monitor the health of Azure services](/azure/service-health/overview) and monitor service-impacting events, planned maintenance, and other changes that might affect availability.

#### Configure monitoring for data governance

- **Monitor data governance.** [Monitor data compliance, management, and usage](/purview/legacy/concept-insights).

- **Use dashboards.** Use dashboards to monitor compliance with any data plane policies.

#### Configure monitoring for resource management governance

- **Monitor policies on resource management.** Monitor compliance with cloud governance policies that apply to resource deployments, such as tag enforcement policies.

#### Configure monitoring for AI governance

- **Monitor AI system outputs.** Use Azure for [abuse monitoring](/azure/ai-foundry/openai/concepts/abuse-monitoring) and [content filtering](/azure/ai-foundry/foundry-models/concepts/content-filter) of AI systems.

- **Red team AI systems.** Regularly [red team language models](/azure/ai-foundry/openai/concepts/red-teaming) to find harmful outputs. Use both manual tests and automated tools to review the risk baseline.

## 2. Configure cloud governance alerts

Configure alerts based on specific compliance metrics or events that indicate a deviation from your governance policies. To configure cloud governance alerts, follow these recommendations:

1. **Use cloud-native alerting mechanisms.** Prefer cloud-native tools that provide real-time monitoring and alerts for compliance problems.

2. **Define noncompliance.** Define clear thresholds and baselines for noncompliance. Set alerts when data exceeds these thresholds or when unexpected changes occur that could indicate noncompliance.

3. **Route alerts appropriately.** Send alerts to the appropriate team or individual responsible for enforcing compliance with cloud governance policies.

4. **Include noncompliance information in alerts.** Configure alerts to include detailed information about the noncompliance event. Ideally include the policy violated, affected resources, and suggested remediation.

### Azure facilitation: Configuring cloud governance alerts

The following guidance helps you start configuring cloud governance alerts in Azure. It provides a sample starting point for major categories of cloud governance.

- **Regulatory compliance governance alerts.** Use Azure activity logs to [generate alerts](/azure/governance/policy/how-to/get-compliance-data#azure-monitor-logs) for noncompliance across Azure.

- **Security governance alerts.** Configure [security alerts](/azure/defender-for-cloud/manage-respond-alerts) and noncompliance [alerts](/azure/governance/policy/how-to/get-compliance-data#azure-monitor-logs).

- **Cost governance alerts.** Set up alerts to notify teams of potential cost overruns and spending anomalies. Configure [cost alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending) and [cost anomaly alerts](/azure/cost-management-billing/understand/analyze-unexpected-charges#create-an-anomaly-alert). Set [reservation utilization alerts](/azure/cost-management-billing/costs/reservation-utilization-alerts) to keep reservations and savings plans usage at or close to full usage.

- **Operations governance alerts.** [Configure alerts](/azure/azure-monitor/alerts/alerts-overview) on specific logs and metrics. [Set alerts](/azure/advisor/advisor-alerts-portal) for new recommendations aligned to reliability and performance. Configure service health alerts to get notified of current and upcoming service health problems. Configure [resource health alerts](/azure/service-health/resource-health-alert-monitor-guide) to get notified of the current and historical health status of your Azure resources.

- **Data governance alerts.** [Configure data governance alerts](/defender-xdr/alert-policies) to report data governance violations.

- **Resource management governance alerts.** Configure alerts for when a noncompliance resource deploys. For example, use build warnings in your deployment pipeline or monitor noncompliance states.

- **AI governance alerts.** Configure alerts when there are harmful inputs and outputs in your AI systems. For example, monitor emails from Azure OpenAI that notify you of [abusive behavior](/azure/ai-foundry/openai/concepts/abuse-monitoring).

## 3. Develop a remediation plan

Develop a targeted action plan to address any noncompliance events. When you detect noncompliance, perform the remediation plan to correct the deviations and minimize the risk and impact. Add the remediation details to the cloud governance policy for easy access. Follow these recommendations:

1. **Discuss remediation timeline.** Negotiate a timeline for remediation depending on risk priority. The team responsible for compliance must remediate compliance in a timely manner.

2. **Remediate high-risk violations quickly.** For noncompliance alerts that are high risk, such as an exposed data endpoint, have a plan to escalate and fix those noncompliance problems. Update the policy enforcement mechanism to avoid a repeat of this high-risk violation. Use Azure to [react to compliance-state changes](/azure/governance/policy/concepts/event-overview), [remediate resources noncompliant with policies](/azure/governance/policy/how-to/remediate-resources), and [remediate security recommendations](/azure/defender-for-cloud/implement-security-recommendations).

3. **Follow up on low-risk violations.** Have an audit-first stance on low-risk policies so that you can have a discussion with the team that violated the cloud governance policy, such as deploying a service on a blocklist. Maybe there’s a new feature available, better service tier (SKU), or a better price in a specific region. The cloud governance team should discuss the needs of the team and adjust policies and enforcement mechanisms in accordance with the conversation.

4. **Automate remediation where possible.** Set up automated workflows that not only notify the relevant teams but also initiate predefined remediation processes where appropriate. This solution is primarily for known high-risk solutions that you can’t prevent with automation.

5. **Update governance policies and enforcement mechanisms.** Based on the insights gained from the noncompliance event, update your governance policies and enforcement mechanisms. Updates might involve tightening policy definitions, enhancing monitoring capabilities, or refining alert thresholds to improve detection and response times.

## 4. Audit cloud governance regularly

Even with automated monitoring, conduct periodic manual reviews and audits to validate compliance monitoring processes and ensure that automation tools are functioning correctly. To audit cloud governance, follow these recommendations:

1. **Conduct internal audits.** Conduct regular internal audits to assess compliance with governance policies.

2. **Conduct external audits.** Engage external auditors as required to validate compliance with legal and regulatory requirements. Ensure that you consult with legal experts to confirm that your governance policies are in accordance with the applicable laws and regulations in your region.

## Next steps

Cloud governance is an ongoing process that requires continuous attention. Consistently repeat the governance process of assessing risks, documenting governance policies, enforcing those policies, and monitoring the effectiveness of the enforcement. The cloud governance team should also work through the cloud governance process whenever they identify new cloud risks.

> [!div class="nextstepaction"]
> [Cloud Adoption Framework overview](/azure/cloud-adoption-framework/)
