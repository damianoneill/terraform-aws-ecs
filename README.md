# terraform-aws-ecs

Terraform configuration for provisioning a trivial AWS ECS example. **Note** the intro material for the first sections below is cut/paste/modified from [learn terraform modules overview](https://learn.hashicorp.com/tutorials/terraform/module?in=terraform/modules).

## Prerequisites

To follow this you will need:

- An AWS account -- Configure one of the authentication methods described in the [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication). This example assumes that you are using the [shared credentials file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-credentials-file) method with the default AWS credentials file and default profile.
- The [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- The [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Module Structure

Terraform treats any local directory referenced in the source argument of a module block as a module. A typical file structure for a new module is:

```console
.
├── main.tf
├── outputs.tf
└── variables.tf
```

None of these files are required, or have any special meaning to Terraform when it uses your module. You can create a module with a single .tf file, or use any other file structure you like. However, it is very common to see modules using at least these three filenames.

Each of these files in this example serves a distinct purpose:

**main.tf** will contain the main set of configuration for this module.

**variables.tf** will contain the variable definitions for this module. Since all Terraform values must be defined, any variables that are not given a default value will become required arguments. Variables with default values can also be provided as module arguments, overriding the default value.

**outputs.tf** will contain the output definitions for this module. Module outputs are made available to the configuration using the module, so they are often used to pass information about the parts of your infrastructure defined by the module to other parts of your configuration.

There are also some other files to be aware of, and ensure that you don't distribute them:

**terraform.tfstate** and **terraform.tfstate.backup**: These files contain your Terraform state, and are how Terraform keeps track of the relationship between your configuration and the infrastructure provisioned by it.

**.terraform**: This directory contains the modules and plugins used to provision your infrastructure. These files are specific to a specific instance of Terraform when provisioning infrastructure, not the configuration of the infrastructure defined in .tf files.

**\*.tfvars**: Since module input variables are set via arguments to the module block in your configuration, you don't need to distribute any \*.tfvars files with your module, unless you are also using it as a standalone Terraform configuration.

If you are tracking changes to your module in a version control system, such as git, you will want to configure your version control system to ignore these files.

> :Warning: **Do Not Commit**: The files mentioned above will often include secret information such as passwords or access keys, which will become public if those files are committed to a public version control system!

## AWS Provider

Let's start by looking at the documentation. Open the [Terraform Registry page for the VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) in a new browser tab or window.

> As of today, the version is 2.77.0

![Terraform Registry for VPC Module](./images/aws-vpc-docs.png)

You will see information about the module, as well as a link to the source repository. On the right side of the page, you will see a drop down widget to select the module version, as well as instructions to use the module to provision infrastructure.

Let start by creating a file for the [provider](./provider.tf) and defining some content.

```terraform
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

```

This configuration includes two blocks:

- terraform configures Terraform itself. This block requires the aws provider from the official Hashicorp provider registry.
- provider "aws" defines your provider. Depending on the authentication method you chose, you may need to include additional arguments in the provider block.

You'll notice that the region is specified using a variable. Variables are defined in the [variables.tf](./variables.tf) file.

```terraform
variable "aws_region" {
  description = "The AWS region to launch the cluster and related resources"
}
```

In this case the variable does not have a default value, therefore terraform expects this to be provided. I have defined a [terraform.tfvars](./terraform.tfvars) file, which can be used to provide a default value, in this case, it's us-west-2. For a list of available [aws regions see this article](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html).

```terraform
aws_region="us-west-2"
```

Amazon EC2 is hosted in multiple locations world-wide. These locations are composed of Regions, Availability Zones, Local Zones, AWS Outposts, and Wavelength Zones. Each Region is a separate geographic area. For further information see this [AWS article](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html).

## VPC

