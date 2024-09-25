resource "aws_route_table" "public" {
    vpc_id = aws_vpc.cloudthat_vpc.id
    tags = {
        Name = "Public Route Table"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.cloudthat_vpc.id
    tags = {
        "Name" = "Private Route Table"
    }
}


resource "aws_route_table_association" "public_subnet_assoc" {
    for_each = aws_subnet.public_subnet
    subnet_id = each.value.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
      for_each = aws_subnet.private_subnet
      subnet_id = each.value.id
      route_table_id = aws_route_table.private.id
}
