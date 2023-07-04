#########
# EC2 configuration

resource "aws_key_pair" "ssh_key" {
  key_name   = local.sshkey_name
  public_key = "${var.public_ssh_key}"
}

resource "aws_instance" "ec2instance" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  subnet_id              = module.vpc.public_subnets[0]
  private_ip             = "10.0.4.10"
  vpc_security_group_ids = ["${aws_security_group.ec2-bastion.id}"]

  #checkov:skip=CKV_AWS_88
  associate_public_ip_address = true

  key_name = "${aws_key_pair.ssh_key.key_name}"

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
    encrypted             = true
  }
  provisioner "local-exec" {
    command = <<EOF
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl 
sudo mv kubectl /usr/local/bin/kubectl
chmod 0755 /usr/local/bin/kubectl
sudo apt-get -y install awscli
# Do some kind of JSON processing with ./jq
EOF
  }

  # https://docs.bridgecrew.io/docs/bc_aws_general_31
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  depends_on = [
    aws_key_pair.ssh_key
  ]

  tags = {
    Name  = local.ec2_bastion_name
  }
}