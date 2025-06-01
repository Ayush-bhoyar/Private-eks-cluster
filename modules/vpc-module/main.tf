resource "aws_vpc" "Main" {
  cidr_block = var.cidr_range
  enable_dns_hostnames= true
  enable_dns_support=true

  tags={
    Name= "EKS-PRIVATE-VPC"
  }

}

data "aws_availability_zones" "available" {}


resource "aws_subnet" "Private" {
  count = var.private_subnet_count
  vpc_id = aws_vpc.Main.id
  cidr_block = cidrsubnet(aws_vpc.Main.cidr_block, 4, count.index)
  map_public_ip_on_launch = false
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))


tags = {
  Name= "EKS-private-subnet-${count.index+1}"
  "kubernetes.io/role/internal-elb" = "1"
  "kubernetes.io/cluster/${var.cluster_name}" = "shared"

}


}

resource "aws_subnet" "Public" {
  vpc_id = aws_vpc.Main.id
  count = var.public_subnet_count
  cidr_block = cidrsubnet(aws_vpc.Main.cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))

  tags = {
    Name= "EKS-Public-subnet-${count.index+1}"
  }

}

resource "aws_internet_gateway" "EKS-IG" {
  vpc_id = aws_vpc.Main.id
}

resource "aws_eip" "nat" {
  count = var.public_subnet_count
  depends_on = [aws_internet_gateway.EKS-IG]
}

resource "aws_nat_gateway" "EKS-NAT" {
  count         = var.public_subnet_count
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.Public[count.index].id
   depends_on = [aws_internet_gateway.EKS-IG]

}

resource "aws_route_table" "Public-RT" {
  count = var.public_subnet_count
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EKS-IG.id
  }

  tags = {
    Name= "Public-RT-${count.index +1}"
  }
}

resource "aws_route_table" "Private-RT" {
  count  = var.private_subnet_count
  vpc_id= aws_vpc.Main.id
   route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.EKS-NAT[count.index % var.public_subnet_count].id
  }

tags = {
  Name = "Private-RT-${count.index + 1}"
}

}

resource "aws_route_table_association" "Private-RTA" {
  count = var.private_subnet_count
  subnet_id =aws_subnet.Private[count.index].id
  route_table_id = aws_route_table.Private-RT[count.index].id
}

resource "aws_route_table_association" "Public-RTA" {
  count = var.public_subnet_count
  route_table_id = aws_route_table.Public-RT[count.index].id
  subnet_id = aws_subnet.Public[count.index].id
}







