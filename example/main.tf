module "terraform-null-mailer" {
  source     = "../"
  smtp_url   = "smtp://example@hotmail.com@smtp.office365.com:587/"
  password   = "password"
  from       = "example@hotmail.com"
  to         = ["example1@hotmail.com","example2@hotmail.com"]
  subject    = "Hello $${user}"
  body       = <<EOT

    Your username has been created.
    Link: $${link}

EOT

  attachments = ["./file.txt"]
  vars = {
    user = "John Doe"
    link   = "https://example.com"
  }
}