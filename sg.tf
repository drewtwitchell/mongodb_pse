# add the below resources in the sg.tf file to create a new security group

resource "aws_security_group" "terrafrom_sg" {
  name        = "allow_ssh_mongo"
  description = "sg for to allow ssh and mongo"
  vpc_id      = aws_vpc.pse_mongo_vpc.id

  tags = {
    Name = "Terraform_project_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.terrafrom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_27017" {
  security_group_id = aws_security_group.terrafrom_sg.id
  cidr_ipv4         = "34.203.25.121/32"
  from_port         = 27017
  ip_protocol       = "tcp"
  to_port           = 27017
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terrafrom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
