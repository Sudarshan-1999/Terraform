resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
  lifecycle {
    create_before_destroy = true
    ignore_changes = [route_table_id]
  }
}