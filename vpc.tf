resource "aws_vpc" "g8VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    name = "devops-group-8"
  }
}     

resource "aws_internet_gateway" "g8igw" {
  vpc_id = aws_vpc.g8VPC.id

  tags = {
    Name = "devops-group-8"
  }
}

resource "aws_route_table" "g8RT" {
  vpc_id = aws_vpc.g8VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.g8igw.id
  }


  tags = {
    Name = "devops-group-8"
  }

}
resource "aws_subnet" "g8public" {
  vpc_id     = aws_vpc.g8VPC.id
  cidr_block = "10.0.0.0/19"

  tags = {
    Name = "devops-group-8"
  }
}

resource "aws_subnet" "g8private" {
  vpc_id     = aws_vpc.g8VPC.id
  cidr_block = "10.0.32.0/19"

  tags = {
    Name = "devops-group-8"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.g8public.id
  route_table_id = aws_route_table.g8RT.id
}

#Create Security Groups
resource "aws_security_group" "group_eight" {
  vpc_id      = aws_vpc.g8VPC.id # Ensure the security group is created in the same VPC
  name        = "group eight security group"
  description = "group eight security group"


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "group_eight"
  }
}
