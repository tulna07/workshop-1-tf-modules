resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = ["FARGATE"]
}

resource "aws_ecs_service" "main" {
  cluster = aws_ecs_cluster.main.id
  name    = var.ecs_service_name

  task_definition = "${aws_ecs_task_definition.main.family}:${max(aws_ecs_task_definition.main.revision, data.aws_ecs_task_definition.main.revision)}"
  desired_count   = var.desired_count

  scheduling_strategy                = "REPLICA"
  deployment_minimum_healthy_percent = 50

  capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = "FARGATE"
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aws_security_group.app.id]

    # Turn on for testing with public subnets
    # assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "container-1"
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [data.aws_ecs_task_definition.main]
}

resource "aws_ecs_task_definition" "main" {
  family = var.ecs_service_name

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  task_role_arn            = aws_iam_role.allow_to_communicate_with_dynamodb.arn
  execution_role_arn       = data.aws_iam_role.ecs_task_execution.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = var.container_definitions
}

resource "aws_iam_role" "allow_to_communicate_with_dynamodb" {
  name = "allow-to-communicate-with-dynamodb"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [aws_iam_policy.allow_to_communicate_with_dynamodb.arn]
}

resource "aws_iam_policy" "allow_to_communicate_with_dynamodb" {
  name        = "AllowToCommunicateWithDynamodb"
  description = "IAM policy for ECS to communicate with DynamoDB"

  policy = templatefile("${path.module}/allow-to-communicate-with-dynamodb-policy.tpl", {
    dynamodb_table_arn = var.dynamodb_table_arn,
  })
}

resource "aws_security_group" "app" {
  name   = "${var.ecs_cluster_name}-sg-app"
  vpc_id = var.vpc_id
}


