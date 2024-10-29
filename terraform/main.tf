resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster"
}

data "aws_ssm_parameter" "ecs_ami" {
name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}


resource "aws_launch_template" "ecs_launch_template" {
  name          = "ecs-launch-template"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
  
  tag_specifications {
    resource_type = "instance"
	tags = {
	  Name = "ecs-instance"
    }
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = ["subnet-01"]
  launch_template {
    id = aws_launch_template.ecs_launch_template.id
	version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }
}
