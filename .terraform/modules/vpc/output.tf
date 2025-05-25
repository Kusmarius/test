output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "main_vpc_cidr" {
  value = "${var.cidr_block}"
}

output "private_subnet_ids" {
  value = ["${aws_subnet.private_a.id}", "${aws_subnet.private_b.id}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
}

output "private_route_table" {
  value = "${aws_route_table.private_route_table.id}"
}

output "public_route_table" {
  value = "${aws_vpc.vpc.main_route_table_id}"
}

output "private_zone" {
  value = "${aws_route53_zone.private.id}"
}
