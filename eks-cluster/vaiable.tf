variable "cidr_block"{
    type= string
}

variable "public_subnets"{
    type=list(string)
}

variable "private_subnets"{
   type=list(string)
}
/*variable "ami_id"{
    type =string
}
variable "instance_type"{
    type=string
}*/
