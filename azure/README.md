# Provisioning ADOP-C Infrastructure In AWS Using Terraform

### AWS Pre Terraform Setup 
To use this script you are required to have a `subscription_id` and `tenant_id` for Azure.

#### Optional - Setting Up a Service Principle
- Before running this you have set up a `Service Principle` for your Azure subscription. This provides you with your `client_id` and `client_secret`.

**If you are using a service principle, ensure that the relevant lines in `provider.tf` are uncommented**

    provider "azurerm" {
        subscription_id = "${var.subscription_id}"
        tenant_id       = "${var.tenant_id}"
        # If using Service Principle Make Sure These Are Uncommented
        client_id = "${var.client_id}"
        client_secret = "${var.client_secret}"
    }
 
1) Run `terraform validate`
    - Run `terraform taint <resource.resource_name> -> Forces destroy and recreation of a resource at the next apply

2) Run `terraform plan -var-file="secret.tfvars" -out=terraformout`
    - secret.tfvars contains secret variables that we do not commit to source control such as passwords.

3) Run `terraform apply "terraformout"`

### ADOP-C
You can view the progress of the onstallation of ADOP-C on the Instance as follows

    ssh -i "<key_name>" centos@<public_ip>
    tail -500f /root/userData.sh

## How To SetUp
- Create a secrets.tfvars file in this directory and add in values for **all** the varaibles in ```variables.tf``` that don't have a default value
    - Example of entry in secrets.tfvars
      adop_username = "<insert value>"
- Update resources tags as appopriate 
- The file `scripts/userData.sh` is publically available as a GitHub gist. You can however have it privately on your own - remember to change the curl url in `adopvm - azurerm_virtual_machine_extension` as appropriate



