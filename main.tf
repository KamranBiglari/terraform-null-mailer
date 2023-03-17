data "template_file" "body" {
  template = "${var.body}"
  vars = "${var.vars}"
}

data "template_file" "subject" {
  template = "${var.subject}"
  vars = "${var.vars}"
}

resource "random_uuid" "body_file" {}

locals {
  body    = "${data.template_file.body.rendered}"
  body_file = random_uuid.body_file.result
  subject = "${data.template_file.subject.rendered}"
  command = "${var.mail_command} -s \"${local.subject}\" -F ${path.module}/.muttrc ${join(" ",[for a in toset(var.attachments): "-a ${a}"])} -i ${path.module}/body/${local.body_file} -- ${join(",",var.to)} "
}

resource "local_file" "default" {
  content  = <<EOT
set from = "${var.from}"
set smtp_url = "${var.smtp_url}"
set smtp_pass = "${var.password}"
EOT
  filename = "${path.module}/.muttrc"
}

resource "local_file" "body" {
  content  = local.body
  filename = "${path.module}/body/${local.body_file}"
}

resource "null_resource" "install" {
  count = "${var.mail_install == "true" ? 1 : 0}"
  provisioner "local-exec" {
    command = "sudo apt install ${var.mail_command} -y"
    interpreter = ["bash", "-c"]
  }
  triggers = {
    always = timestamp()
  }
}
resource "null_resource" "default" {
  count = "${var.enabled == "true" ? 1 : 0}"

  triggers = {
    subject = "${local.subject}"
    body    = "${local.body}"
    to      = join(",",var.to)
    command = "${local.command}"
  }

  provisioner "local-exec" {
    command = "${local.command}"
    interpreter = ["bash", "-c"]
  }

  depends_on = [
    data.template_file.body, 
    data.template_file.subject,
    local_file.body,
    local_file.default,
    null_resource.install
  ]
}