# Azure Landing Zone governance guide: Update ALZ deployed policies

This article describes how to maintain and update policies deployed as part of ALZ initial deployment. Implementations done by ALZ accelerator, ALZ-Bicep or ALZ-Terraform are all covered.

## Use case scenario  
You have deployed ALZ at a specific time and are now looking to update the existing policies/initiatives to leverage new functionality, the following scenarios are covered:
1.	Baseline ALZ policies has been superseded by newer Azure Built-in policies.
2.	Baseline ALZ Initiatives has been updated with new built-in policies or new ALZ policies
3.	Baseline ALZ policies has been updated to newer versions.
4.	New ALZ policies or initiatives has been released to baseline.
5.	Baseline ALZ policies or initiatives has been deprecated.
Note that for the above scenarios it is assumed that you may not want to update all ALZ policies/initiatives and may not have all ALZ policies/initiatives assigned at present.
### Assumptions
The following assumptions has been made when considering the process
- Updates to ALZ base policies is detected through either reviewing updates to Custom policy update (ALZ only) is detected by other means (see fixme for more details)
- Customer deployed through Portal Accelerator and has no existing method for Policy management.
- Customer is assumed to have or create separate dev management group hierarchy for testing policies, separate from ALZ environment either at same level as ALZ pseudo root or in another tenant as described here.
- Deployment method could be via ARM, or leverage bicep or TF implementation


## ALZ environments deployed through ALZ Accelerator.
### Steps
1.	On local repo from https://github.com/azure/alzPolicyMagic  do git sync from main.
2.	Push somewhere or do something else to put into own repo. Need to discuss if  Azure/enterprise-azure-policy-as-code: Enterprise-ready Azure Policy-as-Code (PaC) solution (includes Az DevOps pipeline) (github.com) could be used as a baseline for this. Alternatively some git method or other to put into repo w.o. having a 1:1 clone of the ALZ repo as base necessarily.
3.	Read commit messages/release notes for policy update(s) to determine if there are parameters added or removed. Release notes can be found here: fixme url to policy code repo.
4.	Steps after initial update commit to test branch (in test environment)
    - Get deprecated ALZ policies/initiatives and flag for deletion. If superseded by built-in flag those for inclusion in assignments. (Assuming that ALZ initiatives are updated if an existing ALZ policy is included in an initiative and is superseded by a built-in policy)
    - Get new baseline ALZ policies superseding existing ones
    - Get changed policies -> output changed policies + parameters changed true/false (this can be manual or automated through git diff or similar)
    - If parameters changed equals false it will be possible to update the policy directly. (this can be manual or automated as required)
    - Get changed policy initiatives -> output changed policies + parameters changed true/false (this can be manual or automated through git diff or similar)
    - If parameters changed equals false it will be possible to update the policy directly. (this can be manual or automated as required)
    - If parameters changed equals true ->
      1. Get policy assignments using this policy/initiative. (If no policy assignments are using the policy this will be low impact)
      2. Note policy assignments parameters that needs to change 
      3. Note the policy/initiative as it will need to be deleted and recreated, update not possible.
    - Output list of policies affected with policy assignments to be updated accordingly, list should include:
      1. Policy assignments to be changed due to parameter changes, i.e. deleted and recreated.
      2. Policies that will be updated only
      3. Initiatives that will be updated only
      4. Policies that will be deleted, due to deprecation.
      5. Initiatives that will be deleted, due to deprecation 
      6. Policies that will be deleted and recreated due to parameter changes or other reasons.
      7. Initiatives that will be deleted and recreated due to parameter changes or other reasons.
      8. Role assignments to be set for MSI
    - Modify policy assignment files to desired end values (this could be a manual step as well, but if we are going to be prescriptive, I believe we should try to guide customers towards automation.)
    - Commit to test branch
    - Get list of affected policy assignments and delete (is policy compliance history going to be an issue?)
    - Delete policies/initiatives which cannot be updated, or are flagged for deletion due to deprecation.
    - Deploy policies/initiatives that are to be used going forward. (As mentioned previously this is not necessarily all policies in the pack.)
    - Deploy policy assignments (ARM deploy)
      1. Deploy policy assignments
      2. Deploy MSI role assignments where required
    - Test policy functionality
5. Iterate the above until satisfied.
6. Merge into main
7. Deploy to prod is done either manually repeating the above or through pipeline. (Should we look into staggered approach or should test deploy be sufficient.)

