
data "aws_iam_policy_document" "assume_role_policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]

        }
    }
}



resource "aws_iam_role" "RL-ecsTaskExecutionRole" {
    name = "RL-execution-task-role"
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
    tags = {
        Name = "RL-microservices-iam-role"
        #Environment tag?
    }
}

resourcce "aws_iam_role_policy_attachment" "RL-ecsTaskExecutionRolePolicy" {
    role = aws_iam_role.RL-ecsTaskExecutionRole.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}