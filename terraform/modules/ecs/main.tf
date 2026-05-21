resource "aws_ecs_cluster" "this" {
  name = "wordpress-cluster"
}

resource "aws_iam_role" "task_execution" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_ecs_task_definition" "this" {
  family                   = "wordpress"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.task_execution.arn

  container_definitions = jsonencode([
    {
      name  = "wordpress"
      image = var.ecr_url

      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]

      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
          value = var.db_endpoint
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name   = "wordpress"
    container_port   = 80
  }
}
