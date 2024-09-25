resource "aws_instance" "wordpress" {
    ami = var.instance_id
    instance_type = var.instance_type
    # subnet_id = aws_subnet.public_subnet.*.id
    subnet_id = lookup({ for k, v in aws_subnet.public_subnet : v.availability_zone => v.id }, "ap-south-1a")
    security_groups = [aws_security_group.public_webserver_security_group.id]
    associate_public_ip_address = true
    key_name = aws_key_pair.public_key.key_name
    user_data = file("./wordpress.sh")
    tags ={
        Name = "Webserver"
    }
}

resource "aws_instance" "mysql_server" {
    ami = var.instance_id
    instance_type = var.instance_type
    # subnet_id = aws_subnet.public_subnet.*.id 
    subnet_id = lookup({ for k, v in aws_subnet.public_subnet : v.availability_zone => v.id }, "ap-south-1b")
    security_groups = [aws_security_group.public_mysql_security_group.id]
    associate_public_ip_address = true
    key_name = aws_key_pair.public_key.key_name
    user_data = file("./mysql.sh")
    tags ={
        Name = "MySQL_Server"
    }
}

output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
  description = "The public IP address of the WordPress EC2 instance."
}

output "mysql_server_public_ip" {
  value = aws_instance.mysql_server.public_ip
  description = "The public IP address of the MySQL EC2 instance."
}