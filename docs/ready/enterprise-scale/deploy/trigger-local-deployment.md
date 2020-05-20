# Navigation Menu

* [Overview](../../README.md)
* [North Star Architecture](../NorthStar-Architecture.md)
  * [Design Principles](../Design-Principles.md)
  * [Design Guidelines](../Design-Guidelines.md)
    * [A - Enterprise Enrollment and Azure AD Tenants](../A-Enterprise-Enrollment-and-Azure-AD-Tenants.md)
    * [B - Identity and Access Management](../B-Identity-and-Access-Management.md)
    * [C - Management Group and Subscription Organization](../C-Management-Group-and-Subscription-Organization.md)
    * [D - Network Topology and Connectivity](../D-Network-Topology-and-Connectivity.md)
    * [E - Management and Monitoring](../E-Management-and-Monitoring.md)
    * [F - Business Continuity and Disaster Recovery](../F-Business-Continuity-and-Disaster-Recovery.md)
    * [G - Security, Governance and Compliance](../G-Security-Governance-and-Compliance.md)
    * [H - Platform Automation and DevOps](../H-Platform-Automation-and-DevOps.md)
  * [Implementation Guide](../Implementation-Guide.md)
* [Contoso Reference](../Contoso/Readme.md)
  * [Scope and Design](../Contoso/Scope.md)
  * [Implementation](../Contoso/Design.md)    
* [Using reference implementation in your own environment](./Readme.md)
  * [Getting started](./Getting-Started.md)
    * [Prerequisites](./Prerequisites.md)
    * [Validate prerequisites](./Validate-prereqs.md)
  * [Configure your own environment](./Using-Reference-Implementation.md)
    * [Configure GitHub](./Configure-run-initialization.md)
    * [Provision Platform](./Deploy-platform-infra.md)
    * [Create Landing Zones](./Deploy-lz.md)
    * [Trigger deployments locally](./Trigger-local-deployment.md)
  * [North Star template schema](./NorthStar-schema.md)
    * [Generic North Star ARM template](./NorthStar-template-schema.md)
    * [North Star ARM parameters file](./NorthStar-parameters-schema.md)
  * [Known Issues](./Known-Issues.md)
* [How Do I Contribute?](../Northstar-Contribution.md)
* [FAQ](../Northstar-FAQ.md)
* [Roadmap](../Northstar-roadmap.md)

---

# Contents

This article describes how to trigger local definitions/assignments deployments from your computer whenenver you need to validate deployments without using GitHub actions.

For local debugging purposes, you can trigger a deployment from your computer by running the following commands from a PowerShell terminal.

 Before running the commands below:
 - Ensure you are located in the root folder of your local clone. 
 - Ensure you have made either definitions or assignments changes in your local clone as described on the [Deploy platform infrastructure](./Deploy-platform-infra.md) and [Deploy landing zones](./Deploy-lz.md) articles.

    ```powershell
    Import-Module .\src\AzOps.psd1 -force
    Get-ChildItem -Path .\src -Include *.ps1 -Recurse | ForEach-Object {.$_.FullName}
    Invoke-AzOpsGitPush -Verbose
    ```

Those commands will trigger a definition or assignment deployment (depending which one you configured in your local folder structure) without involving the GitHub actions deployment process described on the previous sections.