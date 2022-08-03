variable "profile" {
  type    = string
  default = "admin"
}

variable "region-master" {
  type    = string
  default = "eu-central-1"
}

variable "region-worker" {
  type    = string
  default = "eu-west-2"
}

variable "ami" {
  type        = string
  default     = "ami-0e0102e3ff768559b"
  description = "ubuntu18server, created by terraform"
}

variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "workers-count" {
  type    = number
  default = 2
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}

variable "webserver-port" {
  type    = number
  default = 8888
}