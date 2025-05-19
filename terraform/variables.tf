# Define variables
variable "region" {
    default = "us-east-1"
}

# Add your key 
# variable "public_key" {

# }


# variable "private_key" {

# }


# variable "key_name" {


# }

# Assuming your keys are stored in the following paths
locals {
    #public_key  = file("~/.ssh/id_rsa.pub")  # Path to your public key
    public_key  = file("/Users/chandrawip-off/keyforawsdev.pub")  # Path to your public key
    # private_key = file("~/.ssh/id_rsa")      # Path to your private key
    private_key = file("/Users/chandrawip-off/keyforawsdev")      # Path to your private key
}
