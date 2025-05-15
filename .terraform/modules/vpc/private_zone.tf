resource "aws_route53_zone" "private" {
  name = "${var.domain_name}.private"

  vpc {
    vpc_id = "${aws_vpc.vpc.id}"
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

