# Optimize post-modernization

Modernization is an ongoing process. Each iteration makes your cloud environment more efficient and easier to maintain. Over time, your applications will use more fully managed services, deployment frequency will increase, and operational incidents will decrease.

1. **Fine-tune configurations.** Azure provides flexibility to quickly adjust resources. Post-modernization, workloads may behave differently. Adjust configurations based on recommendations in their Azure service guides. Use Azure Advisor and Microsoft Defender for Cloud to receive tailored recommendations on cost optimization, performance, reliability, and security.

2. **Monitor costs.** Use Azure Cost Management to identify cost anomalies and Azure Advisor for relevant performance and reliability improvements. Compare current costs to your pre-modernization baseline. Identify and address any configuration or feature changes that increase costs.

5. **Update architecture.** Update your documentation to reflect the modernized system. Capture the current architecture, including all modernized components. update/refine documentation to ensure it aligns with the deployed environment.

6. **Update operations.** Document operational procedures for managing the new environment or component. Train the operations team on any new technologies, such as container orchestration, serverless functions, or platform-as-a-service (PaaS) solutions.

7. **Gather feedback from users.** Collect and document feedback from end users. Address any issues, such as performance concerns or newly discovered bugs. Positive feedback, such as improved speed, can validate modernization success.

8. **Capture lessons learned.** Document insights from the modernization effort. Identify what worked well and what didn’t. Highlight gaps, such as the need for better development/test environments or more automation. Feed these lessons back into your Cloud Adoption Framework to improve future projects.

9. **Track quantitative outcomes.** Quantify the impact of modernization to demonstrate its value. Track key metrics such as performance improvements, cost savings, and incident reduction. Share results with stakeholders to build support for future modernization efforts. Examples: “Page load time dropped from 4 seconds to 2 seconds.” “We eliminated 3 VMs, saving $X/month.”

**Validate backups.** Confirm backup jobs are configured correctly and completing successfully. Test restore procedures to ensure data recoverability. For more information, see [Manage data reliability](/azure/backup/backup-overview).

**Decommission source components.** After a stable period, shut down old workloads or components and update your inventory. See [Decommission source workload](./)

## Next steps

Use CAF guidance to govern, secure, and manage your Azure estate.
