# Provisioning ADOP-C Infrastructure In AWS Using Terraform

### AWS Pre Terraform Setup 
- Before running this you are required to have set up an `IAM User Role` on for your AWS subscription. this provided you with an AWS Access Key ID and Secret Key.
- 
1) Run `terraform validate`
    - Run `terraform taint <resource.resource_name> -> Forces destroy and recreation of a resource at the next apply

2) Run `terraform plan -var-file="secret.tfvars" -out=terraformout`
    - secret.tfvars contains secret variables that we do not commit to source control such as passwords.

3) Run `terraform apply "terraformout"`

### ADOP-C
You can view the progress of the onstallation of ADOP-C on the Instance as follows

    ssh -i "<key_name>" centos@<public_ip>
    tail -500f var/log/cloud-init.log

## How To SetUp
- Create a secrets.tfvars file in this directory and add in values for **all** the varaibles in ```variables.tf``` that don't have a default value
    - Example of entry in secrets.tfvars
      adop_username = "<insert value>"
- Change the `key_name` of the `aws_key_pair` resource to the name you would like the key pair to be called in AWS.
- Update resources tags as appopriate 
- The file `scripts/userData.sh` is publically available as a GitHub gist. You can however have it privately on your own - remember to change the curl url in `init.tpl` as appropriate
- Create a `./aws/credentials` file in your home directory to store AWS IAM access details.

        Example File Structure
            [profile-name]
            aws_access_key_id=avalue
            aws_secret_access_key=avalue


