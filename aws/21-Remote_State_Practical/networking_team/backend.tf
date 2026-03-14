terraform {
  backend "s3" {
    bucket = "jmarcelo-temp-bucket-tf.remote-state"
    key    = "eip.tfstate"
    region = "us-east-2"
  }
}