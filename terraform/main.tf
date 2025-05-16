# Specifiy the intended provider aws,azure,gcp...
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  # Configure the backend to use S3
  backend "s3" {
    key = "aws/ec2-deploy/terraform.tfstate"  # Path within the bucket to store the state file
  }
}
# Specify the required region
provider "aws" {
  region = var.region  # Change to your desired region
}
# Create an EC2 instance
resource "aws_instance" "server" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
  # Ssh connection block
  connection {
    type        = "ssh"
    user        = "ubuntu"  # Change based on the AMI (e.g., "ubuntu" for Ubuntu AMIs)
    private_key = var.private_key  # Path to your private key file
    host        = self.public_ip  # Use the public IP of the instance
    timeout     = "4m"
  }
  tags = {
    Name = "DeployVM"
  }
}
# IAM role
resource "aws_iam_instance_profile" "ec2-profile"{
  name = "ec2-profile"
  role = "ec2-ecr-auth"
}
# Create a security group
resource "aws_security_group" "my_sg" {
  #vpc_id = aws_vpc.my_vpc.id

  ingress {
    description = ""
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (not recommended for production)
  }

  egress {
    description = ""
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_sg"
  }
}

# Add key pair
resource "aws_key_pair" "deployer" {
    key_name = var.key_name
    public_key = var.public_key
}

output "instance_public_ip" {
  value = aws_instance.server.public_ip
  sensitive = true
}