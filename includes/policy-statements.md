<!-- TEMPLATE FILE - DO NOT ADD METADATA -->
<!-- markdownlint-disable MD002 MD041 -->

## Policy statements

The following policy statements establish the necessary requirements to remediate the defined risks. These policies define the functional requirements for the governance MVP. Each policy statement is represented in the implementation of the governance MVP.

Cost Management:

- For tracking purposes, you must assign assets to an application owner within one of the core business functions.
- When cost concerns arise, other governance requirements are established with the finance team.

Security Baseline:

- An asset that's deployed to the cloud must have an approved data classification.
- No assets identified with a protected level of data can be deployed to the cloud until sufficient requirements for security and governance are approved and implemented.
- Until the minimum network security requirements can be validated and governed, cloud environments are seen as perimeter networks and should meet similar connection requirements to other datacenters or internal networks.

Resource Consistency:

- No mission-critical workloads are deployed at this stage, so there are no SLA, performance, or BCDR requirements to govern.
- When mission-critical workloads are deployed, other governance requirements are established with IT operations.

Identity Baseline:

- Assets that are deployed to the cloud are controlled by using identities and roles that are approved by current governance policies.
- All groups in the on-premises Active Directory infrastructure that have elevated privileges should be mapped to an approved RBAC role.

Deployment Acceleration:

- Assets must be grouped and tagged according to defined grouping and tagging strategies.
- Assets must use an approved deployment model.
- After a governance foundation is established for a cloud provider, deployment tooling must be compatible with the tools that the governance team defines.

## Processes

No budget is allocated for ongoing monitoring and enforcement of these governance policies. So, the cloud governance team has improvised ways to monitor adherence to policy statements.

- **Education:** The cloud governance team invests time to educate the cloud adoption teams on the governance guides that support these policies.
- **Deployment reviews:** Before you deploy an asset, the cloud governance team reviews the governance guide with the cloud adoption teams.
