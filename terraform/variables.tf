# Define variables
variable "region" {
    default = "us-east-1"
}

# Add your key 
variable "public_key" {
  description = "The public key for SSH access"
  type        = string
}

}

variable "private_key" {
  description = "The private key for SSH access"
  type        = string
}

}

variable "key_name" {

}