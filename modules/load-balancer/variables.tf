variable "vpc_id" {
  type = string

}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)

}

variable "status_instance_id" {
  type = string
}

variable "lights_instance_id" {
  type = string

}
variable "heating_instance_id" {
  type = string
}
