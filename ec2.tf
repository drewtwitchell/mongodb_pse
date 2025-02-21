# add the below resource in the ec2.tf file to launch an ec2 instance

resource "aws_instance" "terraform-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  key_name               = var.PUB_KEY
  vpc_security_group_ids = [aws_security_group.terrafrom_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install gnupg curl
              curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
              gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
              --dearmor
              echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
              apt-get update
              apt-get install -y mongodb-org
              systemctl start mongod
              systemctl enable mongodb
              EOF
  tags = {
    Name = "TASKY_PSE"
  }
}

resource "aws_s3_bucket" "pse_bucket" {
  bucket  = "pse-bucket"
  region  = var.REGION
  tags    = {
	Name          = "pse-bucket"
	Environment    = "Production"
  }
}

output "PublicIP" {
  value = aws_instance.terraform-instance.public_ip
}