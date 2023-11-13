# Create a VPC
resource "aws_vpc" "our_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "dev"
  }
}

resource "aws_subnet" "our_subnet" {
  vpc_id                  = aws_vpc.our_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    name = "dev-public"
  }
}

resource "aws_internet_gateway" "our_in_gateway" {
  vpc_id = aws_vpc.our_vpc.id
  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "our_route_table" {
  vpc_id = aws_vpc.our_vpc.id

  tags = {
    Name = "dav_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.our_route_table.id
  destination_cidr_block = "0.0.0.0/0" # Going to internet gateway
  gateway_id             = aws_internet_gateway.our_in_gateway.id
}

resource "aws_route_table_association" "our_rt_public_assoc" {
  subnet_id      = aws_subnet.our_subnet.id
  route_table_id = aws_route_table.our_route_table.id
}

resource "aws_security_group" "our_dev_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.our_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["118.99.107.118/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "aws_key_pair" {
  key_name = "aws_key"
  public_key = file("~/.ssh/aws_key.pub")
}

resource "aws_instance" "control_node" {
  count = 1
  instance_type = "t2.micro"
  ami = data.aws_ami.server_ami.id

  tags = {
    name = "control-node"
  }

  key_name = aws_key_pair.aws_key_pair.id
  vpc_security_group_ids = [aws_security_group.our_dev_sg.id]
  subnet_id = aws_subnet.our_subnet.id
  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }
}

resource "aws_instance" "worker_nodes" {
  count = 3
  instance_type = "t2.micro"
  ami = data.aws_ami.server_ami.id

  tags = {
    Name = "worker_node-${count.index + 1}"
  }

  key_name = aws_key_pair.aws_key_pair.id
  vpc_security_group_ids = [aws_security_group.our_dev_sg.id]
  subnet_id = aws_subnet.our_subnet.id
  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

}