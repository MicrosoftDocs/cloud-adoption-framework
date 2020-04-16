# Contoso Reference Implementation - Known Issues

### Subscription Creation

At present, it is not possible to provision new Subscription via ARM templates. Subscription creation requires an Enterprise Enrollment account to be migrated to a new system in the backend. We are working closely with engineering teams to enable this functionality for the Contoso Tenant.

### Unsupported number of tenants in context: x TenantID(s)

We currently do not support Initialization across multiple tenants. <br>Clear your AzContext and run `Connect-AzAccount` with the service principal that was created earlier.