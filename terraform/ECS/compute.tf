provider "aws" {
	#credentials provided by environment. Below is an example environment configuration.
	# access_key = $AWS_ACCESS_KEY
	# secret_key = $AWS_SECRET_KEY
	# region	 = $AWS_REGION

	access_key = var.aws_access_key
	secret_key = var.aws_secret_key
	region = var.aws_region
}


backend "s3" {

	bucket = "rl-terraform-s3"
	key = "terraform/terraform.tfstate"
	region = var.aws_region

}

#Create ECS cluster.

resource "aws_ecs_cluster" "RL-ECS-Cluster" {
    name = "RL-ECS-Cluster"
    tags = {
        Name = "RL-ECS-Cluster"
        #Environment tag?
    }
}

#Create Log group on CloudWatch to be able to get container's logs.
resource "aws_cloudwatch_log_group" "RL-log-group" {
    name = "RL-logs"
    tags = {
        Application = "Aline-Financial" #Maybe change later?
    }
}


# #Launch
# #Make Task Definitions for each microservice.

# resource "aws_ecs_task_definition" "RL-task-definition-user"{
#     family = "user"
#     container_definitions = 
#     network_mode = "bridge"
# }

# resource "aws_ecs_task_definition" "RL-task-definition-transaction"{
#     family = "transaction"
#     container_definitions = 
#     network_mode = "bridge"
# }

# resource "aws_ecs_task_definition" "RL-task-definition-underwriter"{
#     family = "underwriter"
#     container_definitions = 
#     network_mode = "bridge"
# }

# resource "aws_ecs_task_definition" "RL-task-definition-bank"{
#     family = "bank"
#     container_definitions = 
#     network_mode = "bridge"
# }

# resource "aws_ecs_task_definition" "RL-task-definition-gateway"{
#     family = "gateway"
#     container_definitions = 
#     network_mode = "bridge"
# }

# #Make Services for each microservice.

# resource "aws_ecs_service" "RL-user-service" {
#     name = "RL-user-service"
#     cluster = aws_ecs_cluster.RL-ECS-Cluster.id
#     task_definition = aws_ecs_task_definition.RL-task-definition-user.arn
#     desired_count = 1

# }

# resource "aws_ecs_service" "RL-transaction-service" {
#     name = "RL-user-service"
#     cluster = aws_ecs_cluster.RL-ECS-Cluster.id
#     task_definition = aws_ecs_task_definition.RL-task-definition-transaction.arn
#     desired_count = 1
    
# }

# resource "aws_ecs_service" "RL-underwriter-service" {
#     name = "RL-user-service"
#     cluster = aws_ecs_cluster.RL-ECS-Cluster.id
#     task_definition = aws_ecs_task_definition.RL-task-definition-underwriter.arn
#     desired_count = 1
    
# }

# resource "aws_ecs_service" "RL-bank-service" {
#     name = "RL-user-service"
#     cluster = aws_ecs_cluster.RL-ECS-Cluster.id
#     task_definition = aws_ecs_task_definition.RL-task-definition-bank.arn
#     desired_count = 1
    
# }

# resource "aws_ecs_service" "RL-gateway-service" {
#     name = "RL-user-service"
#     cluster = aws_ecs_cluster.RL-ECS-Cluster.id
#     task_definition = aws_ecs_task_definition.RL-task-definition-gateway.arn
#     desired_count = 1
    
# }