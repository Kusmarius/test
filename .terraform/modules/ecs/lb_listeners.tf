#resource "aws_lb_listener" "listener-ecs-https" {
#  load_balancer_arn = "${aws_lb.lb.arn}"
#  port              = "443"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2015-05"
#  certificate_arn   = ""

#  default_action {
#    type = "fixed-response"

#    fixed_response {
#      content_type = "text/plain"
#      message_body = "Fixed response content"
#      status_code  = "200"
#    }
#  }

#  default_action {
#    type             = "forward"
#    target_group_arn = "${aws_lb_target_group.ecs.arn}"
#    }

#}

resource "aws_lb_listener" "listener-ecs-http" {
  load_balancer_arn = "${aws_lb.lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}
