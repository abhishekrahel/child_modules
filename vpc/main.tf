resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr

    tags = {
      Name = "${var.environment[0]}-vpc"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true
    count = 2 
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = var.azs[count.index]
    count = 2
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "public_asso" {
    count = 2
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route" "name" {
    destination_cidr_block = "0.0.0.0/0"
    route_table_id = aws_route_table.public.id
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
  
}

resource "aws_route_table_association" "priv_asso" {
    route_table_id = aws_route_table.private.id
    count = 2
    subnet_id = aws_subnet.private[count.index].id
  
}

resource "aws_route" "private_net" {
    route_table_id = aws_route_table.private.id
    destination_cidr_block =  "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id

}

resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}

