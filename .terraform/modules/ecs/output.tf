#output "lb_arn" {
#  value = "${aws_lb.ecs.arn}"
#}

#output "lb_listener_arn" {
#  value = "${aws_lb_listener.listener-ecs-https.arn}"
#}

output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.ecs-cluster.id}"
}
