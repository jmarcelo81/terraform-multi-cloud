

resource "aws_eip" "lb_eip" {
  domain = "vpc"

}

output "eip_address" {
  value = aws_eip.lb_eip.public_ip
}
