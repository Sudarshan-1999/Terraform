resource "aws_security_group" "public_webserver_security_group" {
  name="public_webserver_security_group"
  description  = "Allow Inbound and outbound rules to ec2 instance on public"
  vpc_id  = aws_vpc.cloudthat_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public_webserver_security_group"
  }
}

resource "aws_security_group" "public_mysql_security_group" {
  name="public_mysql_security_group"
  description  = "Allow Inbound and outbound rules to ec2 instance on public"
  vpc_id  = aws_vpc.cloudthat_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public_mysql_security_group"
  }
}