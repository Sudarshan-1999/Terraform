variable "region" {
    default = "ap-south-1"
    description = "AWS Regions"  
}

variable "instance_id" {
    default = "ami-0838bc34dd3bae25e"
    description = "Ami Id "
}

variable "instance_type" {
    default = "t2.micro"
    description = "instance type "
}
variable "list" {
    default = [1, 2, 3, 4]
    type = list(number)
    description = "Number list"  
}

variable "public_subnets" {
    default = [
        {cidr_block = "10.0.1.0/24", az ="ap-south-1a"},
        {cidr_block = "10.0.2.0/24", az ="ap-south-1b"},
        {cidr_block = "10.0.3.0/24", az ="ap-south-1c"}
        ]
    type = list(object({
      cidr_block = string
      az = string
    }))
}

variable "private_subnets" {
    default = [
        {cidr_block = "10.0.4.0/24", az ="ap-south-1a"},
        {cidr_block = "10.0.5.0/24", az ="ap-south-1b"},
        {cidr_block = "10.0.6.0/24", az ="ap-south-1c"}
        ]
    type = list(object({
      cidr_block = string
      az = string
    }))
}
