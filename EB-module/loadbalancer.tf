# Load Balancer
resource "aws_lb" "eb_lb" {
  name               = "${var.project_name}-load-balancer"
  load_balancer_type = "application"
  subnets            = module.VPC-Module.public_subnet[*]
  security_groups    = [module.VPC-Module.alb_sg]

  tags = {
    Name = "${var.project_name}-eb_lb"
  }
}





resource "aws_lb_target_group" "eb_tg" {
  name     = "${var.project_name}-eb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.VPC-Module.vpc
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.eb_tg.arn
  target_id        = aws_elastic_beanstalk_environment.eb_env.id
  port             = 80

  depends_on = [ aws_elastic_beanstalk_application.eb_env ]
}