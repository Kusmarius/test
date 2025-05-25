data "aws_availability_zones" "available" {}



########################################
# Security Group for ECS               #
########################################

resource "aws_security_group" "ecs_service" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.project_name}-ecs-${var.env}"
  description = "Allow egress from container"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


########################################
# Define ECS Cluster                   #
########################################


resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.project_name}-ecs-${var.env}"
}


############################
# TARGET GROUP ATTACHMENT  #
############################

#resource "aws_autoscaling_attachment" "asg_attachment" {
#  autoscaling_group_name = "${aws_autoscaling_group.bar.id}"
#  alb_target_group_arn   = "${aws_lb_target_group.publisher_acc.arn}"
#}

################################
# ACM CERT FOR APPLICATION LB  #
################################


#resource "aws_acm_certificate" "cert" {
#  #domain_name       = "${var.domain_name}"
#  domain_name       = "*.gamecredits2.org"
#  validation_method = "DNS"
#  provider = "aws.us"
#}

#data "aws_route53_zone" "zone" {
#  name         = "gamecredits2.org."
#  private_zone = false
#}

#resource "aws_route53_record" "cert_validation" {
#  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
#  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
#  zone_id = "${data.aws_route53_zone.zone.id}"
#  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
#  ttl     = 60
#}

#resource "aws_acm_certificate_validation" "cert" {
#  certificate_arn         = "${aws_acm_certificate.cert.arn}"
#  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
#}



#resource "aws_route53_record" "base_domain" {
#  name    = "${var.domain_name}"
#  type    = "CNAME"
#  zone_id = "${data.aws_route53_zone.zone.id}"
#  records = ["${aws_lb.publisher_acc.dns_name}"]
#  ttl     = 60
#}

