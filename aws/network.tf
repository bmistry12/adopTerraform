resource "aws_vpc" "adopVPC" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "adopVPC"
  }
}

resource "aws_internet_gateway" "adopIGW" {
  vpc_id = "${aws_vpc.adopVPC.id}"

  tags {
    Name = "adopIGW"
  }
}

resource "aws_eip" "adopEIP" {
  instance = "${aws_instance.adopInstance.id}"

  depends_on = ["aws_internet_gateway.adopIGW", "aws_instance.adopInstance"]
}

data "aws_route_table" "adopRT" {
  vpc_id = "${aws_vpc.adopVPC.id}"
  depends_on = ["aws_internet_gateway.adopIGW"]
}

resource "aws_route" "adopRoute" {
  route_table_id            = "${data.aws_route_table.adopRT.id}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.adopIGW.id}"
}

resource "aws_subnet" "adopSubnet" {
  vpc_id                  = "${aws_vpc.adopVPC.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  map_public_ip_on_launch = true

  tags {
    Name = "adopSubnet"
  }
}

resource "aws_security_group" "adopSecurityGroup" {
  name        = "adopSecurityGroup"
  description = "Allows ADOP inbound traffic"
  vpc_id      = "${aws_vpc.adopVPC.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.inbound_accessible_ips}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.inbound_accessible_ips}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.inbound_accessible_ips}"
  }

  ingress {
    from_port   = 2376
    to_port     = 2376
    protocol    = "tcp"
    cidr_blocks = "${var.inbound_accessible_ips}"
  }

  ingress {
    from_port   = 25826
    to_port     = 25826
    protocol    = "udp"
    cidr_blocks = "${var.inbound_accessible_ips}"
  }

  //Explicitly add the outbound egress rule as terraform removes the default provide done
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "adopSecurityGroup"
  }
}
