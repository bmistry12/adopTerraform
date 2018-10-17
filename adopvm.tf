resource "aws_key_pair" "bhavTerraformKey" {
  key_name   = "bhavTerraformKey"
  public_key = "${var.public_key}"
}

data "template_file" "ADOPInit" {
  template = "${file("${path.module}/scripts/init.tpl")}"

  vars {
    adop_username = "${var.adop_username}"
    adop_password = "${var.adop_password}"
    s3_bucket_name = "${aws_s3_bucket.temp_adop_credentials.id}"
    key_name = "${aws_key_pair.bhavTerraformKey.id}"
  }
}


/* resource "aws_network_interface" "bhavAdopNetworkInterface" {
  subnet_id = "${aws_subnet.bhavAdopSubnet.id}"
  //private_ips = ["172.31.64.33"] only use it if you want a static ip
  attachment {
    instance     = "${aws_instance.bhavAdopInstance.id}"
    device_index = 0
  }
  tags {
    Name = "bhavAdopNetworkInterface"
  }
} */
resource "aws_instance" "bhavAdopInstance" {
  ami           = "${var.ami_id}"
  instance_type = "m4.xlarge"
  key_name      = "bhav_terraform_example"
 /*  network_interface {
    network_interface_id = "${aws_network_interface.bhavAdopNetworkInterface.id}"
    device_index = 0
  } */
  vpc_security_group_ids = ["${aws_security_group.bhavAdopSecurityGroup.id}"]
  subnet_id = "${aws_subnet.bhavAdopSubnet.id}"
  iam_instance_profile = "${aws_iam_instance_profile.S3UploadRoleProfile.id}" 

  root_block_device {
    volume_type = "gp2"
    volume_size = "8" # size this up if running more than a POC
    delete_on_termination = true
  } 

  ebs_block_device {
    device_name="/dev/sda1"
    delete_on_termination = true
    volume_size = 8
    volume_type = "${var.volume_type}"
  }

  ebs_block_device {
    device_name="/dev/sdf"
    delete_on_termination = false
    volume_size = 15
    volume_type = "${var.volume_type}"
  }

  ebs_block_device {
    device_name="/dev/sdg"
    delete_on_termination = false
    volume_size = 25
    volume_type = "${var.volume_type}"
  }

  ebs_block_device {
    device_name="/dev/sdh"
    delete_on_termination = false
    volume_size = 25
    volume_type = "${var.volume_type}"
  }

  #user_data = "curl -L https://gist.github.com/bmistry12/6a4296de580f69158f864546ee6ecb6d"
  user_data = "${data.template_file.ADOPInit.rendered}" 

  tags {
    Name = "bhavAdopInstance"
    Service = "ADOP-C"
    NetworkTier = "private"
    ServiceComponent = "ApplicationServer"
  }
  # depends_on = ["aws_route.route"]
}