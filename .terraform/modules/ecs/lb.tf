###################
# APPLICATION LB  #
###################

resource "aws_lb" "lb" {
  name               = "${var.project_name}-ecs-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.ecs_service.id}"]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.project_name
    Environment = var.env
  }
}
