#Create instances
resource "aws_instance" "app_server" {
  ami                         = var.ami_id
  instance_type               = var.instance
  count                       = var.instance_count
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_ids[count.index]]
  associate_public_ip_address = var.public_ips[count.index]
  subnet_id                   = var.subnet_ids[count.index]
  tags = {
    Name = var.instance_names[count.index]
  }
}
