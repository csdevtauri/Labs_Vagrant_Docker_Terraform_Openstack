variable "public_key" {
  description = "Public SSH key for keypair"
  type        = string
}

variable "image_id" {
  description = "The ID of the image to use for the server"
  type        = string
}

variable "flavor_name" {
  description = "The name of the flavor to use for the server"
  type        = string
}

variable "network_name" {
  description = "The name of the network to attach the server to"
  type        = string
}
 