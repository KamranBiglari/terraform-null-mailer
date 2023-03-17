variable "enabled" {
  description = "Flag to enable or disable the sending of emails"
  default     = "true"
}

variable "from" {
  description = "From address for email"
}

variable "to" {
  description = "Email recipients"
  type        = list
}

variable "subject" {
  description = "Email subject template"
}

variable "body" {
  description = "Email body template"
}

variable "password" {
  description = "Password to authenticate with the SMTP server"
  type        = string
}

variable "smtp_url" {
  description = "SMTP URL"
  default     = "smtp://USERNAME@smtp.office365.com:587/"
}

variable "vars" {
  description = "Parameters to pass to the body template"
  default     = {}
}

variable "attachments" {
  description = "Attachments"
  type = list
  default = []
}

variable "fqdn" {
  description = "FQDN"
  type = string
  default = ""
}

# We recommend the following tool:
# mutt
variable "mail_command" {
  description = "Command to execute"
  default     = "mutt"
}

variable "mail_install" {
  description = "Install the command"
  default     = "false"
}