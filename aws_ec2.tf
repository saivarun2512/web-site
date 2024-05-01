resource "aws_instance" "website" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.tf_ec2_key.key_name
  subnet_id              = aws_subnet.public_subnets.id
  iam_instance_profile   = aws_iam_instance_profile.test_profile.name
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = "true"
  user_data              = <<EOF
#!/bin/bash
sudo echo "Hello, World!" > hello.txt
sudo echo "Hi varun" >/var/www/html/index.nginx-debian.html
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
sudo echo “Hello CloudChamp from $(hostname -f).Created by USERDATA in Terraform. SUBSCRIBE NOW!!” > /var/www/html/index.html
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo yum install python3-pip -y
sudo pip3 install --user docker-compose
sudo echo "Hi varun2" >> /var/www/html/index.nginx-debian.html
sudo echo "Hello, World2!" >> hello.txt

EOF
}

resource "tls_private_key" "tf_ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf_ec2_key" {
  content  = tls_private_key.tf_ec2_key.private_key_pem
  filename = "~/Downloads/tf_ec2_key.pem"
}

resource "aws_key_pair" "tf_ec2_key" {
  key_name   = "tf_ec2_key"
  public_key = tls_private_key.tf_ec2_key.public_key_openssh
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}

data "template_file" "user_data" {
  template = "${file("../scripts/install_dependencies.sh")}" 
}
