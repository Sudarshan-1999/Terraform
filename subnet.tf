resource "aws_subnet" "public_subnet" {
    for_each = { for idx, subnet in var.public_subnets : idx => subnet}
    vpc_id = aws_vpc.cloudthat_vpc.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az
    map_public_ip_on_launch =  true
    tags = {
        Name = "Public Subnet ${each.value.az}"
    }
}

resource "aws_subnet" "private_subnet" {
    for_each = { for idx, subnet in var.private_subnets : idx => subnet}
    vpc_id = aws_vpc.cloudthat_vpc.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az
    map_public_ip_on_launch = false
    tags ={
        Name = "Private Subnet ${each.value.az}"
    }
}
