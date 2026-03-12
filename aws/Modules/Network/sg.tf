
resource "aws_security_group" "dev" {
  name        = "dev-sg"
  description = "Security group for dev team"

}

resource "aws_security_group" "prod" {
  name        = "prod-sg"
  description = "Security group for prod team"

}
