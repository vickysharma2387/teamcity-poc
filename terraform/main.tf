resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster"
}

data "aws_ssm_parameter" "ecs_ami" {
name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}


resource "aws_launch_configuration" "ecs_launch_config" {
  name          = "ecs-launch-config"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  launch_configuration = aws_launch_configuration.ecs_launch_config.id
  vpc_zone_identifier  = ["subnet-01"]

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }
}
