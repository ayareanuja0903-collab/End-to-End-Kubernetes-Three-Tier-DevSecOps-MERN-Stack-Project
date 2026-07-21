###########################################################
# Jenkins EC2 Module
###########################################################

###########################################################
# Ubuntu AMI
###########################################################

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = [
    "099720109477"
  ]

  filter {

    name = "name"

    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]

  }

  filter {

    name = "virtualization-type"

    values = [
      "hvm"
    ]

  }

}


###########################################################
# Dynamic Public IP
###########################################################

data "http" "my_ip" {

  url = "https://checkip.amazonaws.com"

}



###########################################################
# IAM Role
###########################################################

resource "aws_iam_role" "jenkins" {

  name = "${var.project_name}-${var.environment}-jenkins-role"


  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"


        Principal = {

          Service = "ec2.amazonaws.com"

        }


        Action = "sts:AssumeRole"

      }

    ]

  })

}



###########################################################
# IAM Policies
###########################################################

resource "aws_iam_role_policy_attachment" "jenkins_ssm" {

  role = aws_iam_role.jenkins.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}



resource "aws_iam_role_policy_attachment" "jenkins_ecr" {

  role = aws_iam_role.jenkins.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"

}



resource "aws_iam_role_policy_attachment" "jenkins_eks" {

  role = aws_iam_role.jenkins.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}



###########################################################
# Instance Profile
###########################################################

resource "aws_iam_instance_profile" "jenkins" {

  name = "${var.project_name}-${var.environment}-jenkins-profile"

  role = aws_iam_role.jenkins.name

}



###########################################################
# Jenkins Security Group
###########################################################

resource "aws_security_group" "jenkins" {

  name = "${var.project_name}-${var.environment}-jenkins-sg"

  vpc_id = var.vpc_id



  # SSH

  ingress {

    description = "SSH Access"

    from_port = 22

    to_port = 22

    protocol = "tcp"


    cidr_blocks = [

      "${chomp(data.http.my_ip.response_body)}/32"

    ]

  }



  # Jenkins UI

  ingress {

    description = "Jenkins Web UI"

    from_port = 8080

    to_port = 8080

    protocol = "tcp"


    cidr_blocks = [

      "${chomp(data.http.my_ip.response_body)}/32"

    ]

  }



  # SonarQube

  ingress {

    description = "SonarQube"

    from_port = 9000

    to_port = 9000

    protocol = "tcp"


    cidr_blocks = [

      "${chomp(data.http.my_ip.response_body)}/32"

    ]

  }



  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"


    cidr_blocks = [

      "0.0.0.0/0"

    ]

  }



  tags = {

    Name = "${var.project_name}-${var.environment}-jenkins-sg"

  }

}

###########################################################
# Create Jenkins Key Pair Dynamically
###########################################################

resource "tls_private_key" "jenkins" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins" {
  key_name   = "${var.project_name}-${var.environment}-jenkins-key"
  public_key = tls_private_key.jenkins.public_key_openssh
}

resource "local_file" "jenkins_private_key" {
  content  = tls_private_key.jenkins.private_key_pem
  filename = "${path.root}/keys/jenkins-key.pem"
}


###########################################################
# Jenkins EC2 Instance
###########################################################

resource "aws_instance" "jenkins" {


  ami = data.aws_ami.ubuntu.id



  instance_type = var.instance_type



  subnet_id = var.subnet_id



  key_name = aws_key_pair.jenkins.key_name



  iam_instance_profile = aws_iam_instance_profile.jenkins.name



  vpc_security_group_ids = [

    aws_security_group.jenkins.id

  ]



  associate_public_ip_address = true



  root_block_device {

    volume_size = var.volume_size

    volume_type = "gp3"

    delete_on_termination = true

  }



  user_data = file("${path.module}/user-data.sh")



  tags = {

    Name = "${var.project_name}-${var.environment}-jenkins"

  }


}