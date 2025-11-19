resource "aws_subnet" "this" {
  count             = length(var.subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.name}-${count.index}"
  }
}

