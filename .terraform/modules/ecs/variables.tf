variable "vpc_id" { }
variable "public_subnet_ids" {
  default = []
}

variable "private_subnet_ids" {
  default = []
}
variable "project_name" { }
#variable "key_pair_name" { }
variable "ecs_cluster" { }


variable "region" {
  default = "us-east-1"
}

variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1"
  }
}

variable "name" {
  default = "tbc"
}


#variable "domain_name" {

#}

variable "env" { }

variable "group" {
 default = "prod"
}

variable "az-1" {
  default = "1"
}

variable "az-2" {
  default = "2"
}



