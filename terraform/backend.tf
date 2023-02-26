terraform {
  backend "gcs" {
    bucket = "81cdf193695b1dfb-bucket-tfstate"
    prefix = "terraform/state"
  }
}
