resource "aws_subnet" "this" {
  count             = length(var.subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true   # ← ESTO HACE LA SUBNET PÚBLICA


  tags = {
    Name = "${var.name}-${count.index}"
  }
}
resource "aws_route_table_association" "public" {
  count          = length(var.subnet_cidrs)
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = var.public_route_table_id
}
