resource "aws_iam_openid_connect_provider" "main" {
  url             = "https://token.actions.githubusercontent.com"
  thumbprint_list = ["1b511abead59c6ce207077c0bf0e0043b1382612"]
  client_id_list = [
    "sts.amazonaws.com",
  ]
}

