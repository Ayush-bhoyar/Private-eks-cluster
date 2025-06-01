output "private_subnet_ids" {
  value = aws_subnet.Private[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.Public[*].id
}