## ALZ environments deployed through ALZ-Bicep.
### Assumptions:
- Custom policy update (ALZ only) is detected by other means (see fixme for more details)
- Customer deployed through ALZ Bicep and has no existing method for Policy management beyond what is provided with ALZ-Bicep.
- Customer is assumed to have or create separate dev management group hierarchy for testing policies, separate from ALZ environment either at same level as ALZ pseudo root or in another tenant as described here.
- Deployment method will leverage Bicep methods
### Steps
1.	On local repo from https://github.com/azure/alzPolicyMagic  do git sync from main.
2.	Need to discuss if we are going to assume using ALZ-Bicep repo as local source as well, since it lends itself better to it than does the Portal accelerator implementation. 
3.	Read commit messages/release notes for policy update(s) to determine if there are parameters added or removed. Release notes can be found here: fixme url to policy code repo.
4.	Steps after initial update commit to test branch # (use C:\rep\int\ALZ-Bicep\infra-as-code\bicep\modules\policy\definitions as source, depends on above discussion)
    - Get deprecated ALZ policies/initiatives and flag for deletion. If superseded by built-in flag those for inclusion in assignments. (assuming that ALZ initiatives are updated if an existing ALZ policy is included in an initiative and is superseded by a built-in policy)
    - Get new policies superseding existing ones
    - Get changed policies -> output changed policies + parameters changed true/false (this can be manual or automated through git diff or similar)
    - If parameters changed equals false it will be possible to update the policy directly. (this can be manual or automated as required)
    - Get changed policy initiatives -> output changed policies + parameters changed true/false (this can be manual or automated through git diff or similar)
    - If parameters changed equals false it will be possible to update the policy directly. (this can be manual or automated as required)
    - If parameters changed equals true ->
      1.	Get policy assignments using this policy/initiative. (If no policy assignments are using the policy this will be low impact)
      2.	Note policy assignments parameters that needs to change 
      3.	Note the policy/initiative as it will need to be deleted and recreated, update not possible.
    - Output list of policies affected with policy assignments to be updated accordingly, list should include:
      1.	Policy assignments to be changed due to parameter changes, i.e. deleted and recreated.
      2.	Policies that will be updated only
      3.	Initiatives that will be updated only
      4.	Policies that will be deleted, due to deprecation.
      5.	Initiatives that will be deleted, due to deprecation 
      6.	Policies that will be deleted and recreated due to parameter changes or other reasons.
      7.	Initiatives that will be deleted and recreated due to parameter changes or other reasons.
      8.	Role assignments to be set for MSI
    - Modify policy assignment files to desired end values (presumably this is going to take place in \infra-as-code\bicep\modules\policy\assignments depending on above discussion)
    - Commit to test branch
    - Get list of affected policy assignments and delete (is policy compliance history going to be an issue? -> since bicep don’t allow for deleting this will have to take place some other way, manual or script)
    - Delete policies/initiatives which cannot be updated, or are flagged for deletion due to deprecation. (since bicep don’t allow for deleting this will have to take place some other way, manual or script)
    - Deploy policies/initiatives that are to be used going forward. (As mentioned previously this is not necessarily all policies in the pack.)
    - Deploy policy assignments (Bicep deploy)
      1.	Deploy policy assignments
      2.	Deploy MSI role assignments where required (leveraging infra-as-code\bicep\modules\roleAssignments)
    - Test policy functionality
5.	Iterate until satisfied.
6.	Merge into main
7.	Deploy to prod is done either manually repeating the above or through pipeline. (Should we look into staggered approach or should test deploy be sufficient.)

## ALZ environments deployed through ALZ-Terraform.
### Assumptions:
- Custom policy update (ALZ only) is detected by other means (fixme upon module update?)
- Customer deployed through ALZ Terraform and is using ALZ Terraform for all updates.
- Customer is assumed to have or create separate dev management group hierarchy for testing policies, separate from ALZ environment either at same level as ALZ pseudo root or in another tenant as described here fixme.
- Deployment method will leverage Terraform methods
Steps
1. If major release follow upgrade guidance provided
2. If minor release just update directly




1.	Fixme discussion with Kevin/Matt/Jack on how this is done today. Upgrade guides for entire module are provided here: [User Guide] Upgrade from v1.1.4 to v2.0.0 · Azure/terraform-azurerm-caf-enterprise-scale Wiki (github.com). Current guidance is all-or-nothing, i.e. entire module is updated. No guidance on per-component updates or even more granular. It’s on the backlog though. Moreover upgrade guidance is not provided for all module releases, only major releases. Customers are updating though, HSBC for one, who has a long-standing canary/prod pipeline specifically for policies. Need more details for individual/granular process for policies. Will push till after customer interviews though.
a.	Further details to follow.
