variable "ami_id" {
  type    = string
  default = "ami-0505148b3591e4c07"
}

variable "instance" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "security_group_ids" {
  type = list(string)
}

variable "key_name" {
  type    = string
  default = "aws key"
}

variable "subnet_ids" {
  type = list(string)

}

variable "instance_names" {
  type = list(string)

}
variable "public_ips" {
  type = list(bool)
}


