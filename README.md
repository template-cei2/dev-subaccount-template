# Template for Setting up Subaccount

This README.md document has been generated during creation of the template from your existing subaccount 'Customer Portal DEV-TEST'.

This template comprises the creation of a subaccount, its contained resources and authorization assignment.

## Basic building blocks

The basic setup comprises the following resources:

- A SAP BTP subaccount
- Assignment of *entitlements* for services
- Creation of *service instances* and *subscriptions* (if defined)
- Assignment of *subaccount administrator*, *subaccount viewer* and *Cloud Foundry* specific *roles*.
- Creation of *destinations* (if defined)

## Contained services and applications

| Resource name | Technical Name | Plan |  Quota | Create service instance/subscription
| --- | --- | --- | --- | ---
| Application Logging Service | `application-logs` | `lite` | 2 units | yes
| Destination Service | `destination` | `lite` | 2 units | yes
