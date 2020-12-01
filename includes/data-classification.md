<!-- TEMPLATE FILE - DO NOT ADD METADATA -->
<!-- markdownlint-disable MD026 MD041 -->
Data classification allows you to determine and assign value to your organization's data and provides a common starting point for governance. The data classification process categorizes data by sensitivity and business impact in order to identify risks. When data is classified, you can manage it in ways that protect sensitive or important data from theft or loss.

## Understand data risks, then manage them

Before any risk can be managed, it must be understood. In the case of data breach liability, that understanding starts with data classification. Data classification is the process of associating a metadata characteristic to every asset in a digital estate, which identifies the type of data associated with that asset.

Any asset identified as a potential candidate for migration or deployment to the cloud should have documented metadata to record the data classification, business criticality, and billing responsibility. These three points of classification can go a long way to understanding and mitigating risks.

## Classifications Microsoft uses

The following is a list of classifications Microsoft uses. Depending on your industry or existing security requirements, data classification standards might already exist within your organization. If no standard exists, you might want to use this sample classification to better understand your own digital estate and risk profile.

- **Non-business:** Data from your personal life that doesn't belong to Microsoft.
- **Public:** Business data that is freely available and approved for public consumption.
- **General:** Business data that isn't meant for a public audience.
- **Confidential:** Business data that can cause harm to Microsoft if overshared.
- **Highly confidential:** Business data that would cause extensive harm to Microsoft if overshared.

## Tagging data classification in Azure

Resource tags are a good approach for metadata storage, and you can use these tags to apply data classification information to deployed resources. Although tagging cloud assets by classification isn't a replacement for a formal data classification process, it provides a valuable tool for managing resources and applying policy. [Azure Information Protection](/azure/information-protection/what-is-information-protection) is an excellent solution to help you classify data itself, regardless of where it resides (on-premises, in Azure, or somewhere else). Consider it as part of an overall classification strategy.

## Take action

Take action by defining and tagging assets with a defined data classification.

- [Choose one of the actionable governance guides](../docs/govern/guides/index.md) for examples of applying tags across your portfolio.
- Review the [recommended naming and tagging conventions](../docs/ready/azure-best-practices/resource-tagging.md) to define a more comprehensive tagging standard.
- For additional information on resource tagging in Azure, see [Use tags to organize your Azure resources and management hierarchy](/azure/azure-resource-manager/management/tag-resources).
