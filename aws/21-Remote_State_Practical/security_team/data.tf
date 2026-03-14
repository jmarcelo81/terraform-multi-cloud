data "terraform_remote_state" "eip" {
  backend = "s3"
  config = {
    bucket = "jmarcelo-temp-bucket-tf.remote-state"
    key    = "eip.tfstate"
    region = "us-east-2"
  }
}