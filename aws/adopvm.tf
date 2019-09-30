resource "aws_key_pair" "adopcTerraformKey" {
  key_name   = "${var.aws_key_name}"
  public_key = "${var.public_key}"
}

data "template_file" "ADOPInit" {
  template = "${file("${path.module}/scripts/init.tpl")}"

  vars {
    adop_username  = "${var.adop_username}"
    adop_password  = "${var.adop_password}"
    s3_bucket_name = "${aws_s3_bucket.temp_adop_credentials.id}"
    key_name       = "${aws_key_pair.adopcTerraformKey.id}"
  }

  depends_on = ["aws_s3_bucket.temp_adop_credentials"]
}

resource "aws_instance" "adopInstance" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.adopcTerraformKey.key_name}"

  vpc_security_group_ids = ["${aws_security_group.adopSecurityGroup.id}"]
  subnet_id              = "${aws_subnet.adopSubnet.id}"
  iam_instance_profile   = "${aws_iam_instance_profile.S3UploadRoleProfile.id}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"   # size this up if running more than a POC
    delete_on_termination = true
  }

  ebs_block_device {
    device_name           = "/dev/sda1"
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "${var.volume_type}"
  }

  ebs_block_device {
    device_name           = "/dev/sdf"
    delete_on_termination = false
    volume_size           = 15
    volume_type           = "${var.volume_type}"
  }

  ebs_block_device {
    device_name           = "/dev/sdg"
    delete_on_termination = false
    volume_size           = 25
    volume_type           = "${var.volume_type}"
  }

  ebs_block_device {
    device_name           = "/dev/sdh"
    delete_on_termination = false
    volume_size           = 25
    volume_type           = "${var.volume_type}"
  }

  user_data = "${data.template_file.ADOPInit.rendered}"

  tags {
    Name             = "adopInstance"
    Service          = "ADOP-C"
    NetworkTier      = "private"
    ServiceComponent = "ApplicationServer"
  }

  depends_on = ["aws_key_pair.adopcTerraformKey", "aws_security_group.adopSecurityGroup", "aws_subnet.adopSubnet", "aws_iam_instance_profile.S3UploadRoleProfile"]
}