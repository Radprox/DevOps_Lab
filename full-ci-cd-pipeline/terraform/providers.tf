provider "aws" {
  profile = "admin"
  region  = var.region-master
  alias   = "region-master"
}
provider "aws" {
  profile = "admin"
  region  = var.region-worker
  alias   = "region-worker"
}