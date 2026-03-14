resource "aws_security_group" "sg-remotestate" {
  name        = "remote-state-sg"
  description = "Security group for testing remote state access"
}




resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.sg-remotestate.id
  /* Feature: Remote State Data Source for Whitelisted IP */
  cidr_ipv4 = "${data.terraform_remote_state.eip.outputs.eip_address}/32"
  from_port = 443
  to_port   = 443
  ip_protocol  = "tcp"
}
