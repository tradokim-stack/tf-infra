output "instance_id" {
  value = aws_instance.public_app.id
}

output "public_ip" {
  value = aws_instance.public_app.public_ip
}

output "public_dns" {
  value = aws_instance.public_app.public_dns
}

output "eip_public_dns" {
  value = aws_eip.public_app.public_dns
}

output "private_ip" {
  value = aws_instance.public_app.private_ip
}