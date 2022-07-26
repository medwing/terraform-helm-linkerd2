variable "external_trustanchor" {
  description = "enable the externally supplied trustanchor creation, implies setting trustanchor_* variables!"
  default     = false
}

variable "trustanchor_key" {
  description = "external trustanchor key"
  default     = false
}

variable "trustanchor_cert" {
  description = "external trustanchor cert"
  default     = false
}