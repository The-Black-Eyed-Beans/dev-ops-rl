resource "aws_lb" "RL-alb" {
    name = "RL-alb"
    load_balancer_type = "application"
    internal = false
    subnets = var.public_subnets
}

resource "aws_security_group" "RL-alb-sg" {
    name = "RL-alb-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {

        "Name" = "RL-alb-sg"

    }

}

resource "aws_lb_target_group" "RL-lb-target-group" {
    name = "RL-target-group"
    port = [8070,8071,8072,8083]
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = aws_vpc.main_vpc.id

    health_check {
        path = "/health"
        healthy_threshold = 2
        unhealthy_threshold = 10
        timeout = 60
        interval = 300
        matcher = "200,301,302"
    }

}

resource "aws_lb_listener" "RL-listener" {
    load_balancer_arn = aws_lb.RL-alb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.RL-lb-target-group.arn
    }
}