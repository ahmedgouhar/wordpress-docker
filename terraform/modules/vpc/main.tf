resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "wordpress-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${10 + count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone      = ["eu-west-1a", "eu-west-1b"][count.index]
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${20 + count.index}.0/24"
  availability_zone = ["eu-west-1a", "eu-west-1b"][count.index]
}