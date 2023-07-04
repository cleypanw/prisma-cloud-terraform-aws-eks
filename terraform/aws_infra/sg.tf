#########
# Security group configuration

resource "aws_security_group" "ec2-bastion" {

  description   = "SG for ec2-bastion"
  name          = local.sg_name
  vpc_id        = module.vpc.vpc_id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}