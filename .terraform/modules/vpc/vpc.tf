resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
      Name = "${var.project_name}-${var.env}"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.private_subnet_a}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "${var.project_name}-${var.env}-private-a",
    Tier = "private"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public_subnet_a}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "${var.project_name}-${var.env}-public-a",
    Tier = "public"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.private_subnet_b}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "${var.project_name}-${var.env}-private-b",
    Tier = "private"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public_subnet_b}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "${var.project_name}-${var.env}-public-b",
    Tier = "public"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.project_name}-${var.env}",
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_eip" "net_eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.net_eip.id}"
  subnet_id = "${aws_subnet.public_a.id}"
  depends_on = ["aws_internet_gateway.igw"]
  tags = {
    Name = "${var.project_name}-${var.env}",
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "zfi-private"
  }
}

resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

resource "aws_route_table_association" "public_a_association" {
  subnet_id = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_vpc.vpc.main_route_table_id}"
}

resource "aws_route_table_association" "public_b_association" {
  subnet_id = "${aws_subnet.public_b.id}"
  route_table_id = "${aws_vpc.vpc.main_route_table_id}"
}

resource "aws_route_table_association" "private_a_association" {
  subnet_id = "${aws_subnet.private_a.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "private_b_association" {
  subnet_id = "${aws_subnet.private_b.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
