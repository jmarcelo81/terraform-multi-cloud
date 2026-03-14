provider "aws" {
    region = "us-east-2"
}

import {
    to = aws_security_group.myimportedsg
    id = "sg-07af3a687dffd80eb"
}