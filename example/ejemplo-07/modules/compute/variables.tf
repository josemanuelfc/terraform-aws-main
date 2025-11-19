
variable "ami" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "sg_ids" {
  type = list(string)
}
variable "key_name" {}
variable "name" {}
variable "user_data" {
  default = null
}
