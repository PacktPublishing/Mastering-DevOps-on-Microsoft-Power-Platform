# Power Platform provider for Terraform Example

This repository contains Terraform configuration files for managing resources within the Power Platform. The Power Platform provider enables us to automate the deployment of Power Platform resources using Terraform.

Remember that the Power Platform provider is currently still experimental and not intended for production use. Consult the [official documentation](https://registry.terraform.io/providers/microsoft/power-platform/latest/docs) for more details.


## Files Included:

1. **main.tf**: This file defines the main infrastructure components and resources. Here we can find the core configuration our your Power Platform environment here.

2. **terraform.tf**: The Terraform configuration file specifies the provider and any other global settings. In this case, it sets up the Power Platform provider and AzureRM provider for Terraform task in CI/CD pipeline.

3. **dev.variables.tfvars**: Customize environment-specific variables for our development environment. These variables can be used to parameterize the configuration.

4. **prod.variables.tfvars**: Similar to `dev.variables.tfvars`, this file contains environment-specific variables for the production environment.

5. **variables.tf**: Declare input variables that can be used across your Terraform modules. These variables allow us to make configuration more flexible and reusable.

6. **simple-tf-iac.yml**: Simple pipeline to demonstrate the usage of Terraform tasks in Azure DevOps.

## Authentication:

To authenticate with the Power Platform, you have a few options:

- **Azure CLI**: We can use Azure CLI to log in to Microsoft EntraId account. The Power Platform provider will use the credentials from the Azure CLI. Add the snippet below to change the provider authentication option. Make sure Expose API is set in App registration for provider.
```
provider "powerplatform" {
  use_cli = true
}
```
- **Service Principal with OIDC**: We can use a Service Principal with OpenID Connect (OIDC) to authenticate. This is useful for CI/CD pipelines in GitHub or Azure DevOps, as we will not need to manage secrets. Add the snippet below to change the provider authentication option.

```
provider "powerplatform" {
  use_oidc = true
}
```

- **Service Principal and a Client Secret**: As shown in the example files in this folder, we can use a Service Principal with Client Secret to authenticate.


## Usage

Fork this repository and change the values of variables to adjust to your Power Platform tenant and Microsoft Azure subscription.


## Contributing

Contributions are welcome. Please feel free to fork this repository, make your changes, and then submit a pull request.
