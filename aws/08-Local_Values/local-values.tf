provider "aws"{
    region = "us-east-2"
    profile = "lab-sso"
}

variable old_tags {
    type = map
    default = {
       Team = "Security-team"
    }
}

locals {
    default = {
        Team = "New-Security-Team"
        CreatonDate = "date-${formatdate("DDMMYY",timestamp())}"
    }
}


resource "aws_security_group" "sg_01" {
  name = "app_firewall"
  tags = local.default 
}

resource "aws_security_group" "sg_02" {
  name = "db_firewall"
  tags = local.default
}
