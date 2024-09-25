resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.cloudthat_vpc.id  
    tags = {
        Name = "My-IGW"
    }
}