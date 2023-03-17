
Terraform module to send emails using SMTP server by calling an external `mutt` command.

## Dependencies
First install the `mutt` cli tool:

```
sudo apt install mutt
```

## Usage

```
module "terraform-null-mailer" {
  source  = "KamranBiglari/mailer/null"
  version = "1.0.0"
  smtp_url   = "smtp://example@hotmail.com@smtp.office365.com:587/"
  password   = "password"
  from       = "example@hotmail.com"
  to         = ["example1@hotmail.com","example2@gmail.com"]
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
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.body](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.default](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.default](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_uuid.body_file](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [template_file.body](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.subject](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attachments"></a> [attachments](#input\_attachments) | Attachments | `list` | `[]` | no |
| <a name="input_body"></a> [body](#input\_body) | Email body template | `any` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Flag to enable or disable the sending of emails | `string` | `"true"` | no |
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | FQDN | `string` | `""` | no |
| <a name="input_from"></a> [from](#input\_from) | From address for email | `any` | n/a | yes |
| <a name="input_mail_command"></a> [mail\_command](#input\_mail\_command) | Command to execute | `string` | `"mutt"` | no |
| <a name="input_password"></a> [password](#input\_password) | Password to authenticate with the SMTP server | `string` | n/a | yes |
| <a name="input_smtp_url"></a> [smtp\_url](#input\_smtp\_url) | SMTP URL | `string` | `"smtp://USERNAME@smtp.office365.com:587/"` | no |
| <a name="input_subject"></a> [subject](#input\_subject) | Email subject template | `any` | n/a | yes |
| <a name="input_to"></a> [to](#input\_to) | Email recipients | `list` | n/a | yes |
| <a name="input_vars"></a> [vars](#input\_vars) | Parameters to pass to the body template | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_body"></a> [body](#output\_body) | Rendered body of the email |
| <a name="output_subject"></a> [subject](#output\_subject) | Rendered subject of the email |
<!-- END_TF_DOCS -->