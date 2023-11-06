# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "eb_app" {
  name        = "${var.project_name}-eb-app"
  description = "Elastic Beanstalk Application"
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "eb_env" {
  name        = "${var.project_name}-eb-env"
  application = aws_elastic_beanstalk_application.eb_app.name
  wait_for_ready_timeout  = "60m"
  solution_stack_name = "${var.eb_solution_stack}"


  ########### other config


  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.VPC-Module.vpc
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "true"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.my_key_pair.key_name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "IamInstanceProfile_role" #"aws-elasticbeanstalk-ec2-role" i have create own with full access
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "False" #True
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", module.VPC-Module.private_subnet_ids)
  }

setting {
  namespace = "aws:autoscaling:launchconfiguration"
  name      = "SecurityGroups"
  value     = join(",", [module.VPC-Module.elastic_beanstalk_sg], [module.VPC-Module.alb_sg])
}

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
  tags = {
    Name = "${var.project_name}_eb_app"
  }

}


# Attach the security group to the Elastic Beanstalk instances
# resource "aws_security_group_attachment" "alb_sg_attachment" {
#   security_group_id = module.VPC-Module.alb_sg
#   elastic_beanstalk_environment_name = aws_elastic_beanstalk_environment.eb_env.name
# }