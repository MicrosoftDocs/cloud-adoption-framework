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

## North Star template schema

This article will help you to familiarize with North Star template deployments, which consist on one and only one ARM template (one template to rule them all), and then, just providing the details of the resource(s) you want to deploy by using parameters files.

## Target audience
The target audience for this guide is people with a typical DevOps / SRE background and assumes knowledge in Azure Resource Manager (ARM)/Infrastructure as Code (IaC), Git, and PowerShell.

## Contents
This article is divided in two sections:
 - The first part will describe the [Generic North Star ARM template](./NorthStar-template-schema.md), so that you don't have to write your own ARM templates anymore (unless you decide to do so).
 - The second part of this article will explain how to deploy ARM resources by simply updating a [North Star ARM parameters file](./NorthStar-parameters-schema.md). 