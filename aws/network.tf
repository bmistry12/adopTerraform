resource "aws_subnet" "adopSubnet" {
  vpc_id                  = "${var.aws_vpc}"
  cidr_block              = "172.31.64.32/28"
  map_public_ip_on_launch = true

  tags {
    Name = "adopSubnet"
  }
}

resource "aws_security_group" "adopSecurityGroup" {
  name        = "adopSecurityGroup"
  description = "Allows ADOP inbound traffic"
  vpc_id      = "${var.aws_vpc}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2376
    to_port     = 2376
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25826
    to_port     = 25826
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
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
