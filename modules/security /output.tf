output "security_group_id" {
  value = aws_security_group.app_server.id
}

output "private_security_group_id" {
  value=aws_security_group.private_app.id
}